package org.apache.jsp.cm;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class QCDetermination_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
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
String webContext = request.getContextPath(); 
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>成衣维修品检判定</title>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext );
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext );
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext );
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext );
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext );
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tvar index = 0;\r\n");
      out.write("\t\tfunction addTab(){\r\n");
      out.write("\t\t\tindex++;\r\n");
      out.write("\t\t\t$('#tt').tabs('add',{\r\n");
      out.write("\t\t\t\ttitle:'New Tab ' + index,\r\n");
      out.write("\t\t\t\tcontent:'Tab Body ' + index,\r\n");
      out.write("\t\t\t\ticonCls:'icon-save',\r\n");
      out.write("\t\t\t\tclosable:true,\r\n");
      out.write("\t\t\t\ttools:[{\r\n");
      out.write("\t\t\t\t\ticonCls:'icon-mini-refresh',\r\n");
      out.write("\t\t\t\t\thandler:function(){\r\n");
      out.write("\t\t\t\t\t\talert('refresh');\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}]\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction getSelected(){\r\n");
      out.write("\t\t\tvar tab = $('#tt').tabs('getSelected');\r\n");
      out.write("\t\t\talert('Selected: '+tab.panel('options').title);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction update(){\r\n");
      out.write("\t\t\tindex++;\r\n");
      out.write("\t\t\tvar tab = $('#tt').tabs('getSelected');\r\n");
      out.write("\t\t\t$('#tt').tabs('update', {\r\n");
      out.write("\t\t\t\ttab: tab,\r\n");
      out.write("\t\t\t\toptions:{\r\n");
      out.write("\t\t\t\t\ttitle:'new title'+index,\r\n");
      out.write("\t\t\t\t\ticonCls:'icon-save'\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<h2 align=\"center\">成衣维修</h2>\r\n");
      out.write("\t<div class=\"demo-info\">\r\n");
      out.write("\t\t<div class=\"demo-tip icon-tip\"></div>\r\n");
      out.write("\t\t<div>Tabs are automatically made scrollable when the sum of their width exceeds their container width size.</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t<div style=\"margin:10px 0\">\r\n");
      out.write("\t\t<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-add'\" href=\"javascript:void(0)\" onclick=\"addTab()\">add tab</a>\r\n");
      out.write("\t\t<a class=\"easyui-linkbutton\" href=\"javascript:void(0)\" onclick=\"getSelected()\">getSelected</a>\r\n");
      out.write("\t\t<a class=\"easyui-linkbutton\" href=\"javascript:void(0)\" onclick=\"update()\">Update</a>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t<div id=\"tt\" class=\"easyui-tabs\" data-options=\"tools:'#tab-tools'\" style=\"width:700px;height:250px;\">\r\n");
      out.write("\t\t<div title=\"Tab1\" data-options=\"tools:'#p-tools'\" style=\"padding:20px;\">\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div title=\"Tab2\" data-options=\"closable:true,cache:false,href:'tabs_href_test.html'\" style=\"padding:20px;\">\r\n");
      out.write("\t\t\tThis is Tab2 with close button.\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div title=\"Tab3\" data-options=\"iconCls:'icon-reload',closable:true\" style=\"padding:20px;\">\r\n");
      out.write("\t\t\t<table id=\"test\" class=\"easyui-datagrid\" data-options=\"fit:true\">\r\n");
      out.write("\t\t\t\t<thead>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<th data-options=\"field:'f1',width:60\">field1</th>\r\n");
      out.write("\t\t\t\t\t\t<th data-options=\"field:'f2',width:60\">field2</th>\r\n");
      out.write("\t\t\t\t\t\t<th data-options=\"field:'f3',width:60\">field3</th>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</thead>\r\n");
      out.write("\t\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>d1</td>\r\n");
      out.write("\t\t\t\t\t\t<td>d2</td>\r\n");
      out.write("\t\t\t\t\t\t<td>d3</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>d11</td>\r\n");
      out.write("\t\t\t\t\t\t<td>d21</td>\r\n");
      out.write("\t\t\t\t\t\t<td>d31</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</tbody>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div title=\"Tab4 with iframe\" data-options=\"closable:true\" style=\"overflow:hidden\">\r\n");
      out.write("\t\t\t<iframe scrolling=\"yes\" frameborder=\"0\"  src=\"http://www.jeasyui.com/forum/index.php\" style=\"width:100%;height:100%;\"></iframe>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div title=\"Tab5 with sub tabs\" data-options=\"closable:true,iconCls:'icon-cut'\" style=\"padding:10px;\">\r\n");
      out.write("\t\t\t<div class=\"easyui-tabs\" data-options=\"fit:true,plain:true\">\r\n");
      out.write("\t\t\t\t<div title=\"Title1\" style=\"padding:10px;\">Content 1</div>\r\n");
      out.write("\t\t\t\t<div title=\"Title2\" style=\"padding:10px;\">Content 2</div>\r\n");
      out.write("\t\t\t\t<div title=\"Title3\" style=\"padding:10px;\">Content 3</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\r\n");
      out.write("\t<div id=\"tab-tools\">\r\n");
      out.write("\t\t<a href=\"#\" class=\"easyui-linkbutton\" data-options=\"plain:true,iconCls:'icon-add'\" onclick=\"javascript:alert('add')\"></a>\r\n");
      out.write("\t\t<a href=\"#\" class=\"easyui-linkbutton\" data-options=\"plain:true,iconCls:'icon-save'\" onclick=\"javascript:alert('save')\"></a>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"p-tools\">\r\n");
      out.write("\t\t<a href=\"#\" class=\"icon-mini-add\" onclick=\"alert('add')\"></a>\r\n");
      out.write("\t\t<a href=\"#\" class=\"icon-mini-edit\" onclick=\"alert('edit')\"></a>\r\n");
      out.write("\t\t<a href=\"#\" class=\"icon-mini-refresh\" onclick=\"alert('refresh')\"></a>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
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
