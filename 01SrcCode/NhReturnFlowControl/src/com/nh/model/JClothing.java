package com.nh.model;

import java.sql.Timestamp;

/**
 * JClothing entity. @author MyEclipse Persistence Tools
 */

public class JClothing implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1581342462050520174L;
	private String clothingid;//款号
	private String JStyle;//款式编号
	private String colorid;//颜色编号
	private String sizeid;//尺码编号
	private Double JCost;//成本价
	private Double JPrice;//零售原价
	private Double XPrice;//零售现价
	private Double pjPrice;//发货原价
	private Double pxPrice;//发货现价
	private Timestamp crdate;
	private String oldclothingid;//旧货号

	// Constructors

	/** default constructor */
	public JClothing() {
	}

	/** minimal constructor */
	public JClothing(String clothingid) {
		this.clothingid = clothingid;
	}


	// Property accessors

	public String getClothingid() {
		return this.clothingid;
	}

	public void setClothingid(String clothingid) {
		this.clothingid = clothingid;
	}

	public String getJStyle() {
		return this.JStyle;
	}

	public void setJStyle(String JStyle) {
		this.JStyle = JStyle;
	}

	public String getColorid() {
		return this.colorid;
	}

	public void setColorid(String colorid) {
		this.colorid = colorid;
	}

	public String getSizeid() {
		return this.sizeid;
	}

	public void setSizeid(String sizeid) {
		this.sizeid = sizeid;
	}

	public Double getJCost() {
		return this.JCost;
	}

	public void setJCost(Double JCost) {
		this.JCost = JCost;
	}

	public Double getJPrice() {
		return this.JPrice;
	}

	public void setJPrice(Double JPrice) {
		this.JPrice = JPrice;
	}

	public Double getXPrice() {
		return this.XPrice;
	}

	public void setXPrice(Double XPrice) {
		this.XPrice = XPrice;
	}

	public Double getPjPrice() {
		return this.pjPrice;
	}

	public void setPjPrice(Double pjPrice) {
		this.pjPrice = pjPrice;
	}

	public Double getPxPrice() {
		return this.pxPrice;
	}

	public void setPxPrice(Double pxPrice) {
		this.pxPrice = pxPrice;
	}

	public Timestamp getCrdate() {
		return this.crdate;
	}

	public void setCrdate(Timestamp crdate) {
		this.crdate = crdate;
	}


	public String getOldclothingid() {
		return this.oldclothingid;
	}

	public void setOldclothingid(String oldclothingid) {
		this.oldclothingid = oldclothingid;
	}

}