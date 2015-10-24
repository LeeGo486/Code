package org.hy.service.impl;

import java.util.List;

import org.hy.dao.ICMMenuDao;
import org.hy.model.UserInfo;
import org.hy.service.ICMMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
@Service("CMMenuService")
public class CMMenuService implements ICMMenuService {
	@Autowired(required=true)
	@Qualifier("CMMMenuDao")
	private ICMMenuDao dao;
	
	
	public ICMMenuDao getDao() {
		return dao;
	}


	public void setDao(ICMMenuDao dao) {
		this.dao = dao;
	}


	public List queryMenuNotGrant(String id) {
		// TODO Auto-generated method stub
		return dao.queryMenuNotGrant(id);
	}
	public List queryMenuByUserID(UserInfo userInfo){
		return dao.queryMenuByUserID(userInfo);
	}
	
	public List queryMenuByRoleID(UserInfo userInfo,String roleID){
		return dao.queryMenuByRoleID(userInfo, roleID);
	}
}
