package org.apache.jsp.cm;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction.release();
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.release();
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
      response.setContentType("text/html; charset=GBK");
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
      out.write("    <title>总部成衣维修登录</title>\r\n");
      out.write("    \r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/cmcommon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/src/jquery.parser.js\"></script>\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \tfunction login(){\r\n");
      out.write("  \t\tvar com = $('#com').attr('value');\r\n");
      out.write("  \t\tif(com==null || com==''){\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"必须选择公司\");\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\tdocument.forms[0].submit();\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction getHistoryCom(){\r\n");
      out.write("  \t\tvar object = new Object();\r\n");
      out.write("  \t\tvar userid = $('#userid').attr('value');\r\n");
      out.write("  \t\tif(userid=='' || userid==null){\r\n");
      out.write("  \t\t\tuserid='-1';\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t$.post(\t$('#webContext').attr('value')+ '/rest/User/getHistoryCom/'+userid,object,function(rsp) {\r\n");
      out.write("\t\t\t\t\t\t\tvar stringArray = rsp.split(',');\r\n");
      out.write("\t\t\t\t\t\t\t$('#com').attr('value',stringArray[0]);\r\n");
      out.write("\t\t\t\t\t\t\t$('#logid').attr('value',stringArray[1]);\r\n");
      out.write("\t\t\t\t\t\t\t//}\r\n");
      out.write("\t\t\t\t\t\t},'text').error(function() {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\",\"网络异常，请联系IT运维！\");\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  \r\n");
      out.write("   function initFrom(){\r\n");
      out.write("       \r\n");
      out.write("       var rs = $('#result').attr('value');\r\n");
      out.write("       if(rs=='0'){\r\n");
      out.write("           alert('用户名或密码不正确！');\r\n");
      out.write("       }\r\n");
      out.write("       setTimeout('getHistoryCom()', 500);\r\n");
      out.write("       \r\n");
      out.write("   }\r\n");
      out.write("  </script>\r\n");
      out.write("  <body onload=\"initFrom()\">\r\n");
      out.write(" \t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write(" \t<input type=\"hidden\" id=\"webContext\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write(" \t");
      //  s:form
      org.apache.struts2.views.jsp.ui.FormTag _jspx_th_s_005fform_005f0 = (org.apache.struts2.views.jsp.ui.FormTag) _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction.get(org.apache.struts2.views.jsp.ui.FormTag.class);
      _jspx_th_s_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_s_005fform_005f0.setParent(null);
      // /cm/login.jsp(64,2) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setId("loginForm");
      // /cm/login.jsp(64,2) name = action type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setAction("/web/login!login");
      // /cm/login.jsp(64,2) name = method type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setMethod("post");
      int _jspx_eval_s_005fform_005f0 = _jspx_th_s_005fform_005f0.doStartTag();
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_s_005fform_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_s_005fform_005f0.doInitBody();
        }
        do {
          out.write("\r\n");
          out.write("    \t");
          if (_jspx_meth_s_005fhidden_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("   \r\n");
          out.write("    <div style=\"position:absolute;  width: 100%;top: 0px; \" align=\"center\">\r\n");
          out.write("    \t \r\n");
          out.write("    \t <center>\r\n");
          out.write("    \t<div style=\"position: relative;width:1024; \" >\r\n");
          out.write("    \t\r\n");
          out.write("   \t\t<img alt=\"\" src=\"");
          out.print(path );
          out.write("/img/loginmain.jpg\">\r\n");
          out.write("   \t\t<div style=\"position:relative; top: -430;left: 320\">\r\n");
          out.write("   \t\t\t<input type=\"text\" id=\"userid\" name=\"userInfo.userid\" width=\"160\" onchange=\"getHistoryCom()\">\r\n");
          out.write("   \t\t</div> \r\n");
          out.write("    \t\r\n");
          out.write("    \t<div style=\"position:relative; top: -400;left: 320\">\r\n");
          out.write("   \t\t\t<input type=\"password\" id=\"password\" name=\"userInfo.password\" width=\"160\">\r\n");
          out.write("   \t\t</div > \r\n");
          out.write("   \t\t<div style=\"position:relative; top: -370;left: 320;\">\r\n");
          out.write("   \t\t\t<select id=\"com\" name=\"userInfo.com\" style=\"width: 160\">\r\n");
          out.write("   \t\t\t\t<option value=\"\"></option>\r\n");
          out.write("   \t\t\t\t<option value=\"雅莹\">雅莹</option>\r\n");
          out.write("   \t\t\t\t<option value=\"贝爱\">贝爱</option>\r\n");
          out.write("   \t\t\t\t<option value=\"纳卉\">纳卉</option>\r\n");
          out.write("   \t\t\t</select>\r\n");
          out.write("   \t\t</div>\r\n");
          out.write("   \t\t<div style=\"position:relative; top: -340;left: 300;\">\r\n");
          out.write("   \t\t\t<img alt=\"\" src=\"");
          out.print(path );
          out.write("/img/loginbutton.jpg\" onclick=\"login();\">\r\n");
          out.write("   \t\t</div>\r\n");
          out.write("   \t\t\r\n");
          out.write("    \t</div>\r\n");
          out.write("    \t</center>\r\n");
          out.write("    </div>\r\n");
          out.write("   \r\n");
          out.write("    \r\n");
          out.write("\t");
          int evalDoAfterBody = _jspx_th_s_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_s_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction.reuse(_jspx_th_s_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fs_005fform_005fmethod_005fid_005faction.reuse(_jspx_th_s_005fform_005f0);
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

  private boolean _jspx_meth_s_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f0 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /cm/login.jsp(65,5) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setId("logid");
    // /cm/login.jsp(65,5) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setName("logid");
    int _jspx_eval_s_005fhidden_005f0 = _jspx_th_s_005fhidden_005f0.doStartTag();
    if (_jspx_th_s_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f0);
    return false;
  }
}
