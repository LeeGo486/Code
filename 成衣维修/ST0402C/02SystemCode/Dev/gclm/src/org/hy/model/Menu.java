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
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * CMMenu entity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@Entity
@Table(name = "CM_MENU", schema = "dbo")
public class Menu implements java.io.Serializable {

	// Fields

	private Integer menuid;
	private String menuname;
	private String parentGuid;
	private String menuLevel;
	private String actionUrl;
	private Set<Role> roles = new HashSet<Role>(0);

	// Constructors

	/** default constructor */
	public Menu() {
	}

	/** minimal constructor */
	public Menu(Integer menuid) {
		this.menuid = menuid;
	}

	/** full constructor */
	public Menu(Integer menuid, String menuname, String parentGuid,
			String menuLevel, String actionUrl, Set<Role> roles) {
		this.menuid = menuid;
		this.menuname = menuname;
		this.parentGuid = parentGuid;
		this.menuLevel = menuLevel;
		this.actionUrl = actionUrl;
		this.roles = roles;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	@Column(name = "menuid", unique = true, nullable = false)
	public Integer getMenuid() {
		return this.menuid;
	}

	public void setMenuid(Integer menuid) {
		this.menuid = menuid;
	}

	@Column(name = "menuname", length = 64)
	public String getMenuname() {
		return this.menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	@Column(name = "parent_guid", length = 40)
	public String getParentGuid() {
		return this.parentGuid;
	}

	public void setParentGuid(String parentGuid) {
		this.parentGuid = parentGuid;
	}

	@Column(name = "menu_level", length = 2)
	public String getMenuLevel() {
		return this.menuLevel;
	}

	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}

	@Column(name = "action_url", length = 128)
	public String getActionUrl() {
		return this.actionUrl;
	}

	public void setActionUrl(String actionUrl) {
		this.actionUrl = actionUrl;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "CMMenus")
	public Set<Role> getRoles() {
		return this.roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

}