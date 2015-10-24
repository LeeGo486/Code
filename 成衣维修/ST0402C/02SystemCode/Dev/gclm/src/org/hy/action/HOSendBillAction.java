package org.hy.action;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hy.model.CMOperator;
import org.hy.model.MaintainRegister;
import org.hy.service.IHOSendBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionSupport;

@Namespace("/web")
@Results({
	    @Result(name = "showHOSendBill", location = "/cm/headOfficeSendBill.jsp")
	})
@Service
public class HOSendBillAction extends ActionSupport {
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

	public String showHOSendBill(){
		
		Object[] objs = hoSendBillService.getHOSendBillInfos(id);
		maintainRegister = (MaintainRegister) objs[0];
		cmOperator = (CMOperator) objs[1];
		return "showHOSendBill";
	}
}
