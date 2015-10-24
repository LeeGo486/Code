package org.hy.service.impl;

import java.util.List;



import org.hy.dao.ICMOperateRecordDAO;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.CMOperateRecord;
import org.hy.model.MaintainRegister;
import org.hy.service.ICMOperateRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * 成衣维修登记表操作日志服务实现类
 * @author yuxiaodong
 *
 */

@Service("cmOperateRecordService")
public class CMOperateRecordService extends BaseDaoSupport<CMOperateRecord> implements ICMOperateRecordService  {

	@Autowired(required=false)
	@Qualifier("cmOperateRecordDao")
	
	private ICMOperateRecordDAO operateRecordDAO;
	
	
	public ICMOperateRecordDAO getOperateRecordDAO() {
		return operateRecordDAO;
	}


	public void setOperateRecordDAO(ICMOperateRecordDAO operateRecordDAO) {
		this.operateRecordDAO = operateRecordDAO;
	}


	/**
	 * 根据传入的主表（成衣维修登记表）主键获取操作日志数据
	 * @param guid
	 * @return List
	 */
	public List<CMOperateRecord> queryCMOperateRecord(String guid,int beginPage,int pageSize) {
		// TODO Auto-generated method stub
		//return operateRecordDAO.queryCMOperateRecord(guid, 0, 0);
		return operateRecordDAO.queryCMOperateRecord(guid,beginPage,pageSize);

	}

}
