package org.hy.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hy.model.CMOperator;
import org.hy.model.MaintainRegister;
import org.hy.model.UserInfo;
import org.hy.service.IHOSendBillService;
import org.hy.spring.CustomerContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionSupport;

@Namespace("/web")
@Results({
	    @Result(name = "showHOSendBill", location = "/cm/headOfficeSendBill.jsp")
	})
@Service
public class HeadOfficeSendBillAction extends ActionSupport {
	@Autowired(required=false)
	@Qualifier("HOSendBillService")
	private IHOSendBillService hoSendBillService;

	public IHOSendBillService getHoSendBillService() {
		return hoSendBillService;
	}

	public void setHoSendBillService(IHOSendBillService hoSendBillService) {
		this.hoSendBillService = hoSendBillService;
	}
	
	private MaintainRegister maintainRegister;
	private CMOperator cmOperator;

	public MaintainRegister getMaintainRegister() {
		return maintainRegister;
	}

	public void setMaintainRegister(MaintainRegister maintainRegister) {
		this.maintainRegister = maintainRegister;
	}

	public CMOperator getCmOperator() {
		return cmOperator;
	}

	public void setCmOperator(CMOperator cmOperator) {
		this.cmOperator = cmOperator;
	}
	
	private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	private String makeDate;
	
	
	public String getMakeDate() {
		return makeDate;
	}

	public void setMakeDate(String makeDate) {
		this.makeDate = makeDate;
	}

	public String showHOSendBill(){

		Object[] objs = hoSendBillService.getHOSendBillInfos(id);
		maintainRegister = (MaintainRegister) objs[0];

		HttpServletRequest request = ServletActionContext.getRequest();
		//UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
		//CustomerContextHolder.setCustomerType(userInfo.getCom());
		
		String operatorName = hoSendBillService.getOperatorNamebyID(maintainRegister.getZbfhBzr());
		if(operatorName!=null && !operatorName.equals("")){
			maintainRegister.setZbfhBzr(operatorName);
		}
		return "showHOSendBill";
	}
}
