package org.hy.service.impl;

import java.util.LinkedHashMap;

import javax.annotation.Resource;

import org.hibernate.loader.hql.QueryLoader;
import org.hy.beans.base.QueryResult;
import org.hy.dao.ILogisticsDao;
import org.hy.model.Logistics;
import org.hy.service.ILogisticsService;
import org.springframework.stereotype.Service;

@Service("logisticsService")
public class LogisticsService implements ILogisticsService {
	@Resource(name="logisticsDao")
	private ILogisticsDao logisticsDao;

	public ILogisticsDao getLogisticsDao() {
		return logisticsDao;
	}

	public void setLogisticsDao(ILogisticsDao logisticsDao) {
		this.logisticsDao = logisticsDao;
	}
	
	public QueryResult<Logistics> getScrollData(int firstindex,int maxresult,String wherejpql,Object[] queryParams,LinkedHashMap<String, String> orderby){
		return logisticsDao.getScrollData(firstindex, maxresult, wherejpql, queryParams, orderby);
	}
	
	
	public QueryResult getScrollDataByNativeSql(final int firstindex, final int maxresult,String sql,final String wheresql,final LinkedHashMap<String, String> orderby){
		return logisticsDao.getScrollDataByNativeSql(firstindex, maxresult, sql,wheresql, orderby);
	}

	
	public QueryResult<Logistics> getScrollDataForField(final int firstindex, final int maxresult,final String selectField, final String wherejpql, final Object[] queryParams,
			final LinkedHashMap<String, String> orderby){
		return logisticsDao.getScrollDataForField(firstindex, maxresult, selectField, wherejpql, queryParams, orderby);
	}
	
}
