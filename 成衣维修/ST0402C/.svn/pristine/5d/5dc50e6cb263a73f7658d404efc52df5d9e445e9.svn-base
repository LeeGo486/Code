package org.hy.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hy.SSO.service.PubWSService;
import org.hy.beans.base.QueryResult;
import org.hy.dao.base.BaseDaoSupport;
import org.hy.dao.impl.MaintainRegisterDao;
import org.hy.model.ClothingInfo;
import org.hy.model.Jdepot;
import org.hy.model.MaintainRegister;
import org.hy.model.Ppwxcdyb;
import org.hy.model.UserInfo;
import org.hy.model.Ysgsxxb;
import org.hy.service.IMaintainRegisterService;
import org.hy.dao.*;
import org.hy.util.QueryBean;
import org.hy.wsclient.SSO.login.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

@Service("mrService")
// id=mrService
public class MaintainRegisterServiceImpl extends
		BaseDaoSupport<MaintainRegister> implements IMaintainRegisterService {

	@Autowired(required = false)
	@Qualifier("maintainRegisterDao")
	private IMaintainRegisterDao mrdao;

	@Autowired(required = false)
	@Qualifier("jdepotDao")
	private IJdepot jdepotDao;

	@Autowired(required = false)
	@Qualifier("ysgsDao")
	private IYsgsxxb ysgsDao;

	public IJdepot getJdepotDao() {
		return jdepotDao;
	}

	public void setJdepotDao(IJdepot jdepotDao) {
		this.jdepotDao = jdepotDao;
	}

	public IMaintainRegisterDao getMrdao() {
		return mrdao;
	}

	public void setMrdao(IMaintainRegisterDao mrdao) {
		this.mrdao = mrdao;
	}

	/*
	 * public List<MaintainRegister> findByName(String value) { //
	 * System.out.println("调用service"); return super.findByProperty("dh",
	 * value); }
	 */
	public List<Jdepot> filterDp(String sessionID, String p, String com)
			throws Exception {
		String newCom = "'" + com.replaceAll(",", "','") + "'";
		List Filter;
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		if("0".equals(p)){
			map.put("ConditionStr",
					"【操作类型,GET】【实体,J_DEPOT】【返回内容,店铺ID,店铺名称,店铺地址,品牌,店长姓名,店长联系电话,店铺类型】【条件内容,《W》店铺ID,《W》公司】【《W》公司,"+newCom+"】");
		}else{
			map.put("ConditionStr",
					"【操作类型,GET】【实体,J_DEPOT】【返回内容,店铺ID,店铺名称,店铺地址,品牌,店长姓名,店长联系电话,店铺类型】【条件内容,《W》店铺ID,《W》公司】【《W》店铺ID,"
							+ p + "】【《W》公司,"+newCom+"】");
		}
		
		Filter = PubWSService.callWSRRToList(
				"111b4bb5-4f8f-417a-a51f-01b3a67adbdc", "ITDC_EXCEL",
				sessionID, map);
		return Filter;
	}

	public List filterDpByName(String sessionID, String p, String com)
			throws Exception {
		String newCom = "'" + com.replaceAll(",", "','") + "'";
		List Filter;
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,GET】【实体,J_DEPOT】【返回内容,店铺ID,店铺名称,店铺地址,品牌,店长姓名,店长联系电话,店铺类型】【条件内容,《W》店铺名称,,《W》公司】【《W》店铺名称,%"
						+ p + "%】【《W》公司,"+newCom+"】");

		Filter = PubWSService.callWSRRToList(
				"111b4bb5-4f8f-417a-a51f-01b3a67adbdc", "ITDC_EXCEL",
				sessionID, map);
		return Filter;
	}

	public List<QueryBean> filterZt(String sql) {

		List zt = mrdao.filterZt(sql);
		return zt;

	}

	public List<Ppwxcdyb> filterWxc(String sql) {
		List<Ppwxcdyb> wxc = mrdao.filterWxc(sql);
		return wxc;
	}

	public List getSldg(String sessionID, String depotID) throws Exception {
		List sldg = null;
		List Filter;
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,GET】【实体,J_EMPLOYEE】【返回内容,客户经理ID,客户经理姓名,客户经理电话】【条件内容,《W》店铺ID】【《W》店铺ID,"
						+ depotID + "】");
		sldg = PubWSService.callWSRRToList(
				"0dd084c5-abac-4bef-bbc0-ea28ee1f007b", "ITDC_EXCEL",
				sessionID, map);
		return sldg;
	}

	public void saveRegister(MaintainRegister mrlist) {
		super.save(mrlist);
	}

	public String getWxdh(String sql) {
		String wxdh = mrdao.getWxdh(sql);
		return wxdh;
	}

	public QueryResult<Ysgsxxb> getYsgs() {
		QueryResult<Ysgsxxb> ysgs = ysgsDao.getYsgs();
		return ysgs;
	}

	public List<QueryBean> getWtd(String wheresql) {
		List<QueryBean> wtd = mrdao.getWtd(wheresql);
		return wtd;
	}

	public List<QueryBean> getQy(String wheresql) {
		List<QueryBean> qy = mrdao.getQy(wheresql);
		return qy;
	}

	public List<QueryBean> getXxd(String wheresql) {
		List<QueryBean> xxd = mrdao.getXxd(wheresql);
		return xxd;
	}

	// 通用编码部分
	public List<QueryBean> getTybmb(String wheresql) {
		List<QueryBean> tybmb = mrdao.getTybmb(wheresql);
		return tybmb;
	}

	public List checkKh(String sessionID, String clothingID) throws Exception {
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,GET】【实体,j_clothing】【返回内容,款号,颜色,尺码】【条件内容,《W》项目代号】 【《W》项目代号,"
						+ clothingID + "】");

		List styleInfoList = PubWSService.callWSRRToList(
				"9534098c-56f3-49bd-b255-b00628075276", "ITDC_EXCEL",
				sessionID, map);

		// String sldg =
		// PubWSService.callWSRR("85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25",
		// "DRPAS", "", map);
		return styleInfoList;
	}

	/**
	 * 发货
	 */
	public String sendGoods(String sender,String receiver,String kh, UserInfo userInfo,
			String djr) {
		String thdh = "";
		String tcjg = "error"; 
		String errorinfo = "error"; 
		
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,NEW】【实体,发货】"
						+ "【新增内容,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,原价,现价,结算价,折扣,登记人,发货操作员,收货操作员】"
						+ "【条件内容,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号,《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣,《N》登记人,《N》发货操作员,《N》收货操作员 】"
						+ "【《N》发货店铺ID,"
						+ sender
						+ "】【《N》收货店铺ID,"
						+ receiver
						+ "】【《N》装箱号,"
						+ userInfo.getUserid()
						+ "】"
						+ "【《N》款号,"
						+ kh
						+ "】【《N》款式编号,"
						+ "】【《N》颜色,"
						+ "】"
						+ "【《N》尺码,"
						+ "】【《N》退货数量,1】【《N》成本,0"
						+ "】【《N》原价,0"
						+ "】【《N》现价,0"
						+ "】【《N》结算价,0"
						+ "】【《N》折扣,0】【《N》登记人," + djr 
						+ "】【《N》发货操作员," + userInfo.getUserid() 
						+ "】【《N》收货操作员,】");

		try {
			List thInfo = PubWSService.callWSRRToList(
					"83747e34-ad30-4028-ae74-b0a7f21a378f", "ITDC_EXCEL",
					"", map);
			if (thInfo != null && thInfo.size() != 0) {
				System.out.println(((Map) thInfo.get(0)).get("FLAG"));
				if("TRUE".equals(((Map) thInfo.get(0)).get("FLAG"))){ 
					tcjg = "ok";
					thdh = (String) ((Map) thInfo.get(0)).get("outindentid");
				}else if("FALSE".equals(((Map) thInfo.get(0)).get("FLAG"))){ 
					tcjg = "error";
					errorinfo = (String) ((Map) thInfo.get(0)).get("message");
				}
			} else {
				tcjg = "error";
			}

		} catch (Exception e) {
			tcjg = "error";
		}
		return thdh + "," + tcjg+ "," + errorinfo;
	}
	
	
	/**
	 * 发货带维修单号
	 */
	public String sendGoodsA(String sender,String receiver,String kh, UserInfo userInfo,
			String djr, String wxdh) {
		String thdh = "";
		String tcjg = "error"; 
		String errorinfo = "error"; 
		
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,NEW】【实体,发货】"
						+ "【新增内容,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,原价,现价,结算价,折扣,登记人,发货操作员,收货操作员】"
						+ "【条件内容,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号,《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣,《N》登记人,《N》发货操作员,《N》收货操作员 】"
						+ "【《N》维修单号,"
						+ wxdh
						+ "】【《N》发货店铺ID,"
						+ sender
						+ "】【《N》收货店铺ID,"
						+ receiver
						+ "】【《N》装箱号,"
						+ userInfo.getUserid()
						+ "】"
						+ "【《N》款号,"
						+ kh
						+ "】【《N》款式编号,"
						+ "】【《N》颜色,"
						+ "】"
						+ "【《N》尺码,"
						+ "】【《N》退货数量,1】【《N》成本,0"
						+ "】【《N》原价,0"
						+ "】【《N》现价,0"
						+ "】【《N》结算价,0"
						+ "】【《N》折扣,0】【《N》登记人," + djr 
						+ "】【《N》发货操作员," + userInfo.getUserid() 
						+ "】【《N》收货操作员,】");

		try {
			List thInfo = PubWSService.callWSRRToList(
					"83747e34-ad30-4028-ae74-b0a7f21a378f", "ITDC_EXCEL",
					"", map);
			if (thInfo != null && thInfo.size() != 0) {
				System.out.println(((Map) thInfo.get(0)).get("FLAG"));
				if("TRUE".equals(((Map) thInfo.get(0)).get("FLAG"))){ 
					tcjg = "ok";
					thdh = (String) ((Map) thInfo.get(0)).get("outindentid");
				}else if("FALSE".equals(((Map) thInfo.get(0)).get("FLAG"))){ 
					tcjg = "error";
					errorinfo = (String) ((Map) thInfo.get(0)).get("message");
				}
			} else {
				tcjg = "error";
			}

		} catch (Exception e) {
			tcjg = "error";
		}
		return thdh + "," + tcjg+ "," + errorinfo;
	}
	
	
	/**
	 * 收货
	 */
	public String receiveGoods(String Thdh,String sender,String receiver,String kh, UserInfo userInfo,
			String djr) {
		String tcjg = "ok";
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr",
				"【操作类型,NEW】【实体,收货】"
						+ "【新增内容,退货单号,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,原价,现价,结算价,折扣,登记人,发货操作员,收货操作员】"
						+ "【条件内容,《N》退货单号,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号,《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣,《N》登记人,《N》发货操作员,《N》收货操作员 】"
						+ "【《N》退货单号,"+Thdh+"】【《N》发货店铺ID,"
						+ sender
						+ "】【《N》收货店铺ID,"
						+ receiver
						+ "】【《N》装箱号,"
						+ userInfo.getUserid()
						+ "】"
						+ "【《N》款号,"
						+ kh
						+ "】【《N》款式编号,"
						+ "】【《N》颜色,"
						+ "】【《N》尺码,"
						+ "】【《N》退货数量,1】【《N》成本,0"
						
						+ "】【《N》原价,0"
						
						+ "】"
						+ "【《N》现价,0"
						
						+ "】【《N》结算价,0"
						
						+ "】【《N》折扣,0"
						+"】【《N》登记人," + djr 
						+ "】【《N》发货操作员,"  
						+ "】【《N》收货操作员,"+ userInfo.getUserid()+"】");

		try {
			List thInfo = PubWSService.callWSRRToList(
					"83747e34-ad30-4028-ae74-b0a7f21a378f", "ITDC_EXCEL",
					"", map);
			if (thInfo != null && thInfo.size() != 0
					&& "TRUE".equals(((Map) thInfo.get(0)).get("FLAG"))) {
				return "ok";
			} else {
				tcjg = "error";
			}

		} catch (Exception e) {
			tcjg = "error";
		}
		return tcjg;
	}
	

	/**
	 * 根据店铺ID获取店铺所属公司
	 * 
	 * @param depotID
	 * @return
	 * @throws Exception
	 */
	public String getComByDepot(String depotID) throws Exception {
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", "【操作类型,GET】【cono,HYFG】【店铺编号,"+depotID+"】");
		String s = PubWSService.callWSRR(
				"85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25", "DRPAS", "", map);
		List<Map> comList = PubWSService.callWSRRToList(
				"85dbcb75-af7e-4d63-9c5b-aaa6bbcc9c25", "DRPAS", "", map);
		if (comList == null || comList.size() == 0) {
			return "";
		} else {
			return (String) comList.get(0).get("CPY_NAME");
		}

	}

	public List querySupplierByStyleID(String kh) throws Exception{
		Map map = new HashMap();
		map.put("InputFormat", "AML");
		map.put("OutputContentType", "RS");
		map.put("ConditionStr", "【操作类型,GET】【实体,J_Supplier】【返回内容,供应商ID,供应商简称，供应商全称】【条件内容,《W》款号】" +
				"【《W》款号,"+kh+"】");
		List list = PubWSService.callWSRRToList(
				"8825e573-edaa-4858-8c57-abd959a2f608", "ITDC_EXCEL", "", map);
		return list;
	}
	
	
	/**
	 * 保存前检查维修单号是否存在，不存在返回false，存在返回True
	 * @param sql
	 * @return
	 */
	public boolean isDhExists(String sql){
		return mrdao.isDhExists(sql);
	}
	
	/**
	 * 查询同一个快递单剩余未判定的维修单数量
	 * @param sql
	 * @return
	 */
	public List queryRemainUnJudgeNum(String sql){
		return mrdao.queryRemainUnJudgeNum(sql);
	}
	
	
	/**
	 * 根据UERID从统一帐号管理平台获取用户姓名
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	public String getUserName(String userID) throws Exception{  
		String userName = userID;
		if(userID==null ||"".equals(userID)){
			return "";
		}  
		Map map = new HashMap();
		map.put("ENV_SN", "HZY_CYWX"); 
		map.put("App_UserName", userID);  
		
		List<Map> list = PubWSService.callWSRRToList("0a33a210-34e9-4ff6-bd99-76a45f427d33", "HZY_CYWX", "", map);  
		if( list!=null && list.size()>0 && list.get(0)!=null){  
			 //System.out.println(list.get(0).get("App_UserName_CN")); 
			return (String)list.get(0).get("App_UserName_CN");
			 
		} 
		return userID;

	}

	/**
	 * 根据款号获取品类
	 * @param kh
	 * @return
	 */
	public String getCategoryByKh(String kh){
		String category = "";
		String categoryCode = kh.substring(5, 6);
		if("9".equals(categoryCode)){
			category = "毛衫类";
		}else if("8".equals(categoryCode) || "M".equals(categoryCode) || "N".equals(categoryCode)){
			category = "大衣类";
		}else if("P".equals(categoryCode)){
			category = "皮装类";
		}else if("Q".equals(categoryCode)){
			category = "裘皮类";
		}else if("Y".equals(categoryCode)){
			category = "羽绒服类";
		}else if("1".equals(categoryCode)||
				"2".equals(categoryCode)||
				"3".equals(categoryCode)||
				"4".equals(categoryCode)||
				"5".equals(categoryCode)||
				"6".equals(categoryCode)||
				"7".equals(categoryCode)){
			category = "梭织类";
		}else {
			category = "服饰品类";
		}
		
		return category;
	}
	
	
	
	public static void main(String[] arg0) {
		String s="1234567";
		System.out.println(s.substring(5, 6));
	}
}
