package ep.org.clothingmaintenance.form;


/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午03:38:29
 */

public class MaintenanceInfoListSelfForm extends CloMaintenanceSelfForm {
	private String isShop;//
	private String czlx;
	private String operateBgnDate;
	private String operateEndDate;
	private String judgeBgnDate;
	private String advancedCondition="0";
	public String getIsShop() {
		return isShop;
	}
	public void setIsShop(String isShop) {
		this.isShop = isShop;
	}
	public String getCzlx() {
		return czlx;
	}
	public void setCzlx(String czlx) {
		this.czlx = czlx;
	}
	public String getOperateBgnDate() {
		return operateBgnDate;
	}
	public void setOperateBgnDate(String operateBgnDate) {
		this.operateBgnDate = operateBgnDate;
	}
	public String getOperateEndDate() {
		return operateEndDate;
	}
	public void setOperateEndDate(String operateEndDate) {
		this.operateEndDate = operateEndDate;
	}
	public String getJudgeBgnDate() {
		return judgeBgnDate;
	}
	public void setJudgeBgnDate(String judgeBgnDate) {
		this.judgeBgnDate = judgeBgnDate;
	}
	public String getAdvancedCondition() {
		return advancedCondition;
	}
	public void setAdvancedCondition(String advancedCondition) {
		this.advancedCondition = advancedCondition;
	}
	
}
