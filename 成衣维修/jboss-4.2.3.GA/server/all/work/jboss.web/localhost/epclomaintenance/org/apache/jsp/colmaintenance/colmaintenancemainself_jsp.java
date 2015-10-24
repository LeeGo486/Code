package org.apache.jsp.colmaintenance;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class colmaintenancemainself_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhtml;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fhtml = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fhtml.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.release();
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
 String userID = (String) request.getAttribute("userID");
   String loginDeptID =(String) request.getAttribute("loginDeptID");
   System.out.println(userID);
   System.out.println(loginDeptID);
   String webContext = request.getContextPath();

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      //  html:html
      org.apache.struts.taglib.html.HtmlTag _jspx_th_html_005fhtml_005f0 = (org.apache.struts.taglib.html.HtmlTag) _005fjspx_005ftagPool_005fhtml_005fhtml.get(org.apache.struts.taglib.html.HtmlTag.class);
      _jspx_th_html_005fhtml_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fhtml_005f0.setParent(null);
      int _jspx_eval_html_005fhtml_005f0 = _jspx_th_html_005fhtml_005f0.doStartTag();
      if (_jspx_eval_html_005fhtml_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("<head>\r\n");
          out.write("\t\t<title>非总部维修管理 </title>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\" ");
          out.print(request.getContextPath());
          out.write("/tabbed_pages/tabbed_pages_self.css\" />\r\n");
          out.write("\t\t\r\n");
          out.write("\t<style type=\"text/css\">\r\n");
          out.write("    .alpha{filter:alpha(opacity=30);}\r\n");
          out.write("\t</style>\r\n");
          out.write("\t\r\n");
          out.write("</head>\r\n");
          out.write("\r\n");
          out.write("<script type=\"text/javascript\">\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction creatBill(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//var url=webContext+\"/eidtMaintenanceBill.do?method=init&userID=\"+document.getElementById('userID').value+\"&loginDeptID=\"+document.getElementById('loginDeptID').value;\r\n");
          out.write("\t\t\tdocument.frames['maintenanceParticularInfo'].location.href=webContext+\"/eidtMaintenanceBillSelf.do?method=init&userID=\"+document.getElementById('userID').value+\"&loginDeptID=\"+document.getElementById('loginDeptID').value;\r\n");
          out.write("\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t//window.open(url, \"登记维修单\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\tchangeDIV();\r\n");
          out.write("\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction gkPrint(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//alert(document.getElementById('guid').value);\r\n");
          out.write("\t\t\tvar url=webContext+\"/customerPrintSelf.do?method=getShopPrintData&guid=\"+document.getElementById('guid').value;\r\n");
          out.write("\t\t\twindow.open(url, \"顾客单打印\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\tfunction changeDIV(){\r\n");
          out.write("\t\t\tvar getEls = document.getElementsByTagName('DIV');\r\n");
          out.write("\t\t\tfor (var z=0; z<getEls.length; z++) {\r\n");
          out.write("\t\t\t\tgetEls[z].className=getEls[z].className.replace('show', 'hide');\r\n");
          out.write("\t\t\t\tgetEls[z].className=getEls[z].className.replace('on', 'off');\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tdocument.getElementById('particular').className = 'on';\r\n");
          out.write("\t\t\tvar max = document.getElementById('particular').getAttribute('title');\r\n");
          out.write("\t\t\tdocument.getElementById(max).className = \"show\";\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\tfunction deleteBill(){\r\n");
          out.write("\t\tvar dh = document.getElementById(\"dh\").value;\r\n");
          out.write("\t\tif(confirm('确认删除单号为'+dh+'的维修单？')){\r\n");
          out.write("\t\t\tdocument.getElementById('method').value=\"deleteBill\";\r\n");
          out.write("\t\t\tdocument.forms[0].submit();\r\n");
          out.write("\t\t}\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction finish(){\r\n");
          out.write("\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//var url=webContext+\"/eidtMaintenanceBill.do?method=init&userID=\"+document.getElementById('userID').value+\"&loginDeptID=\"+document.getElementById('loginDeptID').value;\r\n");
          out.write("\t\t\tvar guid = document.getElementById('guid').value;\r\n");
          out.write("\t\t\tdocument.frames['maintenanceParticularInfo'].location.href=webContext+\"/eidtMaintenanceBillSelf.do?method=viewCompleteBill&userID=\"+document.getElementById('userID').value+\"&guid=\"+document.getElementById('guid').value;\r\n");
          out.write("\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t//window.open(url, \"登记维修单\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\tchangeDIV();\r\n");
          out.write("\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\r\n");
          out.write("onload = function() {\r\n");
          out.write("\tvar e, i = 0;\r\n");
          out.write("\t\twhile (e = document.getElementById('gallery').getElementsByTagName('DIV')[i++]) {\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tif (e.className == 'on' || e.className == 'off') {\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\te.onclick = function() {\r\n");
          out.write("\t\t\t\tvar getEls = document.getElementsByTagName('DIV');\r\n");
          out.write("\t\t\t\tfor ( var z = 0; z < getEls.length; z++) {\r\n");
          out.write("\t\t\t\t\tgetEls[z].className = getEls[z].className.replace('show',\r\n");
          out.write("\t\t\t\t\t\t\t'hide');\r\n");
          out.write("\t\t\t\t\tgetEls[z].className = getEls[z].className.replace('on',\r\n");
          out.write("\t\t\t\t\t\t\t'off');\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\tthis.className = 'on';\r\n");
          out.write("\t\t\t\tvar max = this.getAttribute('title');\r\n");
          out.write("\t\t\t\tdocument.getElementById(max).className = \"show\";\r\n");
          out.write("\t\t\t\tvar subIframe = document.getElementById('maintenanceParticularInfo');\r\n");
          out.write("\t\t\t\tif (max == 'particularInfo') {\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\tif (subIframe != null) {\r\n");
          out.write("\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\tif (subIframe.contentWindow.document\r\n");
          out.write("\t\t\t\t\t\t\t\t.getElementById('isSaveFlag') != null) {\r\n");
          out.write("\t\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t\t//document.getElementById(\"guid\").value=subIframe.contentWindow.document.getElementById('guid');\r\n");
          out.write("\t\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t\tdocument.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;\r\n");
          out.write("\t\t\t\t\t\t\tdocument.getElementById('dh').value = subIframe.contentWindow.document.getElementById('dh').value;\r\n");
          out.write("\t\t\t\t\t\t\t//document.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\tif(subIframe.contentWindow.document.getElementById('dh').value==''){\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('gkPrint').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('finish').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\t}else{\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('deleteBill').disabled=false;\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('gkPrint').disabled=false;\r\n");
          out.write("\t\t\t\t\t\t\t}\r\n");
          out.write("\t\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t} else {\r\n");
          out.write("\t\t\t\t\t\t\t//alert(subIframe.contentWindow.document.getElementById('guid').value);\r\n");
          out.write("\t\t\t\t\t\t\tdocument.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;\r\n");
          out.write("\t\t\t\t\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\tvar zt = subIframe.contentWindow.document.getElementById('ZT').value;\r\n");
          out.write("\t\t\t\t\t\t\tif(zt=='21'){\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('gkPrint').disabled=false;\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('finish').disabled=false;\r\n");
          out.write("\t\t\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\t\t}\r\n");
          out.write("\t\t\t\t\t\t\tif(zt=='22'){\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('gkPrint').disabled=false;\r\n");
          out.write("\t\t\t\t\t\t\t\tdocument.getElementById('finish').disabled=true;\r\n");
          out.write("\t\t\t\t\t\t\t\t//document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;\r\n");
          out.write("\t\t\t\t\t\t\t}\r\n");
          out.write("\t\t\t\t\t\t}\r\n");
          out.write("\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t}\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\telse if(max=='infolist'){\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('gkPrint').disabled=true;\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('finish').disabled=true;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\telse{\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('gkPrint').disabled=true;\r\n");
          out.write("\t\t\t\t\tdocument.getElementById('finish').disabled=true;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\r\n");
          out.write("\t\t}\r\n");
          out.write("\t}\r\n");
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("}\r\n");
          out.write("\r\n");
          out.write("</script>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("<body > \r\n");
          out.write("\t\r\n");
          out.write("\t<img alt=\"\" src=\"");
          out.print(webContext);
          out.write("/mypicture/bg3.jpg\" width=\"100%\" height=\"130%\" style=\"position:absolute;top0;left0;z-index: 0;filter:alpha(opacity=100);\">\r\n");
          out.write("\t<div style=\"position:absolute;top0;left0;width: 100%;height: 100%;z-index: 0;filter:alpha(opacity=70);\">\r\n");
          out.write("\t\r\n");
          out.write("\t");
          //  html:form
          org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
          _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
          _jspx_th_html_005fform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
          // /colmaintenance/colmaintenancemainself.jsp(181,1) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setAction("/cloMaintenanceSelf");
          // /colmaintenance/colmaintenancemainself.jsp(181,1) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setStyleId("cloMaintenanceSelForm");
          // /colmaintenance/colmaintenancemainself.jsp(181,1) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setMethod("post");
          int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
          if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              //  html:hidden
              org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
              _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
              _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
              // /colmaintenance/colmaintenancemainself.jsp(184,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setProperty("webContext");
              // /colmaintenance/colmaintenancemainself.jsp(184,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setValue(request.getContextPath());
              int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
              if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\r\n");
              out.write("\t");
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
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t<input type=\"button\"  id=\"creatBill\"  name=\"creatBill\" value=\"登记维修单\" onclick=\"creatBill()\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"deleteBill\"  name=\"deleteBill\" disabled=\"disabled\" value=\"删除维修单\" onclick=\"deleteBill()\"/> \r\n");
          out.write("\t<input type=\"button\"  id=\"gkPrint\" disabled=\"disabled\" name=\"gkPrint\" value=\"顾客单打印\" onclick=\"gkPrint();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"finish\" disabled=\"disabled\" name=\"finish\" value=\"维修完成\" onclick=\"finish();\"/>\r\n");
          out.write("\t <br>\r\n");
          out.write("\t <div align=\"center\" >\r\n");
          out.write("\t \t<font style=\"font-size:28;font-weight: 700;color: white;font-family:Microsoft YaHei,微软雅黑,Microsoft JhengHei,华文细黑,STHeiti,MingLiu\">非总部维修管理</font>\r\n");
          out.write("\t </div>\t\r\n");
          out.write("\t <br>\r\n");
          out.write("\t<font style=\"font-size:15;font-weight: 500;color: white;font-family:Microsoft YaHei,微软雅黑,Microsoft JhengHei,华文细黑,STHeiti,MingLiu\">注：非总部维修管理模块，适用于记录店铺自主维修的情况（即无需寄回给总部维修）</font>\r\n");
          out.write("\t<div id=\"gallery\">\r\n");
          out.write("\t\t<div class=\"on\" title=\"infolist\"><span>列表</span></div>\r\n");
          out.write("\t\t<div id=\"particular\" class=\"off\" title=\"particularInfo\"><span>详细</span></div>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t<div id=\"infolist\" class=\"show\">\r\n");
          out.write("\t\t<iframe name=\"maintenanceInfoList\"  width=\"98%\"  height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/maintenanceInfoListSelf.do?method=queryList&userID=");
          out.print(userID);
          out.write("&loginDeptID=");
          out.print(loginDeptID);
          out.write("\" ></iframe>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t<div id=\"particularInfo\" class=\"hide\">\r\n");
          out.write("\t\t<iframe id=\"maintenanceParticularInfo\" name=\"maintenanceParticularInfo\" width=\"90%\" height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/viewMaintenanceBillSelf.do?method=init\"></iframe>\r\n");
          out.write("\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t \r\n");
          out.write("\r\n");
          out.write("\t</div>\r\n");
          out.write("\t</body>\r\n");
          int evalDoAfterBody = _jspx_th_html_005fhtml_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fhtml_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fhtml.reuse(_jspx_th_html_005fhtml_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fhtml.reuse(_jspx_th_html_005fhtml_005f0);
      out.write("\r\n");
      out.write("\r\n");
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
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemainself.jsp(182,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("userID");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemainself.jsp(183,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("loginDeptID");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f3 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemainself.jsp(185,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setProperty("guid");
    int _jspx_eval_html_005fhidden_005f3 = _jspx_th_html_005fhidden_005f3.doStartTag();
    if (_jspx_th_html_005fhidden_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f4 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemainself.jsp(186,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setProperty("dh");
    int _jspx_eval_html_005fhidden_005f4 = _jspx_th_html_005fhidden_005f4.doStartTag();
    if (_jspx_th_html_005fhidden_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f5 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemainself.jsp(187,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f5.setProperty("method");
    // /colmaintenance/colmaintenancemainself.jsp(187,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f5.setValue("query");
    int _jspx_eval_html_005fhidden_005f5 = _jspx_th_html_005fhidden_005f5.doStartTag();
    if (_jspx_th_html_005fhidden_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f5);
    return false;
  }
}
