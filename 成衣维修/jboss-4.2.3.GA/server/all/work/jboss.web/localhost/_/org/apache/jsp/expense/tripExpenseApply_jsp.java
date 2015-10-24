package org.apache.jsp.expense;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.util.NumberUtil;
import ep.org.branch.expense.dojo.TripExpenseDetail;
import ep.org.branch.expense.dojo.UserInfo;
import ep.org.branch.expense.constant.ExpenseConstant;
import ep.org.branch.expense.dojo.SelectOptionObj;
import ep.org.branch.expense.dojo.TripExpenseSubjectCost;
import ep.org.branch.expense.dojo.TripExpenseShopCost;

public final class tripExpenseApply_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange.release();
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody.release();
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
      out.write("\r\n");
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
      out.write("    \t\t\r\n");
      out.write("  \t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print( path);
      out.write("/css/mycommon.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/myjs/myTime.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/js/jquery-1.5.2.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \tvar handleThread=0;\r\n");
      out.write("\tvar thisTextID;\r\n");
      out.write("\tvar thisTextValue;\r\n");
      out.write("\tvar gasolineCost;\r\n");
      out.write("\tvar trainCost;\r\n");
      out.write("\tvar taxiCost;\r\n");
      out.write("\tvar airplaneCost;\r\n");
      out.write("\tvar others;\r\n");
      out.write("\tvar hotelCost;\r\n");
      out.write("\tvar meal_allowance_cost;\r\n");
      out.write("\t var subjectMoneyIsRight = '0'; \r\n");
      out.write("\t\r\n");
      out.write("\tfunction getLastTextValue(obj){\r\n");
      out.write("\t\tvar textID = $(obj).attr('id');\r\n");
      out.write("\t\tif(textID!=thisTextID){\r\n");
      out.write("\t\t\tthisTextID = textID;\r\n");
      out.write("\t\t\tthisTextValue = $(obj).attr('value');\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction getAccountCode(obj){\r\n");
      out.write("\t\tvar code = $(obj).attr('value');\r\n");
      out.write(" \t\tvar id=$(obj).attr('id');\r\n");
      out.write("    \tvar newid=id.split('-')[0]+'-accountCode';\r\n");
      out.write("    \t$(\"#\"+newid).attr('value',code);\r\n");
      out.write("  \t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction getaccountListBySuper(obj){\r\n");
      out.write("\t\tvar id = $(obj).attr('id');\r\n");
      out.write("\t\tvar superID = id.split('-')[0]+'-categoryCode';\r\n");
      out.write("\t\tvar superObj = $('#'+superID);\r\n");
      out.write("\t\tgetaccountList(superObj,'大类');\r\n");
      out.write("\t\t$('#'+id.split('-')[0]+'-accountNameTD').attr('className','td_text_center_nodisplay');\r\n");
      out.write("\t\t$('#'+id.split('-')[0]+'-subjectCodeTD').attr('className','td_text_center');\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction getaccountList(obj,desc){\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tvar id=$(obj).attr('id');\r\n");
      out.write("    \t$('#'+id.split('-')[0]+'-accountNameTD').attr('className','td_text_center_nodisplay');\r\n");
      out.write("\t\t$('#'+id.split('-')[0]+'-subjectCodeTD').attr('className','td_text_center');\r\n");
      out.write("    \t\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t//var id=$(obj).attr('id');\r\n");
      out.write("    \t\t\tvar newid=id.split('-')[0]+'-subjectCode';\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\tdocument.getElementById(newid).options.length=0;\r\n");
      out.write("    \t\t\tvar jsonObj = eval(\"(\" + xmlhttp.responseText + \")\"); \r\n");
      out.write("    \t\t\tif(jsonObj.length<2){\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t$('#'+id.split('-')[0]+'-accountCode').attr('value',$(obj).attr('value'));\r\n");
      out.write("    \t\t\t\thandleThread--;\t\r\n");
      out.write("    \t\t\t\treturn;\r\n");
      out.write("    \t\t\t}\r\n");
      out.write("    \t\t\t$('#'+id.split('-')[0]+'-accountCode').attr('value','');\r\n");
      out.write("    \t\t\tvar options = document.getElementById(newid).options;\r\n");
      out.write("    \t\t\tif(jsonObj!=null && jsonObj!=''){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\tfor(var item in jsonObj){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\tif(jsonObj[item].value!=null && jsonObj[item].value != ''){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\tvar objOption = new Option(jsonObj[item].lable,jsonObj[item].value); \r\n");
      out.write("\t\t\t\t\t\t\toptions[item]=objOption;\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("    \t\t\t}\r\n");
      out.write("    \t\t\thandleThread--;\t\r\n");
      out.write("    \t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\talert('网络错误，请重新输入'+desc);\r\n");
      out.write("    \t\t\t$(obj).attr('value','');\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t}\r\n");
      out.write(" \t\t}\r\n");
      out.write(" \t\t//var field = $(obj).attr('id');\r\n");
      out.write(" \t\tvar code = $(obj).attr('value');\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=getCategoryList&code=\"+code);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tfunction modifyExpense(modifyFlag,obj,desc){\r\n");
      out.write("\t\tvar objID = $(obj).attr('id');\r\n");
      out.write("\t\tvar objIDs = $(obj).attr('id').split('-');\r\n");
      out.write("\t\tvar value = $(obj).attr('value');\r\n");
      out.write("\t\tvar SN= $('#'+objIDs[0]+\"-SN\").attr('value');\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tvar rs = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(rs=='0'&& objIDs[1]!= 'expenseDate'&&objIDs[1]!='accountCode'){\r\n");
      out.write("\t\t\t\t\talert('输入失败，请重新输入'+desc);\r\n");
      out.write("    \t\t\t\t$(obj).attr('value','');\r\n");
      out.write("\t\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\tif(objIDs[1]=='gasolineCost'||objIDs[1]=='trainCost'||objIDs[1]=='taxiCost'||objIDs[1]=='airplaneCost'||objIDs[1]=='others'||objIDs[1]=='hotelCost'||objIDs[1]=='meal_allowance_cost'){\r\n");
      out.write("\t\t\t\t\tchangeCost(obj);\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\talert('网络错误，请重新输入'+desc);\r\n");
      out.write("    \t\t\t$(obj).attr('value','');\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t\treturn;\r\n");
      out.write("    \t\t}\r\n");
      out.write("    \t}\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=addTripExpenseDetail&modifyFlag=\"+modifyFlag+\"&mapKey=\"+objIDs[0]+\"&field=\"+objIDs[1]+\"&fieldValue=\"+value+\"&SN=\"+SN);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tfunction modifyExpenseSubject(modifyFlag,obj,desc){\r\n");
      out.write("\t\tvar objID = $(obj).attr('id');\r\n");
      out.write("\t\tvar objIDs = $(obj).attr('id').split('-');\r\n");
      out.write("\t\tvar value = $(obj).attr('value');\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tvar rs = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(rs=='0'&& objIDs[1]!= 'expenseDate'&&objIDs[1]!='accountCode'){\r\n");
      out.write("\t\t\t\t\talert('输入失败，请重新输入'+desc);\r\n");
      out.write("    \t\t\t\t$(obj).attr('value','');\r\n");
      out.write("\t\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\t//var moneyObj = $('#'+$(obj).attr('id').split('-')[0]+'-subjectAmout');\r\n");
      out.write("\t\t\t\tchangeAllCost(objIDs[0],objIDs[1],obj);\r\n");
      out.write("\t\t\t\t//changeSubjectTotalCost(moneyObj);\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\talert('网络错误，请重新输入'+desc);\r\n");
      out.write("    \t\t\t$(obj).attr('value','');\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t\treturn;\r\n");
      out.write("    \t\t}\r\n");
      out.write("    \t}\t\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=addTripExpense&modifyFlag=\"+modifyFlag+\"&mapKey=\"+objIDs[0]+\"&field=\"+objIDs[1]+\"&fieldValue=\"+value);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tfunction addExpense(modifyFlag,tableID){\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tvar arrayTr = $('#'+tableID+' tr');\r\n");
      out.write("\t\tvar lastTr = arrayTr[arrayTr.length-1];\r\n");
      out.write("\t\tvar lastTrID =  $(lastTr).attr('id');\r\n");
      out.write("\t\tvar lastTrIDs = lastTrID.split('-'); \r\n");
      out.write("\t\tvar newSerial = parseInt(lastTrIDs[0])+1;\r\n");
      out.write("\t\tif(lastTrID.substring(1,2)=='1'){\r\n");
      out.write("\t\t\tnewSerial = lastTrID.substring(0,1)+'001';\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tvar lastSN = $('#'+lastTrIDs[0]+'-SN').attr('value');\r\n");
      out.write("\t\tvar newSN = parseInt(lastSN)+1;\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar tr = $('#'+tableID+' tr').eq(1).clone(); \r\n");
      out.write("  \t\ttr.appendTo('#'+tableID);\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t$(tr).css(\"display\",\"block\");\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t$(tr).attr('id',newSerial+'-tr');\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t$(tr).find('textarea').each(function(){\r\n");
      out.write(" \t\t\tvar textareaID = $(this).attr('id');\r\n");
      out.write(" \t\t\tvar newTextareaID = newSerial+'-'+textareaID.split('-')[1];\r\n");
      out.write(" \t\t\t$(this).attr('id',newTextareaID);\r\n");
      out.write(" \t\t\t$(this).attr('value','');\r\n");
      out.write(" \t\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(tr).find('select').each(function(){\r\n");
      out.write(" \t\t\tvar textareaID = $(this).attr('id');\r\n");
      out.write(" \t\t\tvar newTextareaID = newSerial+'-'+textareaID.split('-')[1];\r\n");
      out.write(" \t\t\t$(this).attr('id',newTextareaID);\r\n");
      out.write(" \t\t\t$(this).attr('value','');\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(tr).find('input').each(function(){\r\n");
      out.write(" \t\t\tif($(this).attr('type')=='checkbox'){\r\n");
      out.write(" \t\t\t\t$(this).attr('id',newSerial);\r\n");
      out.write(" \t\t\t\t$(this).attr('checked',false);\r\n");
      out.write(" \t\t\t\t$(this).attr('value',newSerial);\r\n");
      out.write(" \t\t\t}else{\r\n");
      out.write(" \t\t\t\tvar textareaID = $(this).attr('id');\r\n");
      out.write(" \t\t\t\tvar newTextareaID = newSerial+'-'+textareaID.split('-')[1];\r\n");
      out.write(" \t\t\t\t$(this).attr('id',newTextareaID);\r\n");
      out.write(" \t\t\t\t$(this).attr('value','');\r\n");
      out.write(" \t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$('#'+newSerial+'-SN').attr('value',newSN);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\tvar rs = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\tif(rs=='0'){\r\n");
      out.write("\t\t\t\t\talert('增加失败，请重新点击增加'+desc);\r\n");
      out.write("    \t\t\t\ttr.remove();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\talert('网络错误，请重新点击增加');\r\n");
      out.write("    \t\t\ttr.remove();\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=addTripExpense&modifyFlag=\"+modifyFlag+\"&mapKey=\"+newSerial+'&SN='+newSN);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tfunction deleteExpense(modifyFlag,tableID){\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tvar arrayTr = $('#'+tableID+' tr');\r\n");
      out.write("\t\tvar mapKeyString = '';\r\n");
      out.write("\t\tfor(var i=0;i<arrayTr.length;i++ ){\r\n");
      out.write("\t\t\tvar thisTr = arrayTr[i];\r\n");
      out.write("\t\t\tif($(thisTr).find('input').eq(1).attr('checked')){\r\n");
      out.write("\t\t\t\tmapKeyString=mapKeyString+','+$(thisTr).attr('id').split('-')[0];\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tmapKeyString = mapKeyString.substring(1,mapKeyString.length);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\tvar rs = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\tif(rs=='0'){\r\n");
      out.write("\t\t\t\t\talert('删除失败，请重新删除');\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif(rs=='1'){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tfor(var i=0;i<arrayTr.length;i++ ){\r\n");
      out.write("\t\t\t\t\t\tvar thisTr = arrayTr[i];\r\n");
      out.write("\t\t\t\t\t\tif($(thisTr).find('input').eq(1).attr('checked')){\r\n");
      out.write("\t\t\t\t\t\t\tvar thisTrID = $(thisTr).attr('id').split('-')[0];\r\n");
      out.write("\t\t\t\t\t\t\tmapKeyString=mapKeyString+','+thisTrID;\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\tif(thisTrID.substring(0,1)=='2'){\r\n");
      out.write("\t\t\t\t\t\t\t\tvar thisValue = $('#'+thisTrID+'-expenseAmout').attr('value')\r\n");
      out.write("\t\t\t\t\t\t\t\tvar totalValue = $('#hiddenShopTotalCost').attr('value');\t\r\n");
      out.write("\t\t\t\t\t\t\t\tif(thisValue==null || thisValue==''){\r\n");
      out.write("  \t\t\t\t\t\t\t\t\tthisValue = '0';\r\n");
      out.write("  \t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\tvar sum = parseFloat(totalValue)-parseFloat(thisValue);\r\n");
      out.write("\t\t\t\t\t\t\t\tsum = sum.toFixed(2);\r\n");
      out.write("\t\t\t\t\t\t\t\t$('#hiddenShopTotalCost').attr('value',sum);\r\n");
      out.write("  \t\t\t\t\t\t\t\t$('#shopTotalCost').html('金额('+sum+')'); \r\n");
      out.write("  \t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t\t\tvar thisValue = $('#'+thisTrID+'-subjectAmout').attr('value')\r\n");
      out.write("\t\t\t\t\t\t\t\tvar totalValue = $('#hiddenSubjectTotalCost').attr('value');\t\r\n");
      out.write("\t\t\t\t\t\t\t\tif(thisValue==null || thisValue==''){\r\n");
      out.write("  \t\t\t\t\t\t\t\t\tthisValue = '0';\r\n");
      out.write("  \t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\tvar sum = parseFloat(totalValue)-parseFloat(thisValue);\r\n");
      out.write("\t\t\t\t\t\t\t\tsum = sum.toFixed(2);\r\n");
      out.write("\t\t\t\t\t\t\t\t$('#hiddenSubjectTotalCost').attr('value',sum);\r\n");
      out.write("  \t\t\t\t\t\t\t\t$('#subjectTotalCost').html('金额('+sum+')'); \r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t$(arrayTr[i]).remove();\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\talert('网络错误，请重新删除');\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\t\txmlhttp.send(\"action=addTripExpense&modifyFlag=\"+modifyFlag+\"&mapKey=\"+mapKeyString);\r\n");
      out.write("\t\t\thandleThread++;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tfunction validateNumber(obj){\r\n");
      out.write("\t\tvar r1= /^\\d+$/;\r\n");
      out.write("\t\tif(!r1.test($(obj).attr('value'))){\r\n");
      out.write("\t\t\t$(obj).attr('value','');\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\talert(\"输入数值必须是不小于0的整数！\");\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction modifyExpenseNumber(modifyFlag,obj,desc){\r\n");
      out.write("  \t\tvar objValue = $(obj).attr('value');\r\n");
      out.write("  \t\tif(isNaN(objValue)){\r\n");
      out.write("  \t\t\t$(obj).attr('value','');\r\n");
      out.write("  \t\t\talert('只允许输入数值!');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t/**}else if(parseFloat(objValue)<0){\r\n");
      out.write("  \t\t\talert('输入金额不能小于零!');\r\n");
      out.write("  \t\t\t$(obj).attr('value','');\r\n");
      out.write("  \t\t\treturn;*/\r\n");
      out.write("  \t\t}else{\r\n");
      out.write("  \t\t\tif($(obj).attr('id').substr(0,1)=='3'||$(obj).attr('id').substr(0,1)=='2'){\r\n");
      out.write("  \t\t\t\tmodifyExpenseSubject(modifyFlag,obj,desc);\r\n");
      out.write("  \t\t\t}else{\r\n");
      out.write("  \t\t\t\tmodifyExpense(modifyFlag,obj,desc);\r\n");
      out.write("  \t\t\t}\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction changeBranchCode(){\r\n");
      out.write("  \t\tvar selecttext = $(\"#branchCode\").find(\"option:selected\").text(); \r\n");
      out.write("  \t\tvar branchName = selecttext.split('|')[1];\r\n");
      out.write("  \t\t$(\"#branchName\").attr(\"value\",selecttext);\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \r\n");
      out.write(" function changeCost(obj){\r\n");
      out.write("\t  var field = $(obj).attr('id').split('-')[1];\r\n");
      out.write("\t  var fieldSum = 0;\r\n");
      out.write("\t  var total = 0;\r\n");
      out.write("\t  $('#tirpDetailTable').find('tr').each(function(){\r\n");
      out.write("\t      \r\n");
      out.write("\t      $(this).find('input').each(function(){\r\n");
      out.write("\t          var objIDs = $(this).attr('id');\r\n");
      out.write("\t          var objIDArray = objIDs.split('-');\r\n");
      out.write("\t          \r\n");
      out.write("\t          if(objIDArray.length>1){\r\n");
      out.write("\t          \t  var field1 = objIDArray[1];\r\n");
      out.write("\t              if(field==field1){\r\n");
      out.write("\t          \t    var temp = $(this).attr('value');\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    if(temp==null||temp==''){\r\n");
      out.write("\t          \t    \ttemp='0.0000'\r\n");
      out.write("\t          \t    }\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    fieldSum = fieldSum+parseFloat(temp); \r\n");
      out.write("\t          \t  }\r\n");
      out.write("\t      \t  }\r\n");
      out.write("\t      })\r\n");
      out.write("\t  })\r\n");
      out.write("\t  \r\n");
      out.write("\t  if(field=='gasolineCost'){\r\n");
      out.write("\t  \tgasolineCost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t  \t $('#gasolineCost').attr('value',gasolineCost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  if(field=='trainCost'){\r\n");
      out.write("\t  \ttrainCost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t  \t$('#trainCost').attr('value',trainCost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t  if(field=='taxiCost'){\r\n");
      out.write("\t  \ttaxiCost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t  \t$('#taxiCost').attr('value',taxiCost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t  if(field=='airplaneCost'){\r\n");
      out.write("\t  \tairplaneCost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t \t$('#airplaneCost').attr('value',airplaneCost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t  if(field=='others'){\r\n");
      out.write("\t  \tothers = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t    $('#others').attr('value',others);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t  \r\n");
      out.write("\t  if(field=='hotelCost'){\r\n");
      out.write("\t  \thotelCost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t  $('#hotelCost').attr('value',hotelCost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t   if(field=='meal_allowance_cost'){\r\n");
      out.write("\t  \tmeal_allowance_cost = parseFloat(fieldSum).toFixed(2);\r\n");
      out.write("\t  \t $('#meal_allowance_cost').attr('value',meal_allowance_cost);\r\n");
      out.write("\t  }\r\n");
      out.write("\t  \r\n");
      out.write("\t  total=parseFloat(gasolineCost)+parseFloat(trainCost)+parseFloat(taxiCost)+parseFloat(airplaneCost)\r\n");
      out.write("\t  \t+parseFloat(others)+parseFloat(hotelCost)+parseFloat(meal_allowance_cost);\r\n");
      out.write("\t total = total.toFixed(2);\r\n");
      out.write("\t  $('#totalMoney').attr('value',total);\r\n");
      out.write("\t\r\n");
      out.write("  \t \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  function checkMustFill(){\r\n");
      out.write("  \t\tvar flag = true;\r\n");
      out.write("  \t\tvar fieldName = '';\r\n");
      out.write("  \t\tvar fieldID = '';\r\n");
      out.write("  \t\tif($('#invoiceBackDate').attr('value')==null || $('#invoiceBackDate').attr('value')==''){\r\n");
      out.write("  \t\t\talert('发票寄回日期不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif($('#tripAddress').attr('value')==null || $('#tripAddress').attr('value')==''){\r\n");
      out.write("  \t\t\talert('出差地点不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#tripPurposes').attr('value')==null || $('#tripPurposes').attr('value')==''){\r\n");
      out.write("  \t\t\talert('出差事由不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#tripName').attr('value')==null || $('#tripName').attr('value')==''){\r\n");
      out.write("  \t\t\talert('出差人姓名不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#employeeID').attr('value')==null || $('#employeeID').attr('value')==''){\r\n");
      out.write("  \t\t\talert('职员编码不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif($('#payComment').attr('value')==null || $('#payComment').attr('value')==''){\r\n");
      out.write("  \t\t\talert('付款说明不能为空！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#isBranchFinance').attr('value')=='1'){\r\n");
      out.write("\t\t\t\tvar arrayTr_Subject = $('#300'+' tr');\r\n");
      out.write("\t\t\t\tif(arrayTr_Subject.length<=2){\r\n");
      out.write("\t\t\t\t\talert('费用科目至少有一条记录！');\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t\tvar count = 0;\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tfor(var k=2;k<arrayTr_Subject.length;k++){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif($(arrayTr_Subject[k]).find('input').eq(2).attr('value')!='' || $(arrayTr_Subject[k]).find('input').eq(3).attr('value')!=''){\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\tcount++;\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t}\t\t\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(count==0){\r\n");
      out.write("\t\t\t\t\talert('费用科目至少有一条记录！');\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tvar totalMoney = $('#totalMoney').attr('value')\r\n");
      out.write("  \t\tif(parseFloat(totalMoney)<=0){\r\n");
      out.write("  \t\t\talert('报销金额必须大于零！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tvar hiddenPurposeTotalCost = $('#totalMoney').attr('value');\r\n");
      out.write("  \t\tvar hiddenShopTotalCost = $('#hiddenShopTotalCost').attr('value');\r\n");
      out.write("  \t\tif(parseFloat(hiddenPurposeTotalCost)<parseFloat(hiddenShopTotalCost)){\r\n");
      out.write("  \t\t\talert('总金额不能小于店铺总金额！');\r\n");
      out.write("  \t\t\treturn false;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t$('#topDiv').find('tr').each(function(){\r\n");
      out.write(" \t\t\tvar totalel = 0;\r\n");
      out.write(" \t\t\tvar fillel = 0;\r\n");
      out.write(" \t\t\tvar value = '';\r\n");
      out.write(" \t\t\t$(this).find('textarea').each(function(){\r\n");
      out.write(" \t\t\t\ttotalel++;\r\n");
      out.write(" \t\t\t\tvalue = $(this).attr('value');\r\n");
      out.write(" \t\t\t\tif(value!=''&&value!=null){\r\n");
      out.write(" \t\t\t\t\tfillel++;\r\n");
      out.write(" \t\t\t\t}else{\r\n");
      out.write(" \t\t\t\t\tfieldName = $(this).attr('name');\r\n");
      out.write(" \t\t\t\t}\r\n");
      out.write(" \r\n");
      out.write(" \t\t\t});\r\n");
      out.write(" \t\t\t\r\n");
      out.write(" \t\t\t$(this).find('input').each(function(){\r\n");
      out.write(" \t\t\t\tif($(this).attr('type')!='checkbox'){\r\n");
      out.write(" \t\t\t\t\t\r\n");
      out.write(" \t\t\t\t\tvar id=$(this).attr('id');\r\n");
      out.write(" \t\t\t\t\tvar ids = id.split('-');\r\n");
      out.write(" \t\t\t\t\t\r\n");
      out.write(" \t\t\t\t\t/**\r\n");
      out.write(" \t\t\t\t\tif(id.substr(0,1)=='1'){\r\n");
      out.write(" \t\t\t\t\t\tif(ids[1]=='fromAdress'||ids[1]=='fromDate'||ids[1]=='toAdress'||ids[1]=='toDate'){\r\n");
      out.write(" \t\t\t\t\t\t\ttotalel++;\r\n");
      out.write(" \t\t\t\t\t\t\tvalue = $(this).attr('value');\r\n");
      out.write(" \t\t\t\t\t\t\tif(value!=''&&value!=null){\r\n");
      out.write(" \t\t\t\t\t\t\t\tfillel++;\r\n");
      out.write(" \t\t\t\t\t\t\t}else{\r\n");
      out.write(" \t\t\t\t\t\t\t\tfieldName = $(this).attr('name');\r\n");
      out.write(" \t\t\t\t\t\t\t}\r\n");
      out.write(" \t\t\t\t\t\t}\r\n");
      out.write(" \t\t\t\t\t}*/\r\n");
      out.write(" \t\t\t\t\t\r\n");
      out.write(" \t\t\t\t\tif($(this).attr('type')!='checkbox'&&$(this).attr('name')!='SN'&&$(this).attr('id').split('-')[1]!='comment'&&$(this).attr('id').split('-')[1]!='accountName'\r\n");
      out.write(" \t\t\t\t\t&&$(this).attr('id').split('-')[1]!='subjectBudget'&&$(this).attr('id').split('-')[1]!='subjectUsedMoney'&&$(this).attr('id').split('-')[1]!='KM'&&$(this).attr('id').split('-')[1]!='gasolineCost'\r\n");
      out.write(" \t\t\t\t\t&&$(this).attr('id').split('-')[1]!='trainCost'&&$(this).attr('id').split('-')[1]!='taxiCost'&&$(this).attr('id').split('-')[1]!='airplaneCost'&&$(this).attr('id').split('-')[1]!='others'\r\n");
      out.write(" \t\t\t\t\t&&$(this).attr('id').split('-')[1]!='hotelCost'&&$(this).attr('id').split('-')[1]!='meal_allowance_cost'\r\n");
      out.write(" \t\t\t\t\t){\r\n");
      out.write(" \t\t\t\t\t\ttotalel++;\r\n");
      out.write(" \t\t\t\t\t\tvalue = $(this).attr('value');\r\n");
      out.write(" \t\t\t\t\t\tif(value!=''&&value!=null){\r\n");
      out.write(" \t\t\t\t\t\t\tfillel++;\r\n");
      out.write(" \t\t\t\t\t\t\t\r\n");
      out.write(" \t\t\t\t\t\t}else{\r\n");
      out.write(" \t\t\t\t\t\t\tfieldName = $(this).attr('name');\r\n");
      out.write(" \t\t\t\t\t\t}\r\n");
      out.write(" \t\t\t\t\t}\r\n");
      out.write(" \t\t\t\t}\r\n");
      out.write(" \t\t\t});\r\n");
      out.write("\t\t\tif(fillel!=0 && totalel!=fillel){\r\n");
      out.write("\t\t\t\talert(fieldName + \"为必填项，请检查！\");\r\n");
      out.write("\t\t\t\tflag = false;\r\n");
      out.write("\t\t\t\treturn false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("  \t\treturn flag;\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction save(){\r\n");
      out.write("  \t\tif(handleThread!=0){\r\n");
      out.write("  \t\t\talert('后台数据还未处理完成，请稍后再保存！');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif(checkMustFill()){\r\n");
      out.write("  \t\t\t$('#action').attr('value','save');\r\n");
      out.write("  \t\t\tdocument.forms[0].submit();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction isExistsActivtyThread(){\r\n");
      out.write("  \t\tif(handleThread==0){\r\n");
      out.write("  \t\t\tdo_submitActvity();\r\n");
      out.write("  \t\t}else{\r\n");
      out.write("  \t\t\tsetTimeout('isExistsActivtyThread()',10);\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction waitDiv(){\r\n");
      out.write("  \t\t$('#waitDiv').show();\r\n");
      out.write("  \t\t$('#mainDiv').hide();\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction waitDivHidden(){\r\n");
      out.write("  \t\t$('#waitDiv').hide();\r\n");
      out.write("  \t\t$('#mainDiv').show();\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction do_submitActvity(){\r\n");
      out.write("  \t\tif(subjectMoneyIsRight=='1'){\r\n");
      out.write("  \t\t\talert('所填科目金额超出该科目的可用预算金额!');\r\n");
      out.write("  \t\t\tsubjectMoneyIsRight = '0';\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif(subjectMoneyIsRight=='2'){\r\n");
      out.write("  \t\t\talert('后台未取到该科目预算，请联系IT运维！');\r\n");
      out.write("  \t\t\tsubjectMoneyIsRight = '0';\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif(subjectMoneyIsRight=='3'){\r\n");
      out.write("  \t\t\talert('网络错误，请重新提交!');\r\n");
      out.write("  \t\t\tsubjectMoneyIsRight = '0';\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t //if(handleThread!=0){\r\n");
      out.write("  \t\t\t//alert('后台数据还未处理完成，请稍后再提交！');\r\n");
      out.write("  \t\t\t//return;\r\n");
      out.write("  \t\t //}\r\n");
      out.write("  \t\t if(checkMustFill()){\r\n");
      out.write("  \t\t \tif(confirm('确定提交？')){\r\n");
      out.write("  \t\t\t\t$('#action').attr('value','send');\r\n");
      out.write("  \t\t\t\tdocument.forms[0].submit();\r\n");
      out.write("  \t\t\t}else{\r\n");
      out.write("  \t\t\t\twaitDivHidden();\r\n");
      out.write("  \t\t\t}\r\n");
      out.write("  \t\t}else{\r\n");
      out.write("  \t\t\twaitDivHidden();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction waitDivHidden(){\r\n");
      out.write("  \t\t$('#waitDiv').hide();\r\n");
      out.write("  \t\t$('#mainDiv').show();\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction do_submit(){\r\n");
      out.write("  \t\t var arrayTr = $('#300 tr');\r\n");
      out.write("  \t\t for(var i=2;i<arrayTr.length;i++){\r\n");
      out.write("  \t\t\t if($(arrayTr[i]).find('input').eq(3).attr('id').split('-')[1]=='subjectAmout'){\r\n");
      out.write("  \t\t\t \t if($(arrayTr[i]).find('input').eq(3).attr('value')!=''){\r\n");
      out.write("  \t\t\t \t \tvalidateSubjectBal($(arrayTr[i]).find('input').eq(2));\r\n");
      out.write("  \t\t\t \t}\r\n");
      out.write("  \t\t\t }else{\r\n");
      out.write("  \t\t\t \t\r\n");
      out.write("  \t\t\t \t if($(arrayTr[i]).find('input').eq(4).attr('value')!=''){\r\n");
      out.write("  \t\t\t\t\tvalidateSubjectBal($(arrayTr[i]).find('input').eq(3));\r\n");
      out.write("  \t\t\t \t}\r\n");
      out.write("  \t\t\t }\r\n");
      out.write("  \t\t }\r\n");
      out.write("  \t\t \r\n");
      out.write("  \t\twaitDiv();\r\n");
      out.write("  \t\tisExistsActivtyThread();\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction refuse(){\r\n");
      out.write("  \t\tif($('#refuseReason').attr('value')==null||$('#refuseReason').attr('value')==''){\r\n");
      out.write("  \t\t\talert('驳回理由不能为空！');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif(confirm('确定驳回？')){\r\n");
      out.write("  \t\t\t$('#action').attr('value','refuse');\r\n");
      out.write("  \t\t\tdocument.forms[0].submit();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction initForm(){\r\n");
      out.write("  \t\t$('#applytitle', parent.document).html('差旅费报销单');\r\n");
      out.write("  \t\tif($('#result').attr('value')=='1'){\r\n");
      out.write("  \t\t\talert('单号为'+$('#expenseNo').attr('value')+'申请单保存成功');\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif($('#result').attr('value')=='2'){\r\n");
      out.write("  \t\t\talert('提交成功');\r\n");
      out.write("  \t\t\twindow.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif($('#result').attr('value')=='3'){\r\n");
      out.write("  \t\t\tprint();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#result').attr('value')=='4'){\r\n");
      out.write("  \t\t\talert('驳回成功');\r\n");
      out.write("  \t\t\twindow.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif($('#result').attr('value')=='-1'){\r\n");
      out.write("  \t\t\talert('流程找不到下个环节，请联系IT部流程配置人员');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tgasolineCost = $('#gasolineCost').attr('value');\r\n");
      out.write("\t\ttrainCost = $('#trainCost').attr('value');\r\n");
      out.write("\t\ttaxiCost = $('#taxiCost').attr('value');\r\n");
      out.write("\t\tairplaneCost = $('#airplaneCost').attr('value');\r\n");
      out.write("\t\tothers = $('#others').attr('value');\r\n");
      out.write("\t\thotelCost = $('#hotelCost').attr('value');\r\n");
      out.write("\t\tmeal_allowance_cost = $('#meal_allowance_cost').attr('value');\r\n");
      out.write("  \t\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  function changeAllCost(id,name,obj){\r\n");
      out.write("  \tif(id.substring(0,1)=='2'&&name=='expenseAmout'){\r\n");
      out.write("  \t\tchangeShopTotalCost(obj);\r\n");
      out.write("  \t}else if(id.substring(0,1)=='3'&&name=='subjectAmout'){\r\n");
      out.write("  \t\tchangeSubjectTotalCost(obj);\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  }\r\n");
      out.write("  \t\r\n");
      out.write("   function changeShopTotalCost(obj){\r\n");
      out.write("\t  \t\r\n");
      out.write("\t var field = $(obj).attr('id').split('-')[1];\r\n");
      out.write("\t var fieldSum = 0;\r\n");
      out.write("\t  var total = 0;\r\n");
      out.write("\t  $('#200').find('tr').each(function(){\r\n");
      out.write("\t      \r\n");
      out.write("\t      $(this).find('input').each(function(){\r\n");
      out.write("\t          var objIDs = $(this).attr('id');\r\n");
      out.write("\t          var objIDArray = objIDs.split('-');\r\n");
      out.write("\t          \r\n");
      out.write("\t          if(objIDArray.length>1){\r\n");
      out.write("\t          \t  var field1 = objIDArray[1];\r\n");
      out.write("\t              if(field==field1){\r\n");
      out.write("\t          \t    var temp = $(this).attr('value');\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    if(temp==null||temp==''){\r\n");
      out.write("\t          \t    \ttemp='0.0000'\r\n");
      out.write("\t          \t    }\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    fieldSum = fieldSum+parseFloat(temp); \r\n");
      out.write("\t          \t  }\r\n");
      out.write("\t      \t  }\r\n");
      out.write("\t      })\r\n");
      out.write("\t  })\r\n");
      out.write("\t  \r\n");
      out.write("\tfieldSum = fieldSum.toFixed(2);\r\n");
      out.write("\t\r\n");
      out.write("\t$('#hiddenShopTotalCost').attr('value',fieldSum);\r\n");
      out.write("  \t$('#shopTotalCost').html('金额('+fieldSum+')'); \r\n");
      out.write("\t  \t\r\n");
      out.write("\t /*\tvar objValue = $(obj).attr('value');\r\n");
      out.write("\t  \tvar totalValue = $('#hiddenShopTotalCost').attr('value');\r\n");
      out.write("  \t\tvar sum = parseFloat(objValue)+parseFloat(totalValue); \r\n");
      out.write("  \t\tsum = sum.toFixed(2);\r\n");
      out.write("  \t\t$('#hiddenShopTotalCost').attr('value',sum);\r\n");
      out.write(" \t\t$('#shopTotalCost').html('奖励金额('+sum+')');  \t*/\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function changeSubjectTotalCost(obj){\r\n");
      out.write("  \t  var field = $(obj).attr('id').split('-')[1];\r\n");
      out.write("\t  var fieldSum = 0;\r\n");
      out.write("\t  var total = 0;\r\n");
      out.write("\t  $('#300').find('tr').each(function(){\r\n");
      out.write("\t      \r\n");
      out.write("\t      $(this).find('input').each(function(){\r\n");
      out.write("\t          var objIDs = $(this).attr('id');\r\n");
      out.write("\t          var objIDArray = objIDs.split('-');\r\n");
      out.write("\t          \r\n");
      out.write("\t          if(objIDArray.length>1){\r\n");
      out.write("\t          \t  var field1 = objIDArray[1];\r\n");
      out.write("\t              if(field==field1){\r\n");
      out.write("\t          \t    var temp = $(this).attr('value');\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    if(temp==null||temp==''){\r\n");
      out.write("\t          \t    \ttemp='0.0000'\r\n");
      out.write("\t          \t    }\r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    \r\n");
      out.write("\t          \t    fieldSum = fieldSum+parseFloat(temp); \r\n");
      out.write("\t          \t  }\r\n");
      out.write("\t      \t  }\r\n");
      out.write("\t      })\r\n");
      out.write("\t  })\r\n");
      out.write("\t  \r\n");
      out.write("\t\tfieldSum = fieldSum.toFixed(2);\r\n");
      out.write("  \t\t$('#hiddenSubjectTotalCost').attr('value',fieldSum);\r\n");
      out.write("  \t\t$('#subjectTotalCost').html('金额('+fieldSum+')');  \t\r\n");
      out.write("  }\t\t\r\n");
      out.write("  \r\n");
      out.write("  function print(){\r\n");
      out.write("  \tvar stateCode = $('#applyStateCode').attr('value');\r\n");
      out.write("  \tvar expenseNo = $('#expenseNo').attr('value');\r\n");
      out.write("  \tif(stateCode==\"100\"){\r\n");
      out.write("  \t\t if(handleThread!=0){\r\n");
      out.write("  \t\t\talert('后台数据还未处理完成，请稍后再打印！');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t \r\n");
      out.write("  \t\t $('#printFlag').attr('value','1');\r\n");
      out.write("  \t\t save();\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t \r\n");
      out.write("  \t}else{\r\n");
      out.write("  \t\tvar url = $('#webcontent').attr('value')+'/tripExpenseApply.do?action=getPrintData&expenseNo='+expenseNo;\t\r\n");
      out.write("  \t\twindow.open(url,'现金付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write("  \t}\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write(" function showRefuseReason(){\r\n");
      out.write(" \t$('#refuseReasonDiv').css('display','block');\r\n");
      out.write(" }\r\n");
      out.write(" function hiddenRefuseReason(){\r\n");
      out.write(" \t$('#refuseReasonDiv').css('display','none');\r\n");
      out.write(" \t$('#refuseReason').attr('value','');\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write("  function viewRefuseReCord(){\r\n");
      out.write(" \tvar expenseNo = $('#expenseNo').attr('value');\r\n");
      out.write(" \tvar url = $('#webcontent').attr('value')+'/refuseRecordQuery.do?action=init&expenseNo='+expenseNo;\t\r\n");
      out.write("  \twindow.open(url,'驳回记录查询','scrollbars=yes,width=800,height=600,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write("  \r\n");
      out.write(" \r\n");
      out.write(" function validateSubjectBal(obj){\r\n");
      out.write(" \tvar costCenter = $('#branchCode').attr('value');\r\n");
      out.write(" \tvar acctCode = $(obj).attr('value');\r\n");
      out.write(" \tvar objID = $(obj).attr('id');\r\n");
      out.write("\tvar serial = objID.split('-')[0];\r\n");
      out.write("\tvar subjectBuggdetID = serial+'-subjectBudget';\r\n");
      out.write("\tvar subjectUsedID = serial+'-subjectUsedMoney';\r\n");
      out.write("\tvar money = serial+'-subjectAmout';\r\n");
      out.write(" \tvar xmlhttp;\r\n");
      out.write(" \t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\tvar res = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\tvar arrayRes = res.split(',');\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(arrayRes[0]=='null'){\r\n");
      out.write("\t\t\t\t\t//alert('后台未取到该科目预算，请联系IT运维！');\r\n");
      out.write("\t\t\t\t\t$('#'+money).attr('value','');\r\n");
      out.write("\t\t\t\t\tsubjectMoneyIsRight = '2';\r\n");
      out.write("\t\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\t\twaitDivHidden();\r\n");
      out.write("\t\t\t\t\tchangeSubjectTotalCost($('#'+money));\r\n");
      out.write("\t\t\t\t\treturn false;\t\t\r\n");
      out.write("\t\t\t\t}else{//+parseFloat($('#'+money).attr('value'))\r\n");
      out.write("\t\t\t\t\tvar appSubjectMoney = parseFloat($('#'+money).attr('value'));\r\n");
      out.write("\t\t\t\t\tvar arrayTr = $('#300 tr');\r\n");
      out.write("\t\t\t\t\tfor(var i=2;i<arrayTr.length;i++){\r\n");
      out.write("  \t\t\t\t\t\r\n");
      out.write("  \t\t\t \t\t\tif($(arrayTr[i]).find('input').eq(3).attr('id').split('-')[1]=='subjectAmout'){\r\n");
      out.write("  \t\t\t \t \t\t\tif($(arrayTr[i]).find('input').eq(2).attr('value')==acctCode&&$(arrayTr[i]).find('input').eq(2).attr('id').split('-')[0]!=serial){\r\n");
      out.write("  \t\t\t \t \t\t\t\tif($(arrayTr[i]).find('input').eq(3).attr('value')!=''){\r\n");
      out.write("  \t\t\t \t \t\t\t\t\tappSubjectMoney = appSubjectMoney+parseFloat($(arrayTr[i]).find('input').eq(3).attr('value'));\r\n");
      out.write("  \t\t\t \t\t\t\t\t}\r\n");
      out.write("  \t\t\t \t \t\t\t}\r\n");
      out.write("  \t\t\t \t \t\t\t\r\n");
      out.write("  \t\t\t \t\t\t}\r\n");
      out.write("  \t\t\t \t\t\t\r\n");
      out.write("  \t\t\t \t\t\telse{\r\n");
      out.write("  \t\t\t \t\t\t\tif($(arrayTr[i]).find('input').eq(3).attr('value')==acctCode&&$(arrayTr[i]).find('input').eq(3).attr('id').split('-')[0]!=serial){\r\n");
      out.write("  \t\t\t \t\t\t \t\tif($(arrayTr[i]).find('input').eq(4).attr('value')!=''){\r\n");
      out.write("  \t\t\t\t\t\t\t\t\tappSubjectMoney = appSubjectMoney+parseFloat($(arrayTr[i]).find('input').eq(4).attr('value'));\r\n");
      out.write("  \t\t\t \t\t\t\t\t}\r\n");
      out.write("  \t\t\t \t\t\t\t}\r\n");
      out.write("  \t\t\t \t\t\t}\r\n");
      out.write("  \t\t\t \r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(parseFloat(arrayRes[0])<parseFloat(arrayRes[1])+appSubjectMoney){\r\n");
      out.write("\t\t\t\t\t\t//alert('所填科目金额超出该科目的可用预算金额');\r\n");
      out.write("\t\t\t\t\t\t$('#'+money).attr('value','');\r\n");
      out.write("\t\t\t\t\t\t$('#'+subjectBuggdetID).attr('value',parseFloat(arrayRes[0]).toFixed(2));\r\n");
      out.write("\t\t\t\t\t\t$('#'+subjectUsedID).attr('value',parseFloat(arrayRes[1]).toFixed(2));\r\n");
      out.write("\t\t\t\t\t\tsubjectMoneyIsRight = '1';\r\n");
      out.write("\t\t\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t\t\t\twaitDivHidden();\r\n");
      out.write("\t\t\t\t\t\tchangeSubjectTotalCost($('#'+money));\r\n");
      out.write("\t\t\t\t\t\treturn false;\t\t\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t$('#'+subjectBuggdetID).attr('value',parseFloat(arrayRes[0]).toFixed(2));\r\n");
      out.write("\t\t\t\t$('#'+subjectUsedID).attr('value',parseFloat(arrayRes[1]).toFixed(2));\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t//alert('网络错误，请重新提交');\r\n");
      out.write("    \t\t\t$('#'+money).attr('value','');\r\n");
      out.write("    \t\t\tsubjectMoneyIsRight = '3';\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t\twaitDivHidden();\r\n");
      out.write("    \t\t\tchangeSubjectTotalCost($('#'+money));\r\n");
      out.write("    \t\t\treturn false;\r\n");
      out.write("    \t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar code = $(obj).attr('value');\r\n");
      out.write("\t\tvar expenseNo = $('#expenseNo').attr('value');\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=getBudgetAndMoneyByAcctCode&costCenter=\"+costCenter+\"&acctCode=\"+acctCode+\"&expenseNo=\"+expenseNo);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write(" function showBudgt(){\r\n");
      out.write(" \tvar costCenter = $('#branchCode').attr('value');\r\n");
      out.write(" \tvar expenseNo = $('#expenseNo').attr('value');\r\n");
      out.write(" \tvar url = $('#webcontent').attr('value')+'/budgetQuery.do?action=init&costCenter='+costCenter+\"&expenseNo=\"+expenseNo;\r\n");
      out.write(" \twindow.open(url,'科目预算查询',\"scrollbars=yes,width=800px,height=600px,resizable=yes,menubar=no,status=no,location=no\") \r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write(" function getShopNameByCS(obj){\r\n");
      out.write("\t\tvar id=$(obj).attr('id');\r\n");
      out.write("\t\tvar key = id.split('-')[0]\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("\t\t\t\tvar res = xmlhttp.responseText;\r\n");
      out.write("\t\t\t\tif(res!=''){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tvar shopName = $('#'+key+'-shopName');\r\n");
      out.write("\t\t\t\t\tshopName.attr('value',res);\r\n");
      out.write("\t\t\t\t\tmodifyExpenseSubject('1',shopName,'店铺名');\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\thandleThread--;\r\n");
      out.write("\t\t\t}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\talert('网络错误，请重新输入'+desc);\r\n");
      out.write("    \t\t\t$(obj).attr('value','');\r\n");
      out.write("    \t\t\thandleThread--;\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar code = $(obj).attr('value');\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=getShopName&costCenter=\"+code);\r\n");
      out.write("\t\thandleThread++;\r\n");
      out.write("\t}\r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write(" </script>\r\n");
      out.write("\r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("    <input type=\"hidden\" id=\"isBranchFinance\" value=\"");
      out.print(request.getAttribute("isBranchFinance") );
      out.write("\" >\r\n");
      out.write("    <input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("\t<input type=\"hidden\" id=\"webcontent\" value=\"");
      out.print(request.getContextPath() );
      out.write("\">\r\n");
      out.write("\t<input type=\"hidden\" id=\"hiddenSubjectTotalCost\" value=\"");
      out.print(request.getAttribute("BTESubjectTotalCost"));
      out.write("\">\r\n");
      out.write("\t<input type=\"hidden\" id=\"hiddenShopTotalCost\" value=\"");
      out.print(request.getAttribute("s_shopTotalCost"));
      out.write("\">\r\n");
      out.write("\t\r\n");
      out.write("\t <div id=\"waitDiv\" style=\"position:absolute;top: 0;width: 100%;height: 100;z-index: 3;display: none;\">正在处理，请稍后......</div>\r\n");
      out.write("    \t<div id=\"mainDiv\" style=\"width: 95%\">\r\n");
      out.write("    \t");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      // /expense/tripExpenseApply.jsp(1010,5) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setAction("/tripExpenseApply");
      // /expense/tripExpenseApply.jsp(1010,5) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setStyleId("tripExpenseApplyForm");
      // /expense/tripExpenseApply.jsp(1010,5) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setMethod("post");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005fhidden_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005fhidden_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005fhidden_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<div id=\"refuseReasonDiv\"  style=\"position:absolute; display: none;background-color: #F3F4F3;height: 500;width:100%;overflow: auto;border-color: gray;border-style: solid;border: 2;z-index: 2; text-align: center;\">\r\n");
          out.write("\t\t\t\t<font color=\"red\">*</font>驳回理由：<br/>\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("<br />\r\n");
          out.write("\t\t\t\t<input type=\"button\" onclick=\"refuse()\" value=\"确定\" style=\"width:60\" >&nbsp;&nbsp;<input type=\"button\" onclick=\"hiddenRefuseReason()\" value=\"取消\" style=\"width:60\"> \r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<div>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t");
UserInfo userinfo = (UserInfo)request.getSession().getAttribute("user_info") ;
          out.write("\r\n");
          out.write("\t\t\t<input type=\"button\" value=\"保存\" onclick=\"save()\" class=\"btn_save\" onmouseover=\"this.className='btn_save_on'\" onmouseout=\"this.className='btn_save'\"  >\r\n");
          out.write("\t\t\t &nbsp;&nbsp;\r\n");
          out.write("\t\t\t");
if(ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())){ 
          out.write("\r\n");
          out.write("\t\t\t<input type=\"button\" value=\"提交\" onclick=\"do_submit()\" class=\"btn_submit\" onmouseover=\"this.className='btn_submit_on'\" onmouseout=\"this.className='btn_submit'\" >\r\n");
          out.write("\t\t\t");
} else{
          out.write("\r\n");
          out.write("\t\t\t\t<input type=\"button\" value=\"审核\" onclick=\"do_submit()\" class=\"btn_submit\" onmouseover=\"this.className='btn_submit_on'\" onmouseout=\"this.className='btn_submit'\" >\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t");
} 
if(!ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())){ 
          out.write("\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t<input type=\"button\" value=\"驳回\" onclick=\"showRefuseReason()\" class=\"btn_back\" onmouseover=\"this.className='btn_back_on'\" onmouseout=\"this.className='btn_back'\" >\r\n");
          out.write("\t\t\t");
} 
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t<button onclick=\"print()\" class=\"btn_print\" onmouseover=\"this.className='btn_print_on'\" onmouseout=\"this.className='btn_print'\" >打印</button>\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t<button onclick=\"viewRefuseReCord()\" class=\"btn_refuse\" onmouseover=\"this.className='btn_refuse_on'\" onmouseout=\"this.className='btn_refuse'\" >驳回记录</button>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<br />\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t");
if("1".equals(request.getAttribute("showRefuseReason"))){ 
          out.write("\r\n");
          out.write("\t\t\t<div>\r\n");
          out.write("\t\t\t\t<font color=\"red\" size=\"2\">驳回原因： ");
          out.print(request.getAttribute("refuseReason") );
          out.write("</font> \r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t");
 }
          out.write("\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t<div style=\"position: relative; display: inline-block; width: 100%; height: 72px;\">\r\n");
          out.write("\t\t\t<img alt=\"\" src=\"");
          out.print(path);
          out.write("/img/img1.JPG\"\r\n");
          out.write("\t\t\t\tstyle=\"position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20\">\r\n");
          out.write("\t\t\t<font size=\"2\">分公司差旅费申请</font>\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\" bgcolor=\"#AFC7D6\">\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\" >申请单状态：\r\n");
          out.write("    \t\t\t\t\t\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\" >\r\n");
          out.write("    \t\t\t\t\t\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\" >申请单号：\r\n");
          out.write("    \t\t\t\t\t\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" colspan=\"2\">\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\">出差人姓名\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\">职员编码\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\">成本中心代码\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t ");
          if (_jspx_meth_html_005fselect_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\t\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\">部门\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" width=\"20%\">电话\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" >出差地点\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">出差事由\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">随同人员\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">日期\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f6(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
          out.write("    \t\t\t\t\t发票寄回日期\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f7(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
          out.write("    \t\t\t\t\t总金额<br />\r\n");
          out.write("    \t\t\t\t\t￥");
          //  html:text
          org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f8 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
          _jspx_th_html_005ftext_005f8.setPageContext(_jspx_page_context);
          _jspx_th_html_005ftext_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
          // /expense/tripExpenseApply.jsp(1142,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005ftext_005f8.setProperty("totalMoney");
          // /expense/tripExpenseApply.jsp(1142,10) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005ftext_005f8.setValue(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("tripCost")));
          // /expense/tripExpenseApply.jsp(1142,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005ftext_005f8.setStyleId("totalMoney");
          // /expense/tripExpenseApply.jsp(1142,10) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005ftext_005f8.setStyleClass("text_read_common");
          int _jspx_eval_html_005ftext_005f8 = _jspx_th_html_005ftext_005f8.doStartTag();
          if (_jspx_th_html_005ftext_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f8);
            return;
          }
          _005fjspx_005ftagPool_005fhtml_005ftext_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f8);
          out.write("\r\n");
          out.write("    \t\t\t\t\t\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
          out.write("    \t\t\t\t\t预算金额<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f9(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
          out.write("    \t\t\t\t\t已用金额<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f10(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td colspan=\"1\" class=\"td_field\">\r\n");
          out.write("    \t\t\t\t\t   附件<br /> ");
          if (_jspx_meth_html_005ftext_005f11(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("P/张\t\t\r\n");
          out.write("    \t\t\t\t\t\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" >收款人\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f12(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td class=\"td_field\" colspan=\"5\">付款说明\r\n");
          out.write("    \t\t\t\t\t<br />\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t</table>\r\n");
          out.write("    \t\t</div>\r\n");
          out.write("    \t\t");
          int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
      out.write("\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<div id=\"topDiv\" style=\"width: 95%\">\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<table id=\"tirpDetailTable\"  border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("    \t\t\t<tr>\r\n");
      out.write("    \t\t\t\t<td   class=\"td_field_title\" colspan=\"2\">出发\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td   class=\"td_field_title\" colspan=\"2\">到达\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td   class=\"td_field_title\" colspan=\"2\">里程\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td  class=\"td_field_title\" colspan=\"6\">交通和住宿费和补贴费\t</td>\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t<tr>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\"  >起点\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >日期\r\n");
      out.write("\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >终点\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >日期</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >公里 </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >汽油费</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >火车票</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >出租车</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >飞机票\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >其他交通\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >住宿费\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" >餐费和补贴\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\t\t\t\t\r\n");
      out.write("    \t\t\t");
 List  detailList =(List)request.getAttribute("detailList"); 
    			   int detailListSize = 0;
    			   int SN = 0;
    			   if(detailList != null){
    			   	   detailListSize =  detailList.size();
    			   }
    			   int beginIndex = 1100;
    			   for(int i=0;i<detailListSize;i++){
    			   	 TripExpenseDetail detail = (TripExpenseDetail) detailList.get(i);
    			   	 beginIndex++;
    			   	 if(detail.getSN()!=null && !"".equals(detail.getSN())){
    			   	 	SN = Integer.parseInt(detail.getSN());
    				 }else{
    				 	SN++;
    				 }
    			
      out.write("\r\n");
      out.write("    \t\t\t<tr  id=\"");
      out.print(beginIndex);
      out.write("\">\r\n");
      out.write("    \t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"");
      out.print(beginIndex);
      out.write("-SN\" value=\"");
      out.print(SN);
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td  class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"   name=\"起点起点\" id=\"");
      out.print(beginIndex);
      out.write("-fromAdress\" class=\"text_write_noborder_trip\" onchange=\"modifyExpense('1',this,'出发')\" value=\"");
      out.print(detail.getFromAdress());
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"日期\"  onclick=\"setday(this)\" id=\"");
      out.print(beginIndex);
      out.write("-fromDate\" readonly=\"readonly\" class=\"text_write_noborder_trip\"  onpropertychange=\"modifyExpense('1',this,'日期')\" value=\"");
      out.print(detail.getFromDate());
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"终点\" id=\"");
      out.print(beginIndex);
      out.write("-toAdress\" class=\"text_write_noborder_trip\" onchange=\"modifyExpense('1',this,'终点')\" value=\"");
      out.print(detail.getToAdress());
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"日期\" onclick=\"setday(this)\" id=\"");
      out.print(beginIndex);
      out.write("-toDate\" readonly=\"readonly\"  class=\"text_write_noborder_trip\" onpropertychange=\"modifyExpense('1',this,'日期')\" value=\"");
      out.print(detail.getToDate());
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"公里\" id=\"");
      out.print(beginIndex);
      out.write("-KM\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'公里')\" value=\"");
      out.print(detail.getKM()==null?"":detail.getKM());
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"汽油费\" id=\"");
      out.print(beginIndex);
      out.write("-gasolineCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'汽油费')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getGasolineCost()==null?"":detail.getGasolineCost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"火车票\" id=\"");
      out.print(beginIndex);
      out.write("-trainCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'火车票')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getTrainCost()==null?"":detail.getTrainCost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\" name=\"出租车\" id=\"");
      out.print(beginIndex);
      out.write("-taxiCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'出租车')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getTaxiCost()==null?"":detail.getTaxiCost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"飞机票\" id=\"");
      out.print(beginIndex);
      out.write("-airplaneCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'飞机票')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getAirplaneCost()==null?"":detail.getAirplaneCost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"其他交通\" id=\"");
      out.print(beginIndex);
      out.write("-others\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'其他交通')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getOthers()==null?"":detail.getOthers()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"住宿费\" id=\"");
      out.print(beginIndex);
      out.write("-hotelCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'住宿费')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getHotelCost()==null?"":detail.getHotelCost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"餐费和补贴\" id=\"");
      out.print(beginIndex);
      out.write("-meal_allowance_cost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'餐费和补贴')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,detail.getMeal_allowance_cost()==null?"":detail.getMeal_allowance_cost()));
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t");
 }
      out.write("\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t");
 
    			int loopLen = 10-detailListSize;
    		     beginIndex = 1000;
    			for(int i=0;i<loopLen;i++){ 
    				beginIndex++; 
    				SN++;
    			
      out.write("\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t<tr id=\"");
      out.print(beginIndex);
      out.write("\">\r\n");
      out.write("    \t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"");
      out.print(beginIndex);
      out.write("-SN\" value=\"");
      out.print(SN);
      out.write("\"> </td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"   name=\"起点起点\" id=\"");
      out.print(beginIndex);
      out.write("-fromAdress\" class=\"text_write_noborder_trip\" onchange=\"modifyExpense('1',this,'出发')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"日期\"  onclick=\"setday(this)\" id=\"");
      out.print(beginIndex);
      out.write("-fromDate\" readonly=\"readonly\" class=\"text_write_noborder_trip\"  onpropertychange=\"modifyExpense('1',this,'日期')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"终点\" id=\"");
      out.print(beginIndex);
      out.write("-toAdress\" class=\"text_write_noborder_trip\" onchange=\"modifyExpense('1',this,'终点')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"日期\" onclick=\"setday(this)\" id=\"");
      out.print(beginIndex);
      out.write("-toDate\" readonly=\"readonly\" class=\"text_write_noborder_trip\" onpropertychange=\"modifyExpense('1',this,'日期')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"公里\" id=\"");
      out.print(beginIndex);
      out.write("-KM\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'公里')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"汽油费\" id=\"");
      out.print(beginIndex);
      out.write("-gasolineCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'汽油费')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"火车票\" id=\"");
      out.print(beginIndex);
      out.write("-trainCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'火车票')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\" name=\"出租车\" id=\"");
      out.print(beginIndex);
      out.write("-taxiCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'出租车')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"飞机票\" id=\"");
      out.print(beginIndex);
      out.write("-airplaneCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'飞机票')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"其他交通\" id=\"");
      out.print(beginIndex);
      out.write("-others\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'其他交通')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"住宿费\" id=\"");
      out.print(beginIndex);
      out.write("-hotelCost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'住宿费')\"> </td>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\"><input style=\"background-color:white;border-style: none;border-width:0;font-size: 12;width: 84;\" type=\"text\"  name=\"餐费和补贴\" id=\"");
      out.print(beginIndex);
      out.write("-meal_allowance_cost\" class=\"text_write_noborder_trip\" onchange=\"modifyExpenseNumber('1',this,'餐费和补贴')\" onkeydown=\"getLastTextValue(this)\"> </td>\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t");
} 
      out.write("\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t<tr>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\" colspan=\"5\">\r\n");
      out.write("    \t\t\t\t\t\r\n");
      out.write("    \t\t\t\t费用小计\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\"><input style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\" type=\"text\" id=\"gasolineCost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("gasolineCost")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input  style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\"   type=\"text\"  id=\"trainCost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("trainCost")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input  style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\"  type=\"text\" id=\"taxiCost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("taxiCost")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\"  type=\"text\" id=\"airplaneCost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("airplaneCost")));
      out.write("\">\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\" type=\"text\" id=\"others\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("others")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\" type=\"text\"  id=\"hotelCost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("hotelCost")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field_title\">\r\n");
      out.write("    \t\t\t\t\t<input style=\"background-color:#E7ECF3;border-style: none;border-width:0;readonly:expression(this.readOnly=true);font-size: 12;width: 84;\"  type=\"text\" id=\"meal_allowance_cost\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("meal_allowance_cost")));
      out.write("\" >\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("    \t\t\t<!-- <td  class=\"td_field_title\"> \r\n");
      out.write("    \t\t\t\t\t费用小计</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\t<td class=\"td_field\">\r\n");
      out.write("    \t\t\t\t\t</td>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t</tr>\r\n");
      out.write("   \r\n");
      out.write("    \t\t\t -->\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t</table>\r\n");
      out.write("    \t\t</div>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<br />\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div >\r\n");
      out.write("\t\t\t<input type=\"button\"  value=\"添加\" class=\"btn_add\" onmouseover=\"this.className='btn_add_on'\" onmouseout=\"this.className='btn_add'\"\r\n");
      out.write("\t\t\t\talign=\"left\" onclick=\"addExpense('0','200')\">\r\n");
      out.write("\t\t\t<input type=\"button\" class=\"btn_delete\" onmouseover=\"this.className='btn_delete_on'\" onmouseout=\"this.className='btn_delete'\" value=\"删除\"\r\n");
      out.write("\t\t\t\talign=\"right\" onclick=\"deleteExpense('2','200')\">\r\n");
      out.write("\t\t\t<font color=\"red\" size=\"2\"> 注：输入店铺成本中心后一般会自动获取到店铺名，如果没有获取到，请手工输入！</font>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<table id='200' width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
      out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"4%\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t店铺成本中心\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t店铺名\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td id=\"shopTotalCost\" class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t金额(");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_shopTotalCost")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t备注\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr id=\"2000-tr\" style=\"display: none\">\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"2000-SN\" value=\"-1\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"2000\" value=\"2000\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2000-shopCostCenterCode\" name=\"店铺成本中心\" type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2000-shopName\" name=\"店铺名\"  type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺名')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2000-expenseAmout\" name=\"金额\"  type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'奖励金额')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2001-comment\" name=\"备注\" type=\"text\" \tclass=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
List shopCostList = (List)request.getAttribute("shopCostList");
				 int shopCostListSize = 0;
				 SN=0;
				 if(shopCostList!=null){
				 	 shopCostListSize = shopCostList.size();
				 }
					
				 for (int i = 0; i < shopCostListSize; i++) {
				     	TripExpenseShopCost shopCost =(TripExpenseShopCost) shopCostList.get(i);
						if(shopCost.getSN()!=null && !shopCost.getSN().equals("")){
							SN = Integer.parseInt(shopCost.getSN());
						}else{
							SN++;
						}
				
				
      out.write("\r\n");
      out.write("\t\t\t\t<tr id=\"");
      out.print(2101+i);
      out.write("-tr\">\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"");
      out.print(2101+i);
      out.write("-SN\" value=\"");
      out.print(SN);
      out.write("\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"");
      out.print(2101+i);
      out.write("\" value=\"2001\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-shopCostCenterCode\" name=\"店铺成本中心\" type=\"text\" value=\"");
      out.print(shopCost.getShopCostCenterCode());
      out.write("\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-shopName\" type=\"text\" name=\"店铺名\" value=\"");
      out.print(shopCost.getShopName());
      out.write("\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺名')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-expenseAmout\" name=\"金额\" type=\"text\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)shopCost.getExpenseAmout()));
      out.write("\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'奖励金额')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-comment\" type=\"text\" name=\"备注\"  value=\"");
      out.print(shopCost.getComment());
      out.write("\"\tclass=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
if(request.getAttribute("isInit")!=null && request.getAttribute("isInit").equals("1")) {
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<tr id=\"2001-tr\">\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"2001-SN\" value=\"");
      out.print(++SN);
      out.write("\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"2001\" value=\"2001\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2001-shopCostCenterCode\" name=\"店铺成本中心\" type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺成本中心');getShopNameByCS(this)\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2001-shopName\" name=\"店铺名\"  type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'店铺名')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2001-expenseAmout\" name=\"金额\"  type=\"text\" value=\"\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'奖励金额')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"2001-comment\" name=\"备注\" type=\"text\" \tclass=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<br />\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<br />\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<input type=\"button\" class=\"btn_add\" onmouseover=\"this.className='btn_add_on'\" onmouseout=\"this.className='btn_add'\" value=\"添加\"\r\n");
      out.write("\t\t\t\talign=\"left\" onclick=\"addExpense('0','300')\">\r\n");
      out.write("\t\t\t<input type=\"button\" class=\"btn_delete\" onmouseover=\"this.className='btn_delete_on'\" onmouseout=\"this.className='btn_delete'\"  value=\"删除\"\r\n");
      out.write("\t\t\t\talign=\"right\" onclick=\"deleteExpense('2','300')\">\r\n");
      out.write("\t\t\t<input type=\"button\" class=\"btn_delete\" onmouseover=\"this.className='btn_delete_on'\" onmouseout=\"this.className='btn_delete'\" value=\"预算\"\r\n");
      out.write("\t\t\t\talign=\"right\" onclick=\"showBudgt()\">\r\n");
      out.write("\t\t\t<table id='300' width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
      out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"4%\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t大类\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"12.2%\">\r\n");
      out.write("\t\t\t\t\t\t所属科目\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"10.2%\">\r\n");
      out.write("\t\t\t\t\t\t科目代码\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td id=\"subjectTotalCost\" class=\"td_field_title\" width=\"12.2%\">\r\n");
      out.write("\t\t\t\t\t\t金额(");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("BTESubjectTotalCost")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t备注\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<td class=\"td_field_title\" width=\"12%\">\r\n");
      out.write("\t\t\t\t\t\t科目预算金额\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"12%\">\r\n");
      out.write("\t\t\t\t\t\t科目已用金额\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<tr id=\"3000-tr\" style=\"display: none\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"3000-SN\" value=\"-1\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"3000\" value=\"3000\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<select id=\"3000-categoryCode\" onchange=\"getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
List categoryList = (List)request.getAttribute("categoryList");  
								 int categoryListSize = 0;
							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"");
      out.print(selectOptionObj.getValue() );
      out.write('"');
      out.write('>');
      out.print(selectOptionObj.getLable());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</select>\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<select  id=\"3000-subjectCode\"  onchange=\"getAccountCode(this);\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3000-accountCode\" name=\"科目代码\" type=\"text\" readonly=\"readonly\" class=\"text_write_common\" onpropertychange=\"modifyExpenseSubject('1',this,'科目代码');\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3000-subjectAmout\" name=\"金额\" type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'科目金额')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3000-comment\" name=\"备注\" type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注');\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3000-subjectBudget\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3000-subjectUsedMoney\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
List subjectCostList = (List)request.getAttribute("BTESubjectCostList");
				 SN = 0;	
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	TripExpenseSubjectCost subjectCost =(TripExpenseSubjectCost) subjectCostList.get(i);
						if(subjectCost.getSN()!=null && !subjectCost.getSN().equals("")){
							SN = Integer.parseInt(subjectCost.getSN());
						}else{
							SN++;
						}
				
      out.write("\r\n");
      out.write("\t\t\t\t<tr id=\"");
      out.print(3101+i);
      out.write("-tr\">\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"");
      out.print(3101+i);
      out.write("-SN\" value=\"");
      out.print(SN);
      out.write("\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"");
      out.print(3101+i);
      out.write("\" id=\"");
      out.print(3101+i);
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<select id=\"");
      out.print(3101+i);
      out.write("-categoryCode\" onchange=\"getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");

							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
								if(!selectOptionObj.getValue().equals(subjectCost.getCategoryCode())){
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"");
      out.print(selectOptionObj.getValue() );
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(selectOptionObj.getLable());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
}else{ 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"");
      out.print(selectOptionObj.getValue() );
      out.write("\" selected=\"selected\">");
      out.print(selectOptionObj.getLable());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
}} 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t</select>\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td id=\"");
      out.print(3101+i);
      out.write("-accountNameTD\" class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-accountName\"  type=\"text\" class=\"text_write_common\" readonly=\"readonly\" value=\"");
      out.print(subjectCost.getAccountName());
      out.write("\" onclick=\"getaccountListBySuper(this)\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td id=\"");
      out.print(3101+i);
      out.write("-subjectCodeTD\" class=\"td_text_center_nodisplay\">\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<select  id=\"");
      out.print(3101+i);
      out.write("-subjectCode\"  onchange=\"getAccountCode(this);\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-accountCode\" name=\"科目代码\"  type=\"text\" readonly=\"readonly\" class=\"text_write_common\" onpropertychange=\"modifyExpenseSubject('1',this,'科目代码');\" value=\"");
      out.print(subjectCost.getAccountCode() );
      out.write(" \">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-subjectAmout\" name=\"金额\" type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'科目金额')\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)subjectCost.getSubjectAmout()));
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-comment\" name=\"备注\"  type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注');\" value=\"");
      out.print(subjectCost.getComment());
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t <td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-subjectBudget\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-subjectUsedMoney\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
if(request.getAttribute("isInit")!=null && request.getAttribute("isInit").equals("1")) {
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<tr id=\"3001-tr\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input name=\"SN\" id=\"3001-SN\" value=\"");
      out.print(++SN);
      out.write("\"> </td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"3001\" value=\"3001\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<select id=\"3001-categoryCode\" onchange=\"getaccountList(this,'大类');modifyExpenseSubject('1',this,'大类');\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");

							 if(categoryList!=null){
				 				 categoryListSize = categoryList.size();
							 }
							 for(int j=0;j<categoryListSize;j++){
								SelectOptionObj selectOptionObj = (SelectOptionObj)categoryList.get(j);
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"");
      out.print(selectOptionObj.getValue() );
      out.write('"');
      out.write('>');
      out.print(selectOptionObj.getLable());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</select>\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<select  id=\"3001-subjectCode\"  onchange=\"getAccountCode(this);\" style=\"width: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3001-accountCode\" name=\"科目代码\" type=\"text\" readonly=\"readonly\" class=\"text_write_common\" onpropertychange=\"modifyExpenseSubject('1',this,'科目代码');\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3001-subjectAmout\" name=\"金额\" type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseNumber('1',this,'科目金额')\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3001-comment\" name=\"备注\" type=\"text\" class=\"text_write_common\" onchange=\"modifyExpenseSubject('1',this,'备注');\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t <td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3001-subjectBudget\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"3001-subjectUsedMoney\"  type=\"text\" class=\"text_read_common\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("    \r\n");
      out.write("    </div>\t\r\n");
      out.write("    \t\r\n");
      out.write("  </body>\r\n");
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

  private boolean _jspx_meth_html_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1011,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("applyStateCode");
    // /expense/tripExpenseApply.jsp(1011,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("applyStateCode");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1012,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setStyleId("action");
    // /expense/tripExpenseApply.jsp(1012,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("action");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1013,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setStyleId("expenseInfoID");
    // /expense/tripExpenseApply.jsp(1013,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setProperty("expenseInfoID");
    int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
    if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f3 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1014,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setStyleId("expenseNo");
    // /expense/tripExpenseApply.jsp(1014,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setProperty("expenseNo");
    int _jspx_eval_html_005fhidden_005f3 = _jspx_th_html_005fhidden_005f3.doStartTag();
    if (_jspx_th_html_005fhidden_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f4 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1015,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setStyleId("printFlag");
    // /expense/tripExpenseApply.jsp(1015,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setProperty("printFlag");
    int _jspx_eval_html_005fhidden_005f4 = _jspx_th_html_005fhidden_005f4.doStartTag();
    if (_jspx_th_html_005fhidden_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005ftextarea_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:textarea
    org.apache.struts.taglib.html.TextareaTag _jspx_th_html_005ftextarea_005f0 = (org.apache.struts.taglib.html.TextareaTag) _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.get(org.apache.struts.taglib.html.TextareaTag.class);
    _jspx_th_html_005ftextarea_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftextarea_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1019,4) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setStyleId("refuseReason");
    // /expense/tripExpenseApply.jsp(1019,4) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setProperty("refuseReason");
    // /expense/tripExpenseApply.jsp(1019,4) name = cols type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setCols("80");
    // /expense/tripExpenseApply.jsp(1019,4) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setRows("5");
    int _jspx_eval_html_005ftextarea_005f0 = _jspx_th_html_005ftextarea_005f0.doStartTag();
    if (_jspx_th_html_005ftextarea_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.reuse(_jspx_th_html_005ftextarea_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.reuse(_jspx_th_html_005ftextarea_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1070,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("applyStateName");
    // /expense/tripExpenseApply.jsp(1070,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyleId("applyStateName");
    // /expense/tripExpenseApply.jsp(1070,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyleClass("text_read_red");
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1077,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("expenseNo");
    // /expense/tripExpenseApply.jsp(1077,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyleId("expenseNo");
    // /expense/tripExpenseApply.jsp(1077,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyleClass("text_read_red");
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f2 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1087,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setProperty("tripName");
    // /expense/tripExpenseApply.jsp(1087,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyleId("tripName");
    // /expense/tripExpenseApply.jsp(1087,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftext_005f2 = _jspx_th_html_005ftext_005f2.doStartTag();
    if (_jspx_th_html_005ftext_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f3 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1091,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setProperty("employeeID");
    // /expense/tripExpenseApply.jsp(1091,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyleId("employeeID");
    // /expense/tripExpenseApply.jsp(1091,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftext_005f3 = _jspx_th_html_005ftext_005f3.doStartTag();
    if (_jspx_th_html_005ftext_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:select
    org.apache.struts.taglib.html.SelectTag _jspx_th_html_005fselect_005f0 = (org.apache.struts.taglib.html.SelectTag) _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange.get(org.apache.struts.taglib.html.SelectTag.class);
    _jspx_th_html_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1096,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setStyleId("branchCode");
    // /expense/tripExpenseApply.jsp(1096,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setProperty("branchCode");
    // /expense/tripExpenseApply.jsp(1096,10) name = onchange type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setOnchange("changeBranchCode()");
    // /expense/tripExpenseApply.jsp(1096,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setStyle("width: 100%");
    int _jspx_eval_html_005fselect_005f0 = _jspx_th_html_005fselect_005f0.doStartTag();
    if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fselect_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fselect_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t");
        if (_jspx_meth_html_005foptionsCollection_005f0(_jspx_th_html_005fselect_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_html_005fselect_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange.reuse(_jspx_th_html_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fstyle_005fproperty_005fonchange.reuse(_jspx_th_html_005fselect_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005foptionsCollection_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fselect_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:optionsCollection
    org.apache.struts.taglib.html.OptionsCollectionTag _jspx_th_html_005foptionsCollection_005f0 = (org.apache.struts.taglib.html.OptionsCollectionTag) _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.get(org.apache.struts.taglib.html.OptionsCollectionTag.class);
    _jspx_th_html_005foptionsCollection_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005foptionsCollection_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fselect_005f0);
    // /expense/tripExpenseApply.jsp(1097,7) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setName("branchList");
    // /expense/tripExpenseApply.jsp(1097,7) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setValue("value");
    // /expense/tripExpenseApply.jsp(1097,7) name = label type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setLabel("lable");
    int _jspx_eval_html_005foptionsCollection_005f0 = _jspx_th_html_005foptionsCollection_005f0.doStartTag();
    if (_jspx_th_html_005foptionsCollection_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f4 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1104,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setProperty("branchName");
    // /expense/tripExpenseApply.jsp(1104,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setStyleId("branchName");
    // /expense/tripExpenseApply.jsp(1104,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setStyleClass("text_read_common");
    int _jspx_eval_html_005ftext_005f4 = _jspx_th_html_005ftext_005f4.doStartTag();
    if (_jspx_th_html_005ftext_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f5 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1109,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setProperty("telephone");
    // /expense/tripExpenseApply.jsp(1109,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setStyleId("telephone");
    // /expense/tripExpenseApply.jsp(1109,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftext_005f5 = _jspx_th_html_005ftext_005f5.doStartTag();
    if (_jspx_th_html_005ftext_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f5);
    return false;
  }

  private boolean _jspx_meth_html_005ftextarea_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:textarea
    org.apache.struts.taglib.html.TextareaTag _jspx_th_html_005ftextarea_005f1 = (org.apache.struts.taglib.html.TextareaTag) _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextareaTag.class);
    _jspx_th_html_005ftextarea_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftextarea_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1116,9) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f1.setRows("1");
    // /expense/tripExpenseApply.jsp(1116,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f1.setProperty("tripAddress");
    // /expense/tripExpenseApply.jsp(1116,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f1.setStyleId("tripAddress");
    // /expense/tripExpenseApply.jsp(1116,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f1.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftextarea_005f1 = _jspx_th_html_005ftextarea_005f1.doStartTag();
    if (_jspx_th_html_005ftextarea_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftextarea_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:textarea
    org.apache.struts.taglib.html.TextareaTag _jspx_th_html_005ftextarea_005f2 = (org.apache.struts.taglib.html.TextareaTag) _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextareaTag.class);
    _jspx_th_html_005ftextarea_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftextarea_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1120,9) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f2.setRows("1");
    // /expense/tripExpenseApply.jsp(1120,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f2.setProperty("tripPurposes");
    // /expense/tripExpenseApply.jsp(1120,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f2.setStyleId("tripPurposes");
    // /expense/tripExpenseApply.jsp(1120,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f2.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftextarea_005f2 = _jspx_th_html_005ftextarea_005f2.doStartTag();
    if (_jspx_th_html_005ftextarea_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005ftextarea_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:textarea
    org.apache.struts.taglib.html.TextareaTag _jspx_th_html_005ftextarea_005f3 = (org.apache.struts.taglib.html.TextareaTag) _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextareaTag.class);
    _jspx_th_html_005ftextarea_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftextarea_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1124,9) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f3.setRows("1");
    // /expense/tripExpenseApply.jsp(1124,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f3.setProperty("tripMenber");
    // /expense/tripExpenseApply.jsp(1124,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f3.setStyleId("tripMenber");
    // /expense/tripExpenseApply.jsp(1124,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f3.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftextarea_005f3 = _jspx_th_html_005ftextarea_005f3.doStartTag();
    if (_jspx_th_html_005ftextarea_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005frows_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f6 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f6.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1128,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setProperty("applyDate");
    // /expense/tripExpenseApply.jsp(1128,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setStyleId("applyDate");
    // /expense/tripExpenseApply.jsp(1128,9) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setReadonly(true);
    // /expense/tripExpenseApply.jsp(1128,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setStyleClass("text_read_common");
    int _jspx_eval_html_005ftext_005f6 = _jspx_th_html_005ftext_005f6.doStartTag();
    if (_jspx_th_html_005ftext_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f6);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f7 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f7.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1134,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setStyleId("invoiceBackDate");
    // /expense/tripExpenseApply.jsp(1134,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setProperty("invoiceBackDate");
    // /expense/tripExpenseApply.jsp(1134,9) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setOnclick("setday(this)");
    // /expense/tripExpenseApply.jsp(1134,9) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setReadonly(true);
    // /expense/tripExpenseApply.jsp(1134,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftext_005f7 = _jspx_th_html_005ftext_005f7.doStartTag();
    if (_jspx_th_html_005ftext_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f7);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f9 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f9.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1148,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setProperty("budget");
    // /expense/tripExpenseApply.jsp(1148,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setStyleId("budget");
    // /expense/tripExpenseApply.jsp(1148,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setStyleClass("text_read_common");
    int _jspx_eval_html_005ftext_005f9 = _jspx_th_html_005ftext_005f9.doStartTag();
    if (_jspx_th_html_005ftext_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f9);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f10 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f10.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1153,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setProperty("usedAmount");
    // /expense/tripExpenseApply.jsp(1153,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setStyleId("usedAmount");
    // /expense/tripExpenseApply.jsp(1153,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setStyleClass("text_read_common");
    int _jspx_eval_html_005ftext_005f10 = _jspx_th_html_005ftext_005f10.doStartTag();
    if (_jspx_th_html_005ftext_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f10);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f11 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f11.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1159,21) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setStyleId("attachments");
    // /expense/tripExpenseApply.jsp(1159,21) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setProperty("attachments");
    // /expense/tripExpenseApply.jsp(1159,21) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setStyle("background-color:white;width:60;	font-size: 12;");
    // /expense/tripExpenseApply.jsp(1159,21) name = onchange type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setOnchange("validateNumber(this)");
    int _jspx_eval_html_005ftext_005f11 = _jspx_th_html_005ftext_005f11.doStartTag();
    if (_jspx_th_html_005ftext_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody.reuse(_jspx_th_html_005ftext_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fonchange_005fnobody.reuse(_jspx_th_html_005ftext_005f11);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f12(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f12 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f12.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1165,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setProperty("receiveName");
    // /expense/tripExpenseApply.jsp(1165,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setStyleId("receiveName");
    // /expense/tripExpenseApply.jsp(1165,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftext_005f12 = _jspx_th_html_005ftext_005f12.doStartTag();
    if (_jspx_th_html_005ftext_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f12);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f12);
    return false;
  }

  private boolean _jspx_meth_html_005ftextarea_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:textarea
    org.apache.struts.taglib.html.TextareaTag _jspx_th_html_005ftextarea_005f4 = (org.apache.struts.taglib.html.TextareaTag) _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextareaTag.class);
    _jspx_th_html_005ftextarea_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftextarea_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/tripExpenseApply.jsp(1173,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f4.setProperty("payComment");
    // /expense/tripExpenseApply.jsp(1173,9) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f4.setStyleId("payComment");
    // /expense/tripExpenseApply.jsp(1173,9) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f4.setStyleClass("text_write_common");
    int _jspx_eval_html_005ftextarea_005f4 = _jspx_th_html_005ftextarea_005f4.doStartTag();
    if (_jspx_th_html_005ftextarea_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005fstyleClass_005fproperty_005fnobody.reuse(_jspx_th_html_005ftextarea_005f4);
    return false;
  }
}
