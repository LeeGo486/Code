package org.hy.dao;

import java.util.List;

import org.hy.dao.base.IBaseDao;
import org.hy.model.ClothingInfo;
import org.hy.model.Jdepot;
import org.hy.model.MaintainRegister;
import org.hy.model.UserInfo;
import org.hy.util.QueryBean;

public interface IJdepot extends IBaseDao<Jdepot>{

	/*
	 *  成衣维修登记查询条件
	 */
	//public List queryFilter();
	public List filterDp(String wherejpql,int firstindex,int maxresult);

	public List<QueryBean> getSldg(String wheresql);

	public String checkKh(String wheresql);

	
	
	
	
public String backStore(MaintainRegister model,UserInfo userInfo,ClothingInfo clothingInfo );
	
	public String getTHDH(UserInfo userInfo,String djr);
	
	public String getStyleID(String clothingid);
	
	public ClothingInfo getClothingPrice(String setDepotid,String getDepotid,String styleID);

}
