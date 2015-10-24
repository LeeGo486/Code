package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class test_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<title>datagrid测试</title>\r\n");
      out.write("<!--  \r\n");
      out.write("\t\t<script type=\"text/javascript\" djConfig=\"parseOnLoad:true,isDebug:false\" src=\"");
      out.print(request.getContextPath());
      out.write("/dojo/dojo.js\">\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"gridx/resources/claro/Gridx.css\" />\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dojo/resources/dojo.css\" />\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dijit/themes/tundra/tundra.css\" />\r\n");
      out.write("\t-->\t\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dojo/resources/dojo.css\" />\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dijit/themes/tundra/tundra.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" djConfig=\"parseOnLoad:true,isDebug:false\" src=\"");
      out.print(request.getContextPath());
      out.write("/dojo/dojo.js\">\r\n");
      out.write("\t\r\n");
      out.write("\t</head>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t//dojo.require(\"dojox.data.JsonRestStore\");\r\n");
      out.write("\t//dojo.require(\"dijit.tree.ForestStoreModel\");\r\n");
      out.write("\tdojo.require(\"dijit.Tree\");\r\n");
      out.write("\tdojo.require(\"dojo.data.ItemFileReadStore\");\r\n");
      out.write("\t\r\n");
      out.write("function init(){\r\n");
      out.write("\t\r\n");
      out.write("\tvar treeData={\r\n");
      out.write("\t\t\t\titems:[\r\n");
      out.write("\t\t\t\t\t{name:'China',type:'one',children:[{_reference:'beijing'}]},\r\n");
      out.write("\t\t\t\t\t{name:'beijing',type:'city'},\r\n");
      out.write("\t\t\t\t\t{name:'USA',type:'one'},\r\n");
      out.write("\t\t\t\t\t{name:'UK',type:'one'}],\r\n");
      out.write("\t\t\t  \tidentifier:'name',\r\n");
      out.write("\t\t\t  \tlabel:'name'};\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t//var store1=new dojo.data.ItemFileReadStore({data:treeData});\r\n");
      out.write("\t\r\n");
      out.write("\tvar menuDataStore = new dojo.data.ItemFileReadStore( {\r\n");
      out.write("\t\t//target : \"/SSH2test/menu.json\",\r\n");
      out.write("\t\t//labelAttribute : \"menuname\"\r\n");
      out.write("\t\tdata:treeData\r\n");
      out.write("\t});\r\n");
      out.write("\t//var treeModel = new dijit.tree.ForestStoreModel( {\r\n");
      out.write("\t\t//store : menuDataStore\r\n");
      out.write("\t\t//deferItemLoadingUntilExpand : true,\r\n");
      out.write("\t\t//rootLabel : \"菜单\"\r\n");
      out.write("\t//});\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\tvar tree = new dijit.Tree( {\r\n");
      out.write("\t\tid : 'tree',\r\n");
      out.write("\t\t//style : 'width:140px;',\r\n");
      out.write("\t\t//persist: false,\r\n");
      out.write("\t\t//openOnClick : true,\r\n");
      out.write("\t\tlabelAttr:\"name\",\r\n");
      out.write("\t\t//model : treeModel\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t store:menuDataStore,\r\n");
      out.write("\t\ttypeAttr:\"type\",\r\n");
      out.write("\t\tquery:{type:'one'}\r\n");
      out.write("\t\t},\r\n");
      out.write("\t\tdojo.byId(\"tree\"));\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tdojo.addOnLoad(init);\r\n");
      out.write("\tfunction openNode(message){\r\n");
      out.write("\t\t\tvar node=message.node;\r\n");
      out.write("\t\t\tif(message.event!=\"toggleOpen\")return;\r\n");
      out.write("\t\t\tconsole.log('click');\r\n");
      out.write("\t}\r\n");
      out.write("\tdojo.subscribe(\"tree\",null,\"openNode\");\r\n");
      out.write("</script>\r\n");
      out.write("\t<body  class=\"tundra\">\r\n");
      out.write("\t\t<div id=\"tree\"></div>\r\n");
      out.write("\t\t\r\n");
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
}
