package org.apache.jsp.mr.config;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.hy.mr.mode.UserInfo;
import java.util.*;

public final class acctConfig_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/ecside.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid.release();
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
      out.write("\r\n");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>店铺账期档案维护</title>\r\n");
      out.write("    \r\n");
      out.write("\t\t\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/cmcommon.css\" />\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<script src=\"http://192.168.0.89:8001/MenuClick.aspx\" type=\"text/javascript\" defer=\"defer\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path );
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("  \t<script src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/myjs/authority.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \t$(function(){\r\n");
      out.write("\t\t\t\r\n");
      out.write("  \t\t\t$('#shopInfo').combogrid({\r\n");
      out.write("\t\t\t\tpanelWidth:300,\r\n");
      out.write("\t\t\t\tidField:'depotNo',\r\n");
      out.write("\t\t\t\ttextField:'depotName',\r\n");
      out.write("\t\t\t\turl:$('#path').attr('value')+'/rest/queryDepot/all',\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tcolumns:[[\r\n");
      out.write("\t\t\t\t\t{field:'depotNo',title:'depotNo',width:60},\r\n");
      out.write("\t\t\t\t\t{field:'depotName',title:'depotName',width:120},\r\n");
      out.write("\t\t\t\t\t{field:'depotAddr',title:'depotAddr',width:120}\r\n");
      out.write("\t\t\t\t]],\r\n");
      out.write("\t\t\t\tonSelect:function(record){\r\n");
      out.write("\t\t\t\t\t  getThisPeriodInfo();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t$('#marketComboBox').combobox({\r\n");
      out.write("\t\t\t\turl: $('#path').attr('value')+'/rest/depot/getMarketOption',\r\n");
      out.write("\t\t\t\tvalueField:'id',\r\n");
      out.write("\t\t\t\ttextField:'text',\r\n");
      out.write("\t\t\t\tmultiple:false,\r\n");
      out.write("\t\t\t\tpanelHeight:'auto'//,\r\n");
      out.write("\t\t\t\t//onLoadSuccess: function(){\r\n");
      out.write("\t\t\t\t\t//alert($('#marketID').attr('value'));\r\n");
      out.write("\t\t\t\t//}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t  \t\t$('#bgnContractDate').datebox();\r\n");
      out.write("\t  \t\t$('#endContractDate').datebox();\r\n");
      out.write("  \t\t\tvar deptoNo=$('#afterDepotNo').attr('value');\r\n");
      out.write("  \t\t\tif(deptoNo!=null && deptoNo!=''){\r\n");
      out.write("  \t\t\t\tgetThisPeriodInfoByDepotNo(deptoNo);\r\n");
      out.write("  \t\t\t}\r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\r\n");
      out.write("\tfunction setComboBoxSelect(){\r\n");
      out.write("\t\tvar marketIDs = $('#marketID').attr('value');\r\n");
      out.write("  \t\tif(marketIDs!=null&&marketIDs!=''){\r\n");
      out.write("  \t\t\t$('#marketComboBox').combobox('setValues',marketIDs.split(','));\r\n");
      out.write("  \t\t}else{\r\n");
      out.write("  \t\t\t$('#marketComboBox').combobox('setValue','');\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\tfunction initForm(){\r\n");
      out.write("  \t\tsetComboBoxSelect();\r\n");
      out.write("  \t\tvar rs = $('#result').attr('value');\r\n");
      out.write("  \t\tshowEndPeriodDay();\r\n");
      out.write("  \t\tif(rs>=1){\r\n");
      out.write("  \t\t\tsetSelectValue();\r\n");
      out.write("  \t\t\t//setTimeout('setSelectValue()',500) ;\r\n");
      out.write("  \t\t\twindow.opener.do_submit();\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"操作成功！\");\r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}else if('0'==rs){\r\n");
      out.write("  \t\t\tsetSelectValue();\r\n");
      out.write("  \t\t\t//setTimeout('setSelectValue()',500) ;\r\n");
      out.write("  \t\t\t$.messager.alert(\"提示\",\"操作失败！\");\r\n");
      out.write("  \t\t\treturn;\r\n");
      out.write("  \t\t}else if('modify'==rs){\r\n");
      out.write("  \t\t\tsetSelectValue();\r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction setSelectValue(){\r\n");
      out.write("  \t\t//alert($('#depotName').attr('value')+$('#afterDepotNo').attr('value'));\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setText',$('#depotName').attr('value'));\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr('value'));\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction setSelectValueByIframe(depotNo,depotName){\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setText',depotName);\r\n");
      out.write("  \t\t$('#shopInfo').combogrid('setValue',depotNo);\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction getThisPeriodInfo(){\r\n");
      out.write("\t\t\tvar\tval = $('#shopInfo').combogrid('getValue');\r\n");
      out.write("\t\t\tvar para = new Object();\r\n");
      out.write("\t\t\t$.post(\t$('#path').attr('value')+ '/rest/depot/getAcctPeriodConfig/'+val,para,function(rsp) {\r\n");
      out.write("\t\t\t\tvar datas = eval(\"(\" + rsp + \")\");\r\n");
      out.write("\t\t\t\tif(datas.contractDeductrate==undefined){\r\n");
      out.write("\t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\t//$('#marketName').attr('value',datas.marketName);\r\n");
      out.write("\t\t\t\t\t$('#deductrate').attr('value',datas.contractDeductrate);\r\n");
      out.write("\t\t\t\t\t//$('#acctPeriodFlag').attr('value',datas.acctPeriodFlag);\r\n");
      out.write("\t\t\t\t\t$(\"#acctPeriodFlag option[value=\"+datas.acctPeriodFlag+\"]\").attr(\"selected\", true);\r\n");
      out.write("\t\t\t\t\t$('#endPeriodDay').attr('value',datas.endPeriodDay);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(datas.marketID!=undefined){\r\n");
      out.write("\t\t\t\t\t\t$('#marketID').attr('value',datas.marketID);\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t$('#marketID').attr('value','');\r\n");
      out.write("\t\t\t\t\t\tsetComboBoxSelect();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(datas.costCenter!=undefined){\r\n");
      out.write("\t\t\t\t\t\t$('#costCenter').attr('value',datas.costCenter);\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t$('#costCenter').attr('value','');\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(datas.LADR!=undefined){\r\n");
      out.write("\t\t\t\t\t\t$('#LADR').attr('value',datas.LADR);\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t$('#LADR').attr('value','');\r\n");
      out.write("\t\t\t\t\t}\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(datas.contractMinSales!=undefined){\r\n");
      out.write("\t\t\t\t\t\t$('#contractMinSales').attr('value',datas.contractMinSales);\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t$('#contractMinSales').attr('value','');\r\n");
      out.write("\t\t\t\t\t}\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(datas.contractPromotionInfo!=undefined){\r\n");
      out.write("\t\t\t\t\t\t$('#contractPromotionInfo').attr('value',datas.contractPromotionInfo);\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\t$('#contractPromotionInfo').attr('value','');\r\n");
      out.write("\t\t\t\t\t}\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#bgnContractDate').datebox('setValue',datas.bgnContractDate);\t\r\n");
      out.write("\t\t\t\t\t$('#endContractDate').datebox('setValue',datas.endContractDate);\t\r\n");
      out.write("\t\t\t\t\tshowEndPeriodDay();\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}\t\r\n");
      out.write("\t\t\t}, \"text\").error(\r\n");
      out.write("\t\t\t\t\t\t\tfunction() {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\",\"提交错误了！\");\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction getThisPeriodInfoByDepotNo(depotNo){\r\n");
      out.write("\t\t\tvar\tval = depotNo;\r\n");
      out.write("\t\t\tvar para = new Object();\r\n");
      out.write("\t\t\t$.post(\t$('#path').attr('value')+ '/rest/depot/getAcctPeriodConfig/'+val,para,function(rsp) {\r\n");
      out.write("\t\t\t\tvar datas = eval(\"(\" + rsp + \")\");\r\n");
      out.write("\t\t\t\tif(datas.contractDeductrate==undefined){\r\n");
      out.write("\t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\treturn;\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$('#shopInfo').combogrid('setText',datas.depotName);\r\n");
      out.write("  \t\t\t\t\t$('#shopInfo').combogrid('setValue',datas.depotNo);\r\n");
      out.write("\t\t\t\t\t//$('#marketName').attr('value',datas.marketName);\r\n");
      out.write("\t\t\t\t\t$('#deductrate').attr('value',datas.contractDeductrate);\r\n");
      out.write("\t\t\t\t\t//$('#acctPeriodFlag').attr('value',datas.acctPeriodFlag);\r\n");
      out.write("\t\t\t\t\t$(\"#acctPeriodFlag option[value=\"+datas.acctPeriodFlag+\"]\").attr(\"selected\", true);\r\n");
      out.write("\t\t\t\t\t$('#endPeriodDay').attr('value',datas.endPeriodDay);\r\n");
      out.write("\t\t\t\t\t$('#marketID').attr('value',datas.marketID);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#costCenter').attr('value',datas.costCenter);\r\n");
      out.write("\t\t\t\t\t$('#LADR').attr('value',datas.LADR);\r\n");
      out.write("\t\t\t\t\t$('#contractMinSales').attr('value',datas.contractMinSales);\r\n");
      out.write("\t\t\t\t\t$('#contractPromotionInfo').attr('value',datas.contractPromotionInfo);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#bgnContractDate').datebox('setValue',datas.bgnContractDate);\t\r\n");
      out.write("\t\t\t\t\t$('#endContractDate').datebox('setValue',datas.endContractDate);\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("  \t\t\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\t\t\tshowEndPeriodDay();\r\n");
      out.write("\t\t\t\t\tsetComboBoxSelect();\r\n");
      out.write("\t\t\t\t}\t\r\n");
      out.write("\t\t\t}, \"text\").error(\r\n");
      out.write("\t\t\t\t\t\t\tfunction() {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t$.messager.alert(\"提示\",\"提交错误了！\");\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction save(){\r\n");
      out.write("\t\t\t//var ssoSessionID = $('#ssoSessionID').attr('value');\r\n");
      out.write("\t\t//var authorityFlag = validateMenuAccessAuthority(menuid,ssoSessionID);\r\n");
      out.write("\t\t\t//var menuid = $('#menuID').attr('value');\r\n");
      out.write("\t\t\t//if(validateMenuAccessAuthority(menuid,ssoSessionID)==false){\r\n");
      out.write("\t\t\t//\treturn;\r\n");
      out.write("\t\t\t//}\r\n");
      out.write("\t\t\t//if(validateMenuAccessAuthority()==false){\r\n");
      out.write("\t\t\t//\treturn;\r\n");
      out.write("\t\t\t//}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar shopNo = $('#shopInfo').combogrid('getValue');\r\n");
      out.write("\t\t\tif(shopNo==null || shopNo==''){\r\n");
      out.write("\t\t\t\talert('店铺必须选择正确');\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tif($('#deductrate').attr('value')==null || $('#deductrate').attr('value')==''){\r\n");
      out.write("\t\t\t\talert('合同扣率必须填写');\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tif($('#contractMinSales').attr('value')==null || $('#contractMinSales').attr('value')==''){\r\n");
      out.write("\t\t\t\talert('合同月保底');\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));\r\n");
      out.write("\t\t\tvar marketIDarray = $('#marketComboBox').combobox('getValues');\r\n");
      out.write("\t\t\tvar marketNames = $('#marketComboBox').combobox('getText');\r\n");
      out.write("\t\t\tvar marketIDs=\"\";\r\n");
      out.write("\t\t\tif(marketIDarray.length>0){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tfor(var i=0;i<marketIDarray.length;i++){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tmarketIDs = marketIDs+\",\"+marketIDarray[i];\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tmarketIDs = marketIDs.substring(1,marketIDs.length);\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t$('#marketID').attr('value',marketIDs);\r\n");
      out.write("\t\t\t$('#marketName').attr('value',marketNames);\r\n");
      out.write("\t\t\tdocument.forms[0].submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction showEndPeriodDay(){\r\n");
      out.write("\t\t\tvar acctPeriodFlagValue = $('#acctPeriodFlag').attr('value');\r\n");
      out.write("\t\t\tif(acctPeriodFlagValue=='0'){\r\n");
      out.write("\t\t\t\t$('#endPeriodDay').css(\"display\",\"none\");\r\n");
      out.write("\t\t\t}else if(acctPeriodFlagValue=='1'){\r\n");
      out.write("\t\t\t\t$('#endPeriodDay').css(\"display\",\"block\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"ssoSessionID\" value=\"");
      out.print(userInfo.getSsoSessionID());
      out.write("\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path );
      out.write("\">\r\n");
      out.write("     ");
      if (_jspx_meth_s_005fform_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("     \r\n");
      out.write("    ");
      out.write("\r\n");
      out.write("     \r\n");
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
    // /mr/config/acctConfig.jsp(270,5) name = action type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setAction("/web/acct-config!save");
    // /mr/config/acctConfig.jsp(270,5) name = method type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fform_005f0.setMethod("post");
    // /mr/config/acctConfig.jsp(270,5) name = theme type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
        out.write("     \t");
        if (_jspx_meth_s_005fhidden_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t");
        if (_jspx_meth_s_005fhidden_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t\t");
        if (_jspx_meth_s_005fhidden_005f2(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  \t\t");
        if (_jspx_meth_s_005fhidden_005f3(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t");
        if (_jspx_meth_s_005fhidden_005f4(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t<center>\r\n");
        out.write("     \t<table width=\"100%\" height=\"15%\"  border=\"0\" cellpadding=\"2\" cellspacing=\"1\"\r\n");
        out.write("\t\t\t\tbgcolor=\"#AFC7D6\">\r\n");
        out.write("     \t\t<tr >\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t\t店铺名称：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t\t");
        if (_jspx_meth_s_005fselect_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" \r\n");
        out.write("     \t\t\t</td>\t\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t\t<td colspan=\"2\" class=\"td_text\" align=\"center\">\r\n");
        out.write("     \t\t\t\t<input type=\"button\" value=\"保存\" onclick=\"save()\">\r\n");
        out.write("     \t\t\t\t\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\t<tr>\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t\t成本中心：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t\t");
        if (_jspx_meth_s_005ftextfield_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t   往来单位：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t\t<input id=\"marketComboBox\" type=\"text\" readonly=\"readonly\">\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\t<tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t  合同 开始日期：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t \t");
        if (_jspx_meth_s_005ftextfield_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t  合同结束日期：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t\t");
        if (_jspx_meth_s_005ftextfield_005f2(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t<tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t<font color=\"red\">*</font>  合同 扣率：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t \t");
        if (_jspx_meth_s_005ftextfield_005f3(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t  最后一次实际扣率：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t\t");
        if (_jspx_meth_s_005ftextfield_005f4(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t<tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t  <font color=\"red\">*</font> 合同月保底：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t \t");
        if (_jspx_meth_s_005ftextfield_005f5(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t  合促消费情况：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t\t");
        if (_jspx_meth_s_005ftextfield_005f6(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t<tr>\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t   账期类型：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t \t");
        if (_jspx_meth_s_005fselect_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write(" \r\n");
        out.write("     \t\t\t \r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t<td class=\"td_field\">\r\n");
        out.write("     \t\t\t   截止日期：\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\t<td class=\"td_text\">\r\n");
        out.write("     \t\t\t \t");
        if (_jspx_meth_s_005ftextfield_005f7(_jspx_th_s_005fform_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("     \t\t\t</td>\r\n");
        out.write("     \t\t\r\n");
        out.write("     \t\t\t\r\n");
        out.write("     \t\t</tr>\r\n");
        out.write("     \t\r\n");
        out.write("     \t</table>\r\n");
        out.write("     \t</center>\r\n");
        out.write("     ");
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
    // /mr/config/acctConfig.jsp(271,6) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setId("menuID");
    // /mr/config/acctConfig.jsp(271,6) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f0.setName("menuID");
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
    // /mr/config/acctConfig.jsp(272,6) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f1.setId("depotName");
    // /mr/config/acctConfig.jsp(272,6) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f1.setName("acctConfig.depotName");
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
    // /mr/config/acctConfig.jsp(273,4) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f2.setId("afterDepotNo");
    // /mr/config/acctConfig.jsp(273,4) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f2.setName("afterDepotNo");
    int _jspx_eval_s_005fhidden_005f2 = _jspx_th_s_005fhidden_005f2.doStartTag();
    if (_jspx_th_s_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f2);
    return false;
  }

  private boolean _jspx_meth_s_005fhidden_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f3 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f3.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(274,4) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f3.setId("marketID");
    // /mr/config/acctConfig.jsp(274,4) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f3.setName("acctConfig.marketID");
    int _jspx_eval_s_005fhidden_005f3 = _jspx_th_s_005fhidden_005f3.doStartTag();
    if (_jspx_th_s_005fhidden_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f3);
    return false;
  }

  private boolean _jspx_meth_s_005fhidden_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:hidden
    org.apache.struts2.views.jsp.ui.HiddenTag _jspx_th_s_005fhidden_005f4 = (org.apache.struts2.views.jsp.ui.HiddenTag) _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.HiddenTag.class);
    _jspx_th_s_005fhidden_005f4.setPageContext(_jspx_page_context);
    _jspx_th_s_005fhidden_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(275,6) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f4.setId("marketName");
    // /mr/config/acctConfig.jsp(275,6) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fhidden_005f4.setName("acctConfig.marketName");
    int _jspx_eval_s_005fhidden_005f4 = _jspx_th_s_005fhidden_005f4.doStartTag();
    if (_jspx_th_s_005fhidden_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fhidden_005fname_005fid_005fnobody.reuse(_jspx_th_s_005fhidden_005f4);
    return false;
  }

  private boolean _jspx_meth_s_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:select
    org.apache.struts2.views.jsp.ui.SelectTag _jspx_th_s_005fselect_005f0 = (org.apache.struts2.views.jsp.ui.SelectTag) _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.SelectTag.class);
    _jspx_th_s_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(284,9) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setId("shopInfo");
    // /mr/config/acctConfig.jsp(284,9) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setName("acctConfig.depotNo");
    // /mr/config/acctConfig.jsp(284,9) name = list type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setList("#request.selectList");
    // /mr/config/acctConfig.jsp(284,9) name = listKey type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setListKey("depotName");
    // /mr/config/acctConfig.jsp(284,9) name = listValue type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f0.setListValue("depotNo");
    int _jspx_eval_s_005fselect_005f0 = _jspx_th_s_005fselect_005f0.doStartTag();
    if (_jspx_th_s_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody.reuse(_jspx_th_s_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fselect_005fname_005flistValue_005flistKey_005flist_005fid_005fnobody.reuse(_jspx_th_s_005fselect_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f0 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(299,9) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setId("costCenter");
    // /mr/config/acctConfig.jsp(299,9) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f0.setName("acctConfig.costCenter");
    int _jspx_eval_s_005ftextfield_005f0 = _jspx_th_s_005ftextfield_005f0.doStartTag();
    if (_jspx_th_s_005ftextfield_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f1 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f1.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(318,10) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setId("bgnContractDate");
    // /mr/config/acctConfig.jsp(318,10) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f1.setName("acctConfig.bgnContractDate");
    int _jspx_eval_s_005ftextfield_005f1 = _jspx_th_s_005ftextfield_005f1.doStartTag();
    if (_jspx_th_s_005ftextfield_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f1);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f2 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f2.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(324,9) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f2.setId("endContractDate");
    // /mr/config/acctConfig.jsp(324,9) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f2.setName("acctConfig.endContractDate");
    int _jspx_eval_s_005ftextfield_005f2 = _jspx_th_s_005ftextfield_005f2.doStartTag();
    if (_jspx_th_s_005ftextfield_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f2);
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
    // /mr/config/acctConfig.jsp(334,10) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f3.setId("deductrate");
    // /mr/config/acctConfig.jsp(334,10) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f3.setName("acctConfig.contractDeductrate");
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
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f4 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f4.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(340,9) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f4.setId("LADR");
    // /mr/config/acctConfig.jsp(340,9) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f4.setName("acctConfig.LADR");
    // /mr/config/acctConfig.jsp(340,9) name = readonly type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f4.setReadonly("true");
    int _jspx_eval_s_005ftextfield_005f4 = _jspx_th_s_005ftextfield_005f4.doStartTag();
    if (_jspx_th_s_005ftextfield_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005freadonly_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f4);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f5 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f5.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(350,10) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setId("contractMinSales");
    // /mr/config/acctConfig.jsp(350,10) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f5.setName("acctConfig.contractMinSales");
    int _jspx_eval_s_005ftextfield_005f5 = _jspx_th_s_005ftextfield_005f5.doStartTag();
    if (_jspx_th_s_005ftextfield_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f5);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f6 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f6.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(356,9) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f6.setId("contractPromotionInfo");
    // /mr/config/acctConfig.jsp(356,9) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f6.setName("acctConfig.contractPromotionInfo");
    int _jspx_eval_s_005ftextfield_005f6 = _jspx_th_s_005ftextfield_005f6.doStartTag();
    if (_jspx_th_s_005ftextfield_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f6);
    return false;
  }

  private boolean _jspx_meth_s_005fselect_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:select
    org.apache.struts2.views.jsp.ui.SelectTag _jspx_th_s_005fselect_005f1 = (org.apache.struts2.views.jsp.ui.SelectTag) _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid.get(org.apache.struts2.views.jsp.ui.SelectTag.class);
    _jspx_th_s_005fselect_005f1.setPageContext(_jspx_page_context);
    _jspx_th_s_005fselect_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(365,10) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setId("acctPeriodFlag");
    // /mr/config/acctConfig.jsp(365,10) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setName("acctConfig.acctPeriodFlag");
    // /mr/config/acctConfig.jsp(365,10) name = list type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setList("#request.acctPeriodFlagList");
    // /mr/config/acctConfig.jsp(365,10) name = listKey type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setListKey("code");
    // /mr/config/acctConfig.jsp(365,10) name = listValue type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setListValue("name");
    // /mr/config/acctConfig.jsp(365,10) name = onchange type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fselect_005f1.setOnchange("showEndPeriodDay()");
    int _jspx_eval_s_005fselect_005f1 = _jspx_th_s_005fselect_005f1.doStartTag();
    if (_jspx_eval_s_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_s_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_s_005fselect_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_s_005fselect_005f1.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("  \t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_s_005fselect_005f1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_s_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_s_005fselect_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid.reuse(_jspx_th_s_005fselect_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fselect_005fonchange_005fname_005flistValue_005flistKey_005flist_005fid.reuse(_jspx_th_s_005fselect_005f1);
    return false;
  }

  private boolean _jspx_meth_s_005ftextfield_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:textfield
    org.apache.struts2.views.jsp.ui.TextFieldTag _jspx_th_s_005ftextfield_005f7 = (org.apache.struts2.views.jsp.ui.TextFieldTag) _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.get(org.apache.struts2.views.jsp.ui.TextFieldTag.class);
    _jspx_th_s_005ftextfield_005f7.setPageContext(_jspx_page_context);
    _jspx_th_s_005ftextfield_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/config/acctConfig.jsp(375,10) name = id type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f7.setId("endPeriodDay");
    // /mr/config/acctConfig.jsp(375,10) name = name type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005ftextfield_005f7.setName("acctConfig.endPeriodDay");
    int _jspx_eval_s_005ftextfield_005f7 = _jspx_th_s_005ftextfield_005f7.doStartTag();
    if (_jspx_th_s_005ftextfield_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005ftextfield_005fname_005fid_005fnobody.reuse(_jspx_th_s_005ftextfield_005f7);
    return false;
  }
}
