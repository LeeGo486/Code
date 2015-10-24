package org.hy.dao;

import java.util.List;

import org.hy.model.UserInfo;

public interface ICMMenuDao {
	public List queryMenuNotGrant(String id);
	public List queryMenuByUserID(UserInfo userInfo);
	public List queryMenuByRoleID(UserInfo userInfo,String roleID);
}
