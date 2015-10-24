package org.hy.dao;

import java.util.List;

import org.hy.beans.base.QueryResult;
import org.hy.dao.base.IBaseDao;
import org.hy.model.Jdepot;
import org.hy.model.Ysgsxxb;
import org.hy.util.QueryBean;

public interface IYsgsxxb extends IBaseDao<Ysgsxxb>{


	public QueryResult<Ysgsxxb> getYsgs();
	

}
