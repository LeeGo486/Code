package org.hy.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hy.dao.IJdepot;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.model.ClothingInfo;
import org.hy.model.Jdepot;
import org.hy.model.MaintainRegister;
import org.hy.model.UserInfo;
import org.hy.spring.CustomerContextHolder;
import org.hy.spring.DynamicDataSourceType;
import org.hy.util.DateUtil;
import org.hy.util.QueryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;


@Service("jdepotDao")


public class JdepotDaoImpl extends BaseDaoSupport<Jdepot> implements IJdepot {
 

	
/*	@Autowired(required=true)
	@Qualifier("sessionFactoryDRP")
	private SessionFactory sessionFactorydrp;

	public SessionFactory getSessionFactorydrp() {
	return sessionFactorydrp;
}
public void setSessionFactorydrp(SessionFactory sessionFactorydrp) {
	this.sessionFactorydrp = sessionFactorydrp;
}
	*/

	/*
	 * 成衣维修查询条件初始化
	 * @see org.hy.dao.IMaintainRegisterDao#queryFilter()
	 */
 
	
		public List filterDp(String wherejpql, int firstindex, int maxresult){
			String hql = "from " + entityClassName + " o " + (wherejpql == null || "".equals(wherejpql.trim()) ? "" : " where " + wherejpql) ;
			//Session session = sessionFactorydrp.openSession();
			//CustomerContextHolder.setCustomerType("雅莹");
			Session session = getSession();
			Query query = session.createQuery(hql);
			if (firstindex != -1 && maxresult != -1)
				query.setFirstResult(firstindex).setMaxResults(maxresult);// last page
			List list =query.list();
			return  list;
		}
		public List<QueryBean> getSldg(String wheresql) {
			
			//CustomerContextHolder.setCustomerType("雅莹");
			//Session session = super.getSession();
			//Session session = sessionFactorydrp.openSession();
			Session session = getSession();
			Query query = session.createSQLQuery(wheresql);
			List<QueryBean> list1 = new ArrayList<QueryBean>();	
			List<Object> list2 = query.list();
			for (int i = 0; i < list2.size(); i++) {
				QueryBean sldg = new QueryBean();
				Object[] objs=(Object[])list2.get(i);
						
				sldg.setEmployeeid((null==objs[0]? "":objs[0].toString()));
				sldg.setNames((null==objs[1]? "":objs[1]).toString());
				sldg.setTelephone((null==objs[2]? "":objs[2]).toString());
				
				list1.add(sldg);
				}
			return list1;
		}
		
		
		public String checkKh(String wheresql) {
			//CustomerContextHolder.setCustomerType("雅莹");
			String error="wu";
			try {
				//Session session = getHibernateTemplate().getSessionFactory().openSession();
				//Session session = sessionFactorydrp.openSession();
				Session session =getSession();
				Query query = session.createSQLQuery(wheresql);
				List list =query.list();
				if(list.size()==0){
					return error;
				}else{
					return (String) list.get(0);
				}
			} catch (Exception e) {
				return error;
			}
			
			
			
		
		}
	
 
		/*
		 * 退仓
		 */
		public String  backStore(MaintainRegister model,UserInfo userInfo,ClothingInfo clothingInfo ){
			Session session = getSession();
			String tcjg = "ok";
			try {
				SQLQuery sqlQuery = session.createSQLQuery("{call X62DRP_thd (?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				sqlQuery.setString(0, model.getThdh());
				sqlQuery.setString(1, model.getDpbm());
				sqlQuery.setString(2, model.getWxcbm());
				sqlQuery.setString(3, userInfo.getUserid());
				sqlQuery.setString(4, model.getKh());
				sqlQuery.setString(5, clothingInfo.getStyleID());
				sqlQuery.setString(6, clothingInfo.getColorid());
				sqlQuery.setString(7, clothingInfo.getSizeid());
				sqlQuery.setInteger(8, 1);
				sqlQuery.setFloat(9, clothingInfo.getJ_cost());
				sqlQuery.setFloat(10, clothingInfo.getJ_price());
				sqlQuery.setFloat(11, clothingInfo.getX_price());
				sqlQuery.setFloat(12, clothingInfo.getS_price());
				sqlQuery.setFloat(13, clothingInfo.getDiscount());
				System.out.println(sqlQuery.getQueryString());
				sqlQuery.executeUpdate();
				
			} catch (Exception e) {
				 e.printStackTrace();
				 tcjg = "error";
			}
		return tcjg;
			
		}
		
		public String getTHDH(UserInfo userInfo,String djr){
			String preThdh = "FH"+ djr +"-"+DateUtil.getFormatDate("yyyy-MM-dd")+"-";
			String sql = "select max(outindentid) thdh from d_OutindentSET where outindentid like '"+preThdh+"%'";
			Session session = getSession();
			List list = session.createSQLQuery(sql).addScalar("thdh", Hibernate.STRING).list();
			String thdh;
			if(list.size()==0||"null".equals(list.get(0))||null==list.get(0)){
				thdh = preThdh+"0001";
			}else{
				thdh = (String) list.get(0);
				int i_index = Integer.parseInt(thdh.split("-")[4])+1;
				String s_index = "000"+i_index;
				thdh = preThdh+s_index.substring(s_index.length()-4);
			}
			return thdh;
		}
		
		public String getStyleID(String clothingid){
			//CustomerContextHolder.setCustomerType("雅莹");
			//Session session = sessionFactorydrp.openSession();
			Session session = getSession();
			String sql = "select styleid from j_clothing where clothingid='"+clothingid+"'";
			List list = session.createSQLQuery(sql).addScalar("styleid", Hibernate.STRING).list();
			String id = (String)list.get(0);
			return id;
		}
		
		public ClothingInfo getClothingPrice(final String setDepotid,final String getDepotid,final String styleID){
			
			ClothingInfo clothingInfo = new ClothingInfo();
			try {
				final String date = DateUtil.getFormatDate("yyyy-MM-dd");
				System.out.println(date); 
				Session session = getSession();
				List<Object> list = session.createSQLQuery(" exec gclm_getPrice '"+setDepotid+"','"+styleID+"','"+date+"','"+getDepotid+"'").list();	
				if(list.size()>0){
					Object[] objs = (Object[]) list.get(0);
					System.out.println(objs[4].toString()+"~~"+objs[5].toString()+"~~"+objs[6].toString()+"~~"+objs[7].toString());
					
					clothingInfo.setJ_cost(Float.parseFloat(objs[4].toString()));
					clothingInfo.setJ_price(Float.parseFloat(objs[5].toString()));
					clothingInfo.setX_price(Float.parseFloat(objs[6].toString()));
					clothingInfo.setS_price(Float.parseFloat(objs[7].toString()));
					clothingInfo.setDiscount(Float.parseFloat(objs[8].toString()));
				}
				
				return clothingInfo;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return clothingInfo;
		}
}
