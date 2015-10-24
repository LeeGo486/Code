package org.apache.jsp.quickcargotransfer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.quickcargotransfer.javabean.SendCargoInfo;

public final class sendCargoPrint_jsp extends org.apache.jasper.runtime.HttpJspBase
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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
SendCargoInfo sendCargoInfo = (SendCargoInfo)request.getAttribute("sendCargoInfo");


      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>调货单打印</title>\r\n");
      out.write("    \r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  function autoPrint(){\r\n");
      out.write("  \ttry{\r\n");
      out.write("\t\t\tif (document.all.eprint.defaultPrinterName.length==0){\r\n");
      out.write("\t\t\talert(\"请先安装打印机，再刷新本页面进行打印！\");\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("  \t\teprint.InitPrint();\r\n");
      out.write("  \t\teprint.header = \"\";\r\n");
      out.write("  \t\teprint.footer = \"\";\r\n");
      out.write("  \t\teprint.Preview();\r\n");
      out.write("  \t\twindow.close();\r\n");
      out.write("\t//document.all.eprint.Print(true);//不弹出打印对话框直接打印\r\n");
      out.write("\t}catch(e){\r\n");
      out.write("\t\tvar url=document.getElementById(\"webContext\").value+'/quickcargotransfer/webprintDownload.jsp';\r\n");
      out.write("\t\twindow.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("  <body onload=\"autoPrint()\">\r\n");
      out.write("     <object id=\"eprint\" classid=\"clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441\"  viewasext> </object>\r\n");
      out.write("          \r\n");
      out.write("     <br />\r\n");
      out.write("     <br />  \r\n");
      out.write("      <br />  \r\n");
      out.write("      <br />     \r\n");
      out.write("             客订单快速调货<br />\r\n");
      out.write("     <div align=\"center\"><font size=\"4\"><b> 浙江雅莹服装有限公司发货单</b></font></div>\r\n");
      out.write("   \t<table width=\"100%\" border=\"0\">\r\n");
      out.write("   \t\t<tr>\r\n");
      out.write("   \t\t\t<td  valign=\"top\" width=\"11%\"></td>\r\n");
      out.write("   \t\t\t<td valign=\"top\" width=\"20%\"></td>\r\n");
      out.write("   \t\t\t<td valign=\"top\" width=\"11%\"></td>\r\n");
      out.write("   \t\t\t<td valign=\"top\" width=\"27%\"></td>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\" width=\"11%\">制表日期：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\" width=\"20%\">");
      out.print(sendCargoInfo.getPrintDate());
      out.write("</td>\r\n");
      out.write("   \t\t</tr>\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t<tr>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\">发货单号：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getFhdh());
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\">发货仓店：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">[");
      out.print(sendCargoInfo.getSendDepotID() );
      out.write(']');
      out.print(sendCargoInfo.getSendDepotName() );
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td align=\"right\" valign=\"top\">总数：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getSendNum() );
      out.write(" </td>\r\n");
      out.write("   \t\t</tr>\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t<tr>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\">发货日期：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getSendDate() );
      out.write(" </td>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\">收货仓店：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">[");
      out.print(sendCargoInfo.getReceiveDepotID() );
      out.write(']');
      out.print(sendCargoInfo.getReceiveDepotName() );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" valign=\"top\">总额：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getCargoPrice());
      out.write("</td>\r\n");
      out.write("   \t\t</tr>\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t<tr>\r\n");
      out.write("   \t\t\t<td  align=\"right\" valign=\"top\">店铺地址：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getReceiveAddress());
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" valign=\"top\">店长：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getReceiveDZ() );
      out.write("</td>\r\n");
      out.write("   \t\t\t<td align=\"right\" valign=\"top\">电话：</td>\r\n");
      out.write("   \t\t\t<td valign=\"top\">");
      out.print(sendCargoInfo.getReceiveDH() );
      out.write("</td>\r\n");
      out.write("   \t\t</tr>\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t\r\n");
      out.write("   \t</table>  \r\n");
      out.write("  \r\n");
      out.write("  \t<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\" bgcolor=\"#000000\">\r\n");
      out.write("  \t\t<tr>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">款式</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">款式名称</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">包装方式</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">颜色</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"30%\" colspan=\"8\">F</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">数量</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">结算价</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">金额</td>\r\n");
      out.write("  \t\t</tr>\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t<tr>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">");
      out.print(sendCargoInfo.getStytleKH());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">");
      out.print(sendCargoInfo.getStytleMC());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"10%\">");
      out.print(sendCargoInfo.getColor());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\">");
      out.print(sendCargoInfo.getSize());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\" width=\"4%\"></td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\"  width=\"10%\">");
      out.print(sendCargoInfo.getSendNum() );
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\"  width=\"10%\">");
      out.print(sendCargoInfo.getJsj());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td bgcolor=\"#FFFFFF\"  width=\"10%\">");
      out.print(sendCargoInfo.getCargoPrice());
      out.write("</td>\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t\t</tr>\r\n");
      out.write("  \t\r\n");
      out.write("  \t</table>\r\n");
      out.write("  \r\n");
      out.write("  \t\r\n");
      out.write("  \t <br />\r\n");
      out.write("     <br />  \r\n");
      out.write("      <br />  \r\n");
      out.write("      <br />     \r\n");
      out.write("       <br />\r\n");
      out.write("     <br />  \r\n");
      out.write("      <br />  \r\n");
      out.write("      <br />     \r\n");
      out.write("       <br />\r\n");
      out.write("     <br />  \r\n");
      out.write("      <br />  \r\n");
      out.write("      <br />     \r\n");
      out.write("  \t <br />\r\n");
      out.write("     <br />  \r\n");
      out.write("      <br />  \r\n");
      out.write("      <br />     \r\n");
      out.write("  \t\r\n");
      out.write("  \t<table width=\"100%\">\r\n");
      out.write("  \t\t<tr>\r\n");
      out.write("  \t\t\t<td>合计金额：</td>\r\n");
      out.write("  \t\t\t<td>");
      out.print(sendCargoInfo.getCargoPrice());
      out.write("</td>\r\n");
      out.write("  \t\t\t<td>");
      out.print(sendCargoInfo.getChinaRMB() );
      out.write(" </td>\r\n");
      out.write("  \t\t\t<td>本页小计数量：</td>\r\n");
      out.write("  \t\t\t<td>");
      out.print(sendCargoInfo.getSendNum() );
      out.write(" </td>\r\n");
      out.write("  \t\t</tr>\r\n");
      out.write("  \t\t\r\n");
      out.write("  \t</table>\r\n");
      out.write("  \t<hr width=\"100%\" color=\"#000000\" size=\"1\"/>\r\n");
      out.write("  \t<table width=\"100%\">\r\n");
      out.write("  \t\t<tr>\r\n");
      out.write("  \t\t\t<td>审 核 人：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>登 帐 人：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>制 单 人：</td>\r\n");
      out.write("  \t\t\t<td>");
      out.print(sendCargoInfo.getTxr() );
      out.write("</td>\r\n");
      out.write("  \t\t\t<td>交 货 人：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>收 货 人：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t</tr>\r\n");
      out.write("  \t\t<tr>\r\n");
      out.write("  \t\t\t<td>审核日期：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>登帐日期：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>制单日期：</td>\r\n");
      out.write("  \t\t\t<td>");
      out.print(sendCargoInfo.getTxrq() );
      out.write("</td>\r\n");
      out.write("  \t\t\t<td>交货日期：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t\t<td>收货日期：</td>\r\n");
      out.write("  \t\t\t<td></td>\r\n");
      out.write("  \t\t</tr>\r\n");
      out.write("  \t</table>\r\n");
      out.write(" \r\n");
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
