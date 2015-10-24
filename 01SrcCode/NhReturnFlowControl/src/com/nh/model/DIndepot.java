package com.nh.model;

/**
 * DIndepot entity. @author MyEclipse Persistence Tools
 */

public class DIndepot implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -5873827516655887575L;
	
	private String indepotid;//入库单编号
	private String SupplierId;//供应商编号
	private String depotid;//收货仓库编号

	// Constructors

	public String getIndepotid() {
		return indepotid;
	}

	public void setIndepotid(String indepotid) {
		this.indepotid = indepotid;
	}


	public String getSupplierId() {
		return SupplierId;
	}

	public void setSupplierId(String supplierId) {
		SupplierId = supplierId;
	}

	public String getDepotid() {
		return depotid;
	}

	public void setDepotid(String depotid) {
		this.depotid = depotid;
	}

	/** default constructor */
	public DIndepot() {
	}

	


	
}