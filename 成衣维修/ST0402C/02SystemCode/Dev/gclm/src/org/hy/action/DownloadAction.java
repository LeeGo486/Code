package org.hy.action;



import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hy.beans.base.PageView;
import org.hy.model.MaintainRegister;
import org.hy.service.IMaintainRegisterService;
import org.hy.service.impl.MaintainRegisterServiceImpl;
import org.hy.spring.CustomerContextHolder;

import com.opensymphony.xwork2.ActionSupport;
@Namespace("/web")
@Action("download")
public class DownloadAction extends ActionSupport implements ServletResponseAware
{
	/**
	 * 测试类 未正式使用
	 */

	private String format = "xls";  
	private HttpServletResponse response;  
	private String fileName;
	private IMaintainRegisterService mrService= new MaintainRegisterServiceImpl();
    @Resource(name="mrService")
	public IMaintainRegisterService getMrService() {
		return mrService;
	}
	public void setMrService(IMaintainRegisterService mrService) {
		this.mrService = mrService;
	}
	
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;  
		this.fileName = "导出数据.xls";
	}
	 /**记住一定有该属性的set方法*/
	public void setServletResponse(HttpServletResponse response) {  
		this.response = response;
	}  
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	 public String outPut(){
		//导出数据查询条件
			int page = 1;
			int maxResult = 200;
			/*String dh	= request.getParameter("dh");
			String dp 	= request.getParameter("dp");
			String vipkh = request.getParameter("vipkh");
			String ydh 	= request.getParameter("ydh");
			String kh 	= request.getParameter("kh");
			String zt 	= request.getParameter("zt");
			String dd1 	= request.getParameter("dd1");
			String dd2 	= request.getParameter("dd2");
			String lx 	= request.getParameter("lx");
			String pl 	= request.getParameter("pl");
			//System.out.println(request.getParameter("status"));
			UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
			String wherejpql =" Branch= '"+userInfo.getCom()+"'";
			if("all".equals(message)){
			}else {
				wherejpql =wherejpql + " and o.zt in ("+message+")";
			};     

			if (null!=dh && !"".equals(dh)) {
				 wherejpql =wherejpql+" and o.dh like '%"+dh+"%'";
			}
			if (null!=dp&&!"".equals(dp)) {
				 wherejpql =wherejpql+" and o.dpmc like '%"+dp+"%'";
			}
			if (null!=vipkh && !"".equals(vipkh)) {
				 wherejpql =wherejpql+" and o.vipkh like '%"+vipkh+"%'";
			}
			if (null!=ydh && !"".equals(ydh)) {
				 wherejpql =wherejpql+" and o.ydh like '%"+ydh+"%'";
			}
			if (null!=kh && !"".equals(kh)) {
				 wherejpql =wherejpql+" and o.kh like '%"+kh+"%'";
			}
			if (null!=zt && !"".equals(zt)) {
				 wherejpql =wherejpql+" and o.zt = "+zt;
			}
			if (null!=dd1 && !"".equals(dd1)) {
				 wherejpql =wherejpql+" and o.djsj >= '"+dd1+"'";
			}
			if (null!=dd2 && !"".equals(dd2)) {
				 wherejpql =wherejpql+" and o.djsj <= '"+dd2+"'";
			}
			if (null!=lx && !"".equals(lx)) {
				if("0".equals(lx)){
					lx="1,2";
				}
				 wherejpql =wherejpql+" and o.dplx in ("+lx+")";
			}
			if (null!=pl && !"".equals(pl)) {
				 wherejpql =wherejpql+" and substring(o.kh,6,1) = '"+pl+"'";
			}*/
			String wherejpql  =" order by o.zt asc ,o.djsj desc ";
			System.out.println("列表查询条件"+wherejpql);
			//CustomerContextHolder.setCustomerType("x6");
			PageView<MaintainRegister> pageView = new PageView<MaintainRegister>(maxResult, page);
			pageView.setQueryResult(mrService.getScrollData(pageView.getFirstResult(), maxResult, wherejpql, null, null));
		 	List<MaintainRegister> list  = pageView.getRecords();
		 	
	System.out.println("导出");
	 setResponseHeader();  
	 try {  
	 	exportExcel(response.getOutputStream(),list);  
	 	response.getOutputStream().flush();  
	 	response.getOutputStream().close();  
	 } catch (IOException e) {  
	 	e.printStackTrace();  
	 }  
	 return null;  
	 }
	
	 
	/** 设置响应头 */
	public void setResponseHeader() {
		try {
			response.setContentType("application/msexcel;charset=UTF-8"); // 两种方法都可以
			response.setContentType("application/octet-stream;charset=iso-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ java.net.URLEncoder.encode(this.fileName, "UTF-8"));
			// 客户端不缓存
			response.addHeader("Pargam", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** 导出数据 */
	private void exportExcel(OutputStream os,List list) throws IOException {
		Workbook book = new HSSFWorkbook();
		Sheet sheet = book.createSheet("导出信息");
		org.apache.poi.ss.usermodel.Row row = sheet.createRow(0);
		// 生成一个样式
		CellStyle style = book.createCellStyle();
		// 设置样式
		style.setFillForegroundColor(HSSFColor.PALE_BLUE.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		
		row.createCell(0).setCellValue("维修单号");
		row.createCell(1).setCellValue("运单号");
		row.createCell(2).setCellValue("店铺编码");
		row.createCell(3).setCellValue("店铺名称");
		row.createCell(4).setCellValue("登记时间");
		row.createCell(5).setCellValue("退回日期");
		row.createCell(6).setCellValue("顾客姓名");
		row.createCell(7).setCellValue("VIP卡号");
		row.createCell(8).setCellValue("紧急程度");
		row.createCell(9).setCellValue("维修性质");
		row.createCell(10).setCellValue("问题点");
		row.createCell(11).setCellValue("起因");
		row.createCell(12).setCellValue("现象点");
		row.createCell(13).setCellValue("部位描述");
		row.createCell(14).setCellValue("品检判定时间");
		row.createCell(15).setCellValue("总部发货时间");
		row.createCell(16).setCellValue("判定处理方式");
		row.createCell(17).setCellValue("维修时间");
		
		for (int i = 0; i < 18; i++) {
			row.getCell(i).setCellStyle(style);
		}
		
		
	
		List<MaintainRegister> list1 = new ArrayList<MaintainRegister>();
		/*
		MaintainRegister mrinfo = new MaintainRegister();
		mrinfo.setDh(dh);
		list.add(mrinfo);*/
		list1=list;
		for (int i = 0; i < list1.size(); i++) {
			MaintainRegister mr = list1.get(i);
			row = sheet.createRow(i+1);
			row.createCell(0).setCellValue(mr.getDh());
		}
		try {
			book.write(os);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	
	
	
	
	//
	
	public InputStream getDownloadFile()
	{
		System.out.println("download");
		return ServletActionContext.getServletContext().getResourceAsStream( "/document/2012预算budget.xlsx");
	}
	
	
	@Override
	public String execute() throws Exception {
		
		return SUCCESS;
	}
	
	
	
	
}
