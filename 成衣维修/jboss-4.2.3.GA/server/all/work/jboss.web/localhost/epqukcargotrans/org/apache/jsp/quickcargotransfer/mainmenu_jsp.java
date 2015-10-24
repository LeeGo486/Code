package org.apache.jsp.quickcargotransfer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import ep.org.quickcargotransfer.javabean.UserInfo;

public final class mainmenu_jsp extends org.apache.jasper.runtime.HttpJspBase
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

String path = request.getContextPath();
System.out.println(path);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userinfo = (UserInfo) request.getSession().getAttribute("user_info");

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>快速调货</title>\r\n");
      out.write("    \r\n");
      out.write("\t<meta http-equiv=\"pragma\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"cache-control\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"expires\" content=\"0\">    \r\n");
      out.write("\t\r\n");
      out.write("\t <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/mycommon.css\">\r\n");
      out.write("\t\r\n");
      out.write("  </head>\r\n");
      out.write("  <script>\r\n");
      out.write("  function mouseonChange(obj){\r\n");
      out.write("      obj.style.cursor='hand';\r\n");
      out.write("  }\r\n");
      out.write("  function mouseonChangeText(obj){\r\n");
      out.write("      var cssName = obj.className;\r\n");
      out.write("      obj.className=cssName.substring(0,6)+'2';\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function mouseoutChange(obj){\r\n");
      out.write("      obj.style.cursor='move';\r\n");
      out.write("      \r\n");
      out.write("  }\r\n");
      out.write("  function mouseoutChangeText(obj){\r\n");
      out.write("  \t  var cssName = obj.className;\r\n");
      out.write("      obj.className=cssName.substring(0,6)+'1';\r\n");
      out.write("  }\r\n");
      out.write(" \r\n");
      out.write("  function initForm(){\r\n");
      out.write("  \t if(document.getElementById(\"comfirmed-hidden\").value!=0){\r\n");
      out.write("  \t \tdocument.getElementById(\"comfirmed\").className='text2_1';\r\n");
      out.write("  \t }\r\n");
      out.write("  \t \r\n");
      out.write("  \t if(document.getElementById(\"transfered-hidden\").value!=0){\r\n");
      out.write("  \t \tdocument.getElementById(\"transfered\").className='text2_1';\r\n");
      out.write("  \t }\r\n");
      out.write("  \t \r\n");
      out.write("  \t if(document.getElementById(\"beiconfirm-hidden\").value!=0){\r\n");
      out.write("  \t \tdocument.getElementById(\"beiconfirm\").className='text2_1';\r\n");
      out.write("  \t }\r\n");
      out.write("  \t \r\n");
      out.write("  \t if(document.getElementById(\"betransfer-hidden\").value!=0){\r\n");
      out.write("  \t \tdocument.getElementById(\"betransfer\").className='text2_1';\r\n");
      out.write("  \t }\r\n");
      out.write("  \t \r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function searchCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/searchCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"我要找货\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function responseCargoApply(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/responseCargoApply.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"回复要货请求\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function notifyCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/notifyCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"通知发货\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function sendCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/sendCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"发货\", \"scrollbars=yes,width=1200px,height=800px,resizable=no,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("    \r\n");
      out.write("  \r\n");
      out.write("  function viewReport(zt){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/baseReport.do?action=init&zt=\"+zt;\r\n");
      out.write("  \twindow.open(url, \"报表查询\", \"scrollbars=yes,width=1200px,height=600px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function viewCargoApplyRes(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/viewCargoApplyRes.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"查看要货回复\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function viewWaitSendCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/waitSendCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"查看待发货品\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function receiveCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/receiveCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"收货\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function waitSendCargoNotify(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/waitSendNotify.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"等待发货通知\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("   function waitReceiveCargo(){\r\n");
      out.write("  \tvar url = document.getElementById(\"webConent\").value+\"/waitReceiveCargo.do?action=init\";\r\n");
      out.write("  \twindow.open(url, \"查看在途货品\", \"scrollbars=yes,width=1200px,height=800px,resizable=yes,menubar=no,status=no,location=no\");\t\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  </script>\r\n");
      out.write("  \r\n");
      out.write("  <body onload=\"initForm()\">\r\n");
      out.write("    <input type=\"hidden\" id=\"comfirmed-hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.comfirmed}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("   \t<input type=\"hidden\" id=\"transfered-hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.transfered}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("   \t<input type=\"hidden\" id=\"beiconfirm-hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.beiconfirm}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("    <input type=\"hidden\" id=\"betransfer-hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.betransfer}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("    <input type=\"hidden\" id=\"webConent\" value=\"");
      out.print(path);
      out.write("\">\r\n");
      out.write("    \t\r\n");
      out.write("    <div style=\"position:relative;width: 926;height: 434;vertical-align: middle;\" align=\"center\">\r\n");
      out.write("    \t<div style=\"width: 100%;height: 100%;vertical-align: middle;\" align=\"center\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main1.JPG\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div style=\"position: absolute;top: 50;left: 190\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main2.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"searchCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 50;height: 10;position: absolute;top: 120;left: 205\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"searchCargo()\">我要找货</div>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div style=\"position: absolute;top: 62;left: 385\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main3.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"viewCargoApplyRes()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("   \t\t<div class=\"text1_1\" style=\"width: 75;height: 10;position: absolute;top: 120;left: 380\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"viewCargoApplyRes()\">查看要货回复</div> \r\n");
      out.write("   \t\t\r\n");
      out.write("   \t\t<div style=\"position: absolute;top: 54;left: 505\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main4.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"notifyCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div id=\"comfirmed\" class=\"text1_1\" style=\"width: 75;height: 10;position: absolute;top: 120;left: 500\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"notifyCargo()\">通知发货(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.comfirmed}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(")</div> \r\n");
      out.write("    \t\r\n");
      out.write("    \t<div style=\"position: absolute;top: 54;left: 625\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main5.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"viewWaitSendCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 75;height: 10;position: absolute;top: 120;left: 620\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"viewWaitSendCargo()\">查看待发货品</div> \r\n");
      out.write("    \t\r\n");
      out.write("    \t<div style=\"position: absolute;top: 54;left: 730\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main6.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"receiveCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t\r\n");
      out.write("    \t<div id=\"transfered\" class=\"text1_1\" style=\"width: 75;height: 10;position: absolute;top: 120;left: 720\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"receiveCargo()\">收货(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.transfered}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(")</div> \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 180;left: 385\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main7.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"responseCargoApply()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div id=\"beiconfirm\" class=\"text1_1\" style=\"width: 95;height: 10;position: absolute;top: 235;left: 380\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"responseCargoApply()\">回复要货请求(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.beiconfirm}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(")</div> \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 176;left: 507\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main8.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"waitSendCargoNotify()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 235;left: 495\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"waitSendCargoNotify()\">等待发货通知</div> \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 175;left:630\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main9.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"sendCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div id=\"betransfer\" class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 235;left: 615\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"sendCargo()\">发货(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${cargoTransferInfo.betransfer}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(")</div> \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 180;left:725\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main10.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"waitReceiveCargo()\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 235;left: 720\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"waitReceiveCargo()\">查看在途货品</div> \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 287;left:186\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main11.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"viewReport('已取消')\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 350;left: 175\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"viewReport('已取消')\">被取消通知发货</div> \r\n");
      out.write("  \r\n");
      out.write("    \t<div style=\"position: absolute;top: 287;left:295\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main12.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"viewReport('不发货')\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 350;left: 285\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"viewReport('不发货')\">被取消发货</div> \r\n");
      out.write("  \r\n");
      out.write("    \r\n");
      out.write("    \t<div style=\"position: absolute;top: 286;left:395\">\r\n");
      out.write("    \t\t<img border=\"0\" src=\"");
      out.print(path);
      out.write("/img/main13.JPG\" onmouseover=\"mouseonChange(this)\" onclick=\"viewReport('已收货')\">\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div class=\"text1_1\" style=\"width: 90;height: 10;position: absolute;top: 350;left: 380\" onmouseover=\"mouseonChange(this);mouseonChangeText(this)\" onmouseout=\"mouseoutChange(this);mouseoutChangeText(this)\" onclick=\"viewReport('已收货')\">成功的调货</div> \r\n");
      out.write(" \t\t<div style=\"width:720;height:10;position: absolute;top: 390;left: 400\">\r\n");
      out.write(" \t\t\t<font size=\"2\">店铺：");
      out.print(userinfo.getJ_username());
      out.write("</font>\r\n");
      out.write(" \t\t</div>\r\n");
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
