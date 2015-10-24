package ep.org.clothingmaintenance.form;
/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午03:40:56
 */

public class ViewMaintenanceBillSelfForm extends CloMaintenanceSelfForm{
	private String ztTypeName;
	private String dpTypeName;
	private String dpTypeCode;
	public String getZtTypeName() {
		return ztTypeName;
	}
	public void setZtTypeName(String ztTypeName) {
		this.ztTypeName = ztTypeName;
	}
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
	
}
