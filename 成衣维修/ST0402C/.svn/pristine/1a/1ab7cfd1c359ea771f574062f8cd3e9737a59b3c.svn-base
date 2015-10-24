package org.hy.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hy.model.Menu;
import org.hy.model.Role;

public interface ICMRoleManageService {
	/**
	 * 分页查询角色
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> queryRole(int beginPage,int  pageSize);
	
	
	/**
	 * 根据角色ID获取Menu结果集
	 * @param roleID
	 * @return Set
	 */
	public Set<Menu> queryMenuByRoleID(String roleID);
	
	
	/**
	 * 根据角色名称分页查询角色
	 * @param roleName
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> getRoleByRoleName(String roleName,int beginPage,int  pageSize);
	
	/**
	 * 根据角色名获取角色结果集大小
	 * @param roleName
	 * @return int
	 */
	public int getRoleSizeByRoleName(String roleNam);
	
	
	/**
	 * 获取角色结果集大小
	 * @return int
	 */
	public int getRoleSize();
	
	public String saveRole(Map map);
	
	public String addMenuForRole(String roleID,String[] menuIDArray);
	
	public String delMenuForRole(String roleID,String[] menuIDArray);
}
