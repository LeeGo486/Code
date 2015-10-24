package org.hy.util;

public class QueryBean {
	

	//问题点   起因
	private String fcode;
	private String fscope;
	private String fcontent;
	
	// 受理导购
	private String employeeid;
	private String names;
	private String telephone;
	
	private String bh;
	private String mc;
	private  int sx;
	
	//店铺查询条件
	private String depotid;
	private String dname;
	
	public String getBh() {
		return bh;
	}
	public void setBh(String bh) {
		this.bh = bh;
	}
	public String getMc() {
		return mc;
	}
	public void setMc(String mc) {
		this.mc = mc;
	}
	public int getSx() {
		return sx;
	}
	public void setSx(int sx) {
		this.sx = sx;
	}
	public String getDepotid() {
		return depotid;
	}
	public void setDepotid(String depotid) {
		this.depotid = depotid;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getNames() {
		return names;
	}
	public void setNames(String names) {
		this.names = names;
	}
	public String getEmployeeid() {
		return employeeid;
	}
	public void setEmployeeid(String employeeid) {
		this.employeeid = employeeid;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getFcontent() {
		return fcontent;
	}
	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}
	public String getFcode() {
		return fcode;
	}
	public void setFcode(String fcode) {
		this.fcode = fcode;
	}
	public String getFscope() {
		return fscope;
	}
	public void setFscope(String fscope) {
		this.fscope = fscope;
	}

}
