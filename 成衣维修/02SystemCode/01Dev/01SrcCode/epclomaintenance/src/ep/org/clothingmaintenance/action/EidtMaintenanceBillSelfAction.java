package ep.org.clothingmaintenance.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.form.EidtMaintenanceBilSelflForm;
import ep.org.clothingmaintenance.service.CloMaintenanceSelfService;
import ep.org.clothingmaintenance.util.DateUtil;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午03:29:48
 */

public class EidtMaintenanceBillSelfAction extends DispatchAction {
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		String loginDeptID =request.getParameter("loginDeptID"); 
		String userID =request.getParameter("userID"); 
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm)form;
		billForm.setDpbm(loginDeptID);
		billForm.setIsSaveFlag("false");
		billForm.setGuid(service.genarateGuid());
		billForm.setLoginDeptID(loginDeptID);
		billForm.setUserID(userID);
		billForm.setTHRQ(DateUtil.getFormatDate("yyyy-MM-dd"));
		billForm.setDjsj(DateUtil.getFormatDate("yyyy-MM-dd HH:mm"));
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info"); 
		billForm.setDjr(userInfo.getUserName());
		billForm.setZtTypeName("登记");
		billForm.setZT("20");
		billForm.setFFJE("0.0");
		List urgencyList = new ArrayList();
		HashMap<String, String> urgencyState = null;
		
		urgencyState = new HashMap<String, String>();
		
		urgencyState.put("stateCode", "");
		urgencyState.put("stateName", "");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		
		urgencyState.put("stateCode", "01");
		urgencyState.put("stateName", "很急");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "02");
		urgencyState.put("stateName", "急");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "03");
		urgencyState.put("stateName", "一般");
		urgencyList.add(urgencyState);
		
		request.setAttribute("urgencyList",urgencyList);
		
		List transCoList  = new ArrayList();
		HashMap<String, String> transCo = null;
		
		
		
		
		
		
	
		
		return mapping.findForward("eidtMaintenanceBillSelf");
	
		
	}
	
	
	public ActionForward viewEditBill(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm) form;
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		String loginDeptID =request.getParameter("loginDeptID"); 
		String userID =request.getParameter("userID");
		
		billForm.setIsSaveFlag("true");
		billForm.setLoginDeptID(loginDeptID);
		billForm.setUserID(userID);
		
		if(billForm.getTHRQ()==null || "".equals(billForm.getTHRQ())){
			billForm.setTHRQ(DateUtil.getFormatDate("yyyy-MM-dd HH:mm:ss"));
		}
		if(billForm.getDjsj()==null || "".equals(billForm.getDjsj())){
			billForm.setDjsj(DateUtil.getFormatDate("yyyy-MM-dd HH:mm:ss"));
		}
		billForm.setDjr(service.getUserName(userID));
		
		
		List urgencyList = new ArrayList();
		HashMap<String, String> urgencyState = null;
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "");
		urgencyState.put("stateName", "");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "01");
		urgencyState.put("stateName", "很急");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "02");
		urgencyState.put("stateName", "急");
		urgencyList.add(urgencyState);
		
		urgencyState = new HashMap<String, String>();
		urgencyState.put("stateCode", "03");
		urgencyState.put("stateName", "一般");
		urgencyList.add(urgencyState);
		
		request.setAttribute("urgencyList", urgencyList);
		
	
		//billForm.setGuid(request.getParameter("guid"));
		MaintenanceBill bean = (MaintenanceBill) service.viewMaintenanceBillInfo(billForm.getGuid());
		billForm.setDh(bean.getDh());
		billForm.setDpbm(bean.getDpbm());
		billForm.setDpmc(bean.getDpmc());
		billForm.setDplx(bean.getDplx());
		billForm.setDZXM(bean.getDZXM());
		billForm.setDZLXDH(bean.getDZLXDH());
	
		billForm.setSLDG(bean.getSLDG());
		billForm.setDGLXDH(bean.getDGLXDH());
		billForm.setSFTYFFWX(bean.getSFTYFFWX());
		billForm.setVIPKH(bean.getVIPKH());
		billForm.setGKXM(bean.getGKXM());
		billForm.setGKLXDH(bean.getGKLXDH());
		billForm.setSCSJ(bean.getSCSJ());
		billForm.setJJCD(bean.getJJCD());
		billForm.setKH(bean.getKH());
		billForm.setTHRQ(bean.getTHRQ());
		billForm.setWTMS(bean.getWTMS());
		billForm.setFHDZ(bean.getFHDZ());
		billForm.setBZXX(bean.getBZXX());
		billForm.setSFSF(bean.getSFSF());
		billForm.setDjr(bean.getDjr());
		billForm.setDjsj(bean.getDjsj());
		billForm.setZT(bean.getZT());
		if(billForm.getZtTypeName()==null || billForm.equals("")){
			billForm.setZtTypeName("登记");
		}
		
		billForm.setYS(bean.getYS());
		billForm.setMS(bean.getMS());
		billForm.setSldgCode(bean.getSldgCode());
		billForm.setDpTypeName(bean.getDpTypeName());
		billForm.setDpTypeCode(bean.getDpTypeCode());
		billForm.setDPDQ(bean.getDPDQ());
		billForm.setPP(bean.getPP());
		billForm.setWXDW(bean.getWXDW());
		billForm.setYJWCSJ(bean.getYJWCSJ());
		billForm.setSJWCSJ(bean.getSJWCSJ());
		billForm.setFFJE(bean.getFFJE());
		billForm.setSLDGXM(bean.getSLDGXM());
		return mapping.findForward("eidtMaintenanceBillSelf");
		
	}
	
	public ActionForward saveBill(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm) form;
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user_info");
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		if(billForm.getDh()==null || billForm.getDh().endsWith("")){
			billForm.setDh(service.genarateDH(billForm.getDpbm(),userInfo));
		}
		billForm.setZT("20");
		billForm.setZtTypeName("登记");
		int rs = service.saveBill(billForm,userInfo);
		billForm.setSaveState(Integer.toString(rs));
		
		
		viewEditBill(mapping, billForm, request, response);
		return mapping.findForward("eidtMaintenanceBillSelf");
	}
	
	public ActionForward sendBill (ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm) form;
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user_info");
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		if(billForm.getDh()==null || billForm.getDh().endsWith("")){
			billForm.setDh(service.genarateDH(billForm.getDpbm(),userInfo));
		}
		billForm.setZT("21");
		billForm.setZtTypeName("接受任务");
		int rs = service.saveBill(billForm,userInfo);
		if(rs==1){
			billForm.setSaveState("2");
		}
		viewEditBill(mapping, billForm, request, response);
		return mapping.findForward("eidtMaintenanceBillSelf");
	}

	public ActionForward viewCompleteBill(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm) form;
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		String loginDeptID =request.getParameter("loginDeptID"); 
		String userID =request.getParameter("userID");
		
		billForm.setIsSaveFlag("true");
		billForm.setLoginDeptID(loginDeptID);
		billForm.setUserID(userID);
		
		if(billForm.getTHRQ()==null || "".equals(billForm.getTHRQ())){
			billForm.setTHRQ(DateUtil.getFormatDate("yyyy-MM-dd HH:mm:ss"));
		}
		if(billForm.getDjsj()==null || "".equals(billForm.getDjsj())){
			billForm.setDjsj(DateUtil.getFormatDate("yyyy-MM-dd HH:mm:ss"));
		}
		billForm.setDjr(service.getUserName(userID));
		
		
	
	
		//billForm.setGuid(request.getParameter("guid"));
		MaintenanceBill bean = (MaintenanceBill) service.viewMaintenanceBillInfo(billForm.getGuid());
		billForm.setDh(bean.getDh());
		billForm.setDpbm(bean.getDpbm());
		billForm.setDpmc(bean.getDpmc());
		billForm.setDplx(bean.getDplx());
		billForm.setDZXM(bean.getDZXM());
		billForm.setDZLXDH(bean.getDZLXDH());
	
		billForm.setSLDG(bean.getSLDG());
		billForm.setDGLXDH(bean.getDGLXDH());
		billForm.setSFTYFFWX(bean.getSFTYFFWX());
		billForm.setVIPKH(bean.getVIPKH());
		billForm.setGKXM(bean.getGKXM());
		billForm.setGKLXDH(bean.getGKLXDH());
		billForm.setSCSJ(bean.getSCSJ());
		billForm.setJJCD(bean.getJJCD());
		billForm.setKH(bean.getKH());
		billForm.setTHRQ(bean.getTHRQ());
		billForm.setWTMS(bean.getWTMS());
		billForm.setFHDZ(bean.getFHDZ());
		billForm.setBZXX(bean.getBZXX());
		billForm.setSFSF(bean.getSFSF());
		billForm.setDjr(bean.getDjr());
		billForm.setDjsj(bean.getDjsj());
		billForm.setZT(bean.getZT());
		billForm.setZtTypeName("接受任务");
		billForm.setYS(bean.getYS());
		billForm.setMS(bean.getMS());
		billForm.setSldgCode(bean.getSldgCode());
		billForm.setDpTypeName(bean.getDpTypeName());
		billForm.setDpTypeCode(bean.getDpTypeCode());
		billForm.setDPDQ(bean.getDPDQ());
		billForm.setPP(bean.getPP());
		billForm.setWXDW(bean.getWXDW());
		billForm.setYJWCSJ(bean.getYJWCSJ());
		billForm.setSJWCSJ(bean.getSJWCSJ());
		billForm.setFFJE(bean.getFFJE());
		
		if(billForm.getJJCD()!=null && !billForm.getJJCD().equals("")&&billForm.getJJCD().equals("01")){
			billForm.setJJCD("很急");
		}
		if(billForm.getJJCD()!=null && !billForm.getJJCD().equals("")&&billForm.getJJCD().equals("02")){
			billForm.setJJCD("急");
		}
		if(billForm.getJJCD()!=null && !billForm.getJJCD().equals("")&&billForm.getJJCD().equals("03")){
			billForm.setJJCD("一般");
		}
		return mapping.findForward("completeMaintenanceBillSelf");
		
	}
	
	public ActionForward completeBill(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
		EidtMaintenanceBilSelflForm billForm = (EidtMaintenanceBilSelflForm) form;
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		String loginDeptID =request.getParameter("loginDeptID");
		billForm.setZT("22");
		billForm.setZtTypeName("完成");
		
		int rs = service.completeBill(billForm,loginDeptID);
		if(rs==1){
			request.setAttribute("result", "1");
		}
		viewCompleteBill(mapping, billForm, request, response);
		return mapping.findForward("completeMaintenanceBillSelf");
	}

}
