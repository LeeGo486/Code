package org.hy.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;
import org.hy.dao.ICMOperatorDao;
import org.hy.model.CMOperator;
import org.hy.model.LoginLog;
import org.hy.model.Menu;
import org.hy.model.UserInfo;
import org.hy.spring.CustomerContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;
@Service("cmOperatorDao")
public class CMOperatorDao extends HibernateDaoSupport implements ICMOperatorDao {

/*	@Autowired(required=true)
	@Qualifier("sessionFactoryDRP")
	private SessionFactory sessionFactoryDRP;
	
	
	public SessionFactory getSessionFactoryDRP() {
		return sessionFactoryDRP;
	}


	public void setSessionFactoryDRP(SessionFactory sessionFactoryDRP) {
		this.sessionFactoryDRP = sessionFactoryDRP;
	}*/

	
	public CMOperator getCMOperator(String userid) {
		// TODO Auto-generated method stub
		Session session =  getSession();
		CMOperator cmoperator = (CMOperator) session.get(CMOperator.class, userid);
		return cmoperator;
	}
	
	public List getDrpDept(){
		Session session = getSession();
		String sql = "select distinct usergroup id,usergroup text,'closed' state  from j_user where freeze<>1";
		SQLQuery ss=(SQLQuery) session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		List list=ss.list();
		return list;
	}
	
	
	public List getDrpUser(String usergroup){
		
		Session session = getSession();
		String sql = "select userid id,username text   from j_user where usergroup='"+usergroup+"'";
		SQLQuery ss=(SQLQuery) session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		List list=ss.list();
		return list;
		
	}
	
	public List getRoleForUser(String userid){
		Session session = getSession();
		String sql = "select r.roleid,r.rolename,r.roledesc from cm_role r,cm_rel_userrole u where r.roleid = u.roleid and u.userid='"+userid+"'";
		return session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
	}
	
	public List getRoleNotGrant(String userid){
		Session session = getSession();
		String sql = "select r.roleid,r.rolename,r.roledesc from cm_role r where not exists(select 1 from cm_rel_userrole u where r.roleid = u.roleid and u.userid='"+userid+"') ";
		return session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
	}

	public String addRoleForUser(String userid,String[] roleids){
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx =  session.beginTransaction();
		String sql;
		for(int i=0;i<roleids.length;i++){
			sql = "insert into cm_rel_userrole values('"+userid+"',"+roleids[i]+")";
			session.createSQLQuery(sql).executeUpdate();
		}
		tx.commit();
		session.close();
		return "1";
	}
	
	/**
	 * 操作时，将第一次的操作人员记录到本地
	 */
	public String addOperator(UserInfo userInfo){
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx =  session.beginTransaction();
		String sql = "insert into cywxdjczr(guid,userid,username)" +
				" select newid(),'"+userInfo.getUserid()+"','"+userInfo.getUsername()+"'    where " +
						"not exists(select 1 from cywxdjczr where userid='"+userInfo.getUserid()+"') ";
		session.createSQLQuery(sql).executeUpdate();
		tx.commit();
		session.close();
		return "1";		
	}
	
	public String delRoleForUser(String userid,String[] roleids){
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx =  session.beginTransaction();
		String sql;
		for(int i=0;i<roleids.length;i++){
			sql = "delete from cm_rel_userrole where userid='"+userid+"' and roleid="+roleids[i];
			session.createSQLQuery(sql).executeUpdate();
		}
		tx.commit();
		session.close();
		return "1";
	}

	public UserInfo getCurrentUser(String userid,String password){
		Session session = getSession();
		SQLQuery query = (SQLQuery) session.createSQLQuery("select userid,username,password from j_user where userid='"+userid+"' and password='"+password+"'").setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		List list = query.list();
		UserInfo userInfo = null; 
		if(list.size()>0){
			userInfo = new UserInfo();
			Map map = (Map) list.get(0);
			userInfo.setUserid((String) map.get("userid"));
			userInfo.setUsername((String)map.get("username"));
			userInfo.setPassword((String)map.get("password"));
		}
		return userInfo;
	}
	
	public List getMenuListForUser(String userid){
		Session session = getSession();
		SQLQuery query = (SQLQuery) session.createSQLQuery("select m.menuid,m.menuname,m.action_url from cm_rel_userrole u,cm_rel_rolemenu rm,cm_menu m where u.roleid=rm.roleid and rm.menuid=m.menuid and u.userid = '"+userid+"'").setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		List list = query.list();
		List menuList =new ArrayList();
		Menu menu;
		for(int i=0;i<list.size();i++){
			menu = new Menu();
			menu.setMenuid((Integer)((Map)list.get(i)).get("menuid"));
			menu.setMenuname((String)((Map)list.get(i)).get("menuname"));
			menu.setActionUrl((String)((Map)list.get(i)).get("action_url"));
			menuList.add(menu);
		}
		return menuList;
	}
	
	public String getOperatorNamebyID(String id){
		Session session = getSession();
		List list= session.createSQLQuery("select  username from CYWXDJCZR where userid='"+id+"'").addScalar("username", Hibernate.STRING).list();
		if(list.size()==0){
			return "";
		}
		String username =(String)list.get(0);
		return username;
	}
	
	
	
	
	public LoginLog getLoginLogByUserID(String userid){
		Session session = getSession();
		//String sql = "select guid,userid,com from cm_loginlog";
		//Query query = session.createSQLQuery(sql);
		Query query = session.createQuery("from LoginLog l where l.userid='"+userid+"'");
		List list =  query.list();
		if(list.size()>0){
			return (LoginLog)list.get(0);
		}else{
			return new LoginLog();
		}
		
	}
	
	public void saveLoginLog(LoginLog loginLog){
		Session session = getSession();
		if(loginLog.getGuid()!=null){
			session.update(loginLog);
		}else{
			session.save(loginLog);
		
		}

	}
}