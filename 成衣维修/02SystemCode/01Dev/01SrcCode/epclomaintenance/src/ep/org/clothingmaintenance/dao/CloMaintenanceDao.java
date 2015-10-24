package ep.org.clothingmaintenance.dao;

import java.io.InputStream;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts.upload.FormFile;
import org.hy.SSO.service.PubWSService;
import org.hy.wsclient.SSO.login.LoginService;

import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.form.CloMaintenanceForm;
import ep.org.clothingmaintenance.form.EidtMaintenanceBillForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListForm;
import ep.org.clothingmaintenance.util.DBUtil;
import ep.org.clothingmaintenance.util.PropertiesUtil;


/**
   @description: 
   @author: DLY
   @version：2.00
   @date：2014-2-12  
   @historyfile：CloMaintenanceDao140212
*/
public class CloMaintenanceDao {

	

	public static String genarateGuid() throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String guid = null;
		try {
			conn = DBUtil.getConnection();
			st = conn.createStatement();

			rs = st.executeQuery("select newid()");
			if (rs.next()) {
				guid = rs.getString(1);
			}
			String[] guids = guid.split("-");
			guid = guids[0] + guids[1] + guids[2] + guids[3] + guids[4];

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

		return guid;
	}

	public static String genarateDH(String shopID,UserInfo userInfo) throws Exception {
		Connection conn = null;
		CallableStatement callSta = null;
		ResultSet rs = null;
		String dh = null;
		try {
			conn = DBUtil.getConnection();
			String exeSql = "{call GenerateCYWXDJBDH()}";
			callSta = conn.prepareCall(exeSql);
			//callSta.setString(1, shopID);
			//callSta.setString(2, userInfo.getCom());

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

	public List queryList(MaintenanceInfoListForm form,UserInfo userInfo) throws Exception {
		StringBuffer sqlBuffer = new StringBuffer();
		StringBuffer conditionBuffer = new StringBuffer();
		sqlBuffer
				.append("select b.GUID ,b.DH ,b.YDH ,b.DPBM,b.DPMC ,b.KH ,b.zt ZTCODE,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '成衣维修状态' and a.fsequence = b.zt) ZT ,b.DJSJ ,b.THRQ ,b.GKXM ,b.VIPKH,b.GKLXDH ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '紧急程度' and A.FCODE=b.JJCD) JJCD,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '成衣维修性质' and a.fcode = b.wxxz1) WXXZ1 ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '成衣问题点' and a.fcode = b.wtd1) WTD1 ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '成衣问题起因' and a.fcode = b.qy1) QY1 ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '成衣问题现象点' and a.fcode = b.xxd1) XXD1 ");
		sqlBuffer
				.append(",b.WXBW , b.PJPDSJ ,b.ZBFH_BZRQ ,b.ZBFH_YSGS ,b.ZBFH_YSDH,b.SFJE"
						+ " ,(select a.fcontent from SCFX_TYBMB a where a.FSCOPE = '判定处理方式' and a.fcode = b.pdclfs) PDCLFS ,b.WXSJ ,(case when b.dppj='0' then '好评'  when b.dppj='1' then '中评'  when b.dppj='2' then '差评' else '' end) DPPJ ,b.THDH, (case when b.POSTHFHDDZBS='0' then '未登帐' when b.POSTHFHDDZBS='1' then '已登帐' else '' end) getchk_sure from CYWXDJB b ");

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

		if (form.getYDH() != null && !"".equals(form.getYDH())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.ydh like '%" + form.getYDH() + "%'");
			condition++;
		}

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

		if (form.getDplx() != null && !"".equals(form.getDplx())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append(" b.DPLX='" + form.getDplx() + "'");
			condition++;
		}

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
					.append(" exists (select 1 from CYWXDJCZB c where c.zbguid=b.guid ");
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
		if (form.getJudgeBgnDate() != null
				&& !"".equals(form.getJudgeBgnDate())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append("  b.PJPDSJ>CONVERT(DATETIME,'"
					+ form.getJudgeBgnDate() + "')");
			condition++;
		}

		if (form.getJudgeEndDate() != null
				&& !"".equals(form.getJudgeEndDate())) {
			if (condition > 0) {
				conditionBuffer.append(" and ");
			}
			conditionBuffer.append("  b.PJPDSJ<CONVERT(DATETIME,'"
					+ form.getJudgeEndDate() + " 23:59:59')");
			condition++;
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

	public List getShopAllSelectData() throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List shopList = new ArrayList();
		HashMap<String, String> shop = null;
		try {
			conn = DBUtil.getConnection();
			st = conn.createStatement();

			rs = st.executeQuery("select depotid,d_name,address,d_dq from "
					+ PropertiesUtil.getProperties().getProperty("drpdblink")
					+ "j_depot where m_type <> 0");
			shopList = DBUtil.convertResultToMapList(rs);
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

		return shopList;

	}

	/**
	 * @category 查询维修单信息
	 * @author DLY
	 * @date 2014-2-24 
	 * @param guid 
	 * @return Object
	 * @throws Exception
	 */
	public Object viewMaintenanceBillInfo(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill(); 
		try { 
			String sql = "select a.guid,a.dpdq,a.pp,a.ys,a.ms,a.dh,a.dpbm,a.dpmc,dplx dplxcode,case a.dplx when '1' then '自营' else '加盟' end as dplx,a.dzxm,a.dzlxdh,a.wxcbm,a.wxcmc, "
					+ " a.sldg as lxdg, a.sldg, a.dglxdh,a.SFFGKWX ,a.SFTYFFWX,a.SLDGXM,"
					+ "a.vipkh,a.gkxm,a.gklxdh,convert(varchar,a.scsj,23) scsj,a.jjcd,"
					+ "a.kh,convert(varchar,a.thrq,23) thrq,a.wtms,a.ysgs,a.ydh,a.fhdz,a.shdz,a.shr,a.shrlxdh,a.bzxx,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣维修状态' and b.fcode = a.zt) ztTypeName,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣维修性质' and b.fcode = a.wxxz1) wxxz1,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题点' and b.fcode = a.wtd1) wtd1,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题起因' and b.fcode = a.qy1) qy1,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题现象点' and b.fcode = a.xxd1) xxd1,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣维修性质' and b.fcode = a.wxxz2) wxxz2,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题点' and b.fcode = a.wtd2) wtd2,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题起因' and b.fcode = a.qy2) qy2,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣问题起因' and b.fcode = a.xxd2) xxd2,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '判定处理方式' and b.fcode = a.pdclfs) pdclfs,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '维修_责任部门' and b.fcode = a.zrbm) zrbm,"
					+ "a.thdh,a.tccljg,a.jcyy,case a.tx when '0' then '否' else '是' end tx,case a.sfsf when '0' then '否' else '是' end sfsf,"
					+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '计划维修天数' and b.fcode = a.jhwxts) jhwxts,"
					+ "a.sfje,a.sfnr,a.pjpdbz,a.wxr,convert(varchar,a.wxsj,23) wxsj, a.djr djr,"
					+ "convert(varchar,a.djsj,20) djsj,  a.pjpdr pjpdr,"
					+ "convert(varchar,a.pjpdsj,20) pjpdsj, a.ttspr ttspr,"
					+ "convert(varchar,a.ttspsj,20) ttspsj, a.wxqrr  wxqrr,"
					//+ "(select b.fcontent from SCFX_TYBMB b where b.FSCOPE = '成衣维修状态' and b.fcode = a.zt) zt "
					+"convert(varchar,a.wxqrsj,20) wxqrsj,zt "
					+ "from cywxdjb a where  a.guid='" + guid + "'";
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
				bean.setWXCBM(rs.getString("wxcbm"));
				bean.setWXCMC(rs.getString("wxcmc"));
				if (rs.getString("lxdg") == null
						|| rs.getString("lxdg").equals("")) {
					bean.setSLDG(rs.getString("sldg"));
				} else {
					bean.setSLDG(rs.getString("lxdg"));
				}

				bean.setSldgCode(rs.getString("sldg"));
				bean.setSLDGXM(rs.getString("SLDGXM"));
				bean.setDGLXDH(rs.getString("dglxdh"));
				bean.setGKWX(Integer.toString(rs.getInt("SFFGKWX")));
				bean.setSFTYFFWX(Integer.toString(rs.getInt("SFTYFFWX")));
				bean.setVIPKH(rs.getString("vipkh"));
				bean.setGKXM(rs.getString("gkxm"));
				bean.setGKLXDH(rs.getString("gklxdh"));
				bean.setSCSJ(rs.getString("scsj"));
				bean.setJJCD(rs.getString("jjcd"));
				bean.setKH(rs.getString("kh"));
				bean.setTHRQ(rs.getString("thrq"));
				bean.setWTMS(rs.getString("wtms"));
				bean.setYSGS(rs.getString("ysgs"));
				bean.setYDH(rs.getString("ydh"));
				bean.setFHDZ(rs.getString("fhdz"));
				bean.setSHDZ(rs.getString("shdz"));
				bean.setSHR(rs.getString("shr"));
				bean.setSHRLXDH(rs.getString("shrlxdh"));
				bean.setBZXX(rs.getString("bzxx"));
				bean.setZtTypeName(rs.getString("ztTypeName"));
				bean.setWXXZ1(rs.getString("wxxz1"));
				bean.setWTD1(rs.getString("wtd1"));
				bean.setQY1(rs.getString("qy1"));
				bean.setXXD1(rs.getString("xxd1"));
				bean.setWXXZ2(rs.getString("wxxz2"));
				bean.setWTD2(rs.getString("wtd2"));
				bean.setQY2(rs.getString("qy2"));
				bean.setXXD2(rs.getString("xxd2"));
				bean.setPDCLFS(rs.getString("pdclfs"));
				bean.setZRBM(rs.getString("zrbm"));
				bean.setTHDH(rs.getString("thdh"));
				bean.setTCCLJG(rs.getString("tccljg"));
				bean.setJCYY(rs.getString("jcyy"));
				bean.setTX(rs.getString("tx"));
				bean.setSFSF(rs.getString("sfsf"));
				bean.setJHWXTS(rs.getString("jhwxts"));
				bean.setSFJE(rs.getString("sfje"));
				bean.setSFNR(rs.getString("sfnr"));
				bean.setPJPDBZ(rs.getString("pjpdbz"));
				bean.setWXR(rs.getString("wxr"));
				bean.setWXSJ(rs.getString("wxsj")); 
				bean.setDjr(UserDao.getUserName(rs.getString("djr")));
				bean.setDjsj(rs.getString("djsj"));
				bean.setPJPDR(UserDao.getUserName(rs.getString("pjpdr")));
				bean.setPJPDSJ(rs.getString("pjpdsj"));
				bean.setTTSPR(UserDao.getUserName(rs.getString("ttspr")));
				bean.setTTSPSJ(rs.getString("ttspsj"));
				bean.setWXQRR(UserDao.getUserName(rs.getString("wxqrr")));
				bean.setWXQRSJ(rs.getString("wxqrsj"));
				bean.setZT(rs.getString("zt"));
				bean.setYS(rs.getString("ys"));
				bean.setMS(rs.getString("ms"));
				bean.setDPDQ(rs.getString("dpdq"));
				bean.setPP(rs.getString("pp"));
				bean.setGuid(rs.getString("guid"));
			}

		}catch (Exception e) {
			e.printStackTrace(); 
		}  finally {
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

	public Object viewHQSendGoods(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill(); 
		try {
			String sql = "select ZBFHDH,ZBFH_YSGS,ZBFH_YSDH,ZBFH_FHDZ,ZBFH_SHDZ,ZBFH_SHR,ZBFH_SHRDH,ZBFH_BZ,"
					+ "a.ZBFH_BZR  ZBFH_BZR,"
					+ "convert(varchar,ZBFH_BZRQ,20) ZBFH_BZRQ,dpbm,dpmc from cywxdjb a where guid='"
					+ guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				bean.setZBFH_DH(rs.getString("ZBFHDH"));
				bean.setZBFH_YSGS(rs.getString("ZBFH_YSGS"));
				bean.setZBFH_FHDZ(rs.getString("ZBFH_FHDZ"));
				bean.setZBFH_YSDH(rs.getString("ZBFH_YSDH"));
				bean.setZBFH_SHDZ(rs.getString("ZBFH_SHDZ"));
				bean.setZBFH_SHR(UserDao.getUserName(rs.getString("ZBFH_SHR")));
				bean.setZBFH_SHRDH(rs.getString("ZBFH_SHRDH"));
				bean.setZBFH_BZ(rs.getString("ZBFH_BZ"));
				bean.setZBFH_BZR(rs.getString("ZBFH_BZR"));
				bean.setZBFH_BZSJ(rs.getString("ZBFH_BZRQ")); 
				bean.setDpbm(rs.getString("dpbm")); 
				bean.setDpmc(rs.getString("dpmc")); 
			}

		}catch (SQLException e) {
			e.printStackTrace(); 
		}  finally {
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

	/**
	 * @category 查询评论  
	 * @param guid 
	 * @return Object
	 * @throws Exception
	 */
	public Object viewAppraiseinfo(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill();
		try {
			String sql = "select ZT,GKPJ,GKPJYJ,DPPJ,DPPJYJ from cywxdjb where guid='"
					+ guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				bean.setZT(rs.getString("ZT"));
				bean.setGKPJ(rs.getString("GKPJ"));
				bean.setGKPJYJ(rs.getString("GKPJYJ"));
				bean.setDPPJ(rs.getString("DPPJ"));
				bean.setDPPJYJ(rs.getString("DPPJYJ"));
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

	/**
	 * @category 保存评论  并执行收货 
	 * @param bean, userInfo
	 * @return boolean
	 * @throws Exception
	 */
	public boolean updateAppraise(MaintenanceBill bean,UserInfo userInfo) throws Exception {
		Connection conn = null;
		Statement st = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		boolean sucflag = false;
		String dppjOrgkpk = "";
		try {
			String sql = "";
			String czbSql = "";
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			st = conn.createStatement();
			if (bean.getZT().equals("8")) {
				sql = "update cywxdjb set DPPJ='" + bean.getDPPJ()
						+ "',DPPJYJ='" + bean.getDPPJYJ()
						+ "',zt='9' where zt='8' and guid='" + bean.getGuid() + "'";
				czbSql = "insert into cywxdjczb(guid,zbguid,czy,czsj,czlx,czbm,czyxm,czbmmx) " 
						+" values(?,?,?, GETDATE(),'9', 'DEPOT_"+userInfo.getLoginDeptID()
						+"', '"+userInfo.getUserName()+"', '"+userInfo.getDeptName()+"' )";
				dppjOrgkpk = "dppj";

			} else {
				sql = "update cywxdjb set GKPJ='" + bean.getGKPJ()
						+ "',GKPJYJ='" + bean.getGKPJYJ()
						+ "',zt='10',DJZT='1' where  zt='9' and guid='" + bean.getGuid()
						+ "'";
				czbSql = "insert into cywxdjczb(guid,zbguid,czy,czsj,czlx,czbm,czyxm,czbmmx)  " 
						+" values( ?,?,?, GETDATE(),'10', 'DEPOT_"+userInfo.getLoginDeptID()
						+"', '"+userInfo.getUserName()+"', '"+userInfo.getDeptName()+"' )"; 
				dppjOrgkpk = "gkpj";
			}
			/*//获取退货发货单号并执行收货
			if("dppj".equals(dppjOrgkpk)){
				dppjOrgkpk = "dpshsb"; 
				String sql1 = "select ZBFHDH from cywxdjb where guid='"+ bean.getGuid()+"'"; 
			    rs = st.executeQuery(sql1);
				if(rs.next()){ 
					//System.out.println("ZBFHDH:"+rs.getString("ZBFHDH"));
		            	//生成退货单 
						String wsid = "83747e34-ad30-4028-ae74-b0a7f21a378f";
						String env = "ITDC_EXCEL";
						String sessionID = "";
						String ConditionStr = "【操作类型,NEW】【实体,收货】"
								+ "【新增内容,退货单号,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,原价,现价,结算价,折扣】" 
								+ "【条件内容,《N》退货单号,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号," 
								+ "《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣 】【《N》登记人】" 
								+ "【《N》退货单号,"+rs.getString("ZBFHDH")+"】【《N》发货店铺ID,】【《N》收货店铺ID,】【《N》装箱号,0】" 
								+ "【《N》款号,】【《N》款式编号,】【《N》颜色,】【《N》尺码,】【《N》退货数量,0】" 
								+ "【《N》成本,0】【《N》原价,0】【《N》现价,0】【《N》结算价,0】【《N》折扣,0】"  
								+ "【《N》登记人,】";   
						//System.out.println(ConditionStr);
						Map map = new HashMap();
						map.put("InputFormat", "AML");
						map.put("OutputContentType", "RS");
						map.put("ConditionStr", ConditionStr);   
						String com =  PubWSService.callWSRR(wsid, env, "", map);  
						System.out.println(com); 
						List<Map> dpsh = PubWSService.callWSRRToList(wsid, env, "", map); 
						if(dpsh.size()>0){
							String rflag =  (String)dpsh.get(0).get("FLAG");
							if(rflag!=null &&  "TRUE".equals(rflag) ){
								dppjOrgkpk = "dpshcg"; 
							}
						}  
	            }
			} */
			/*if(!("dpshsb".equals(dppjOrgkpk))){  */
				st.executeUpdate(sql);
				pst = conn.prepareStatement(czbSql);
				String czbGuid = genarateGuid();
				pst.setString(1, czbGuid);
				pst.setString(2, bean.getGuid());
				pst.setString(3, bean.getUserid()); 
				pst.executeUpdate();  
			/*} */
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
			return false;
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
		return true;

	}

	public List queryOperateRecord(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List recordList = new ArrayList();
		try {
			String sql = "select a.czbmmx CZBM ,"
					+ "a.czyxm CZY,"
					+ "CONVERT(VARCHAR,a.CZSJ,20) CZSJ,"
					+ "(select b.FCONTENT from SCFX_TYBMB b where b.FSCOPE='成衣维修状态' and b.FCODE=a.czlx) CZLX"
					+ " from cywxdjczb a where a.zbguid='"
					+ guid
					+ "' ORDER BY a.czsj";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			recordList = DBUtil.convertResultToMapList(rs);

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

		return recordList;
	}

	public Object getExpressData(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill();
		try {
			String sql = "select DPMC,DZXM,DZLXDH,FHDZ,SHDZ,SHR,SHRLXDH from cywxdjb where guid='"
					+ guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				bean.setSHR(rs.getString("SHR"));
				bean.setDZXM(rs.getString("DZXM"));
				bean.setDZLXDH(rs.getString("DZLXDH"));
				bean.setDpmc(rs.getString("DPMC"));
				bean.setFHDZ(rs.getString("FHDZ"));
				bean.setSHDZ(rs.getString("SHDZ"));
				bean.setSHRLXDH(rs.getString("SHRLXDH"));

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

	/**
	 * @category 打印维修单
	 * @author DLY
	 * @date 2014-2-24
	 * @param guid 
	 * @return MaintenanceBill
	 * @throws Exception
	 */
	public Object getShopPrintData(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		MaintenanceBill bean = new MaintenanceBill();
		UserDao ud = new UserDao();
		try { 
			String sql = "select DH,Branch,PP,DPBM,DPMC,SFFGKWX,DZXM,DZLXDH,GKXM,GKLXDH,WXCBM,VIPKH,SLDG,SFTYFFWX,KH,YS,MS,"
					+ "convert(varchar(10),SCSJ,20) as SCSJ,WTMS,YSGS,YDH,FHDZ,DGLXDH,"
					+ "cast(datepart(yyyy,THRQ) as varchar(4)) + '年'+ right('0' + cast(datepart(mm,THRQ) as varchar(2)), 2) + '月'+ right('0' + cast(datepart(dd,THRQ) as varchar(2)), 2) + '日 ' as THRQ "
					+ "from cywxdjb where guid='" + guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				bean.setDh(rs.getString("DH"));  
				bean.setPP(rs.getString("Branch"));
				bean.setDpmc(rs.getString("DPMC"));
				bean.setGKWX(rs.getString("SFFGKWX"));
				bean.setDZXM(rs.getString("DZXM"));
				bean.setGKXM(rs.getString("GKXM"));
				bean.setGKLXDH(rs.getString("GKLXDH"));
				bean.setWXCBM(rs.getString("WXCBM"));
				bean.setVIPKH(rs.getString("VIPKH"));
				bean.setDGLXDH(rs.getString("DGLXDH"));
				bean.setSLDG(rs.getString("SLDG"));
				
				/*if (rs.getString("SLDG") == null
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
				} */
				
				bean.setSFTYFFWX(rs.getString("SFTYFFWX"));
				bean.setKH(rs.getString("KH"));
				bean.setYS(rs.getString("YS"));
				bean.setMS(rs.getString("MS"));
				bean.setSCSJ(rs.getString("SCSJ"));
				bean.setWTMS(rs.getString("WTMS"));
				bean.setYSGS(rs.getString("YSGS"));
				bean.setYDH(rs.getString("YDH"));
				bean.setFHDZ(rs.getString("FHDZ"));
				bean.setTHRQ(rs.getString("THRQ"));
				bean.setDZLXDH(rs.getString("DZLXDH"));

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

	public List getImageInfo(String guid, String imageType) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List imageInfoList = new ArrayList();
		try {
			String sql = "select GUID,WJM,MS,'查看' VIEWOP,'删除' DELETEOP from CYWXDJTPB where zbguid='"
					+ guid + "' and LX='" + imageType + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			imageInfoList = DBUtil.convertResultToMapList(rs);

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
		return imageInfoList;
	}

	/**
	 * @category 保存维修单 
	 * @date 2014-2-24
	 * @param 
	 * @return  
	 * @throws Exception
	 */
	public int saveBill(EidtMaintenanceBillForm billForm,UserInfo userInfo) throws Exception {
		Connection conn = null;
		PreparedStatement st = null;
		int sucflag = 0;
		try {
			String sql = "";
			if (billForm.getIsSaveFlag().equals("false")) {
				sql = "insert into cywxdjb(ms,dpbm,dpmc,dplx,dzxm,dzlxdh,wxcbm,wxcmc,sldg,dglxdh,"
						+ "sffgkwx,SFTYFFWX,VIPKH,GKXM,GKLXDH,SCSJ,JJCD,KH,THRQ,WTMS,"
						+ "YSGS,YDH,FHDZ,SHDZ,SHR,SHRLXDH,BZXX,Djr,Djsj,DPDQ,pp,zt,ys,dh,guid,DJZT,branch,sldgxm)  values (?,?,?,?,?,?,?,?,?,?"
						+ ",?,?,?,?,?,convert(datetime,?),?,?,convert(datetime,?),?, '"
						+ billForm.getYSGS()
						+ "',?,?,?,?,?,?,?,convert(datetime,?),?,?,'0',?,?,?,'0','"+userInfo.getCom()+"','"+billForm.getSLDGXM()+"')";
			} else {
				sql = "update cywxdjb set ms=?,dpbm=?,dpmc=?,dplx=?,dzxm=?,dzlxdh=?,wxcbm=?,wxcmc=?,sldg=?,dglxdh=?,"
						+ "sffgkwx=?,SFTYFFWX=?,VIPKH=?,GKXM=?,GKLXDH=?,SCSJ=?,JJCD=?,KH=?,THRQ=?,WTMS=?,"
						+ "YSGS='"
						+ billForm.getYSGS()
						+ "',YDH=?,FHDZ=?,SHDZ=?,SHR=?,SHRLXDH=?,BZXX=?,Djr=?,Djsj=?,DPDQ=?,pp=?,ys=?,sldgxm='"+billForm.getSLDGXM()+"' where zt='0' and guid='"
						+ billForm.getGuid() + "'";
			}
			System.out.println("保存SQL:"+sql);
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
			st.setInt(11, Integer.parseInt(billForm.getGKWX()));
			st.setInt(12, Integer.parseInt(billForm.getSFTYFFWX()));
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
			
			System.out.println("-----保存状态:"+billForm.getIsSaveFlag());
			if (billForm.getIsSaveFlag().equals("false")) {
				st.setString(32, billForm.getDh());
				st.setString(33, billForm.getGuid());
			}
			sucflag = st.executeUpdate();
			System.out.println("-----业务保存成功标志:"+sucflag);
			if (billForm.getIsSaveFlag().equals("false")) {
				String czbGuid = genarateGuid();
				String czbSql = "insert into cywxdjczb(guid,zbguid,czy,czsj,czlx,czbm,czyxm,czbmmx) " 
						+ " values( ?,?,?, GETDATE(),'0','DEPOT_"
						+ userInfo.getLoginDeptID()+"','"+userInfo.getUserName()
						+ "','"+userInfo.getDeptName()+"' )";
				st = conn.prepareStatement(czbSql);
				st.setString(1, czbGuid);
				st.setString(2, billForm.getGuid());
				st.setString(3, billForm.getUserID()); 
				sucflag = st.executeUpdate();
			}
			System.out.println("-----日志保存成功标志:"+sucflag);
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

	
	/**
	 * @category 发送总部 
	 * DLY
	 * @date 2014-2-24
	 * @param form， userInfo
	 * @return boolean
	 * @throws Exception
	 */
	public boolean sendBilltoHQ(CloMaintenanceForm form,UserInfo userInfo) throws Exception {
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		boolean sucflag = false;
		try { 
			conn = DBUtil.getConnection();
			
			
			//获取维修单信息
			String sql1 = "select * FROM  CYWXDJB where guid = ?";
			st = conn.prepareStatement(sql1); 
			st.setString(1, form.getGuid());  
			rs = st.executeQuery();
			if(rs.next()){   
				//生成退货单 
				/*String wsid = "83747e34-ad30-4028-ae74-b0a7f21a378f";
				String env = "ITDC_EXCEL";
				String sessionID = "";
				String ConditionStr = "【操作类型,NEW】【实体,发货】"
						+ "【新增内容,退货单号,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,原价,现价,结算价,折扣】" 
						+ "【条件内容,《N》退货单号,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号," 
						+ "《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣 】【《N》登记人】" 
						+ "【《N》退货单号,''】【《N》发货店铺ID,"+rs.getString("DPBM")
						+ "】【《N》收货店铺ID,"+rs.getString("WXCBM")+"】【《N》装箱号,0】" 
						+ "【《N》款号,"+rs.getString("KH")
						+ "】【《N》款式编号,"+rs.getString("KH")
						+ "】【《N》颜色,"+rs.getString("YS")+"】【《N》尺码,"+rs.getString("MS")+"】【《N》退货数量,1】" 
						+ "【《N》成本,0】【《N》原价,0】【《N》现价,0】【《N》结算价,0】【《N》折扣,0】"  
						+ "【《N》登记人,"+rs.getString("DJR")+"】";  

				//System.out.println(ConditionStr);
				Map map = new HashMap();
				map.put("InputFormat", "AML");
				map.put("OutputContentType", "RS");
				map.put("ConditionStr", ConditionStr);   
				String com =  PubWSService.callWSRR(wsid, env, "", map);  
				System.out.println(com); 
				List<Map> thdh = PubWSService.callWSRRToList(wsid, env, "", map); 
				if(thdh.size()>0){
					String rflag =  (String)thdh.get(0).get("FLAG");
					if(rflag!=null &&  "TRUE".equals(rflag) ){*/
						conn.setAutoCommit(false);
						//修改主表状态
						String sql = "update cywxdjb set zt='1' where zt='0' and guid=?  "; 
						st = conn.prepareStatement(sql);
						//st.setString(1, (String)thdh.get(0).get("outindentid"));
						st.setString(1, form.getGuid());
						boolean s = st.execute();

					    //记录操作
						String czbGuid = genarateGuid(); 
						String czbSql = "insert into cywxdjczb(guid,zbguid,czy,czsj,czlx,czbm,czyxm,czbmmx) " 
								+ " values( ?,?,?, GETDATE(),'1','DEPOT_"
								+ userInfo.getLoginDeptID()+"','"+userInfo.getUserName()
								+ "','"+userInfo.getDeptName()+"')";
						st = conn.prepareStatement(czbSql);
						st.setString(1, czbGuid);
						st.setString(2, form.getGuid());
						st.setString(3, form.getUserID()); 
						sucflag = st.execute();
						
						 //记录物流信息
						String wlGuid = genarateGuid(); 
						String wlSql = "insert into cywxwlb(guid,zbguid,wxdh,ydh,js,fhsj,czguid,wlgs,fhdp) " 
								+ " values( ?,?,?,?,'1',GETDATE(),?,?,?)";
						st = conn.prepareStatement(wlSql);
						st.setString(1, wlGuid);
						st.setString(2, form.getGuid());
						st.setString(3, rs.getString("DH")); 
						st.setString(4, rs.getString("YDH")); 
						st.setString(5, czbGuid);
						st.setString(6, rs.getString("YSGS")); 
						st.setString(7, rs.getString("DPMC")); 
						sucflag = st.execute(); 
						conn.commit(); 
					}else{
						return false;
					}
				/*}else{
					return false;
				} 
				
			} else{
				return false;
			}*/

		} catch (SQLException e) {
			conn.rollback();
			return false;
		} finally {
			if (st != null) {
				st.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return sucflag;
	}

	public boolean saveBillPictrue(EidtMaintenanceBillForm billForm)
			throws Exception {
		Connection conn = null;
		PreparedStatement st = null;
		boolean sucflag = false;
		try {
			String guid = genarateGuid();
			FormFile image = billForm.getUploadFile();
			String sql = "insert into CYWXDJTPB(guid,ZBGUID,LX,WJM,MS,p1,DX) values(?,?,?,?,?,?,?)";
			conn = DBUtil.getConnection();
			st = conn.prepareStatement(sql);
			st.setString(1, guid);
			st.setString(2, billForm.getGuid());
			st.setString(3, "待修图片");
			st.setString(4, image.getFileName());
			st.setString(5, billForm.getPicms());
			InputStream is = image.getInputStream();
			st.setBinaryStream(6, is, is.available());
			st.setString(7, Integer.toString(image.getFileSize()));
			sucflag = st.execute();
			is.close();
			billForm.setPicms("");
		} finally {
			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return sucflag;
	}

	public void deletePicture(EidtMaintenanceBillForm billForm)
			throws Exception {
		Connection conn = null;
		PreparedStatement st = null;
		try {
			String sql = "delete from CYWXDJTPB where guid=?";
			conn = DBUtil.getConnection();
			st = conn.prepareStatement(sql);
			st.setString(1, billForm.getPicGuid());
			st.execute();

		} finally {
			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

	}

	public InputStream getImageData(String guid) throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		InputStream is = null;
		try {
			String sql = "select p1 from cywxdjtpb where guid ='" + guid + "'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				is = rs.getBinaryStream("p1");
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

		return is;
	}

	/**
	 * @category 用户认证
	 * @author DLY
	 * @date 2014-2-12
	 * @param userID
	 * @param pwd
	 * @return 用户信息: ssoSessionID_店铺编号_店铺名称,
	 * @throws Exception
	 */
	public String checkUser(String userID, String pwd) throws Exception {   
		String loginDept = null;
		String ssoSessionID = LoginService.ssoLogin("HZY_CYWX", "HZY_CYWX", userID, pwd);
		//System.out.println("ssoSessionID:"+ssoSessionID); 
		if(ssoSessionID==null || ssoSessionID.substring(0, 5).toUpperCase().equals("ERROR") ){ 
			return ssoSessionID;
		}
		
		//组合条件   
		String wsid = "5c968f16-c517-43b0-896d-93e3f231d50b";
		String env = "HZY_CYWX";
		String sessionID = ssoSessionID;
		Map map = new HashMap();
		map.put("SessionID", ssoSessionID);    
		List<Map> list = PubWSService.callWSRRToList(wsid, env, sessionID, map);
		if(list!=null && list.size()>0){
			loginDept = (String) list.get(0).get("App_UserName_CN"); 
		}  
		return ssoSessionID+"_"+loginDept; 
	}
	
	/**
	 * @category 根据店铺编码获取所属公司
	 * @author DLY
	 * @date 2014-2-12
	 * @param depotID 
	 * @return 所属公司
	 * @throws Exception
	 */
	public String getComByDepot(String depotID) throws Exception {
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", "【操作类型,GET】【cono,HYFG】【店铺编号,"+depotID+"】"); 
		/*String com =  PubWSService.callWSRR(
				"85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25", "DRPAS", "", map); */
		List<Map> comList = PubWSService.callWSRRToList(
				"85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25", "DRPAS", "", map); 
		if (comList == null || comList.size() == 0 || comList.get(0)==null) {
			return "";
		} else {
			String com =  (String) comList.get(0).get("CPY_NAME");
			if(com!=null){
				com = com.replace("DRP", "");
			}
			return com;
		}   
	}

	public List<Map<String, String>> getTransCos() throws Exception {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			// HashMap<String, String> map = null;
			String sql = "select '' transCoCode,'' transCoName  union all select mc transCoCode ,mc transCoName from YSGSXXB where sx='公用'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			/*
			 * while(rs.next()){ map = new HashMap<String, String>();
			 * map.put("transCoCode", rs.getString("transCoCode"));
			 * map.put("transCoName", rs.getString("transCoName"));
			 * list.add(map); }
			 */
			list = DBUtil.convertResultToMapList(rs);
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
		return list;
	}
	
	public int deleteBill(String guid) throws Exception{
		Connection conn = null;
		Statement st = null;
		int rs = 0;
		try{
			String sql = "delete from cywxdjb where zt='0' and guid='"+guid+"'";
			String czbSql = "delete from cywxdjczb where zbguid='"+guid+"'";
			String tpbsql = "delete from cywxdjtpb where zbguid='"+guid+"'";
			String wlbsql = "delete from cywxwlb where zbguid='"+guid+"'";
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			st = conn.createStatement();
			if(st.executeUpdate(sql)>0){
				rs = st.executeUpdate(czbSql);
				rs=st.executeUpdate(tpbsql);
				rs=st.executeUpdate(wlbsql);
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
	
	
	/**
	 * @category 修改运单号
	 * DLY
	 * @date 2014-2-25
	 * @param nydh, guid
	 * @return boolean
	 * @throws Exception
	 */
	public boolean updateydh(String nydh,String guid,UserInfo userInfo) throws Exception {
		Connection conn = null;
		Statement st = null;
		boolean flag = false;
		if(userInfo.getSessionID()==null ||userInfo.getSessionID()==""){
			return false;
		}
		try{
			conn = DBUtil.getConnection(); 
			st = conn.createStatement();
			//修改物流记录
			String sql = "update cywxwlb set Remark = isnull(Remark,'')+'"
					+userInfo.getUserName()+"(运单号'+YDH+'->"+nydh+")'+convert(varchar(20),getdate(),120)+';  '   , YDH = '"
					+nydh+"'  where zbguid='"+guid+"'"; 
			int a = st.executeUpdate(sql); 
			
			//修改维修单
			String sql1 = "update CYWXDJB set YDH = '"+nydh+"'  where guid='"+guid+"'"; 
			int b = st.executeUpdate(sql1); 
			if(a>0 && b>0){
				flag = true;
			}
			  
		} catch (SQLException e) { 
			System.out.println("修改失败！");
		}finally{
			if (st != null) {
				st.close();
			}
			if (conn != null) {
				conn.close();
			}
		} 
		return flag;
		
	}
	/*public static void main(String[] arg0){
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", "【操作类型,GET】【cono,HYFG】【店铺编号,E0009573】");
		String com =  PubWSService.callWSRR(
				"85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25", "DRPAS", "", map); 
		System.out.println(com);
	}*/
	
		
	
	
}
