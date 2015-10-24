package org.apache.jsp.form;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class welcome_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
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
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write("<html> \n");
      out.write("\t<head>\n");
      out.write("\t\t<title>RFID网络订货系统</title>\n");
      out.write("\t\t<link rel=\"shortcut icon\" href=\"../image/logo.ico\" type=\"image/x-icon\">\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"./css/common.css\" type=\"text/css\"></link>\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"./js/jquery-1.7.2.min.js\"></script>\n");
      out.write("\t\t<script type=\"text/javascript\">\n");
      out.write("\t    </script>\n");
      out.write("\t</head>\n");
      out.write("\t<body>\n");
      out.write("\t\t<div id=\"bgcolor\"></div>\n");
      out.write("\t\t<div id=\"bg\">\n");
      out.write("\t\t\t<div id=\"welcome\">\n");
      out.write("\t\t\t\t<div id=\"img\">\n");
      out.write("\t\t\t\t\t<div id=\"greyRFID\" class=\"img\"></div>\n");
      out.write("\t\t\t\t\t<div id=\"blueRFID\" class=\"img\"></div>\n");
      out.write("\t\t\t\t\t<div class=\"clear\"></div>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<div id=\"txt\">请刷用户卡...</div>\n");
      out.write("\t\t\t\t<div id=\"exit\" onclick=\"window.close();\">点击此处退出重新选择</div>\n");
      out.write("\t\t\t\t");
      if (_jspx_meth_html_005fform_005f0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\t\t\t\t<div id=\"rfid\"></div>\n");
      out.write("\t\t\t\t");
 if (request.getAttribute("error") != null) { 
      out.write("\t\n");
      out.write("\t\t\t\t\t<script type=\"text/javascript\">\n");
      out.write("\t\t\t\t\t\talert('");
      out.print(request.getAttribute("error"));
      out.write("');\n");
      out.write("\t\t\t\t\t</script>\n");
      out.write("\t\t\t\t");
}
      out.write("\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t<script type=\"text/javascript\">\n");
      out.write("            $('.img').click(function(){\n");
      out.write("            \t$('.img').css('border','1px solid grey');\n");
      out.write("            \t$(this).css('border','1px solid yellow');\n");
      out.write("            \t$('.img').not(this).hide();\n");
      out.write("            \t$('input').eq(1).val($(this).attr('id'));\n");
      out.write("            \t$('#txt').show();\n");
      out.write("            \t$('#exit').show();\n");
      out.write("            \tif ($(this).attr('id')=='greyRFID') {\n");
      out.write("            \t\t$('#rfid').html(\"<object id='RFIDReader' classid='clsid:0CBD6597-3953-4B88-8C9F-F58B1B023413' codebase='RFID/RFIDREADER.cab'></object>\");\n");
      out.write("            \t} else {\n");
      out.write("            \t\t$('#rfid').html(\"<object id='RFIDReader' classid='clsid:E6A15262-D581-4AA3-98D3-5B9F83920EFE' codebase='RFID/RFIDREADER.cab'></object>\");\n");
      out.write("            \t}\n");
      out.write("            \tclearInterval(getRfidData);\n");
      out.write("            \tsetInterval(getRfidData, 500);\n");
      out.write("            });\n");
      out.write("            \n");
      out.write("            var ischanged = \"\";\n");
      out.write("            function getRfidData() {\n");
      out.write("                //不能用Jquery的方法获取 $(\"#RFIDReader\")\n");
      out.write("                var rfid = (document.getElementById(\"RFIDReader\").CardNum);\n");
      out.write("                if (ischanged == rfid) return;\n");
      out.write("                ischanged = rfid;\n");
      out.write("\n");
      out.write("\t\t\t\t$('input').eq(0).val(ischanged);\n");
      out.write("\t\t\t\tdocument.forms[0].submit();\n");
      out.write("            }\n");
      out.write("\t    </script>\n");
      out.write("\t</body>\n");
      out.write("</html>\n");
      out.write("\n");
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
    org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005faction.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fform_005f0.setParent(null);
    // /form/welcome.jsp(24,4) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fform_005f0.setAction("/welcome");
    int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
    if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("<br/>\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
          return true;
        out.write("<br/>\n");
        out.write("\t\t\t\t");
        int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fform_005faction.reuse(_jspx_th_html_005fform_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fform_005faction.reuse(_jspx_th_html_005fform_005f0);
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
    // /form/welcome.jsp(25,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("username");
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
    // /form/welcome.jsp(26,5) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("type");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }
}
