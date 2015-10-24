package org.hy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "CYWXWLB", schema = "dbo")
public class Logistics {
	private String guid;
	private String zbguid;
	private String wxdh;
	private String ydh;
	private String js;
	private String fhsj;
	private String shsj;
	private String zt;
	private String czguid;
	private String remark;
	private String wlgs;
	private String fhdp;
	
	@Id
	@Column(name = "GUID", unique = true, nullable = false, length = 64)
	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	
	@Column(name = "ZBGUID")
	public String getZbguid() {
		return zbguid;
	}
	public void setZbguid(String zbguid) {
		this.zbguid = zbguid;
	}
	
	@Column(name = "WXDH")
	public String getWxdh() {
		return wxdh;
	}
	public void setWxdh(String wxdh) {
		this.wxdh = wxdh;
	}
	
	@Column(name = "YDH")
	public String getYdh() {
		return ydh;
	}
	public void setYdh(String ydh) {
		this.ydh = ydh;
	}
	
	@Column(name = "JS")
	public String getJs() {
		return js;
	}
	public void setJs(String js) {
		this.js = js;
	}
	
	@Column(name = "FHSJ")
	public String getFhsj() {
		return fhsj;
	}
	public void setFhsj(String fhsj) {
		this.fhsj = fhsj;
	}
	
	@Column(name = "SHSJ")
	public String getShsj() {
		return shsj;
	}
	public void setShsj(String shsj) {
		this.shsj = shsj;
	}
	
	@Column(name = "ZT")
	public String getZt() {
		return zt;
	}
	public void setZt(String zt) {
		this.zt = zt;
	}
	
	@Column(name = "CZGUID")
	public String getCzguid() {
		return czguid;
	}
	public void setCzguid(String czguid) {
		this.czguid = czguid;
	}
	
	@Column(name = "Remark")
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Column(name = "WLGS")
	public String getWlgs() {
		return wlgs;
	}
	public void setWlgs(String wlgs) {
		this.wlgs = wlgs;
	}
	
	@Column(name = "FHDP")
	public String getFhdp() {
		return fhdp;
	}
	public void setFhdp(String fhdp) {
		this.fhdp = fhdp;
	}
	
	
	
}
