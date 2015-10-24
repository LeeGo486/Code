package com.nh.service;

import java.util.Date;
import java.util.List;

import com.nh.model.DOutindentChk;
import com.nh.model.DOutindentChksub;
import com.nh.model.DOutindentSet;
import com.nh.model.DOutindentSetsub;
import com.nh.model.JClothing;
import com.nh.model.JDepot;
import com.nh.model.SysStylepower18ql;

public interface DOutindentService {
	
	public List<DOutindentChk> queryById(String outindentid);

	//判断退货发货单号是否存在
	public boolean isHasOutindent(String outindentid);
	
	public JDepot queryBydepotid(String depotid);
	
	public List<DOutindentSet> queryByOutindentid(String outindentid);
	
	public List<DOutindentSetsub> getDOutindentsub(String outindentid);
	
	public List<DOutindentSetsub> getColorid(String outindentid, String colorid);
	
	public List<DOutindentChksub> clothOrNum(String outindentid, String colorid);
	
	public void  saveSetsub(DOutindentSetsub DOutindentSetsub);
	
	public double[] exePriceProc(String dname, String outindentid);
	
	public boolean isEpDepot(String colthid);
	
	public String execRightProc(String clothid);
	
	public List<DOutindentSetsub> execRightProc1(String clothid,String outindentid);
	
	public List<JClothing> getClothing(String clothingid);
	
	public List<SysStylepower18ql> getSysStyle(String Style,String userid);
	
	public String exeGetUserProc(String userid);
	
	public String exeSplitListProc(String outindentid,String surename,Date suredate);
	
	public List<Object> haveInventory(String depotid,String suredate);
}
