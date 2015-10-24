package ep.org.clothingmaintenance.bean;
/**
  @description: 记录用户信息
  @author: 俞晓东
  @version：1.00
  @date：2012-7-11 下午02:29:24
 */

public class UserInfo {
	private String userID;//POSUSER用户登录
	private String loginDeptID;// 用户部门（即店铺）
	private String userName;//用户名称
	private String pwd;//密码
	private String com;//分公司
	private String deptName;//不忙名称
	private String sessionID; //sessionID
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public String getLoginDeptID() {
		return loginDeptID;
	}
	public void setLoginDeptID(String loginDeptID) {
		this.loginDeptID = loginDeptID;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getCom() {
		return com;
	}
	public void setCom(String com) {
		this.com = com;
	}
	public String getSessionID() {
		return sessionID;
	}
	public void setSessionID(String sessionID) {
		this.sessionID = sessionID;
	}
	
	
}
