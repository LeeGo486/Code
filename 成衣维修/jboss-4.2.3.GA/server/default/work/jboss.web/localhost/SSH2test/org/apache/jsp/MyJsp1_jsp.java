package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class MyJsp1_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
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
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>测试</title>\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dojo/resources/dojo.css\" />\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dijit/themes/tundra/tundra.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" djConfig=\"parseOnLoad:true,isDebug:false\" src=\"");
      out.print(request.getContextPath());
      out.write("/dojo/dojo.js\" />\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \tdojo.require(\"dojox.data.JsonRestStore\");\r\n");
      out.write("\tdojo.require(\"dijit.tree.ForestStoreModel\");\r\n");
      out.write("\tdojo.require(\"dijit.Tree\");\r\n");
      out.write("  \tvar booksDataStore = new dojox.data.JsonRestStore({\r\n");
      out.write("  \t\ttarget:\"/SSH2test/org/hy/action/JsonRestStoreTree!getSubjectList \",\r\n");
      out.write("\t\tlabelAttribute:\"name\"});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\tvar treeModel = new dijit.tree.ForestStoreModel({\r\n");
      out.write("                     store: booksDataStore,\r\n");
      out.write("                     deferItemLoadingUntilExpand: true,\r\n");
      out.write("                     rootLabel: \"Subjects\",\r\n");
      out.write("                     childrenAttrs: [\"children\"]\r\n");
      out.write("       \t     });\r\n");
      out.write("            \r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("\t\t<div dojoType=\"dijit.Tree\" model=\"booksDataStore\" \tpersist=\"false\" id=\"booksDataTree\" />\r\n");
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
}
