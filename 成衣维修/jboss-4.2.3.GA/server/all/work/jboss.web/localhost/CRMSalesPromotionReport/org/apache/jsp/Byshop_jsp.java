package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class Byshop_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fform_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody.release();
    _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005fform_005faction.release();
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat.release();
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody.release();
    _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody.release();
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

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      if (_jspx_meth_s_005fhead_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_sx_005fhead_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("<!-- 这句加上日期才显示 -->\r\n");
      out.write("\r\n");
      out.write("<title>单店历史活动分析</title>\r\n");
      out.write("<meta http-equiv=\"pragma\" content=\"no-cache\">\r\n");
      out.write("<meta http-equiv=\"cache-control\" content=\"no-cache\">\r\n");
      out.write("<meta http-equiv=\"expires\" content=\"0\">\r\n");
      out.write("<meta http-equiv=\"keywords\" content=\"keyword1,keyword2,keyword3\">\r\n");
      out.write("<meta http-equiv=\"description\" content=\"This is my page\">\r\n");
      out.write("<link href=\"css/jquerymenu.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("<link href=\"css/custom.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("<script type=\"text/javascript\" src=\"js/jquery.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"js/jquerymenu.js\"></script>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\t");
      if (_jspx_meth_s_005faction_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<table\r\n");
      out.write("\t\tstyle=\" border-collapse:collapse; border:solid  0px; border-color: white; width: 980px\"\r\n");
      out.write("\t\tborder=\"0\">\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td>\r\n");
      out.write("\t\t\t\t<div class=\"jquerymenu\" id=\"myslidemenu\">\r\n");
      out.write("\t\t\t\t\t<ul>\r\n");
      out.write("\t\t\t\t\t\t<li><a href=\"index.jsp\">首 页</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li><a href=\"Bytheme.jsp\">单活动分析</a>\r\n");
      out.write("\t\t\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t\t\t<li><a href=\"Byshop.jsp\">单店活动分析</a></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</div></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td>");
      if (_jspx_meth_s_005fform_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td>\r\n");
      out.write("\t\t\t\t<div id=\"resultshop\"></div></td>\r\n");
      out.write("\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t<p align=center>\r\n");
      out.write("\t\t市场活动分析 v1.0 copyright 2012<br> 信息管理部\r\n");
      out.write("\t</p>\r\n");
      out.write("</body>\r\n");
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

  private boolean _jspx_meth_s_005fhead_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:head
    org.apache.struts2.views.jsp.ui.HeadTag _jspx_th_s_005fhead_005f0 = (org.apache.struts2.views.jsp.ui.HeadTag) _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody.get(org.apache.struts2.views.jsp.ui.HeadTag.class);
    _jspx_th_s_005fhead_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhead_005f0.setParent(null);
    // /Byshop.jsp(16,0) name = theme type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhead_005f0.setTheme("xhtml");
    int _jspx_eval_s_005fhead_005f0 = _jspx_th_s_005fhead_005f0.doStartTag();
    if (_jspx_th_s_005fhead_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody.reuse(_jspx_th_s_005fhead_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhead_005ftheme_005fnobody.reuse(_jspx_th_s_005fhead_005f0);
    return false;
  }

  private boolean _jspx_meth_sx_005fhead_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  sx:head
    org.apache.struts2.dojo.views.jsp.ui.HeadTag _jspx_th_sx_005fhead_005f0 = (org.apache.struts2.dojo.views.jsp.ui.HeadTag) _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody.get(org.apache.struts2.dojo.views.jsp.ui.HeadTag.class);
    _jspx_th_sx_005fhead_005f0.setPageContext(_jspx_page_context);
    _jspx_th_sx_005fhead_005f0.setParent(null);
    // /Byshop.jsp(17,0) name = extraLocales type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fhead_005f0.setExtraLocales("UTF-8");
    int _jspx_eval_sx_005fhead_005f0 = _jspx_th_sx_005fhead_005f0.doStartTag();
    if (_jspx_th_sx_005fhead_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody.reuse(_jspx_th_sx_005fhead_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fsx_005fhead_005fextraLocales_005fnobody.reuse(_jspx_th_sx_005fhead_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005faction_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:action
    org.apache.struts2.views.jsp.ActionTag _jspx_th_s_005faction_005f0 = (org.apache.struts2.views.jsp.ActionTag) _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ActionTag.class);
    _jspx_th_s_005faction_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005faction_005f0.setParent(null);
    // /Byshop.jsp(37,1) name = name type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005faction_005f0.setName("FormAction");
    // /Byshop.jsp(37,1) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005faction_005f0.setId("select");
    int _jspx_eval_s_005faction_005f0 = _jspx_th_s_005faction_005f0.doStartTag();
    if (_jspx_th_s_005faction_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody.reuse(_jspx_th_s_005faction_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005faction_005fname_005fid_005fnobody.reuse(_jspx_th_s_005faction_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005fform_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:form
    org.apache.struts2.views.jsp.ui.FormTag _jspx_th_s_005fform_005f0 = (org.apache.struts2.views.jsp.ui.FormTag) _005fjspx_005ftagPool_005fs_005fform_005faction.get(org.apache.struts2.views.jsp.ui.FormTag.class);
    _jspx_th_s_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fform_005f0.setParent(null);
    // /Byshop.jsp(54,7) name = action type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setAction("ByShopId_con");
    int _jspx_eval_s_005fform_005f0 = _jspx_th_s_005fform_005f0.doStartTag();
    if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_s_005fform_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_s_005fform_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t<div class=\"select\">\r\n");
        out.write("\t\t\t\t\t\t<table style=\"font-size: 10pt\">\r\n");
        out.write("\t\t\t\t\t\t\t<tr>\r\n");
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t<th>");
        if (_jspx_meth_s_005fselect_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t</th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"10px\"></th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"80px\">");
        if (_jspx_meth_s_005ftextfield_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t</th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"10px\"></th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"210px\">开始日期： ");
        if (_jspx_meth_sx_005fdatetimepicker_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"10px\"></th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th width=\"200px\">结束日期：");
        if (_jspx_meth_sx_005fdatetimepicker_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t</th>\r\n");
        out.write("\t\t\t\t\t\t\t\t<th>");
        if (_jspx_meth_sx_005fsubmit_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t</th>\r\n");
        out.write("\t\t\t\t\t\t\t</tr>\r\n");
        out.write("\r\n");
        out.write("\t\t\t\t\t\t</table>\r\n");
        out.write("\t\t\t\t\t</div>\r\n");
        out.write("\t\t\t\t");
        int evalDoAfterBody = _jspx_th_s_005fform_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_s_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fform_005faction.reuse(_jspx_th_s_005fform_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fform_005faction.reuse(_jspx_th_s_005fform_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:select
    org.apache.struts2.views.jsp.ui.SelectTag _jspx_th_s_005fselect_005f0 = (org.apache.struts2.views.jsp.ui.SelectTag) _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody.get(org.apache.struts2.views.jsp.ui.SelectTag.class);
    _jspx_th_s_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /Byshop.jsp(59,12) name = list type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setList("#request.ThemeName");
    // /Byshop.jsp(59,12) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setName("Theme");
    // /Byshop.jsp(59,12) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setId("select1");
    // /Byshop.jsp(59,12) name = cssStyle type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setCssStyle("width:180px");
    int _jspx_eval_s_005fselect_005f0 = _jspx_th_s_005fselect_005f0.doStartTag();
    if (_jspx_th_s_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flist_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005fselect_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f0 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /Byshop.jsp(63,25) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setName("ShopName");
    // /Byshop.jsp(63,25) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setValue("请填写店铺名称");
    int _jspx_eval_s_005ftextfield_005f0 = _jspx_th_s_005ftextfield_005f0.doStartTag();
    if (_jspx_th_s_005ftextfield_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fvalue_005fname_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
    return false;
  }

  private boolean _jspx_meth_sx_005fdatetimepicker_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  sx:datetimepicker
    org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag _jspx_th_sx_005fdatetimepicker_005f0 = (org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag) _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat.get(org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag.class);
    _jspx_th_sx_005fdatetimepicker_005f0.setPageContext(_jspx_page_context);
    _jspx_th_sx_005fdatetimepicker_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /Byshop.jsp(67,32) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f0.setId("bdate");
    // /Byshop.jsp(67,32) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f0.setName("begindate");
    // /Byshop.jsp(67,32) name = toggleType type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f0.setToggleType("explode");
    // /Byshop.jsp(67,32) name = language type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f0.setLanguage("utf-8");
    // /Byshop.jsp(67,32) name = displayFormat type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f0.setDisplayFormat("yyyy-MM-dd");
    int _jspx_eval_sx_005fdatetimepicker_005f0 = _jspx_th_sx_005fdatetimepicker_005f0.doStartTag();
    if (_jspx_eval_sx_005fdatetimepicker_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_sx_005fdatetimepicker_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_sx_005fdatetimepicker_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_sx_005fdatetimepicker_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_sx_005fdatetimepicker_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_sx_005fdatetimepicker_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_sx_005fdatetimepicker_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat.reuse(_jspx_th_sx_005fdatetimepicker_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat.reuse(_jspx_th_sx_005fdatetimepicker_005f0);
    return false;
  }

  private boolean _jspx_meth_sx_005fdatetimepicker_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  sx:datetimepicker
    org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag _jspx_th_sx_005fdatetimepicker_005f1 = (org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag) _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody.get(org.apache.struts2.dojo.views.jsp.ui.DateTimePickerTag.class);
    _jspx_th_sx_005fdatetimepicker_005f1.setPageContext(_jspx_page_context);
    _jspx_th_sx_005fdatetimepicker_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /Byshop.jsp(72,31) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f1.setId("edate");
    // /Byshop.jsp(72,31) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f1.setName("enddate");
    // /Byshop.jsp(72,31) name = toggleType type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f1.setToggleType("explode");
    // /Byshop.jsp(72,31) name = language type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f1.setLanguage("utf-8");
    // /Byshop.jsp(72,31) name = displayFormat type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fdatetimepicker_005f1.setDisplayFormat("yyyy-MM-dd");
    int _jspx_eval_sx_005fdatetimepicker_005f1 = _jspx_th_sx_005fdatetimepicker_005f1.doStartTag();
    if (_jspx_th_sx_005fdatetimepicker_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody.reuse(_jspx_th_sx_005fdatetimepicker_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fsx_005fdatetimepicker_005ftoggleType_005fname_005flanguage_005fid_005fdisplayFormat_005fnobody.reuse(_jspx_th_sx_005fdatetimepicker_005f1);
    return false;
  }

  private boolean _jspx_meth_sx_005fsubmit_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  sx:submit
    org.apache.struts2.dojo.views.jsp.ui.SubmitTag _jspx_th_sx_005fsubmit_005f0 = (org.apache.struts2.dojo.views.jsp.ui.SubmitTag) _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody.get(org.apache.struts2.dojo.views.jsp.ui.SubmitTag.class);
    _jspx_th_sx_005fsubmit_005f0.setPageContext(_jspx_page_context);
    _jspx_th_sx_005fsubmit_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /Byshop.jsp(76,12) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fsubmit_005f0.setValue("查询");
    // /Byshop.jsp(76,12) name = targets type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_sx_005fsubmit_005f0.setTargets("resultshop");
    int _jspx_eval_sx_005fsubmit_005f0 = _jspx_th_sx_005fsubmit_005f0.doStartTag();
    if (_jspx_th_sx_005fsubmit_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody.reuse(_jspx_th_sx_005fsubmit_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fsx_005fsubmit_005fvalue_005ftargets_005fnobody.reuse(_jspx_th_sx_005fsubmit_005f0);
    return false;
  }
}
