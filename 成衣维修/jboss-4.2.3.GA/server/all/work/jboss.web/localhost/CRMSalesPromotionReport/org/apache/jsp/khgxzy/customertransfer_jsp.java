package org.apache.jsp.khgxzy;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class customertransfer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid.release();
    _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody.release();
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
      response.setContentType("text/html;charset=GBK");
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
	
	String userid  = request.getParameter("userid");
	String deptid  = request.getParameter("deptid");

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("<title>客户关系转移</title>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset= GBK  \">\r\n");
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
      out.write("<script language=\"javascript\" >\r\n");
      out.write("\r\n");
      out.write("function getdpjl(idField){\r\n");
      out.write("\t\r\n");
      out.write("\t$('#getListjl').combogrid({\r\n");
      out.write("\t\t\tpanelWidth:200,\r\n");
      out.write("\t \t\tmode:'remote',\r\n");
      out.write("\t\t\tidField:'khjlid',\r\n");
      out.write("\t\t\ttextField:'khjlname',  \t\r\n");
      out.write("\t\t\turl:'");
      out.print(path);
      out.write("/getFilterKhjl.action?deptid='+idField,\r\n");
      out.write("\t\t\tmethod:'post',\r\n");
      out.write("\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t{field:'khjlid',title:'编号',width:90},\r\n");
      out.write("\t\t\t\t{field:'khjlname',title:'客户经理',width:90}\r\n");
      out.write("\t\t\t]]\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function getdp(textField){\r\n");
      out.write("\t \r\n");
      out.write("}\r\n");
      out.write("$(function(){\r\n");
      out.write("\t //进入页面初始化\r\n");
      out.write("\t//下拉列表选择  店铺编码\r\n");
      out.write("\t$('#getListzcdp').combogrid({\r\n");
      out.write("\t\tpanelWidth:280,\r\n");
      out.write(" \t\tmode:'remote',\r\n");
      out.write("\t\tidField:'zcdpid',\r\n");
      out.write("\t\ttextField:'zcdp',\r\n");
      out.write("\t\turl:'");
      out.print(path);
      out.write("/getFilterZcdp.action?deptid='+");
      out.print(deptid);
      out.write(",\r\n");
      out.write("\t\tmethod:'post',\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tonChange:function (idField,textField){\r\n");
      out.write("\t\t \r\n");
      out.write("\t\t\t\t//获取客户经理\r\n");
      out.write("\t\t\t \r\n");
      out.write("\t\t\t getdpjl(idField);\r\n");
      out.write("\t\t\t//getdp(textField);\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t },\r\n");
      out.write("\t\tcolumns:[[\r\n");
      out.write("\t\t\t{field:'zcdpid',title:'店铺编号',width:60},\r\n");
      out.write("\t\t\t{field:'zcdp',title:'店铺名称',width:140} \r\n");
      out.write("\t\t]]\r\n");
      out.write("\t});\r\n");
      out.write("\t \r\n");
      out.write("\t //进入页面初始化\r\n");
      out.write("\t//下拉列表选择  店铺编码\r\n");
      out.write("\t$('#getListzrdp').combogrid({\r\n");
      out.write("\t\tpanelWidth:280,\r\n");
      out.write(" \t\tmode:'remote',\r\n");
      out.write("\t\tidField:'zcdpid',\r\n");
      out.write("\t\ttextField:'zcdp',\r\n");
      out.write("\t\turl:'");
      out.print(path);
      out.write("/getFilterZcdp.action?deptid='+");
      out.print(deptid);
      out.write(",\r\n");
      out.write("\t\tmethod:'post',\r\n");
      out.write("\t\tonChange:function (idField){  \r\n");
      out.write("\t\t\t\t$('#getListzrjl').combogrid({\r\n");
      out.write("\t  \t\t\tpanelWidth:200,\r\n");
      out.write("\t  \t \t\tmode:'remote',\r\n");
      out.write("\t  \t\t\tidField:'khjlid',\r\n");
      out.write("\t  \t\t\ttextField:'khjlname',  \t\r\n");
      out.write("\t  \t\t\turl:'");
      out.print(path);
      out.write("/getFilterKhjl.action?deptid='+idField,\r\n");
      out.write("\t  \t\t\tmethod:'post',\r\n");
      out.write("\t  \t\t\tcolumns:[[\r\n");
      out.write("\t  \t\t\t\t{field:'khjlid',title:'编号',width:90},\r\n");
      out.write("\t  \t\t\t\t{field:'khjlname',title:'客户经理',width:90}\r\n");
      out.write("\t  \t\t\t]]\r\n");
      out.write("\t  \t\t});\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t },\r\n");
      out.write("\t\tcolumns:[[\r\n");
      out.write("\t\t\t{field:'zcdpid',title:'店铺编号',width:60},\r\n");
      out.write("\t\t\t{field:'zcdp',title:'店铺名称',width:140} \r\n");
      out.write("\t\t]]\r\n");
      out.write("\t});\r\n");
      out.write("\t \r\n");
      out.write("\t \r\n");
      out.write("\t /*列表查询结果*/\r\n");
      out.write("\t\t$('#operateRecordGrid').datagrid({\r\n");
      out.write("\t\t \ttitle:'请选着要转出的客户',\r\n");
      out.write("\t\t//\ticonCls:'icon-save',\r\n");
      out.write("\t\t\twidth:980,\r\n");
      out.write("\t\t//\theight:450,\r\n");
      out.write("\t\t//\tsingleSelect:true,\r\n");
      out.write("\t\t\tnowrap: true,\r\n");
      out.write("\t\t\tautoRowHeight: false,\r\n");
      out.write("\t\t\tstriped: true,\r\n");
      out.write("\t\t\tcollapsible:true,\r\n");
      out.write("\t\t\tloadMsg:'正在努力查找数据……',\r\n");
      out.write("\t\t\t//url:'/getKhgrid.action',\r\n");
      out.write("\t\t\t//queryParams:query,\r\n");
      out.write("\t\t\tmethod:'post',\r\n");
      out.write("\t\t\ttoolbar:[ \r\n");
      out.write("\t\t\t          { text:'开始转移',     \r\n");
      out.write("\t\t\t\t\t\ticonCls:'icon-redo',     \r\n");
      out.write("\t\t\t\t\t\t\thandler:function(){ \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar zcdpid = $('#getListzcdp').combogrid('getValues');\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar zcjlid = $('#getListjl').combogrid('getValues');\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar zrdpid = $('#getListzrdp').combogrid('getValues');\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar zrjlid = $('#getListzrjl').combogrid('getValues');\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tif(zrdpid==''||zrjlid==''){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t$.messager.alert('Warning','请选折转入店铺和客户经理!'); return;\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar rows = $('#operateRecordGrid').datagrid('getSelections');\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tif (null == rows || rows.length == 0) {  \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t$.messager.alert('Warning','没有选中要转移的客户!'); \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\treturn;  \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar accountnames = [];\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvar accountids = [];\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tfor(var i=0;i<rows.length;i++){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\taccountnames.push(rows[i].accountname);\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\taccountids.push(rows[i].accountid);\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t$.messager.confirm('Confirm','确认马上转移以下客户？<br/>'+accountnames.join(':'),function(r){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tif (r){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t$.ajax({type:'post', \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\turl:'beginTransfer.action', \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\tdata:'zcdpid='+zcdpid+'&zcjlid='+zcjlid+'&zrdpid='+zrdpid+'&zrjlid='+zrjlid+'&accountids='+accountids.join(\";\"), \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\tdataType:'text', \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\tsuccess:function(msg){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\tsearchData();\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\", msg);\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\terror:function(){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t$.messager.alert(\"ok\", \"error\");\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t}  \r\n");
      out.write("\t\t\t          }\r\n");
      out.write("\t\t\t\t\t,{     \r\n");
      out.write("\t\t\t\t\t\ttext:'导入Excel',     \r\n");
      out.write("\t\t\t\t\t\ticonCls:'icon-excel',     \r\n");
      out.write("\t\t\t\t\t\thandler:function(){\r\n");
      out.write("\t\t\t\t\t\t\t$('#export').window('open');\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t    \r\n");
      out.write("\t\t\t\t],\r\n");
      out.write("\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t{field:'ck',checkbox:true},\r\n");
      out.write("\t\t\t\t{field:'zcdpid',title:'转出店铺ID',width:150,hidden:true},\r\n");
      out.write("\t\t\t\t{field:'zcdp',title:'转出店铺',width:150,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'accountid',title:'客户ID',width:80,hidden:true},\r\n");
      out.write("\t\t\t\t{field:'accountid',title:'客户ID',width:80,hidden:true},\r\n");
      out.write("\t\t\t\t{field:'accountname',title:'客户姓名',width:80,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'mobilephone',title:'手机号码',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'vipcode',title:'VIP卡号',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'khjlname',title:'客户经理',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'totalamount',title:'总消费金额',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'maxdate',title:'最近消费日期',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'xfdpid',title:'最近消费店铺ID',width:150,hidden:true},\r\n");
      out.write("\t\t\t\t{field:'xfdp',title:'最近消费店铺',width:150,sortable:true}\r\n");
      out.write("\t\t\t]],\r\n");
      out.write("\t\t\t//pagination:true,   显示分页控件\r\n");
      out.write("\t\t\trownumbers:true\r\n");
      out.write("\t\t});\r\n");
      out.write("\t \r\n");
      out.write("\t \r\n");
      out.write("\t \r\n");
      out.write(" /*通过Excel导入数据列表结果*/\r\n");
      out.write("\t\t$('#ExcelGrid').datagrid({\r\n");
      out.write("\t\t \ttitle:'以下的是您导入Excel判定所能转移的客户，请仔细核对并选择所要转移的数据',\r\n");
      out.write("\t\t\twidth:800,\r\n");
      out.write("\t\t\t////height:450,\r\n");
      out.write("\t\t//\tsingleSelect:true,\r\n");
      out.write("\t\t\tnowrap: true,\r\n");
      out.write("\t\t\tautoRowHeight: false,\r\n");
      out.write("\t\t\tstriped: true,\r\n");
      out.write("\t\t\tcollapsible:true,\r\n");
      out.write("\t\t\tloadMsg:'正在努力查找数据……',\r\n");
      out.write("\t\t\tmethod:'post',\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t//{field:'deptname',title:'店铺名称',width:130,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'ck',checkbox:true},\r\n");
      out.write("\t\t\t\t{field:'zcdpid',title:'转出店铺ID',width:80,hidden:true},\r\n");
      out.write("\t\t\t\t{field:'zcdp',title:'转出店铺',width:100,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'accountid',title:'客户ID',width:60},\r\n");
      out.write("\t\t\t\t{field:'accountname',title:'客户姓名',width:60,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'mobilephone',title:'手机号码',width:90,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'vipcode',title:'VIP卡号',width:70,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'zrdpid',title:'转入店铺ID',width:80},\r\n");
      out.write("\t\t\t\t{field:'zrdp',title:'转入店铺',width:120,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'khjlid',title:'转入客户经理ID',width:80,sortable:true},\r\n");
      out.write("\t\t\t\t{field:'khjlname',title:'转入客户经理',width:80,sortable:true}\r\n");
      out.write("\t\t\t]],\r\n");
      out.write("\t\t\t//pagination:true,   显示分页控件\r\n");
      out.write("\t\t\trownumbers:true\r\n");
      out.write("\t\t});\r\n");
      out.write("\t \r\n");
      out.write("})\r\n");
      out.write("\r\n");
      out.write("//按条件查询\r\n");
      out.write("function searchData(){  \r\n");
      out.write("\r\n");
      out.write("\t var zcdpid = $('#getListzcdp').combogrid('getValues');\r\n");
      out.write("\t var zcjlid = $('#getListjl').combogrid('getValues');\r\n");
      out.write("\t var xm= document.getElementById(\"xm\").value;\r\n");
      out.write("\t var sj= document.getElementById(\"sj\").value;\r\n");
      out.write("\t var kh= document.getElementById(\"kh\").value;\r\n");
      out.write("\t var tj1 = zcdpid==''||zcjlid=='';\r\n");
      out.write("\t var tj2 = xm==''||sj=='';\r\n");
      out.write("\t \r\n");
      out.write("\t  if(tj1&&tj2){\r\n");
      out.write("\t\t  $.messager.alert('Warning','条件一或者条件二至少选择其一!'); return;\r\n");
      out.write("\t  }\r\n");
      out.write("\t$('#form').form('submit', {\r\n");
      out.write("\t\t \r\n");
      out.write("\t\turl : 'getKhgrid.action',\t\t\t\r\n");
      out.write("\t\tsuccess : function(result) { \r\n");
      out.write("\t\t\tif (result != \"\") { \r\n");
      out.write("\t\t\t     dslist = eval (\"(\" + result + \")\");   \r\n");
      out.write("\t\t\t\t $('#operateRecordGrid').datagrid('loadData',dslist); \r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("  });\r\n");
      out.write("    \t\r\n");
      out.write(" } \r\n");
      out.write(" \r\n");
      out.write(" //导入excel\r\n");
      out.write("function fileExport() { //点击确定按钮的时候\r\n");
      out.write("\t$('#uploadexcel').form('submit', {\r\n");
      out.write("\t\turl : 'beginTransferByexcel.action',\t\t\t\r\n");
      out.write("\t\tsuccess : function(result) { \r\n");
      out.write("\t\t\tif (result == \"a\"){\r\n");
      out.write("\t\t\t\t $.messager.alert('Warning','导入失败，原因可能Excel数据格式或类型有误!');\r\n");
      out.write("\t\t\t}else if(result == \"b\"){\r\n");
      out.write("\t\t\t\t  $.messager.alert('Warning','文件数据类型错误，请先将文件解密!');\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\telse  {\r\n");
      out.write("\t\t\t\t dslist = eval (\"(\" + result + \")\");   \r\n");
      out.write("\t\t\t\t $('#ExcelGrid').datagrid('loadData',dslist); \r\n");
      out.write("\t\t\t\t $('#excelok').linkbutton('enable');  \r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("  });\r\n");
      out.write("}\r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write(" function sureTransfer(){\r\n");
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar rows = $('#ExcelGrid').datagrid('getSelections');\r\n");
      out.write("\t\tif (null == rows || rows.length == 0) {  \r\n");
      out.write("\t\t\t$.messager.alert('Warning','没有选中要转移的客户!'); \r\n");
      out.write("\t\t\treturn;  \r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar zcdpid = []; //临时表所需要参数\r\n");
      out.write("\t\tvar zcjlid = [];\r\n");
      out.write("\t\tvar zrdpid = [];\r\n");
      out.write("\t\tvar zrjlid = [];\r\n");
      out.write("\t\tvar accountids = [];\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar accountnames = [];\r\n");
      out.write("\t\tfor(var i=0;i<rows.length;i++){\r\n");
      out.write("\t\t\tzcdpid=[];\r\n");
      out.write("\t\t\tzcjlid = [];\r\n");
      out.write("\t\t\tzrdpid.push(rows[i].zrdpid);\r\n");
      out.write("\t\t\tzrjlid.push(rows[i].khjlid);\r\n");
      out.write("\t\t\taccountnames.push(rows[i].accountname);\r\n");
      out.write("\t\t\taccountids.push(rows[i].accountid);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$.messager.confirm('Confirm','确认马上转移以下客户？<br/>'+accountnames.join(':'),function(r){\r\n");
      out.write("\t\tif (r){\r\n");
      out.write("\t\t\t$.ajax({type:'post', \r\n");
      out.write("\t\t\turl:'beginTransfer.action', \r\n");
      out.write("\t\t\tdata:'zcdpid='+zcdpid.join(\";\")+'&zcjlid='+zcjlid.join(\";\")+'&zrdpid='+zrdpid.join(\";\")+'&zrjlid='+zrjlid.join(\";\")+'&accountids='+accountids.join(\";\"), \r\n");
      out.write("\t\t\tdataType:'text', \r\n");
      out.write("\t\t\tsuccess:function(msg){\r\n");
      out.write("\t\t\t\t//存储过程返回参数\r\n");
      out.write("\t\t\t$.messager.alert(\"提示\", msg);\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\terror:function(){\r\n");
      out.write("\t\t\t$.messager.alert(\"ok\", \"error\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write(" }\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("html,body{\r\n");
      out.write("  _height:100%; _overflow:auto;\r\n");
      out.write("}\r\n");
      out.write("#header,#footer{\r\n");
      out.write(" position:fixed;\r\n");
      out.write("_position:absolute;\r\n");
      out.write(" z-index:1000;\r\n");
      out.write(" width:100%;\r\n");
      out.write(" height:40px;\r\n");
      out.write(" background:window;\r\n");
      out.write(" left:20px;\r\n");
      out.write("}\r\n");
      out.write("#content{background:#ccc;_height:100%;_overflow:auto; position:relative; padding:20px; }\r\n");
      out.write("#header{top:0;}\r\n");
      out.write("#footer{bottom:0; width:500px; float:right;}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div  id=\"header\">\r\n");
      out.write("    <a id=\"button\" class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-search'\" onclick=\"searchData()\">查询</a>\r\n");
      out.write(" </div> \r\n");
      out.write("<table>\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t");
      //  s:form
      org.apache.struts2.views.jsp.ui.FormTag _jspx_th_s_005fform_005f0 = (org.apache.struts2.views.jsp.ui.FormTag) _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid.get(org.apache.struts2.views.jsp.ui.FormTag.class);
      _jspx_th_s_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_s_005fform_005f0.setParent(null);
      // /khgxzy/customertransfer.jsp(345,1) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setId("form");
      // /khgxzy/customertransfer.jsp(345,1) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setName("ff");
      // /khgxzy/customertransfer.jsp(345,1) name = method type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setMethod("post");
      int _jspx_eval_s_005fform_005f0 = _jspx_th_s_005fform_005f0.doStartTag();
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_s_005fform_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_s_005fform_005f0.doInitBody();
        }
        do {
          out.write("  \r\n");
          out.write("\t<div style=\"padding-top: 40\"><!-- align=\"center\" style=\"padding-top: 30\" -->\r\n");
          out.write("\t\t<table>\r\n");
          out.write("\t\t<tr style=\"color: #4682b4;\"><th> 条件一:</th>  </tr>\r\n");
          out.write("\t\t\t<tr><td>转出店铺</td><td><input id=\"getListzcdp\" name=\"zcdp\" class=\"easyui-combogrid\"  style=\"width:160px;\"></input></td>\r\n");
          out.write("\t\t\t<td>客户经理</td><td><input id=\"getListjl\" name=\"jl\" class=\"easyui-combogrid\"  style=\"width:160px;\"></input></td>\r\n");
          out.write("\t\t\t</tr>\r\n");
          out.write("\t\t<tr style=\"color: #4682b4;\"><th>条件二:</th> </tr>\r\n");
          out.write("\t\t<tr>\r\n");
          out.write("\t\t\t<td>客户姓名</td><td><input id=\"xm\" name=\"xm\"  class=\"easyui-validatebox\"  style=\"width:160px;\"></input></td>\r\n");
          out.write("\t\t\t<td>客户手机</td>\t<td><input id=\"sj\" name=\"sj\"   style=\"width:160px;\"></input></td>\r\n");
          out.write("\t\t\t<td>客户卡号</td><td><input id=\"kh\"  name=\"kh\"   style=\"width:160px;\"></input>\r\n");
          out.write("\t\t\t</td></tr>\r\n");
          out.write("\t\t</table>\r\n");
          out.write("\t</div>\r\n");
          out.write("\t");
          out.write("<br/>\r\n");
          out.write("\t  <div style=\"display: none\">\r\n");
          out.write("\t \t<input id=\"path\" type=\"hidden\" value=\"");
          out.print(path);
          out.write("\" />\r\n");
          out.write("\t</div>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
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
        _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid.reuse(_jspx_th_s_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fs_005fform_005fname_005fmethod_005fid.reuse(_jspx_th_s_005fform_005f0);
      out.write("\r\n");
      out.write("\t<div title=\"请选择需要转入的店铺和客户经理\">\r\n");
      out.write("\t <table>\r\n");
      out.write("\t <tr style=\"color: #4682b4;\"><th  colspan=\"2\">请选择需要转入的店铺和客户经理</th></tr>\r\n");
      out.write("\t\t\t<tr><td>转入店铺</td><td><input id=\"getListzrdp\" name=\"zcdp\" class=\"easyui-combogrid\"  style=\"width:160px;\"></input></td>\r\n");
      out.write("\t\t\t<td>客户经理</td><td><input id=\"getListzrjl\" name=\"jl\" class=\"easyui-combogrid\"  style=\"width:160px;\"></input></td>\r\n");
      out.write("\t\t\t</tr> \r\n");
      out.write("\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div>\r\n");
      out.write("\t\t<table id=\"operateRecordGrid\"></table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t</td>\r\n");
      out.write("\r\n");
      out.write("</tr>\r\n");
      out.write("</table> \r\n");
      out.write("  <div id=\"export\" class=\"easyui-window\" title=\"导入转移的客户数据Excel格式\" closed=\"true\" modal=\"true\" shadow=\"true\"  inline =\"true\" modal=\"true\"  minimizable=\"false\" maximizable=\"false\" \r\n");
      out.write("  style=\"width:840px;height:500px;padding-top:30;padding:5px;background: #fafafa;\">  \r\n");
      out.write("            <div class=\"easyui-layout\" fit=\"true\">                   \r\n");
      out.write("               <div region=\"center\" border=\"false\" style=\"padding:10px;background:#fff;border:1px solid #ccc;\" mce_style=\"padding:10px;background:#fff;border:1px solid #ccc;\">                                                     \r\n");
      out.write("                 \r\n");
      out.write("                   <form id=\"uploadexcel\" enctype=\"multipart/form-data\"  action=\"beginTransferByexcel\" method=\"post\">  \r\n");
      out.write("                         ");
      if (_jspx_meth_s_005ffile_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("                    </form>  \r\n");
      out.write("                    \r\n");
      out.write("                    <div>\r\n");
      out.write("\t\t\t\t\t\t<table id=\"ExcelGrid\"></table>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("                </div>  \r\n");
      out.write("                      \r\n");
      out.write("                    <div region=\"south\" border=\"false\" style=\"text-align:right;height:30px;line-height:30px;\">  \r\n");
      out.write("                        <a id=\"excelok\" class=\"easyui-linkbutton\"   href=\"javascript:void(0)\" data-options=\"iconCls:'icon-ok',disabled:true\" onclick=\"sureTransfer()\" >确定</a>  \r\n");
      out.write("                        <a class=\"easyui-linkbutton\" iconCls=\"icon-cancel\" href=\"javascript:void(0)\"   onclick=\"$('#export').window('close');\" >  \r\n");
      out.write("                        取消</a>   \r\n");
      out.write("                    </div>   \r\n");
      out.write("                  \r\n");
      out.write("            </div>   \r\n");
      out.write("        </div> \r\n");
      out.write("\r\n");
      out.write(" </body>\r\n");
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

  private boolean _jspx_meth_s_005ffile_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:file
    org.apache.struts2.views.jsp.ui.FileTag _jspx_th_s_005ffile_005f0 = (org.apache.struts2.views.jsp.ui.FileTag) _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody.get(org.apache.struts2.views.jsp.ui.FileTag.class);
    _jspx_th_s_005ffile_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005ffile_005f0.setParent(null);
    // /khgxzy/customertransfer.jsp(394,25) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ffile_005f0.setName("excelFile");
    // /khgxzy/customertransfer.jsp(394,25) name = onchange type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ffile_005f0.setOnchange("fileExport()");
    int _jspx_eval_s_005ffile_005f0 = _jspx_th_s_005ffile_005f0.doStartTag();
    if (_jspx_th_s_005ffile_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody.reuse(_jspx_th_s_005ffile_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ffile_005fonchange_005fname_005fnobody.reuse(_jspx_th_s_005ffile_005f0);
    return false;
  }
}
