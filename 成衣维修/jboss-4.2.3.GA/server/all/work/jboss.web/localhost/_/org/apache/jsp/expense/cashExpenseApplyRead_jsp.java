package org.apache.jsp.expense;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import ep.org.util.NumberUtil;
import java.util.*;
import ep.org.branch.expense.dojo.CashExpensePurposeCost;
import ep.org.branch.expense.dojo.CashExpenseShopCost;
import ep.org.branch.expense.dojo.CashExpenseSubjectCost;
import ep.org.branch.expense.dojo.SelectOptionObj;
import ep.org.branch.expense.dojo.UserInfo;
import ep.org.branch.expense.constant.ExpenseConstant;

public final class cashExpenseApplyRead_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled.release();
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.release();
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
      out.write("    <title>现金付款申请</title>\r\n");
      out.write("    \r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("  <link rel=\"stylesheet\" type=\"text/css\" href=\"");
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
      out.write("\t\r\n");
      out.write("  \r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction initForm(){\r\n");
      out.write("  \t\t$('#applytitle', parent.document).html('现金付款申请');\r\n");
      out.write("  \t\tif($('#result').attr('value')=='1'){\r\n");
      out.write("  \t\t\talert('操作成功');\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tif($('#result').attr('value')=='2'){\r\n");
      out.write("  \t\t\talert('提交成功');\r\n");
      out.write("  \t\t\twindow.location.href=$('#webcontent').attr('value')+'/expenseMainFlow.do?action=init';\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\r\n");
      out.write("  \t}\r\n");
      out.write(" \t\r\n");
      out.write(" \tfunction refuse(){\r\n");
      out.write("  \t\tif($('#refuseReason').attr('value')==null||$('#refuseReason').attr('value')==''){\r\n");
      out.write("  \t\t\talert('驳回理由不能为空！');\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif(confirm('确定驳回？')){\r\n");
      out.write("  \t\t\t$('#action').attr('value','refuse');\r\n");
      out.write("  \t\t\tdocument.forms[0].submit();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \r\n");
      out.write("\tfunction do_submit(){\r\n");
      out.write("  \t\tif(confirm('确定审核通过？')){\r\n");
      out.write("  \t\t\t$('#action').attr('value','send');\r\n");
      out.write("  \t\t\tdocument.forms[0].submit();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  function print(){\r\n");
      out.write("  \tvar stateCode = $('#applyStateCode').attr('value');\r\n");
      out.write("  \tvar cashExpenseNo = $('#cashExpenseNo').attr('value');\r\n");
      out.write("  \tvar url = $('#webcontent').attr('value')+'/cashExpenseApply.do?action=getPrintData&cashExpenseNo='+cashExpenseNo;\t\r\n");
      out.write("  \twindow.open(url,'现金付款单打印','scrollbars=yes,width=100%,height=100%,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function showRefuseReason(){\r\n");
      out.write(" \t$('#refuseReasonDiv').css('display','block');\r\n");
      out.write("  }\r\n");
      out.write(" \r\n");
      out.write("  function hiddenRefuseReason(){\r\n");
      out.write(" \t$('#refuseReasonDiv').css('display','none');\r\n");
      out.write(" \t$('#refuseReason').attr('value','');\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function viewRefuseReCord(){\r\n");
      out.write(" \tvar expenseNo = $('#cashExpenseNo').attr('value');\r\n");
      out.write(" \tvar url = $('#webcontent').attr('value')+'/refuseRecordQuery.do?action=init&expenseNo='+expenseNo;\t\r\n");
      out.write("  \twindow.open(url,'驳回记录查询','scrollbars=yes,width=800,height=600,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write(" function showBudgt(){\r\n");
      out.write(" \tvar costCenter = $('#costCenter').attr('value');\r\n");
      out.write(" \tvar expenseNo = $('#cashExpenseNo').attr('value');\r\n");
      out.write(" \tvar url = $('#webcontent').attr('value')+'/budgetQuery.do?action=init&costCenter='+costCenter+\"&expenseNo=\"+expenseNo;\r\n");
      out.write(" \t\r\n");
      out.write(" \twindow.open(url,'科目预算查询',\"scrollbars=yes,width=800px,height=600px,resizable=yes,menubar=no,status=no,location=no\") \r\n");
      out.write(" }\r\n");
      out.write(" </script>\r\n");
      out.write("\t<body onload=\"initForm()\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"webcontent\" value=\"");
      out.print(request.getContextPath() );
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"hiddenPurposeTotalCost\"  value=\"");
      out.print(request.getAttribute("s_purposeTotalCost"));
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"hiddenShopTotalCost\" value=\"");
      out.print(request.getAttribute("s_shopTotalCost"));
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"hiddenSubjectTotalCost\" value=\"");
      out.print(request.getAttribute("s_subjectTotalCost"));
      out.write("\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div style=\"width: 95%\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      // /expense/cashExpenseApplyRead.jsp(109,2) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setAction("/cashExpenseApply");
      // /expense/cashExpenseApplyRead.jsp(109,2) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setStyleId("cashExpenseForm");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t");
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
          out.write("\t\t\r\n");
          out.write("\t\t<div id=\"refuseReasonDiv\"  style=\"position:absolute; display: none;background-color: #F3F4F3;height: 500;width:100%;overflow: auto;border-color: gray;border-style: solid;border: 2;z-index: 2; text-align: center;\">\r\n");
          out.write("\t\t\t<font color=\"red\">*</font>驳回理由：<br/>\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005ftextarea_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("<br />\r\n");
          out.write("\t\t\t<input type=\"button\" onclick=\"refuse()\" value=\"确定\" style=\"width:60\" >&nbsp;&nbsp;<input type=\"button\" onclick=\"hiddenRefuseReason()\" value=\"取消\" style=\"width:60\"> \r\n");
          out.write("\t\t</div>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<div>\r\n");
          out.write("\t\t\t");
UserInfo userinfo = (UserInfo)request.getSession().getAttribute("user_info") ;
			  if(!ExpenseConstant.APPLY_ROLE.equals(userinfo.getFlowRole())) {
			
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t");
String isView = (String)request.getAttribute("isView"); 
			if(!"1".equals(isView)){
			
          out.write("\r\n");
          out.write("\t\t\t<input type=\"button\" value=\"审核\" onclick=\"do_submit()\" class=\"btn_submit\" onmouseover=\"this.className='btn_submit_on'\" onmouseout=\"this.className='btn_submit'\">\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t<input type=\"button\" value=\"驳回\" onclick=\"showRefuseReason()\" class=\"btn_back\" onmouseover=\"this.className='btn_back_on'\" onmouseout=\"this.className='btn_back'\" >\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t");
} 
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t");
} 
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t<button onclick=\"print()\" class=\"btn_print\" onmouseover=\"this.className='btn_print_on'\" onmouseout=\"this.className='btn_print'\" >打印</button>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t&nbsp;&nbsp;\r\n");
          out.write("\t\t\t<button onclick=\"viewRefuseReCord()\" class=\"btn_refuse\" onmouseover=\"this.className='btn_refuse_on'\" onmouseout=\"this.className='btn_refuse'\" >驳回记录</button>\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t<br />\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<div\r\n");
          out.write("\t\t\tstyle=\"position: relative; display: inline-block; width: 100%; height: 72px;\">\r\n");
          out.write("\t\t\t<img alt=\"\" src=\"");
          out.print( path);
          out.write("/img/img1.JPG\"\r\n");
          out.write("\t\t\t\tstyle=\"position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20\">\r\n");
          out.write("\t\t\t<font size=\"2\">分公司费用申请单：</font>\r\n");
          out.write("\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
          out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
          out.write("\t\t\t\t<tr>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"14%\">\r\n");
          out.write("\t\t\t\t\t\t单据状态：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"19%\" >\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"14%\">\r\n");
          out.write("\t\t\t\t\t\t单号：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" colspan=\"3\">\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<tr >\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"14%\">\r\n");
          out.write("\t\t\t\t\t\t分公司代码：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"19%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005fselect_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\t\r\n");
          out.write("\t\t\t\t\t");
          out.write("\t\t\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"14%\">\r\n");
          out.write("\t\t\t\t\t\t申请人：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"19%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\t\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"14%\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>员工编号：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"19%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\t\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t\t</table>\r\n");
          out.write("\r\n");
          out.write("\t\t</div>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t<div\r\n");
          out.write("\t\t\tstyle=\"position: relative; display: inline-block; width: 100%; height: 100px;\">\r\n");
          out.write("\t\t\t<img alt=\"\" src=\"");
          out.print( path);
          out.write("/img/img1.JPG\"\r\n");
          out.write("\t\t\t\tstyle=\"position: absolute; z-index: -1; left: 0; top: 0; width: 100%; height: 20\">\r\n");
          out.write("\t\t\t<font size=\"2\">费用信息：</font>\r\n");
          out.write("\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
          out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
          out.write("\t\t\t\t<tr>\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>登记日期：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"16.5%\">\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>发票寄回日期：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>银行账号\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" colspan=\"1\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f6(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\t<tr>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>金额：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f7(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t￥\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t预算总额：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f8(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t已用费用：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\" width=\"16.5%\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f9(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<tr>\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\">\r\n");
          out.write("\t\t\t\t\t\t联系电话：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\">\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f10(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\">\r\n");
          out.write("\t\t\t\t\t\t移动电话：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f11(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t<td class=\"td_field\">\r\n");
          out.write("\t\t\t\t\t\t<font color=\"red\">*</font>上司：\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t<td class=\"td_text\">\r\n");
          out.write("\t\t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f12(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\t\t\t</table>\r\n");
          out.write("\r\n");
          out.write("\t\t</div>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t");
          int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.reuse(_jspx_th_html_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.reuse(_jspx_th_html_005fform_005f0);
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\t<br />\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div id=\"topDiv\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"添加\"\r\n");
      out.write("\t\t\t\talign=\"left\">\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"删除\"\r\n");
      out.write("\t\t\t\talign=\"right\">\r\n");
      out.write("\t\t\t<table id='100' width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
      out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"4%\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"66%\">\r\n");
      out.write("\t\t\t\t\t\t费用用途\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td id=\"purposeTotalCost\" class=\"td_field_title\" width=\"15%\">\r\n");
      out.write("\t\t\t\t\t\t金额(");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_purposeTotalCost")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"15%\">\r\n");
      out.write("\t\t\t\t\t\t使用日期\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t");
List purposeCostList = (List)request.getAttribute("purposeCostList");
				 int purposeCostListSize = 0;
				 if(purposeCostList!=null){
				 	 purposeCostListSize = purposeCostList.size();
				 }
				
				 for (int i = 0; i < purposeCostListSize; i++) {
				     	CashExpensePurposeCost purposeCost =(CashExpensePurposeCost) purposeCostList.get(i);
				
      out.write("\r\n");
      out.write("\t\t\t\t<tr id=\"");
      out.print(1101+i);
      out.write("-tr\" >\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\" align=\"center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"");
      out.print(1101+i);
      out.write("\" value=\"");
      out.print(1101+i);
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<textarea id=\"");
      out.print(1101+i );
      out.write("-expensePurpose\"  rows=\"1\" style=\"width: 100%\"  disabled=\"disabled\">");
      out.print(purposeCost.getExpensePurpose());
      out.write(" </textarea>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(1101+i);
      out.write("-expenseAmout\"  type=\"text\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)purposeCost.getExpenseAmout()));
      out.write("\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(1101+i);
      out.write("-expenseDate\" type=\"text\" value=\"");
      out.print(purposeCost.getExpenseDate() );
      out.write("\" onclick=\"setday(this)\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<br />\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"添加\"\r\n");
      out.write("\t\t\t\talign=\"left\" >\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"删除\"\r\n");
      out.write("\t\t\t\talign=\"right\" >\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<table id='200' width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
      out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"4%\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t店铺成本中心\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t店铺名\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td id=\"shopTotalCost\" class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t奖励金额(");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_shopTotalCost")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"24%\">\r\n");
      out.write("\t\t\t\t\t\t备注\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
List shopCostList = (List)request.getAttribute("shopCostList");
				 int shopCostListSize = 0;
				 if(shopCostList!=null){
				 	 shopCostListSize = shopCostList.size();
				 }
					
				 for (int i = 0; i < shopCostListSize; i++) {
				     	CashExpenseShopCost shopCost =(CashExpenseShopCost) shopCostList.get(i);
				
      out.write("\r\n");
      out.write("\t\t\t\t<tr id=\"");
      out.print(2101+i);
      out.write("-tr\">\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"");
      out.print(2101+i);
      out.write("\" value=\"2001\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-shopCostCenterCode\" type=\"text\" value=\"");
      out.print(shopCost.getShopCostCenterCode());
      out.write("\" class=\"text_write_common\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-shopName\" type=\"text\" value=\"");
      out.print(shopCost.getShopName());
      out.write("\" class=\"text_write_common\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-expenseAmout\" type=\"text\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)shopCost.getExpenseAmout()));
      out.write("\" class=\"text_write_common\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(2101+i);
      out.write("-comment\" type=\"text\"  value=\"");
      out.print(shopCost.getComment());
      out.write("\"\tclass=\"text_write_common\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<br />\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"添加\"\r\n");
      out.write("\t\t\t\talign=\"left\" >\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"删除\"\r\n");
      out.write("\t\t\t\talign=\"right\" >\r\n");
      out.write("\t\t\t<input type=\"button\" style=\"background-color: #E2E9F1\" value=\"预算\"\r\n");
      out.write("\t\t\t\talign=\"right\" onclick=\"showBudgt()\">\r\n");
      out.write("\t\t\t<table id='300' width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
      out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"4%\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t大类\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t所属科目\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t科目代码\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td id=\"subjectTotalCost\" class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t金额(");
      out.print(NumberUtil.formatFloatDecimal(2,(String)request.getAttribute("s_subjectTotalCost")));
      out.write(")\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td class=\"td_field_title\" width=\"19.2%\">\r\n");
      out.write("\t\t\t\t\t\t备注\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
List subjectCostList = (List)request.getAttribute("subjectCostList");
					
				  int subjectCostListSize = 0;
				 if(subjectCostList!=null){
				 	 subjectCostListSize = subjectCostList.size();
				 }
					
				 
				 for (int i = 0; i < subjectCostListSize; i++) {
				     	CashExpenseSubjectCost subjectCost =(CashExpenseSubjectCost) subjectCostList.get(i);
				
      out.write("\r\n");
      out.write("\t\t\t\t<tr id=\"");
      out.print(3101+i);
      out.write("-tr\">\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" id=\"");
      out.print(3101+i);
      out.write("\" id=\"");
      out.print(3101+i);
      out.write("\" >\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<select id=\"");
      out.print(3101+i);
      out.write("-categoryCode\" disabled=\"disabled\" >\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t");
List categoryList = (List)request.getAttribute("categoryList");  
							 for(int j=0;j<categoryList.size();j++){
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
      out.print(subjectCost.getAccountName() );
      out.write("\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td id=\"");
      out.print(3101+i);
      out.write("-subjectCodeTD\" class=\"td_text_center_nodisplay\">\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<select  id=\"");
      out.print(3101+i);
      out.write("-subjectCode\" name=\"subjectCode\"   style=\"width: 100%\" disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\" >\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-accountCode\" type=\"text\"  class=\"text_write_common\" disabled=\"disabled\" value=\"");
      out.print(subjectCost.getAccountCode() );
      out.write(" \">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-subjectAmout\" type=\"text\" class=\"text_write_common\" disabled=\"disabled\" value=\"");
      out.print(NumberUtil.formatFloatDecimal(2,(String)subjectCost.getSubjectAmout()));
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<td class=\"td_text_center\">\r\n");
      out.write("\t\t\t\t\t\t<input id=\"");
      out.print(3101+i);
      out.write("-comment\" type=\"text\" class=\"text_write_common\" disabled=\"disabled\" value=\"");
      out.print(subjectCost.getComment());
      out.write("\">\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t</div>\r\n");
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

  private boolean _jspx_meth_html_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(110,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("applyStateCode");
    // /expense/cashExpenseApplyRead.jsp(110,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
    // /expense/cashExpenseApplyRead.jsp(111,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setStyleId("action");
    // /expense/cashExpenseApplyRead.jsp(111,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
    // /expense/cashExpenseApplyRead.jsp(112,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setStyleId("cashExpenseInfoID");
    // /expense/cashExpenseApplyRead.jsp(112,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setProperty("cashExpenseInfoID");
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
    // /expense/cashExpenseApplyRead.jsp(113,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setStyleId("cashExpenseNo");
    // /expense/cashExpenseApplyRead.jsp(113,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setProperty("cashExpenseNo");
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
    // /expense/cashExpenseApplyRead.jsp(114,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setStyleId("costCenter");
    // /expense/cashExpenseApplyRead.jsp(114,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setProperty("branchCode");
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
    // /expense/cashExpenseApplyRead.jsp(118,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setStyleId("refuseReason");
    // /expense/cashExpenseApplyRead.jsp(118,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setProperty("refuseReason");
    // /expense/cashExpenseApplyRead.jsp(118,3) name = cols type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setCols("80");
    // /expense/cashExpenseApplyRead.jsp(118,3) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(162,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("applyStateName");
    // /expense/cashExpenseApplyRead.jsp(162,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyleClass("text_read_red");
    // /expense/cashExpenseApplyRead.jsp(162,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setDisabled(true);
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(170,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("cashExpenseNo");
    // /expense/cashExpenseApplyRead.jsp(170,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyleClass("text_read_red");
    // /expense/cashExpenseApplyRead.jsp(170,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setDisabled(true);
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:select
    org.apache.struts.taglib.html.SelectTag _jspx_th_html_005fselect_005f0 = (org.apache.struts.taglib.html.SelectTag) _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled.get(org.apache.struts.taglib.html.SelectTag.class);
    _jspx_th_html_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(180,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setProperty("branchCode");
    // /expense/cashExpenseApplyRead.jsp(180,6) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setStyle("width: 100%");
    // /expense/cashExpenseApplyRead.jsp(180,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setDisabled(true);
    int _jspx_eval_html_005fselect_005f0 = _jspx_th_html_005fselect_005f0.doStartTag();
    if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fselect_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fselect_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_html_005foptionsCollection_005f0(_jspx_th_html_005fselect_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_html_005fselect_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled.reuse(_jspx_th_html_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fdisabled.reuse(_jspx_th_html_005fselect_005f0);
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
    // /expense/cashExpenseApplyRead.jsp(181,6) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setName("branchList");
    // /expense/cashExpenseApplyRead.jsp(181,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setValue("value");
    // /expense/cashExpenseApplyRead.jsp(181,6) name = label type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setLabel("lable");
    int _jspx_eval_html_005foptionsCollection_005f0 = _jspx_th_html_005foptionsCollection_005f0.doStartTag();
    if (_jspx_th_html_005foptionsCollection_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f2 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(191,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setProperty("applyUserName");
    // /expense/cashExpenseApplyRead.jsp(191,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyleClass("text_read_common");
    // /expense/cashExpenseApplyRead.jsp(191,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setDisabled(true);
    int _jspx_eval_html_005ftext_005f2 = _jspx_th_html_005ftext_005f2.doStartTag();
    if (_jspx_th_html_005ftext_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f3 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(198,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyleId("applyUserID");
    // /expense/cashExpenseApplyRead.jsp(198,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setProperty("applyUserID");
    // /expense/cashExpenseApplyRead.jsp(198,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyleClass("text_write_common");
    // /expense/cashExpenseApplyRead.jsp(198,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setDisabled(true);
    int _jspx_eval_html_005ftext_005f3 = _jspx_th_html_005ftext_005f3.doStartTag();
    if (_jspx_th_html_005ftext_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f4 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(222,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setProperty("applyDate");
    // /expense/cashExpenseApplyRead.jsp(222,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setOnclick("setday(this)");
    // /expense/cashExpenseApplyRead.jsp(222,6) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setReadonly(false);
    // /expense/cashExpenseApplyRead.jsp(222,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setDisabled(true);
    int _jspx_eval_html_005ftext_005f4 = _jspx_th_html_005ftext_005f4.doStartTag();
    if (_jspx_th_html_005ftext_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f5 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(229,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setProperty("sendInvoiceDate");
    // /expense/cashExpenseApplyRead.jsp(229,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setOnclick("setday(this)");
    // /expense/cashExpenseApplyRead.jsp(229,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setDisabled(true);
    // /expense/cashExpenseApplyRead.jsp(229,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f5.setDisabled(true);
    int _jspx_eval_html_005ftext_005f5 = _jspx_th_html_005ftext_005f5.doStartTag();
    if (_jspx_th_html_005ftext_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fproperty_005fonclick_005fdisabled_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f5);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f6 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f6.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(236,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setProperty("bankAccount");
    // /expense/cashExpenseApplyRead.jsp(236,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setStyleClass("text_write_common");
    // /expense/cashExpenseApplyRead.jsp(236,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f6.setDisabled(true);
    int _jspx_eval_html_005ftext_005f6 = _jspx_th_html_005ftext_005f6.doStartTag();
    if (_jspx_th_html_005ftext_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f6);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f7 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f7.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(246,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setProperty("applyAmount");
    // /expense/cashExpenseApplyRead.jsp(246,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setStyleClass("text_read_common");
    // /expense/cashExpenseApplyRead.jsp(246,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f7.setDisabled(true);
    int _jspx_eval_html_005ftext_005f7 = _jspx_th_html_005ftext_005f7.doStartTag();
    if (_jspx_th_html_005ftext_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f7);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f8 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f8.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(254,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f8.setProperty("budget");
    // /expense/cashExpenseApplyRead.jsp(254,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f8.setStyleClass("text_read_common");
    // /expense/cashExpenseApplyRead.jsp(254,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f8.setDisabled(true);
    int _jspx_eval_html_005ftext_005f8 = _jspx_th_html_005ftext_005f8.doStartTag();
    if (_jspx_th_html_005ftext_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f8);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f9 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f9.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(261,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setProperty("usedAmount");
    // /expense/cashExpenseApplyRead.jsp(261,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setStyleClass("text_read_common");
    // /expense/cashExpenseApplyRead.jsp(261,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f9.setDisabled(true);
    int _jspx_eval_html_005ftext_005f9 = _jspx_th_html_005ftext_005f9.doStartTag();
    if (_jspx_th_html_005ftext_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f9);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f10 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f10.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(276,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setProperty("telephone");
    // /expense/cashExpenseApplyRead.jsp(276,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setStyleClass("text_write_common");
    // /expense/cashExpenseApplyRead.jsp(276,6) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setStyle("width:95%");
    // /expense/cashExpenseApplyRead.jsp(276,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f10.setDisabled(true);
    int _jspx_eval_html_005ftext_005f10 = _jspx_th_html_005ftext_005f10.doStartTag();
    if (_jspx_th_html_005ftext_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f10);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f11 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f11.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(284,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setProperty("mobilephone");
    // /expense/cashExpenseApplyRead.jsp(284,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setStyleClass("text_write_common");
    // /expense/cashExpenseApplyRead.jsp(284,6) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setStyle("width:95%");
    // /expense/cashExpenseApplyRead.jsp(284,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f11.setDisabled(true);
    int _jspx_eval_html_005ftext_005f11 = _jspx_th_html_005ftext_005f11.doStartTag();
    if (_jspx_th_html_005ftext_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f11);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f12(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f12 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f12.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/cashExpenseApplyRead.jsp(291,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setProperty("leadername");
    // /expense/cashExpenseApplyRead.jsp(291,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setStyleClass("text_write_common");
    // /expense/cashExpenseApplyRead.jsp(291,6) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setStyle("width:95%");
    // /expense/cashExpenseApplyRead.jsp(291,6) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f12.setDisabled(true);
    int _jspx_eval_html_005ftext_005f12 = _jspx_th_html_005ftext_005f12.doStartTag();
    if (_jspx_th_html_005ftext_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f12);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleClass_005fstyle_005fproperty_005fdisabled_005fnobody.reuse(_jspx_th_html_005ftext_005f12);
    return false;
  }
}
