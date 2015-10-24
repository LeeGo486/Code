package org.hy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 *J_DEPO Tentity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "PPWXCDYB", schema = "dbo")
public class Ppwxcdyb implements java.io.Serializable {

	// Fields
	private String pp;
	private String dplx;
	private String wxcbm;
	private String wxcmc;
	 

	// Constructors
	
	
	/** default constructor */
	public Ppwxcdyb() {
	}
	 
	
	@Id
	@Column(name = "PP", unique = true, nullable = false, length = 32)
	public String getPp() {
		return this.pp;
	}
	
	public void setPp(String pp) {
		this.pp = pp;
	}
	
	@Column(name = "dplx", nullable = false, length = 32)
	public String getDplx() {
		return this.dplx;
	}
	
	public void setDplx(String dplx) {
		this.dplx = dplx;
	}
	
	

	@Column(name = "WXCBM", nullable = false, length = 32)
	public String getWxcbm() {
		return wxcbm;
	}

	public void setWxcbm(String wxcbm) {
		this.wxcbm = wxcbm;
	}

	@Column(name = "WXCMC", nullable = false, length = 32)
	public String getWxcmc() {
		return wxcmc;
	}

	public void setWxcmc(String wxcmc) {
		this.wxcmc = wxcmc;
	}

/*	@Override
	public String toString()
	{
		return "CYWXDJB [dh=" + dh + ", dpbm=" + dpbm +  "]";
	}
*/
}