package org.hy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 *J_DEPO Tentity. @author MyEclipse Persistence Tools, catalog = "F22test"
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "J_DEPOT", schema = "dbo")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE) 
public class Jdepot implements java.io.Serializable {

	// Fields

	private String depotid;
	private String dname;
	private String areaid;
	private String r_name;
	private String Tel;
	private String m_type;
	private String address;
	private String d_dq;
	private String d_dd;
	private String d_lx;
	private String brandid;
  

	// Constructors
	
	
	/** default constructor */
	public Jdepot() {
	}
	
	/** minimal constructor */
	public Jdepot(String depotid) {
		this.depotid = depotid;
	}
	
	/** full constructor */
	public Jdepot(String depotid, String dname) {
		this.depotid = depotid;
		this.dname = dname;
	}
	
	@Id
	@Column(name = "depotid", unique = true, nullable = false, length = 32)
	public String getDepotid() {
		return this.depotid;
	}
	
	public void setDepotid(String depotid) {
		this.depotid = depotid;
	}
	
	@Column(name = "d_name", nullable = false, length = 32)
	public String getDname() {
		return this.dname;
	}
	
	public void setDname(String dname) {
		this.dname = dname;
	}
	
	

	@Column(name = "areaid", nullable = false, length = 32)
	public String getAreaid() {
		return areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}

	@Column(name = "r_name", nullable = false, length = 32)
	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	@Column(name = "Tel", nullable = false, length = 32)
	public String getTel() {
		return Tel;
	}

	public void setTel(String tel) {
		Tel = tel;
	}

	@Column(name = "m_type", nullable = false, length = 32)
	public String getM_type() {
		return m_type;
	}

	public void setM_type(String m_type) {
		this.m_type = m_type;
	}

	@Column(name = "address", nullable = false, length = 32)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "d_dq", nullable = false, length = 32)
	public String getD_dq() {
		return d_dq;
	}

	public void setD_dq(String d_dq) {
		this.d_dq = d_dq;
	}

	@Column(name = "d_dd", nullable = false, length = 32)
	public String getD_dd() {
		return d_dd;
	}

	public void setD_dd(String d_dd) {
		this.d_dd = d_dd;
	}

	@Column(name = "d_lx", nullable = false, length = 32)
	public String getD_lx() {
		return d_lx;
	}

	public void setD_lx(String d_lx) {
		this.d_lx = d_lx;
	}

	@Column(name = "brandid", nullable = false, length = 32)
	public String getBrandid() {
		return brandid;
	}

	public void setBrandid(String brandid) {
		this.brandid = brandid;
	}
	
/*	@Override
	public String toString()
	{
		return "CYWXDJB [dh=" + dh + ", dpbm=" + dpbm +  "]";
	}
*/
}