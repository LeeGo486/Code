package org.apache.jsp.vipConsumeAnalysis;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class vipLevelContributeAnalysis_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/ecside.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhtml;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005ftable_005fxlsFileName_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftitle_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fextendrow_005flocation;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005frow_005frecordKey;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fhtml = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005ftable_005fxlsFileName_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftitle_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fextendrow_005flocation = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fhtml.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick.release();
    _005fjspx_005ftagPool_005fec_005ftable_005fxlsFileName_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftitle_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.release();
    _005fjspx_005ftagPool_005fec_005fextendrow_005flocation.release();
    _005fjspx_005ftagPool_005fec_005frow_005frecordKey.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005fvalue_005ftitle_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.release();
    _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.release();
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
      out.write("\r\n");
      out.write("\r\n");
      //  html:html
      org.apache.struts.taglib.html.HtmlTag _jspx_th_html_005fhtml_005f0 = (org.apache.struts.taglib.html.HtmlTag) _005fjspx_005ftagPool_005fhtml_005fhtml.get(org.apache.struts.taglib.html.HtmlTag.class);
      _jspx_th_html_005fhtml_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fhtml_005f0.setParent(null);
      int _jspx_eval_html_005fhtml_005f0 = _jspx_th_html_005fhtml_005f0.doStartTag();
      if (_jspx_eval_html_005fhtml_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\r\n");
          out.write("<title>VIP等级贡献分析表</title>\r\n");
          out.write("\r\n");
          out.write("<head>\r\n");
          out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../ecside/css/ecside_style.css\" />\r\n");
          out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../ecside/calendar/calendar-blue.css\" />\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/js/prototype_mini.js\"></script>\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/js/ecside_msg_utf8_cn.js\"></script>\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/js/ecside.js\"></script>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/calendar/calendar.js\"></script>\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/calendar/calendar-cn-utf8.js\"></script>\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\"../ecside/calendar/calendar-setup.js\"></script>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<script language=\"javascript\" src=\"../myjs/myTime.js\"></script>\r\n");
          out.write("\t\t\r\n");
          out.write("</head>\r\n");
          out.write("<script type=\"text/javascript\">\r\n");
          out.write("\tvar xmlhttp;\r\n");
          out.write("\t\r\n");
          out.write("\tfunction showOrg(){\r\n");
          out.write("\t\t var loginDeptID = document.getElementById(\"loginDeptID\").value;\r\n");
          out.write("\t\t window.open(\"../orgmutilchecktree.jsp?loginDeptID=\"+loginDeptID, \"选择单位\", \"scrollbars=yes,width=400px,height=400px;\"); \r\n");
          out.write("\t}\r\n");
          out.write("\r\n");
          out.write("\tfunction setOrg(deptname,deptid){\r\n");
          out.write("\t\tdocument.getElementById(\"deptName\").value=deptname;\r\n");
          out.write("\t\tdocument.getElementById(\"deptID\").value=deptid;\r\n");
          out.write("\t\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction query(){\r\n");
          out.write("\t\tif(document.getElementById('deptID').value==null||document.getElementById('deptID').value==''){\r\n");
          out.write("\t\t\talert(\"请选择单位\");\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\tif(document.getElementById('bgnDate').value==null||document.getElementById('bgnDate').value==''){\r\n");
          out.write("\t\t\talert(\"请起始时间\");\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\tif(document.getElementById('endDate').value==null||document.getElementById('bgnDate').value==''){\r\n");
          out.write("\t\t\talert(\"请截止时间\");\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
          out.write("  \t\txmlhttp=new XMLHttpRequest();\r\n");
          out.write("  \t}else{// code for IE6, IE5\r\n");
          out.write("  \t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
          out.write("  \t}\r\n");
          out.write("\txmlhttp.onreadystatechange=function() {\r\n");
          out.write("\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
          out.write("    \t \r\n");
          out.write("    \tdocument.forms[0].submit();\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t};\r\n");
          out.write("\t\r\n");
          out.write("\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
          out.write("\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
          out.write("\txmlhttp.send(\"action=executeProduce&produceName=sp_crm_report&loginDeptID=\"\r\n");
          out.write("\t\t+document.getElementById('loginDeptID').value\r\n");
          out.write("\t\t+\"&deptID=\"+document.getElementById('deptID').value\r\n");
          out.write("\t\t+\"&bgnDate=\"+document.getElementById('bgnDate').value\r\n");
          out.write("\t\t+\"&endDate=\"+document.getElementById('endDate').value\r\n");
          out.write("\t\t+\"&deptName=\"+document.getElementById('deptName').value\r\n");
          out.write("\t\t+\"&userID=\"+document.getElementById('userID').value\r\n");
          out.write("\t\t+\"&reportID=6\");\r\n");
          out.write("\tdocument.getElementById(\"button\").disabled=true;\t\r\n");
          out.write(" \r\n");
          out.write(" }\r\n");
          out.write("\t\r\n");
          out.write("\tfunction queryDetail(queryField){\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tvar ecsideObj=ECSideUtil.getGridObj('customerTable');\r\n");
          out.write("\t\tvar selectedRow = ecsideObj.selectedRow;\r\n");
          out.write("\t\tvar deptID = selectedRow.getAttribute(\"recordKey\");\r\n");
          out.write("\t\twindow.open(\"vipLevelContributionDetail.do?dept_id=\"+deptID+\"&userID=\"+document.getElementById('userID').value+\"&queryField=\"+queryField,\"用户信息\",\"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction allqueryDetail(queryField){\r\n");
          out.write("\t\tvar deptID = document.getElementById(\"deptID\").value;\r\n");
          out.write("\t\tif(deptID==null||deptID==''){\r\n");
          out.write("\t\t\talert('请选择单位!');\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\twindow.open(\"vipLevelContributionDetail.do?dept_id=\"+deptID+\"&userID=\"+document.getElementById('userID').value+\"&queryField=\"+queryField,\"用户信息\",\"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("</script>\r\n");
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\r\n");
          out.write("<body>\r\n");
          out.write("\t<!-- <form id=\"customerAnalysisForm\" name=\"customerAnalysisForm\" action=\"customerAnalysis.do\">  -->\r\n");
          out.write("\t");
          //  html:form
          org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
          _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
          _jspx_th_html_005fform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
          // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(111,1) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setAction("/vipConsumeAnalysis/vipLevelContributionAnaysis");
          // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(111,1) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setStyleId("baseActionForm");
          // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(111,1) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setMethod("post");
          int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
          if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t");
              //  html:hidden
              org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
              _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
              _jspx_th_html_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
              // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(113,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f1.setProperty("loginDeptID");
              // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(113,3) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f1.setValue(request.getParameter("loginDeptID"));
              int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
              if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
              out.write("\r\n");
              out.write("\t\t\t");
              //  html:hidden
              org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
              _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
              _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
              // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(114,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setProperty("userID");
              // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(114,3) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setValue(request.getParameter("userID"));
              int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
              if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
              out.write("\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005fhidden_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t起始时间：\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005ftext_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t截至时间：\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005ftext_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\r\n");
              out.write("\r\n");
              out.write("\t\t\t部门：\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005ftext_005f2(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\t");
              if (_jspx_meth_html_005fbutton_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t\r\n");
              out.write("\t");
              int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.reuse(_jspx_th_html_005fform_005f0);
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\t\t");
          if (_jspx_meth_ec_005ftable_005f0(_jspx_th_html_005fhtml_005f0, _jspx_page_context))
            return;
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\r\n");
          out.write("<!-- </form> -->\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("</body>\r\n");
          int evalDoAfterBody = _jspx_th_html_005fhtml_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fhtml_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fhtml.reuse(_jspx_th_html_005fhtml_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fhtml.reuse(_jspx_th_html_005fhtml_005f0);
      out.write("\r\n");
      out.write("\r\n");
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
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(112,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("method");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(112,3) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("query");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f3 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(115,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setProperty("deptID");
    int _jspx_eval_html_005fhidden_005f3 = _jspx_th_html_005fhidden_005f3.doStartTag();
    if (_jspx_th_html_005fhidden_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f0 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(118,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setProperty("bgnDate");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(118,3) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setStyle("width:200px");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(118,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setOnclick("setday(this)");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(118,3) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f0.setReadonly(false);
    int _jspx_eval_html_005ftext_005f0 = _jspx_th_html_005ftext_005f0.doStartTag();
    if (_jspx_th_html_005ftext_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f1 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(121,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setProperty("endDate");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(121,3) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setStyle("width:200px");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(121,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setOnclick("setday(this)");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(121,3) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f1.setReadonly(false);
    int _jspx_eval_html_005ftext_005f1 = _jspx_th_html_005ftext_005f1.doStartTag();
    if (_jspx_th_html_005ftext_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005fstyle_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005ftext_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:text
    org.apache.struts.taglib.html.TextTag _jspx_th_html_005ftext_005f2 = (org.apache.struts.taglib.html.TextTag) _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody.get(org.apache.struts.taglib.html.TextTag.class);
    _jspx_th_html_005ftext_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005ftext_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(126,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setProperty("deptName");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(126,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setOnclick("showOrg()");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(126,3) name = readonly type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ftext_005f2.setReadonly(false);
    int _jspx_eval_html_005ftext_005f2 = _jspx_th_html_005ftext_005f2.doStartTag();
    if (_jspx_th_html_005ftext_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ftext_005freadonly_005fproperty_005fonclick_005fnobody.reuse(_jspx_th_html_005ftext_005f2);
    return false;
  }

  private boolean _jspx_meth_html_005fbutton_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:button
    org.apache.struts.taglib.html.ButtonTag _jspx_th_html_005fbutton_005f0 = (org.apache.struts.taglib.html.ButtonTag) _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick.get(org.apache.struts.taglib.html.ButtonTag.class);
    _jspx_th_html_005fbutton_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fbutton_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(127,3) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setProperty("button");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(127,3) name = onclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fbutton_005f0.setOnclick("query()");
    int _jspx_eval_html_005fbutton_005f0 = _jspx_th_html_005fbutton_005f0.doStartTag();
    if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005fbutton_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005fbutton_005f0.doInitBody();
      }
      do {
        out.write('查');
        out.write('询');
        int evalDoAfterBody = _jspx_th_html_005fbutton_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_html_005fbutton_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
      }
    }
    if (_jspx_th_html_005fbutton_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick.reuse(_jspx_th_html_005fbutton_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fbutton_005fproperty_005fonclick.reuse(_jspx_th_html_005fbutton_005f0);
    return false;
  }

  private boolean _jspx_meth_ec_005ftable_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fhtml_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:table
    org.ecside.tag.TableTag _jspx_th_ec_005ftable_005f0 = (org.ecside.tag.TableTag) _005fjspx_005ftagPool_005fec_005ftable_005fxlsFileName_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftitle_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.get(org.ecside.tag.TableTag.class);
    _jspx_th_ec_005ftable_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005ftable_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = items type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setItems(new String("vipCustomers"));
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = var type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setVar("vipcustomer");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = tableId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setTableId("customerTable");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = useAjax type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setUseAjax("false");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = doPreload type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setDoPreload("false");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = toolbarContent type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setToolbarContent("navigation|pagejump|pagesize|export|extend|status");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = showHeader type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setShowHeader("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = width type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setWidth("150%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = retrieveRowsCallback type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRetrieveRowsCallback("process");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = action type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setAction("vipLevelContributionAnaysis.do");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = pageSizeList type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setPageSizeList("10,20,30,50");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = rowsDisplayed type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setRowsDisplayed("20");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = editable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setEditable("false");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = xlsFileName type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setXlsFileName("VIP等级贡献分析表.xls");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = classic type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setClassic("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setTitle("VIP等级贡献分析表");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(131,2) name = filterable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005ftable_005f0.setFilterable("true");
    int[] _jspx_push_body_count_ec_005ftable_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005ftable_005f0 = _jspx_th_ec_005ftable_005f0.doStartTag();
      if (_jspx_eval_ec_005ftable_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t \r\n");
          out.write("\t\t\t");
          if (_jspx_meth_ec_005fextendrow_005f0(_jspx_th_ec_005ftable_005f0, _jspx_page_context, _jspx_push_body_count_ec_005ftable_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
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
      _005fjspx_005ftagPool_005fec_005ftable_005fxlsFileName_005fwidth_005fvar_005fuseAjax_005ftoolbarContent_005ftitle_005ftableId_005fshowHeader_005frowsDisplayed_005fretrieveRowsCallback_005fpageSizeList_005fitems_005ffilterable_005feditable_005fdoPreload_005fclassic_005faction.reuse(_jspx_th_ec_005ftable_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fextendrow_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005ftable_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005ftable_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:extendrow
    org.ecside.tag.ExtendRowTag _jspx_th_ec_005fextendrow_005f0 = (org.ecside.tag.ExtendRowTag) _005fjspx_005ftagPool_005fec_005fextendrow_005flocation.get(org.ecside.tag.ExtendRowTag.class);
    _jspx_th_ec_005fextendrow_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fextendrow_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005ftable_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(139,3) name = location type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fextendrow_005f0.setLocation("top");
    int _jspx_eval_ec_005fextendrow_005f0 = _jspx_th_ec_005fextendrow_005f0.doStartTag();
    if (_jspx_eval_ec_005fextendrow_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_ec_005fextendrow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_push_body_count_ec_005ftable_005f0[0]++;
        _jspx_th_ec_005fextendrow_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_ec_005fextendrow_005f0.doInitBody();
      }
      do {
        out.write("\r\n");
        out.write("\t\t\t\t \r\n");
        out.write("\t\t\t\t<tr>\r\n");
        out.write("    \t\t\t\t\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t<td class=\"tableHeader\" colspan=\"1\"> </td>\r\n");
        out.write("\t\t\t\t\t\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费低于3000</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费3000-4999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费5000-7999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费8000-9999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费10000-29999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费30000-49999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费50000-79999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">消费80000-99999</td>\r\n");
        out.write("   \t\t\t\t\t<td class=\"tableHeader\"  colspan=\"4\">100000以上</td>\r\n");
        out.write("\r\n");
        out.write("    \t\t\t\t\r\n");
        out.write("     \r\n");
        out.write("\r\n");
        out.write("\t\t\t\t</tr>\t\t\t\r\n");
        out.write("\t\t\t\r\n");
        out.write("\t\t\t");
        int evalDoAfterBody = _jspx_th_ec_005fextendrow_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
      if (_jspx_eval_ec_005fextendrow_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.popBody();
        _jspx_push_body_count_ec_005ftable_005f0[0]--;
      }
    }
    if (_jspx_th_ec_005fextendrow_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fec_005fextendrow_005flocation.reuse(_jspx_th_ec_005fextendrow_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fec_005fextendrow_005flocation.reuse(_jspx_th_ec_005fextendrow_005f0);
    return false;
  }

  private boolean _jspx_meth_ec_005frow_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005ftable_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005ftable_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:row
    org.ecside.tag.RowTag _jspx_th_ec_005frow_005f0 = (org.ecside.tag.RowTag) _005fjspx_005ftagPool_005fec_005frow_005frecordKey.get(org.ecside.tag.RowTag.class);
    _jspx_th_ec_005frow_005f0.setPageContext(_jspx_page_context);
    _jspx_th_ec_005frow_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005ftable_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(176,3) name = recordKey type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005frow_005f0.setRecordKey((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${vipcustomer.dept_id}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
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
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f0(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f1(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\t\t\t\t\r\n");
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
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f6(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f7(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t \r\n");
          out.write("\t\t\t\t \r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f8(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f9(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f10(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t<!-- 消费低于3000  -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f11(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f12(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f13(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f14(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费3000-4999  -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f15(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f16(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f17(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f18(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费5000-7999  -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f19(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f20(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f21(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f22(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费8000-9999  -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f23(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f24(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f25(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f26(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费10000-29999  -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f27(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f28(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f29(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f30(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费30000-49999 -->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f31(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f32(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f33(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f34(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费50000-79999-->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f35(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f36(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f37(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f38(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 消费80000-99999-->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f39(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f40(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f41(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f42(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t<!-- 100000以上-->\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f43(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f44(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f45(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t");
          if (_jspx_meth_ec_005fcolumn_005f46(_jspx_th_ec_005frow_005f0, _jspx_page_context, _jspx_push_body_count_ec_005frow_005f0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t\r\n");
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
      _005fjspx_005ftagPool_005fec_005frow_005frecordKey.reuse(_jspx_th_ec_005frow_005f0);
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
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(177,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setProperty("_0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(177,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f0.setTitle("序号");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(177,4) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f1 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f1.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(179,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setTitle("店铺名称");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(179,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setProperty("dept_name");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(179,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f1.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f2 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f2.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(180,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setTitle("开店时间");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(180,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setProperty("opentime");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(180,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f2.setSortable("true");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f3 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f3.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(181,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setTitle("分公司");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(181,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f3.setProperty("region");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(181,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f4 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f4.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(182,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setTitle("销售渠道");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(182,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f4.setProperty("dept_channel");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(182,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fsortable_005fproperty_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f4);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f5 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f5.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setTitle("VIP总数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setProperty("VIP");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(183,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f5.setCalcSpan("1");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f5);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f6 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f6.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setTitle("销售线索");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setProperty("ZVIP");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setOndblclick("queryDetail('ZVIP')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(188,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f6.setCalcSpan("1");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f6);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f7(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f7 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f7.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setTitle("选择时间段内的VIP人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setProperty("devvip");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setOndblclick("queryDetail('devvip')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(193,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f7.setCalcSpan("1");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f7);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f8(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f8 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f8.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setTitle("销售总额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setProperty("sumsalse");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(196,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f8.setCalcSpan("1");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f8);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f9(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f9 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f9.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setTitle("VIP消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setProperty("VIPfcalcsums");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(198,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f9.setCalcSpan("1");
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
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f9);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f10(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f10 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f10.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setProperty("fcalcsumsratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(199,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f10.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f10 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f10 = _jspx_th_ec_005fcolumn_005f10.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f10[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f10.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f10.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f10);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f11(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f11 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f11.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setProperty("VIP1");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setOndblclick("queryDetail('VIP1')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(201,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f11.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f11 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f11 = _jspx_th_ec_005fcolumn_005f11.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f11[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f11.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f11.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f11);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f12(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f12 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f12.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setProperty("vip1ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(202,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f12.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f12 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f12 = _jspx_th_ec_005fcolumn_005f12.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f12[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f12.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f12.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f12);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f13(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f13 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f13.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setProperty("VIPfcalcsums1");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(203,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f13.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f13 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f13 = _jspx_th_ec_005fcolumn_005f13.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f13[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f13.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f13.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f13);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f14(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f14 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f14.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setProperty("VIPfcalcsums1ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(204,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f14.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f14 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f14 = _jspx_th_ec_005fcolumn_005f14.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f14[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f14.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f14.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f14);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f15(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f15 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f15.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setProperty("VIP2");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setOndblclick("queryDetail('VIP2')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(207,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f15.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f15 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f15 = _jspx_th_ec_005fcolumn_005f15.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f15[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f15.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f15.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f15);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f16(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f16 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f16.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setProperty("vip2ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(208,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f16.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f16 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f16 = _jspx_th_ec_005fcolumn_005f16.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f16[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f16.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f16.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f16);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f17(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f17 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f17.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setProperty("VIPfcalcsums2");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(209,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f17.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f17 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f17 = _jspx_th_ec_005fcolumn_005f17.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f17[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f17.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f17.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f17);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f18(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f18 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f18.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f18.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setProperty("VIPfcalcsums2ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(210,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f18.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f18 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f18 = _jspx_th_ec_005fcolumn_005f18.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f18[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f18.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f18.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f18);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f19(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f19 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f19.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f19.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setProperty("VIP3");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setOndblclick("queryDetail('VIP3')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(213,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f19.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f19 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f19 = _jspx_th_ec_005fcolumn_005f19.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f19[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f19.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f19.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f19);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f20(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f20 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f20.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f20.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setProperty("vip3ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(214,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f20.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f20 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f20 = _jspx_th_ec_005fcolumn_005f20.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f20[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f20.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f20.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f20);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f21(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f21 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f21.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f21.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setProperty("VIPfcalcsums3");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(215,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f21.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f21 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f21 = _jspx_th_ec_005fcolumn_005f21.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f21[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f21.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f21.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f21);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f22(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f22 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f22.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f22.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setProperty("VIPfcalcsums3ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(216,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f22.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f22 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f22 = _jspx_th_ec_005fcolumn_005f22.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f22[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f22.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f22.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f22);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f23(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f23 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f23.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f23.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setProperty("VIP4");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setOndblclick("queryDetail('VIP4')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(219,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f23.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f23 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f23 = _jspx_th_ec_005fcolumn_005f23.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f23[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f23.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f23.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f23);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f24(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f24 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f24.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f24.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setProperty("vip4ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(220,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f24.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f24 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f24 = _jspx_th_ec_005fcolumn_005f24.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f24[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f24.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f24.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f24);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f25(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f25 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f25.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f25.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setProperty("VIPfcalcsums4");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(221,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f25.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f25 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f25 = _jspx_th_ec_005fcolumn_005f25.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f25[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f25.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f25.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f25);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f26(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f26 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f26.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f26.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setProperty("VIPfcalcsums4ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(222,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f26.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f26 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f26 = _jspx_th_ec_005fcolumn_005f26.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f26[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f26.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f26.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f26);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f27(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f27 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f27.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f27.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setProperty("VIP5");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setOndblclick("queryDetail('VIP5')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(225,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f27.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f27 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f27 = _jspx_th_ec_005fcolumn_005f27.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f27[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f27.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f27.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f27);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f28(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f28 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f28.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f28.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setProperty("vip5ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(226,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f28.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f28 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f28 = _jspx_th_ec_005fcolumn_005f28.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f28[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f28.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f28.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f28);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f29(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f29 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f29.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f29.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setProperty("VIPfcalcsums5");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(227,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f29.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f29 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f29 = _jspx_th_ec_005fcolumn_005f29.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f29[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f29.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f29.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f29);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f30(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f30 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f30.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f30.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setProperty("VIPfcalcsums5ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(228,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f30.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f30 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f30 = _jspx_th_ec_005fcolumn_005f30.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f30.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f30[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f30.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f30.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f30);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f31(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f31 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f31.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f31.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setProperty("VIP6");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setOndblclick("queryDetail('VIP6')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(231,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f31.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f31 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f31 = _jspx_th_ec_005fcolumn_005f31.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f31.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f31[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f31.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f31.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f31);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f32(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f32 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f32.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f32.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setProperty("vip6ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(232,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f32.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f32 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f32 = _jspx_th_ec_005fcolumn_005f32.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f32.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f32[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f32.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f32.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f32);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f33(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f33 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f33.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f33.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setProperty("VIPfcalcsums6");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(233,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f33.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f33 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f33 = _jspx_th_ec_005fcolumn_005f33.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f33.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f33[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f33.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f33.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f33);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f34(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f34 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f34.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f34.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setProperty("VIPfcalcsums6ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(234,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f34.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f34 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f34 = _jspx_th_ec_005fcolumn_005f34.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f34.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f34[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f34.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f34.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f34);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f35(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f35 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f35.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f35.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setProperty("VIP7");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setOndblclick("queryDetail('VIP7')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(237,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f35.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f35 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f35 = _jspx_th_ec_005fcolumn_005f35.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f35.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f35[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f35.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f35.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f35);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f36(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f36 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f36.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f36.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setProperty("vip7ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(238,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f36.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f36 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f36 = _jspx_th_ec_005fcolumn_005f36.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f36.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f36[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f36.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f36.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f36);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f37(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f37 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f37.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f37.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setProperty("VIPfcalcsums7");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(239,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f37.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f37 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f37 = _jspx_th_ec_005fcolumn_005f37.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f37.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f37[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f37.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f37.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f37);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f38(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f38 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f38.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f38.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setProperty("VIPfcalcsums7ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(240,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f38.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f38 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f38 = _jspx_th_ec_005fcolumn_005f38.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f38.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f38[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f38.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f38.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f38);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f39(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f39 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f39.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f39.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setProperty("VIP8");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setOndblclick("queryDetail('VIP8')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(243,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f39.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f39 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f39 = _jspx_th_ec_005fcolumn_005f39.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f39.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f39[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f39.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f39.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f39);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f40(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f40 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f40.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f40.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setProperty("vip8ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(244,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f40.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f40 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f40 = _jspx_th_ec_005fcolumn_005f40.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f40.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f40[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f40.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f40.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f40);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f41(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f41 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f41.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f41.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setProperty("VIPfcalcsums8");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(245,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f41.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f41 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f41 = _jspx_th_ec_005fcolumn_005f41.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f41.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f41[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f41.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f41.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f41);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f42(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f42 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f42.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f42.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setProperty("VIPfcalcsums8ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(246,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f42.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f42 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f42 = _jspx_th_ec_005fcolumn_005f42.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f42.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f42[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f42.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f42.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f42);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f43(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f43 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f43.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f43.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setTitle("人数");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setProperty("VIP9");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setFormat("0");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setStyle("text-align:right;text-decoration:underline");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = ondblclick type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setOndblclick("queryDetail('VIP9')");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(249,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f43.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f43 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f43 = _jspx_th_ec_005fcolumn_005f43.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f43.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f43[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f43.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f43.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fondblclick_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f43);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f44(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f44 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f44.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f44.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setTitle("人数占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setProperty("vip9ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(250,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f44.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f44 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f44 = _jspx_th_ec_005fcolumn_005f44.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f44.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f44[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f44.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f44.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f44);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f45(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f45 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f45.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f45.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setTitle("消费金额");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setProperty("VIPfcalcsums9");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setFormat("0.00");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setStyle("text-align:right");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = calc type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setCalc("total");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = calcTitle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setCalcTitle("合计");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(251,4) name = calcSpan type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f45.setCalcSpan("1");
    int[] _jspx_push_body_count_ec_005fcolumn_005f45 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f45 = _jspx_th_ec_005fcolumn_005f45.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f45.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f45[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f45.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f45.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fcalcTitle_005fcalcSpan_005fcalc_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f45);
    }
    return false;
  }

  private boolean _jspx_meth_ec_005fcolumn_005f46(javax.servlet.jsp.tagext.JspTag _jspx_th_ec_005frow_005f0, PageContext _jspx_page_context, int[] _jspx_push_body_count_ec_005frow_005f0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  ec:column
    org.ecside.tag.ColumnTag _jspx_th_ec_005fcolumn_005f46 = (org.ecside.tag.ColumnTag) _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.get(org.ecside.tag.ColumnTag.class);
    _jspx_th_ec_005fcolumn_005f46.setPageContext(_jspx_page_context);
    _jspx_th_ec_005fcolumn_005f46.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_ec_005frow_005f0);
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = title type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setTitle("消费占比");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setProperty("VIPfcalcsums9ratio");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = sortable type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setSortable("true");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = cell type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setCell("number");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = format type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setFormat("0.00%");
    // /vipConsumeAnalysis/vipLevelContributeAnalysis.jsp(252,4) name = style type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_ec_005fcolumn_005f46.setStyle("text-align:right");
    int[] _jspx_push_body_count_ec_005fcolumn_005f46 = new int[] { 0 };
    try {
      int _jspx_eval_ec_005fcolumn_005f46 = _jspx_th_ec_005fcolumn_005f46.doStartTag();
      if (_jspx_th_ec_005fcolumn_005f46.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_ec_005fcolumn_005f46[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_ec_005fcolumn_005f46.doCatch(_jspx_exception);
    } finally {
      _jspx_th_ec_005fcolumn_005f46.doFinally();
      _005fjspx_005ftagPool_005fec_005fcolumn_005ftitle_005fstyle_005fsortable_005fproperty_005fformat_005fcell_005fnobody.reuse(_jspx_th_ec_005fcolumn_005f46);
    }
    return false;
  }
}
