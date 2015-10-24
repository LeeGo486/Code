package org.hy.resteasyservice;

import java.io.IOException;
import java.io.OutputStream;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.hy.beans.base.PageView;
import org.hy.service.ILogisticsService;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
@Path(value = "/rest/logistics")
@Service
public class LogisticsRs {
	@Resource(name="logisticsService")
	private ILogisticsService logisticsService;

	public ILogisticsService getLogisticsService() {
		return logisticsService;
	}

	public void setLogisticsService(ILogisticsService logisticsService) {
		this.logisticsService = logisticsService;
	}
	
	@POST
	@Path("/page")
	@Produces("text/html;charset=GBK")
	public String queryOfPage(@Context HttpServletRequest request){
		int page = Integer.parseInt(request.getParameter("page"));
		int maxResult = Integer.parseInt(request.getParameter("rows"));
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String gs = request.getParameter("wlgs");
		String dh = request.getParameter("ydh");
		String fhdp = request.getParameter("fhdp");
		String shsj = request.getParameter("shsj");
		String zt = request.getParameter("zt");
		String wherejpql = "   1=1  " ;
		if(gs!=null && !gs.equals("")){
			wherejpql = wherejpql+" and  wlgs like '%"+gs+"%' ";
		}
		if(dh!=null && !dh.equals("")){
			wherejpql = wherejpql+" and  ydh like '%"+dh+"%' ";
		}
		
		if(fhdp!=null && !fhdp.equals("")){
			wherejpql = wherejpql+" and  fhdp like '%"+fhdp+"%' ";
		}
		
		if(shsj!=null && !shsj.equals("")){
			wherejpql = wherejpql+" and  convert(varchar,shsj,23)='"+shsj+"' ";
		}
		
		if(zt!=null && !zt.equals("")){
			wherejpql = wherejpql+" and  zt='"+zt+"' ";
		}
		
		wherejpql = wherejpql+" group by YDH,WLGS,FHDP,ZT";
		
		String sql = "select ydh,wlgs,fhdp,SUM(JS) js,MAX(FHSJ) fhsj,MAX(SHSJ) shsj,zt from cywxwlb where "+wherejpql;
		//System.out.println(wherejpql.toUpperCase().indexOf("GROUP")!=-1);
		String orderSql = null;
		if(sort!=null){
			orderSql = sql + " order by "+sort+" "+order;
		}else{
			orderSql = sql;
		}
		
		PageView pageView = new PageView(
				maxResult, page);
		pageView.setQueryResult(logisticsService.getScrollDataByNativeSql(
				pageView.getFirstResult(), maxResult, orderSql,"select count(1) from ("+sql+") aa", null));

		List list = pageView.getRecords();
		
		
		Gson gson = new Gson();
		
		String totalrecords = gson.toJson(pageView.getTotalRecord());
		String gs1 = gson.toJson(list);

		gs1 = " { \"total\":" + totalrecords + " , \"rows\": " + gs1 + " }";
		return gs1;
		
	}
	
	
	@POST
	@Path(value = "/getExcelList")
	 public String outPut(@Context HttpServletRequest request,@Context HttpServletResponse response) throws Exception{
		//导出数据查询条件
		//this.response = response;
		//int page = Integer.parseInt(request.getParameter("page"));
		//int maxResult = Integer.parseInt(request.getParameter("rows"));
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String gs = request.getParameter("wlgs");
		String dh = request.getParameter("ydh");
		String fhdp = request.getParameter("fhdp");
		String shsj = request.getParameter("shsj");
		String zt = request.getParameter("zt");
		//String selectFile=" o.ydh,o.wlgs,o.fhdp,o.js,o.fhsj,o.shsj,o.zt ";
		
		
		String wherejpql = " 1=1  " ;
		
		if(gs!=null && !gs.equals("")){
			wherejpql = wherejpql+" and  wlgs like '%"+gs+"%' ";
		}
		if(dh!=null && !dh.equals("")){
			wherejpql = wherejpql+" and  ydh like '%"+dh+"%' ";
		}
		
		if(fhdp!=null && !fhdp.equals("")){
			wherejpql = wherejpql+" and  fhdp like '%"+fhdp+"%' ";
		}
		
		if(shsj!=null && !shsj.equals("")){
			wherejpql = wherejpql+" and  convert(varchar,shsj,23)='"+shsj+"' ";
		}
		
		if(zt!=null && !zt.equals("")){
			wherejpql = wherejpql+" and  zt='"+zt+"' ";
		}
		
		
		String sql = "select ydh,wlgs,fhdp,SUM(JS) js,MAX(FHSJ) fhsj,MAX(SHSJ) shsj,zt  from cywxwlb where "+wherejpql+" group by YDH,WLGS,FHDP,ZT";
		
		PageView pageView = new PageView(
				-1, -1);
		pageView.setQueryResult(logisticsService.getScrollDataByNativeSql(
				-1, -1, sql,wherejpql, null));

		List list = pageView.getRecords();
		 setResponseHeader(response);  
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
	public void setResponseHeader(HttpServletResponse response) {
		try {
					
			response.setContentType("application/msexcel;charset=UTF-8"); // 两种方法都可以
			response.setContentType("application/octet-stream;charset=iso-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ java.net.URLEncoder.encode("物流信息.xls", "UTF-8"));
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
		
		row.createCell(0).setCellValue("快递单号");
		row.createCell(1).setCellValue("快递公司");
		row.createCell(2).setCellValue("发货店铺");
		row.createCell(3).setCellValue("件数");
		row.createCell(4).setCellValue("发货时间");
		row.createCell(5).setCellValue("收货时间");
		row.createCell(6).setCellValue("状态");
		
		
		for (int i = 0; i < 7; i++) {
			row.getCell(i).setCellStyle(style);
		}
		
		
	
		
		
		Map map = null;
		
		for (int i = 0; i < list.size(); i++) {
			map = (Map) list.get(i);
			row = sheet.createRow(i+1);
			row.createCell(0).setCellValue((String) map.get("ydh"));
			row.createCell(1).setCellValue((String) map.get("wlgs"));
			row.createCell(2).setCellValue((String) map.get("fhdp"));
			row.createCell(3).setCellValue(String.valueOf(map.get("js")));
			row.createCell(4).setCellValue(map.get("fhsj")==null?"":map.get("fhsj").toString());
			row.createCell(5).setCellValue(map.get("shsj")==null?"":map.get("shsj").toString());
			row.createCell(6).setCellValue((String) map.get("zt"));
		}
		try {
			book.write(os);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
