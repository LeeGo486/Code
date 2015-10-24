package org.hy.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hy.beans.base.QueryResult;
import org.hy.dao.IJdepot;
import org.hy.dao.IYsgsxxb;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.Jdepot;
import org.hy.model.Ysgsxxb;
import org.hy.spring.CustomerContextHolder;
import org.hy.spring.DynamicDataSourceType;
import org.hy.util.QueryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Service;


@Service("ysgsDao")


public class YsgsxxbDaoImpl extends BaseDaoSupport<Ysgsxxb> implements IYsgsxxb {
	
	public QueryResult<Ysgsxxb> getYsgs() {
		//CustomerContextHolder.setCustomerType("x6test");
		return (QueryResult<Ysgsxxb>) super.getScrollData();
		 
	}

 
		

}
