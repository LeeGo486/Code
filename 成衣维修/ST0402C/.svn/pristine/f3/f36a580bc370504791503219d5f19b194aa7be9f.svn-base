package org.hy.resteasyservice;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;

import org.hy.model.LoginLog;
import org.hy.model.Role;
import org.hy.model.UserInfo;
import org.hy.service.ICMUserService;
import org.hy.spring.CustomerContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Path(value = "/rest")
@Service
public class CMUserRS {
	private Gson gson = new Gson();
	
	@Autowired(required=true)
	@Qualifier("CMUserService")
	private ICMUserService userService;

	public ICMUserService getUserService() {
		return userService;
	}

	public void setUserService(ICMUserService userService) {
		this.userService = userService;
	}
	/**
	 * 获取DRP系统的所有组织
	 * @return
	 */
	@POST
	@Path(value = "/DrpDept/get/all")
	public String getDrpDept(@Context HttpServletRequest request){
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType(userInfo.getCom());
		List list = userService.getDrpDept();
		return gson.toJson(list);
	}
	/**
	 * 根据组织获取该组织下的所有DRP用户
	 * @param usergroup
	 * @return
	 */
	@POST
	@Path(value = "/DrpUser/get/{usergroup}")
	public String getDrpUser(@PathParam(value = "usergroup") String usergroup,@Context HttpServletRequest request ){
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType(userInfo.getCom());
		List list = userService.getDrpUser(usergroup);
		return gson.toJson(list);
	}
	
	@POST
	@Path(value = "/DrpUser/get/usergroup")
	public void getDrpUser(@Context HttpServletRequest request,@Context HttpServletResponse response) throws IOException{
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType(userInfo.getCom());
		
		String usergroup = request.getParameter("usergroup");
		List list = userService.getDrpUser(usergroup);
		PrintWriter pwriter = response.getWriter();
		pwriter.print(gson.toJson(list));
		pwriter.close();
		//return gson.toJson(list);
	}
	
	@POST
	@Path(value = "/DrpUser/queryrole/{userid}")
	public String getRoleForUser(@PathParam(value = "userid") String userid,@Context HttpServletRequest request ){
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType("X6");
		List list = userService.getRoleForUser(userid);
		return gson.toJson(list);
	}
	
	@POST
	@Path(value = "/DrpUser/queryRoleNoGrant/{userid}")
	public String getRoleNoGrant(@PathParam(value = "userid") String userid,@Context HttpServletRequest request ){
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType("X6");
		List list = userService.getRoleNotGrant(userid);
		return gson.toJson(list);
	}
	
	@POST
	@Path(value = "/DrpUser/addRole/{userid}/{roleids}")
	public String addRoleForUser(@PathParam(value = "userid") String userid,@PathParam(value = "roleids") String roleids,@Context HttpServletRequest request){
		String roleGrant = request.getParameter("grant");
		Type type = new TypeToken<List<Role>>(){}.getType(); 
		List<Role> list = gson.fromJson(roleGrant, type);
		String[] roleidArray = new String[list.size()];
		for(int i=0;i<list.size();i++){
			roleidArray[i] = list.get(i).getRoleid().toString();		
		}
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType("X6");
		return userService.addRoleForUser(userid, roleidArray);
	}
	
	@POST
	@Path(value = "/DrpUser/delRole/{userid}")
	public String delRoleForUser(@PathParam(value = "userid") String userid,@Context HttpServletRequest request){
		String deleted = request.getParameter("deleted");
		Type type = new TypeToken<List<Role>>(){}.getType(); 
		HashMap map = new HashMap();
		List<Role> list = gson.fromJson(deleted, type);
		String[] roleidArray = new String[list.size()];
		for(int i=0;i<list.size();i++){
			roleidArray[i] = list.get(i).getRoleid().toString();
		}

		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType("X6");
		return userService.delRoleForUser(userid, roleidArray);
	}
	@POST
	@Path(value = "/User/getHistoryCom/{userid}")
	public void getHistoryCom(@PathParam(value = "userid") String userid,@Context HttpServletRequest request,@Context HttpServletResponse response) throws IOException{
		//CustomerContextHolder.setCustomerType("x6");
		LoginLog log = userService.getLoginLogByUserID(userid);
		String com = log.getCom();
		String logid = log.getGuid()==null?null: log.getGuid().toString();
		PrintWriter pwriter = response.getWriter();
		pwriter.print(com+","+logid);
		pwriter.close();
	}
	
	@GET
	@Path(value = "/userInfo/getUserInfo")
	public void getUser(@Context HttpServletRequest request,@Context HttpServletResponse response) throws IOException{
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
		Gson gson = new Gson();
		PrintWriter pwriter = response.getWriter();
		pwriter.print(gson.toJson(userInfo));
		pwriter.close();
	}

}
