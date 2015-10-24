package org.hy.model;

public class UserInfo {
	private String userid;//用户ID
	private String username;//用户名
	private String password;//密码
	private String com;//公司
	private String brand;//品牌
	private String ssoSessionID;//单点登入sessionID
	
	public String getSsoSessionID() {
		return ssoSessionID;
	}
	public void setSsoSessionID(String ssoSessionID) {
		this.ssoSessionID = ssoSessionID;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCom() {
		return com;
	}
	public void setCom(String com) {
		this.com = com;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	
}
