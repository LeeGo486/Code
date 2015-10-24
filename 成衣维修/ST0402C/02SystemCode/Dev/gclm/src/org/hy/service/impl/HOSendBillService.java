package org.hy.service.impl;


import org.hy.dao.ICMOperatorDao;
import org.hy.dao.IMaintainRegisterDao;
import org.hy.model.CMOperator;
import org.hy.model.MaintainRegister;
import org.hy.service.IHOSendBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
@Service("HOSendBillService")
public class HOSendBillService implements IHOSendBillService {
	@Autowired(required=false)
	@Qualifier("maintainRegisterDao")
	private IMaintainRegisterDao maintainRegisterDao;
	
	@Autowired(required=false)
	@Qualifier("cmOperatorDao")
	private ICMOperatorDao cmOperatorDao;
	
	public IMaintainRegisterDao getMaintainRegisterDao() {
		return maintainRegisterDao;
	}

	public void setMaintainRegisterDao(IMaintainRegisterDao maintainRegisterDao) {
		this.maintainRegisterDao = maintainRegisterDao;
	}

	public ICMOperatorDao getCmOperatorDao() {
		return cmOperatorDao;
	}

	public void setCmOperatorDao(ICMOperatorDao cmOperatorDao) {
		this.cmOperatorDao = cmOperatorDao;
	}

	public Object[] getHOSendBillInfos(String id) {
		// TODO Auto-generated method stub
		
		MaintainRegister mr =  maintainRegisterDao.getMaintainRegisterByID(id);
		//CMOperator cmOperator = cmOperatorDao.getCMOperator(mr.getZbfhBzr());
		return new Object[]{mr};
	}
	
	public String getOperatorNamebyID(String id){
		return cmOperatorDao.getOperatorNamebyID(id);
	}
}
