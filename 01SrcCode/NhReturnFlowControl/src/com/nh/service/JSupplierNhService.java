package com.nh.service;

import java.util.List;

import com.nh.model.JSupplierNh;


public interface JSupplierNhService {

	public boolean isHadSupplier(String suppliesId);
	
	public List<JSupplierNh> getSuppliers();
	
	public boolean delete(String suppliesId);
}
