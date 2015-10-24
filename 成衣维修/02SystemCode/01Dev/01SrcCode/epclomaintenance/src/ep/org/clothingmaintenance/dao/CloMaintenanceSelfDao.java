package ep.org.clothingmaintenance.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.form.EidtMaintenanceBilSelflForm;
import ep.org.clothingmaintenance.form.EidtMaintenanceBillForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListSelfForm;
import ep.org.clothingmaintenance.util.DBUtil;
import ep.org.clothingmaintenance.util.DateUtil;
import ep.org.clothingmaintenance.util.PropertiesUtil;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午05:08:03
 */

public class CloMaintenanceSelfDao {
	
	public static String genarateDH(String shopID,UserInfo userInfo) throws Exception {
		Connection conn = null;
		CallableStatement callSta = null;
		ResultSet rs = null;
		String dh = null;
		try {
			conn = DBUtil.getConnection();
			String exeSql = "{call GenerateCYWXDJBDH_D(?,?)}";
			callSta = conn.prepareCall(exeSql);
			callSta.setString(1, shopID);
			callSta.setString(2, userInfo.getCom());

			// callSta.registerOutParameter(2, java.sql.Types.CHAR);
			// callSta.registerOutParameter(3, java.sql.Types.CHAR);

			rs = callSta.executeQuery();
			if (rs.next()) {
				dh = rs.getString(1);
			}

		} finally {

			if (rs != null) {
				rs.close();
			}

			if (callSta != null) {
				callSta.close();
			}

			if (conn != null) {
				conn.close();
			}

		}

		return dh;

	}
	
	public List queryList(MaintenanceInfoListSelfForm form,UserInfo userInfo) throws Exception {
		StringBuffer sqlBuffer = new StringBuffer();
		StringBuffer conditionBuffer = new StringBuffer();
		sqlBuffer
				.append("select b.GUID ,b.DH  ,b.DPBM,b.DPMC ,b.KH ,b.zt ZTCODE,case b.zt when '21' then '任务接受' when '22' then '完成' else '登记' end  ZT ,b.DJSJ ,b.THRQ ,b.GKXM ,b.VIPKH ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '紧急程度' and A.FCODE=b.JJCD) JJCD ");
		sqlBuffer
				.append(",b.WXBW , b.PJPDSJ ,b.ZBFH_BZRQ,b.YJWCSJ,b.SJWCSJ,b.WXDW"
						+ " ,b.WXSJ  from CYWXDJBSHOP b ");

		int condition = 1;
		if (form.getDh() != null && !"".equals(form.getDh())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.DH like '%" + form.getDh() + "%'");
			condition++;
		}

		if (form.getGKXM() != null && !"".equals(form.getGKXM())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" (b.GKXM like '%" + form.getGKXM()
					+ "%' or b.VIPKH like '%" + form.getGKXM() + "%')");
			condition++;
		}

		if (form.getLoginDeptID() != null && !"".equals(form.getLoginDeptID())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.dpbm like '%" + form.getLoginDeptID()
					+ "%'");
			condition++;
		}

		/*if (form.getYDH() != null && !"".equals(form.getYDH())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.ydh like '%" + form.getYDH() + "%'");
			condition++;
		}*/

		if (form.getKH() != null && !"".equals(form.getKH())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.kh like '%" + form.getKH() + "%'");
			condition++;
		}

		if (form.getZT() != null && !"".equals(form.getZT())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.zt='" + form.getZT() + "'");
			condition++;
		}

		/*if (form.getDplx() != null && !"".equals(form.getDplx())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.DPLX='" + form.getDplx() + "'");
			condition++;
		}*/

		if (form.getBgnQueryDate() != null
				&& !"".equals(form.getBgnQueryDate())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.djsj>CONVERT(DATETIME,'"
					+ form.getBgnQueryDate() + "')");
			condition++;
		}

		if (form.getEndQueryDate() != null
				&& !"".equals(form.getEndQueryDate())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.djsj<CONVERT(DATETIME,'"
					+ form.getEndQueryDate() + " 23:59:59')");
			condition++;
		}

		if ("0".equals(form.getCzlx())) {
			
			if (form.getOperateBgnDate() != null
					&& !"".equals(form.getOperateBgnDate())) {
				if (condition > 0) {
					conditionBuffer.append(" and ");
				}
				conditionBuffer.append(" b.djsj>CONVERT(DATETIME,'"
						+ form.getOperateBgnDate() + "')");
				condition++;
			}

			if (form.getOperateEndDate() != null
					&& !"".equals(form.getOperateEndDate())) {
				if (condition > 0) {
					conditionBuffer.append(" and ");
				}
				conditionBuffer.append(" b.djsj<CONVERT(DATETIME,'"
						+ form.getOperateEndDate() + " 23:59:59')");
				condition++;
			}
			
		} else {

			if (condition > 0) {
				conditionBuffer.append(" and ");
			}

			conditionBuffer
					.append(" exists (select 1 from CYWXDJCZBSHOP c where c.zbguid=b.guid ");
			if (form.getCzlx() != null && !"".equals(form.getCzlx())) {
				conditionBuffer.append(" and c.czlx='" + form.getCzlx() + "'");
			}

			condition++;

			if (form.getOperateBgnDate() != null
					&& !"".equals(form.getOperateBgnDate())) {
				conditionBuffer.append(" and c.czsj>CONVERT(DATETIME,'"
						+ form.getOperateBgnDate() + "')");
			}

			if (form.getOperateEndDate() != null
					&& !"".equals(form.getOperateEndDate())) {
				conditionBuffer.append(" and c.czsj<CONVERT(DATETIME,'"
						+ form.getOperateEndDate() + " 23:59:59')");
			}

			conditionBuffer.append(")");

		}
		

		sqlBuffer.append(" where b.DJZT<>'2' and branch='"+userInfo.getCom()+"' ");
		
		String sql = sqlBuffer.append(conditionBuffer).append(
				" order by b.djsj desc").toString();

		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List cloMaintenanceList = new ArrayList();
		try {
			conn = DBUtil.getConnection();

			st = conn.createStatement();
			rs = st.executeQuery(sql);
			cloMaintenanceList = DBUtil.convertResultToMapList(rs);

		} finally {

			if (rs != null) {
				rs.close();
			}

			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

		return cloMaintenanceList;
	}

	public Object viewMaintenanceBillInfo(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill();
		try {
			 
			String sql = "select a.guid,a.dpdq,a.pp,a.ys,a.zt,a.ms,a.dh,a.dpbm,a.dpmc,dplx dplxcode,case a.dplx when '1' then '自营' else '加盟' end as dplx,a.dzxm,a.dzlxdh, "
					+ "sldg  lxdg, a.sldg, a.dglxdh,a.SFTYFFWX,a.sldgxm,"
					+ "a.vipkh,a.gkxm,a.gklxdh,convert(varchar,a.scsj,23) scsj,a.jjcd,"
					+ "a.kh,convert(varchar,a.thrq,23) thrq,a.wtms,a.fhdz,a.bzxx,"
					+ "case a.zt when '21' then '任务接受' when '22' then '完成' else '登记' end ztTypeName,"
					+ "a.thdh,case a.sfsf when '0' then '否' else '是' end sfsf,"
					+ "a.sfje,a.sfnr,convert(varchar,a.wxsj,23) wxsj, djr,"
					+ "convert(varchar,a.djsj,20) djsj,a.WXDW,a.YJWCSJ,a.SJWCSJ,a.FFJE,a.YJWCSJ_DAY  "
					+ "from CYWXDJBSHOP a where  a.guid='" + guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {

				bean.setDh(rs.getString("dh"));
				bean.setDpbm(rs.getString("dpbm"));
				bean.setDpmc(rs.getString("dpmc"));
				bean.setDplx(rs.getString("dplx"));
				bean.setDpTypeCode(rs.getString("dplxcode"));
				bean.setDpTypeName(rs.getString("dplx"));
				bean.setDZXM(rs.getString("dzxm"));
				bean.setDZLXDH(rs.getString("dzlxdh"));
				if (rs.getString("lxdg") == null
						|| rs.getString("lxdg").equals("")) {
					bean.setSLDG(rs.getString("sldg"));
				} else {
					bean.setSLDG(rs.getString("lxdg"));
				}
				bean.setSLDGXM(rs.getString("lxdgxm"));
				bean.setSldgCode(rs.getString("sldg"));
				bean.setDGLXDH(rs.getString("dglxdh"));
				bean.setSFTYFFWX(Integer.toString(rs.getInt("SFTYFFWX")));
				bean.setVIPKH(rs.getString("vipkh"));
				bean.setGKXM(rs.getString("gkxm"));
				bean.setGKLXDH(rs.getString("gklxdh"));
				bean.setSCSJ(rs.getString("scsj"));
				bean.setJJCD(rs.getString("jjcd"));
				bean.setKH(rs.getString("kh"));
				bean.setTHRQ(rs.getString("thrq"));
				bean.setWTMS(rs.getString("wtms"));
				bean.setFHDZ(rs.getString("fhdz"));
				bean.setBZXX(rs.getString("bzxx"));
				bean.setZtTypeName(rs.getString("ztTypeName"));
				bean.setSFSF(rs.getString("sfsf"));
				bean.setDjr(UserDao.getUserName(rs.getString("djr")));
				bean.setDjsj(rs.getString("djsj"));
				bean.setZT(rs.getString("zt"));
				bean.setYS(rs.getString("ys"));
				bean.setMS(rs.getString("ms"));
				bean.setDPDQ(rs.getString("dpdq"));
				bean.setPP(rs.getString("pp"));
				bean.setGuid(rs.getString("guid"));
				bean.setWXDW(rs.getString("WXDW"));
				bean.setYJWCSJ(rs.getString("YJWCSJ_DAY"));
				bean.setSJWCSJ(rs.getString("SJWCSJ"));
				bean.setFFJE(Float.toString( rs.getFloat("FFJE")));
			}

		} finally {
			if (rs != null) {
				rs.close();
			}

			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}

		}
		return bean;
	}

	public int saveBill(EidtMaintenanceBilSelflForm billForm,UserInfo userInfo) throws Exception {
		Connection conn = null;
		PreparedStatement st = null;
		int sucflag = 0;
		String yjwcsj_day = billForm.getYJWCSJ();
		String yjwcsj = DateUtil.getExpectDateFromNow(Integer.parseInt(yjwcsj_day));
		try {
			String sql = "";
			if    (billForm.getIsSaveFlag().endsWith("false")) {
				sql = "insert into cywxdjbshop(ms,dpbm,dpmc,dplx,dzxm,dzlxdh,wxcbm,wxcmc,sldg,dglxdh,"
						+ "sffgkwx,SFTYFFWX,VIPKH,GKXM,GKLXDH,SCSJ,JJCD,KH,THRQ,WTMS,"
						+ "YSGS,YDH,FHDZ,SHDZ,SHR,SHRLXDH,BZXX,Djr,Djsj,DPDQ,pp,zt,ys,WXDW,YJWCSJ,FFJE,yjwcsj_day,dh,guid,DJZT,branch,sldgxm)  values (?,?,?,?,?,?,?,?,?,?"
						+ ",?,?,?,?,?,convert(datetime,?),?,?,convert(datetime,?),?, '"
						+ billForm.getYSGS()
						+ "',?,?,?,?,?,?,?,convert(datetime,?),?,?,'"+billForm.getZT()+"',?,?,?,"+billForm.getFFJE()+",'"+yjwcsj_day+"',?,?,'0','"+userInfo.getCom()+"','"+billForm.getSLDGXM()+"')";
			} else {
				sql = "update cywxdjbshop set ms=?,dpbm=?,dpmc=?,dplx=?,dzxm=?,dzlxdh=?,wxcbm=?,wxcmc=?,sldg=?,dglxdh=?,"
						+ "sffgkwx=?,SFTYFFWX=?,VIPKH=?,GKXM=?,GKLXDH=?,SCSJ=?,JJCD=?,KH=?,THRQ=?,WTMS=?,sldgxm='"+billForm.getSLDGXM()+"',"
						+ "YSGS='"
						+ billForm.getYSGS()
						+ "',YDH=?,FHDZ=?,SHDZ=?,SHR=?,SHRLXDH=?,BZXX=?,Djr=?,Djsj=?,DPDQ=?,pp=?,ys=?,WXDW=?,YJWCSJ=?,FFJE="+billForm.getFFJE()+",yjwcsj_day='"+yjwcsj_day+"',ZT='"+billForm.getZT()+"' where  guid='"
						+ billForm.getGuid() + "'";
			}

			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			st = conn.prepareStatement(sql);
			st.setString(1, billForm.getMS());
			st.setString(2, billForm.getDpbm());
			st.setString(3, billForm.getDpmc());
			st.setString(4, billForm.getDpTypeCode());
			st.setString(5, billForm.getDZXM());
			st.setString(6, billForm.getDZLXDH());
			st.setString(7, billForm.getWXCBM());
			st.setString(8, billForm.getWXCMC());
			st.setString(9, billForm.getSLDG());
			st.setString(10, billForm.getDGLXDH());
			st.setInt(11, 1);
			if(billForm.getSFTYFFWX()==null ||billForm.getSFTYFFWX().equals("") ){
				st.setInt(12,0);
			}else{
				st.setInt(12, Integer.parseInt(billForm.getSFTYFFWX()));
			}
			st.setString(13, billForm.getVIPKH());
			st.setString(14, billForm.getGKXM());
			st.setString(15, billForm.getGKLXDH());
			st.setString(16, billForm.getSCSJ());
			st.setString(17, billForm.getJJCD());
			st.setString(18, billForm.getKH().toUpperCase().trim());
			st.setString(19, billForm.getTHRQ());
			st.setString(20, billForm.getWTMS());
			st.setString(21, billForm.getYDH());
			st.setString(22, billForm.getFHDZ());
			st.setString(23, billForm.getSHDZ());
			st.setString(24, billForm.getSHR());
			st.setString(25, billForm.getSHRLXDH());
			st.setString(26, billForm.getBZXX());
			st.setString(27, billForm.getUserID());
			st.setString(28, billForm.getDjsj());
			st.setString(29, billForm.getDPDQ());
			st.setString(30, billForm.getPP());
			st.setString(31, billForm.getYS());
			st.setString(32, billForm.getWXDW());
			st.setString(33, yjwcsj);
			
			
			if (billForm.getIsSaveFlag().equals("false")) {
				st.setString(34, billForm.getDh());
				st.setString(35, billForm.getGuid());
			}
			sucflag = st.executeUpdate();

			
			 String czbGuid = CloMaintenanceDao.genarateGuid();
				String czbSql = "insert into cywxdjczbshop(guid,zbguid,czy,czsj,czlx,czbm) values(?,?,?, GETDATE(),'"
						+billForm.getZT()+"','DEPOT_"+ userInfo.getLoginDeptID()+"')";
				st = conn.prepareStatement(czbSql);
				st.setString(1, czbGuid);
				st.setString(2, billForm.getGuid());
				st.setString(3, billForm.getUserID()); 
				sucflag = st.executeUpdate();
			

			conn.commit();

		} catch (SQLException e) {
			conn.rollback();
			return 0;
		}

		finally {

			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}

		}
		return sucflag;
	}

	public Object getShopPrintData(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill();
		UserDao ud = new UserDao();
		try { 
			String sql = "select DH,YJWCSJ,PP,DPMC,DPBM,SFFGKWX,DZXM,DZLXDH,GKXM,GKLXDH,VIPKH," 
					+ " sldg lxdg,SLDG,SFTYFFWX,KH,YS,MS,DGLXDH,"
					+ "convert(varchar(10),SCSJ,20) as SCSJ,WTMS,YSGS,YDH,FHDZ,"
					+ "cast(datepart(yyyy,THRQ) as varchar(4)) + '年'+ right('0' + cast(datepart(mm,THRQ) as varchar(2)), 2) + '月'+ right('0' + cast(datepart(dd,THRQ) as varchar(2)), 2) + '日 ' as THRQ "
					+ "from cywxdjbshop where guid='" + guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				bean.setDh(rs.getString("DH"));
				bean.setPP(rs.getString("PP"));
				bean.setDpmc(rs.getString("DPMC"));
				bean.setGKWX(rs.getString("SFFGKWX"));
				bean.setDZXM(rs.getString("DZXM"));
				bean.setDZLXDH(rs.getString("DZLXDH"));
				bean.setGKXM(rs.getString("GKXM"));
				bean.setGKLXDH(rs.getString("GKLXDH"));
				bean.setVIPKH(rs.getString("VIPKH"));
				bean.setDGLXDH(rs.getString("DGLXDH"));
				if (rs.getString("SLDG") == null
						|| "".equals(rs.getString("SLDG"))) {
					bean.setSLDG("");
				} else {
					//获取导购名称
					List<Map> dgs = ud.getEmployeeList(rs.getString("DPBM")); 
					for(int i=0; i<dgs.size(); i++){
						if(rs.getString("SLDG").equals((String)dgs.get(i).get("EMPLOYEEID"))){
							bean.setSLDG((String)dgs.get(i).get("NAMES"));
							break;
						} 
					}
				} 

				bean.setSFTYFFWX(rs.getString("SFTYFFWX"));
				bean.setKH(rs.getString("KH"));
				bean.setYS(rs.getString("YS"));
				bean.setMS(rs.getString("MS"));
				bean.setSCSJ(rs.getString("SCSJ"));
				bean.setWTMS(rs.getString("WTMS"));
				bean.setFHDZ(rs.getString("FHDZ"));
				bean.setTHRQ(rs.getString("THRQ"));
				bean.setYJWCSJ(rs.getString("YJWCSJ"));
			}

		} finally {

			if (rs != null) {
				rs.close();
			}

			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}

		}
		return bean;
	}

	public int completeBill(EidtMaintenanceBilSelflForm billForm, String loginDeptID) throws Exception {
		Connection conn = null;
		Statement st = null;
		PreparedStatement pst = null;
		int sucflag = 0;
		try{
			String sql = "update cywxdjbshop set SJWCSJSYS=getdate(),SJWCSJ='"+billForm.getSJWCSJ()+"',ZT='22',FFJE="+billForm.getFFJE()+" WHERE zt='21' and guid='"+billForm.getGuid()+"'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			sucflag = st.executeUpdate(sql);
			
			
			String czbGuid = CloMaintenanceDao.genarateGuid();
			String czbSql = "insert into cywxdjczbshop(guid,zbguid,czy,czsj,czlx,czbm) values(?,?,?, GETDATE(),'"
					+billForm.getZT()+"','DEPOT_"+loginDeptID+"')";
			pst = conn.prepareStatement(czbSql);
			pst.setString(1, czbGuid);
			pst.setString(2, billForm.getGuid());
			pst.setString(3, billForm.getUserID()); 
			sucflag = pst.executeUpdate();
			
		}finally{
			if (st != null) {
				st.close();
			}
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return sucflag;
	}
	
	public int deleteBill(String guid) throws Exception{
		Connection conn = null;
		Statement st = null;
		int rs = 0;
		try{
			String sql = "delete from cywxdjbshop where zt='20' and guid='"+guid+"'";
			String czbSql = "delete from cywxdjczbshop where zbguid='"+guid+"'";
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			st = conn.createStatement();
			if(st.executeUpdate(sql)>0){
				rs = st.executeUpdate(czbSql);
			}
			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			return rs;
		}finally{
			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return rs;
	}

}
