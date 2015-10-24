package org.apache.jsp.quickcargotransfer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.util.*;

public final class notifySendCargo_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhtml;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005frow_005frecordKey_005fonmouseover_005fonmouseout_005fonclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fhtml = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey_005fonmouseover_005fonmouseout_005fonclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fhtml.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.release();
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey_005fonmouseover_005fonmouseout_005fonclick.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.release();
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

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      //  html:html
      org.apache.struts.taglib.html.HtmlTag _jspx_th_html_005fhtml_005f0 = (org.apache.struts.taglib.html.HtmlTag) _005fjspx_005ftagPool_005fhtml_005fhtml.get(org.apache.struts.taglib.html.HtmlTag.class);
      _jspx_th_html_005fhtml_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fhtml_005f0.setParent(null);
      int _jspx_eval_html_005fhtml_005f0 = _jspx_th_html_005fhtml_005f0.doStartTag();
      if (_jspx_eval_html_005fhtml_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  <head>\r\n");
          out.write("    <base href=\"");
          out.print(basePath);
          out.write("\">\r\n");
          out.write("    \r\n");
          out.write("    <title>通知发货</title>\r\n");
          out.write("    \r\n");
          out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
          out.print(request.getContextPath());
          out.write("/ecside/css/ecside_style.css\" />\r\n");
          out.write("\t\r\n");
          out.write("\t<script type=\"text/javascript\" src=\"");
          out.print(request.getContextPath());
          out.write("/ecside/js/prototype_mini.js\"></script>\r\n");
          out.write("\t<script type=\"text/javascript\" src=\"");
          out.print(request.getContextPath());
          out.write("/ecside/js/ecside_msg_utf8_cn.js\"></script>\r\n");
          out.write("\t<script type=\"text/javascript\" src=\"");
          out.print(request.getContextPath());
          out.write("/ecside/js/ecside.js\"></script>\r\n");
          out.write("\r\n");
          out.write("\t<script type=\"text/javascript\" src=\"");
          out.print(request.getContextPath());
          out.write("/myjs/myTime.js\"></script>\t\r\n");
          out.write("\t\r\n");
          out.write("\t<script type=\"text/javascript\" src=\"");
          out.print(request.getContextPath());
          out.write("/jquery/jquery-1.4.2.js\"></script>\t\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("  </head>\r\n");
          out.write("  \r\n");
          out.write("  <script>\r\n");
          out.write("  \tfunction setGuid(){\r\n");
          out.write("  \t\tdocument.getElementById('responseButton2').disabled = false;\r\n");
          out.write("  \t\tdocument.getElementById('responseButton1').disabled = false;\r\n");
          out.write("  \t\tvar ecsideObj=ECSideUtil.getGridObj('ecTable');\r\n");
          out.write("\t\tvar selectedRow = ecsideObj.selectedRow;\r\n");
          out.write("\t\tvar recordKey = selectedRow.getAttribute(\"recordKey\");\r\n");
          out.write("  \t\tdocument.getElementById('guid').value=recordKey;\r\n");
          out.write("  \t}\r\n");
          out.write("  \r\n");
          out.write("  \r\n");
          out.write("  function notifyDetail(state){\r\n");
          out.write("  \tvar guid = document.getElementById('guid').value;\r\n");
          out.write("  \tif(guid=='' || guid==null){\r\n");
          out.write("  \t\talert('请选择记录！');\r\n");
          out.write("  \t\treturn;\r\n");
          out.write("  \t}\r\n");
          out.write("  \tif(state==1){\r\n");
          out.write("  \t\tif(confirm('确定要通知发货？')){\r\n");
          out.write("  \t\t\tdocument.getElementById(\"notifySate\").value='待发货';\r\n");
          out.write(" \t\t\tdocument.getElementById(\"action\").value='notifySendCargo';\r\n");
          out.write(" \t\t\tdocument.forms[0].submit();\t\r\n");
          out.write("  \t\t\twaitDetail();\r\n");
          out.write("  \t\t}\r\n");
          out.write("  \t}\r\n");
          out.write("  \tif(state==0){\r\n");
          out.write("  \t\tif(confirm('确定要取消发货通知？')){\r\n");
          out.write("  \t\t\tdocument.getElementById(\"notifySate\").value='已取消';\r\n");
          out.write(" \t\t\tdocument.getElementById(\"action\").value='notifySendCargo';\r\n");
          out.write(" \t\t\tdocument.forms[0].submit();\t\r\n");
          out.write("  \t\t\twaitDetail();\r\n");
          out.write("  \t\t}\r\n");
          out.write("  \t}\r\n");
          out.write("  \t\r\n");
          out.write("  \r\n");
          out.write("  }\r\n");
          out.write("  \r\n");
          out.write("  function initForm(){\r\n");
          out.write("  \t\r\n");
          out.write("  \tif(document.getElementById('detailResult').value=='1'){\r\n");
          out.write("  \t\talert('处理完成！');\r\n");
          out.write("  \t\tdocument.getElementById('detailResult').value=='';\r\n");
          out.write("  \t}\r\n");
          out.write("  \tif(document.getElementById('detailResult').value=='0'){\r\n");
          out.write("  \t\talert('处理失败！');\r\n");
          out.write("  \t\tdocument.getElementById('detailResult').value=='';\r\n");
          out.write("  \t}\r\n");
          out.write("  \t//$('#ecTable').find('').each(function(){\r\n");
          out.write("  }\r\n");
          out.write("  \r\n");
          out.write("  \r\n");
          out.write("   function waitDetail(){\r\n");
          out.write(" \t$('#waitDiv').slideDown('fast');\r\n");
          out.write(" \t$('#mainDiv').slideUp('fast');\r\n");
          out.write(" }\r\n");
          out.write(" \r\n");
          out.write(" \r\n");
          out.write(" function mouseonChange(obj){\r\n");
          out.write("      obj.style.cursor='hand';\r\n");
          out.write("  }\r\n");
          out.write(" \r\n");
          out.write("  \r\n");
          out.write("  function mouseoutChange(obj){\r\n");
          out.write("      obj.style.cursor='move';\r\n");
          out.write("      \r\n");
          out.write("  }\r\n");
          out.write("  </script>\r\n");
          out.write("  \r\n");
          out.write("  <body onload=\"initForm()\">\r\n");
          out.write("    \r\n");
          out.write("    <div style=\"position: relative\">\r\n");
          out.write("    <div id=\"waitDiv\" style=\"position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;\">正在处理，请稍后......</div>\r\n");
          out.write("    <div id=\"mainDiv\" style=\"position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;\">\r\n");
          out.write("    \r\n");
          out.write("    <input type=\"hidden\" id=\"webcontent\" name=\"webcontent\" value=\"");
          out.print(path);
          out.write("\">\r\n");
          out.write("    \r\n");
          out.write("    \r\n");
          out.write("    ");
          if (_jspx_meth_html_005fform_005f0(_jspx_th_html_005fhtml_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("  \t\r\n");
          out.write("  \t");
          if (_jspx_meth_ec_005ftable_005f0(_jspx_th_html_005fhtml_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t");
          if (_jspx_meth_html_005fbutton_005f0(_jspx_th_html_005fhtml_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("  \t\t\t");
          if (_jspx_meth_html_005fbutton_005f1(_jspx_th_html_005fhtml_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("  </div>\r\n");
          out.write("  </div>\r\n");
          out.write("  </body>\r\n");
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
      out.write("  ");
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

  private boolean _jspx_meth_html_005fform_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fhtml_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:form
    org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(109,4) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setAction("/notifyCargo");
    // /quickcargotransfer/notifySendCargo.jsp(109,4) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setStyleId("notifySendCargoForm");
    // /quickcargotransfer/notifySendCargo.jsp(109,4) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setMethod("post");
    int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
    if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("    \t");
        if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t");
        if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t");
        if (_jspx_meth_html_005fhidden_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t");
        if (_jspx_meth_html_005fhidden_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t");
        if (_jspx_meth_html_005fhidden_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t");
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
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(110,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("action");
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
    // /quickcargotransfer/notifySendCargo.jsp(111,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("depotid");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(112,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setProperty("notifySate");
    int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
    if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
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
    // /quickcargotransfer/notifySendCargo.jsp(113,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
    // /quickcargotransfer/notifySendCargo.jsp(114,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setProperty("detailResult");
    int _jspx_eval_html_005fhidden_005f4 = _jspx_th_html_005fhidden_005f4.doStartTag();
    if (_jspx_th_html_005fhidden_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
    return false;
  }

  private boolean _jspx_meth_ec_005ftable_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fhtml_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:table
    org.ecside.tag.TableTag _jspx_th_ec_005ftable_005f0 = (org.ecside.tag.TableTag) _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.get(org.ecside.tag.TableTag.class);
    _jspx_th_ec_005ftable_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005ftable_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = items type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setItems(new String("reponsedCargoApply"));
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = var type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setVar("record");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = tableId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setTableId("ecTable");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = useAjax type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setUseAjax("false");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = doPreload type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setDoPreload("false");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = toolbarContent type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setToolbarContent("navigation|pagejump|pagesize|export|extend|status");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = showHeader type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setShowHeader("true");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = width type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setWidth("100%");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = retrieveRowsCallback type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRetrieveRowsCallback("process");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = action type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setAction("notifyCargo.do");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = pageSizeList type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setPageSizeList("10,20,30,50");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = rowsDisplayed type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRowsDisplayed("20");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = editable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setEditable("false");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = classic type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setClassic("true");
    // /quickcargotransfer/notifySendCargo.jsp(117,3) name = filterable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setFilterable("true");
    int[] _jspx_push_body_count_ec_005ftable_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005ftable_005f0 = _jspx_th_ec_005ftable_005f0.doStartTag();
      if (_jspx_eval_ec_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t \r\n");
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
      _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.reuse(_jspx_th_ec_005ftable_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005frow_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005ftable_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005ftable_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:row
    org.ecside.tag.RowTag _jspx_th_ec_005frow_005f0 = (org.ecside.tag.RowTag) _005fjspx_005ftagPool_005fec_005frow_005frecordKey_005fonmouseover_005fonmouseout_005fonclick.get(org.ecside.tag.RowTag.class);
    _jspx_th_ec_005frow_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005frow_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005ftable_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(125,3) name = recordKey type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setRecordKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.guid}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /quickcargotransfer/notifySendCargo.jsp(125,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOnclick("setGuid()");
    // /quickcargotransfer/notifySendCargo.jsp(125,3) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOnmouseover("mouseonChange(this)");
    // /quickcargotransfer/notifySendCargo.jsp(125,3) name = onmouseout type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOnmouseout("mouseoutChange(this)");
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
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f0(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
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
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f9(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f10(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f11(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f12(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f13(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f14(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t");
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
      _005fjspx_005ftagPool_005fec_005frow_005frecordKey_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_ec_005frow_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f0 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(129,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setProperty("_0");
    // /quickcargotransfer/notifySendCargo.jsp(129,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setTitle("序号");
    // /quickcargotransfer/notifySendCargo.jsp(129,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${GLOBALROWCOUNT}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f1 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f1.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(131,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setTitle("需求款式");
    // /quickcargotransfer/notifySendCargo.jsp(131,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setProperty("XQKH");
    // /quickcargotransfer/notifySendCargo.jsp(131,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f2 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f2.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(132,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setTitle("颜色");
    // /quickcargotransfer/notifySendCargo.jsp(132,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setProperty("YS");
    // /quickcargotransfer/notifySendCargo.jsp(132,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f3 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f3.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(133,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setTitle("尺码");
    // /quickcargotransfer/notifySendCargo.jsp(133,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setProperty("CM");
    // /quickcargotransfer/notifySendCargo.jsp(133,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f4 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f4.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(134,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setTitle("最晚回复日期");
    // /quickcargotransfer/notifySendCargo.jsp(134,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setProperty("YQHFRQ");
    // /quickcargotransfer/notifySendCargo.jsp(134,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f4);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f5 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f5.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(135,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setTitle("最晚到货日期");
    // /quickcargotransfer/notifySendCargo.jsp(135,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setProperty("XQRQ");
    // /quickcargotransfer/notifySendCargo.jsp(135,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f5);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f6 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f6.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(136,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setTitle("申请日期");
    // /quickcargotransfer/notifySendCargo.jsp(136,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setProperty("SQRQ");
    // /quickcargotransfer/notifySendCargo.jsp(136,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f6);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f7 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f7.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(137,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setTitle("承诺调货日期");
    // /quickcargotransfer/notifySendCargo.jsp(137,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setProperty("CNDHRQ");
    // /quickcargotransfer/notifySendCargo.jsp(137,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f7);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f8 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f8.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(138,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setTitle("供方编号");
    // /quickcargotransfer/notifySendCargo.jsp(138,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setProperty("GFBH");
    // /quickcargotransfer/notifySendCargo.jsp(138,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f8);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f9 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f9.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(139,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setTitle("供方名称");
    // /quickcargotransfer/notifySendCargo.jsp(139,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setProperty("GFMC");
    // /quickcargotransfer/notifySendCargo.jsp(139,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f9 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f9 = _jspx_th_ec_005fcolumn_005f9.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f9[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f9.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f9.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f9);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f10 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f10.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(140,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setTitle("店铺类别");
    // /quickcargotransfer/notifySendCargo.jsp(140,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setProperty("DPLB");
    // /quickcargotransfer/notifySendCargo.jsp(140,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f10 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f10 = _jspx_th_ec_005fcolumn_005f10.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f10[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f10.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f10.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f10);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f11 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f11.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(142,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setTitle("所属大区");
    // /quickcargotransfer/notifySendCargo.jsp(142,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setProperty("GFSSDQ");
    // /quickcargotransfer/notifySendCargo.jsp(142,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f11 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f11 = _jspx_th_ec_005fcolumn_005f11.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f11[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f11.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f11.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f11);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f12(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f12 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f12.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(143,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setTitle("店长");
    // /quickcargotransfer/notifySendCargo.jsp(143,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setProperty("DZ");
    // /quickcargotransfer/notifySendCargo.jsp(143,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f12 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f12 = _jspx_th_ec_005fcolumn_005f12.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f12[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f12.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f12.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f12);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f13(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f13 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f13.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(145,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setTitle("电话");
    // /quickcargotransfer/notifySendCargo.jsp(145,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setProperty("DH");
    // /quickcargotransfer/notifySendCargo.jsp(145,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f13 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f13 = _jspx_th_ec_005fcolumn_005f13.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f13[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f13.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f13.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f13);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f14(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f14 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f14.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(146,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setTitle("该店半月销售额");
    // /quickcargotransfer/notifySendCargo.jsp(146,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setProperty("NUMS");
    // /quickcargotransfer/notifySendCargo.jsp(146,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f14 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f14 = _jspx_th_ec_005fcolumn_005f14.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f14[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f14.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f14.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f14);
    }
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fhtml_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f0 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(155,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setStyleId("responseButton1");
    // /quickcargotransfer/notifySendCargo.jsp(155,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setProperty("responseButton1");
    // /quickcargotransfer/notifySendCargo.jsp(155,3) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setValue("通知发货");
    // /quickcargotransfer/notifySendCargo.jsp(155,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setOnclick("notifyDetail(1)");
    // /quickcargotransfer/notifySendCargo.jsp(155,3) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setDisabled(true);
    int _jspx_eval_html_005fbutton_005f0 = _jspx_th_html_005fbutton_005f0.doStartTag();
    if (_jspx_th_html_005fbutton_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005fbutton_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005fbutton_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fhtml_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f1 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
    // /quickcargotransfer/notifySendCargo.jsp(156,5) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setStyleId("responseButton2");
    // /quickcargotransfer/notifySendCargo.jsp(156,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setProperty("responseButton2");
    // /quickcargotransfer/notifySendCargo.jsp(156,5) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setValue("取消发货");
    // /quickcargotransfer/notifySendCargo.jsp(156,5) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setOnclick("notifyDetail(0)");
    // /quickcargotransfer/notifySendCargo.jsp(156,5) name = disabled type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setDisabled(true);
    int _jspx_eval_html_005fbutton_005f1 = _jspx_th_html_005fbutton_005f1.doStartTag();
    if (_jspx_th_html_005fbutton_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005fbutton_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fproperty_005fonclick_005fdisabled_005fnobody.reuse(_jspx_th_html_005fbutton_005f1);
    return false;
  }
}
