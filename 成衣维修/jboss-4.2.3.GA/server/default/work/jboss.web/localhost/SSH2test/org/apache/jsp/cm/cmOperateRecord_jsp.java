package org.apache.jsp.cm;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class cmOperateRecord_jsp extends org.apache.jasper.runtime.HttpJspBase
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
String webContext = request.getContextPath();
  String zbguid = request.getParameter("zbguid");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>成衣维修操作记录</title>\r\n");
      out.write("</head>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/SSH2test/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/SSH2test/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/SSH2test/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"/SSH2test/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"/SSH2test/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t$(function(){\r\n");
      out.write("\t\t\t$('#operateRecordGrid').datagrid({\r\n");
      out.write("\t\t\t\ttitle:'成衣维修操作记录',\r\n");
      out.write("\t\t\t\ticonCls:'icon-save',\r\n");
      out.write("\t\t\t\twidth:700,\r\n");
      out.write("\t\t\t\theight:350,\r\n");
      out.write("\t\t\t\tnowrap: true,\r\n");
      out.write("\t\t\t\tautoRowHeight: false,\r\n");
      out.write("\t\t\t\tstriped: true,\r\n");
      out.write("\t\t\t\tcollapsible:true,\r\n");
      out.write("\t\t\t\turl:$('#webContext').attr('value')+ '/rest/queryCMOperateRecord/'+$('#zbguid').attr('value'),\r\n");
      out.write("\t\t\t\tmethod:'post',\r\n");
      out.write("\t\t\t\t//sortName: 'code',\r\n");
      out.write("\t\t\t\t//pageSize:10,\r\n");
      out.write("\t\t\t\tsortOrder: 'desc',\r\n");
      out.write("\t\t\t\tremoteSort: false,\r\n");
      out.write("\t\t\t\t//idField:'code',\r\n");
      out.write("\t\t\t\t//frozenColumns:[[\r\n");
      out.write("\t                //{field:'ck',checkbox:true},\r\n");
      out.write("\t              //  {title:'Code',field:'code',width:80,sortable:true}\r\n");
      out.write("\t\t\t\t//]],\r\n");
      out.write("\t\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t       /* {title:'Base Information',colspan:3},\r\n");
      out.write("\t\t\t\t\t{field:'opt',title:'Operation',width:100,align:'center', rowspan:2,\r\n");
      out.write("\t\t\t\t\t\tformatter:function(value,rec){\r\n");
      out.write("\t\t\t\t\t\t\treturn '<span style=\"color:red\">Edit Delete</span>';\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t],\r\n");
      out.write("\t\t\t\t[*/\r\n");
      out.write("\t\t\t\t\t{field:'guid',title:'主键',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t\t{field:'czbmmc',title:'操作部门',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t\t{field:'czyxm',title:'操作员',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t\t{field:'czsj',title:'操作事件',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t\t{field:'czlx',title:'操作类型',width:120,sortable:true}\r\n");
      out.write("\t\t\t\t\t//{field:'addr',title:'Address',width:220,rowspan:1,sortable:true,\r\n");
      out.write("\t\t\t\t\t\t//sorter:function(a,b){\r\n");
      out.write("\t\t\t\t\t\t//\treturn (a>b?1:-1);\r\n");
      out.write("\t\t\t\t\t\t//}\r\n");
      out.write("\t\t\t\t\t//},\r\n");
      out.write("\t\t\t\t\t//{field:'col4',title:'Col41',width:150,rowspan:2}\r\n");
      out.write("\t\t\t\t]],\r\n");
      out.write("\t\t\t\tpagination:true,\r\n");
      out.write("\t\t\t\trownumbers:true\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t/*toolbar:[{\r\n");
      out.write("\t\t\t\t\tid:'btnadd',\r\n");
      out.write("\t\t\t\t\ttext:'Add',\r\n");
      out.write("\t\t\t\t\ticonCls:'icon-add',\r\n");
      out.write("\t\t\t\t\thandler:function(){\r\n");
      out.write("\t\t\t\t\t\t$('#btnsave').linkbutton('enable');\r\n");
      out.write("\t\t\t\t\t\talert('add')\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t},{\r\n");
      out.write("\t\t\t\t\tid:'btncut',\r\n");
      out.write("\t\t\t\t\ttext:'Cut',\r\n");
      out.write("\t\t\t\t\ticonCls:'icon-cut',\r\n");
      out.write("\t\t\t\t\thandler:function(){\r\n");
      out.write("\t\t\t\t\t\t$('#btnsave').linkbutton('enable');\r\n");
      out.write("\t\t\t\t\t\talert('cut')\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t},'-',{\r\n");
      out.write("\t\t\t\t\tid:'btnsave',\r\n");
      out.write("\t\t\t\t\ttext:'Save',\r\n");
      out.write("\t\t\t\t\tdisabled:true,\r\n");
      out.write("\t\t\t\t\ticonCls:'icon-save',\r\n");
      out.write("\t\t\t\t\thandler:function(){\r\n");
      out.write("\t\t\t\t\t\t$('#btnsave').linkbutton('disable');\r\n");
      out.write("\t\t\t\t\t\talert('save')\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}]*/\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\tvar p = $('#operateRecordGrid').datagrid('getPager');\r\n");
      out.write("\t\t\t$(p).pagination({\r\n");
      out.write("\t\t\t\t/*onSelectPage: function( pageNumber, pageSize ) {\r\n");
      out.write("\t\t\t\t\talert(pageSize);\r\n");
      out.write("\t\t\t\t\tvar grid = $('#datagrid');  \r\n");
      out.write("\t\t\t\t\tvar options = grid.datagrid('getPager').data(\"pagination\").options;  \r\n");
      out.write("\t\t\t\t\tvar curr = options.pageNumber;  \r\n");
      out.write("\t\t\t\t\tvar total = options.total;  \r\n");
      out.write("\t\t\t\t\tvar max = Math.ceil(total/options.pageSize);  \r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t},*/\r\n");
      out.write("\t\t\t\tonBeforeRefresh:function(){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\talert('before refresh');\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("\t<input type=\"hidden\" id=\"zbguid\" value=\"");
      out.print(zbguid);
      out.write("\">\r\n");
      out.write("\t<input type=\"hidden\" id=\"webContext\" value=\"");
      out.print(webContext);
      out.write("\">\r\n");
      out.write("\t<table id=\"operateRecordGrid\"></table>\r\n");
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
