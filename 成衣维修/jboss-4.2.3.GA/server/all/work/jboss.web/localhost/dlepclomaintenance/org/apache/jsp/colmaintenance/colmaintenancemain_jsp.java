package org.apache.jsp.colmaintenance;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class colmaintenancemain_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhtml;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005fhtml = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005fhtml.release();
    _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.release();
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
 String userID = (String) request.getAttribute("userID");
   String loginDeptID =(String) request.getAttribute("loginDeptID");
   String pwd = (String) request.getAttribute("pwd");
   System.out.println(userID);
   System.out.println(loginDeptID);
   String webContext = request.getContextPath();

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
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("<head>\r\n");
          out.write("\t\t<title>成衣维修</title>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\" ");
          out.print(request.getContextPath());
          out.write("/tabbed_pages/tabbed_pages.css\" />\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t<script type=\"text/javascript\" src=\" ");
          out.print(request.getContextPath());
          out.write("/tabbed_pages/tabbed_pages.js\" ></script>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("</head>\r\n");
          out.write("\r\n");
          out.write("<script type=\"text/javascript\">\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction creatBill(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//var url=webContext+\"/eidtMaintenanceBill.do?method=init&userID=\"+document.getElementById('userID').value+\"&loginDeptID=\"+document.getElementById('loginDeptID').value;\r\n");
          out.write("\t\t\tdocument.frames['maintenanceParticularInfo'].location.href=webContext+\"/eidtMaintenanceBill.do?method=init&userID=\"+document.getElementById('userID').value+\"&loginDeptID=\"+document.getElementById('loginDeptID').value;\r\n");
          out.write("\t\t\t\r\n");
          out.write("\r\n");
          out.write("\t\t\t//window.open(url, \"登记维修单\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\tchangeDIV();\r\n");
          out.write("\t\t\tdocument.getElementById('sendHQ').disabled=false;\r\n");
          out.write("\t\t\tdocument.getElementById('deleteBill').disabled=true;\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\t//function dpReceive(){\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t//}\r\n");
          out.write("\t\r\n");
          out.write("\t\tfunction dpReceive(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\tvar userID = document.getElementById('userID').value;\r\n");
          out.write("\t\t\tvar url=webContext+\"/appraiseinfo.do?method=viewAppraiseinfo&guid=\"+document.getElementById('guid').value+\"&userID=\"+userID;\r\n");
          out.write("\t\t\twindow.open(url, \"店铺收货\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction gkReceive(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\tvar userID = document.getElementById('userID').value;\r\n");
          out.write("\t\t\tvar url=webContext+\"/appraiseinfo.do?method=viewAppraiseinfo&guid=\"+document.getElementById('guid').value+\"&userID=\"+userID;;\r\n");
          out.write("\t\t\twindow.open(url, \"顾客收货\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\tfunction sendHQ(){\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\tvar subIframe = document.getElementById('maintenanceParticularInfo');\r\n");
          out.write("\t\tvar guid = subIframe.contentWindow.document.getElementById('guid').value;\r\n");
          out.write("\t\t//var parentGuid = document.getElementById('guid').value;\r\n");
          out.write("\t\t//if(parentGuid == guid){\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.valNum!=0){\r\n");
          out.write("\t\t\t\talert('后台还有数据在处理，请稍后！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('YS').value==null||subIframe.contentWindow.document.getElementById('YS').value==''){\r\n");
          out.write("\t\t\t\talert('后台正在获取服装颜色信息，请稍后提交！');\r\n");
          out.write("\t\t\treturn;\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('MS').value==null||subIframe.contentWindow.document.getElementById('MS').value==''){\r\n");
          out.write("\t\t\t\talert('后台正在获取服装尺码信息，请稍后提交！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('dpbm').value==null||subIframe.contentWindow.document.getElementById('dpbm').value==''){\r\n");
          out.write("\t\t\t\talert('店铺不能为空！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('DZXM').value==null||subIframe.contentWindow.document.getElementById('DZXM').value==''){\r\n");
          out.write("\t\t\t\talert('店长不能为空');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('SLDG').value==null||subIframe.contentWindow.document.getElementById('SLDG').value==''){\r\n");
          out.write("\t\t\t\talert('受理导购不能为空！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('DGLXDH').value==null||subIframe.contentWindow.document.getElementById('DGLXDH').value==''){\r\n");
          out.write("\t\t\t\talert('导购联系电话不能为空！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById(\"GKWX\").checked){\r\n");
          out.write("\t\t\t\tif(subIframe.contentWindow.document.getElementById('GKXM').value==null||subIframe.contentWindow.document.getElementById('GKXM').value==''){\r\n");
          out.write("\t\t\t\t\talert('顾客姓名不能为空！');\r\n");
          out.write("\t\t\t\t\treturn;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\tif(subIframe.contentWindow.document.getElementById('SCSJ').value==null||subIframe.contentWindow.document.getElementById('SCSJ').value==''){\r\n");
          out.write("\t\t\t\t\talert('售出时间不能为空！');\r\n");
          out.write("\t\t\t\t\treturn;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('KH').value==null||subIframe.contentWindow.document.getElementById('KH').value==''){\r\n");
          out.write("\t\t\t\talert('款号不能为空！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tif(subIframe.contentWindow.document.getElementById('WTMS').value==null||subIframe.contentWindow.document.getElementById('WTMS').value==''){\r\n");
          out.write("\t\t\t\talert('问题描述不能为空！');\r\n");
          out.write("\t\t\t\treturn;\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\tvar YSGS = subIframe.contentWindow.document.getElementById('YSGS').value;\r\n");
          out.write("\t\t\tvar YDH = subIframe.contentWindow.document.getElementById('YDH').value;\r\n");
          out.write("\t\t\tvar dpbm = subIframe.contentWindow.document.getElementById('dpbm').value;\r\n");
          out.write("\t\t\tvar dh = subIframe.contentWindow.document.getElementById('dh').value; \r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\tif( (YSGS !=null && YSGS!='') && (YDH !=null && YDH!='') ){\r\n");
          out.write("\t\t\t\tdocument.getElementById('method').value=\"sendToHQ\";\r\n");
          out.write("\t\t\t\tsubIframe.contentWindow.document.forms[0].submit();\r\n");
          out.write("\t\t\t\t//dpPrint();\r\n");
          out.write("\t\t\t\t//\r\n");
          out.write("\t\t\t    //document.forms[0].submit();\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t}else{\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\tvar url=webContext+\"/shopLogisticsBill.do?method=getShopPrintData&guid=\"+document.getElementById('guid').value+\"&dpbm=\"+dpbm+\"&dh=\"+dh;\r\n");
          out.write("\t\t\t\tif(YSGS != null && YSGS != ''){\r\n");
          out.write("\t\t\t\t\turl=url+\"&YSGS=\"+YSGS;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\tif(YDH != null && YDH != ''){\r\n");
          out.write("\t\t\t\t\turl=url+\"&YDH=\"+YDH;\r\n");
          out.write("\t\t\t\t}\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\twindow.open(url, \"发到总部\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\t\t\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t//}else{\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t//}\r\n");
          out.write("\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction dpPrint(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//alert(document.getElementById('guid').value);\r\n");
          out.write("\t\t\tvar url=webContext+\"/shopPrint.do?method=getShopPrintData&guid=\"+document.getElementById('guid').value;\r\n");
          out.write("\t\t\twindow.open(url, \"店铺打印\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction gkPrint(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\t//alert(document.getElementById('guid').value);\r\n");
          out.write("\t\t\tvar url=webContext+\"/customerPrint.do?method=getShopPrintData&guid=\"+document.getElementById('guid').value;\r\n");
          out.write("\t\t\twindow.open(url, \"顾客打印\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\t\r\n");
          out.write("\t\tfunction expressPrint(){\r\n");
          out.write("\t\t\tvar webContext = document.getElementById('webContext').value;\r\n");
          out.write("\t\t\tvar url=webContext+\"/expressWayBill.do?method=getExpressData&guid=\"+document.getElementById('guid').value;\r\n");
          out.write("\t\t\twindow.open(url, \"快递单打印\", \"scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\r\n");
          out.write("\t\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction changeDIV(){\r\n");
          out.write("\t\t\tvar getEls = document.getElementsByTagName('DIV');\r\n");
          out.write("\t\t\tfor (var z=0; z<getEls.length; z++) {\r\n");
          out.write("\t\t\t\tgetEls[z].className=getEls[z].className.replace('show', 'hide');\r\n");
          out.write("\t\t\t\tgetEls[z].className=getEls[z].className.replace('on', 'off');\r\n");
          out.write("\t\t\t}\r\n");
          out.write("\t\t\tdocument.getElementById('particular').className = 'on';\r\n");
          out.write("\t\t\tvar max = document.getElementById('particular').getAttribute('title');\r\n");
          out.write("\t\t\tdocument.getElementById(max).className = \"show\";\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t//var subIframe = document.getElementById('maintenanceParticularInfo');\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t//if(subIframe.contentWindow.document.getElementById('method')!=null){\r\n");
          out.write("\t\t\t\t//document.getElementById(\"sendHQ\").disabled=false;\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t//}else{\r\n");
          out.write("\t\t\t\t//document.getElementById(\"sendHQ\").disabled=true;\r\n");
          out.write("\t\t\t//}\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction dpPrintAfter(guid){\r\n");
          out.write("\t\tvar xmlhttp;\r\n");
          out.write("\t\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
          out.write("  \t\t\txmlhttp=new XMLHttpRequest();\r\n");
          out.write("  \t\t}else{// code for IE6, IE5\r\n");
          out.write("  \t\t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
          out.write("  \t\t}\r\n");
          out.write("\t\txmlhttp.onreadystatechange=function() {\r\n");
          out.write("\t\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
          out.write("    \t\t\t\r\n");
          out.write("    \t\t}\r\n");
          out.write(" \t\t}\r\n");
          out.write(" \t\tvar employeeID = document.getElementById(\"SLDG\").value;\r\n");
          out.write("\t\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
          out.write("\t\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
          out.write("\t\txmlhttp.send(\"action=isExist&employeeID=\"+employeeID);\r\n");
          out.write("\t\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\tfunction deleteBill(){\r\n");
          out.write("\t\tvar dh = document.getElementById(\"dh\").value;\r\n");
          out.write("\t\tif(confirm('确认删除单号为'+dh+'的维修单？')){\r\n");
          out.write("\t\t\tdocument.getElementById('method').value=\"deleteBill\";\r\n");
          out.write("\t\t\tdocument.forms[0].submit();\r\n");
          out.write("\t\t}\r\n");
          out.write("\t}\r\n");
          out.write("\t\r\n");
          out.write("\t</script>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("<body> \r\n");
          out.write("\t");
          //  html:form
          org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_005fstyleId_005fmethod_005faction.get(org.apache.struts.taglib.html.FormTag.class);
          _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
          _jspx_th_html_005fform_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fhtml_005f0);
          // /colmaintenance/colmaintenancemain.jsp(238,1) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setAction("/cloMaintenanceMain");
          // /colmaintenance/colmaintenancemain.jsp(238,1) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setStyleId("cloMaintenanceForm");
          // /colmaintenance/colmaintenancemain.jsp(238,1) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005fform_005f0.setMethod("post");
          int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
          if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f1(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              //  html:hidden
              org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f2 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
              _jspx_th_html_005fhidden_005f2.setPageContext(_jspx_page_context);
              _jspx_th_html_005fhidden_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
              // /colmaintenance/colmaintenancemain.jsp(241,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setProperty("webContext");
              // /colmaintenance/colmaintenancemain.jsp(241,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_html_005fhidden_005f2.setValue(request.getContextPath());
              int _jspx_eval_html_005fhidden_005f2 = _jspx_th_html_005fhidden_005f2.doStartTag();
              if (_jspx_th_html_005fhidden_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
                return;
              }
              _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f2);
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f3(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f4(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f5(_jspx_th_html_005fform_005f0, _jspx_page_context))
                return;
              out.write("\r\n");
              out.write("\t\t");
              if (_jspx_meth_html_005fhidden_005f6(_jspx_th_html_005fform_005f0, _jspx_page_context))
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
          out.write("\t\r\n");
          out.write("\t<input type=\"button\"  id=\"creatBill\"  name=\"creatBill\" value=\"登记维修单\" onclick=\"creatBill()\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"deleteBill\"  name=\"deleteBill\" disabled=\"disabled\" value=\"删除维修单\" onclick=\"deleteBill()\"/> \r\n");
          out.write("\t<input type=\"button\"  id=\"dpAppraiseInfo\" disabled=\"disabled\" name=\"dpAppraiseInfo\" value=\"店铺收货\" onclick=\"dpReceive();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"gkAppraiseInfo\" disabled=\"disabled\" name=\"gkAppraiseInfo\" value=\"顾客收货\" onclick=\"gkReceive();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"sendHQ\" disabled=\"disabled\" name=\"sendHQ\" value=\"发送总部\" onclick=\"sendHQ();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"dpPrint\" disabled=\"disabled\" name=\"dpPrint\" value=\"店铺打印\" onclick=\"dpPrint();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"gkPrint\" disabled=\"disabled\" name=\"gkPrint\" value=\"顾客打印\" onclick=\"gkPrint();\"/>\r\n");
          out.write("\t<input type=\"button\"  id=\"expressPrint\" disabled=\"disabled\" name=\"expressPrint\" value=\"快递单打印\" onclick=\"expressPrint();\"/>\r\n");
          out.write("\t\r\n");
          out.write("\t<div align=\"right\">\r\n");
          out.write("\t\t<a href=\"");
          out.print(webContext);
          out.write("/cloMaintenanceSelf.do?method=init&userID=");
          out.print(userID);
          out.write("&pwd=");
          out.print(pwd);
          out.write("\" target=\"_blank\"><font>非总部维修管理 </font></a>\r\n");
          out.write("\t</div>\r\n");
          out.write("\t<div id=\"gallery\">\r\n");
          out.write("\t\t<div class=\"on\" title=\"infolist\"><span>列表</span></div>\r\n");
          out.write("\t\t<div id=\"particular\" class=\"off\" title=\"particularInfo\"><span>详细</span></div>\r\n");
          out.write("\t\t<div class=\"off\" title=\"HQsendgoods\"><span>总部发货</span></div>\r\n");
          out.write("\t\t<div class=\"off\" title=appraiseinfo><span>评价信息</span></div>\r\n");
          out.write("\t\t<div class=\"off\" title=\"operaterecord\"><span>操作记录</span></div>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t<div id=\"infolist\" class=\"show\">\r\n");
          out.write("\t\t<iframe name=\"maintenanceInfoList\"  width=\"98%\" height=\"95%\" src=\"");
          out.print(webContext);
          out.write("/maintenanceInfoList.do?method=queryList&userID=");
          out.print(userID);
          out.write("&loginDeptID=");
          out.print(loginDeptID);
          out.write("\" ></iframe>\r\n");
          out.write("\t\t\r\n");
          out.write("\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t<div id=\"particularInfo\" class=\"hide\">\r\n");
          out.write("\t\t<iframe id=\"maintenanceParticularInfo\" name=\"maintenanceParticularInfo\" width=\"100%\" height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/viewMaintenanceBill.do?method=init\"></iframe>\r\n");
          out.write("\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t<div id=\"HQsendgoods\" class=\"hide\">\r\n");
          out.write("\t\t<iframe name=\"maintenanceHQSendGoods\" width=\"100%\" height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/viewHQSendGoods.do?method=init\" ></iframe>\r\n");
          out.write("\t\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t<div id=\"appraiseinfo\" class=\"hide\">\r\n");
          out.write("\t\t<iframe name=\"maintenanceAppraiseInfo\" width=\"100%\" height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/appraiseinfo.do?method=init\"></iframe>\r\n");
          out.write("\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\r\n");
          out.write("\t<div id=\"operaterecord\" class=\"hide\">\t\r\n");
          out.write("\t\t<iframe name=\"maintenanceOperaterecord\" width=\"100%\" height=\"100%\" src=\"");
          out.print(webContext);
          out.write("/operaterecord.do?method=query\"></iframe>\r\n");
          out.write("\t\t\r\n");
          out.write("\t</div>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("\t</body>\r\n");
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
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemain.jsp(239,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("userID");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f1 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f1.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemain.jsp(240,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f1.setProperty("loginDeptID");
    int _jspx_eval_html_005fhidden_005f1 = _jspx_th_html_005fhidden_005f1.doStartTag();
    if (_jspx_th_html_005fhidden_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f1);
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
    // /colmaintenance/colmaintenancemain.jsp(242,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f3.setProperty("guid");
    int _jspx_eval_html_005fhidden_005f3 = _jspx_th_html_005fhidden_005f3.doStartTag();
    if (_jspx_th_html_005fhidden_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f4 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemain.jsp(243,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f4.setProperty("dh");
    int _jspx_eval_html_005fhidden_005f4 = _jspx_th_html_005fhidden_005f4.doStartTag();
    if (_jspx_th_html_005fhidden_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f5 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemain.jsp(244,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f5.setProperty("method");
    // /colmaintenance/colmaintenancemain.jsp(244,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f5.setValue("query");
    int _jspx_eval_html_005fhidden_005f5 = _jspx_th_html_005fhidden_005f5.doStartTag();
    if (_jspx_th_html_005fhidden_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fvalue_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f5);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f6 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f6.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /colmaintenance/colmaintenancemain.jsp(245,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f6.setProperty("sendHQFlag");
    int _jspx_eval_html_005fhidden_005f6 = _jspx_th_html_005fhidden_005f6.doStartTag();
    if (_jspx_th_html_005fhidden_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f6);
    return false;
  }
}
