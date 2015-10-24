package org.hy.service.impl;

import java.util.List;

import org.hy.dao.ICMOperatorDao;
import org.hy.model.LoginLog;
import org.hy.model.UserInfo;
import org.hy.service.ICMUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("CMUserService")
public class CMUserService implements ICMUserService {
	
	@Autowired(required=true)
	@Qualifier("cmOperatorDao")
	private ICMOperatorDao cmOperatorDao;

	public ICMOperatorDao getCmOperatorDao() {
		return cmOperatorDao;
	}

	public void setCmOperatorDao(ICMOperatorDao cmOperatorDao) {
		this.cmOperatorDao = cmOperatorDao;
	}
	
	
	public List getDrpDept(){
		return cmOperatorDao.getDrpDept();
	}
	
	public List getDrpUser(String usergroup){
		return cmOperatorDao.getDrpUser(usergroup);
	}

	public List getRoleForUser(String userid) {
		// TODO Auto-generated method stub
		return cmOperatorDao.getRoleForUser(userid);
	}

	public List getRoleNotGrant(String userid) {
		// TODO Auto-generated method stub
		return cmOperatorDao.getRoleNotGrant(userid);
	}

	public String addRoleForUser(String userid, String[] roleids) {
		// TODO Auto-generated method stub
		return cmOperatorDao.addRoleForUser(userid, roleids);
	}

	public String delRoleForUser(String userid, String[] roleids) {
		// TODO Auto-generated method stub
		return cmOperatorDao.delRoleForUser(userid, roleids);
	}
	
	public UserInfo getCurrentUser(String userid,String password){
		return cmOperatorDao.getCurrentUser(userid, password);
	}
	
	public List getMenuListForUser(String userid){
		return cmOperatorDao.getMenuListForUser(userid);
	}
	
	public LoginLog getLoginLogByUserID(String userid){
		return cmOperatorDao.getLoginLogByUserID(userid);
	}
	
	public void saveLoginLog(LoginLog loginLog){
		 cmOperatorDao.saveLoginLog(loginLog);
	}
	
	public String  addOperator(UserInfo userInfo){
		return cmOperatorDao.addOperator(userInfo);
	}
}
