package org.apache.jsp.expense;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.branch.expense.dojo.TripExpenseInfo;
import ep.org.branch.expense.dojo.TripExpenseDetail;

public final class tripExpenseApplyPrint_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>差旅费申请单打印</title>\r\n");
      out.write("    \r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("  \r\n");
      out.write("  \t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print( path);
      out.write("/css/mycommon.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/myjs/myTime.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/js/jquery-1.5.2.min.js\"></script>\r\n");
      out.write("\t</head>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write(" function Print() {  \r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\ttry{\r\n");
      out.write("\t\t\tif (document.all.eprint.defaultPrinterName.length==0){\r\n");
      out.write("\t\t\talert(\"请先安装打印机，再执行此功能！\");\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("  \t    eprint.InitPrint();\r\n");
      out.write("  \t    eprint.marginTop=1;\r\n");
      out.write("  \t\teprint.marginLeft=10;\r\n");
      out.write(" \t\teprint.marginRight=10;\r\n");
      out.write("  \t\teprint.marginBottom=1;\r\n");
      out.write("  \t\teprint.header = \"\";\r\n");
      out.write("  \t\teprint.footer = \"\";\r\n");
      out.write("  \t\teprint.Print();\r\n");
      out.write("\t\twindow.close();\r\n");
      out.write("\t//document.all.eprint.Print(true);//不弹出打印对话框直接打印\r\n");
      out.write("\t}catch(e){\r\n");
      out.write("\t\tinitForm();\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function initForm(){\r\n");
      out.write("\ttry{\r\n");
      out.write("\t\tif (document.all.eprint.defaultPrinterName.length==0){\r\n");
      out.write("\t\talert(\"请先安装打印机，再执行此功能！\");\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\tcatch(e){\r\n");
      out.write("\t\r\n");
      out.write("\t\tvar url=document.getElementById(\"webContext\").value+'/expense/webprintDownload.jsp';\r\n");
      out.write("\t\twindow.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write("\t}\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("  \r\n");
      out.write(" </script>\r\n");
      out.write("\t<body  onload=\"Print()\">\r\n");
      out.write("\t\t<object id=\"eprint\" classid=\"clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441\"  viewasext> </object>\r\n");
      out.write("   \t\t");
TripExpenseInfo tripExpenseInfo = (TripExpenseInfo)request.getAttribute("tripExpenseInfo");
      out.write("\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t\r\n");
      out.write("   <div style=\"position:relative;width: 95%;height: 100%; left: 30 \">\r\n");
      out.write("   <div align=\"center\" style=\"height: 20\"><img alt=\"\" src=\"");
      out.print(path );
      out.write("/img/image2.png\"></div>\r\n");
      out.write("    \r\n");
      out.write("    <div style=\"position:absolute;top: 50;z-index: 1\">\r\n");
      out.write("    <div align=\"center\" style=\"height: 50\">\r\n");
      out.write("    \t\r\n");
      out.write("    <font style=\"font-weight: 600;font-size: 18\">Business Trip Expenses Note</font> <br> <font  style=\"font-weight: 600;font-size: 18\">差 旅 费 报 销 单\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("     </font>  </div>\r\n");
      out.write("    \r\n");
      out.write("    <div align=\"right\" style=\"position: absolute;top: 2;right: 0%\">\r\n");
      out.write("   \t <img alt=\"\" src=\"");
      out.print(path);
      out.write("/barcode.bracodeServlet?image=1&type=21&data=");
      out.print(tripExpenseInfo.getExpenseNo() );
      out.write("&height=50\" >\r\n");
      out.write("  \t</div>\r\n");
      out.write("    \t<br />\r\n");
      out.write("    \r\n");
      out.write("   \r\n");
      out.write("   \r\n");
      out.write("     ");
      out.write("\r\n");
      out.write("    <table width=\"100%\" cellPadding=0 cellSpacing=0  frame=box style=\"BORDER-COLLAPSE: collapse;\" bgColor=white borderColor=black>\t\t\r\n");
      out.write("    <tr>\r\n");
      out.write("    \t\t<td height=\"30\" class=\"td_field_thin\" colspan=\"3\">Name/出差人姓名\t<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getTripName() );
      out.write("\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"3\">Code/职员编码<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getEmployeeID() );
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t </td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"3\">Dept/部门\t<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getBranchName() );
      out.write("\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"3\">Cost center/成本中心代码<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getCostCenter() );
      out.write("\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"2\">Telephone/电话\t\t<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getTelephone());
      out.write("\t\t\t\t\t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td height=\"30\" class=\"td_field_thin\" colspan=\"5\">Places for trip/出差地点\t<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getTripAddress() );
      out.write("\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"5\">Purposes for trip/出差事由\t<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getTripPurposes() );
      out.write("\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"3\">Accompanied by/随同人员<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getTripMenber());
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write(" \t\t\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">Date/日期<br />\r\n");
      out.write("    \t\t\t");
      out.print(tripExpenseInfo.getApplyDate() );
      out.write("\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td  colspan=\"14\" class=\"td_field_thin\" height=\"30\">Charged to/and Reasons其他付款说明：<br />\r\n");
      out.write("    \t\t");
      out.print(tripExpenseInfo.getPayComment() );
      out.write("\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td align=\"center\" colspan=\"3\"  class=\"td_field_thin\">DEPARTURE<br />出      发\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td align=\"center\" colspan=\"3\"  class=\"td_field_thin\">ARRIVAL<br />到    达\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td align=\"center\" colspan=\"2\"  class=\"td_field_thin\">MILEAGE  <br />    里 程\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td align=\"center\" colspan=\"6\"  class=\"td_field_thin\">TRANSPORTATION&HOTEL&ALLOWANCES <br /> 交通和住宿费和补贴费\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td align=\"center\" class=\"td_field_thin\" width=\"7.6%\">From<br/> 起点</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"5.6%\">M<br/>月</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"5.6%\">D<br/>日</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"7.6%\">To<br/>终点</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"5.6%\">M<br/>月</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"5.6%\">D<br/>日</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"8.6%\">Km<br/>公里</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"8.6%\">Gasoline<br/>汽油费</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"7.6%\">rain<br/>火车票</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"7.6%\">Taxi<br/>出租车</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"8.6%\">Airplane<br/>飞机票</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"8.6%\">Others<br/>其他交通</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" width=\"8.6%\">Hotel<br/>住宿费（    定额）\r\n");
      out.write("   \t\t\t</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" >Meal&Allowance<br/>餐费和补贴（   定额）</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("\t\t");
List  detailList =(List)request.getAttribute("detailList"); 
		   for(int i=0;i<detailList.size();i++){
    			   	 TripExpenseDetail detail = (TripExpenseDetail) detailList.get(i);
					 String bgnDate = detail.getFromDate();
					 String endDate = detail.getToDate();
		 			 
		 			 String bgnMonth = "";
		 			 String bgnDay = "";
		 			 String endMonth = "";
		 			 String endDay = "";
		 			 String[] bgn = new String[1];
		 			 String[] end = new String[1];
		 			 
		 			 if(bgnDate!=null){
		 			 	bgn = bgnDate.split("-");
		 			  }
		 			 if(endDate!=null){
		 			 	end = endDate.split("-");
		 			  } 
		 			  if(bgn.length>=2){
		 			  	bgnMonth = bgn[1];
		 			  }
		 			  if(bgn.length==3){
		 			  	bgnDay =bgn[2];
		 			  }
		 			  if(end.length>=2){
		 			  	endMonth = bgn[1];
		 			  }
		 			  if(end.length==3){
		 			  	endDay =bgn[2];
		 			  } 
		 
		 
      out.write("    \r\n");
      out.write("   \t\t<tr>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getFromAdress() );
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print(bgnMonth );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print(bgnDay  );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print( detail.getToAdress());
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print(endMonth );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"center\" class=\"td_field_thin\" height=\"25\">");
      out.print(endDay );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getKM()==null?"": detail.getKM());
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getGasolineCost()==null?"": detail.getGasolineCost());
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getTrainCost()==null?"": detail.getTrainCost() );
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getTaxiCost()==null?"": detail.getTaxiCost() );
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getAirplaneCost()==null?"": detail.getAirplaneCost() );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getOthers()==null?"": detail.getOthers() );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getHotelCost()==null?"": detail.getHotelCost() );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" class=\"td_field_thin\" height=\"25\">");
      out.print(detail.getMeal_allowance_cost()==null?"": detail.getMeal_allowance_cost() );
      out.write(" </td>\r\n");
      out.write("   \t\t</tr>\r\n");
      out.write("\t\t\r\n");
      out.write("\r\n");
      out.write("    \t\r\n");
      out.write("    \t");
} 
      out.write("\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"3\" height=\"35\">Attachments<br/> 附件： ");
      out.print(tripExpenseInfo.getAttachments() );
      out.write("  P/张</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td class=\"td_field_thin\"  colspan=\"4\" >Subtotal/费用小计</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("gasolineCost") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("trainCost") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("taxiCost") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("airplaneCost") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("others") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("hotelCost") );
      out.write("</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\">");
      out.print(request.getAttribute("meal_allowance_cost") );
      out.write("</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td height=\"35\" class=\"td_field_thin\" align=\"center\" colspan=\"2\">Total<br/> 费用总计\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td class=\"td_field_thin\"  colspan=\"4\">In Figure/小写:\r\n");
      out.write("    \t\t\t\t\t");
      out.print(tripExpenseInfo.getTotalMoney() );
      out.write("\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"8\"> In Captial/大写：\t\t\t\t\t\t\t\t\r\n");
      out.write("    \t\t\t");
      out.print(request.getAttribute("totalMoneyCN") );
      out.write("\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td  height=\"30\" class=\"td_field_thin\" colspan=\"7\">The temporary Cash Advance remainder/临时借款余额\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td  height=\"30\" class=\"td_field_thin\" colspan=\"2\">\t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td height=\"30\"  class=\"td_field_thin\" colspan=\"5\" rowspan=\"3\" align=\"center\">The actual payment 实际支付金额：<font style=\"text-decoration: underline; \"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </font>                     元（出纳填写<br/> Filled by Cashier ）\t\t\t\t\t\t\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td height=\"30\" class=\"td_field_thin\" colspan=\"9\" align=\"left\">Offset Cash Advance 抵冲借款：    <br />     \t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; \r\n");
      out.write("\t\t\t\t&nbsp;&nbsp;<input type=\"checkbox\">  Yes是 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;      <input type=\"checkbox\">No否\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td height=\"30\" class=\"td_field_thin\" colspan=\"7\">The amount to offset Cash Advance/抵冲借款金额\r\n");
      out.write("\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t<td  height=\"30\" class=\"td_field_thin\" colspan=\"2\">\t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    </table>\r\n");
      out.write("   \r\n");
      out.write("  \r\n");
      out.write("    <table width=\"100%\" height=\"3\" cellPadding=0 cellSpacing=0  frame=box style=\"BORDER-COLLAPSE: collapse;\" bgColor=white borderColor=black >\r\n");
      out.write("    \t<tr >\r\n");
      out.write("    \t\t<td height=\"1\">\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    </table>\t\r\n");
      out.write("    \r\n");
      out.write("     ");
      out.write("\r\n");
      out.write("    <table width=\"100%\" cellPadding=0 cellSpacing=0  frame=box style=\"BORDER-COLLAPSE: collapse;\" bgColor=white borderColor=black>\t\t\r\n");
      out.write("    <tr>   \r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">部门经理批准<br /> Approved by DM</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">部门总监(部长)批准<br />Approved by BU </td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">事业部总经理 <br />Approved by BMD</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">财务审核 <br />Audited by FIN</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">财务总监 <br />Approved by FM</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">总经理 <br />Approved by MD</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\" align=\"center\">签 收 <br />Received by</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" width=\"14.28%\"></td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:\t</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" height=\"30\" >日期/Date:</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td class=\"td_field_thin\" colspan=\"8\" height=\"30\">\r\n");
      out.write("    \t\t<b>\tInstruction: </b> <br />                                                                        \r\n");
      out.write("1.The expenses claim must be supported by original inoices. 费用报销必须附有原始发票。    <br /> \r\n");
      out.write(" 2.The daily allowances shall be claim based on the departure and arrival time and the participation in the dinner or luncheon. <br /> \r\n");
      out.write("每日补贴必须依据出差时间和是否参加宴请申领。 <br /> \r\n");
      out.write("3.Other expenses claim shall be referred to the guidelines and principles covered in Company's related regulation. <br /> \r\n");
      out.write("其他报销标准和原则请参阅公司相关规定。\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    </table>\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("    <br />\r\n");
      out.write("    <div style=\"position: absolute;top: 1000;z-index:2;left: 28%\" >\r\n");
      out.write("    \t<img alt=\"\" src=\"");
      out.print(path );
      out.write("/img/image1.jpeg\" height=\"9\">\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("    </div>\r\n");
      out.write("\t</body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
