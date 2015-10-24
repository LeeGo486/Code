package org.apache.jsp.expense;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.branch.expense.dojo.UserInfo;

public final class expenseMainFlowInfo_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005frow_005frowId_005frecordKey_005fonmouseover_005fonmouseout_005fondblclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fonmouseover_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005frow_005frowId_005frecordKey_005fonmouseover_005fonmouseout_005fondblclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fonmouseover_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange.release();
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.release();
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.release();
    _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.release();
    _005fjspx_005ftagPool_005fec_005frow_005frowId_005frecordKey_005fonmouseover_005fonmouseout_005fondblclick.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fonmouseover_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.release();
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
      out.write("\r\n");

String path = request.getContextPath();
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info");
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
      out.write("    <title>流程信息</title>\r\n");
      out.write("    \r\n");
      out.write("\t\r\n");
      out.write("\t  \t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/css/mycommon.css\" />\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/myjs/myTime.js\"></script>\r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(request.getContextPath());
      out.write("/ecside/css/ecside_style.css\" />\r\n");
      out.write("\t\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/prototype_mini.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/ecside_msg_utf8_cn.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print(request.getContextPath());
      out.write("/ecside/js/ecside.js\"></script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.print( path);
      out.write("/js/jquery-1.5.2.min.js\"></script>\r\n");
      out.write("\t\t\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  \r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \tvar x = 0;\r\n");
      out.write("  \tvar y = 0;\r\n");
      out.write("  \tfunction getMXInfos(){\r\n");
      out.write("  \t\tvar ecsideObj=ECSideUtil.getGridObj('ecTable');\r\n");
      out.write("\t\tvar selectedRow = ecsideObj.selectedRow;\r\n");
      out.write("\t\tvar recordKey = selectedRow.getAttribute(\"recordKey\");\r\n");
      out.write("\t\tvar keyArray = recordKey.split(',');\t\t\r\n");
      out.write("\t\tvar url = keyArray[1];\r\n");
      out.write("\t\tvar expenseNo = keyArray[0];\r\n");
      out.write("\t\tvar currentUser = keyArray[4];\r\n");
      out.write("\t\twindow.location.href=$('#webcontent').attr('value')+url+'&cashExpenseNo='+expenseNo+'&currentUser='+currentUser;\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction showMsg(obj){\r\n");
      out.write("  \t\tvar recordKey = $(obj).attr(\"recordKey\");\r\n");
      out.write("\t\tvar keyArray = recordKey.split(',');\r\n");
      out.write("\t\tvar expenseNo = keyArray[0];\r\n");
      out.write("\t\tvar xmlhttp;\r\n");
      out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t\t}else{// code for IE6, IE5\r\n");
      out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\tvar msg =xmlhttp.responseText;\r\n");
      out.write("    \t\t\tvar left = x-10;\r\n");
      out.write("    \t\t\tvar top = y+10;\r\n");
      out.write("    \t\t\t$('#showMsg').html(msg);\r\n");
      out.write("    \t\t\t$('#showMsg').css({\"position\": \"absolute\",\"left\":left,\"top\":top,\"display\":\"block\",\"z-index\":\"1\"});\r\n");
      out.write("\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t}\r\n");
      out.write(" \t\t};\r\n");
      out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\txmlhttp.send(\"action=getRecordInfo&expenseNo=\"+expenseNo);\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction hiddenMsg(obj){\r\n");
      out.write("  \t\t$('#showMsg').css({\"display\":\"none\"});\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("\r\n");
      out.write("  \t\r\n");
      out.write("     $(document).ready(function(){\r\n");
      out.write("     \t $(document).mousemove(function(e){\r\n");
      out.write("\t\t\tx=event.clientX;\r\n");
      out.write("\t\t\ty=event.clientY;\r\n");
      out.write("\t\t });\r\n");
      out.write("     \r\n");
      out.write("     }) ;         \r\n");
      out.write("          \r\n");
      out.write("         \r\n");
      out.write("  function mouseonChange(obj){\r\n");
      out.write("      obj.style.cursor='hand';\r\n");
      out.write("  }\r\n");
      out.write(" \r\n");
      out.write("  \r\n");
      out.write("  function mouseoutChange(obj){\r\n");
      out.write("      obj.style.cursor='move';\r\n");
      out.write("      \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \tif($('#result').attr('value')=='1'){\r\n");
      out.write("  \t\talert('操作成功！');\r\n");
      out.write("  \t}\r\n");
      out.write("  \tif($('#result').attr('value')=='0'){\r\n");
      out.write("  \t\talert($('#failExpenseNo').attr('value')+'删除失败！');\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tvar arrayTr = $('#ecTable_table tr');\r\n");
      out.write("\tvar thisTr = arrayTr[1];\r\n");
      out.write("  \tif(arrayTr.length>1){\r\n");
      out.write("\t\r\n");
      out.write("\t\tvar state = $(thisTr).attr('recordKey').split(',')[5];\r\n");
      out.write("\t\tif(state==='F02'){\r\n");
      out.write("  \t\t\t$('#button2').hide();\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t$(\"#applytitle\",parent.document).html(\"待办任务\");\r\n");
      out.write("  \t\r\n");
      out.write("  \t$('#branchApply',parent.document).find('td').each(function(){\r\n");
      out.write("\t\t\tif($(this).attr('id')!='1002-td' && $(this).attr('id')!='1003-td'){\r\n");
      out.write("          \t\t$(this).css({\"font-weight\": \"500\",\"background-color\":\"#E7ECF3\"});\r\n");
      out.write("      \t\t}\r\n");
      out.write("      });\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t$(\"#task\",parent.document).css({\"font-weight\": \"700\",\"background-color\":\"#FFEEDD\"});\r\n");
      out.write("  }\r\n");
      out.write("  \t\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  function deleteBatch(){\r\n");
      out.write("  \t if(validateCheckBox('0')){\r\n");
      out.write("  \t \t $('#action').attr('value','deleteBatch');\r\n");
      out.write("  \t \t document.forms[0].submit();\r\n");
      out.write("  \t }\r\n");
      out.write("  \t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function approveBatch(){\r\n");
      out.write("  \tif(validateCheckBox('1')){\r\n");
      out.write("  \t \t $('#action').attr('value','approveBatch');\r\n");
      out.write("  \t \t document.forms[0].submit();\r\n");
      out.write("  \t }\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function validateCheckBox(operateFlag){\r\n");
      out.write("  \tvar flag = true;\r\n");
      out.write("  \tvar expenseNo = '';\r\n");
      out.write("  \tvar branchName = '';\r\n");
      out.write("  \tvar flowState = '';\r\n");
      out.write("  \tvar CurrentUser = '';\r\n");
      out.write("  \tvar realName = $('#realName').attr('value');\r\n");
      out.write("  \tvar arrayTr = $('#ecTable_table tr');\r\n");
      out.write("  \t\r\n");
      out.write("  \tfor(var i=0;i<arrayTr.length;i++ ){\r\n");
      out.write("\t\tvar thisTr = arrayTr[i];\r\n");
      out.write("\t\tif($(thisTr).find('input').eq(0).attr('checked')){\r\n");
      out.write("\t\t\texpenseNo = expenseNo+','+$(thisTr).attr('recordKey').split(',')[0];\r\n");
      out.write("\t\t\tbranchName = branchName+','+$(thisTr).attr('recordKey').split(',')[3];\r\n");
      out.write("\t\t\tCurrentUser = $(thisTr).attr('recordKey').split(',')[4];\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("  \texpenseNo=expenseNo.substr(1,expenseNo.length-1); \r\n");
      out.write("  \tbranchName=branchName.substr(1,expenseNo.length-1); \r\n");
      out.write("  \tif(expenseNo==''){\r\n");
      out.write("  \t\talert('请选择操作记录');\r\n");
      out.write("  \t\tflag = false;\r\n");
      out.write("  \t}\r\n");
      out.write("  \tif(CurrentUser!=realName){\r\n");
      out.write("  \t\talert('对不起，您不是申请单的当前执行人，无法执行该操作！');\r\n");
      out.write("  \t\tflag = false;\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \t$('#expenseNos').attr('value',expenseNo);\r\n");
      out.write("  \t$('#branchNames').attr('value',branchName);\r\n");
      out.write("  \treturn flag;\r\n");
      out.write("  \t\r\n");
      out.write("  } \r\n");
      out.write("  \r\n");
      out.write("  function searchByExpenseNo(){\r\n");
      out.write(" \tif(event.keyCode==13){\r\n");
      out.write(" \t\twaitDetail();\r\n");
      out.write(" \t\tdocument.forms[0].submit();\r\n");
      out.write(" \t}\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write("  function waitDetail(){\r\n");
      out.write(" \t$('#waitDiv').slideDown('fast');\r\n");
      out.write(" \t$('#mainDiv').slideUp('fast');\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"webcontent\" value=\"");
      out.print(request.getContextPath() );
      out.write("\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"result\" value=\"");
      out.print(request.getAttribute("result") );
      out.write("\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"failExpenseNo\" value=\"");
      out.print(request.getAttribute("failExpenseNo") );
      out.write("\"> \r\n");
      out.write("    \t<input type=\"hidden\" id=\"realName\" value=\"");
      out.print(userInfo.getRealname() );
      out.write("\">\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div id=\"waitDiv\" style=\"position:absolute;top: 0;width: 100%;height: 100;z-index: 1;display: none;\">正在处理，请稍后......</div>\r\n");
      out.write("    \r\n");
      out.write("    \t <div id=\"mainDiv\" style=\"position:absolute;top: 0;width: 100%;height: 100;z-index: -1;display: block;\">\r\n");
      out.write("    \t\r\n");
      out.write("    \t");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      // /expense/expenseMainFlowInfo.jsp(207,5) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setAction("/expenseMainFlow");
      // /expense/expenseMainFlowInfo.jsp(207,5) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setStyleId("expenseMainFlowForm");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fhidden_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t<table >\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" width=\"100\">分公司：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\" width=\"150\">\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("</td>\r\n");
          out.write("    \t\t\t\t\r\n");
          out.write("    \t\t\t\t<td align=\"right\" width=\"100\">申请人：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\"  width=\"150\">");
          if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </td>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" width=\"100\">申请单号：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\"  width=\"150\">");
          if (_jspx_meth_html_005ftext_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </td>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" width=\"100\">审批状态</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\"  width=\"150\">\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005fselect_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" >费用类型：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\"  >\r\n");
          out.write("    \t\t\t\t\t");
          if (_jspx_meth_html_005fselect_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t\t\t</td>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" >起始日期：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\"  >");
          if (_jspx_meth_html_005ftext_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </td>\r\n");
          out.write("    \t\t\t\t<td align=\"right\" >截止日期：</td>\r\n");
          out.write("    \t\t\t\t<td align=\"left\" >");
          if (_jspx_meth_html_005ftext_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </td>\r\n");
          out.write("    \t\t\t\t<td ></td>\r\n");
          out.write("    \t\t\t\t<td >");
          if (_jspx_meth_html_005fbutton_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </td>\r\n");
          out.write("    \t\t\t</tr>\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t</table>\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<hr width=\"90%\" color=\"#E7ECF3\"/>\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t");
if(userInfo.getUserRole().equals("0")){ 
          out.write("\t\r\n");
          out.write("    \t\t <div style=\"height: 20\" align=\"right\">\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fbutton_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t</div>\r\n");
          out.write("    \t\t");
}else{ 
          out.write("\r\n");
          out.write("    \t\t");
          if (_jspx_meth_html_005fbutton_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("    \t\t<br />\r\n");
          out.write("    \t\t");
} 
          out.write("\r\n");
          out.write("    \t\t\r\n");
          out.write("    \t\t<br />\r\n");
          out.write("    \t");
          int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.reuse(_jspx_th_html_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005faction.reuse(_jspx_th_html_005fform_005f0);
      out.write("\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t ");
      if (_jspx_meth_ec_005ftable_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("    \t\r\n");
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

  private boolean _jspx_meth_html_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(208,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("action");
    // /expense/expenseMainFlowInfo.jsp(208,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("action");
    // /expense/expenseMainFlowInfo.jsp(208,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("query");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(209,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setStyleId("expenseNos");
    // /expense/expenseMainFlowInfo.jsp(209,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("expenseNos");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(210,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setStyleId("branchNames");
    // /expense/expenseMainFlowInfo.jsp(210,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f2.setProperty("branchNames");
    int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
    if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(216,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("branchName");
    // /expense/expenseMainFlowInfo.jsp(216,9) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyle("width: 100%;");
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(219,38) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("employee");
    // /expense/expenseMainFlowInfo.jsp(219,38) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyle("width:100%");
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f2 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(221,38) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setProperty("expenseNo");
    // /expense/expenseMainFlowInfo.jsp(221,38) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setStyle("width:100%");
    // /expense/expenseMainFlowInfo.jsp(221,38) name = onkeypress type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setOnkeypress("searchByExpenseNo()");
    int _jspx_eval_html_005ftext_005f2 = _jspx_th_html_005ftext_005f2.doStartTag();
    if (_jspx_th_html_005ftext_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005fproperty_005fonkeypress_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005fselect_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:select
    org.apache.struts.taglib.html.SelectTag _jspx_th_html_005fselect_005f0 = (org.apache.struts.taglib.html.SelectTag) _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange.get(org.apache.struts.taglib.html.SelectTag.class);
    _jspx_th_html_005fselect_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselect_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(224,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setProperty("approveState");
    // /expense/expenseMainFlowInfo.jsp(224,9) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setStyle("width:100%");
    // /expense/expenseMainFlowInfo.jsp(224,9) name = onchange type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f0.setOnchange("document.forms[0].submit()");
    int _jspx_eval_html_005fselect_005f0 = _jspx_th_html_005fselect_005f0.doStartTag();
    if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fselect_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fselect_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("    \t\t\t\t\t\t");
        if (_jspx_meth_html_005foptionsCollection_005f0(_jspx_th_html_005fselect_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_html_005fselect_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fselect_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fselect_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange.reuse(_jspx_th_html_005fselect_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty_005fonchange.reuse(_jspx_th_html_005fselect_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005foptionsCollection_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fselect_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:optionsCollection
    org.apache.struts.taglib.html.OptionsCollectionTag _jspx_th_html_005foptionsCollection_005f0 = (org.apache.struts.taglib.html.OptionsCollectionTag) _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.get(org.apache.struts.taglib.html.OptionsCollectionTag.class);
    _jspx_th_html_005foptionsCollection_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005foptionsCollection_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fselect_005f0);
    // /expense/expenseMainFlowInfo.jsp(225,10) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setName("approveStateList");
    // /expense/expenseMainFlowInfo.jsp(225,10) name = label type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setLabel("label");
    // /expense/expenseMainFlowInfo.jsp(225,10) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f0.setValue("value");
    int _jspx_eval_html_005foptionsCollection_005f0 = _jspx_th_html_005foptionsCollection_005f0.doStartTag();
    if (_jspx_th_html_005foptionsCollection_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fselect_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:select
    org.apache.struts.taglib.html.SelectTag _jspx_th_html_005fselect_005f1 = (org.apache.struts.taglib.html.SelectTag) _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty.get(org.apache.struts.taglib.html.SelectTag.class);
    _jspx_th_html_005fselect_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fselect_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(234,9) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f1.setProperty("expenseTypeCode");
    // /expense/expenseMainFlowInfo.jsp(234,9) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fselect_005f1.setStyle("width:100%");
    int _jspx_eval_html_005fselect_005f1 = _jspx_th_html_005fselect_005f1.doStartTag();
    if (_jspx_eval_html_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fselect_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fselect_005f1.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("    \t\t\t\t\t\t");
        if (_jspx_meth_html_005foptionsCollection_005f1(_jspx_th_html_005fselect_005f1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("    \t\t\t\t\t");
        int evalDoAfterBody = _jspx_th_html_005fselect_005f1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fselect_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fselect_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty.reuse(_jspx_th_html_005fselect_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fselect_005fstyle_005fproperty.reuse(_jspx_th_html_005fselect_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005foptionsCollection_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fselect_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:optionsCollection
    org.apache.struts.taglib.html.OptionsCollectionTag _jspx_th_html_005foptionsCollection_005f1 = (org.apache.struts.taglib.html.OptionsCollectionTag) _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.get(org.apache.struts.taglib.html.OptionsCollectionTag.class);
    _jspx_th_html_005foptionsCollection_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005foptionsCollection_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fselect_005f1);
    // /expense/expenseMainFlowInfo.jsp(235,10) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f1.setName("expenseTypeList");
    // /expense/expenseMainFlowInfo.jsp(235,10) name = label type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f1.setLabel("lable");
    // /expense/expenseMainFlowInfo.jsp(235,10) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005foptionsCollection_005f1.setValue("lableCode");
    int _jspx_eval_html_005foptionsCollection_005f1 = _jspx_th_html_005foptionsCollection_005f1.doStartTag();
    if (_jspx_th_html_005foptionsCollection_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005foptionsCollection_005fvalue_005fname_005flabel_005fnobody.reuse(_jspx_th_html_005foptionsCollection_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f3 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(239,27) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setProperty("queryBgnDate");
    // /expense/expenseMainFlowInfo.jsp(239,27) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setOnclick("setday(this)");
    // /expense/expenseMainFlowInfo.jsp(239,27) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setReadonly(true);
    // /expense/expenseMainFlowInfo.jsp(239,27) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f3.setStyle("width:100%");
    int _jspx_eval_html_005ftext_005f3 = _jspx_th_html_005ftext_005f3.doStartTag();
    if (_jspx_th_html_005ftext_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f4 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(241,26) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setProperty("queryEndDate");
    // /expense/expenseMainFlowInfo.jsp(241,26) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setOnclick("setday(this)");
    // /expense/expenseMainFlowInfo.jsp(241,26) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setReadonly(true);
    // /expense/expenseMainFlowInfo.jsp(241,26) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f4.setStyle("width:100%");
    int _jspx_eval_html_005ftext_005f4 = _jspx_th_html_005ftext_005f4.doStartTag();
    if (_jspx_th_html_005ftext_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f0 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(243,13) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setProperty("button");
    // /expense/expenseMainFlowInfo.jsp(243,13) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setValue("查询");
    // /expense/expenseMainFlowInfo.jsp(243,13) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setOnclick("document.forms[0].submit()");
    // /expense/expenseMainFlowInfo.jsp(243,13) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setStyleClass("btn_search");
    // /expense/expenseMainFlowInfo.jsp(243,13) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setOnmouseover("this.className='btn_search_on'");
    // /expense/expenseMainFlowInfo.jsp(243,13) name = onmouseout type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setOnmouseout("this.className='btn_search'");
    int _jspx_eval_html_005fbutton_005f0 = _jspx_th_html_005fbutton_005f0.doStartTag();
    if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fbutton_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fbutton_005f0.doInitBody();
      }
      do {
        out.write(' ');
        int evalDoAfterBody = _jspx_th_html_005fbutton_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fbutton_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f1 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(254,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setStyleId("button1");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setProperty("button1");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setValue("删除");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setOnclick("deleteBatch()");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setStyleClass("btn_delete1");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setOnmouseover("this.className='btn_delete1_on'");
    // /expense/expenseMainFlowInfo.jsp(254,6) name = onmouseout type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f1.setOnmouseout("this.className='btn_delete1'");
    int _jspx_eval_html_005fbutton_005f1 = _jspx_th_html_005fbutton_005f1.doStartTag();
    if (_jspx_eval_html_005fbutton_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fbutton_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fbutton_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fbutton_005f1.doInitBody();
      }
      do {
        out.write(' ');
        int evalDoAfterBody = _jspx_th_html_005fbutton_005f1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fbutton_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fbutton_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f2 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /expense/expenseMainFlowInfo.jsp(257,6) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setStyleId("button2");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setProperty("button2");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setValue("审核");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setOnclick("approveBatch()");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = styleClass type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setStyleClass("btn_submit");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setOnmouseover("this.className='btn_submit_on'");
    // /expense/expenseMainFlowInfo.jsp(257,6) name = onmouseout type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f2.setOnmouseout("this.className='btn_submit'");
    int _jspx_eval_html_005fbutton_005f2 = _jspx_th_html_005fbutton_005f2.doStartTag();
    if (_jspx_eval_html_005fbutton_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fbutton_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fbutton_005f2.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fbutton_005f2.doInitBody();
      }
      do {
        out.write(' ');
        int evalDoAfterBody = _jspx_th_html_005fbutton_005f2.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fbutton_005f2 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fbutton_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fvalue_005fstyleId_005fstyleClass_005fproperty_005fonmouseover_005fonmouseout_005fonclick.reuse(_jspx_th_html_005fbutton_005f2);
    return false;
  }

  private boolean _jspx_meth_ec_005ftable_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:table
    org.ecside.tag.TableTag _jspx_th_ec_005ftable_005f0 = (org.ecside.tag.TableTag) _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.get(org.ecside.tag.TableTag.class);
    _jspx_th_ec_005ftable_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005ftable_005f0.setParent(null);
    // /expense/expenseMainFlowInfo.jsp(268,6) name = items type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setItems(new String("infolist"));
    // /expense/expenseMainFlowInfo.jsp(268,6) name = var type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setVar("record");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = tableId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setTableId("ecTable");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = useAjax type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setUseAjax("false");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = doPreload type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setDoPreload("false");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = toolbarContent type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setToolbarContent("navigation|pagejump|pagesize|export|extend|status");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = showHeader type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setShowHeader("true");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = width type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setWidth("100%");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = retrieveRowsCallback type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRetrieveRowsCallback("process");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = action type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setAction("expenseMainFlow.do");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = pageSizeList type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setPageSizeList("10,20,30,50");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = rowsDisplayed type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRowsDisplayed("20");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = editable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setEditable("false");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = classic type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setClassic("true");
    // /expense/expenseMainFlowInfo.jsp(268,6) name = filterable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setFilterable("true");
    int[] _jspx_push_body_count_ec_005ftable_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005ftable_005f0 = _jspx_th_ec_005ftable_005f0.doStartTag();
      if (_jspx_eval_ec_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t \r\n");
          out.write("\t\t\t");
          if (_jspx_meth_ec_005frow_005f0(_jspx_th_ec_005ftable_005f0, _jspx_page_context, _jspx_push_body_count_ec_005ftable_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t");
          int evalDoAfterBody = _jspx_th_ec_005ftable_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_ec_005ftable_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005ftable_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005ftable_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005ftable_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005ftable_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.reuse(_jspx_th_ec_005ftable_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005frow_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005ftable_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005ftable_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:row
    org.ecside.tag.RowTag _jspx_th_ec_005frow_005f0 = (org.ecside.tag.RowTag) _005fjspx_005ftagPool_005fec_005frow_005frowId_005frecordKey_005fonmouseover_005fonmouseout_005fondblclick.get(org.ecside.tag.RowTag.class);
    _jspx_th_ec_005frow_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005frow_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005ftable_005f0);
    // /expense/expenseMainFlowInfo.jsp(276,3) name = rowId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setRowId("ecrow");
    // /expense/expenseMainFlowInfo.jsp(276,3) name = recordKey type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setRecordKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.FI_ExpenseNo},${record.FI_Action},${record.FI_FlowState},${record.BranchName},${record.FI_CurrentUser},${record.FI_CurNode}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(276,3) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOndblclick("getMXInfos()");
    // /expense/expenseMainFlowInfo.jsp(276,3) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOnmouseover("mouseonChange(this);");
    // /expense/expenseMainFlowInfo.jsp(276,3) name = onmouseout type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setOnmouseout("mouseoutChange(this);");
    int[] _jspx_push_body_count_ec_005frow_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005frow_005f0 = _jspx_th_ec_005frow_005f0.doStartTag();
      if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_push_body_count_ec_005frow_005f0[0]++;
          _jspx_th_ec_005frow_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_ec_005frow_005f0.doInitBody();
        }
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f0(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f1(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f2(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f3(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f4(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f5(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f6(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f7(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f8(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f9(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t");
          int evalDoAfterBody = _jspx_th_ec_005frow_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_ec_005frow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
          _jspx_push_body_count_ec_005frow_005f0[0]--;
        }
      }
      if (_jspx_th_ec_005frow_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005frow_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005frow_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005frow_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005frow_005frowId_005frecordKey_005fonmouseover_005fonmouseout_005fondblclick.reuse(_jspx_th_ec_005frow_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f0 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(278,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setProperty("_0");
    // /expense/expenseMainFlowInfo.jsp(278,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setTitle("序号");
    // /expense/expenseMainFlowInfo.jsp(278,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${GLOBALROWCOUNT}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    int[] _jspx_push_body_count_ec_005fcolumn_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f0 = _jspx_th_ec_005fcolumn_005f0.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f0.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f1 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f1.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(279,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setProperty("_0");
    // /expense/expenseMainFlowInfo.jsp(279,4) name = alias type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setAlias("选择");
    // /expense/expenseMainFlowInfo.jsp(279,4) name = headerCell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setHeaderCell("checkbox");
    // /expense/expenseMainFlowInfo.jsp(279,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setCell("checkbox");
    // /expense/expenseMainFlowInfo.jsp(279,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setStyle("text-align:center");
    int[] _jspx_push_body_count_ec_005fcolumn_005f1 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f1 = _jspx_th_ec_005fcolumn_005f1.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f1.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005fstyle_005fproperty_005fheaderCell_005fcell_005falias_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f2 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fonmouseover_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f2.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(280,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(280,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setTitle("申请单号");
    // /expense/expenseMainFlowInfo.jsp(280,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setProperty("FI_ExpenseNo");
    // /expense/expenseMainFlowInfo.jsp(280,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setSortable("true");
    // /expense/expenseMainFlowInfo.jsp(280,4) name = onmouseover type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setOnmouseover("");
    int[] _jspx_push_body_count_ec_005fcolumn_005f2 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f2 = _jspx_th_ec_005fcolumn_005f2.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f2[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f2.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f2.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fonmouseover_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f3 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f3.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(281,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(281,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setTitle("分公司");
    // /expense/expenseMainFlowInfo.jsp(281,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setProperty("BranchName");
    // /expense/expenseMainFlowInfo.jsp(281,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f3 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f3 = _jspx_th_ec_005fcolumn_005f3.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f3[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f3.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f3.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f4 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f4.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(282,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(282,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setTitle("费用流程类型");
    // /expense/expenseMainFlowInfo.jsp(282,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setProperty("FI_FlowName");
    // /expense/expenseMainFlowInfo.jsp(282,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f4 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f4 = _jspx_th_ec_005fcolumn_005f4.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f4[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f4.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f4.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f4);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f5 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f5.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(283,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(283,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setTitle("金额");
    // /expense/expenseMainFlowInfo.jsp(283,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setProperty("FI_ExpenseAmount");
    // /expense/expenseMainFlowInfo.jsp(283,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setCell("number");
    // /expense/expenseMainFlowInfo.jsp(283,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setFormat("0.00");
    // /expense/expenseMainFlowInfo.jsp(283,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setStyle("text-align:right;");
    // /expense/expenseMainFlowInfo.jsp(283,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f5 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f5 = _jspx_th_ec_005fcolumn_005f5.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f5[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f5.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f5.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f5);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f6 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f6.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(285,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(285,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setTitle("申请人");
    // /expense/expenseMainFlowInfo.jsp(285,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setProperty("EmployeeName");
    // /expense/expenseMainFlowInfo.jsp(285,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f6 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f6 = _jspx_th_ec_005fcolumn_005f6.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f6[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f6.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f6.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f6);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f7 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f7.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(286,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(286,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setTitle("申请日期");
    // /expense/expenseMainFlowInfo.jsp(286,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setProperty("FI_CreateperTime");
    // /expense/expenseMainFlowInfo.jsp(286,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f7 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f7 = _jspx_th_ec_005fcolumn_005f7.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f7[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f7.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f7.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f7);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f8 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f8.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(287,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(287,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setTitle("当前执行人");
    // /expense/expenseMainFlowInfo.jsp(287,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setProperty("FI_CurrentUser");
    // /expense/expenseMainFlowInfo.jsp(287,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f8 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f8 = _jspx_th_ec_005fcolumn_005f8.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f8[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f8.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f8.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f8);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f9 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f9.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /expense/expenseMainFlowInfo.jsp(289,4) name = tipTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setTipTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${record.Approve_Info_title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    // /expense/expenseMainFlowInfo.jsp(289,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setTitle("流程状态");
    // /expense/expenseMainFlowInfo.jsp(289,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setProperty("FI_FlowStateName");
    // /expense/expenseMainFlowInfo.jsp(289,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setSortable("true");
    int[] _jspx_push_body_count_ec_005fcolumn_005f9 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f9 = _jspx_th_ec_005fcolumn_005f9.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f9[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f9.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f9.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005ftipTitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f9);
    }
    return false;
  }
}
