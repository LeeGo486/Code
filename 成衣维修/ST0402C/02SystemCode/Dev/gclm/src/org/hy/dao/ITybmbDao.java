package org.hy.dao;

import java.util.List;

import org.hy.dao.base.IBaseDao;
import org.hy.model.Tybmb;

public interface ITybmbDao extends IBaseDao<Tybmb> {
	public Tybmb getTybmbByID(String id);
	public List<Tybmb> queryTybmb(String whereSql);
}
