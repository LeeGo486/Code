package org.apache.jsp.vipCustomerApprove;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class vipCustomerApprove_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/ecside.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005fdoPreload_005fclassic_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005frow_005frecordKey;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fondblclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005fdoPreload_005fclassic_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fondblclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005fdoPreload_005fclassic_005faction.release();
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fondblclick_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fnobody.release();
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
      response.setContentType("text/html; charset=utf-8");
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

	String path = request.getContextPath();

      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<title>大客户审批</title>\r\n");
      out.write("\r\n");
      out.write("\t \r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/ecside/css/ecside_style.css\" />\r\n");
      out.write("\t\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/prototype_mini.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/ecside_msg_utf8_cn.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/ecside.js\"></script>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("\t\t<script src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t</head>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\tvar department;\r\n");
      out.write("\t$(function() {\r\n");
      out.write("\r\n");
      out.write("\t\t$('#department').combogrid({\r\n");
      out.write("\t\t\tpanelWidth : 250,\r\n");
      out.write("\t\t\tidField : 'dept_id',\r\n");
      out.write("\t\t\ttextField : 'dept_name',\r\n");
      out.write("\r\n");
      out.write("\t\t\tcolumns : [ [ {\r\n");
      out.write("\t\t\t\tfield : 'dept_id',\r\n");
      out.write("\t\t\t\ttitle : '编号',\r\n");
      out.write("\t\t\t\twidth : 50\r\n");
      out.write("\t\t\t}, {\r\n");
      out.write("\t\t\t\tfield : 'dept_name',\r\n");
      out.write("\t\t\t\ttitle : '店铺名称',\r\n");
      out.write("\t\t\t\twidth : 200\r\n");
      out.write("\t\t\t} ] ]\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\tgetDepartment();\r\n");
      out.write("\t\tinitForm();\r\n");
      out.write("\t});\r\n");
      out.write("\r\n");
      out.write("\tfunction getDepartment() {\r\n");
      out.write("\t\tif (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("\t\t\txmlhttp = new XMLHttpRequest();\r\n");
      out.write("\t\t} else {// code for IE6, IE5\r\n");
      out.write("\t\t\txmlhttp = new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange = function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState == 4 && xmlhttp.status == 200) {\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tdepartment = eval(\"(\" + xmlhttp.responseText + \")\");\r\n");
      out.write("\t\t\t\t$(\"#department\").combogrid(\"grid\").datagrid(\"loadData\", department);\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t};\r\n");
      out.write("\r\n");
      out.write("\t\t//var loginDeptID = document.getElementById(\"deptID\").value;\r\n");
      out.write("\t\txmlhttp.open(\"post\", \"ajax.ajaxServlet\", true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\r\n");
      out.write("\t\t\t\t\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=getDepartmentList\");\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction query(){\r\n");
      out.write("\t\tdocument.forms[0].submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction approveBatch(){\r\n");
      out.write("\t\tif(validateCheckBox()){\r\n");
      out.write("\t\t\t$('#method').attr('value','approveBatch');\r\n");
      out.write("\t\t\tdocument.forms[0].submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction refuseBatch(){\r\n");
      out.write("\t\tif(validateCheckBox()){\r\n");
      out.write("\t\t\t$('#method').attr('value','refuseBatch');\r\n");
      out.write("\t\t\tdocument.forms[0].submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction approve(){\r\n");
      out.write("\t\tvar accountIDs = $('#account_id').attr('value');\r\n");
      out.write("\t\t$('#accountIDs').attr('value',accountIDs);\r\n");
      out.write("\t\t$('#method').attr('value','approve');\r\n");
      out.write("\t\tdocument.forms[0].submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction refuse(){\r\n");
      out.write("\t\tvar accountIDs = $('#account_id').attr('value');\r\n");
      out.write("\t\t$('#accountIDs').attr('value',accountIDs);\r\n");
      out.write("\t\t$('#method').attr('value','refuse');\r\n");
      out.write("\t\tdocument.forms[0].submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction initForm(){\r\n");
      out.write("\t\tvar result = $('#result').attr('value');\r\n");
      out.write("\t\tif(result=='0'||result=='-1'||result=='-2'||result=='-3'){\r\n");
      out.write("\t\t\talert('操作失败');\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tif(result=='1'){\r\n");
      out.write("\t\t\talert('操作成功');\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tif(result=='2'){\r\n");
      out.write("\t\t\talert('部分操作成功');\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction hiddenDetail(){\r\n");
      out.write("\t\t$('#customerDetail').hide();\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction viewDetail() { \r\n");
      out.write("\t\tvar ecsideObj=ECSideUtil.getGridObj('ecTable');\r\n");
      out.write("\t\tvar selectedRow = ecsideObj.selectedRow;\r\n");
      out.write("\t\tvar recordKey = selectedRow.getAttribute(\"recordKey\");\r\n");
      out.write("\t\tvar para = new Object();\r\n");
      out.write("\t\tpara[\"accountID\"] = recordKey;\r\n");
      out.write("\t\t$.post(\r\n");
      out.write("\t\t\t\t$('#path').attr('value') + '/vipCustomerApprove.do?method=viewDetail',para,\r\n");
      out.write("\t\t\t\tfunction(rsp) {\r\n");
      out.write("\t\t\t\t\tvar datas = eval(\"(\" + rsp + \")\");\r\n");
      out.write("\t\t\t\t\tif (datas.account_id == undefined) {\r\n");
      out.write("\t\t\t\t\t\t$.messager.alert(\"提示\", \"找不到客户信息！\");\r\n");
      out.write("\t\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t$('#account_id').attr('value',datas.account_id);\r\n");
      out.write("\t\t\t\t\t\t$('#account_name').html(\"姓名：\"+datas.account_name);\r\n");
      out.write("\t\t\t\t\t\t$('#age').html(\"年龄：\"+datas.age);\r\n");
      out.write("\t\t\t\t\t\t$('#manager').html(\"客户经理：\"+datas.manager);\r\n");
      out.write("\t\t\t\t\t\t$('#sex').html(\"性别：\"+datas.sex);\r\n");
      out.write("\t\t\t\t\t\t$('#industry').html(\"行业：\"+datas.industry);\r\n");
      out.write("\t\t\t\t\t\t$('#job').html(\"岗位：\"+datas.job);\r\n");
      out.write("\t\t\t\t\t\t$('#annual_revenue').html(\"家庭年收入：\"+datas.annual_revenue);\r\n");
      out.write("\t\t\t\t\t\t$('#dept_name').html(\"店铺：\"+datas.dept_name);\r\n");
      out.write("\t\t\t\t\t\t$('#ZXFJE').html(\"总消费金额：\"+datas.ZXFJE);\r\n");
      out.write("\t\t\t\t\t\t$('#xiaofcs').html(\"总消费次数：\"+datas.xiaofcs);\r\n");
      out.write("\t\t\t\t\t\t$('#thisyearsale').html(\"今年消费：\"+datas.thisyearsale);\r\n");
      out.write("\t\t\t\t\t\t$('#lastdate').html(\"最近消费:\"+datas.lastdate);\r\n");
      out.write("\t\t\t\t\t\t$('#comment').html(\"备注:\"+datas.comment);\r\n");
      out.write("\t\t\t\t\t\t$('#customerDetail').show();\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}, \"text\").error(function() {\r\n");
      out.write("\t\t\t$.messager.alert(\"提示\", \"获取详细信息失败！\");\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction validateCheckBox() {\r\n");
      out.write("\t\tvar flag = true;\r\n");
      out.write("\t\tvar accountIDs = '';\r\n");
      out.write("\t\tvar arrayTr = $('#ecTable_table tr');\r\n");
      out.write("\t\tfor ( var i = 0; i < arrayTr.length; i++) {\r\n");
      out.write("\t\t\tvar thisTr = arrayTr[i];\r\n");
      out.write("\t\t\tif ($(thisTr).find('input').eq(0).attr('checked')) {\r\n");
      out.write("\t\t\t\taccountIDs = accountIDs + ',' + $(thisTr).attr('recordKey');\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\taccountIDs = accountIDs.substr(1, accountIDs.length - 1);\r\n");
      out.write("\t\tif (accountIDs == '') {\r\n");
      out.write("\t\t\talert('请选择操作记录');\r\n");
      out.write("\t\t\tflag = false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\t$('#accountIDs').attr('value', accountIDs);\r\n");
      out.write("\t\treturn flag;\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\t<body>\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result"));
      out.write("\">\r\n");
      out.write("\t\t");
      if (_jspx_meth_html_005fform_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div id=\"customerDetail\" style=\"position:absolute; display: none;background-color: #F3F4F3;height: 200;width:400;overflow: auto;border-color: gray;border-style: solid;border: 2;left:350;z-index: 2; text-align: center;\">\r\n");
      out.write("\t\t\t<input type=\"hidden\" id=\"account_id\">\r\n");
      out.write("\t\t\t<table>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td>基本信息</td>\r\n");
      out.write("\t\t\t\t\t<td><input type=\"button\" value=\"审批\" onclick=\"approve()\"><input type=\"button\" value=\"驳回\" onclick=\"refuse()\"><input type=\"button\" value=\"关闭\" onclick=\"hiddenDetail()\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"account_name\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"age\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"manager\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"sex\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"industry\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"job\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"annual_revenue\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"dept_name\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"comment\" colspan=\"2\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t\t消费信息\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"ZXFJE\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"xiaofcs\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td id=\"thisyearsale\"></td>\r\n");
      out.write("\t\t\t\t\t<td id=\"lastdate\"></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t \r\n");
      out.write("\t\t ");
      if (_jspx_meth_ec_005ftable_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\r\n");
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

  private boolean _jspx_meth_html_005fform_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:form
    org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fform_005f0.setParent(null);
    // /vipCustomerApprove/vipCustomerApprove.jsp(190,2) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setStyleId("vipCustomerApproveForm");
    // /vipCustomerApprove/vipCustomerApprove.jsp(190,2) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setAction("/vipCustomerApprove");
    // /vipCustomerApprove/vipCustomerApprove.jsp(190,2) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setMethod("post");
    int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
    if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t ");
        if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t ");
        if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t <table>\r\n");
        out.write("\t\t\t \t<tr>\r\n");
        out.write("\t\t\t \t\t<td>店铺名称：</td>\r\n");
        out.write("\t\t\t \t\t<td>");
        if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t \t\t<td>顾客姓名：</td>\r\n");
        out.write("\t\t\t \t\t<td>");
        if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t \t\t<td><input type=\"button\" value=\"查询\" onclick=\"query()\" style=\"width: 60\"> </td>\r\n");
        out.write("\t\t\t \t</tr>\r\n");
        out.write("\t\t\t \t<tr>\r\n");
        out.write("\t\t\t \t\t<td>VIP卡号：</td>\r\n");
        out.write("\t\t\t \t\t<td>");
        if (_jspx_meth_html_005ftext_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t \t\t<td>手机号码：</td>\r\n");
        out.write("\t\t\t \t\t<td>");
        if (_jspx_meth_html_005ftext_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t \t\t<td></td>\r\n");
        out.write("\t\t\t \t</tr>\r\n");
        out.write("\t\t\t </table>\r\n");
        out.write("\t\t\t<br />\r\n");
        out.write("\t\t\t \r\n");
        out.write("\t\t\t<input type=\"button\" value=\"批量审批\" onclick=\"approveBatch()\">\t\r\n");
        out.write("\t\t\t<input type=\"button\" value=\"批量驳回\" onclick=\"refuseBatch()\">\t\r\n");
        out.write("\t\t\t \r\n");
        out.write("\t\t\t\r\n");
        out.write("\t\t");
        int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(191,4) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("method");
    // /vipCustomerApprove/vipCustomerApprove.jsp(191,4) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("method");
    // /vipCustomerApprove/vipCustomerApprove.jsp(191,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("query");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
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
    // /vipCustomerApprove/vipCustomerApprove.jsp(192,4) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setStyleId("accountIDs");
    // /vipCustomerApprove/vipCustomerApprove.jsp(192,4) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("accountIDs");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(196,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyleId("department");
    // /vipCustomerApprove/vipCustomerApprove.jsp(196,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("department");
    // /vipCustomerApprove/vipCustomerApprove.jsp(196,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyle("width: 180");
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(198,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyleId("customerName");
    // /vipCustomerApprove/vipCustomerApprove.jsp(198,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("customerName");
    // /vipCustomerApprove/vipCustomerApprove.jsp(198,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyle("width: 180");
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f2 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(203,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyleId("vipNo");
    // /vipCustomerApprove/vipCustomerApprove.jsp(203,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setProperty("vipNo");
    // /vipCustomerApprove/vipCustomerApprove.jsp(203,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyle("width: 180");
    int _jspx_eval_html_005ftext_005f2 = _jspx_th_html_005ftext_005f2.doStartTag();
    if (_jspx_th_html_005ftext_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f3 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(205,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyleId("customerPhone");
    // /vipCustomerApprove/vipCustomerApprove.jsp(205,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setProperty("customerPhone");
    // /vipCustomerApprove/vipCustomerApprove.jsp(205,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyle("width: 180");
    int _jspx_eval_html_005ftext_005f3 = _jspx_th_html_005ftext_005f3.doStartTag();
    if (_jspx_th_html_005ftext_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
    return false;
  }

  private boolean _jspx_meth_ec_005ftable_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:table
    org.ecside.tag.TableTag _jspx_th_ec_005ftable_005f0 = (org.ecside.tag.TableTag) _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005fdoPreload_005fclassic_005faction.get(org.ecside.tag.TableTag.class);
    _jspx_th_ec_005ftable_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005ftable_005f0.setParent(null);
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = items type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setItems(new String("recordlist"));
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = var type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setVar("record");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = tableId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setTableId("ecTable");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = useAjax type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setUseAjax("false");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = doPreload type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setDoPreload("false");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = toolbarContent type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setToolbarContent("navigation|pagejump|pagesize|export|extend|status");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = showHeader type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setShowHeader("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = width type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setWidth("100%");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = retrieveRowsCallback type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRetrieveRowsCallback("process");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = action type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setAction("vipCustomerApprove.do");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = pageSizeList type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setPageSizeList("10,20,30,50");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = rowsDisplayed type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRowsDisplayed("20");
    // /vipCustomerApprove/vipCustomerApprove.jsp(265,3) name = classic type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setClassic("true");
    int[] _jspx_push_body_count_ec_005ftable_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005ftable_005f0 = _jspx_th_ec_005ftable_005f0.doStartTag();
      if (_jspx_eval_ec_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_ec_005frow_005f0(_jspx_th_ec_005ftable_005f0, _jspx_page_context, _jspx_push_body_count_ec_005ftable_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t");
          int evalDoAfterBody = _jspx_th_ec_005ftable_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_ec_005ftable_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005ftable_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005ftable_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005ftable_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005fdoPreload_005fclassic_005faction.reuse(_jspx_th_ec_005ftable_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005frow_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005ftable_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005ftable_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:row
    org.ecside.tag.RowTag _jspx_th_ec_005frow_005f0 = (org.ecside.tag.RowTag) _005fjspx_005ftagPool_005fec_005frow_005frecordKey.get(org.ecside.tag.RowTag.class);
    _jspx_th_ec_005frow_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005frow_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005ftable_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(271,3) name = recordKey type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setRecordKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.account_id}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    int[] _jspx_push_body_count_ec_005frow_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005frow_005f0 = _jspx_th_ec_005frow_005f0.doStartTag();
      if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_push_body_count_ec_005frow_005f0[0]++;
          _jspx_th_ec_005frow_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_ec_005frow_005f0.doInitBody();
        }
        do {
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f0(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f1(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f2(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f3(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f4(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f5(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f6(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f7(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f8(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t");
          int evalDoAfterBody = _jspx_th_ec_005frow_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
          _jspx_push_body_count_ec_005frow_005f0[0]--;
        }
      }
      if (_jspx_th_ec_005frow_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005frow_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005frow_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005frow_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005frow_005frecordKey.reuse(_jspx_th_ec_005frow_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f0 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(272,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setProperty("_0");
    // /vipCustomerApprove/vipCustomerApprove.jsp(272,4) name = alias type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setAlias("选择");
    // /vipCustomerApprove/vipCustomerApprove.jsp(272,4) name = headerCell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setHeaderCell("checkbox");
    // /vipCustomerApprove/vipCustomerApprove.jsp(272,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setCell("checkbox");
    // /vipCustomerApprove/vipCustomerApprove.jsp(272,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setStyle("text-align:center");
    int[] _jspx_push_body_count_ec_005fcolumn_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f0 = _jspx_th_ec_005fcolumn_005f0.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f1 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f1.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(273,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setProperty("_0");
    // /vipCustomerApprove/vipCustomerApprove.jsp(273,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setTitle("序号");
    // /vipCustomerApprove/vipCustomerApprove.jsp(273,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${GLOBALROWCOUNT}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    // /vipCustomerApprove/vipCustomerApprove.jsp(273,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f1 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f1 = _jspx_th_ec_005fcolumn_005f1.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f1.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f2 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f2.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(274,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setTitle("分公司");
    // /vipCustomerApprove/vipCustomerApprove.jsp(274,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setProperty("region");
    // /vipCustomerApprove/vipCustomerApprove.jsp(274,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(274,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f2 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f2 = _jspx_th_ec_005fcolumn_005f2.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f2[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f2.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f2.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f3 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f3.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(275,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setTitle("店铺");
    // /vipCustomerApprove/vipCustomerApprove.jsp(275,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setProperty("dept_name");
    // /vipCustomerApprove/vipCustomerApprove.jsp(275,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(275,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f3 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f3 = _jspx_th_ec_005fcolumn_005f3.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f3[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f3.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f3.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f4 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f4.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(276,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setTitle("姓名");
    // /vipCustomerApprove/vipCustomerApprove.jsp(276,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setProperty("account_name");
    // /vipCustomerApprove/vipCustomerApprove.jsp(276,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(276,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f4 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f4 = _jspx_th_ec_005fcolumn_005f4.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f4[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f4.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f4.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f4);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f5 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f5.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(277,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setTitle("客户经理");
    // /vipCustomerApprove/vipCustomerApprove.jsp(277,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setProperty("manager");
    // /vipCustomerApprove/vipCustomerApprove.jsp(277,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(277,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f5 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f5 = _jspx_th_ec_005fcolumn_005f5.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f5[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f5.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f5.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f5);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f6 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f6.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(278,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setTitle("卡号");
    // /vipCustomerApprove/vipCustomerApprove.jsp(278,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setProperty("vipcode");
    // /vipCustomerApprove/vipCustomerApprove.jsp(278,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(278,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f6 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f6 = _jspx_th_ec_005fcolumn_005f6.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f6[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f6.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f6.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f6);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f7 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f7.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(279,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setTitle("手机号码");
    // /vipCustomerApprove/vipCustomerApprove.jsp(279,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setProperty("account_mobile_phone");
    // /vipCustomerApprove/vipCustomerApprove.jsp(279,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(279,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f7 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f7 = _jspx_th_ec_005fcolumn_005f7.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f7[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f7.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f7.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f7);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f8 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f8.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setTitle("创建时间");
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setProperty("Create_time");
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setSortable("true");
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setCell("date");
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setFormat("yyyy-MM-dd");
    // /vipCustomerApprove/vipCustomerApprove.jsp(280,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setOndblclick("viewDetail()");
    int[] _jspx_push_body_count_ec_005fcolumn_005f8 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f8 = _jspx_th_ec_005fcolumn_005f8.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f8[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f8.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f8.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f8);
    }
    return false;
  }
}
