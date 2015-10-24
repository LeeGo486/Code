package ep.org.clothingmaintenance.service;

import java.util.List;

import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.dao.CloMaintenanceDao;
import ep.org.clothingmaintenance.dao.CloMaintenanceSelfDao;
import ep.org.clothingmaintenance.dao.UserDao;
import ep.org.clothingmaintenance.form.EidtMaintenanceBilSelflForm;
import ep.org.clothingmaintenance.form.EidtMaintenanceBillForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListSelfForm;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午05:06:56
 */

public class CloMaintenanceSelfService {
	
	
	
	public List queryList(MaintenanceInfoListSelfForm form,UserInfo userInfo) throws Exception {
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.queryList(form,userInfo);
		
	}
	
	public String genarateGuid()throws Exception{
		return CloMaintenanceDao.genarateGuid();
	}

	public String getUserName(String userID) throws Exception{
		return UserDao.getUserName(userID);
	}
	
	public Object viewMaintenanceBillInfo(String guid) throws Exception{
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.viewMaintenanceBillInfo(guid);
	}

	public String genarateDH(String shopID,UserInfo userInfo) throws Exception{
		
		return CloMaintenanceSelfDao.genarateDH(shopID,userInfo);
	}
	
	public int saveBill(EidtMaintenanceBilSelflForm billForm,UserInfo userInfo) throws Exception {
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.saveBill(billForm,userInfo);
	}
	
	public Object getShopPrintData(String guid) throws Exception{
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.getShopPrintData(guid);
	}
	
	public int completeBill(EidtMaintenanceBilSelflForm billForm,String loginDeptID) throws Exception {
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.completeBill(billForm,loginDeptID);
	}
	
	public int deleteBill(String guid) throws Exception{
		CloMaintenanceSelfDao dao = new CloMaintenanceSelfDao();
		return dao.deleteBill(guid);
	}
}
