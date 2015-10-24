package org.hy.dao;

import java.util.List;
import java.util.Map;

import org.hy.model.Role;

public interface ICMRoleDao {
	/**
	 * 获取分页数据集
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> queryRoleList(int beginPage,int pageSize);
	/**
	 * 获取结果集大小
	 * @return int
	 */
	public int getRoleSize();
	/**
	 * 根据ID获取Role
	 * @param roleID
	 * @return List
	 */
	public List<Role> getRoleByID(String roleID);
	
	/**
	 * 根据传入的角色名称模糊查询Role
	 * @param roleName
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> getRoleByName(String roleName,int beginPage,int  pageSize);
	/**
	 * 根据传入的角色名称模糊查询Role结果集大大小
	 * @param roleName
	 * @return int
	 */
	public int getRoleSizeByName(String roleName);
	
	public String saveRole(Map map);
	
	public String addMenuForRole(String roleID,String[] menuIDArray);
	
	public String delMenuForRole(String roleID,String[] menuIDArray);
}

