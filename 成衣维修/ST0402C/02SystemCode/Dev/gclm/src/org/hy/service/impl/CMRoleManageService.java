package org.hy.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import org.hy.dao.ICMRoleDao;
import org.hy.model.Menu;
import org.hy.model.Role;
import org.hy.service.ICMRoleManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("CMRoleManageService")
public class CMRoleManageService implements ICMRoleManageService{
	@Autowired(required=true)
	@Qualifier("roleDao")
	private ICMRoleDao CMRoleDao;
	
	
	public ICMRoleDao getCMRoleDao() {
		return CMRoleDao;
	}


	public void setCMRoleDao(ICMRoleDao cMRoleDao) {
		CMRoleDao = cMRoleDao;
	}


	/**
	 * 分页查询角色
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> queryRole(int beginPage,int  pageSize){
		return CMRoleDao.queryRoleList(beginPage, pageSize);
	}
	
	/**
	 * 根据角色ID获取Menu结果集
	 * @param roleID
	 * @return Set
	 */
	public Set<Menu> queryMenuByRoleID(String roleID){
		List<Role> roleList = CMRoleDao.getRoleByID(roleID);
		if(roleList.size()>0){
			Role role = roleList.get(0);
			return role.getCMMenus();
		}
		return new HashSet<Menu>();
	}
	
	/**
	 * 根据角色名称分页查询角色
	 * @param roleName
	 * @param beginPage
	 * @param pageSize
	 * @return List
	 */
	public List<Role> getRoleByRoleName(String roleName,int beginPage,int  pageSize){
		return CMRoleDao.getRoleByName(roleName,beginPage,pageSize);
	}
	
	/**
	 * 根据角色名获取角色结果集大小
	 * @param roleName
	 * @return int
	 */
	public int getRoleSizeByRoleName(String roleName){
		return CMRoleDao.getRoleSizeByName(roleName);
	}
	
	/**
	 * 获取角色结果集大小
	 * @return int
	 */
	public int getRoleSize(){
		return CMRoleDao.getRoleSize();
	}

	public String saveRole(Map map){
		return CMRoleDao.saveRole(map);
	};
	
	public String addMenuForRole(String roleID,String[] menuIDArray){
		return CMRoleDao.addMenuForRole(roleID, menuIDArray);
	}
	
	public String delMenuForRole(String roleID,String[] menuIDArray){
		return CMRoleDao.delMenuForRole(roleID, menuIDArray);
	}
}
