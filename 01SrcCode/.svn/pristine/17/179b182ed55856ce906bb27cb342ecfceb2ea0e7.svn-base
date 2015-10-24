package com.nh.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.nh.dao.JSupplierNhDao;
import com.nh.model.JSupplierNh;
import com.nh.service.JSupplierNhService;

public class JSupplierNhServiceImpl implements JSupplierNhService {

	private JSupplierNhDao dao;

	public JSupplierNhDao getJSupplierNhDao() {
		return dao;
	}

	public void setJSupplierNhDao(JSupplierNhDao dao) {
		this.dao = dao;
	}
	

	public boolean isHadSupplier(String suppliesId){
		//System.out.println(suppliesId);
		//判断J_Supplier_nh 是否已经存在
		List<JSupplierNh> list = dao.queryBySupplierId(suppliesId);
		//取F22YY.dbo.J_Supplier 供应商编号
		//List list1 = dao.queryByJSupplierId(suppliesId);
		//System.out.println(list1.size());
		//if( null != list1 && list1.size()>0){
			//System.out.println(list);
			if ( list.size()==0){
				JSupplierNh jSupplierNh = new JSupplierNh();
				jSupplierNh.setSuppliesId(suppliesId);
				dao.save(jSupplierNh);
				return true;
			}
			else{
				return false;
			}	
		//}
		//else{	
			//return false;
		//}
		
	}
	

	public List<JSupplierNh> getSuppliers(){
		List<JSupplierNh> list = new ArrayList<JSupplierNh>();
		list = dao.getSuppliers();
		return list;
	}
	
	//
	public boolean delete(String suppliesId){
		List<JSupplierNh> list = dao.queryBySupplierId(suppliesId);
		if (null!=list&&list.size()>0){
			dao.delete(list.get(0));
		}
		return true;
		
	}
}
