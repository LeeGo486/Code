package org.hy.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hy.model.AppraiseRadio;
import org.hy.model.MaintainRegister;
import org.hy.service.ICMAppraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionSupport;
@Namespace("/web")
@Results({
	    @Result(name = "viewAppraise", location = "/cm/cmAppraiseView.jsp")
	})
@Service
public class AppraiseViewAction extends ActionSupport {
	
	@Autowired(required=false)
	@Qualifier("CMAppraiseService")
	private ICMAppraiseService cmAppraiseService;
	private MaintainRegister maintainRegister;
	private String id;
	public ICMAppraiseService getCmAppraiseService() {
		return cmAppraiseService;
	}
	public void setCmAppraiseService(ICMAppraiseService cmAppraiseService) {
		this.cmAppraiseService = cmAppraiseService;
	}
	public MaintainRegister getMaintainRegister() {
		return maintainRegister;
	}
	public void setMaintainRegister(MaintainRegister maintainRegister) {
		this.maintainRegister = maintainRegister;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getAppraiseInfo(){
		
		
		maintainRegister = cmAppraiseService.getAppraiseInfo(id);
		//maintainRegister = new MaintainRegister();
		//maintainRegister.setDppj(0);
		//maintainRegister.setGkpj(1);
		
		ArrayList list = new ArrayList();
		/*HashMap map = new HashMap();
		map.put("key", "好评");
		map.put("value", "0");
		list.add(map);
		
		map = new HashMap();
		map.put("key", "中评");
		map.put("value", "1");
		list.add(map);
		
		map = new HashMap();
		map.put("key", "差评");
		map.put("value", "2");
		list.add(map);*/
		AppraiseRadio ar = new AppraiseRadio();
		ar.setRadioCode("0");
		ar.setRadioName("好评");
		list.add(ar);
		
		ar = new AppraiseRadio();
		ar.setRadioCode("1");
		ar.setRadioName("中评");
		list.add(ar);
		
		ar = new AppraiseRadio();
		ar.setRadioCode("2");
		ar.setRadioName("差评");
		list.add(ar);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("appraiseList", list);
		return "viewAppraise";
	}
}
