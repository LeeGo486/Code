package org.hy.service;

import java.util.List;

import org.hy.dao.base.IBaseDao;
import org.hy.model.CMOperateRecord;
import org.hy.model.MaintainRegister;

/**
 * 成衣维修登记表操作日志服务接口类
 * @author yuxiaodong
 *
 */
public interface ICMOperateRecordService  extends IBaseDao<CMOperateRecord>{
	/**
	 * 根据传入的主表（成衣维修登记表）主键获取操作日志数据
	 * @param guid
	 * @return List
	 */
	public List<CMOperateRecord>  queryCMOperateRecord(String guid,int beginPage,int pageSize);
}
