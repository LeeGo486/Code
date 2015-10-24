package org.hy.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * CMOperator entity. @author MyEclipse Persistence Tools    , catalog = "MDM"
 */
@Entity
@Table(name = "POSUser", schema = "dbo")
public class CMOperator implements java.io.Serializable {

	// Fields

	private String JUserid;
	private String JCom;
	private String JUsername;
	private String JPw;
	private String JDepotid;
	private String JNotes;

	// Constructors

	/** default constructor */
	public CMOperator() {
	}

	/** minimal constructor */
	public CMOperator(String JUserid) {
		this.JUserid = JUserid;
	}

	/** full constructor */
	public CMOperator(String JUserid, String JCom, String JUsername,
			String JPw, String JDepotid, String JNotes) {
		this.JUserid = JUserid;
		this.JCom = JCom;
		this.JUsername = JUsername;
		this.JPw = JPw;
		this.JDepotid = JDepotid;
		this.JNotes = JNotes;
	}

	// Property accessors
	@Id
	@Column(name = "J_USERID", nullable = false, length = 10)
	public String getJUserid() {
		return this.JUserid;
	}

	public void setJUserid(String JUserid) {
		this.JUserid = JUserid;
	}

	@Column(name = "J_COM", length = 10)
	public String getJCom() {
		return this.JCom;
	}

	public void setJCom(String JCom) {
		this.JCom = JCom;
	}

	@Column(name = "J_USERNAME", length = 12)
	public String getJUsername() {
		return this.JUsername;
	}

	public void setJUsername(String JUsername) {
		this.JUsername = JUsername;
	}

	@Column(name = "J_PW", length = 50)
	public String getJPw() {
		return this.JPw;
	}

	public void setJPw(String JPw) {
		this.JPw = JPw;
	}

	@Column(name = "J_DEPOTID", length = 8)
	public String getJDepotid() {
		return this.JDepotid;
	}

	public void setJDepotid(String JDepotid) {
		this.JDepotid = JDepotid;
	}

	@Column(name = "J_NOTES", length = 50)
	public String getJNotes() {
		return this.JNotes;
	}

	public void setJNotes(String JNotes) {
		this.JNotes = JNotes;
	}

}