package ep.org.clothingmaintenance.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ep.org.clothingmaintenance.bean.TTreeNode;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.dao.AjaxDao;
import ep.org.clothingmaintenance.dao.CloMaintenanceDao;
import ep.org.clothingmaintenance.dao.OrgUtilDao;
import ep.org.clothingmaintenance.dao.UserDao;


public class AjaxService {
	public static String getRootNodeTreeData(HttpServletRequest request) throws Exception{
		String deptID= request.getParameter("loginDeptID");
		Gson gson = new Gson();
		
		TTreeNode rootTreeNode = OrgUtilDao.getOrgInfo(Integer.parseInt(deptID));
		String json = gson.toJson(rootTreeNode);
		return json;
		
	}
	
	public static String getSunNodeTreeData(HttpServletRequest request) throws Exception{
		Gson gson = new Gson();
		String arrayJson = "[";
		String parentDeptID = request.getParameter("parentDeptID");
		List nodes = OrgUtilDao.getSunOrgNode(Integer.parseInt(parentDeptID));
		for(int i=0;i<nodes.size();i++){
			arrayJson=arrayJson+gson.toJson(nodes.get(i));
			if(i<nodes.size()-1 ){
				arrayJson=arrayJson+",";
			}
		}
		arrayJson = arrayJson+"]";
		return arrayJson;
		
	}
	
	public static String getShopSelectData(HttpServletRequest request) throws Exception{
		Gson gson = new Gson();
		List shops = OrgUtilDao.getShopSelectData(request.getParameter("dpmc"));
		return gson.toJson(shops);
	}	
	
	public static String getShopInfo (HttpServletRequest request) throws Exception{
		UserInfo userInfo =(UserInfo) request.getSession().getAttribute("user_info");
		Gson gson = new Gson(); 
		List shopInfos = OrgUtilDao.getShopInfo(request.getParameter("shopID"),userInfo);
		//System.out.println(gson.toJson(shopInfos));
		return gson.toJson(shopInfos);
	}
	
	public static String getEmployeeList(HttpServletRequest request)throws Exception{
		Gson gson = new Gson();
		List employeeList =  UserDao.getEmployeeList(request.getParameter("shopID"));
		return  gson.toJson(employeeList);
	}
	
	public static String getEmployeeTel(HttpServletRequest request)throws Exception{
		return UserDao.getEmployeeTel(request.getParameter("employeeID"));
	}
	
	public static String getVIPCustomerInfo(HttpServletRequest request)throws Exception{
		
		return UserDao.getVIPCustomerInfo(request.getParameter("vipCode"));
		
	}
	
	
	public static String executeProduce(HttpServletRequest request) throws Exception{
		
		return "1";
	}
	
	public static String isExsitClothingKH(HttpServletRequest request) throws Exception{
		return AjaxDao.isExsitClothingKH(request.getParameter("KH"));
	}
	
	
	//调整运单号
	public static String updateydh(HttpServletRequest request) throws Exception {
		String rinfo = "F";
		UserInfo userInfo =(UserInfo) request.getSession().getAttribute("user_info"); 
		String nydy = request.getParameter("nydh");
		String guid = request.getParameter("guid"); 
		CloMaintenanceDao cmd = new CloMaintenanceDao();
		if(cmd.updateydh(nydy,guid,userInfo)){
			rinfo =  "T"; 
		}
		return rinfo;
		
		
		
	}
}
