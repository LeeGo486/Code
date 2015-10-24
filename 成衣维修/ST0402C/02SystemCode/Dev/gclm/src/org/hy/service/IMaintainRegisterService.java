package org.hy.service;

import java.util.List;

import org.hy.beans.base.QueryResult;
import org.hy.dao.base.IBaseDao;
import org.hy.model.MaintainRegister;
import org.hy.model.Ppwxcdyb;
import org.hy.model.UserInfo;
import org.hy.model.Ysgsxxb;
import org.hy.util.QueryBean;
 
/**
 * 
 * @author <a href="" target="_blank">Liuwei</a>
 * @notes Created on 2012-09-17<br>
 *        Revision of last commit:$Revision: 633 $<br>
 *        Author of last commit:$Author: liuwei@elegant-prosper.com $<br>
 *         <br>
 *        <p>
 */
public interface IMaintainRegisterService extends IBaseDao<MaintainRegister> {
	/**
	 * 
	 * @param value 
	 *             
	 * @return  
	 */      
//	public abstract List<MaintainRegister> findByName(String value);

	public List filterDp(String sessionID,String p,String com) throws Exception ;
	public List filterDpByName(String sessionID,String p,String com) throws Exception;
	public List<QueryBean> filterZt(String sql);

	public List<Ppwxcdyb> filterWxc(String sql);

	public void saveRegister(MaintainRegister mrlist);

	public List getSldg(String sessionID,String depotID) throws Exception;

	public String getWxdh(String sql);

	public  QueryResult<Ysgsxxb> getYsgs();

	public List<QueryBean> getWtd(String wheresql);

	public List<QueryBean> getQy(String wheresql);

	public List<QueryBean> getXxd(String wheresql);

	public List<QueryBean> getTybmb(String wheresql);

	public List checkKh(String sessionID,String clothingID) throws Exception;
	
	/**
	 * 发货
	 * @param model
	 * @param userInfo
	 * @param djr 
	 * @return
	 */
	public String sendGoods(String sender,String receiver,String kh, UserInfo userInfo, String djr );
	
	
	/**
	 * 发货带维修单号
	 * @param model
	 * @param userInfo
	 * @param djr 
	 * @return
	 */
	public String sendGoodsA(String sender,String receiver,String kh, UserInfo userInfo, String djr, String wxdh );
	
	/**
	 * 收货
	 */
	public String receiveGoods(String Thdh,String sender,String receiver,String kh, UserInfo userInfo,
			String djr);
	
	
	/**
	 * 根据店铺ID获取店铺所属公司
	 * @param depotID
	 * @return
	 * @throws Exception
	 */
	public String getComByDepot(String depotID) throws Exception;
	
	/**
	 * 根据款式ID获取供应商
	 * @param styleID
	 * @return
	 * @throws Exception
	 */
	public List querySupplierByStyleID(String styleID) throws Exception;
	
	/**
	 * 保存前检查维修单号是否存在，不存在返回false，存在返回True
	 * @param sql
	 * @return
	 */
	public boolean isDhExists(String sql);
	
	
	/**
	 * 查询同一个快递单剩余未判定的维修单数量
	 * @param sql
	 * @return
	 */
	public List queryRemainUnJudgeNum(String sql);
	
	/**
	 * 根据UERID从统一帐号管理平台获取用户姓名
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	public String getUserName(String userID) throws Exception;
	
	
	/**
	 * 根据款号获取品类
	 * @param kh
	 * @return
	 */
	public String getCategoryByKh(String kh);
	
}
