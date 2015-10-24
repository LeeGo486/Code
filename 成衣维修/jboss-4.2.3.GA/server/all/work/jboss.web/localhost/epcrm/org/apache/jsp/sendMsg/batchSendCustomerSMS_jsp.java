package org.apache.jsp.sendMsg;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class batchSendCustomerSMS_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody;

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
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty.release();
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.release();
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

	String path = request.getContextPath();

      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>客户短信批量发送</title>\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">\r\n");
      out.write("\t-->\r\n");
      out.write("\t<style type=\"text/css\">\r\n");
      out.write("\t\t/*td {font-size: 12}*/\r\n");
      out.write("\t\tinput {font-size: 12}\r\n");
      out.write("\t\tselect {font-size: 12}\r\n");
      out.write("\t\t.td_field{background-color:white;\r\n");
      out.write("\t\t  font-size: 12;\r\n");
      out.write("\t\t  font-weight: 700;\r\n");
      out.write("\t\t }\r\n");
      out.write("\t\t .td_text{background-color:white;\r\n");
      out.write("\t\t\t  text-align: left;\r\n");
      out.write("\t\t\t   font-size: 12;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</style>\r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script language=\"javascript\" src=\"");
      out.print(path);
      out.write("/myjs/myTime2.js\"></script>\r\n");
      out.write("\t<script language=\"javascript\" src=\"");
      out.print(path);
      out.write("/myjs/insertText.js\"></script>\r\n");
      out.write("  \t\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write(" // var insertPos = 0;\r\n");
      out.write("  function preViewContent(){\r\n");
      out.write("  \t\tvar batchNo = $('#batchNO').attr('value');\r\n");
      out.write("  \t\tvar type = $('#msgType').attr('value');\r\n");
      out.write("  \t\tvar preContent = $('#content').attr('value');\r\n");
      out.write("  \t\tvar para = new Object();\r\n");
      out.write("  \t\tpara[\"smsContent\"] = preContent;\r\n");
      out.write("  \t\tpara[\"type\"] = type;\r\n");
      out.write("  \t\tpara[\"batchNo\"] = batchNo;\r\n");
      out.write("\t\t$.post(\r\n");
      out.write("\t\t\t\t$('#path').attr('value') + '/customerSMSBatchSend.do?method=preViewSMSContent',para,\r\n");
      out.write("\t\t\t\tfunction(rsp) {\r\n");
      out.write("\t\t\t\t\t$('#viewContent').attr(\"value\",rsp);\r\n");
      out.write("\t\t\t\t\t$('#preViewSMSContent').show();\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}, \"text\").error(function() {\r\n");
      out.write("\t\t\talert(\"获取详细信息失败！\");\r\n");
      out.write("\t\t});\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function sendMsg(){\r\n");
      out.write("  \t$('#sendButton').attr('disabled','disabled');\r\n");
      out.write("  \t$('#waitDiv').show();\r\n");
      out.write("  \tdocument.forms[0].submit();\r\n");
      out.write("  \t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function insertContentCode(){\r\n");
      out.write("  \t\tvar insertText ='@'+ $('#insertCode').val()+'@';\r\n");
      out.write("  \t\t$('#content').insert({'text':insertText});\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  //function checkInsertPos(){\r\n");
      out.write("  \r\n");
      out.write("  //}\r\n");
      out.write("  \r\n");
      out.write("  function hiddenDetail(){\r\n");
      out.write("\t\t$('#preViewSMSContent').hide();\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \t\tvar result = $('#result').attr('value');\r\n");
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
      out.write("  }\r\n");
      out.write("  </script>\r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("      <input type=\"hidden\" id=\"path\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write("      <input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result"));
      out.write("\">\r\n");
      out.write("      <div >\r\n");
      out.write("      ");
      if (_jspx_meth_html_005fform_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("      \r\n");
      out.write("      \r\n");
      out.write("      <div id=\"preViewSMSContent\" style=\"position:absolute; display: none;background-color: #F3F4F3;height: 300;width:500;overflow: auto;border-color: gray;border-style: solid;border: 2;top:30;left:350;z-index: 2; text-align: center;\">\r\n");
      out.write("      \t<table width=\"480\">\r\n");
      out.write("      \t\t<tr>\r\n");
      out.write("      \t\t\t<td align=\"left\"><font size=\"4\"><b>短信内容预览</b></font> </td>\r\n");
      out.write("      \t\t\t<td align=\"right\">\r\n");
      out.write("      \t\t\t\t<input type=\"button\" value=\"关闭\" onclick=\"hiddenDetail()\">\r\n");
      out.write("      \t\t\t\r\n");
      out.write("      \t\t</tr>\r\n");
      out.write("      \t\t\r\n");
      out.write("      \t\t<tr align=\"left\">\r\n");
      out.write("      \t\t\t<td colspan=\"2\">\r\n");
      out.write("      \t\t\t\t<textarea id=\"viewContent\" rows=\"13\" cols=\"55\" readonly=\"readonly\"></textarea>\r\n");
      out.write("      \t\t\t</td>\r\n");
      out.write("      \t\t</tr>\r\n");
      out.write("      \t\r\n");
      out.write("      \t</table>\r\n");
      out.write("      </div>\r\n");
      out.write("      \r\n");
      out.write("      </div>\r\n");
      out.write("      \r\n");
      out.write("      <div id=\"waitDiv\" style=\"position:absolute; display: none;overflow: auto;border-color: gray;border-style: solid;border: 2;top:200;left:500;z-index: 3; text-align: center;vertical-align: middle;\" >\r\n");
      out.write("      \t <font size=\"2\">正在发送，请稍等<br></font> \r\n");
      out.write("      \t<img  src=\"../img/13221810.gif\">\r\n");
      out.write("      </div>\r\n");
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

  private boolean _jspx_meth_html_005fform_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:form
    org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fform_005f0.setParent(null);
    // /sendMsg/batchSendCustomerSMS.jsp(95,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setStyleId("customSMSBatchForm");
    // /sendMsg/batchSendCustomerSMS.jsp(95,6) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setAction("/customerSMSBatchSend.do");
    // /sendMsg/batchSendCustomerSMS.jsp(95,6) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setMethod("post");
    int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
    if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("          ");
        if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          ");
        if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          ");
        if (_jspx_meth_html_005fhidden_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          \r\n");
        out.write("          <center>\r\n");
        out.write("          <table width=\"680\"  border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
        out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t<td colspan=\"2\" align=\"center\">\r\n");
        out.write("          \t\t<font size=\"4\"><b>\t客户短信批量发送</b></font>\r\n");
        out.write("          \t\t</td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          \t\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t<td width=\"80\" class=\"td_field\">短信主题：</td>\r\n");
        out.write("          \t\t<td width=\"600\" class=\"td_text\">");
        if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t<td class=\"td_field\">插入变量：</td>\r\n");
        out.write("          \t\t<td class=\"td_text\"> ");
        if (_jspx_meth_html_005fselect_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          \t\t\t<input type=\"button\" value=\"插入\" onclick=\"insertContentCode()\">\r\n");
        out.write("          \t\t</td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t<td class=\"td_field\">短信内容：</td>\r\n");
        out.write("          \t\t<td class=\"td_text\">");
        if (_jspx_meth_html_005ftextarea_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t<td class=\"td_field\">发送时间：</td>\r\n");
        out.write("          \t\t<td class=\"td_text\">");
        if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          \t<tr>\r\n");
        out.write("          \t\t\r\n");
        out.write("          \t\t<td align=\"center\" colspan=\"2\">\r\n");
        out.write("          \t\t\t<input type=\"button\" value=\"随机预览\" onclick=\"preViewContent()\" >\r\n");
        out.write("          \t\t\t<input id=\"sendButton\" type=\"button\" value=\"确定发送\" onclick=\"sendMsg()\">\r\n");
        out.write("          \t\t</td>\r\n");
        out.write("          \t</tr>\r\n");
        out.write("          </table>\r\n");
        out.write("      \t\t</center>\r\n");
        out.write("      ");
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
    // /sendMsg/batchSendCustomerSMS.jsp(96,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("method");
    // /sendMsg/batchSendCustomerSMS.jsp(96,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("method");
    // /sendMsg/batchSendCustomerSMS.jsp(96,10) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("batchSend");
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
    // /sendMsg/batchSendCustomerSMS.jsp(97,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setStyleId("batchNO");
    // /sendMsg/batchSendCustomerSMS.jsp(97,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("batchNO");
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
    // /sendMsg/batchSendCustomerSMS.jsp(98,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setStyleId("msgType");
    // /sendMsg/batchSendCustomerSMS.jsp(98,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setProperty("msgType");
    int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
    if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
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
    // /sendMsg/batchSendCustomerSMS.jsp(111,44) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyleId("subject");
    // /sendMsg/batchSendCustomerSMS.jsp(111,44) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("subject");
    // /sendMsg/batchSendCustomerSMS.jsp(111,44) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyle("width: 200");
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyleId_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:select
    org.apache.struts.taglib.html.SelectTag _jspx_th_html_005fselect_005f0 = (org.apache.struts.taglib.html.SelectTag) _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty.get(org.apache.struts.taglib.html.SelectTag.class);
    _jspx_th_html_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /sendMsg/batchSendCustomerSMS.jsp(115,33) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setStyleId("insertCode");
    // /sendMsg/batchSendCustomerSMS.jsp(115,33) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setProperty("insertCode");
    int _jspx_eval_html_005fselect_005f0 = _jspx_th_html_005fselect_005f0.doStartTag();
    if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fselect_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fselect_005f0.doInitBody();
      }
      do {
        out.write(' ');
        if (_jspx_meth_html_005foptionsCollection_005f0(_jspx_th_html_005fselect_005f0, _jspx_page_context))
          return true;
        out.write(' ');
        int evalDoAfterBody = _jspx_th_html_005fselect_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty.reuse(_jspx_th_html_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyleId_005fproperty.reuse(_jspx_th_html_005fselect_005f0);
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
    // /sendMsg/batchSendCustomerSMS.jsp(115,90) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setName("selectList");
    // /sendMsg/batchSendCustomerSMS.jsp(115,90) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setValue("code");
    // /sendMsg/batchSendCustomerSMS.jsp(115,90) name = label type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setLabel("lable");
    int _jspx_eval_html_005foptionsCollection_005f0 = _jspx_th_html_005foptionsCollection_005f0.doStartTag();
    if (_jspx_th_html_005foptionsCollection_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
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
    // /sendMsg/batchSendCustomerSMS.jsp(121,32) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setStyleId("content");
    // /sendMsg/batchSendCustomerSMS.jsp(121,32) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setProperty("content");
    // /sendMsg/batchSendCustomerSMS.jsp(121,32) name = cols type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setCols("55");
    // /sendMsg/batchSendCustomerSMS.jsp(121,32) name = rows type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftextarea_005f0.setRows("13");
    int _jspx_eval_html_005ftextarea_005f0 = _jspx_th_html_005ftextarea_005f0.doStartTag();
    if (_jspx_th_html_005ftextarea_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.reuse(_jspx_th_html_005ftextarea_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftextarea_005fstyleId_005frows_005fproperty_005fcols_005fnobody.reuse(_jspx_th_html_005ftextarea_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /sendMsg/batchSendCustomerSMS.jsp(125,32) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("sendDate");
    // /sendMsg/batchSendCustomerSMS.jsp(125,32) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setOnclick("setday(this)");
    // /sendMsg/batchSendCustomerSMS.jsp(125,32) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyle("width: 200");
    // /sendMsg/batchSendCustomerSMS.jsp(125,32) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setReadonly(true);
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }
}
