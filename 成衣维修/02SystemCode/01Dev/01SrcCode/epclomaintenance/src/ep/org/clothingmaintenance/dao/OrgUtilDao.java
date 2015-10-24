package ep.org.clothingmaintenance.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hy.SSO.service.PubWSService;

import ep.org.clothingmaintenance.bean.TTreeNode;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.util.DBUtil;
import ep.org.clothingmaintenance.util.PropertiesUtil;


public class OrgUtilDao {
	public static TTreeNode getOrgInfo(int deptID) throws Exception {
		TTreeNode rootTreeNode = new TTreeNode();

		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			conn = DBUtil.getConnection();

			st = conn.createStatement();
			rs = st
					.executeQuery("select c.dept_id,c.dept_name,(select count(1) from TC_DEPARTMENT b where b.parent_id=c.dept_id) sun_num from TC_DEPARTMENT c where c.dept_id="
							+ deptID);

			if (rs.next()) {
				rootTreeNode.setDeptid(String.valueOf(deptID));
				rootTreeNode.setEnname("");
				rootTreeNode.setName(rs.getString("dept_name"));
				if (rs.getInt("sun_num") > 0) {
					rootTreeNode.setHasunFlag("1");
					rootTreeNode.setIsParent(true);
				}
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

		return rootTreeNode;

	}

	public static List getSunOrgNode(int parentDeptID) throws Exception {
		ArrayList orgNodes = new ArrayList();
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		try {
		conn = DBUtil.getConnection();
		st = conn.createStatement();
		rs = st
				.executeQuery("select c.dept_id,c.dept_name,(select count(1) from TC_DEPARTMENT b where b.parent_id=c.dept_id) sun_num from TC_DEPARTMENT c where c.parent_id="+parentDeptID+" and c.stop_flag=0 and c.org_id=1");
		while(rs.next()){
			TTreeNode rootTreeNode = new TTreeNode();
			rootTreeNode.setDeptid(String.valueOf(rs.getInt("dept_id")));
			rootTreeNode.setEnname("");
			rootTreeNode.setName(rs.getString("dept_name"));
			if (rs.getInt("sun_num") > 0) {
				rootTreeNode.setHasunFlag("1");
				rootTreeNode.setIsParent(true);
			}
			orgNodes.add(rootTreeNode);
		}
		}finally{
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
		
		
		return orgNodes;

	}
	
	public static List getShopSelectData(String prefixValue) throws Exception{
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		List shopList = new ArrayList();
		HashMap<String, String> shop = null;
		try {
		conn = DBUtil.getConnection();
		st = conn.createStatement();
		if(prefixValue != null && !"".equals(prefixValue)){
			rs = st.executeQuery("select depotid,depotid+' | '+d_name from "+PropertiesUtil.getProperties().getProperty("drpdblink")+"j_depot where depotid like '"+prefixValue+"%' and m_type <> 0");
		}else{
			rs = st.executeQuery("select depotid,depotid+' | '+d_name from "+PropertiesUtil.getProperties().getProperty("drpdblink")+"j_depot where m_type <> 0");

		}
		while(rs.next()){
			shop = new HashMap<String, String>();
			shop.put("dpbm",rs.getString(1));
			shop.put("dpmc", rs.getString(2));
			shopList.add(shop);
		}
		}finally{
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
	 * @category 根据公司和店铺编码获取店铺对应信息
	 * @author DLY
	 * @date 2014-2-12 
	 * @param userInfo 
	 * @return shopList
	 * @throws Exception
	 */  
	public static List getShopInfo(String shopID,UserInfo userInfo) throws Exception{   
		
		//组合条件   
		String wsid = "111b4bb5-4f8f-417a-a51f-01b3a67adbdc";
		String env = "ITDC_EXCEL";
		String sessionID = "";
		String ConditionStr = "【操作类型,GET】【实体,J_DEPOT】【返回内容,店铺ID,店铺名称,店铺地址,品牌,店长姓名,店长联系电话,店铺类型,大区】"
				+ "【条件内容,《W》店铺ID,《W》公司】【《W》店铺ID,"+userInfo.getLoginDeptID()+"】【《W》公司,'"+userInfo.getCom()+"'】"; 
		//System.out.println(ConditionStr);
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", ConditionStr);   
		/*String com =  PubWSService.callWSRR(wsid, env, "", map);  
		System.out.println(com); */
		List<Map> shopList = PubWSService.callWSRRToList(wsid, env, "", map);
		if (shopList == null || shopList.size() == 0) {
			return null;
		}
		System.out.println("shopList.get(0):"+shopList.get(0).get("M_TYPE"));
		String dpTypeCode ="";
		String dpTypeName ="";
		if("11".equals((String)shopList.get(0).get("M_TYPE"))){
			dpTypeName = "自营";
			dpTypeCode = "1";
		}else{
			dpTypeName = "加盟";
			dpTypeCode = "2"; 
		}  
		
		Map map1 = new HashMap();
		map1.put("d_dq", (String)shopList.get(0).get("D_DQ"));
		map1.put("PP", (String)shopList.get(0).get("BRANDID"));
		map1.put("d_name", (String)shopList.get(0).get("D_NAME"));
		map1.put("dpTypeName", dpTypeName);
		map1.put("dpTypeCode", dpTypeCode); 
		map1.put("r_name", (String)shopList.get(0).get("R_NAME"));
		map1.put("tel", (String)shopList.get(0).get("TEL"));
		map1.put("address", (String)shopList.get(0).get("address"));
		
		
		//获取店铺对应维修仓
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;  
		try {
			conn = DBUtil.getConnection();
			st = conn.createStatement(); 
			/*String sql= "select wxcbm, wxcmc from PPWXCDYB where branch = '"+userInfo.getCom()
					+"' and pp = '"+(String)shopList.get(0).get("BRANDID")*/
			String sql= "select wxcbm, wxcmc from PPWXCDYB where pp = '"+userInfo.getLoginDeptID().substring(0,1)+"'";
				
			/*String sql="select a.d_dq,a.brandid PP,a.d_name,case when a.M_TYPE='11' then '自营' else '加盟' end as dpTypeName, " +
					"case when a.M_TYPE='11' then '1' else '2' end as dpTypeCode,a.r_name,a.tel,b.wxcbm,b.wxcmc,a.address," +
					"(select c.r_name from "+dblink+"j_depot c where c.depotid=b.wxcbm) receivename, " +
					"(select c.tel from "+dblink+"j_depot c where c.depotid=b.wxcbm) receivetel," +
					"(select c.address from "+dblink+"j_depot c where c.depotid=b.wxcbm) receiveaddress " +
					"from "+dblink+"j_depot a, PPWXCDYB b " +
					"where b.branch='"+userInfo.getCom()+"' and b.pp=a.brandid and b.dplx=(case when a.m_type='11' then '1' else '2' end) and  depotid='"+shopID+"'";
		    */
			rs = st.executeQuery(sql); 
			if(rs.next()){  
				map1.put("wxcbm", rs.getObject("wxcbm").toString());
				map1.put("wxcmc", rs.getObject("wxcmc").toString());  
				//获取维修仓联系人信息
				ConditionStr = "【操作类型,GET】【实体,J_DEPOT】【返回内容,店铺ID,店铺名称,店铺地址,品牌,店长姓名,店长联系电话,店铺类型】"
						+ "【条件内容,《W》店铺ID,《W》公司】【《W》店铺ID,"+rs.getObject("wxcbm")+"】【《W》公司,'"+userInfo.getCom()+"'】"; 
				//System.out.println(ConditionStr);
				Map mapwxc = new HashMap();
				mapwxc.put("InputFormat", "AML");
				mapwxc.put("OutputContentType", "RS");
				mapwxc.put("ConditionStr", ConditionStr);   
				/*String com =  PubWSService.callWSRR(wsid, env, "", map);  
				System.out.println(com); */
				List<Map> wxcList = PubWSService.callWSRRToList(wsid, env, "", mapwxc);
				if (wxcList !=  null || wxcList.size() > 0) {
					map1.put("receivename", (String)wxcList.get(0).get("R_NAME"));
					map1.put("receivetel", (String)wxcList.get(0).get("TEL"));
					map1.put("receiveaddress", (String)wxcList.get(0).get("address"));
				}
			}else{
				System.out.println("未找到对应维修仓！");
				return null;  
			}  
		}finally{
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
		List tshopList = new ArrayList();
		tshopList.add(map1);
		return tshopList;

	}
}
