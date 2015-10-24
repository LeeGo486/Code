package com.nh.action;

import java.util.List;

import com.nh.model.JSupplierNh;
import com.nh.service.JSupplierNhService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class JSupplierAction extends ActionSupport implements
		ModelDriven<Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6328557316235812100L;

	private JSupplierNh jSupplierNh = new JSupplierNh();
	private List<JSupplierNh> list;
	
	public List<JSupplierNh> getList() {
		return list;
	}

	public void setList(List<JSupplierNh> list) {
		this.list = list;
	}

	public JSupplierNh getModel() {
		// TODO Auto-generated method stub
		return jSupplierNh;
	}
	
	private JSupplierNhService service;

	public JSupplierNhService getJSupplierNhService() {
		return service;
	}

	public void setJSupplierNhService(JSupplierNhService service) {
		this.service = service;
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		System.out.println(" execute()");
		return SUCCESS;
	}
	

	public String supplierSave()throws Exception {
	/*	HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("list",service.getSuppliers());*/
		
		if (jSupplierNh.getSuppliesId().equals("")){
			this.addFieldError("msg", "供应商编号不能为空!");
			return SUCCESS;
		}
		else {
			
			if(service.isHadSupplier(jSupplierNh.getSuppliesId())){
				this.addFieldError("msg", "添加成功!");
				this.list = service.getSuppliers();
				return SUCCESS;
			}
			else{
				this.list = service.getSuppliers();
				this.addFieldError("msg", "供应商编号已经存在！");
				return SUCCESS;
			}
			
		}
	}
	
	public String listSupplier() throws Exception{
		/*HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("list",service.getSuppliers());*/	
		this.list = service.getSuppliers();
		return SUCCESS;
	}
	
	public String deleteSupplier() throws Exception{
		//System.out.println(jSupplierNh.getSuppliesId());
		
		service.delete(jSupplierNh.getSuppliesId());
		/*HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("list",service.getSuppliers());*/
		this.list = service.getSuppliers();
		return SUCCESS;
	}
	

}
