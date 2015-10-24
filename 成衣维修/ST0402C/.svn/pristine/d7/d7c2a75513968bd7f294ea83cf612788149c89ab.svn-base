package org.hy.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import org.hy.model.Menu;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/web")
@Results({
	    @Result(name = "toMainFrame", location = "/cm/mainframe.jsp")
	})
public class CmMainFrameAction extends ActionSupport {
	
	public List list1;
	

	public List getList1() {
		return list1;
	}


	public void setList1(List list1) {
		this.list1 = list1;
	}


	public String initFrame(){
	
		list1 = new ArrayList();
		Menu menu = new Menu();
		menu.setMenuname("test1");
		menu.setActionUrl("http://baidu.com");
	
		list1.add(menu);
		
		menu = new Menu(); 
		menu.setMenuname("test2");
		menu.setActionUrl("http://www.sina.cn");
		
		list1.add(menu);
		
	
		
		return "toMainFrame";
	}
}
