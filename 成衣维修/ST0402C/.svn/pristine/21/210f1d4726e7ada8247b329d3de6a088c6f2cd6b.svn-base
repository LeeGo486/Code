package org.hy.service.impl;

import org.hy.dao.IMaintainRegisterDao;
import org.hy.model.MaintainRegister;
import org.hy.service.ICMAppraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("CMAppraiseService")
public class CMAppraiseService implements ICMAppraiseService {
	@Autowired(required=false)
	@Qualifier("maintainRegisterDao")
	private IMaintainRegisterDao maintainRegisterDao;
	
	public IMaintainRegisterDao getMaintainRegisterDao() {
		return maintainRegisterDao;
	}

	public void setMaintainRegisterDao(IMaintainRegisterDao maintainRegisterDao) {
		this.maintainRegisterDao = maintainRegisterDao;
	}

	public MaintainRegister getAppraiseInfo(String id) {
		// TODO Auto-generated method stub
		return maintainRegisterDao.getMaintainRegisterByID(id);
	}

}
