package org.hy.action;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hy.action.base.BaseActionSupport;
import org.hy.beans.base.PageView;
import org.hy.model.MaintainRegister;
import org.hy.model.UserInfo;
import org.hy.service.IMaintainRegisterService;
import org.hy.service.impl.MaintainRegisterServiceImpl;
import org.hy.spring.CustomerContextHolder;
import org.hy.util.QueryBean;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;

@Namespace("/web")

@Action("maintainregister")
@Results(
{ @Result(name = "success", location = "/cm/register/QueryList.jsp" ), 
@Result(name = "input", location = "/cm/register/index.jsp") })

public class MaintainRegisterAction extends BaseActionSupport  implements ServletResponseAware {

//	@Autowired(required = false)
//	@Qualifier("mrService")
 //  @Autowired //调用业务逻辑层
    
    private String format = "xls";  
	private HttpServletResponse response;  
	//private HttpServletRequest request;  
	
	private String fileName;
	
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

	
    @Resource(name="mrService")
	private IMaintainRegisterService mrService= new MaintainRegisterServiceImpl();
	private JSONObject returnjson;


	public IMaintainRegisterService getMrService() {
		return mrService;
	}


	public void setMrService(IMaintainRegisterService mrService) {
		this.mrService = mrService;
	}

	public JSONObject getReturnjson() {
		return returnjson;
	}


	public void setReturnjson(JSONObject returnjson) {
		this.returnjson = returnjson;
	}
	
	
	
	public String execute() throws Exception
	{
		
		System.out.println("struts调用没问题");
		ActionContext ctx = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) ctx.get(ServletActionContext.HTTP_REQUEST);
		int maxResult = 5;
		PageView<MaintainRegister> pageView = new PageView<MaintainRegister>(maxResult, getPage());
		pageView.setQueryResult(mrService.getScrollData(pageView.getFirstResult(), maxResult));
	 
		Gson gson = new Gson();
		
		String gs = gson.toJson(pageView.getRecords());
		JSONObject.fromObject(pageView);
		System.out.println(gs);
		System.out.println(JSONObject.fromObject(pageView));
		returnjson = JSONObject.fromObject(pageView);
		/**
		 * request.setAttribute("pageView", pageViewageView
		 */
		//request.setAttribute("pageView", pageView);
		 return SUCCESS;
	}
		 
	
	public String outPut(){
		ActionContext ctx = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest) ctx.get(ServletActionContext.HTTP_REQUEST);
			//导出数据查询条件'
				int page = 1;
				int maxResult = 100000;
				String sort = request.getParameter("sort");
				String order = request.getParameter("order");
				
				String dh	= request.getParameter("dh");
				String dp 	= request.getParameter("dp");
				String vipkh = request.getParameter("vipkh");
				String ydh 	= request.getParameter("ydh");
				String kh 	= request.getParameter("kh");
				String zt 	= request.getParameter("zt");
				String closed 	= request.getParameter("closed");
				String zturl 	= request.getParameter("zturl");
				String dd1 	= request.getParameter("dd1");
				String dd2 	= request.getParameter("dd2");
				String lx 	= request.getParameter("lx");
				String pl 	= request.getParameter("pl");
				//System.out.println(request.getParameter("status"));
				UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
				String newCom = "('" + userInfo.getCom().replaceAll(",", "','") + "')";
				String wherejpql =" Branch in "+newCom+" and o.closed = '"+closed+"'";
				if("all".equals(zturl)){
				}else {
					wherejpql =wherejpql + " and o.zt in ("+zturl+")";
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
				}
				LinkedHashMap<String, String> orderby =  new LinkedHashMap<String, String>();
				if(null!=sort && !"".equals(sort)){
					orderby.put(sort, order);
				}else{
					orderby.put("zt", "asc");
					orderby.put("djsj", "desc");
				}
				
				//System.out.println("列表查询条件"+wherejpql);
 				//CustomerContextHolder.setCustomerType("x6");
				PageView<MaintainRegister> pageView = new PageView<MaintainRegister>(maxResult, page);
				pageView.setQueryResult(mrService.getScrollData(pageView.getFirstResult(), maxResult, wherejpql, null, orderby));
			 	List<MaintainRegister> list  = pageView.getRecords();
			 	
			 		String wheresql = "    SELECT FCODE,FSCOPE, FCONTENT  FROM SCFX_TYBMB where fscope in('成衣维修状态','成衣问题现象点','成衣问题起因','成衣问题点' ) ";
			 		List<QueryBean> tybmname = mrService.getTybmb(wheresql);

			 	for (int i = 0; i < list.size(); i++) {
			 		String ztcode = list.get(i).getZt();
			 		String wtdcode = list.get(i).getWtd1();
			 		String xxdcode = list.get(i).getXxd1();
			 		String qycode = list.get(i).getQy1();
					for (int j = 0; j < tybmname.size(); j++) {
						String fcode = tybmname.get(j).getFcode();
						String fscope = tybmname.get(j).getFscope();
				 		String fcontent = tybmname.get(j).getFcontent();
						if("成衣维修状态".equals(fscope)){
							if(fcode.equals(ztcode)){
				 				list.get(i).setZt_name(fcontent);
							}
						}
						if("成衣问题点".equals(fscope)){
							if(fcode.equals(wtdcode)){
				 				list.get(i).setWtd_name(fcontent);
							}
						}
						if("成衣问题现象点".equals(fscope)){
							if(fcode.equals(xxdcode)){
				 				list.get(i).setXxd_name(fcontent);
							}
						}
						if("成衣问题起因".equals(fscope)){
							if(fcode.equals(qycode)){
				 				list.get(i).setQy_name(fcontent);
							}
						}
					}
				}
			 	
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
			this.fileName="导出excel.xls";
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
			Sheet sheet = book.createSheet("成衣维修");
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
			row.createCell(4).setCellValue("款号");
			row.createCell(5).setCellValue("状态");
			row.createCell(6).setCellValue("登记时间");
			row.createCell(7).setCellValue("退回日期");
			row.createCell(8).setCellValue("顾客姓名");
			row.createCell(9).setCellValue("VIP卡号");
			row.createCell(10).setCellValue("紧急程度");
			row.createCell(11).setCellValue("维修性质");
			row.createCell(12).setCellValue("问题点");
			row.createCell(13).setCellValue("起因");
			row.createCell(14).setCellValue("现象点");
			row.createCell(15).setCellValue("问题描述");
			row.createCell(16).setCellValue("品检判定时间");
			row.createCell(17).setCellValue("总部发货时间");
			row.createCell(18).setCellValue("判定处理方式");
			row.createCell(19).setCellValue("维修时间");
			row.createCell(20).setCellValue("退货单号");
			
			for (int i = 0; i < 21; i++) {
				row.getCell(i).setCellStyle(style);
			}
			
			
		
		List<MaintainRegister> list1 = new ArrayList<MaintainRegister>();
		/*	MaintainRegister mrinfo = new MaintainRegister();
			mrinfo.setDh(dh);
			list.add(mrinfo);*/
			list1=list;
			
			for (int i = 0; i < list1.size(); i++) {
				MaintainRegister mr = list1.get(i);
				row = sheet.createRow(i+1);
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//定义格式，不显示毫秒
				row.createCell(0).setCellValue(mr.getDh());
				row.createCell(1).setCellValue(mr.getYdh());
				row.createCell(2).setCellValue(mr.getDpbm());
				row.createCell(3).setCellValue(mr.getDpmc());	
				row.createCell(4).setCellValue(mr.getKh());
				row.createCell(5).setCellValue(mr.getZt_name());
				
				String djsj = null==mr.getDjsj()?"":df.format(mr.getDjsj());
				row.createCell(6).setCellValue(djsj);
				String thrq = null==mr.getThrq()?"":df.format(mr.getThrq());
				row.createCell(7).setCellValue(thrq);
				row.createCell(8).setCellValue(mr.getGkxm());
				row.createCell(9).setCellValue(mr.getVipkh());
				String jjcd = "";
				if("01".equals(mr.getJjcd())){
					jjcd = "一般";
				}else if("02".equals(mr.getJjcd())) {
					jjcd = "紧急";
				}else if("03".equals(mr.getJjcd())) {
					jjcd = "非常急";
				}
				row.createCell(10).setCellValue(jjcd);
				String wxxz = "";
				if("1".equals(mr.getWxxz1())){
					wxxz = "帮忙维修";
				}else if("2".equals(mr.getWxxz1())) {
					wxxz = "质量维修";
				}
				row.createCell(11).setCellValue(wxxz);
				row.createCell(12).setCellValue(mr.getWtd_name());
				row.createCell(13).setCellValue(mr.getQy_name());
				row.createCell(14).setCellValue(mr.getXxd_name());
				row.createCell(15).setCellValue(mr.getWtms());
				
				String s1 = null==mr.getPjpdsj()?"":df.format(mr.getPjpdsj());
				row.createCell(16).setCellValue(s1);
				String s2 = null==mr.getZbfhBzrq()?"":df.format(mr.getZbfhBzrq());
				row.createCell(17).setCellValue(s2);
				String pdclfs = "";
				if("1".equals(mr.getPdclfs())){
					pdclfs = "产品退仓";
				}else if("2".equals(mr.getPdclfs())) {
					pdclfs = "不能维修，退回店铺";
				}else if("3".equals(mr.getPdclfs())) {
					pdclfs = "可以维修";
				}
				row.createCell(18).setCellValue(pdclfs);
				String s3 = null==mr.getWxsj()?"":df.format(mr.getWxsj());
				row.createCell(19).setCellValue(s3);
				
				row.createCell(20).setCellValue(mr.getThdh());
			}
			try {
				book.write(os);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	
}
