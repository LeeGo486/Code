package org.hy.dao.impl;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;
import org.hy.dao.ICMRoleDao;
import org.hy.model.Role;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Service;

@Service("roleDao")
public class RoleDao extends HibernateDaoSupport implements ICMRoleDao {
	
	
	public List<Role> queryRoleList(int beginPage,int pageSize){
		Session session =  getSession();
		Query query = session.createQuery(" from Role as r ");
		query.setFirstResult(beginPage);
		query.setMaxResults(pageSize);
		List<Role>  recordList = query.list();
		return recordList;
	}
	
	public int getRoleSize(){
		Session session =  getSession();
		return (Integer) session.createSQLQuery("select count(1) rownum from cm_role").addScalar("rownum", Hibernate.INTEGER).list().get(0);
		  //return 1; 
	}
	
	
	public List<Role> getRoleByID(String roleID){
		return getHibernateTemplate().find(" from Role as r where r.roleid='"+roleID+"'");
		
	}
	
	
	
	public List<Role> getRoleByName(String roleName,int beginPage,int  pageSize){
		Session session =  getSession();
		
		Query query = session.createQuery(" from Role as r where r.rolename like '%"+roleName+"%'");
		query.setFirstResult(beginPage);
		query.setMaxResults(pageSize);
		List<Role>  recordList = query.list();
		return recordList;
	}
	
	public int getRoleSizeByName(String roleName){
		Session session =  getSession();
		return (Integer)session.createSQLQuery("select count(1) rownum from cm_role  r where r.rolename like '%"+roleName+"%'").addScalar("rownum", Hibernate.INTEGER).list().get(0);
	}
	
	public String saveRole(Map map){
		Session session =  this.getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx =  session.beginTransaction();
		List insertList = (List)map.get("inserted");
		if(insertList!=null){
			for(int i=0;i<insertList.size();i++){
				Role role = (Role)insertList.get(i);
				session.save(role);
			}
		}
		
		List updateList = (List)map.get("updated");
		if(updateList!=null){
			for(int i=0;i<updateList.size();i++){
				Role role = (Role)updateList.get(i);
				session.update(role);
			}
		}
		
		List deleteList = (List)map.get("deleted");
		if(deleteList!=null){
			for(int i=0;i<deleteList.size();i++){
				Role role = (Role)deleteList.get(i);
				session.delete(role);
			}
		}
		tx.commit();
		session.close();
		return "1";
	}

	public String addMenuForRole(String roleID,String[] menuIDArray){
		Session session =  getSession();
		session.beginTransaction();
		String sql = "";
		for(int i=0;i<menuIDArray.length;i++){
			sql = "insert into cm_rel_rolemenu values("+roleID+","+menuIDArray[i]+")";
			SQLQuery sq =  session.createSQLQuery(sql);
			sq.executeUpdate();
		}
		return "1";
	}
	
	public String delMenuForRole(String roleID,String[] menuIDArray){
		Session session =  getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		String sql = "";
		for(int i=0;i<menuIDArray.length;i++){
			sql = "delete from cm_rel_rolemenu where roleid="+roleID+" and menuid="+menuIDArray[i];
			SQLQuery sq =  session.createSQLQuery(sql);
			sq.executeUpdate();
		}
		tx.commit();
		session.close();
		return "1";
	}
}
