package org.hy.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hy.dao.ITybmbDao;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.Tybmb;
import org.springframework.stereotype.Service;
@Service("tybmbDao")
public class TybmbDao extends BaseDaoSupport<Tybmb> implements ITybmbDao {
	public Tybmb getTybmbByID(String id) {
		return find(id);
	}
	
	
	
	public List<Tybmb> queryTybmb(String whereHql) {
		// TODO Auto-generated method stub
		Session session =  getSession(); 
		Query query = session.createQuery(whereHql);
		List<Tybmb> list = query.list();
		return list;
		
	}
	
}
