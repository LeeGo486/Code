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

import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.form.MaintenanceInfoListSelfForm;
import ep.org.clothingmaintenance.service.CloMaintenanceSelfService;
/**
  @description: 
  @author: 俞晓东
  @version：1.00
  @date：2012-4-25 下午03:28:27
 */

public class MaintenanceInfoListSelfAction extends DispatchAction {
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		
		String loginDeptID =request.getParameter("loginDeptID"); 
		String userID =request.getParameter("userID"); 
		MaintenanceInfoListSelfForm listForm = (MaintenanceInfoListSelfForm)form;
		if(listForm.getLoginDeptID() == null || "".equals(loginDeptID))
		{
			listForm.setLoginDeptID(loginDeptID);
		}
		listForm.setUserID(userID);
		
		//订单状态下拉列表框初始化
		List billStateList = new ArrayList();
		HashMap<String, String> billState = null;
		
		billState = new HashMap<String, String>();
		billState.put("stateCode", "");
		billState.put("stateName", "全部");
		billStateList.add(billState);
		
		billState = new HashMap<String, String>();
		billState.put("stateCode", "20");
		billState.put("stateName", "登记");//店铺登记
		billStateList.add(billState);
		
		billState = new HashMap<String, String>();
		billState.put("stateCode", "21");
		billState.put("stateName", "任务接受");
		billStateList.add(billState);
		
		billState = new HashMap<String, String>();
		billState.put("stateCode", "22");
		billState.put("stateName", "任务完成");
		billStateList.add(billState);

		request.setAttribute("billStateList", billStateList);
		
		
		
		
		//初始化店铺类类型
		List shopTypeList = new ArrayList();
		HashMap<String, String> shopType = null;
		
		shopType = new HashMap<String, String>();
		shopType.put("shopTypeCode", "");
		shopType.put("shopTypeName", "全部");
		shopTypeList.add(shopType);
		
		shopType = new HashMap<String, String>();
		shopType.put("shopTypeCode", "1");
		shopType.put("shopTypeName", "自营");
		shopTypeList.add(shopType);
		
		shopType = new HashMap<String, String>();
		shopType.put("shopTypeCode", "2");
		shopType.put("shopTypeName", "加盟");
		shopTypeList.add(shopType);
		
		request.setAttribute("shopTypeList", shopTypeList);
		
		//操作类型下拉列表初始化
		List operateList = new ArrayList();
		HashMap<String, String> operateMap = null;
		
		operateMap = new HashMap<String, String>();
		operateMap.put("stateCode", "");
		operateMap.put("stateName", "全部");
		operateList.add(operateMap);
		
		operateMap = new HashMap<String, String>();
		operateMap.put("stateCode", "20");//店铺登记
		operateMap.put("stateName", "登记");
		operateList.add(operateMap);
		
		operateMap = new HashMap<String, String>();
		operateMap.put("stateCode", "21");
		operateMap.put("stateName", "任务接受");
		operateList.add(operateMap);
		
		operateMap = new HashMap<String, String>();
		operateMap.put("stateCode", "22");
		operateMap.put("stateName", "完成状态");
		operateList.add(operateMap);
		
		
		request.setAttribute("operateList", operateList);
		
		return mapping.findForward("tomaintenanceInfoListSelf");
	}

	public ActionForward queryList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		MaintenanceInfoListSelfForm listForm = (MaintenanceInfoListSelfForm)form;
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user_info");
		CloMaintenanceSelfService service = new CloMaintenanceSelfService();
		
		request.setAttribute("recordlist", service.queryList(listForm,userInfo));
		init(mapping, listForm, request, response);
		
		
		
		
	
		return mapping.findForward("tomaintenanceInfoListSelf");
	}
}
