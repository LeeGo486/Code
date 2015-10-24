package org.hy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hy.dao.ITybmbDao;
import org.hy.model.Tybmb;
import org.hy.model.Typzb;
import org.hy.service.ITybmbService;
import org.springframework.stereotype.Service;

@Service("tybmbService")
public class TybmbService implements ITybmbService {
	
	@Resource(name="tybmbDao")
	private ITybmbDao tybmbDao;
	
	
	public ITybmbDao getTybmbDao() {
		return tybmbDao;
	}

	public void setTybmbDao(ITybmbDao tybmbDao) {
		this.tybmbDao = tybmbDao;
	}

	public List<Tybmb> queryTybmb(String whereJPQL) {
		// TODO Auto-generated method stub
		return tybmbDao.queryTybmb(whereJPQL);
	}

	public void saveEntity(Tybmb entity) {
		// TODO Auto-generated method stub
		tybmbDao.save(entity);
	}

	public void deleteEntityByID(String guid) {
		// TODO Auto-generated method stub
		tybmbDao.deleteByID(guid);
	}

	public void updateEntity(Tybmb entity) {
		// TODO Auto-generated method stub
		tybmbDao.update(entity);
	}

}
