package com.nh.model;

/**
 * DOutindentChksubId entity. @author MyEclipse Persistence Tools
 */

public class DOutindentChksubId implements java.io.Serializable {

	// Fields

	private DOutindentChk DOutindentChk;
	private String boxid;
	private String clothingid;

	// Constructors

	/** default constructor */
	public DOutindentChksubId() {
	}

	/** full constructor */
	public DOutindentChksubId(DOutindentChk DOutindentChk, String boxid,
			String clothingid) {
		this.DOutindentChk = DOutindentChk;
		this.boxid = boxid;
		this.clothingid = clothingid;
	}

	// Property accessors

	public DOutindentChk getDOutindentChk() {
		return this.DOutindentChk;
	}

	public void setDOutindentChk(DOutindentChk DOutindentChk) {
		this.DOutindentChk = DOutindentChk;
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
		if (!(other instanceof DOutindentChksubId))
			return false;
		DOutindentChksubId castOther = (DOutindentChksubId) other;

		return ((this.getDOutindentChk() == castOther.getDOutindentChk()) || (this
				.getDOutindentChk() != null
				&& castOther.getDOutindentChk() != null && this
				.getDOutindentChk().equals(castOther.getDOutindentChk())))
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

		result = 37
				* result
				+ (getDOutindentChk() == null ? 0 : this.getDOutindentChk()
						.hashCode());
		result = 37 * result
				+ (getBoxid() == null ? 0 : this.getBoxid().hashCode());
		result = 37
				* result
				+ (getClothingid() == null ? 0 : this.getClothingid()
						.hashCode());
		return result;
	}

}