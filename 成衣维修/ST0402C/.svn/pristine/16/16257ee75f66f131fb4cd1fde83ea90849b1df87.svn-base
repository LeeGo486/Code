package org.hy.dao;

import java.util.List;

import org.hy.model.CMOperator;
import org.hy.model.LoginLog;
import org.hy.model.UserInfo;

public interface ICMOperatorDao {
	
	
	public CMOperator getCMOperator(String userid);
	
	public List getDrpDept();
	
	public List getDrpUser(String usergroup);
	
	public List getRoleForUser(String userid);
	
	public List getRoleNotGrant(String userid);
	
	public String addRoleForUser(String userid,String[] roleids);
	
	public String delRoleForUser(String userid,String[] roleids);
	
	public UserInfo getCurrentUser(String userid,String password);
	
	public List getMenuListForUser(String userid);
	
	public String getOperatorNamebyID(String id);
	
	public LoginLog getLoginLogByUserID(String userid);
	
	public void saveLoginLog(LoginLog loginLog);
	
	public String addOperator(UserInfo userInfo);
}
