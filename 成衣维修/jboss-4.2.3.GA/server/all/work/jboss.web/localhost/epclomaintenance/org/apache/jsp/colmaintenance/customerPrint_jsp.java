package org.apache.jsp.colmaintenance;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class customerPrint_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhtml;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fhtml = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fhtml.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.release();
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.release();
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
String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getContextPath(); 

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
          out.write("<head>\r\n");
          out.write("<title>顾客打印</title>\r\n");
          out.write("<link rel=\"stylesheet\" type=\"text/css\"\r\n");
          out.write("\t\thref=\"");
          out.print(request.getContextPath());
          out.write("/mycss/common.css\" media=\"PRINT\"/>\r\n");
          out.write("\r\n");
          out.write("<link rel=\"stylesheet\" type=\"text/css\"\r\n");
          out.write("\t\thref=\"");
          out.print(request.getContextPath());
          out.write("/mycss/common.css\" />\r\n");
          out.write("\r\n");
          out.write("<STYLE  MEDIA=\"PRINT\">    \r\n");
          out.write("     .button {display:none;}\r\n");
          out.write("</STYLE>\r\n");
          out.write("<STYLE MEDIA=\"SCREEN\">    \r\n");
          out.write("    .button {display:block;}\r\n");
          out.write("</STYLE>\r\n");
          out.write("\r\n");
          out.write("</head>\r\n");
          out.write("<script> \r\n");
          out.write("/**function previewPrint(){\r\n");
          out.write("\tdocument.getElementById(\"printTool\").style.display='none';\r\n");
          out.write("\twb.execwb(7,1);\r\n");
          out.write("\tdocument.getElementById(\"printTool\").style.display='block';\r\n");
          out.write("}\r\n");
          out.write("\r\n");
          out.write("function doPrint(){\r\n");
          out.write("\tdocument.getElementById(\"printTool\").style.display='none';\r\n");
          out.write("\twb.execwb(6,6);\r\n");
          out.write("\tdocument.getElementById(\"printTool\").style.display='block';\r\n");
          out.write("\t\r\n");
          out.write("}\r\n");
          out.write("\r\n");
          out.write("function initForm(){\r\n");
          out.write("\topener.window.close();\r\n");
          out.write("}*/\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("function Preview() \r\n");
          out.write("{\r\n");
          out.write("\t\r\n");
          out.write("\ttry{\r\n");
          out.write("\t\r\n");
          out.write("\t\tif (document.all.eprint.defaultPrinterName.length==0){\r\n");
          out.write("\t\t\talert(\"请先安装打印机，再执行此功能！\");\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t}\r\n");
          out.write("\r\n");
          out.write("  \t\teprint.InitPrint();\r\n");
          out.write(" \t\teprint.header = \"\";\r\n");
          out.write("  \t\teprint.footer = \"\";\r\n");
          out.write("  \t\teprint.Preview();\r\n");
          out.write("\t}catch(e){\r\n");
          out.write("\t\tvar url=document.getElementById(\"webContext\").value+'/colmaintenance/webprintDownload.jsp';\r\n");
          out.write("\t\twindow.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');\r\n");
          out.write("\t\r\n");
          out.write("\t}\r\n");
          out.write("}\r\n");
          out.write("\r\n");
          out.write("function Print() {  \r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\ttry{\r\n");
          out.write("\t\t\tif (document.all.eprint.defaultPrinterName.length==0){\r\n");
          out.write("\t\t\talert(\"请先安装打印机，再执行此功能！\");\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t}\r\n");
          out.write("\r\n");
          out.write("  \teprint.InitPrint();\r\n");
          out.write("  \t\teprint.header = \"\";\r\n");
          out.write("  \t\teprint.footer = \"\";\r\n");
          out.write("  \t\teprint.Print();\r\n");
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
          out.write("\t\tvar url=document.getElementById(\"webContext\").value+'/colmaintenance/webprintDownload.jsp';\r\n");
          out.write("\t\twindow.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tvar dh = document.getElementById(\"dhspan\").innerText; \r\n");
          out.write("\tvar srcstr = 'http://192.168.0.43/barcode.bracodeServlet?image=1&type=21&data='+dh+'&height=50';  \r\n");
          out.write("\tdocument.getElementById(\"dhtxmimg\").src=srcstr;\t\r\n");
          out.write("\r\n");
          out.write("}\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write(" </script>\r\n");
          out.write("\r\n");
          out.write("<body onload=\"initForm()\">\r\n");
          out.write("\t<!--   <OBJECT classid=\"CLSID:8856F961-340A-11D0-A96B-00C04FD705A2\" height=0 id=\"wb\" name=\"wb\" width=0></OBJECT> -->\r\n");
          out.write("\t\r\n");
          out.write("\t<!--  <object id=\"eprint\" classid=\"clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441\" codebase=\"");
          out.print(request.getContextPath());
          out.write("/plug_tools/webprint.CAB#Version=3,0,0,13\"  viewasext> </object>-->\r\n");
          out.write("\t\r\n");
          out.write("\t <object id=\"eprint\" classid=\"clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441\"  viewasext> </object>\r\n");
          out.write("\t\r\n");
          out.write("\t");
          //  html:form
          org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
          _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
          _jspx_th_html_005fform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
          // /colmaintenance/customerPrint.jsp(117,1) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setAction("/customerPrint");
          // /colmaintenance/customerPrint.jsp(117,1) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setStyleId("customerPrintForm");
          // /colmaintenance/customerPrint.jsp(117,1) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setMethod("post");
          int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
          if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t");
              //  html:hidden
              org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
              _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
              _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
              // /colmaintenance/customerPrint.jsp(120,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f0.setProperty("webContext");
              // /colmaintenance/customerPrint.jsp(120,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f0.setValue(request.getContextPath());
              int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
              if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
                return;
              }
              _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
              out.write("\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t<div id=\"printTool\">\r\n");
              out.write("\t\t\t<input type=button name=button_print class=\"button\" value=\"打印\" onclick=\"Print()\" style=\"position:absolute;left:10px;top:10px;width:80px\"> \r\n");
              out.write("\t\t\t<input type=button name=button_show  class=\"button\" value=\"打印预览\" onclick=\"Preview()\" style=\"position:absolute;left:100px;top:10px;width:80px\">\r\n");
              out.write("\t\t</div>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\r\n");
              out.write("\t\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t<table width=\"90%\"  align=\"center\">\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t<tr>\r\n");
              out.write("\t\t\t<td width=\"40%\">\r\n");
              out.write("\t\t\t\t");
              out.write("\r\n");
              out.write("\t\t\t</td>\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t<td align=\"center\">\r\n");
              out.write("\t\t\t\t<font size=\"5\" style= \"font-weight:bold \">顾客维修单</font>\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t</td>\r\n");
              out.write("\t\t\t<td align=\"right\" width=\"40%\">\r\n");
              out.write("\t\t\t\t<!-- <font size=\"2px\"> 维修单号&nbsp;");
              if (_jspx_meth_bean_005fwrite_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("</font> -->\r\n");
              out.write("\t\t\t\t<span id=\"dhspan\" style=\"display: none;\">");
              if (_jspx_meth_bean_005fwrite_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("</span> \r\n");
              out.write("\t\t\t\t<div>\r\n");
              out.write("\t\t\t\t\t<img id='dhtxmimg'  alt=\"\" src=\"\" >\r\n");
              out.write("\t\t\t\t</div> \r\n");
              out.write("\t\t\t</td>\r\n");
              out.write("\t\t</tr>\r\n");
              out.write("\t\t</table>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t<DIV align=\"center\">\r\n");
              out.write("\t\t<!-- <table width=\"100%\" border=\"0\" bgcolor=#000000 cellpadding=\"0\" cellspacing=\"1\"> -->  \r\n");
              out.write("\t\t\t<table width=\"90%\" class=\"table_thin\" align=\"center\">\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\t\t<!-- <tr>\r\n");
              out.write("\t\t\t\t\t<td colspan=\"8\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t</tr> -->\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td width=\"10.5%\" class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t所属公司\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td colspan=\"7\"  width=\"18.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\" colspan=\"2\" >\r\n");
              out.write("\t\t\t\t\t\t款号\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\" colspan=\"1\" >\r\n");
              out.write("\t\t\t\t\t\t颜色\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\"colspan=\"1\">\r\n");
              out.write("\t\t\t\t\t\t码数\r\n");
              out.write("\t\t\t\t\t</td >\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\" colspan=\"2\">\r\n");
              out.write("\t\t\t\t\t\t售出时间\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\"  colspan=\"2\">\r\n");
              out.write("\t\t\t\t\t\t问题描述\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\" colspan=\"2\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\" colspan=\"1\" >\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\" colspan=\"1\" >\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\" colspan=\"2\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f6(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\" colspan=\"2\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f7(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td rowspan=\"4\" width=\"10.5%\" class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t店铺信息\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"12.5%\" class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t店铺名称\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"18.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f8(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td rowspan=\"4\" width=\"10.5%\" class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t顾客信息\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"11.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"12.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t顾客维修\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"11.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td width=\"12.5%\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t店铺维修\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t店长姓名\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f9(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t顾客名称\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f10(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t顾客电话\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f11(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t导购电话\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f12(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\tVIP卡号\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td colspan=\"3\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f13(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\t<tr>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t受理导购\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_bean_005fwrite_005f14(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"field_enabled\">\r\n");
              out.write("\t\t\t\t\t\t付费维修\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f6(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t<td colspan=\"2\" class=\"td_enabled\">\r\n");
              out.write("\t\t\t\t\t\t\r\n");
              out.write("\t\t\t\t\t\t");
              if (_jspx_meth_html_005fcheckbox_005f7(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t\t\t</td>\r\n");
              out.write("\t\t\t\t\t\r\n");
              out.write("\r\n");
              out.write("\t\t\t\t</tr>\r\n");
              out.write("\t\t\t\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t\t\r\n");
              out.write("\t\t\t</tbody>\r\n");
              out.write("\t\t</table>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t</DIV>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t<table width=\"90%\" align=\"center\">\r\n");
              out.write("\t\t <tr>\r\n");
              out.write("\t\t \t<td align=\"left\" colspan=\"2\">\r\n");
              out.write("\t\t \t\t<font color=\"red\" size=\"2\">备注：必须凭此单提取衣服！</font>\r\n");
              out.write("\t\t \t</td>\r\n");
              out.write("\t\t </tr>\t\t\r\n");
              out.write("\t\t <tr>\r\n");
              out.write("\t\t  \t<td width=\"80%\" align=\"right\">\r\n");
              out.write("\t\t  \t\t<font size=\"2\">顾客签字：</font>\r\n");
              out.write("\t\t  \t</td>\r\n");
              out.write("\t\t \t <td width=\"20%\">\r\n");
              out.write("\t\t \t</td>\r\n");
              out.write("\t\t </tr>\r\n");
              out.write("\t\t \r\n");
              out.write("\t\t  <tr>\r\n");
              out.write("\t\t  \t<td width=\"80%\" align=\"right\">\r\n");
              out.write("\t\t \t \t<font size=\"2\"> 退回日期：</font>\r\n");
              out.write("\t\t \t </td>\r\n");
              out.write("\t\t \t <td align=\"left\"><br>\r\n");
              out.write("\t\t \t \t<font size=\"2\">\r\n");
              out.write("\t\t \t \t \r\n");
              out.write("\t\t \t \t</font>\r\n");
              out.write("\t\t  \t<br></td>\r\n");
              out.write("\t\t </tr>\r\n");
              out.write("\t\t</table>\r\n");
              out.write("\t\t\r\n");
              out.write("\t\t");
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
          out.write("\r\n");
          out.write("\r\n");
          out.write("</body>\r\n");
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

  private boolean _jspx_meth_bean_005fwrite_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f0 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f0.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(143,37) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f0.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(143,37) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f0.setProperty("dh");
    int _jspx_eval_bean_005fwrite_005f0 = _jspx_th_bean_005fwrite_005f0.doStartTag();
    if (_jspx_th_bean_005fwrite_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f1 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f1.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(144,45) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f1.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(144,45) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f1.setProperty("dh");
    int _jspx_eval_bean_005fwrite_005f1 = _jspx_th_bean_005fwrite_005f1.doStartTag();
    if (_jspx_th_bean_005fwrite_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f0 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(159,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f0.setStyleClass("checkBox_1");
    // /colmaintenance/customerPrint.jsp(159,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f0.setValue("E");
    // /colmaintenance/customerPrint.jsp(159,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f0.setProperty("PP");
    // /colmaintenance/customerPrint.jsp(159,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f0.setOnclick("this.checked=!this.checked");
    int _jspx_eval_html_005fcheckbox_005f0 = _jspx_th_html_005fcheckbox_005f0.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f0.doInitBody();
      }
      do {
        out.write('E');
        out.write('P');
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f1 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(161,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f1.setStyleClass("checkBox_1");
    // /colmaintenance/customerPrint.jsp(161,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f1.setValue("M");
    // /colmaintenance/customerPrint.jsp(161,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f1.setProperty("PP");
    // /colmaintenance/customerPrint.jsp(161,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f1.setOnclick("this.checked=!this.checked");
    int _jspx_eval_html_005fcheckbox_005f1 = _jspx_th_html_005fcheckbox_005f1.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f1.doInitBody();
      }
      do {
        out.write('E');
        out.write('M');
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f2 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(163,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f2.setStyleClass("checkBox_1");
    // /colmaintenance/customerPrint.jsp(163,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f2.setValue("T");
    // /colmaintenance/customerPrint.jsp(163,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f2.setProperty("PP");
    // /colmaintenance/customerPrint.jsp(163,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f2.setOnclick("this.checked=!this.checked");
    int _jspx_eval_html_005fcheckbox_005f2 = _jspx_th_html_005fcheckbox_005f2.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f2.doInitBody();
      }
      do {
        out.write('T');
        out.write('B');
        out.write('F');
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f2.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f3 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(165,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f3.setStyleClass("checkBox_1");
    // /colmaintenance/customerPrint.jsp(165,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f3.setValue("F");
    // /colmaintenance/customerPrint.jsp(165,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f3.setProperty("PP");
    // /colmaintenance/customerPrint.jsp(165,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f3.setOnclick("this.checked=!this.checked");
    int _jspx_eval_html_005fcheckbox_005f3 = _jspx_th_html_005fcheckbox_005f3.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f3.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f3.doInitBody();
      }
      do {
        out.write("Outlet");
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f3.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f3 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f3);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f2 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f2.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(173,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f2.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(173,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f2.setProperty("PP");
    int _jspx_eval_bean_005fwrite_005f2 = _jspx_th_bean_005fwrite_005f2.doStartTag();
    if (_jspx_th_bean_005fwrite_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f2);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f3 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f3.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(195,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f3.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(195,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f3.setProperty("KH");
    int _jspx_eval_bean_005fwrite_005f3 = _jspx_th_bean_005fwrite_005f3.doStartTag();
    if (_jspx_th_bean_005fwrite_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f3);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f4 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f4.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(198,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f4.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(198,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f4.setProperty("YS");
    int _jspx_eval_bean_005fwrite_005f4 = _jspx_th_bean_005fwrite_005f4.doStartTag();
    if (_jspx_th_bean_005fwrite_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f4);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f5 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f5.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(201,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f5.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(201,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f5.setProperty("MS");
    int _jspx_eval_bean_005fwrite_005f5 = _jspx_th_bean_005fwrite_005f5.doStartTag();
    if (_jspx_th_bean_005fwrite_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f5);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f6 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f6.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(204,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f6.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(204,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f6.setProperty("SCSJ");
    int _jspx_eval_bean_005fwrite_005f6 = _jspx_th_bean_005fwrite_005f6.doStartTag();
    if (_jspx_th_bean_005fwrite_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f6);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f7 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f7.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(207,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f7.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(207,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f7.setProperty("WTMS");
    int _jspx_eval_bean_005fwrite_005f7 = _jspx_th_bean_005fwrite_005f7.doStartTag();
    if (_jspx_th_bean_005fwrite_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f7);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f8 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f8.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(218,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f8.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(218,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f8.setProperty("dpmc");
    int _jspx_eval_bean_005fwrite_005f8 = _jspx_th_bean_005fwrite_005f8.doStartTag();
    if (_jspx_th_bean_005fwrite_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f8);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f4 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(225,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f4.setValue("1");
    // /colmaintenance/customerPrint.jsp(225,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f4.setProperty("GKWX");
    // /colmaintenance/customerPrint.jsp(225,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f4.setOnclick("this.checked=!this.checked");
    // /colmaintenance/customerPrint.jsp(225,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f4.setStyleClass("checkBox_1");
    int _jspx_eval_html_005fcheckbox_005f4 = _jspx_th_html_005fcheckbox_005f4.doStartTag();
    if (_jspx_th_html_005fcheckbox_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005fcheckbox_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005fcheckbox_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f5 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(232,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f5.setValue("0");
    // /colmaintenance/customerPrint.jsp(232,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f5.setProperty("GKWX");
    // /colmaintenance/customerPrint.jsp(232,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f5.setOnclick("this.checked=!this.checked");
    // /colmaintenance/customerPrint.jsp(232,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f5.setStyleClass("checkBox_1");
    int _jspx_eval_html_005fcheckbox_005f5 = _jspx_th_html_005fcheckbox_005f5.doStartTag();
    if (_jspx_th_html_005fcheckbox_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005fcheckbox_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005fcheckbox_005f5);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f9 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f9.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(243,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f9.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(243,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f9.setProperty("DZXM");
    int _jspx_eval_bean_005fwrite_005f9 = _jspx_th_bean_005fwrite_005f9.doStartTag();
    if (_jspx_th_bean_005fwrite_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f9);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f9);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f10 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f10.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(250,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f10.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(250,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f10.setProperty("GKXM");
    int _jspx_eval_bean_005fwrite_005f10 = _jspx_th_bean_005fwrite_005f10.doStartTag();
    if (_jspx_th_bean_005fwrite_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f10);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f10);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f11 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f11.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(256,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f11.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(256,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f11.setProperty("GKLXDH");
    int _jspx_eval_bean_005fwrite_005f11 = _jspx_th_bean_005fwrite_005f11.doStartTag();
    if (_jspx_th_bean_005fwrite_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f11);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f11);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f12(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f12 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f12.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(265,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f12.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(265,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f12.setProperty("DGLXDH");
    int _jspx_eval_bean_005fwrite_005f12 = _jspx_th_bean_005fwrite_005f12.doStartTag();
    if (_jspx_th_bean_005fwrite_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f12);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f12);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f13(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f13 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f13.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(271,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f13.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(271,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f13.setProperty("VIPKH");
    int _jspx_eval_bean_005fwrite_005f13 = _jspx_th_bean_005fwrite_005f13.doStartTag();
    if (_jspx_th_bean_005fwrite_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f13);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f13);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f14(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f14 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f14.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(281,6) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f14.setName("customerPrintForm");
    // /colmaintenance/customerPrint.jsp(281,6) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f14.setProperty("SLDG");
    int _jspx_eval_bean_005fwrite_005f14 = _jspx_th_bean_005fwrite_005f14.doStartTag();
    if (_jspx_th_bean_005fwrite_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f14);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f14);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f6 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f6.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(288,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f6.setValue("1");
    // /colmaintenance/customerPrint.jsp(288,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f6.setProperty("SFTYFFWX");
    // /colmaintenance/customerPrint.jsp(288,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f6.setOnclick("this.checked=!this.checked");
    // /colmaintenance/customerPrint.jsp(288,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f6.setStyleClass("checkBox_1");
    int _jspx_eval_html_005fcheckbox_005f6 = _jspx_th_html_005fcheckbox_005f6.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f6 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f6 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f6.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f6.doInitBody();
      }
      do {
        out.write('是');
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f6.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f6 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f6);
    return false;
  }

  private boolean _jspx_meth_html_005fcheckbox_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:checkbox
    org.apache.struts.taglib.html.CheckboxTag _jspx_th_html_005fcheckbox_005f7 = (org.apache.struts.taglib.html.CheckboxTag) _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.get(org.apache.struts.taglib.html.CheckboxTag.class);
    _jspx_th_html_005fcheckbox_005f7.setPageContext(_jspx_page_context);
    _jspx_th_html_005fcheckbox_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/customerPrint.jsp(292,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f7.setValue("0");
    // /colmaintenance/customerPrint.jsp(292,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f7.setProperty("SFTYFFWX");
    // /colmaintenance/customerPrint.jsp(292,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f7.setOnclick("this.checked=!this.checked");
    // /colmaintenance/customerPrint.jsp(292,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fcheckbox_005f7.setStyleClass("checkBox_1");
    int _jspx_eval_html_005fcheckbox_005f7 = _jspx_th_html_005fcheckbox_005f7.doStartTag();
    if (_jspx_eval_html_005fcheckbox_005f7 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fcheckbox_005f7 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fcheckbox_005f7.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fcheckbox_005f7.doInitBody();
      }
      do {
        out.write('否');
        int evalDoAfterBody = _jspx_th_html_005fcheckbox_005f7.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fcheckbox_005f7 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fcheckbox_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fcheckbox_005fvalue_005fstyleClass_005fproperty_005fonclick.reuse(_jspx_th_html_005fcheckbox_005f7);
    return false;
  }
}
