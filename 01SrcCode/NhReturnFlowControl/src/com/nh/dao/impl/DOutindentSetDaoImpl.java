package com.nh.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nh.dao.DOutindentSetDao;
import com.nh.model.DOutindentChk;
import com.nh.model.DOutindentChksub;
import com.nh.model.DOutindentSet;
import com.nh.model.DOutindentSetsub;
import com.nh.model.DOutindentSetsubId;
import com.nh.model.JClothing;
import com.nh.model.JDepot;
import com.nh.model.SysStylepower18ql;

public class DOutindentSetDaoImpl extends HibernateDaoSupport implements
		DOutindentSetDao {

	//
	public List<DOutindentChk> queryById(String outindentid) {
		//String sql = " from DOutindentChk where outindentid='"+outindentid+"'";
		//System.out.println(sql);
		return getHibernateTemplate().find(" from DOutindentChk where outindentid='"+outindentid+"'");
	}
	
	public List<DOutindentSet> queryById2(String outindentid){
		//return getHibernateTemplate().get(DOutindentSet.class, outindentid);
		return getHibernateTemplate().find(" from DOutindentSet where outindentid='"+outindentid+"'");
	}
	
	//根据店铺ID查找店铺名称
	public JDepot queryBydepotid(String depotid){
		//String sql = " from JDepot where depotid='"+depotid+"'";
		//System.out.println(sql);
		return (JDepot) getHibernateTemplate().find(" from JDepot where depotid='"+depotid+"'").get(0);
	}

	//获取退货发货单明细表
	public List<DOutindentSetsub> getDoutindentsub(String outindentid) {
		//String sql = "from DOutindentSetsub where outindentid='"+outindentid+"'";
		//System.out.println(sql);
		return getHibernateTemplate().find("from DOutindentSetsub where outindentid='"+outindentid+"'");
	}

	public List<DOutindentChksub> queryByColorid(String outindentid, String clothingid) {
		//String sql="from DOutindentChksub where outindentid='"+outindentid+"' and clothingid='"+clothingid+"'";
		//System.out.println(sql);
		return getHibernateTemplate().find("from DOutindentChksub where outindentid='"+outindentid+"' and clothingid='"+clothingid+"'");
	}

	public List<DOutindentSetsub> queryByColorid1(String outindentid, String clothingid) {
		//String sql="from DOutindentSetsub where outindentid='"+outindentid+"' and clothingid='"+clothingid+"'";
		//System.out.println(sql);
		return getHibernateTemplate().find("from DOutindentSetsub where outindentid='"+outindentid+"' and clothingid='"+clothingid+"'");
	}
	
	public void  saveSetsub(DOutindentSetsub DOutindentSetsub){
		getHibernateTemplate().saveOrUpdate(DOutindentSetsub);
	}

	public double[] exePriceProc(String dname, String outindentid) {
		double d = 0;
		double d1 = 0;
		double[] aa = new double[2];
		Session ses=this.getHibernateTemplate().getSessionFactory().openSession(); 
		try{ 
		  Connection conn = ses.connection();
		  conn.setAutoCommit(false); 
		  CallableStatement st = conn.prepareCall("{ call dbo.t18tj_GetClothingPrice(?,?,?) }");	  
		  st.setInt(1, 3);
		  st.setString(2, dname);
		  st.setString(3, outindentid);
		  //rs = st.executeQuery();
		  //System.out.println("executeQuery:"+rs);
		 //System.out.println("3,"+dname+","+outindentid);
		  st.execute();  
		  ResultSet rs = st.getResultSet();
		  if (rs == null){
			  if(st.getMoreResults()){
				  rs = st.getResultSet();
			  }
			  else{
				  System.out.println("s_price is error!");
			  }
		  }
		  
		  //返回 null（表示结果不是 ResultSet 对象）
		  //System.out.println("getResultSet:"+rs);	  
		  //如果 getMoreResults 返回 true，则需要再次调用 getResultSet 来检索下一个结果集
		  //System.out.println("getMoreResults:"+st.getMoreResults());//
		  //如果为 -1 则表示结果是结果集或没有结果
		  //System.out.println("getUpdateCount:"+st.getUpdateCount()) ; 
		  //rs = st.getResultSet();
		  //System.out.println("getMoreResults:"+st.getMoreResults());
		  while(rs.next()){
			  d = Double.parseDouble(rs.getString(8));//取s_price
			  d1 = Double.parseDouble(rs.getString(9));//取discount
			  aa[0]=d;
			  aa[1]=d1;
			 /* for(int i=1;i<=12;i++){
				  System.out.println(rs.getString(i));
			  }	 */
		  }
		  //System.out.println(d);
		  conn.commit(); 
		  st.close();
		  conn.close();
		  ses.close();
		}catch(Exception e){ 
		  e.printStackTrace(); 
		} 
		return aa;
	}
	
	public double exePriceProc1(String dname, String outindentid) {
		
		return 0;
	}

	public List getClothid(String indepotids) {
		//String sql = " select distinct id.clothingid from DIndepotsub  where indepotid in "+indepotids+" order by id.clothingid desc";
		//System.out.println(sql);
		return getHibernateTemplate().find(" select distinct id.clothingid from DIndepotsub  where indepotid in "+indepotids+" order by id.clothingid desc");
	}

	public List getEpIndepot(String suppliers) {
		//String sql = " from DIndepot a where a.SupplierId in "+suppliers+"";
		//System.out.println(sql);
		return getHibernateTemplate().find(" from DIndepot a where a.SupplierId in "+suppliers+"");
	}

	public List getEpSupplier() {
		//String sql=" from JSupplierNh ";
		return getHibernateTemplate().find(" from JSupplierNh ");
	}

	public String execRightProc(String clothid) {
		String rights = null;
		Session ses=this.getHibernateTemplate().getSessionFactory().openSession();
		try{
		  Connection conn = ses.connection();   
		  conn.setAutoCommit(false); 
		 // String proc= "{call DRP_REPORT.dbo.NhReturnGoodsRights(?,?)}";
		  CallableStatement st = conn.prepareCall("{call DRP_REPORT.dbo.NhReturnGoodsRights(?,?,?)}");
		  st.setString(1, "NULL");
		  st.setString(2, clothid);
		  st.registerOutParameter(3, Types.VARCHAR);
		  st.execute();
		  rights = st.getString(3);
		  conn.commit(); 
		  st.close();
		  conn.close();
		  ses.close();
		}catch(Exception e){ 
		  e.printStackTrace(); 
		} 
		return rights;
	}

	public List<DOutindentSetsub> execRightProc1(String clothid, String outindentid) {
		List<DOutindentSetsub> list = new ArrayList();
		Session ses=this.getHibernateTemplate().getSessionFactory().openSession();
		try{
		  Connection conn = ses.connection();   
		  conn.setAutoCommit(false); 
		  //String proc= "{call DRP_REPORT.dbo.NhReturnGoodsRights(?,?,?)}";
		  CallableStatement st = conn.prepareCall("{call DRP_REPORT.dbo.NhReturnGoodsRights(?,?,?)}");
		  st.setString(1, outindentid);
		  st.setString(2, "NULL");
		  st.registerOutParameter(3, Types.VARCHAR);
		  st.execute();  
		  ResultSet rs = st.getResultSet();
		  //System.out.println(rs);
		  if (rs == null){
			  if(st.getMoreResults()){
				  rs = st.getResultSet();
			  }
			  else{
				  System.out.println("rights is error!");
			  }
		  }  
		  while(rs.next()){
//			  System.out.println(rs.getString(1));
//			  System.out.println(rs.getString(2));
			  DOutindentSetsub DOutindentSetsub = new DOutindentSetsub();	
			  DOutindentSetsubId DOutindentSetsubId = new DOutindentSetsubId();
			  DOutindentSet DOutindentSet = new DOutindentSet();
			  DOutindentSet.setOutindentid(outindentid);//单号
			  DOutindentSetsubId.setDOutindentSet(DOutindentSet);
			  DOutindentSetsubId.setClothingid(rs.getString(2));//款号
			  DOutindentSetsub.setId(DOutindentSetsubId);//ID
			  DOutindentSetsub.setRights(rs.getString(3));//货权
			  DOutindentSetsub.setStyleid(rs.getString(4));//
			  DOutindentSetsub.setColorid(rs.getString(5));//
			  DOutindentSetsub.setSizeid(rs.getString(6));
			  DOutindentSetsub.setNums(Integer.parseInt(rs.getString(7)));
			  DOutindentSetsub.setXPrice(Double.parseDouble(rs.getString(8)));
			  list.add(DOutindentSetsub);
		  }	  
		  conn.commit(); 
		  st.close();
		  conn.close();
		  ses.close();
		}catch(Exception e){ 
		  e.printStackTrace(); 
		} 
		//System.out.println(list.size());
		return list;
	}

	public List<JClothing> getClothing(String clothingid) {
		
		return getHibernateTemplate().find("from JClothing where clothingid='"+clothingid+"' or oldclothingid='"+clothingid+"'");
	}

	public List<SysStylepower18ql> getSysStyle(String Style, String userid) {
		
		return getHibernateTemplate().find(" from SysStylepower18ql a where a.id.JStyle='"+Style+"' and a.id.JUser ='"+userid+"'");
	}

	public String exeGetUserProc(String userid) {
		String s="";
		Session ses=this.getHibernateTemplate().getSessionFactory().openSession();
		try{
		  Connection conn = ses.connection();   
		  conn.setAutoCommit(false); 
		  CallableStatement st = conn.prepareCall("{call f18master.dbo.f22_getUserForm18(?,?)}");
		  st.setString(1, userid);
		  st.setString(2, "6100007");
		  //System.out.println("{call f18master.dbo.f22_getUserForm18("+userid+",'6100007')}");
		  //st.execute();
		  //ResultSet rs = st.getResultSet();
		  ResultSet rs = st.executeQuery();
		  //System.out.println("修改的记录："+st.getUpdateCount());
		  //System.out.println("更多的记录："+st.getMoreResults());
		  //System.out.println("------------"+rs);
		  
		  //rs = st.getResultSet();
		  //rs = st.getResultSet();
		  /* if (rs == null){
			  if(st.getMoreResults()){
				  rs = st.getResultSet();
			  }
			  else{
				  System.out.println("exeGetUserProc is error!");
			  }
		  }*/
		  //System.out.println("==========="+rs);
		  while(rs.next()){
			  s = rs.getString(1);
			 //System.out.println( rs.getString(1));
			  
		  }
		  conn.commit();
		  st.close();
		  conn.close();
		  ses.close();
		}catch(Exception e){ 
			  e.printStackTrace(); 
		} 
		return s;
	}

	public String exeSplitListProc(String outindentid,String surename,Date suredate) {
		String s="";
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String mDateTime1=formatter.format(suredate);
		//System.out.println(mDateTime1);

		Session ses=this.getHibernateTemplate().getSessionFactory().openSession();
		try{
		  Connection conn = ses.connection();   
		  conn.setAutoCommit(false); 
		  CallableStatement st = conn.prepareCall("{call DRP_REPORT.dbo.NhReturnGoodsSplitList(?,?,?,?)}");
		  st.setString(1, outindentid);	 
		  st.setString(2, surename);
		  st.setString(3, mDateTime1);
		  st.registerOutParameter(4, Types.VARCHAR);
		  st.execute();
			//rs = callSta.getResultSet();
		  //s = st.getString(2);
		  conn.commit();
		  st.close();
		  conn.close();
		  ses.close();
		}catch(Exception e){ 
			  e.printStackTrace(); 
		} 
		return s;
	}


	public List<Object>  haveInventory(final String depotid, final String suredate) {
		List<Object> list = this.getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session)throws HibernateException, SQLException {
				String hql="";
				hql="select * from d_inventory where depotid='"+depotid+"' and isnull(sure,0)>0 and substring(inventoryid,1,2)='PD' and convert(char(10),sure_date,126)>='"+suredate+"'";
				//System.out.println(hql);
				return session.createSQLQuery(hql).list();
			}
		});
		
		//System.out.println(list);
		return list;
	}

	
	
}
