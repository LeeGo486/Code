package org.hy.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hy.dao.ICMOperateRecordDAO;
import org.hy.model.CMOperateRecord;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;
/**
 * 成衣维修操作日志数据库访问类
 * @author yuxiaodong
 *
 */

@Service("cmOperateRecordDao")
public class CMOperateRecordDao extends HibernateDaoSupport implements ICMOperateRecordDAO {

	
	


	/**
	 * 根据传入的主表（成衣维修登记表）主键获取操作日志数据集
	 * @param guid
	 * @return List
	 */
	
	public List<CMOperateRecord> queryCMOperateRecord(String guid,int beginPage,int pageSize) {
		// TODO Auto-generated method stub
		
		Session session =  getSession();
		Query query = session.createQuery(" from CMOperateRecord as cm where cm.zbguid = '"+guid+"'");
		query.setFirstResult(beginPage);
		query.setMaxResults(pageSize);
		List<CMOperateRecord>  recordList = query.list();
		return recordList;
	}

	
	
}
