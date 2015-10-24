package com.nh.service.impl;

import java.util.Date;
import java.util.List;

import com.nh.dao.DOutindentSetDao;

import com.nh.model.DIndepot;
import com.nh.model.DOutindentChk;
import com.nh.model.DOutindentChksub;
import com.nh.model.DOutindentSet;
import com.nh.model.DOutindentSetsub;
import com.nh.model.JClothing;
import com.nh.model.JDepot;
import com.nh.model.JSupplierNh;
import com.nh.model.SysStylepower18ql;
import com.nh.service.DOutindentService;

public class DOutindentServiceImpl implements DOutindentService {
	
	private DOutindentSetDao dao;
	

	public DOutindentSetDao getDOutindentSetDao() {
		return dao;
	}


	public void setDOutindentSetDao(DOutindentSetDao dao) {
		this.dao = dao;
	}

	public List<DOutindentChk> queryById(String outindentid){
		List<DOutindentChk> list = dao.queryById(outindentid);
		return list;
	}
	
	//判断退货发货单是否存在
	public boolean isHasOutindent(String outindentid) {
		// TODO Auto-generated method stub
		List<DOutindentChk> list = dao.queryById(outindentid);
		if (null!=list && list.size()>0){		
			return true;
		}
		return false;
	}
	
	//退货发货单：若存在，取出收货店铺和制单日期。若不存在，提示不存在。
	

	//获取店铺名称
	public JDepot queryBydepotid(String depotid) {
		JDepot jDepot = dao.queryBydepotid(depotid);		
		return jDepot;
	}

	//
	public List<DOutindentSet> queryByOutindentid(String outindentid){
		return dao.queryById2(outindentid);
	}


	public List<DOutindentSetsub> getDOutindentsub(String outindentid) {

		return dao.getDoutindentsub(outindentid);
	}
	
	//判断款号是否存在，判断数量是否在范围内
	public List<DOutindentChksub> clothOrNum(String outindentid, String colorid){
		return  dao.queryByColorid(outindentid, colorid);
	}


	public List<DOutindentSetsub> getColorid(String outindentid, String colorid) {
		return  dao.queryByColorid1(outindentid, colorid);
	}
	
	public void  saveSetsub(DOutindentSetsub DOutindentSetsub){
		dao.saveSetsub(DOutindentSetsub);
	}


	public double[] exePriceProc(String dname, String outindentid) {
		
		return dao.exePriceProc(dname, outindentid);
	}


	@SuppressWarnings("unchecked")
	public boolean isEpDepot(String colthid) {
		List<JSupplierNh> list = dao.getEpSupplier();		
		StringBuffer sb = new StringBuffer();		
	    sb.append("(");
		for(int i=0;i<list.size();i++){
			if(i!=0){sb.append(",");}
			sb.append("'"+list.get(i).getSuppliesId()+"'");
		}
		sb.append(")");
		System.out.println(sb);
		
		List<DIndepot> list1 = dao.getEpIndepot(sb.toString());
		StringBuffer sb1 = new StringBuffer();
		sb1.append("(");
		for(int i=0;i<list1.size();i++){
			if(i!=0){sb1.append(",");}
			sb1.append("'"+list1.get(i).getIndepotid()+"'");
		}
		sb1.append(")");
		System.out.println(sb1);
		
		List list2 = dao.getClothid(sb1.toString());
		for(int i=0;i<list2.size();i++){
			System.out.println(list2.get(i).toString());
		}
		
		return false;
	}


	public String execRightProc(String clothid) {
		return dao.execRightProc(clothid);
	}
	
	public List<DOutindentSetsub> execRightProc1(String clothid,String outindentid){
		 List<DOutindentSetsub> list = dao.execRightProc1(clothid, outindentid);
		
		 return list;
	}
	
	public List<JClothing> getClothing(String clothingid) {
		return dao.getClothing(clothingid);
	}
	
	public List<SysStylepower18ql> getSysStyle(String Style,String userid){
		return dao.getSysStyle(Style, userid);
	}
	
	public String exeGetUserProc(String userid){
		return dao.exeGetUserProc(userid);
	}
	
	public String exeSplitListProc(String outindentid,String surename,Date suredate){
		return dao.exeSplitListProc(outindentid, surename, suredate);
	}
	
	public List<Object> haveInventory(String depotid,String suredate){
		return dao.haveInventory(depotid, suredate);
	}
}
