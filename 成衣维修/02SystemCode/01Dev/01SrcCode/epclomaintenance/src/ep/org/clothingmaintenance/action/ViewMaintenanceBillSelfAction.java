package ep.org.clothingmaintenance.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.form.ViewMaintenanceBillSelfForm;
import ep.org.clothingmaintenance.service.CloMaintenanceSelfService;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午04:26:13
 */

public class ViewMaintenanceBillSelfAction extends DispatchAction {
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String loginDeptID =request.getParameter("loginDeptID"); 
		String userID =request.getParameter("userID"); 
		ViewMaintenanceBillSelfForm viewForm = (ViewMaintenanceBillSelfForm) form;
		viewForm.setLoginDeptID(loginDeptID);
		viewForm.setUserID(userID);
		
		return mapping.findForward("viewMaintenanceInfoSelf");
	}
	
	
	public ActionForward viewInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ViewMaintenanceBillSelfForm viewForm = (ViewMaintenanceBillSelfForm) form;
		viewForm.setGuid(request.getParameter("guid"));
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		MaintenanceBill bean = (MaintenanceBill) service.viewMaintenanceBillInfo(viewForm.getGuid());
		viewForm.setGuid(bean.getGuid());
		viewForm.setZtTypeName(bean.getZtTypeName());
		viewForm.setDh(bean.getDh());
		viewForm.setDpbm(bean.getDpbm());
		viewForm.setDpmc(bean.getDpmc());
		viewForm.setDplx(bean.getDplx());
		viewForm.setDZXM(bean.getDZXM());
		viewForm.setDZLXDH(bean.getDZLXDH());
		viewForm.setSLDG(bean.getSLDG());
		viewForm.setDGLXDH(bean.getDGLXDH());
		viewForm.setSFTYFFWX(bean.getSFTYFFWX());
		viewForm.setVIPKH(bean.getVIPKH());
		viewForm.setGKXM(bean.getGKXM());
		viewForm.setGKLXDH(bean.getGKLXDH());
		viewForm.setSCSJ(bean.getSCSJ());
		viewForm.setJJCD(bean.getJJCD());
		viewForm.setKH(bean.getKH());
		viewForm.setTHRQ(bean.getTHRQ());
		viewForm.setWTMS(bean.getWTMS());
		viewForm.setBZXX(bean.getBZXX());
		viewForm.setDjr(bean.getDjr());
		viewForm.setDjsj(bean.getDjsj());
		viewForm.setZT(bean.getZT());
		viewForm.setWXDW(bean.getWXDW());
		viewForm.setYJWCSJ(bean.getYJWCSJ());
		viewForm.setSJWCSJ(bean.getSJWCSJ());
		viewForm.setFFJE(bean.getFFJE());
		if(viewForm.getJJCD()!=null && !viewForm.getJJCD().equals("")&&viewForm.getJJCD().equals("01")){
			viewForm.setJJCD("很急");
		}
		if(viewForm.getJJCD()!=null && !viewForm.getJJCD().equals("")&&viewForm.getJJCD().equals("02")){
			viewForm.setJJCD("急");
		}
		if(viewForm.getJJCD()!=null && !viewForm.getJJCD().equals("")&&viewForm.getJJCD().equals("03")){
			viewForm.setJJCD("一般");
		}
		return mapping.findForward("viewMaintenanceInfoSelf");
	}
}
