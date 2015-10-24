package org.apache.jsp.cm.register;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class QueryList_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<head>\r\n");
      out.write("<base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset= GBK \">\r\n");
      out.write("<title>成衣维修登记列表查询</title>\r\n");
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\" charset=\"GBK\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\" charset=\"GBK\"></script>\r\n");
      out.write("\r\n");
      out.write("<script language=\"javascript\" >\r\n");
      out.write("\r\n");
      out.write("//下拉列表选择  店铺编码\r\n");
      out.write("$(function(){\r\n");
      out.write("\t$('#dp').combogrid({\r\n");
      out.write("\t\tpanelWidth:260,\r\n");
      out.write(" \t\tmode:'remote',\r\n");
      out.write("\t\tidField:'depotid',\r\n");
      out.write("\t\ttextField:'dname',\r\n");
      out.write("\t\turl:'rest/getFilterdp/S2',\r\n");
      out.write("\t\tmethod:'post',\r\n");
      out.write("\t \r\n");
      out.write("\t\tcolumns:[[\r\n");
      out.write("\t\t\t{field:'depotid',title:'店铺编号',width:90},\r\n");
      out.write("\t\t\t{field:'dname',title:'店铺名称',width:160},\r\n");
      out.write("\r\n");
      out.write("\t\t]]\r\n");
      out.write("\t});\r\n");
      out.write("});\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("//普通下拉2   店铺类型\r\n");
      out.write("$(function(){\r\n");
      out.write("\t\t\t$('#zt').combobox({\r\n");
      out.write("\t\t\t\turl:'rest/getFilterzt/S1',\r\n");
      out.write("\t\t\t\tmethod:'post',\r\n");
      out.write("\t\t\t\tvalueField:'bh',\r\n");
      out.write("\t\t\t\ttextField:'mc'\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t \r\n");
      out.write("//结果列表\r\n");
      out.write("\t$(function(){\r\n");
      out.write("\t\t$('#operateRecordGrid').datagrid({\r\n");
      out.write("\t\t//\ttitle:'DataGrid - ContextMenu',\r\n");
      out.write("\t\t\ticonCls:'icon-save',\r\n");
      out.write("\t\t\twidth:960,\r\n");
      out.write("\t\t\theight:400,\r\n");
      out.write("\t\t\tnowrap: true,\r\n");
      out.write("\t\t\tautoRowHeight: false,\r\n");
      out.write("\t\t\tstriped: true,\r\n");
      out.write("\t\t\tcollapsible:true,\r\n");
      out.write("\t\t\tloadMsg:'正在努力查找数据……',\r\n");
      out.write("\t\t\t//url:'/gclm/web/maintainregister!execute',\r\n");
      out.write("\t\t\turl:'rest/getList/'+$('#status').attr('value'),\r\n");
      out.write("\t\t\tmethod:'post',\r\n");
      out.write("\t\t\tsingleSelect:true,\r\n");
      out.write("\t\t\tonDblClickRow: function() {\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t    var selected = $('#operateRecordGrid').datagrid('getSelected');\r\n");
      out.write("\t\t\t   \r\n");
      out.write("\t\t\t    \r\n");
      out.write("\t\t\t    if (selected){\r\n");
      out.write("\t\t\t    \t\r\n");
      out.write("\t\t\t    \t\r\n");
      out.write("\t\t\t    \twindow.parent.listDbOnclick(selected.guid,selected.zt);\r\n");
      out.write("\t\t\t  /*\r\n");
      out.write("\t\t\t    \tif(selected.zt==0){\r\n");
      out.write("\t\t\t            window.open(\"cm/register/querydetail_register.jsp?guid=\"+selected.guid+\"&zt=\"+selected.zt);\r\n");
      out.write("\t\t\t    \t}else if(selected.zt==1){\r\n");
      out.write("\t\t\t    \t\twindow.open(\"cm/register/querydetail_pjpd.jsp?guid=\"+selected.guid+\"&zt=\"+selected.zt);\r\n");
      out.write("\t\t\t    \t}\r\n");
      out.write("\t\t\t    \telse if(\"3,4,5\".indexOf(selected.zt)>=0){\r\n");
      out.write("\t\t\t    \t\twindow.open(\"cm/register/querydetail_pjpd2.jsp?guid=\"+selected.guid+\"&zt=\"+selected.zt);\r\n");
      out.write("\t\t\t    \t}\r\n");
      out.write("\t\t\t    \telse {\r\n");
      out.write("\t\t\t    \t\twindow.open(\"cm/register/querydetail_noable.jsp?guid=\"+selected.guid+\"&zt=\"+selected.zt);\r\n");
      out.write("\t\t\t    \t}\r\n");
      out.write("\t\t\t    */\t\r\n");
      out.write("\t\t\t    \r\n");
      out.write("\t\t\t   }\r\n");
      out.write("\t\t\t  }\r\n");
      out.write("\t\t\t    \t\r\n");
      out.write("\t\t\t    \t,\r\n");
      out.write("\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t{field:'dh',title:'维修单号',width:130,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'ydh',title:'运单号',width:100,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'dpbm',title:'店铺编码',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'dpmc',title:'店铺名称',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'kh',title:'款号',width:100,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'zt',title:'状态',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'djsj',title:'登记时间',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'thrq',title:'退回日期',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'gkxm',title:'顾客姓名',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'vipkh',title:'VIP卡号',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'jjcd',title:'紧急程度',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'wxxz1',title:'维修性质1',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'wtd1',title:'问题点1',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'qy1',title:'起因1',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'xxd1',title:'现象点1',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'bwms',title:'部位描述',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'pjpdsj',title:'品检判定时间',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'zbfhBzrq',title:'总部发货时间',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'pdclfs',title:'判定处理方式',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'wxsj',title:'维修时间',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'dppj',title:'店铺满意度',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'thdh',title:'退货单号',width:130,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'posthfhddzbs',title:'POS退货发货单登帐标识',width:140,sortable:true}\r\n");
      out.write("\t\t\t]],\r\n");
      out.write("\t\t\tpagination:true,\r\n");
      out.write("\t\t\trownumbers:true\r\n");
      out.write("\t\t\t   \r\n");
      out.write("        /*    toolbar:[{  \r\n");
      out.write("                id : 'btngjsearch',  \r\n");
      out.write("                text : '搜索',  \r\n");
      out.write("                iconCls : 'icon-search',  \r\n");
      out.write("                handler :searchData,  \r\n");
      out.write("        }]  \r\n");
      out.write("\t\t\t */\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t//$(\"div.datagrid-toolbar\").html(\"查询关键字:<input type='text' />\");\r\n");
      out.write("\t\tvar p = $('#operateRecordGrid').datagrid('getPager');\r\n");
      out.write("\t\t$(p).pagination({\r\n");
      out.write("\t\t\tonBeforeRefresh:function(){\r\n");
      out.write("\t\t\t\talert('before refresh');\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t});\r\n");
      out.write("\t \r\n");
      out.write("\t /*\r\n");
      out.write("    //搜索功能   \r\n");
      out.write("         function reloadgrid (keyword)  {    \r\n");
      out.write("        var queryParams = $('#operateRecordGrid').datagrid('options').queryParams;    \r\n");
      out.write("         queryParams.state = keyword;    \r\n");
      out.write("         $('#operateRecordGrid').datagrid('options').queryParams=queryParams;          \r\n");
      out.write("         $(\"#operateRecordGrid\").datagrid('reload');   \r\n");
      out.write("         \r\n");
      out.write("    } */\r\n");
      out.write("    function searchData(){  \r\n");
      out.write("     \tvar dh,dp,vipkh,     ydh,kh,zt,           dd1,dd2,lx;\r\n");
      out.write("    \t\r\n");
      out.write("    \tdh=document.getElementById(\"dh\").value;\r\n");
      out.write("    \tdp=$('#dp').combobox('getValue');\r\n");
      out.write("    \tvipkh = document.getElementById(\"vipkh\").value;\r\n");
      out.write("    \t\r\n");
      out.write("    \tydh=document.getElementById(\"ydh\").value;\r\n");
      out.write("    \tkh=document.getElementById(\"kh\").value;\r\n");
      out.write("    \tzt=$('#zt').combobox('getValue');\r\n");
      out.write("    \t\r\n");
      out.write("    \tdd1 = $('#dd1').datebox('getValue'); \r\n");
      out.write("    \tdd2=$('#dd2').datebox('getValue');\r\n");
      out.write("    \tlx=$('#lx').combobox('getValue');\r\n");
      out.write("    \t//alert(wxdh+\"===\"+dp+\"====\"+dd1);\r\n");
      out.write("         \r\n");
      out.write("        var query={dh:dh,dp:dp,vipkh:vipkh,    ydh:ydh,kh:kh,zt:zt,           dd1:dd1,dd2:dd2,lx:lx}; //把查询条件拼接成JSON\r\n");
      out.write(" \r\n");
      out.write("        $(\"#operateRecordGrid\").datagrid('options').queryParams=query; //把查询条件赋值给datagrid内部变量\r\n");
      out.write("    \t$(\"#operateRecordGrid\").datagrid('reload'); //重新加载\r\n");
      out.write("       \r\n");
      out.write("         } \r\n");
      out.write(" \r\n");
      out.write("    \r\n");
      out.write("    $(function(){\r\n");
      out.write("        $('#dd1').datebox({\r\n");
      out.write("            formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },\r\n");
      out.write("            parser: function(date){ return new Date(Date.parse(date.replace(/-/g,\"/\"))); }\r\n");
      out.write("            });    \r\n");
      out.write("        })\r\n");
      out.write("    $(function(){\r\n");
      out.write("        $('#dd2').datebox({\r\n");
      out.write("            formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },\r\n");
      out.write("            parser: function(date){ return new Date(Date.parse(date.replace(/-/g,\"/\"))); }\r\n");
      out.write("            });    \r\n");
      out.write("        })\r\n");
      out.write("    \r\n");
      out.write("    </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t<table>\r\n");
      out.write(" \r\n");
      out.write(" <tr>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t</td>\r\n");
      out.write("\r\n");
      out.write("\t<td>\r\n");
      out.write("\t\r\n");
      out.write("\t<div align=\"center\">\r\n");
      out.write("\t<table>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td><input id=\"status\"  type=\"hidden\" value=\"");
      out.print(request.getParameter("status"));
      out.write("\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td>维修单号</td><td>\r\n");
      out.write("\t<input id=\"dh\"  class=\"easyui-validatebox\" validType=\"minLength[0]\"/>\r\n");
      out.write("\t \r\n");
      out.write("\t</td><td>店铺</td><td><select id=\"dp\" name=\"dept\" style=\"width:135px;\"></select></td><td>客户/VIP号</td><td><input id=\"vipkh\"></input></td><td></td></tr>\r\n");
      out.write("\t\r\n");
      out.write("\t<tr><td>运输单号</td><td><input id=\"ydh\"></input></td><td>款号</td><td><input id=\"kh\"></input></td><td>状态</td><td>\r\n");
      out.write("\t<select id=\"zt\" class=\"easyui-combobox\" name=\"state\" style=\"width:135px;\"></select>\r\n");
      out.write("\t</td><td><a id=\"button\" class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-search'\" onclick=\" searchData()\">查询</a></td></tr>\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t<tr><td>登记时间</td><td><input id=\"dd1\"  class=\"easyui-datebox\" style=\"width:135px;\" ></input></td><td>- -</td><td><input id=\"dd2\" class=\"easyui-datebox\" style=\"width:135px;\"></input></td>\r\n");
      out.write("\t<td>店铺类型</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t<select id=\"lx\" class=\"easyui-combobox\" name=\"state\" style=\"width:135px;height: 50px;\" data-options=\"required:true,panelHeight:'auto'\" >\r\n");
      out.write("\t\t<option value=\"0\" selected>全部</option>\r\n");
      out.write("\t\t<option value=\"1\">自营</option>\r\n");
      out.write("\t\t<option value=\"2\">加盟</option>\r\n");
      out.write("\t</select>\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td> ");
      out.write("</tr>\r\n");
      out.write("\t\r\n");
      out.write("\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<br/><br/>\r\n");
      out.write("\t  \r\n");
      out.write("\t<div>\r\n");
      out.write("\t<table id=\"operateRecordGrid\"></table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t<div align=\"right\"></div>\r\n");
      out.write("\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t\r\n");
      out.write("\t<input id=\"path\" type=\"hidden\" value=\"");
      out.print(path);
      out.write("\" />\r\n");
      out.write("\t\r\n");
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
}
