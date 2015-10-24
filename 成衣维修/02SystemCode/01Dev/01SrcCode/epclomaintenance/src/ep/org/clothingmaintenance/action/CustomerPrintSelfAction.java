package ep.org.clothingmaintenance.action;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import ep.org.clothingmaintenance.bean.MaintenanceBill;
import ep.org.clothingmaintenance.form.CustomerPrintForm;
import ep.org.clothingmaintenance.form.CustomerPrintSelfForm;
import ep.org.clothingmaintenance.service.CloMaintenanceSelfService;
import ep.org.clothingmaintenance.service.CloMaintenanceService;

/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-5-7 下午04:02:15
 */

public class CustomerPrintSelfAction extends DispatchAction {
	public ActionForward getShopPrintData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String guid = request.getParameter("guid");
		CustomerPrintSelfForm customerPrintForm = (CustomerPrintSelfForm)form;
		customerPrintForm.setGuid(guid);
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		MaintenanceBill bean = (MaintenanceBill) service.getShopPrintData(guid);
		
		customerPrintForm.setDh(bean.getDh());
		customerPrintForm.setPP(bean.getPP());
		customerPrintForm.setDpmc(bean.getDpmc());
		customerPrintForm.setGKWX(bean.getGKWX());
		customerPrintForm.setDZXM(bean.getDZXM());
		customerPrintForm.setGKXM(bean.getGKXM());
		customerPrintForm.setGKLXDH(bean.getGKLXDH());
		customerPrintForm.setDZLXDH(bean.getDZLXDH());
		customerPrintForm.setVIPKH(bean.getVIPKH());
		customerPrintForm.setSLDG(bean.getSLDG());
		customerPrintForm.setDGLXDH(bean.getDGLXDH());
		customerPrintForm.setSFTYFFWX(bean.getSFTYFFWX());
		customerPrintForm.setKH(bean.getKH());
		customerPrintForm.setYS(bean.getYS());
		customerPrintForm.setMS(bean.getMS());
		customerPrintForm.setSCSJ(bean.getSCSJ());
		customerPrintForm.setWTMS(bean.getWTMS());
		customerPrintForm.setFHDZ(bean.getFHDZ());
		customerPrintForm.setTHRQ(bean.getTHRQ());
		customerPrintForm.setYJWCSJ(bean.getYJWCSJ());
		return mapping.findForward("toCustomerPrintSelf");
	}
}
