package org.hy.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionSupport;


@Namespace("/web")
@Results({
	    @Result(name = "success", location = "/cm/login.jsp")
	})
@Service
public class LogoutAction extends ActionSupport {
	public String logout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.getSession().invalidate();
		return "success";
	}
}
