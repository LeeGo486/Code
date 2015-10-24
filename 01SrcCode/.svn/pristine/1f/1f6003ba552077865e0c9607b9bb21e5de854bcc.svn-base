package com.nh.dao;

import java.util.Date;
import java.util.List;

import com.nh.model.DOutindentChk;
import com.nh.model.DOutindentChksub;
import com.nh.model.DOutindentSet;
import com.nh.model.DOutindentSetsub;
import com.nh.model.JClothing;
import com.nh.model.JDepot;
import com.nh.model.SysStylepower18ql;

public interface DOutindentSetDao {

	// 根据退货发货单号id查询 退货发货单
	public List<DOutindentChk> queryById(String outindentid);
	
	// 根据退货发货单号id查询 退货发货单
	public List<DOutindentSet> queryById2(String outindentid);
	
	//根据depotid获取收获店铺名称
	public JDepot queryBydepotid(String depotid);
	
	//获取退货发货单明细表
	public List<DOutindentSetsub> getDoutindentsub(String outindentid);
	
	//根据款号查询退货审批单明细表记录
	public List<DOutindentSetsub> queryByColorid1(String outindentid,String clothingid);
	
	//根据款号查询退货审批单明细表记录
	public List<DOutindentChksub> queryByColorid(String outindentid,String clothingid);
	
	//新增修改保存退货发货单明细记录
	public void  saveSetsub(DOutindentSetsub DOutindentSetsub);
	
	//
	public double[] exePriceProc(String dname, String outindentid);
	
	public double exePriceProc1(String dname, String outindentid);
	
	//供应商维护表中    查询出属于雅莹的供应商编号
	public List getEpSupplier();
	
	//查询所有雅莹供应商的款号的生产入库单
	public List getEpIndepot(String suppliers);
	
	//获取生产入库单明细 所有款号
	public List getClothid(String indepotids);
	
	public String execRightProc(String clothid);
	
	public List<DOutindentSetsub> execRightProc1(String clothid,String outindentid);
	
	//查找款式
	public List<JClothing> getClothing(String clothingid);
	
	//查找款式权限
	public List<SysStylepower18ql> getSysStyle(String Style,String userid);
	
	//退货权限过程
	public String exeGetUserProc(String userid);
	
	public String exeSplitListProc(String outindentid,String surename,Date suredate);
	
	public List<Object> haveInventory(String depotid,String suredate);
}
