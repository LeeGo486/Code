package org.hy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * LoginLog entity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@Entity
@Table(name = "CM_LOGINLOG", schema = "dbo")
public class LoginLog implements java.io.Serializable {

	// Fields

	private Integer guid;
	private String userid;
	private String com;

	// Constructors

	/** default constructor */
	public LoginLog() {
	}

	/** minimal constructor */
	public LoginLog(String userid) {
		this.userid = userid;
	}

	/** full constructor */
	public LoginLog(String userid, String com) {
		this.userid = userid;
		this.com = com;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "guid", unique = true, nullable = false)
	public Integer getGuid() {
		return this.guid;
	}

	public void setGuid(Integer guid) {
		this.guid = guid;
	}

	@Column(name = "userid", nullable = false, length = 50)
	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "com", length = 50)
	public String getCom() {
		return this.com;
	}

	public void setCom(String com) {
		this.com = com;
	}

}