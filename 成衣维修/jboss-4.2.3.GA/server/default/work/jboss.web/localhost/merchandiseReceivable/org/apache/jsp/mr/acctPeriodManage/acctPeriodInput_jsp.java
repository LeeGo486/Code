package org.apache.jsp.mr.acctPeriodManage;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class acctPeriodInput_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody.release();
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
      out.write("    <title>账期录入</title>\r\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("  \t<script src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js\" type=\"text/javascript\"></script>\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \t$(function(){\r\n");
      out.write("\t\t\t\r\n");
      out.write("  \t\t$('#thisPeriodEndDate').datebox();\r\n");
      out.write("  \t\t$('#thisPeriodBgnDate').datebox();\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t$('#shopInfo').combogrid({\r\n");
      out.write("\t\t\t\tpanelWidth:300,\r\n");
      out.write("\t\t\t\tidField:'depotNo',\r\n");
      out.write("\t\t\t\ttextField:'depotName',\r\n");
      out.write("\t\t\t\turl:$('#path').attr('value')+'/rest/queryDepot/acctPeriod/all',\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t\t{field:'depotNo',title:'depotNo',width:60},\r\n");
      out.write("\t\t\t\t\t{field:'depotName',title:'depotName',width:120},\r\n");
      out.write("\t\t\t\t\t{field:'depotAddr',title:'depotAddr',width:120}\r\n");
      out.write("\t\t\t\t]],\r\n");
      out.write("\t\t\t\tonSelect:function(record){\r\n");
      out.write("\t\t\t\t\tvar guid = $('#guid').attr('value');\r\n");
      out.write("\t\t\t\t\tif(guid==null || guid==''){\r\n");
      out.write("\t\t\t\t\t\tgetThisPeriodInfo();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t//setTimeout('setSelectValue()',2000);\r\n");
      out.write("\t\t\t//setSelectValue();\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\tfunction reload(){\r\n");
      out.write("\t\t\t$('#shopInfo').combogrid('grid').datagrid('reload');\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction newInfo(){\r\n");
      out.write("\t\t\t$('#guid').attr('value','');\r\n");
      out.write("\t\t\t$('#acctYear').attr('value','');\r\n");
      out.write("\t\t\t$('#acctMonth').attr('value','');\r\n");
      out.write("\t\t\t$('#depotName').attr('value','');\r\n");
      out.write("\t\t\t//$('#depotName').attr('value','');\r\n");
      out.write("\t\t\t$('#shopInfo').combogrid('setText',$('#depotName').attr(''));\r\n");
      out.write("  \t\t\t$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr(''));\r\n");
      out.write("\t\t\t$('#CDR').attr('value','');\r\n");
      out.write("\t\t\t$('#EDR').attr('value','');\r\n");
      out.write("\t\t\t$('#lastPeriodEndDate').attr('value','');\r\n");
      out.write("\t\t\t$('#thisPeriodBgnDate').datebox('setValue','');\t\r\n");
      out.write("\t\t\t//$('#thisPeriodEndDate').attr('value','');\r\n");
      out.write("\t\t\t$('#thisPeriodEndDate').datebox('setValue','');\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction save(){\r\n");
      out.write("\t\t\t//alert($('#shopInfo').combogrid('getValue'));\r\n");
      out.write("\t\t\t//return;\r\n");
      out.write("\t\t\tif($('#EDR').attr('value')==null || $('#EDR').attr('value')==''){\r\n");
      out.write("\t\t\t\talert('预估扣率不能为空');\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tdocument.forms[0].submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction getThisPeriodInfo(){\r\n");
      out.write("\t\t\tvar val = $('#shopInfo').combogrid('getValue');\r\n");
      out.write("\t\t\tvar para = new Object();\r\n");
      out.write("\t\t\t$.post(\t$('#path').attr('value')+ '/rest/depot/getAcctPeriodInfo/'+val,para,function(rsp) {\r\n");
      out.write("\t\t\t\tvar datas = eval(\"(\" + rsp + \")\");\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(datas.acctMonth==undefined){\r\n");
      out.write("\t\t\t\t\t//$.messager.alert(\"提示\",\"获取不到该店铺上月的账期信息！\");\r\n");
      out.write("\t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\t$('#acctYear').attr('readonly',false);\r\n");
      out.write("\t\t\t\t\t$('#acctMonth').attr('readonly',false);\r\n");
      out.write("\t\t\t\t\t$('#acctYear').attr('value','');\r\n");
      out.write("\t\t\t\t\t$('#acctMonth').attr('value','');\r\n");
      out.write("\t\t\t\t\t$('#thisPeriodBgnDate').datebox('enable');\r\n");
      out.write("\t\t\t\t\t$('#thisPeriodBgnDate').datebox('setValue','');\t\r\n");
      out.write("\t\t\t\t\t$('#lastPeriodEndDate').attr('value','');\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#thisPeriodEndDate').datebox('setValue','');\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#CDR').attr('value','');\r\n");
      out.write("\t\t\t\t\t//$('#acctMonth').attr('readonly',false);\r\n");
      out.write("\t\t\t\t\t//$('#acctMonth').attr('readonly',false);\r\n");
      out.write("\t\t\t\t\t//$('#lastPeriodEndDate').attr('readonly',true);\r\n");
      out.write("\t\t\t\t\t//$('#thisPeriodBgnDate').attr('readonly',false);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\t$('#acctYear').attr('value',datas.acctYear);\r\n");
      out.write("\t\t\t\t\t$('#acctMonth').attr('value',datas.acctMonth);\r\n");
      out.write("\t\t\t\t\t$('#lastPeriodEndDate').attr('value',datas.lastPeriodEndDate);\r\n");
      out.write("\t\t\t\t\tif(datas.thisPeriodBgnDate!=null &&datas.thisPeriodBgnDate!=''){\r\n");
      out.write("\t\t\t\t\t\t//alert(datas.thisPeriodBgnDate);\r\n");
      out.write("\t\t\t\t\t\t//$('#thisPeriodBgnDate').datebox(options).disabled=true;\r\n");
      out.write("\t\t\t\t\t\t$('#thisPeriodBgnDate').datebox('disable');\r\n");
      out.write("\t\t\t\t\t\t$('#thisPeriodBgnDate').datebox('setValue',datas.thisPeriodBgnDate);\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t//$('#thisPeriodBgnDate').datebox();\r\n");
      out.write("\t\t\t\t\t\t$('#thisPeriodBgnDate').datebox('setValue',datas.thisPeriodBgnDate);\r\n");
      out.write("\t\t\t\t\t\t$('#thisPeriodBgnDate').datebox('enable');\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\tgetAcctPeriodEndDate();\r\n");
      out.write("\t\t\t\t}\t\r\n");
      out.write("\t\t\t}, \"text\").error(\r\n");
      out.write("\t\t\t\t\t\t\tfunction() {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\",\"提交错误了！\");\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write(" \t\r\n");
      out.write(" \tfunction initForm(){\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tvar rs = $('#result').attr('value');\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\tif(rs>='1'){\r\n");
      out.write("  \t\t\tsetSelectValue();\r\n");
      out.write("  \t\t\t//setTimeout('setSelectValue()',500) ;\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"操作成功！\");\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}else if('0'==rs){\r\n");
      out.write("  \t\t\tsetSelectValue();\r\n");
      out.write("  \t\t\t//setTimeout('setSelectValue()',500) ;\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"操作失败！\");\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction setSelectValue(){\r\n");
      out.write("  \t\t//alert($('#depotName').attr('value')+$('#afterDepotNo').attr('value'));\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setText',$('#depotName').attr('value'));\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr('value'));\r\n");
      out.write("  \t}\r\n");
      out.write("  \r\n");
      out.write("  \tfunction getAcctPeriodEndDate(){\r\n");
      out.write("  \t\tvar year = $('#acctYear').attr('value');\r\n");
      out.write("  \t\tif(year==null||year==\"\"){\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"请正确填写年月！\");\r\n");
      out.write("  \t\t\t$('#acctMonth').attr('value','');\r\n");
      out.write("  \t\t\treturn\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\tvar month = $('#acctMonth').attr('value');\r\n");
      out.write("\t\tif(year==null||year==\"\"){\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"请正确填写年月！\");\r\n");
      out.write("  \t\t\t$('#acctMonth').attr('value','');\r\n");
      out.write("  \t\t\treturn\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\tvar bgndate = $('#thisPeriodBgnDate').attr('value');\r\n");
      out.write("\t\tif(bgndate==''){\r\n");
      out.write("\t\t\tbgndate = '-1';\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tvar val = $('#shopInfo').combogrid('getValue');\r\n");
      out.write("\t    var para = new Object();\r\n");
      out.write("\t\t$.post(\t$('#path').attr('value')+ '/rest/depot/getAcctPeriodEndDate/'+val+'/'+month+'/'+year+'/'+bgndate,para,function(rsp) {\r\n");
      out.write("\t\t\t$('#thisPeriodEndDate').datebox('setValue',rsp.split(',')[0]);\r\n");
      out.write("\t\t\t$('#CDR').attr('value',rsp.split(',')[1]);\t\t\r\n");
      out.write("\t\t\t$('#EDR').attr('value',rsp.split(',')[1]);\t\t\r\n");
      out.write("\t\t\t}, \"text\").error(\r\n");
      out.write("\t\t\t\t\t\t\tfunction() {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\",\"提交错误了！\");\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("  \t}\r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path );
      out.write("\">\r\n");
      out.write("  \t");
      if (_jspx_meth_s_005fform_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \r\n");
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

  private boolean _jspx_meth_s_005fform_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:form
    org.apache.struts2.views.jsp.ui.FormTag _jspx_th_s_005fform_005f0 = (org.apache.struts2.views.jsp.ui.FormTag) _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction.get(org.apache.struts2.views.jsp.ui.FormTag.class);
    _jspx_th_s_005fform_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fform_005f0.setParent(null);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(192,3) name = action type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setAction("/web/acct-period-input!saveInput");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(192,3) name = method type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setMethod("post");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(192,3) name = theme type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setTheme("simple");
    int _jspx_eval_s_005fform_005f0 = _jspx_th_s_005fform_005f0.doStartTag();
    if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_s_005fform_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_s_005fform_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("  \t\t");
        if (_jspx_meth_s_005fhidden_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t\t");
        if (_jspx_meth_s_005fhidden_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t\t");
        if (_jspx_meth_s_005fhidden_005f2(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t\t<center>\r\n");
        out.write("  \t\t<div>\r\n");
        out.write("  \t\t\t<input type=\"button\" value=\"新建\" onclick=\"newInfo()\">\r\n");
        out.write("  \t\t\t<input type=\"button\" value=\"提交\" onclick=\"save()\">\r\n");
        out.write("  \t\t\t<br>\r\n");
        out.write("  \t\t\t<table >\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\" width=\"100px\">年份：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\" width=\"100px\">");
        if (_jspx_meth_s_005ftextfield_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\" width=\"30px\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\" width=\"100px\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">月份：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">店铺名称：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"> ");
        if (_jspx_meth_s_005fselect_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" <!--   <select id=\"shopInfo\" name=\"dept\" style=\"width:250px;\"></select> -->  </td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">合同扣率：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f2(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">预估扣率：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f3(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">上期结账截止日：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f4(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("  </td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\"></td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t\t<tr>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">本期结账起止：</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f5(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">至</td>\r\n");
        out.write("  \t\t\t\t\t<td align=\"left\">");
        if (_jspx_meth_s_005ftextfield_005f6(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("  \t\t\t\t</tr>\r\n");
        out.write("  \t\t\t</table>\r\n");
        out.write("  \t\t\t\r\n");
        out.write("  \t\t</div>\r\n");
        out.write("  \t\t</center>\r\n");
        out.write("  \t");
        int evalDoAfterBody = _jspx_th_s_005fform_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_s_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction.reuse(_jspx_th_s_005fform_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction.reuse(_jspx_th_s_005fform_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f0 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(193,4) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setId("guid");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(193,4) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setName("acctPeriod.acctPeriodID");
    int _jspx_eval_s_005fhidden_005f0 = _jspx_th_s_005fhidden_005f0.doStartTag();
    if (_jspx_th_s_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005fhidden_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f1 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f1.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(194,4) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f1.setId("depotName");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(194,4) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f1.setName("acctPeriod.depotName");
    int _jspx_eval_s_005fhidden_005f1 = _jspx_th_s_005fhidden_005f1.doStartTag();
    if (_jspx_th_s_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_s_005fhidden_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f2 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f2.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(195,4) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f2.setId("afterDepotNo");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(195,4) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f2.setName("afterDepotNo");
    int _jspx_eval_s_005fhidden_005f2 = _jspx_th_s_005fhidden_005f2.doStartTag();
    if (_jspx_th_s_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f2);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f0 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(204,38) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setId("acctYear");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(204,38) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setName("acctPeriod.acctYear");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(204,38) name = readonly type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setReadonly("true");
    int _jspx_eval_s_005ftextfield_005f0 = _jspx_th_s_005ftextfield_005f0.doStartTag();
    if (_jspx_th_s_005ftextfield_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f1 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f1.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(210,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setId("acctMonth");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(210,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setName("acctPeriod.acctMonth");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(210,24) name = readonly type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setReadonly("true");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(210,24) name = onchange type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setOnchange("getAcctPeriodEndDate()");
    int _jspx_eval_s_005ftextfield_005f1 = _jspx_th_s_005ftextfield_005f1.doStartTag();
    if (_jspx_th_s_005ftextfield_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fonchange_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f1);
    return false;
  }

  private boolean _jspx_meth_s_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:select
    org.apache.struts2.views.jsp.ui.SelectTag _jspx_th_s_005fselect_005f0 = (org.apache.struts2.views.jsp.ui.SelectTag) _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid.get(org.apache.struts2.views.jsp.ui.SelectTag.class);
    _jspx_th_s_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(216,25) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setId("shopInfo");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(216,25) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setName("acctPeriod.depotNo");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(216,25) name = list type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setList("#request.selectList");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(216,25) name = listKey type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setListKey("depotName");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(216,25) name = listValue type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setListValue("depotNo");
    int _jspx_eval_s_005fselect_005f0 = _jspx_th_s_005fselect_005f0.doStartTag();
    if (_jspx_eval_s_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_s_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_s_005fselect_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_s_005fselect_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("  \t\t\t\t\t\t\r\n");
        out.write("  \t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_s_005fselect_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_s_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_s_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid.reuse(_jspx_th_s_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid.reuse(_jspx_th_s_005fselect_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f2 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f2.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(224,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f2.setId("CDR");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(224,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f2.setName("acctPeriod.CDR");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(224,24) name = readonly type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f2.setReadonly("true");
    int _jspx_eval_s_005ftextfield_005f2 = _jspx_th_s_005ftextfield_005f2.doStartTag();
    if (_jspx_th_s_005ftextfield_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f2);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f3 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f3.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(230,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f3.setId("EDR");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(230,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f3.setName("acctPeriod.EDR");
    int _jspx_eval_s_005ftextfield_005f3 = _jspx_th_s_005ftextfield_005f3.doStartTag();
    if (_jspx_th_s_005ftextfield_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f3);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f4 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f4.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(236,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f4.setId("lastPeriodEndDate");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(236,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f4.setName("acctPeriod.lastPeriodEndDate");
    int _jspx_eval_s_005ftextfield_005f4 = _jspx_th_s_005ftextfield_005f4.doStartTag();
    if (_jspx_th_s_005ftextfield_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f4);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f5 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f5.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(242,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setId("thisPeriodBgnDate");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(242,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setName("acctPeriod.thisPeriodBgnDate");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(242,24) name = readonly type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setReadonly("true");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(242,24) name = cssStyle type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setCssStyle("width:140");
    int _jspx_eval_s_005ftextfield_005f5 = _jspx_th_s_005ftextfield_005f5.doStartTag();
    if (_jspx_th_s_005ftextfield_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005ftextfield_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005ftextfield_005f5);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f6 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f6.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/acctPeriodManage/acctPeriodInput.jsp(244,24) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f6.setId("thisPeriodEndDate");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(244,24) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f6.setName("acctPeriod.thisPeriodEndDate");
    // /mr/acctPeriodManage/acctPeriodInput.jsp(244,24) name = cssStyle type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f6.setCssStyle("width:140");
    int _jspx_eval_s_005ftextfield_005f6 = _jspx_th_s_005ftextfield_005f6.doStartTag();
    if (_jspx_th_s_005ftextfield_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005ftextfield_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fcssStyle_005fnobody.reuse(_jspx_th_s_005ftextfield_005f6);
    return false;
  }
}
