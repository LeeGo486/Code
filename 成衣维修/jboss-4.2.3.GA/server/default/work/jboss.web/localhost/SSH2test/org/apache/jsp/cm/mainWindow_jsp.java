package org.apache.jsp.cm;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class mainWindow_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html;charset=GBK");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String viewFlag = request.getParameter("viewFlag");
String status = request.getParameter("status");


      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>成衣维修主界面</title>\r\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/cmcommon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/src/jquery.parser.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \tvar status = $('status').attr('value');\r\n");
      out.write("  \t$(\"#listInfo\").attr('src',$('#path').attr('value')+'/cm/register/QueryList.jsp'+'?status='+status);\r\n");
      out.write("  \t\r\n");
      out.write("  \t//window.frames['detailInfo'].location.href=$('#path').attr('value')+'/cm/register/querydetail_noalble.jsp?guid=-1&zt=0';\r\n");
      out.write("  \t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_noable.jsp?guid=04519C843A6645F7BE827421B60F01AA&zt=0');\r\n");
      out.write("  \t\r\n");
      out.write("  \t//window.frames['hosendbill'].location.href=$('#path').attr('value')+'/cm/headOfficeSendBill.jsp';\r\n");
      out.write("  //\t$(\"#hosendbill\").attr('src',$('#path').attr('value')+'/cm/headOfficeSendBill.jsp');\r\n");
      out.write("  \t//window.frames['appraise'].location.href=$('#path').attr('value')+'/cm/cmAppraiseView.jsp';\r\n");
      out.write("  //\t$(\"#appraise\").attr('src',$('#path').attr('value')+'/web/appraise-view!getAppraiseInfo?id='+);\r\n");
      out.write("  \t//window.frames['operateRecord'].location.href=$('#path').attr('value')+'/cm/cmOperateRecord.jsp';\r\n");
      out.write("  //\t$(\"#operateRecord\").attr('src',$('#path').attr('value')+'/cm/cmOperateRecord.jsp');\r\n");
      out.write("  \t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function listOnclick(guid,zt){\r\n");
      out.write("  \t\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function listDbOnclick(guid,zt){\r\n");
      out.write("  \tvar viewFlag = $('viewFlag').attr('value');\r\n");
      out.write("  \tif(viewFlag==\"1\"){\r\n");
      out.write("  \t\t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_noable.jsp?guid='+guid);\r\n");
      out.write("  \t}else{\r\n");
      out.write("  \t\tif(zt==0){\r\n");
      out.write("\t\t\t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_register.jsp?guid='+guid+'&zt='+zt);\r\n");
      out.write("\t\t}else if(zt==1){\r\n");
      out.write("\t\t\t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_pjpd.jsp?guid='+guid+'&zt='+zt);\r\n");
      out.write("\t\t}else if('2,3,4,5,6'.indexOf(zt)){\r\n");
      out.write("\t\t\t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_pjpd2.jsp?guid='+guid+'&zt='+zt);\r\n");
      out.write("\t\t}else {\r\n");
      out.write("\t\t\t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_noable.jsp?guid='+guid+'&zt='+zt);\r\n");
      out.write("\t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\t\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t$('#mian').tabs('select','详细');\r\n");
      out.write("  \t$(\"#hosendbill\").attr('src',$('#path').attr('value')+'/web/head-office-send-bill!showHOSendBill?id='+guid);\r\n");
      out.write("  \t$(\"#appraise\").attr('src',$('#path').attr('value')+'/web/appraise-view!getAppraiseInfo?id='+guid);\r\n");
      out.write("  \t$(\"#operateRecord\").attr('src',$('#path').attr('value')+'/cm/cmOperateRecord.jsp?zbguid='+guid);\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function openRegister(){\r\n");
      out.write("  \t$(\"#detailInfo\").attr('src',$('#path').attr('value')+'/cm/register/querydetail_register.jsp');\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function pjConfirm(){\r\n");
      out.write("  \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function maintanceComplete(){\r\n");
      out.write("  \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function HOSend(){\r\n");
      out.write("  \r\n");
      out.write("  }\r\n");
      out.write("  function pichSend(){\r\n");
      out.write("  }\r\n");
      out.write("  function shopPrint(){\r\n");
      out.write("  \r\n");
      out.write("  }\r\n");
      out.write("  function HOPrint(){\r\n");
      out.write("  \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function expressPrint(){\r\n");
      out.write("  }\r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"status\" value=\"");
      out.print(status);
      out.write("\">\r\n");
      out.write("    \t<input type=\"hidden\" id=\"viewFlag\" value=\"");
      out.print(viewFlag);
      out.write("\">\r\n");
      out.write("    \t\r\n");
      out.write("    \t");
      out.write("\r\n");
      out.write("\t\t<div id=\"mian\" class=\"easyui-tabs\" data-options=\"fit:true,border:false\" >\r\n");
      out.write("\t\t\t<div id=\"tab1\" title=\"列表\" style=\"padding:20px;overflow:hidden;\"> \r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<iframe id=\"listInfo\" src=\"\" scrolling=\"auto\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<div id=\"tab2\" title=\"详细\" data-options=\"iconCls:'icon-reload',closable:true\" style=\"overflow:hidden;padding:5px;\">\r\n");
      out.write("\t\t\t\t<iframe id=\"detailInfo\" src=\"");
      out.print(path);
      out.write("/cm/register/querydetail_noable.jsp?guid=-1&zt=0\" scrolling=\"auto\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div id=\"tab3\" title=\"总部发货单\"  data-options=\"iconCls:'icon-reload',closable:true\" style=\"overflow:hidden;padding:5px;\">\r\n");
      out.write("\t\t\t\t<iframe id=\"hosendbill\" src=\"");
      out.print(path);
      out.write("/cm/headOfficeSendBill.jsp\" scrolling=\"auto\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div id=\"tab4\" title=\"评价信息\" data-options=\"iconCls:'icon-reload',closable:true\" style=\"overflow:hidden;padding:5px;\">\r\n");
      out.write("\t\t\t\t<iframe id=\"appraise\" src=\"");
      out.print(path);
      out.write("/web/appraise-view!getAppraiseInfo?id=-1\" scrolling=\"auto\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div id=\"tab5\" title=\"操作记录\" data-options=\"iconCls:'icon-reload',closable:true\" style=\"overflow:hidden;padding:5px;\">\r\n");
      out.write("\t\t\t\t<iframe id=\"operateRecord\" src=\"");
      out.print(path);
      out.write("/cm/cmOperateRecord.jsp\" scrolling=\"auto\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
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
}
