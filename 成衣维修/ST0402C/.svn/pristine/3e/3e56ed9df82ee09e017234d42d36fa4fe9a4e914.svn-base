package org.hy.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hy.SSO.mode.Menu;
import org.hy.SSO.mode.Role;
import org.hy.SSO.role.RoleService;
import org.hy.SSO.service.PubWSService;
import org.hy.SSO.service.WSService;
import org.hy.model.SystemInfo;
import org.hy.model.UserInfo;
import org.hy.util.SystemInfoUtil;
import org.hy.wsclient.SSO.login.LoginService;
import org.hy.wsclient.SSO.menu.MenuService;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionSupport;
@Namespace("/web")
@Results({
	     @Result(name = "success", location = "/cm/mainframe.jsp"),
	     @Result(name = "fail", location = "/cm/login.jsp"),
	     @Result(name = "input", location = "/cm/login.jsp")
	})
@Service
public class LoginAction extends ActionSupport {
	

	private UserInfo userInfo;
	
	
	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}
	
	private String logid;
	
	
	

	public String getLogid() {
		return logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

	public String login(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		//先做店铺人员还是总部人员的判断，如果是店铺人员，只给维修单登记操作，不提供其他权限，不需要做权限判断
		String loginType = request.getParameter("loginType");
		if(loginType!=null&&"dp".equals(loginType)){
			
		}
		
		
		if(null==userInfo){
			return "fail";
		}
		SystemInfo systemInfo = SystemInfoUtil.getSystemInfo();
		String sessionID = LoginService.ssoLogin(systemInfo.getEnv(), systemInfo.getLoginEnv(), userInfo.getUserid(), userInfo.getPassword());
		
		
		if(sessionID.startsWith("ERROR")){
			request.setAttribute("result","0");
			return "fail";
		}
		
		userInfo.setSsoSessionID(sessionID);
		
		
		Map map = new HashMap();
		map.put("SessionID", sessionID);
		try {
			System.out.println(PubWSService.callWSRR("5c968f16-c517-43b0-896d-93e3f231d50b", systemInfo.getEnv(), sessionID, map));
			List<Map> list = PubWSService.callWSRRToList("5c968f16-c517-43b0-896d-93e3f231d50b", systemInfo.getEnv(), sessionID, map);
			if(list!=null && list.size()>0){
				userInfo.setUsername((String) list.get(0).get("App_UserName_CN"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		List<Role> list = null;
		try {
			list = RoleService.getRoleList(systemInfo.getEnv(), sessionID);
		} catch (Exception e) {
			request.setAttribute("result","0");
			e.printStackTrace();
			return "fail";
		}
		

		if(list.size()==0){
			request.setAttribute("result","0");
			return "fail";
		}
		
		
		String com = "";
		Role role = null;
		for(int i=0;i<list.size();i++){
			role = list.get(i);
			if("公司".equals(role.getAuthorization_Name().split("-")[0])){
				com = com+","+role.getAuthorization_Name().split("-")[1];
			}
		}
		if(com.length()>1){
			com = com.substring(1);
			userInfo.setCom(com);
		}
		request.getSession().setAttribute("userInfo", userInfo);
		List<Menu> menuList = null;
		try {
			
			
			menuList = MenuService.getMenuList(systemInfo.getEnv(), sessionID,1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			request.setAttribute("result","0");
			e.printStackTrace();
			return "fail";
		}
		request.setAttribute("menuList", menuList);
		return "success";
	}

	public static void main(String[] arg0){
		String sessionID = LoginService.ssoLogin("HZY_CYWX","HZY_CYWX","1028","123456a");
		System.out.println(sessionID);
		
		Map map = new HashMap();
		map.put("SessionID", sessionID);
		try {
			List<Map> list = PubWSService.callWSRRToList("5c968f16-c517-43b0-896d-93e3f231d50b", "HZY_CYWX", sessionID, map);
			System.out.println(list.get(0).get("App_UserName_CN"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
