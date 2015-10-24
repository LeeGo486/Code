package ep.org.clothingmaintenance.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hy.SSO.service.PubWSService; 



import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.util.DBUtil;
import ep.org.clothingmaintenance.util.PropertiesUtil;

public class UserDao {
	
	/**
	 * @category 根据用户id获取用户名称
	 * @author DLY
	 * @date 2014-2-24
	 * @param userID  如“1028” 
	 * @return userName
	 * @throws Exception
	 */
	public static String getUserName(String userID) throws Exception{  
		String userName = userID;
		if(userID==null ||"".equals(userID)){
			return "";
		}
		//组合条件   
		String wsid = PropertiesUtil.getProperties().getProperty("wsid1");
		String env = PropertiesUtil.getProperties().getProperty("env1");
		String sessionID = "";  
		Map map = new HashMap();
		map.put("ENV_SN", "HZY_CYWX"); 
		map.put("App_UserName", userID);  
		/*String com =  PubWSService.callWSRR(wsid, env, "", map);  
		System.out.println(com); */ 
		List<Map> list = PubWSService.callWSRRToList(wsid, env, "", map);  
		if(list.size()>0){  
			 //System.out.println(list.get(0).get("App_UserName_CN")); 
			 String s = (String)list.get(0).get("App_UserName_CN");
			 String[] sl = s.split("_");
			 if(sl.length>1){
				 userName = sl[sl.length-1];
			 } 
		} 
		return userName;

	}
	
	/**
	 * @category 根据用户id获取用户名称
	 * @author DLY
	 * @date 2014-2-24
	 * @param userIDs  如“1028,1042” 
	 * @return userName
	 * @throws Exception
	 */
	public static String getUserName1(String userIDs) throws Exception{ 
		userIDs = "1004,1042";
		String userName = "";
		//组合条件   
		String wsid = PropertiesUtil.getProperties().getProperty("wsid1");
		String env = PropertiesUtil.getProperties().getProperty("env1");
		String sessionID = "";  
		Map map = new HashMap();
		map.put("ENV_SN", "HZY_Mat"); 
		map.put("App_UserName", userIDs);  
		/*String com =  PubWSService.callWSRR(wsid, env, "", map);  
		System.out.println(com); */ 
		List<Map> list = PubWSService.callWSRRToList(wsid, env, "", map);  
		if(list.size()>0){
			for(int i=0; i<list.size(); i++){
				userName = userName + list.get(i).get("App_UserName_CN")+",";
				//System.out.println(list.get(i).get("App_UserName_CN")); 
			} 
		} 
		
		return userName.substring(0, userName.length()-2);

	}
	
	
	/**
	 * @category 根据店铺编号获取导购信息
	 * @author DLY
	 * @date 2014-2-12 
	 * @param shopID 
	 * @return employeeList
	 * @throws Exception
	 */
	public static List getEmployeeList(String shopID) throws Exception{  
		//组合条件   
		String wsid = "0dd084c5-abac-4bef-bbc0-ea28ee1f007b";
		String env = "ITDC_EXCEL";
		String sessionID = "";
		String ConditionStr = "【操作类型,GET】【实体,J_EMPLOYEE】【返回内容,客户经理ID,客户经理姓名,客户经理电话】"
				+ "【【条件内容,《W》店铺ID】【《W》店铺ID,"+shopID+"】"; 
		//System.out.println(ConditionStr);
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", ConditionStr);   
		//String com =  PubWSService.callWSRR(wsid, env, "", map);  
		//System.out.println(com); 
		List<Map> employeeList = PubWSService.callWSRRToList(wsid, env, "", map);    
		return employeeList;

	}
	
	public static void main(String[] arg0){
		try {
			getEmployeeList("E0009291");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static String getEmployeeTel(String employeeID) throws Exception{
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String tel = null;
		
		try {
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			String dblink = PropertiesUtil.getProperties().getProperty("drpdblink");
			String sql="select telephone from "+dblink+"j_employee where employeeid = '"+employeeID+"'";
			rs = st.executeQuery(sql);
			if(rs.next()){
				tel=rs.getString(1);
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
		
		
		return tel;

	}
	
	/**
	 * @category 获取VIP卡号信息 vipname+','+mobtel
	 * @author DLY
	 * @date 2014-2-12 
	 * @param vipcode 
	 * @return VIPCustomerInfo
	 * @throws Exception
	 */
	public static String getVIPCustomerInfo(String vipcode) throws Exception{
		String VIPCustomerInfo = null;  
		//组合条件   
		String wsid = "0cc1429c-14be-4f0e-96ed-be3efe127ac5";
		String env = "ITDC_EXCEL";
		String sessionID = "";
		String ConditionStr = "【操作类型,GET】【实体,VIP_USER】【返回内容,客户ID,客户姓名,客户手机号码】"
				+ "【条件内容,《W》VIP卡号】【《W》VIP卡号,"+vipcode+"】"; 
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", ConditionStr);   
		/*String com =  PubWSService.callWSRR(wsid, env, "", map); */
		List<Map> khList = PubWSService.callWSRRToList(wsid, env, "", map); 
		if (khList == null || khList.size() == 0) {
			VIPCustomerInfo="";
		} else {
			VIPCustomerInfo = (String) khList.get(0).get("VIPNAME"); 
			VIPCustomerInfo = VIPCustomerInfo+","+(String) khList.get(0).get("MOBTEL"); 
		}    
		
		return VIPCustomerInfo; 

	}
	
	 
	 
	/**
	 * 根据用户ID和密码获取用户的基础信息
	 * @param userID
	 * @param pwd
	 * @return UserInfo
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String userID,String pwd) throws Exception{
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		UserInfo userInfo = null;
		String DBLink = PropertiesUtil.getProperties().getProperty("MDMdblink");
		try {
			String sql="select a.j_userid userID,a.J_USERNAME userName,a.j_com com,a.j_pw pwd,a.j_depotid loginDeptID ,b.j_name deptName from "+DBLink+"POSUSER a,"+DBLink+"depot b where b.j_depotid=a.j_depotid and  a.j_userid='"+userID+"' and j_pw='"+pwd+"'";
			conn = DBUtil.getConnection();
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			userInfo = (UserInfo) DBUtil.convertResultTojavaBean(rs, "ep.org.clothingmaintenance.bean.UserInfo");
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
		return userInfo;
	}
}
