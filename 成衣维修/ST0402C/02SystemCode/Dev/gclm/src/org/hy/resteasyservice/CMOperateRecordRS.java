package org.hy.resteasyservice;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;

import org.hy.beans.base.PageView;
import org.hy.model.CMOperateRecord;
import org.hy.model.MaintainRegister;
import org.hy.service.ICMOperateRecordService;
import org.hy.spring.CustomerContextHolder;
import org.hy.spring.DynamicDataSourceType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
@Path(value = "/rest")
@Service
public class CMOperateRecordRS {
	@Autowired(required=false)
	@Qualifier("cmOperateRecordService")
	private ICMOperateRecordService operateRecordService;

	public ICMOperateRecordService getOperateRecordService() {
		return operateRecordService;
	}

	public void setOperateRecordService(ICMOperateRecordService operateRecordService) {
		this.operateRecordService = operateRecordService;
	}
	
	/**
	 * 根据传入的主表（成衣维修登记表）主键获取操作日志数据
	 * @param guid 
	 * @return List
	 */
	@POST
	@Path(value = "/queryCMOperateRecord/{guid}")
	public String queryCMOperateRecord(@PathParam(value = "guid") String guid,@Context HttpServletRequest request) {
		// TODO Auto-generated method stub
		int page = Integer.parseInt(request.getParameter("page"));
		int maxResult = Integer.parseInt(request.getParameter("rows"));
		//int pageIndex = Integer.parseInt((request.getParameter("page")));
		//int pageSize = Integer.parseInt((request.getParameter("rows")));
		//CustomerContextHolder.setCustomerType("x6");
		
		PageView<CMOperateRecord> pageView = new PageView<CMOperateRecord>(maxResult, page);
		pageView.setQueryResult(operateRecordService.getScrollData(pageView.getFirstResult(), maxResult, null, null, null));
	 	List operateRecords = pageView.getRecords();
	 	
		//List operateRecords =  operateRecordService.queryCMOperateRecord(guid,(pageIndex-1)*pageSize,pageSize);
		Gson gson = new Gson();
		return gson.toJson(operateRecords);
		
	}

}
