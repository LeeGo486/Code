package org.hy.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hy.model.ClothingInfo;
import org.hy.model.MaintainRegister;
import org.hy.model.Ppwxcdyb;
import org.hy.model.UserInfo;
import org.hy.util.QueryBean;
import org.springframework.orm.hibernate3.HibernateCallback;

public interface IMaintainRegisterDao {
//www
	public MaintainRegister getMaintainRegisterByID(String id);
	
	public List filterZt(String sql);

	public List<Ppwxcdyb> filterWxc(String sql);

	public String getWxdh(String sql);

	public List<QueryBean> getWtd(String wheresql);

	public List<QueryBean> getQy(String wheresql);

	public List<QueryBean> getXxd(String wheresql);

	//通用编码表
	public List<QueryBean> getTybmb(String wheresql);
	
	/**
	 * 保存前检查维修单号是否存在，不存在返回false，存在返回True
	 * @param sql
	 * @return
	 */
	public boolean isDhExists(String sql);
	
	/**
	 * 查询同一个快递单剩余未判定的维修单数量
	 * @param sql
	 * @return
	 */
	public List queryRemainUnJudgeNum(String sql);
	
	
}
