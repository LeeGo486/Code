package com.nh.model;

/**
 * DOutindentSetsubId entity. @author MyEclipse Persistence Tools
 */

public class DOutindentSetsubId implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3002799786080553895L;
	private DOutindentSet DOutindentSet;//退货发货单编号
	private String boxid;//箱号
	private String clothingid;//款号

	// Constructors

	/** default constructor */
	public DOutindentSetsubId() {
	}

	/** full constructor */
	public DOutindentSetsubId(DOutindentSet DOutindentSet, String boxid,
			String clothingid) {
		this.DOutindentSet = DOutindentSet;
		this.boxid = boxid;
		this.clothingid = clothingid;
	}

	// Property accessors

	public DOutindentSet getDOutindentSet() {
		return this.DOutindentSet;
	}

	public void setDOutindentSet(DOutindentSet DOutindentSet) {
		this.DOutindentSet = DOutindentSet;
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
		if (!(other instanceof DOutindentSetsubId))
			return false;
		DOutindentSetsubId castOther = (DOutindentSetsubId) other;

		return ((this.getDOutindentSet() == castOther.getDOutindentSet()) || (this
				.getDOutindentSet() != null
				&& castOther.getDOutindentSet() != null && this
				.getDOutindentSet().equals(castOther.getDOutindentSet())))
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
				+ (getDOutindentSet() == null ? 0 : this.getDOutindentSet()
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