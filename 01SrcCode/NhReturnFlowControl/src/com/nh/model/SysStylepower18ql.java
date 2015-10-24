package com.nh.model;

import java.sql.Timestamp;

/**
 * SysStylepower18ql entity. @author MyEclipse Persistence Tools
 */

public class SysStylepower18ql implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 8712148157592177818L;
	private SysStylepower18qlId id;
	private Boolean selection;
	private Boolean access;
	private String comment;
	private Timestamp crdate;
	private String updatetime;
	private String struc1;
	private String struc2;
	private String struc3;
	private String struc4;
	private String SName;

	// Constructors

	/** default constructor */
	public SysStylepower18ql() {
	}

	/** minimal constructor */
	public SysStylepower18ql(SysStylepower18qlId id) {
		this.id = id;
	}

	/** full constructor */
	public SysStylepower18ql(SysStylepower18qlId id, Boolean selection,
			Boolean access, String comment, Timestamp crdate,
			String updatetime, String struc1, String struc2, String struc3,
			String struc4, String SName) {
		this.id = id;
		this.selection = selection;
		this.access = access;
		this.comment = comment;
		this.crdate = crdate;
		this.updatetime = updatetime;
		this.struc1 = struc1;
		this.struc2 = struc2;
		this.struc3 = struc3;
		this.struc4 = struc4;
		this.SName = SName;
	}

	// Property accessors

	public SysStylepower18qlId getId() {
		return this.id;
	}

	public void setId(SysStylepower18qlId id) {
		this.id = id;
	}

	public Boolean getSelection() {
		return this.selection;
	}

	public void setSelection(Boolean selection) {
		this.selection = selection;
	}

	public Boolean getAccess() {
		return this.access;
	}

	public void setAccess(Boolean access) {
		this.access = access;
	}

	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Timestamp getCrdate() {
		return this.crdate;
	}

	public void setCrdate(Timestamp crdate) {
		this.crdate = crdate;
	}

	public String getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public String getStruc1() {
		return this.struc1;
	}

	public void setStruc1(String struc1) {
		this.struc1 = struc1;
	}

	public String getStruc2() {
		return this.struc2;
	}

	public void setStruc2(String struc2) {
		this.struc2 = struc2;
	}

	public String getStruc3() {
		return this.struc3;
	}

	public void setStruc3(String struc3) {
		this.struc3 = struc3;
	}

	public String getStruc4() {
		return this.struc4;
	}

	public void setStruc4(String struc4) {
		this.struc4 = struc4;
	}

	public String getSName() {
		return this.SName;
	}

	public void setSName(String SName) {
		this.SName = SName;
	}

}