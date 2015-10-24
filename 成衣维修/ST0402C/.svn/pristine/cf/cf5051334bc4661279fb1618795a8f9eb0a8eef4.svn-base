package org.hy.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hy.dao.IMaintainRegisterDao;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.MaintainRegister;
import org.hy.model.Ppwxcdyb;
import org.hy.util.QueryBean;
import org.springframework.stereotype.Service;

@Service("maintainRegisterDao")
public class MaintainRegisterDao extends BaseDaoSupport<MaintainRegister> implements
		IMaintainRegisterDao {
	
	public MaintainRegister getMaintainRegisterByID(String id) {
		Session session =  getSession();
		MaintainRegister mr = (MaintainRegister) session.get(MaintainRegister.class, id);
		//session.close();
		return mr;
	}
	
	public List filterZt(String sql){
		Session session =  getSession();
		Query query = session.createSQLQuery(sql);
		
		List<QueryBean> list1 = new ArrayList<QueryBean>();	
		List<Object> list2 = query.list();
		for (int i = 0; i < list2.size(); i++) {
			QueryBean zt = new QueryBean();
			Object[] objs=(Object[])list2.get(i);
					
			zt.setBh((null==objs[0]? "":objs[0].toString()));
			zt.setMc((null==objs[1]? "":objs[1]).toString());
		
			list1.add(zt);
	}
		//session.close();
		return list1;
	}

	
	//店铺对应维修仓
	public List filterWxc(String sql){
		//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
		//Session session = super.getSession();
		List<Ppwxcdyb> list1 = new ArrayList<Ppwxcdyb>();	
		
		//CustomerContextHolder.setCustomerType("x6test");
		Session session =  getSession(); 
		Query query = session.createSQLQuery(sql);
		List<Object> list2 = query.list();
		
		for (int i = 0; i < list2.size(); i++) {
			Ppwxcdyb ppwxc = new Ppwxcdyb();
			Object[] objs=(Object[])list2.get(i);
					
			ppwxc.setWxcbm((null==objs[0]? "":objs[0].toString()));
			ppwxc.setWxcmc((null==objs[1]? "":objs[1]).toString());
		
			list1.add(ppwxc);
	}
		return list1;
	}

	public String getWxdh(String sql) {
		//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
		//Session session = super.getSession();
		Session session =  getSession();
		Query query = session.createSQLQuery(sql);
		List<Object> list =query.list();
		if(list==null || list.size()==0 || list.get(0)==null){
			return "000001";
		}else{
			String wxdh = (String) list.get(0);
			wxdh = ("00000"+(Integer.parseInt(wxdh)+1)).substring( ("00000"+(Integer.parseInt(wxdh)+1)).length()-6);
			return wxdh;
		}
		
	}
	
	/**
	 * 保存前检查维修单号是否存在，不存在返回false，存在返回True
	 * @param sql
	 * @return
	 */
	public boolean isDhExists(String sql){
		Session session =  getSession();
		Query query = session.createSQLQuery(sql);
		List<Object> list =query.list();
		if(list==null || list.size()==0 || list.get(0)==null){
			return false;
		}else{
			return true;
		}
	}
	
	
	//维修性质  级联  问题点
		public List<QueryBean> getWtd(String wheresql) {
			//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
			//CustomerContextHolder.setCustomerType("x6test");
			//Session session = super.getSession();
			Session session =  getSession();
			Query query = session.createSQLQuery(wheresql);
			
			List<QueryBean> list1 = new ArrayList<QueryBean>();	
			List<Object> list2 = query.list();
			for (int i = 0; i < list2.size(); i++) {
				QueryBean wtd = new QueryBean();
				Object[] objs=(Object[])list2.get(i);
						
				wtd.setFcode((null==objs[0]? "":objs[0].toString()));
				wtd.setFcontent((null==objs[1]? "":objs[1]).toString());
			
				list1.add(wtd);
		}
		//	session.close();
			return list1;
		}
		
	// 问题点 级联  起因
		public List<QueryBean> getQy(String wheresql) {
			//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
			//CustomerContextHolder.setCustomerType("x6test");
			//Session session = super.getSession();
			Session session =  getSession();
			Query query = session.createSQLQuery(wheresql);
			List<QueryBean> list1 = new ArrayList<QueryBean>();	
			List<Object> list2 = query.list();
			for (int i = 0; i < list2.size(); i++) {
				QueryBean qy = new QueryBean();
				Object[] objs=(Object[])list2.get(i);
						
				qy.setFcode((null==objs[0]? "":objs[0].toString()));
				qy.setFcontent((null==objs[1]? "":objs[1]).toString());
				list1.add(qy);
		}
		//	session.close();
			return list1;
		}
		
	//   起因   级联   现象点
		public List<QueryBean> getXxd(String wheresql) {
					//CustomerContextHolder.setCustomerType(DynamicDataSourceType.S1);
					//Session session = super.getSession();
					//CustomerContextHolder.setCustomerType("x6test");
					Session session =  getSession();
					Query query = session.createSQLQuery(wheresql);
					List<QueryBean> list1 = new ArrayList<QueryBean>();	
					List<Object> list2 = query.list();
					for (int i = 0; i < list2.size(); i++) {
						QueryBean xxd = new QueryBean();
						Object[] objs=(Object[])list2.get(i);
								
						xxd.setFcode((null==objs[0]? "":objs[0].toString()));
						xxd.setFcontent((null==objs[1]? "":objs[1]).toString());
						list1.add(xxd);
				}
			//		session.close();
					return list1;
				}

		public List<QueryBean> getTybmb(String wheresql) {
			Session session =  getSession();
			Query query = session.createSQLQuery(wheresql);
			List<QueryBean> list = new ArrayList<QueryBean>();	
			List<Object> list2 =query.list();	
			
			for (int i = 0; i < list2.size(); i++) {
				QueryBean tybm = new QueryBean();
				Object[] objs=(Object[])list2.get(i);
				tybm.setFcode((null==objs[0]? "":objs[0].toString()));
				tybm.setFscope((null==objs[1]? "":objs[1]).toString());
				tybm.setFcontent((null==objs[2]? "":objs[2]).toString());
				list.add(tybm);
				}
		//	session.close();
		
			return list;
		}

		/**
		 * 查询同一个快递单剩余未判定的维修单数量
		 * @param sql
		 * @return
		 */
		public List queryRemainUnJudgeNum(String sql){
			Session session =  getSession();
			Query query = session.createSQLQuery(sql);
			List list = query.list();
			return list;
		}
}
