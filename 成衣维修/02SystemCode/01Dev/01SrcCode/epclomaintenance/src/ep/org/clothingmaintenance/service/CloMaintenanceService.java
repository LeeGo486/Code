package ep.org.clothingmaintenance.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;



import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.dao.CloMaintenanceDao;

import ep.org.clothingmaintenance.dao.UserDao;
import ep.org.clothingmaintenance.form.CloMaintenanceForm;
import ep.org.clothingmaintenance.form.EidtMaintenanceBillForm;
import ep.org.clothingmaintenance.form.MaintenanceInfoListForm;

public class CloMaintenanceService {
	public String genarateGuid()throws Exception{
		return CloMaintenanceDao.genarateGuid();
	}
	
	public String genarateDH(String shopID,UserInfo userInfo) throws Exception{
		
		return CloMaintenanceDao.genarateDH(shopID,userInfo);
	}
	
	public List getBillState(){
		
		
		return null;
	}

	public List queryList(MaintenanceInfoListForm form,UserInfo userInfo)throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.queryList(form,userInfo);
		
	}
	
	public String getUserName(String userID) throws Exception{
		return UserDao.getUserName(userID);
	}
	
	public List getShopAllSelectData() throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getShopAllSelectData();
	}
	
	public Object viewMaintenanceBillInfo(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.viewMaintenanceBillInfo(guid);
	}
	
	public Object viewHQSendGoods(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.viewHQSendGoods(guid);
	}
	
	public Object viewAppraiseinfo(String guid)throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.viewAppraiseinfo(guid);
	}

	public boolean updateAppraise(MaintenanceBill bean,UserInfo userInfo) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.updateAppraise(bean,userInfo);
	}
	
	public List queryOperateRecord(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.queryOperateRecord(guid);
	}

	public Object getExpressData(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getExpressData(guid);
	}

	public Object getShopPrintData(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getShopPrintData(guid);
	}
	
	public List getImageInfo(String guid,String imageType) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getImageInfo(guid, imageType);
	}

	public int saveBill(EidtMaintenanceBillForm billForm,UserInfo userInfo) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.saveBill(billForm,userInfo);
	}

	public boolean sendBilltoHQ(CloMaintenanceForm form,UserInfo userInfo) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.sendBilltoHQ(form,userInfo);
	}
	
	public boolean saveBillPictrue(EidtMaintenanceBillForm form)throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.saveBillPictrue(form);
	}
	
	public void deletePicture(EidtMaintenanceBillForm billForm) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		dao.deletePicture(billForm);
	}
	
	public InputStream getImageData(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getImageData(guid);
	}
	
	public String checkUser(String userID,String pwd) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.checkUser(userID,pwd);
	}
	public String getComByDepot(String depotID) throws Exception {
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getComByDepot(depotID) ;
	}
	
	public List<Map<String, String>> getTransCos() throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.getTransCos();
		
	}
	public int deleteBill(String guid) throws Exception{
		CloMaintenanceDao dao = new CloMaintenanceDao();
		return dao.deleteBill(guid);
	}
}
