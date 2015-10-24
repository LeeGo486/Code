package com.nh.model;


/**
 * JSupplier entity. @author MyEclipse Persistence Tools
 */

public class JSupplier implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -2396607533917456960L;
	private String supplierId;
	

	// Constructors

	/** default constructor */
	public JSupplier() {
	}

	/** minimal constructor */
	public JSupplier(String supplierId) {
		this.supplierId = supplierId;
	}


	// Property accessors

	public String getSupplierId() {
		return this.supplierId;
	}

	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}


}