package org.hy.model;

public class ClothingInfo {
	
	private String styleID;
	private String Colorid;
	private String Sizeid;
	private int setNum;
	private float j_cost;
	private float j_price;
	private float x_price;
	private float s_price;
	private float discount;
	public String getStyleID() {
		return styleID;
	}
	public void setStyleID(String styleID) {
		this.styleID = styleID;
	}
	public String getColorid() {
		return Colorid;
	}
	public void setColorid(String colorid) {
		Colorid = colorid;
	}
	public String getSizeid() {
		return Sizeid;
	}
	public void setSizeid(String sizeid) {
		Sizeid = sizeid;
	}
	public int getSetNum() {
		return setNum;
	}
	public void setSetNum(int setNum) {
		this.setNum = setNum;
	}
	public float getJ_cost() {
		return j_cost;
	}
	public void setJ_cost(float j_cost) {
		this.j_cost = j_cost;
	}
	public float getJ_price() {
		return j_price;
	}
	public void setJ_price(float j_price) {
		this.j_price = j_price;
	}
	public float getX_price() {
		return x_price;
	}
	public void setX_price(float x_price) {
		this.x_price = x_price;
	}
	public float getS_price() {
		return s_price;
	}
	public void setS_price(float s_price) {
		this.s_price = s_price;
	}
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	
	
}
