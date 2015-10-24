package com.nh.model;

/**
 * SysStylepower18qlId entity. @author MyEclipse Persistence Tools
 */

public class SysStylepower18qlId implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 4759824779002218455L;
	private String JUser;
	private String JStyle;

	// Constructors

	/** default constructor */
	public SysStylepower18qlId() {
	}

	// Property accessors

	public String getJUser() {
		return this.JUser;
	}

	public void setJUser(String JUser) {
		this.JUser = JUser;
	}

	public String getJStyle() {
		return this.JStyle;
	}

	public void setJStyle(String JStyle) {
		this.JStyle = JStyle;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SysStylepower18qlId))
			return false;
		SysStylepower18qlId castOther = (SysStylepower18qlId) other;

		return ((this.getJUser() == castOther.getJUser()) || (this.getJUser() != null
				&& castOther.getJUser() != null && this.getJUser().equals(
				castOther.getJUser())))
				&& ((this.getJStyle() == castOther.getJStyle()) || (this
						.getJStyle() != null
						&& castOther.getJStyle() != null && this.getJStyle()
						.equals(castOther.getJStyle())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getJUser() == null ? 0 : this.getJUser().hashCode());
		result = 37 * result
				+ (getJStyle() == null ? 0 : this.getJStyle().hashCode());
		return result;
	}

}