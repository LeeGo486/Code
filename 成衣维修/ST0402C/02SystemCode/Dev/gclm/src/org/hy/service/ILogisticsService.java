package org.hy.service;

import java.util.LinkedHashMap;

import org.hy.beans.base.QueryResult;
import org.hy.model.Logistics;



public interface ILogisticsService {
	public QueryResult<Logistics> getScrollData(int firstindex,int maxresult,String wherejpql,Object[] queryParams,LinkedHashMap<String, String> orderby);

	/**
	 *  根据本地SQL查询分页数据
	 * @param firstindex
	 * @param maxresult
	 * @param sql
	 * @param wheresql
	 * @param orderby
	 * @return
	 */
	public QueryResult getScrollDataByNativeSql(final int firstindex, final int maxresult,String sql,final String wheresql,final LinkedHashMap<String, String> orderby);
		

	
	public QueryResult<Logistics> getScrollDataForField(final int firstindex, final int maxresult,final String selectField, final String wherejpql, final Object[] queryParams,
			final LinkedHashMap<String, String> orderby);

	
}
