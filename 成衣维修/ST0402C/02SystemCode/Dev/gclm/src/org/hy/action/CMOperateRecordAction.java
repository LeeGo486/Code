package org.hy.action;



import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import org.hy.service.ICMOperateRecordService;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 成衣维修操作日志ACTION类
 * @author yuxiaodong
 *
 */

@Namespace("/web")
@Results({
	    @Result(name = "queryOperateRecord", location = "/cm/cmOperateRecord.jsp")
	})
public class CMOperateRecordAction extends ActionSupport {
	private ICMOperateRecordService operateRecordService;

	public ICMOperateRecordService getOperateRecordService() {
		return operateRecordService;
	}

	public void setOperateRecordService(ICMOperateRecordService operateRecordService) {
		this.operateRecordService = operateRecordService;
	}
	
	private String zbguid;//成衣维修等级表主键

	public String getZbguid() {
		return zbguid;
	}

	public void setZbguid(String zbguid) {
		this.zbguid = zbguid;
	}
	
	public String queryCMOperateRecord(){
		return "queryOperateRecord";
	}
	
	
}
