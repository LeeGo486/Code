package com.nh.model;

/**
 * DIndepotsubId entity. @author MyEclipse Persistence Tools
 */

public class DIndepotsubId implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -7782016523914251112L;
	private DIndepot DIndepot;
	private String boxid;
	private String clothingid;//款号

	// Constructors

	/** default constructor */
	public DIndepotsubId() {
	}

	/** full constructor */
	public DIndepotsubId(DIndepot DIndepot, String boxid, String clothingid) {
		this.DIndepot = DIndepot;
		this.boxid = boxid;
		this.clothingid = clothingid;
	}

	// Property accessors

	public DIndepot getDIndepot() {
		return this.DIndepot;
	}

	public void setDIndepot(DIndepot DIndepot) {
		this.DIndepot = DIndepot;
	}

	public String getBoxid() {
		return this.boxid;
	}

	public void setBoxid(String boxid) {
		this.boxid = boxid;
	}

	public String getClothingid() {
		return this.clothingid;
	}

	public void setClothingid(String clothingid) {
		this.clothingid = clothingid;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof DIndepotsubId))
			return false;
		DIndepotsubId castOther = (DIndepotsubId) other;

		return ((this.getDIndepot() == castOther.getDIndepot()) || (this
				.getDIndepot() != null
				&& castOther.getDIndepot() != null && this.getDIndepot()
				.equals(castOther.getDIndepot())))
				&& ((this.getBoxid() == castOther.getBoxid()) || (this
						.getBoxid() != null
						&& castOther.getBoxid() != null && this.getBoxid()
						.equals(castOther.getBoxid())))
				&& ((this.getClothingid() == castOther.getClothingid()) || (this
						.getClothingid() != null
						&& castOther.getClothingid() != null && this
						.getClothingid().equals(castOther.getClothingid())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getDIndepot() == null ? 0 : this.getDIndepot().hashCode());
		result = 37 * result
				+ (getBoxid() == null ? 0 : this.getBoxid().hashCode());
		result = 37
				* result
				+ (getClothingid() == null ? 0 : this.getClothingid()
						.hashCode());
		return result;
	}

}