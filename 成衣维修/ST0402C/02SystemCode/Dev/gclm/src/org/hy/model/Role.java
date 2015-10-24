package org.hy.model;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * Role entity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@Entity
@Table(name = "CM_ROLE", schema = "dbo")
public class Role implements java.io.Serializable {

	// Fields

	private Integer roleid;
	private String rolename;
	private String roledesc;
	private Set<Menu> CMMenus = new HashSet<Menu>(0);

	// Constructors

	/** default constructor */
	public Role() {
	}

	/** minimal constructor */
	public Role(Integer roleid) {
		this.roleid = roleid;
	}

	/** full constructor */
	public Role(Integer roleid, String rolename, String roledesc,
			Set<Menu> CMMenus) {
		this.roleid = roleid;
		this.rolename = rolename;
		this.roledesc = roledesc;
		this.CMMenus = CMMenus;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	@Column(name = "roleid", unique = true, nullable = false)
	public Integer getRoleid() {
		return this.roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}

	@Column(name = "rolename", length = 128)
	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	@Column(name = "roledesc", length = 128)
	public String getRoledesc() {
		return this.roledesc;
	}

	public void setRoledesc(String roledesc) {
		this.roledesc = roledesc;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "CM_REL_ROLEMENU", schema = "dbo",  joinColumns = { @JoinColumn(name = "roleid", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "menuid", nullable = false, updatable = false) })
	public Set<Menu> getCMMenus() {		//catalog = "epapp",
		return this.CMMenus;
	}

	public void setCMMenus(Set<Menu> CMMenus) {
		this.CMMenus = CMMenus;
	}

}