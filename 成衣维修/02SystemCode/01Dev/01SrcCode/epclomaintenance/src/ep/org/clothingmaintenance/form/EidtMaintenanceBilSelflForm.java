package ep.org.clothingmaintenance.form;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午03:37:23
 */

public class EidtMaintenanceBilSelflForm extends CloMaintenanceSelfForm {
	private String dpTypeName;
	private String dpTypeCode;
	private String isSaveFlag;
	private String picGuid;
	private String ztTypeName="登记";
	private String sldgCode;
	private String picms;
	private String saveState;
	public String getDpTypeName() {
		return dpTypeName;
	}
	public void setDpTypeName(String dpTypeName) {
		this.dpTypeName = dpTypeName;
	}
	public String getDpTypeCode() {
		return dpTypeCode;
	}
	public void setDpTypeCode(String dpTypeCode) {
		this.dpTypeCode = dpTypeCode;
	}

	public String getIsSaveFlag() {
		return isSaveFlag;
	}
	public void setIsSaveFlag(String isSaveFlag) {
		this.isSaveFlag = isSaveFlag;
	}
	public String getPicGuid() {
		return picGuid;
	}
	public void setPicGuid(String picGuid) {
		this.picGuid = picGuid;
	}
	public String getZtTypeName() {
		return ztTypeName;
	}
	public void setZtTypeName(String ztTypeName) {
		this.ztTypeName = ztTypeName;
	}
	public String getSldgCode() {
		return sldgCode;
	}
	public void setSldgCode(String sldgCode) {
		this.sldgCode = sldgCode;
	}
	public String getPicms() {
		return picms;
	}
	public void setPicms(String picms) {
		this.picms = picms;
	}
	public String getSaveState() {
		return saveState;
	}
	public void setSaveState(String saveState) {
		this.saveState = saveState;
	}
	
	
}
