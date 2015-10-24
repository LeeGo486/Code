package org.hy.resteasyservice;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;

import org.hy.model.Menu;
import org.hy.model.Role;
import org.hy.model.UserInfo;
import org.hy.service.ICMMenuService;
import org.hy.service.ICMRoleManageService;
import org.hy.spring.CustomerContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
@Path(value = "/rest")
@Service
public class CMRoleManageRs {
	
	private Gson gson = new Gson();
	
	@Autowired(required=true)
	@Qualifier("CMRoleManageService")
	private ICMRoleManageService cmRoleManageService;

	public ICMRoleManageService getCmRoleManageService() {
		return cmRoleManageService;
	}

	public void setCmRoleManageService(ICMRoleManageService cmRoleManageService) {
		this.cmRoleManageService = cmRoleManageService;
	}
	
	@Autowired(required=true)
	@Qualifier("CMMenuService")
	private ICMMenuService menuService;
	
	
	public ICMMenuService getMenuService() {
		return menuService;
	}

	public void setMenuService(ICMMenuService menuService) {
		this.menuService = menuService;
	}

	/**
	 * 获取所有角色信息
	 * @param request
	 * @return json
	 */
	@POST
	@Path(value = "/queryRole/all")
	public String queryRole(@Context HttpServletRequest request){
		int pageIndex = Integer.parseInt((request.getParameter("page")));
		int pageSize = Integer.parseInt((request.getParameter("rows")));
		//CustomerContextHolder.setCustomerType("x6");
		List<Role> list = cmRoleManageService.queryRole((pageIndex-1)*pageSize,pageSize);
		List list1 = new ArrayList();
		Role role;
		for(int i=0;i<list.size();i++){
			role = new Role();
			role.setRoleid(((Role)list.get(i)).getRoleid());
			role.setRolename(((Role)list.get(i)).getRolename());
			role.setRoledesc(((Role)list.get(i)).getRoledesc());
			list1.add(role);
		}
		//Role role = list.get(0);
		//System.out.println(role.getCMMenus());
		String json ="{\"total\":"+cmRoleManageService.getRoleSize()+", \"rows\":"+ gson.toJson(list1)+"}";
		//System.out.println(json);
		return json;
	}
	
	/**
	 * 根据角色名模糊查询角色信息
	 * @param rolename
	 * @param request
	 * @return json
	 */
	@POST
	@Path(value = "/queryRole/name/{rolename}")
	public String queryRoleByName(@PathParam(value = "rolename") String rolename,@Context HttpServletRequest request){
		int pageIndex = Integer.parseInt((request.getParameter("page")));
		int pageSize = Integer.parseInt((request.getParameter("rows")));
		//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
		//CustomerContextHolder.setCustomerType("x6");
		List<Role> list = cmRoleManageService.getRoleByRoleName(rolename, (pageIndex-1)*pageSize,pageSize);
		List list1 = new ArrayList();
		Role role;
		for(int i=0;i<list.size();i++){
			role = new Role();
			role.setRoleid(((Role)list.get(i)).getRoleid());
			role.setRolename(((Role)list.get(i)).getRolename());
			role.setRoledesc(((Role)list.get(i)).getRoledesc());
			list1.add(role);
		}
		
		
		String json = "{\"total\":"+cmRoleManageService.getRoleSizeByRoleName(rolename)+", \"rows\":"+gson.toJson(list1)+"}";
		return json;
	}
	
	/**
	 * 根据角色ID获取菜单列表
	 * @param roleid
	 * @return json
	 */
	@POST
	@Path(value = "/queryMenu/id/{roleid}")
	public String queryMenuByRoleID(@PathParam(value = "roleid") String roleid,@Context HttpServletRequest request){
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType("x6");
		List list = menuService.queryMenuByRoleID(userInfo, roleid);
		return gson.toJson(list);
	}

	@POST
	@Path(value = "/roleChange")
	public void saveChangeRoles(@Context HttpServletRequest request,@Context HttpServletResponse response) throws IOException{
		String deleted = request.getParameter("deleted");
		String inserted = request.getParameter("inserted");
		String updated = request.getParameter("updated");
		
		Type type = new TypeToken<List<Role>>(){}.getType(); 
		HashMap map = new HashMap();
		List<Role> list = gson.fromJson(inserted, type);
		map.put("inserted", list);
		list = gson.fromJson(updated, type);


		list = gson.fromJson(deleted, type);
		map.put("deleted", list);
		//CustomerContextHolder.setCustomerType("x6");
		String rs = cmRoleManageService.saveRole(map);
		
		
		PrintWriter pwriter = response.getWriter();
		if("1".equals(rs)){
			pwriter.print("01");
		}else{
			pwriter.print("00");
		}
		
		pwriter.close();
	}
	
	
	@POST
	@Path(value = "/queryMenu/notGrant/id/{roleid}")
	public String queryMenuNotGrant(@PathParam(value = "roleid") String roleid){
		//CustomerContextHolder.setCustomerType("x6");
		return gson.toJson( menuService.queryMenuNotGrant(roleid));
	}
	
	@POST
	@Path(value = "/addMenu/id/{roleid}/{menuids}")
	public String addMenuForRole(@PathParam(value = "roleid") String roleid,@PathParam(value = "menuids") String menuids,@Context HttpServletRequest request){
		String menuGrant = request.getParameter("grant");
		Type type = new TypeToken<List<Menu>>(){}.getType(); 
		List<Menu> list = gson.fromJson(menuGrant, type);
		String[] menuIDArray = new String[list.size()];
		for(int i=0;i<list.size();i++){
			menuIDArray[i] = list.get(i).getMenuid().toString();		
		}
		//CustomerContextHolder.setCustomerType("x6");
		return cmRoleManageService.addMenuForRole(roleid, menuIDArray);
	}
	
	@POST
	@Path(value = "/delMenu/id/{roleid}")
	public String delMenuForRole(@PathParam(value = "roleid") String roleid,@Context HttpServletRequest request){
		String deleted = request.getParameter("deleted");
		Type type = new TypeToken<List<Menu>>(){}.getType(); 
		List<Menu> list = gson.fromJson(deleted, type);
		String[] menuids = new String[list.size()];
		for(int i=0;i<list.size();i++){
			menuids[i] = list.get(i).getMenuid().toString();		
		}
		//CustomerContextHolder.setCustomerType("x6");
		return cmRoleManageService.delMenuForRole(roleid, menuids);
	}
	
	public static void main(String[] arg0){
		Map map = new HashMap();
		if(map.get("1")!=null){
			System.out.println("kong");
		}
	}
}