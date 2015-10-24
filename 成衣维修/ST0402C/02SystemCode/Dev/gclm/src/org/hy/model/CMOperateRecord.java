package org.hy.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * CMOperateRecord entity. @author MyEclipse Persistence Tools, catalog = "epapp"
 */
@Entity
@Table(name = "CYWXDJCZB", schema = "dbo")
public class CMOperateRecord implements java.io.Serializable {

	// Fields

	private String guid;
	private String zbguid;
	private String czy;
	private Timestamp czsj;
	private String czlx;
	private String czbm;
	private String czyxm;
	private String czbmmx;

	// Constructors

	/** default constructor */
	public CMOperateRecord() {
	}

	/** minimal constructor */
	public CMOperateRecord(String zbguid) {
		this.zbguid = zbguid;
	}

	/** full constructor */
	public CMOperateRecord(String zbguid, String czy, Timestamp czsj,
			String czlx, String czbm, String czyxm, String czbmmx) {
		this.zbguid = zbguid;
		this.czy = czy;
		this.czsj = czsj;
		this.czlx = czlx;
		this.czbm = czbm;
		this.czyxm = czyxm;
		this.czbmmx = czbmmx;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "GUID", unique = true, nullable = false, length = 32)
	public String getGuid() {
		return this.guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	@Column(name = "ZBGUID", nullable = false, length = 32)
	public String getZbguid() {
		return this.zbguid;
	}

	public void setZbguid(String zbguid) {
		this.zbguid = zbguid;
	}

	@Column(name = "CZY", length = 32)
	public String getCzy() {
		return this.czy;
	}

	public void setCzy(String czy) {
		this.czy = czy;
	}

	@Column(name = "CZSJ", length = 23)
	public Timestamp getCzsj() {
		return this.czsj;
	}

	public void setCzsj(Timestamp czsj) {
		this.czsj = czsj;
	}

	@Column(name = "CZLX", length = 2)
	public String getCzlx() {
		return this.czlx;
	}

	public void setCzlx(String czlx) {
		this.czlx = czlx;
	}

	@Column(name = "CZBM", length = 32)
	public String getCzbm() {
		return this.czbm;
	}

	public void setCzbm(String czbm) {
		this.czbm = czbm;
	}

	@Column(name = "CZYXM", length = 128)
	public String getCzyxm() {
		return this.czyxm;
	}

	public void setCzyxm(String czyxm) {
		this.czyxm = czyxm;
	}

	@Column(name = "CZBMMX", length = 128)
	public String getCzbmmx() {
		return this.czbmmx;
	}

	public void setCzbmmx(String czbmmx) {
		this.czbmmx = czbmmx;
	}

}