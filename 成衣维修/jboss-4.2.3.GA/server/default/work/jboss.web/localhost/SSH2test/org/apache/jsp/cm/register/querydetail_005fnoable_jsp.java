package org.apache.jsp.cm.register;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class querydetail_005fnoable_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\r');
      out.write('\n');

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
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset= GBK  \">\r\n");
      out.write("    \r\n");
      out.write("    <title>维修登记详细</title>\r\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"");
      out.print(path);
      out.write("/js/maintain.js\" charset=\"gbk\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/maintain.css\">\r\n");
      out.write("\t<meta http-equiv=\"pragma\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"cache-control\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"expires\" content=\"0\">    \r\n");
      out.write("\t<meta http-equiv=\"keywords\" content=\"keyword1,keyword2,keyword3\">\r\n");
      out.write("\t<meta http-equiv=\"description\" content=\"This is my page\">\r\n");
      out.write("\t\r\n");
      out.write(" \r\n");
      out.write(" <script type=\"text/javascript\">\r\n");
      out.write(" $(function(){\r\n");
      out.write("\t\tvar guid='");
out.print(request.getParameter("guid"));
      out.write("';\r\n");
      out.write("\t\t var zt = '");
out.print(request.getParameter("zt"));
      out.write("';\r\n");
      out.write("\t\tgetDetail(guid,zt);\r\n");
      out.write("})      \r\n");
      out.write("   \r\n");
      out.write("      \r\n");
      out.write(" </script>\r\n");
      out.write("   \r\n");
      out.write("  <style type=\"text/css\">\r\n");
      out.write("  \r\n");
      out.write("  .output-body{readOnly:expression(this.readOnly=true);border:0px;}\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("\t\tlabel{\r\n");
      out.write("\t\t\twidth:120px;\r\n");
      out.write("\t\t\tdisplay:block;\r\n");
      out.write("\t\t}\r\n");
      out.write("/*border:1px solid #fffffb; textarea {border:1px solid #fffffb;}\r\n");
      out.write("*/\r\n");
      out.write("input {width: 100%;border:1px solid #fffffb;}\r\n");
      out.write("select {width: 100%;border:1px solid #fffffb;}\r\n");
      out.write("textarea {border:1px solid #fffffb;}\r\n");
      out.write("\r\n");
      out.write("input.diabled {disabled :}\r\n");
      out.write("table.gridtable {\r\n");
      out.write("    font-family: verdana,arial,sans-serif;\r\n");
      out.write("    font-size:9px;\r\n");
      out.write("    color:#000000;\r\n");
      out.write("    border-width: 1px;\r\n");
      out.write("    border-color: #666666; \r\n");
      out.write("    border-collapse: collapse;\r\n");
      out.write("    width: 100%;\r\n");
      out.write("}\r\n");
      out.write("table.gridtable th {\r\n");
      out.write("    border-width: 1px;\r\n");
      out.write("    padding: 8px;\r\n");
      out.write("    border-style: solid;\r\n");
      out.write("    border-color: #666666;\r\n");
      out.write("    background-color: #dedede;\r\n");
      out.write("    width: 123px;\r\n");
      out.write("}\r\n");
      out.write("table.gridtable td {\r\n");
      out.write("    border-width: 1px;\r\n");
      out.write("    padding: 8px;\r\n");
      out.write("    border-style: solid;\r\n");
      out.write("    border-color: #666666;\r\n");
      out.write("    background-color: #ffffff;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("table.intable {\r\n");
      out.write("    font-family: verdana,arial,sans-serif;\r\n");
      out.write("    font-size:9px;\r\n");
      out.write("    color:#000000;\r\n");
      out.write("    border-width: 1px;\r\n");
      out.write("    border-color: #fffffb;\r\n");
      out.write("    border-collapse: collapse;\r\n");
      out.write("    width: 100%;\r\n");
      out.write("}\r\n");
      out.write("table.intable td {\r\n");
      out.write("    border-width: 1px;\r\n");
      out.write("    padding: 8px;\r\n");
      out.write("    border-style: solid;\r\n");
      out.write("    border-color: #fffffb;\r\n");
      out.write("    background-color: #fffffb;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("tr.head {\r\n");
      out.write("border-color: red;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  \r\n");
      out.write("  <body>\r\n");
      out.write("   <div id=\"header\" class=\"toolbar\"><input type=\"text\" id=\"zt\" width=\"100%\" height=\"100%\"/>\r\n");
      out.write(" <a id=\"save020\" class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-redo'\" onclick=\"saveMaintain(id,1)\">重新判定</a>\r\n");
      out.write("   </div>\r\n");
      out.write("\t<div style=\"background:#fafafa;padding:10px;width:800px;height:800px;\">\r\n");
      out.write("\t    <form id=\"ff\" method=\"post\" novalidate>\r\n");
      out.write("\t    <table class=\"gridtable\">\r\n");
      out.write("\t\t    <tr></tr>\r\n");
      out.write("\t\t    <tr class=\"head\" ><td colspan=\"3\"><input id=\"guid\" type=\"text\" value=\"");
out.print(request.getParameter("guid"));
      out.write("\"></input></td><td><label >维修单号:</label></td><td colspan=\"2\"><input id=\"wxdh\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t     \r\n");
      out.write("\t\t     <tr><th rowspan=\"3\">店铺信息</th>\t<th>店铺编码</th><td><select id=\"dpbm\"  style=\"width: 220px;border:1px solid #fffffb;\" disabled=\"disabled\"></select> </td><th>店铺名称</th><td><input id=\"dpmc\" disabled=\"disabled\" class=\"easyui-validatebox\" type=\"text\"  \"></input></td><td><input ID=\"dplx\" disabled=\"disabled\" style=\"width: 30px\"></input> </td></tr>\r\n");
      out.write("\t\t     <tr >\t\t\t\t\t\t\t<th>店长姓名</th><td><input id=\"dzxm\" disabled=\"disabled\"></input></td><th>店长联系电话</th><td colspan=\"2\"><input id=\"dzlxdh\" disabled=\"disabled\"></input</td></tr>\r\n");
      out.write("\t\t     <tr>\t\t\t\t\t\t\t<th>维修仓编号</th><td><input id=\"wxcbm\" disabled=\"disabled\"></input></td><th>维修仓名称</th><td colspan=\"2\"><input id=\"wxcmc\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t     \r\n");
      out.write("\t\t     <tr><th rowspan=\"2\">维修接单信息</th><th>受理导购*</th><td><input id=\"sldg\" disabled=\"disabled\" style=\"width: 220px;\"></input></td><th>导购联系电话*</th><td colspan=\"2\"><input id=\"dglxdh\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t     <tr>\t\t<th>顾客维修</th><td colspan=\"4\"><input type=\"checkbox\" disabled=\"disabled\" id=\"isgkwx\" value=\"1\" style=\"width: 20px;\"> </input> </td></tr>\r\n");
      out.write("\t\t     \r\n");
      out.write("\t\t    <tr><th rowspan=\"3\">顾客信息</th>\t<th>VIP卡号</th><td><input id=\"vipkh\" disabled=\"disabled\"></input></td><th>顾客姓名*</th><td colspan=\"2\"><input id=\"gkxm\" disabled=\"disabled\" data-options=\"required:true\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>顾客联系电话</th><td><input id=\"gklxdh\" disabled=\"disabled\"></input></td><th>售出时间*</th><td colspan=\"2\"><input id=\"scsj\" class=\"easyui-datebox\" disabled=\"disabled\" style=\"width: 220px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>同意付费维修</th><td><input  type=\"checkbox\"  disabled=\"disabled\" id=\"isffwx\" value=\"1\" style=\"width: 20px;\"> </input> </td><th>紧急程度</th><td colspan=\"2\"><input id=\"jjcd\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    \r\n");
      out.write("\t\t    <tr><th rowspan=\"2\">待修产品信息</th>\t<th>款号*</th><td><input id=\"kh\"  disabled=\"disabled\" onBlur=\"checkKh(value)\"></input></td><th>退回日期</th><td colspan=\"2\" ><input id=\"thrq\" disabled=\"disabled\" class=\"easyui-datebox\" style=\"width: 220px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>问题描述*</th><td colspan=\"4\"><textarea id=\"wtms\" disabled=\"disabled\" style=\"height:60px;width: 580px\"></textarea></td></tr>\r\n");
      out.write("\t\t    \r\n");
      out.write("\t\t    <tr><th rowspan=\"4\">物流信息</th>\t<th>运输公司*</th><td><input id=\"ysgs\" disabled=\"disabled\" style=\"width: 220px;\"></input></td><th>运单号</th><td colspan=\"2\"><input id=\"ydh\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>发货地址</th><td colspan=\"4\"><input id=\"fhdz\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>收货地址</th><td colspan=\"4\"><input id=\"shdz\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>收货人</th><td><input id=\"shr\" disabled=\"disabled\"></input></td><th>收货人联系电话</th><td  colspan=\"2\"><input id=\"shrlxdh\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    \r\n");
      out.write("\t\t    <tr><th>备注信息</th> <td colspan=\"5\"><textarea id=\"bzxx\" disabled=\"disabled\" style=\"height:100%;width:100%\"></textarea></td> </tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t    <tr><th rowspan=\"14\">品检判定</th>\t<th colspan=\"5\">问题主因(必填)</th></tr>\r\n");
      out.write("\t\t    \r\n");
      out.write("\t\t    \r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>维修性质</th><td><select id=\"wxxz1\" style=\"width:200px;\"   disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"0\">  </option><option value=\"1\">帮忙维修</option><option value=\"2\">质量维修</option></select>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t</td><th>问题点</th><td colspan=\"2\"><input id=\"wtd1\"  disabled=\"disabled\" class=\"easyui-combogrid\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>起因</th><td><input id=\"qy1\"  disabled=\"disabled\" class=\"easyui-combogrid\" style=\"width:200px;\"></input></td><th>现象点</th><td colspan=\"2\"><input id=\"xxd1\"  disabled=\"disabled\" class=\"easyui-combogrid\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th colspan=\"5\">问题次因(选填)</th></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>维修性质</th><td><select id=\"wxxz2\" style=\"width:200px;\"  disabled=\"disabled\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"0\">  </option><option value=\"1\">帮忙维修</option><option value=\"2\">质量维修</option></select></td><th>问题点</th><td colspan=\"2\"><input id=\"wtd2\"  disabled=\"disabled\" class=\"easyui-combogrid\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>起因</th><td><input id=\"qy2\" class=\"easyui-combogrid\" style=\"width:200px;\"  disabled=\"disabled\"></input></td><th>现象点</th><td colspan=\"2\"><input id=\"xxd2\" class=\"easyui-combogrid\"  disabled=\"disabled\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th colspan=\"5\">判定结果</th></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>判定处理方式*</th><td><select id=\"pdclfs\"  disabled=\"disabled\" class=\"easyui-combobox\" name=\"state\" style=\"width:200px;\" data-options=\"required:true\" >\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"0\">  </option><option value=\"1\">产品退仓</option><option value=\"2\">不能维修，退回店铺</option><option value=\"3\">可以维修</option></select></td><th>退仓处理结果</th><td colspan=\"2\"><input id=\"tccljg\" disabled=\"disabled\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>责任部门</th><td><input id=\"zrbm\"  disabled=\"disabled\" style=\"width:200px;\"></input></td><th>退货单号</th><td colspan=\"2\"><input  type=\"text\"   id=\"thdh\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>检测异议</th><td colspan=\"4\"><input id=\"jcyy\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>特修</th><td><select id=\"tx\" disabled=\"disabled\" class=\"easyui-combobox\" style=\"width:200px;\"><option value=\"0\" selected=\"selected\">否</option><option value=\"1\">是</option></select></td><th>计划维修天数</th><td colspan=\"2\"><input id=\"jhwxts\" disabled=\"disabled\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>是否收费</th><td><select id=\"sfsf\" disabled=\"disabled\" class=\"easyui-combobox\" style=\"width:200px;\"><option value=\"0\" selected=\"selected\">否</option><option value=\"1\">是</option></select></td><th>收费金额(元)</th><td colspan=\"2\"><input id=\"sfje\" disabled=\"disabled\" style=\"width:200px;\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>收费内容</th><td colspan=\"4\"><input id=\"sfnr\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr>\t\t\t\t\t\t\t<th>品检判定备注</th><td colspan=\"4\"><input id=\"pjpdbz\" disabled=\"disabled\"></input></td></tr>\r\n");
      out.write("\t\t    <tr><th>维修信息</th><th>维修人</th><td><input id=\"wxr\" disabled=\"disabled\"></input></td> <th>维修时间</th> <td colspan=\"2\"><input id=\"wxsj\" disabled=\"disabled\"></input></td> </tr>\r\n");
      out.write("\t\t<br></br>\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<table class=\"gridtable\">\r\n");
      out.write("\t\t<tr><td>登记人</td><td><input readonly=\"readonly\" id=\"djr\"/></td><td>登记时间</td><td><input readonly=\"readonly\" id=\"djsj\"/></td><td>品检判定人</td><td><input id=\"pjpdr\" readonly=\"readonly\"/></td><td>判定时间</td><td><input id=\"pjpdsj\" readonly=\"readonly\"/></td></tr>\r\n");
      out.write("\t\t<tr><td>特退审批人</td><td><input readonly=\"readonly\" id=\"ttspr\"/></td><td>审批时间</td><td><input readonly=\"readonly\" id=\"spsj\"/></td><td>维修确认人</td><td><input id=\"wxqrr\" readonly=\"readonly\"/></td><td>确认时间</td><td><input id=\"qrsj\" readonly=\"readonly\"/></td></tr> \r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t</div> \r\n");
      out.write("\t\t \r\n");
      out.write("\t    </table>\r\n");
      out.write("\t        \r\n");
      out.write("\t        \r\n");
      out.write("\t        <div></div>\r\n");
      out.write("\t        \r\n");
      out.write("\t        \r\n");
      out.write("\t    </form>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div >\r\n");
      out.write("\t           </div>\r\n");
      out.write("  </body>\r\n");
      out.write(" \r\n");
      out.write("</html>\r\n");
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
}
