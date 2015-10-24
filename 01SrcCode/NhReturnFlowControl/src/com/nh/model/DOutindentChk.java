package com.nh.model;

/**
 * DOutindentChk entity. @author MyEclipse Persistence Tools
 */

public class DOutindentChk implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -204814112043736269L;
	private String outindentid;//退货审批单编号
	private String outindent;//自编号
	private String quotaid;//申请单号

	// Constructors

	/** default constructor */
	public DOutindentChk() {
	}

	

	// Property accessors

	public String getOutindentid() {
		return this.outindentid;
	}

	public void setOutindentid(String outindentid) {
		this.outindentid = outindentid;
	}

	public String getOutindent() {
		return this.outindent;
	}

	public void setOutindent(String outindent) {
		this.outindent = outindent;
	}

	public String getQuotaid() {
		return this.quotaid;
	}

	public void setQuotaid(String quotaid) {
		this.quotaid = quotaid;
	}

	
}