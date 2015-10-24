package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody.release();
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, false, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      out = pageContext.getOut();
      _jspx_out = out;

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
      out.write("    <title>分公司费用审批系统用户登录</title>\r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/js/jquery-1.5.2.min.js\"></script>\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print( path);
      out.write("/css/mycommon.css\" />\r\n");
      out.write("  </head>\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  function login(){\r\n");
      out.write("  \t\r\n");
      out.write("  \tif(window.top!=window.self){\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\r\n");
      out.write("  \t\twindow.top.location.href=$('#path').attr('value')+\"/login.do?action=init&username=\"+$('#username').attr('value')+\"&password=\"+$('#password').attr('value');\r\n");
      out.write("  \t}else{\r\n");
      out.write("\t\tvar url = $('#path').attr('value')+'/img/loginafter.png';\r\n");
      out.write("  \t\t$('#buttonImg').attr('src',url);\r\n");
      out.write("  \t\tdocument.forms[0].submit();\r\n");
      out.write("\t}  \t\r\n");
      out.write("  \t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("\r\n");
      out.write("  \r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \tif($('#result').attr('value')=='-1'){\r\n");
      out.write("  \t\talert('用户名或密码错误！');\r\n");
      out.write("  \t\treturn;\r\n");
      out.write("  \t}\r\n");
      out.write("  \tif($('#result').attr('value')=='0'){\r\n");
      out.write("  \t\talert('该用户没有权限！');\r\n");
      out.write("  \t\treturn;\r\n");
      out.write("  \t}\r\n");
      out.write("  \tif($('#result').attr('value')=='-2'){\r\n");
      out.write("  \t\talert('用户登录失效！');\r\n");
      out.write("  \t\treturn;\r\n");
      out.write("  \t}\r\n");
      out.write("  \tif($('#result').attr('value')=='-3'){\r\n");
      out.write("  \t\talert('已经有用户登录，请先注销已登录用户！');\r\n");
      out.write("  \t\treturn;\r\n");
      out.write("  \t}\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function nextInput(inputID){\r\n");
      out.write(" \tif(event.keyCode==13){\r\n");
      out.write(" \t\t$('#'+inputID).focus();\r\n");
      out.write(" \t}\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write(" function do_submit(){\r\n");
      out.write(" \tif(event.keyCode==13){\r\n");
      out.write(" \t\tlogin();\r\n");
      out.write(" \t}\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write("   function mouseonChange(obj){\r\n");
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
      out.write("  <body bgcolor=\"#DCF0FB\" onload=\"initForm()\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result")==null?request.getParameter("result"):request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path );
      out.write("\">\r\n");
      out.write("  \t\r\n");
      out.write("  \t");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      // /index.jsp(85,3) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setAction("/login");
      // /index.jsp(85,3) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setStyleId("loginForm");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  \t\t");
          if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("  \t\r\n");
          out.write("  \t<div style=\"width: 100%;height: 100%\" align=\"center\">\r\n");
          out.write("  \t\r\n");
          out.write("  \t<div style=\"position: relative;width:1024;height: 600;\" align=\"center\">\r\n");
          out.write("  \t\t<div style=\"position: absolute;left: 700;top: 150\" align=\"right\">\r\n");
          out.write("  \t\t<font style=\"font-family:黑体;font-size: 14\">\t 系统编号：ST0502C</font>\r\n");
          out.write("  \t\t</div>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t\t<div style=\"position: absolute;left: 780;top: 430\">\r\n");
          out.write("  \t\t\t<font style=\"font-family:黑体;font-size: 14\">版本V2.0</font>\r\n");
          out.write("  \t\t</div>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t\t<div style=\"position: absolute;left: 220;top: 520\" align=\"center\">\r\n");
          out.write("  \t\t <font style=\"font-family:黑体;font-size: 14\">  Copyright © 2012 HWAYI Investment/elegant prosper Garment. All Rights Reserved. <br />\r\n");
          out.write("  \t\t\t华之毅投资公司/雅莹服装公司 版权所有</font>\r\n");
          out.write("  \t\t</div>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t\t<img alt=\"\" src=\"");
          out.print(path);
          out.write("/img/login2.jpg\" width=\"1024\">\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t\t<div style=\"position: absolute;left: 55%;top: 43%\" >\r\n");
          out.write("  \t\t<table width=\"200\">\r\n");
          out.write("  \t\t\t<tr>\r\n");
          out.write("  \t\t\t\t<td style=\"width: 55;font-size: 13\">用户名：</td>\r\n");
          out.write("  \t\t\t\t<td>\r\n");
          out.write("  \t\t\t\t <input type=\"text\" id=\"username\" name=\"username\" style=\"width:105;font-size: 13\" value=\"\" onkeypress=\"nextInput('password')\"/>\r\n");
          out.write("  \t\t\t\t");
          out.write(" \r\n");
          out.write("  \t\t\t\t\r\n");
          out.write("  \t\t\t\t</td>\r\n");
          out.write("  \t\t\t</tr>\r\n");
          out.write("  \t\t\t\r\n");
          out.write("  \t\t\t<tr>\t\r\n");
          out.write("  \t\t\t\t<td style=\"width: 45;font-size: 13;\" align=\"right\">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>\r\n");
          out.write("  \t\t\t\t\r\n");
          out.write("  \t\t\t\t<td>");
          if (_jspx_meth_html_005fpassword_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("</td>\r\n");
          out.write("  \t\t\t</tr>\r\n");
          out.write("  \t\t\t\r\n");
          out.write("  \t\t\t<tr>\r\n");
          out.write("  \t\t\t\t\r\n");
          out.write("  \t\t\t\t\t<td colspan=\"2\" align=\"center\"><img id=\"buttonImg\" alt=\"\" src=\"");
          out.print(path);
          out.write("/img/loginbefor.png\" onkeypress=\"do_submit()\" onclick=\"login()\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\"> </td>\r\n");
          out.write("  \t\t\t\t\r\n");
          out.write("  \t\t\t</tr>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t\t</table>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \r\n");
          out.write("  \t\t</div>\r\n");
          out.write("  \t\t\r\n");
          out.write("  \t</div>\r\n");
          out.write("  </div>\t\r\n");
          out.write("  \t");
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
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /index.jsp(86,4) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("action");
    // /index.jsp(86,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("init");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fpassword_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:password
    org.apache.struts.taglib.html.PasswordTag _jspx_th_html_005fpassword_005f0 = (org.apache.struts.taglib.html.PasswordTag) _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody.get(org.apache.struts.taglib.html.PasswordTag.class);
    _jspx_th_html_005fpassword_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fpassword_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /index.jsp(120,10) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fpassword_005f0.setStyleId("password");
    // /index.jsp(120,10) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fpassword_005f0.setStyle("width:105;font-size:13");
    // /index.jsp(120,10) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fpassword_005f0.setProperty("password");
    // /index.jsp(120,10) name = onkeypress type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fpassword_005f0.setOnkeypress("do_submit()");
    int _jspx_eval_html_005fpassword_005f0 = _jspx_th_html_005fpassword_005f0.doStartTag();
    if (_jspx_th_html_005fpassword_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody.reuse(_jspx_th_html_005fpassword_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fpassword_005fstyleId_005fstyle_005fproperty_005fonkeypress_005fnobody.reuse(_jspx_th_html_005fpassword_005f0);
    return false;
  }
}
