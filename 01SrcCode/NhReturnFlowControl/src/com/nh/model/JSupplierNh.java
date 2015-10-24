package com.nh.model;

/**
 * JSupplierNh entity. @author MyEclipse Persistence Tools
 */

public class JSupplierNh implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 6835153498229855736L;
	private String suppliesId;

	// Constructors

	/** default constructor */
	public JSupplierNh() {
	}

	/** full constructor */
	public JSupplierNh(String suppliesId) {
		this.suppliesId = suppliesId;
	}

	// Property accessors

	public String getSuppliesId() {
		return this.suppliesId;
	}

	public void setSuppliesId(String suppliesId) {
		this.suppliesId = suppliesId;
	}

}