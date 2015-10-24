package org.hy.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * Ysgsxxb entity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "YSGSXXB", schema = "dbo")
public class Ysgsxxb implements java.io.Serializable {

	// Fields

	private String bm;
	private String mc;
	private String lxdh;
	private String lxr;
	private Integer jybs;
	private String sx;
	private String createPerson;
	private Timestamp createTime;
	private String updatePerson;
	private Timestamp updateTime;

	// Constructors

	/** default constructor */
	public Ysgsxxb() {
	}

	/** full constructor */
	public Ysgsxxb(String mc, String lxdh, String lxr, Integer jybs, String sx,
			String createPerson, Timestamp createTime, String updatePerson,
			Timestamp updateTime) {
		this.mc = mc;
		this.lxdh = lxdh;
		this.lxr = lxr;
		this.jybs = jybs;
		this.sx = sx;
		this.createPerson = createPerson;
		this.createTime = createTime;
		this.updatePerson = updatePerson;
		this.updateTime = updateTime;
	}

	// Property accessors
	@Id
	@Column(name = "BM", unique = true, nullable = false, length = 32)
	public String getBm() {
		return this.bm;
	}

	public void setBm(String bm) {
		this.bm = bm;
	}

	@Column(name = "MC", length = 32)
	public String getMc() {
		return this.mc;
	}

	public void setMc(String mc) {
		this.mc = mc;
	}

	@Column(name = "LXDH", length = 32)
	public String getLxdh() {
		return this.lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	@Column(name = "LXR", length = 20)
	public String getLxr() {
		return this.lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	@Column(name = "JYBS")
	public Integer getJybs() {
		return this.jybs;
	}

	public void setJybs(Integer jybs) {
		this.jybs = jybs;
	}

	@Column(name = "SX", length = 4)
	public String getSx() {
		return this.sx;
	}

	public void setSx(String sx) {
		this.sx = sx;
	}

	@Column(name = "CreatePerson", length = 10)
	public String getCreatePerson() {
		return this.createPerson;
	}

	public void setCreatePerson(String createPerson) {
		this.createPerson = createPerson;
	}

	@Column(name = "CreateTime", length = 23)
	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	@Column(name = "UpdatePerson", length = 10)
	public String getUpdatePerson() {
		return this.updatePerson;
	}

	public void setUpdatePerson(String updatePerson) {
		this.updatePerson = updatePerson;
	}

	@Column(name = "UpdateTime", length = 23)
	public Timestamp getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

}