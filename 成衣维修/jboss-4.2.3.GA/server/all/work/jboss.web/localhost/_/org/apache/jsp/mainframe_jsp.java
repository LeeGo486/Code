package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.branch.expense.dojo.UserInfo;

public final class mainframe_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("user_info");
  String path = request.getContextPath();

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    \r\n");
      out.write("    <title>费用审批</title>\r\n");
      out.write("    \r\n");
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"js/jquery-1.5.2.min.js\"></script>\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print( path);
      out.write("/css/mycommon.css\" />\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  \tfunction changeArea(){\r\n");
      out.write("  \t\tif($(\"#barImg\").attr(\"src\")=='img/changebar.JPG'){\r\n");
      out.write("  \t\t\t$(\"#leftFrame\").css(\"width\",\"0\");\r\n");
      out.write("  \t\t\t$(\"#leftFrame\").css(\"display\",\"none\");\r\n");
      out.write("  \t\t\t$(\"#barFrame\").css(\"left\",\"0\");\r\n");
      out.write("  \t\t\t$(\"#mainFrame\").css(\"width\",\"99.5%\");\r\n");
      out.write("  \t\t\t$(\"#mainFrame\").css(\"left\",\"0.5%\");\r\n");
      out.write("  \t\t\t$(\"#barImg\").attr(\"src\",\"img/changebar2.JPG\");\r\n");
      out.write("  \t\t}else{\r\n");
      out.write("  \t\t\t$(\"#leftFrame\").css(\"width\",\"120\");\r\n");
      out.write("  \t\t\t$(\"#leftFrame\").css(\"display\",\"block\");\r\n");
      out.write("  \t\t\t$(\"#barFrame\").css(\"left\",\"120\");\r\n");
      out.write("  \t\t\t$(\"#mainFrame\").css(\"left\",\"130\");\r\n");
      out.write("  \t\t\t$(\"#mainFrame\").css(\"width\",\"1100\");\r\n");
      out.write("  \t\t\t$(\"#barImg\").attr(\"src\",\"img/changebar.JPG\");\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction gotoCashExpenseApply(obj){\r\n");
      out.write("  \t\tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \t\tdocument.getElementById(\"detailView\").src=webContext+\"/cashExpenseApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \t\t//document.frames['detailView'].location.href=webContext+\"/cashExpenseApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \t\tmenuOnclick(obj)\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
      out.write("  \tfunction gotoMainFlow(obj){\r\n");
      out.write("  \t\tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \t\tdocument.frames['detailView'].location.href=webContext+\"/expenseMainFlow.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \t\tmenuOnclick(obj)\r\n");
      out.write("  \t}\r\n");
      out.write("  \t\r\n");
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
      out.write("  function logout(){\r\n");
      out.write("  \twindow.location.href=$('#path').attr('value')+'/login.do?action=logout';\r\n");
      out.write("  }\r\n");
      out.write(" \r\n");
      out.write("  function gotoSpecialPayment(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/specialPaymentApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function gotoWagePayment(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/wagePaymentApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("    function gotoTripExpense(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/tripExpenseApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function gotoPaymentExpense(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/paymentApply.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function gotoPurposeMergeQuery(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/purposeCostMergeQuery.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("   function gotoSubjectMergeQuery(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/subjectMergeQuery.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function gotoShopExpenseApportion(obj){\r\n");
      out.write("  \tvar webContext = $(\"#path\").attr(\"value\");\r\n");
      out.write("  \tdocument.frames['detailView'].location.href=webContext+\"/shopExpenseApportion.do?action=init&username=\"+ $(\"#username\").attr(\"value\");\r\n");
      out.write("  \tmenuOnclick(obj)\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function menuChange(){\r\n");
      out.write("  \t$('#101').toggle();\r\n");
      out.write("  \t \r\n");
      out.write("  \t \r\n");
      out.write("  \t $('#2001').css('display','none');\r\n");
      out.write("  \t $('#2002').css('display','none');\r\n");
      out.write("  \t $('#2003').css('display','none');\r\n");
      out.write("  \t $('#2004').css('display','none');\r\n");
      out.write("  \t $('#2005').css('display','none');\r\n");
      out.write("  \t \r\n");
      out.write("  \t $('#3001').css('display','none');\r\n");
      out.write("  \t $('#3002').css('display','none');\r\n");
      out.write("  \t $('#3003').css('display','none');\r\n");
      out.write("  \t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function menuOnclick(obj){\r\n");
      out.write("      $('#branchApply').find('td').each(function(){\r\n");
      out.write("          if($(this).attr('id')!='1002-td' && $(this).attr('id')!='1003-td'){\r\n");
      out.write("          \t$(this).css({\"font-weight\": \"500\",\"background-color\":\"#E7ECF3\"});\r\n");
      out.write("          }\r\n");
      out.write("      })\r\n");
      out.write("      \r\n");
      out.write("      \t$(obj).css({\"font-weight\": \"700\",\"background-color\":\"#FFEEDD\"});\r\n");
      out.write("      \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \t $('#2001').css('display','none');\r\n");
      out.write("  \t $('#2002').css('display','none');\r\n");
      out.write("  \t $('#2003').css('display','none');\r\n");
      out.write("  \t $('#2004').css('display','none');\r\n");
      out.write("  \t $('#2005').css('display','none');\r\n");
      out.write("  \t \r\n");
      out.write("  \t $('#3001').css('display','none');\r\n");
      out.write("  \t $('#3002').css('display','none');\r\n");
      out.write("  \t $('#3003').css('display','none');\r\n");
      out.write("  }\r\n");
      out.write("  </script>\r\n");
      out.write("  <body bgcolor=\"#E7ECF3\" onload=\"initForm()\">\r\n");
      out.write("  \t\r\n");
      out.write("  \t<input type=\"hidden\" id=\"path\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write("  \t<input type=\"hidden\" id=\"username\" value=\"");
      out.print(request.getAttribute("username"));
      out.write("\" >\r\n");
      out.write("  <table style=\"width: 1250;height: 20;\">\r\n");
      out.write("  \t<tr>\r\n");
      out.write("  \t\t<td style=\"font-size: 12;height: 20;width: 15%;\">  当前登录人：");
      out.print(userInfo.getRealname());
      out.write("\r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t</td>\r\n");
      out.write("  \t\t<td id=\"applytitle\" style=\"font-size: 12;font-weight:700;height: 20;width: 80%\">\r\n");
      out.write("  \t\t\t待办任务\r\n");
      out.write("  \t\t</td>\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t<td style=\"font-size: 12;height: 20;text-align: left;width: 5%; \"> \r\n");
      out.write("  \t\t<div style=\"position: relative;\">\r\n");
      out.write("  \t\t\t<div style=\"position: absolute;top: -2;z-index: 2\">\r\n");
      out.write("  \t\t\t\t<a onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\" onclick=\"logout()\"> 注销 </a>\r\n");
      out.write("  \t\t\t\r\n");
      out.write("  \t\t\t</div>\r\n");
      out.write("  \t\t\t<div style=\"position: absolute;top: -25;z-index: 1;\">\r\n");
      out.write("  \t\t\t<img alt=\"注销\" src=\"");
      out.print(path);
      out.write("/css/images/logout.png\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\" onclick=\"logout()\">\r\n");
      out.write("  \t\t\t</div>\r\n");
      out.write("  \t\t</div>\r\n");
      out.write("  \t\t</td>\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  </table> \r\n");
      out.write("     <div style=\"position: relative; display: inline-block; width: 1200; height: 100%;\">\r\n");
      out.write("     \t<div id=\"leftFrame\" style=\"position: absolute;top:0;left:0; width: 150;height: 100%;background-color: #E7ECF3\" >\r\n");
      out.write("    \t\t\t\t <div style=\"position: absolute;top:0;left:-20; width: 150;height: 100%;background-color: #E7ECF3;z-index: -1\">\r\n");
      out.write("    \t\t\t\t \t<img alt=\"\" src=\"");
      out.print(path);
      out.write("/img/Logo1.png\">\r\n");
      out.write("    \t\t\t\t </div>\r\n");
      out.write("    \t\t\t\t \r\n");
      out.write("    \t\t\t\t  <div style=\"position: absolute;top:65;left:-20;z-index: 0\">\r\n");
      out.write("    \t\t\t\t  \t<img alt=\"\"  src=\"");
      out.print(path);
      out.write("/img/headerBgH.gif\" width=\"150\" height=\"20\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\"  onclick=\"\">\r\n");
      out.write("    \t\t\t\t  </div>\r\n");
      out.write("    \t\t\t\t  \t\r\n");
      out.write("    \t\t\t\t  \t\r\n");
      out.write("    \t\t\t\t  \t\r\n");
      out.write("    \t\t\t\t  \t<div style=\"position :absolute; top:70;z-index: 1;font-size: 14;font-weight: 700\" onclick=\"menuChange()\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t  \t\r\n");
      out.write("    \t\t\t\t  \t    分公司费用审批\r\n");
      out.write("    \t\t\t\t\t</div>\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t\r\n");
      out.write("    \t\t\t\t<div id=\"101\" style=\"position: absolute;top: 85;left:-20;width: 150\">\r\n");
      out.write("    \t\t\t\t\t<table id=\"branchApply\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\" bgcolor=\"#AFC7D6\">\r\n");
      out.write("    \t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr><td id=\"task\" class=\"td_text_menu\" onclick=\"gotoMainFlow(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t待办任务\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t");
if(userInfo.getUserRole().equals("0")){ 
      out.write("\t\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr height=\"22\" onclick=\"$('#2001').toggle();$('#2002').toggle();$('#2003').toggle();$('#2004').toggle();$('#2005').toggle();$('#3001').css('display','none');$('#3002').css('display','none');$('#3003').css('display','none')\"><td id=\"1002-td\" align=\"center\" class=\"td_text_menu2\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t费用单据填写\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"2001\"><td class=\"td_text_menu\" onclick=\"gotoCashExpenseApply(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t现金付款\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"2002\"><td class=\"td_text_menu\" onclick=\"gotoSpecialPayment(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t特殊付款\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"2003\"><td class=\"td_text_menu\"  onclick=\"gotoWagePayment(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t工资付款 \r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"2004\"><td class=\"td_text_menu\" onclick=\"gotoTripExpense(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t差旅费报销\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"2005\"><td class=\"td_text_menu\" onclick=\"gotoPaymentExpense(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t付款申请单\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t");
} 
      out.write("\r\n");
      out.write("    \t\t\t\t\t\t<tr height=\"22\" onclick=\"$('#3001').toggle();$('#3002').toggle(); $('#3003').toggle();$('#2001').css('display','none');$('#2002').css('display','none');$('#2003').css('display','none');$('#2004').css('display','none');$('#2005').css('display','none');\"><td  id=\"1003-td\" align=\"center\" class=\"td_text_menu2\"   onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t查询\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"3001\"><td class=\"td_text_menu\"  onclick=\"gotoPurposeMergeQuery(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t费用单据查询\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"3002\"><td class=\"td_text_menu\"  onclick=\"gotoShopExpenseApportion(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t店铺分摊费用查询\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t\t<tr id=\"3003\"><td class=\"td_text_menu\"  onclick=\"gotoSubjectMergeQuery(this)\" onmouseover=\"mouseonChange(this)\" onmouseout=\"mouseoutChange(this)\">\r\n");
      out.write("    \t\t\t\t\t\t科目单据查询\r\n");
      out.write("    \t\t\t\t\t\t</td></tr>\r\n");
      out.write("    \t\t\t\t\t</table>\r\n");
      out.write("    \t\t\t\t\t</div>\t\r\n");
      out.write("    \t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\r\n");
      out.write("    \t\t\t\t\t\r\n");
      out.write("    \t\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div id=\"barFrame\" style=\"position: absolute;top:0;left:120; width: 10;height: 100%;background-color: #EFF8FF\">\r\n");
      out.write("    \t\t<img id='barImg' alt=\"\"  src=\"img/changebar.JPG\" onclick=\"changeArea()\" style=\"position: absolute;top:40%;\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div id=\"mainFrame\" style=\"position: absolute;top:0;left:130;width: 1100;height: 100%;background-color: blue\">\r\n");
      out.write("    \t\t<iframe id=\"detailView\" name=\"detailView\" width=\"100%\" height=\"100%\" frameborder=\"0\" src=\"");
      out.print(path);
      out.write("/expenseMainFlow.do?action=init&username=");
      out.print(request.getAttribute("username") );
      out.write("\"></iframe>\r\n");
      out.write("    \t</div>\r\n");
      out.write("    </div>\r\n");
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
