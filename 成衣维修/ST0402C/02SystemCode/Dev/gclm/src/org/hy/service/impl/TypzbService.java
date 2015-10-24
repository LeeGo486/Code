package org.hy.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hy.dao.ITypzbDao;
import org.hy.model.Typzb;
import org.hy.service.ITypzbService;
import org.springframework.stereotype.Service;

@Service("typzbService")
public class TypzbService implements ITypzbService {
	@Resource(name="typzbDao")
	private ITypzbDao typzbDao;
	
	
	public ITypzbDao getTypzbDao() {
		return typzbDao;
	}

	public void setTypzbDao(ITypzbDao typzbDao) {
		this.typzbDao = typzbDao;
	}

	public List<Typzb> queryTypzb(String whereJPQL) {
		// TODO Auto-generated method stub
		return typzbDao.queryTypzb(whereJPQL);
	}

	public void saveEntity(Typzb entity) {
		// TODO Auto-generated method stub
		typzbDao.save(entity);
	}

	public void deleteEntityByID(String guid) {
		// TODO Auto-generated method stub
		typzbDao.deleteByID(guid);
	}

	public void updateEntity(Typzb entity) {
		// TODO Auto-generated method stub
		typzbDao.update(entity);
	}

}
