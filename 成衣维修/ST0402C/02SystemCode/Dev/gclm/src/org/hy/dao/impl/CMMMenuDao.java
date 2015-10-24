package org.hy.dao.impl;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hy.dao.ICMMenuDao;
import org.hy.model.Menu;
import org.hy.model.UserInfo;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;

@Service("CMMMenuDao")
public class CMMMenuDao extends HibernateDaoSupport implements ICMMenuDao {
	public List queryMenuNotGrant(String id){
		Session session = getSession();
		String sql = "select menuid,menuname from cm_menu m where not exists(select 1 from cm_rel_rolemenu r where r.menuid=m.menuid and r.roleid="+id+")";
		return session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
		
		
	}
	
	public List queryMenuByUserID(UserInfo userInfo){
		Session session = getSession();
		String sql = "select menuname,action_url from cm_menu a,CM_REL_ROLEMENU b,CM_REL_USERROLE c where b.menuid = a.menuid and c.roleid =b.roleid and c.userid='"+userInfo.getUserid()+"' order by b.menuid desc";
		return session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
	}

	public List queryMenuByRoleID(UserInfo userInfo,String roleID){
		Session session = getSession();
		String sql = "select a.menuid,a.menuname from cm_menu a,CM_REL_ROLEMENU b where a.menuid=b.menuid and b.roleid='"+roleID+"'";
		return session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
	}
}
