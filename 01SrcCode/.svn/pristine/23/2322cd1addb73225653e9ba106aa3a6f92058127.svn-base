package com.nh.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nh.dao.JSupplierNhDao;
import com.nh.model.JSupplier;
import com.nh.model.JSupplierNh;

public class JSupplierNhDaoImpl extends HibernateDaoSupport implements
		JSupplierNhDao {
	
	//��ݹ�Ӧ�̱�Ų���
	public List<JSupplierNh> queryBySupplierId(String suppliesId){	
		return getHibernateTemplate().find(" from JSupplierNh where suppliesId='"+suppliesId+"'");
	}

	//������߸���
	public void save(JSupplierNh jSupplierNh){
		getHibernateTemplate().saveOrUpdate(jSupplierNh);
	}
	
	//��ȡ���й�Ӧ�̱��
	public List<JSupplierNh> getSuppliers(){
		return getHibernateTemplate().find(" from JSupplierNh order by suppliesId desc ");
	}
	
	//ɾ��
	public void delete(JSupplierNh jSupplierNh){
		getHibernateTemplate().delete(jSupplierNh);
	}
	
	public List queryByJSupplierId(String suppliesId){
		return getHibernateTemplate().find(" select a.supplierId from JSupplier a where a.supplierId=? ",suppliesId);
	}
}
