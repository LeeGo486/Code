package org.hy.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hy.dao.ITypzbDao;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.Typzb;
import org.springframework.stereotype.Service;

@Service("typzbDao")
public class TypzbDao extends BaseDaoSupport<Typzb> implements ITypzbDao {

	public Typzb getTypzbByID(String id) {
		return find(id);
	}
	
	
	
	public List<Typzb> queryTypzb(String whereHql) {
		// TODO Auto-generated method stub
		Session session =  getSession(); 
		Query query = session.createQuery(whereHql);
		List<Typzb> list = query.list();
		return list;
		
	}
	

}
