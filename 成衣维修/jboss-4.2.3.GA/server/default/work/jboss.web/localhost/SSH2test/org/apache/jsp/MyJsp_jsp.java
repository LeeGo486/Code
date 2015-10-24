package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class MyJsp_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<html>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<title>testtree,dynamicaddtreenode</title>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dojo/resources/dojo.css\" />\r\n");
      out.write("\t\t<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/dijit/themes/tundra/tundra.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" djConfig=\"parseOnLoad:true,isDebug:false\" src=\"");
      out.print(request.getContextPath());
      out.write("/dojo/dojo.js\">\r\n");
      out.write("\t\t</script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tdojo.require(\"dijit.Tree\");\r\n");
      out.write("\t\tdojo.require(\"dojo.data.ItemFileReadStore\");\r\n");
      out.write("\t\tdojo.require(\"dojox.data.JsonRestStore\");\r\n");
      out.write("\t\tdojo.require(\"dijit.tree.ForestStoreModel\");\r\n");
      out.write("\t\tfunction init(){\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t/**\r\n");
      out.write("\t\t\tvar treeData={\r\n");
      out.write("\t\t\t\titems:[\r\n");
      out.write("\t\t\t\t\t{name:'China',type:'one',children:[{_reference:'beijing'}]},\r\n");
      out.write("\t\t\t\t\t{name:'beijing',type:'city'},\r\n");
      out.write("\t\t\t\t\t{name:'USA',type:'one'},\r\n");
      out.write("\t\t\t\t\t{name:'UK',type:'one'}],\r\n");
      out.write("\t\t\t  \tidentifier:'name',\r\n");
      out.write("\t\t\t  \tlabel:'name'};\r\n");
      out.write("\t\t\tvar store1=new dojo.data.ItemFileReadStore({data:treeData\r\n");
      out.write("\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t*/\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar store1 = new dojox.data.JsonRestStore({target:\"/SSH2test/rest/echo/231\"});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar treeModel = new dijit.tree.ForestStoreModel({\r\n");
      out.write("                     store: store1\r\n");
      out.write("       \t     });\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar _tree=new dijit.Tree({id:'tree',\r\n");
      out.write("\t\t\t\t\t\t\t\t store:store1,\r\n");
      out.write("\t\t\t\t\t\t\t\t query:{type:'one'},\r\n");
      out.write("\t\t\t\t\t\t\t\t labelAttr:\"name\",\r\n");
      out.write("\t\t\t\t\t\t\t\t typeAttr:\"type\"},\r\n");
      out.write("\t\t\t\t\t\t\t\t dojo.byId(\"tree\"));\r\n");
      out.write("\t\t\tconsole.log(store1._getItemsArray()[0].name);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tdojo.addOnLoad(init);\r\n");
      out.write("\t\t/**\r\n");
      out.write("\t\tfunction openNode(message){\r\n");
      out.write("\t\t\tvar node=message.node;\r\n");
      out.write("\t\t\tif(message.event!=\"toggleOpen\")return;\r\n");
      out.write("\t\t\tconsole.log('click');\r\n");
      out.write("\t\t}*/\r\n");
      out.write("\t\t//dojo.subscribe(\"tree\",null,\"openNode\");\r\n");
      out.write("\t\t</script>\r\n");
      out.write("\t</head>\r\n");
      out.write("\t<body class=\"tundra\">\r\n");
      out.write("\t<div id=\"tree\"></div>\r\n");
      out.write("\t</body>\r\n");
      out.write("</html>");
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
