package ep.org.clothingmaintenance.action;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.form.CloMaintenanceForm;
import ep.org.clothingmaintenance.form.CloMaintenanceSelfForm;
import ep.org.clothingmaintenance.service.CloMaintenanceSelfService;
import ep.org.clothingmaintenance.service.CloMaintenanceService;

/**
  @description: 店铺自己维修
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午02:54:46
 */

public class CloMaintenanceSelfAction extends DispatchAction {
	
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			//String loginDeptID =request.getParameter("loginDeptID"); 
			
			CloMaintenanceSelfForm customerAnalysisFrom = (CloMaintenanceSelfForm) form;
			String userID = customerAnalysisFrom.getUserID();
			String pwd = (String)request.getSession().getAttribute("pwd");
			String com = "";  
			if(pwd==null || pwd.equals("")){
		
				userID =request.getParameter("userID"); 
				pwd = request.getParameter("pwd"); 
			}
			CloMaintenanceService service = new CloMaintenanceService(); 
			String[] loginDept = service.checkUser(userID, pwd).split("_");   
			if(loginDept==null || loginDept.equals("")||loginDept.length<2){
				return mapping.findForward("loginWrong");
			}
			String sessionID = loginDept[0];
			String loginDeptID = loginDept[1];
			String userName = loginDept[2];
			//System.out.println("loginDeptID:"+loginDeptID);
			//根据店铺编码获取所属公司
			com = service.getComByDepot(loginDeptID);
			if(com==null || com.equals("")){
				return mapping.findForward("loginWrong");
			} 
			request.getSession().setAttribute("pwd", pwd);
			//设置用户信息
			UserInfo userInfo = new UserInfo();  
			userInfo.setUserID(userID);
			userInfo.setPwd(pwd);
			userInfo.setLoginDeptID(loginDeptID);
			userInfo.setUserName(userName);
			userInfo.setSessionID(sessionID);    
			userInfo.setCom(com);   
			userInfo.setDeptName("");
			request.getSession().setAttribute("user_info",userInfo );
			
			customerAnalysisFrom.setLoginDeptID(loginDeptID);
			customerAnalysisFrom.setUserID(userID);
			request.setAttribute("userID", customerAnalysisFrom.getUserID());
			request.setAttribute("loginDeptID", customerAnalysisFrom.getLoginDeptID());
			request.setAttribute("pwd", pwd); 
			
			return mapping.findForward("cloMaintenanceMainSelf");
	}
	
	public ActionForward deleteBill(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		CloMaintenanceSelfForm cloMaintenanceForm = (CloMaintenanceSelfForm)form;
		CloMaintenanceSelfService service  = new CloMaintenanceSelfService();
		service.deleteBill(cloMaintenanceForm.getGuid());
		request.setAttribute("userID", cloMaintenanceForm.getUserID());
		request.setAttribute("loginDeptID", cloMaintenanceForm.getLoginDeptID());
		return mapping.findForward("cloMaintenanceMainSelf");
		
	}
}
