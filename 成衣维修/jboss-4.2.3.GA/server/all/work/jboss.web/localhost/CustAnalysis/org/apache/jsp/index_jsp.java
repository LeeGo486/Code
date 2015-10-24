package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import com.custanalysis.entity.User;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=UTF-8");
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
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>异店查询</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"./css/common.css\" type=\"text/css\"></link>\r\n");
      out.write("    <script type=\"text/javascript\" src=\"./js/jquery-1.7.2.min.js\"></script>\r\n");
      out.write("    <script type=\"text/javascript\" src=\"./js/jquery.dataTables.min.js\"></script>\r\n");
      out.write("  \t<link rel=\"stylesheet\" href=\"./dataTables/css/jquery.dataTables.css\" type=\"text/css\"></link>\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("    \tvar oTable;\r\n");
      out.write("    \tvar xmlHttp1;\r\n");
      out.write("    \tvar PARAMTER_VALUE = null;   \r\n");
      out.write("    \t\r\n");
      out.write("    \t$(document).ready(function(){\r\n");
      out.write("    \t\toTable = $(\"#listData\").dataTable({\r\n");
      out.write("\t\t\t\t\"bFilter\": false,\r\n");
      out.write("\t\t\t\t\"bSort\": true,\r\n");
      out.write("\t\t\t\t\"bAutoWidth\": true,\r\n");
      out.write("\t\t\t\t\"bLengthChange\": false,\r\n");
      out.write("\t\t\t\t\"bInfo\": false,\r\n");
      out.write("\t\t\t\t\"bProcessing\": true,\r\n");
      out.write("\t\t\t\t\"bPaginate\": false,\r\n");
      out.write("\t\t\t\t\"bScrollInfinite\": true,\r\n");
      out.write("\t\t        \"sScrollX\": \"1000px\",\r\n");
      out.write("\t\t        \"oLanguage\": {\r\n");
      out.write("\t\t\t      \"sEmptyTable\": \"没有记录\"\r\n");
      out.write("\t\t\t    }\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t//getList(\"\",\"\",\"\");\r\n");
      out.write("    \t});\r\n");
      out.write("    \t\r\n");
      out.write("    \tfunction getParamter(paramName) {   \r\n");
      out.write("\t\t    if(!PARAMTER_VALUE) {   //第一次初始化   \r\n");
      out.write("\t\t        PARAMTER_VALUE = new Array();   \r\n");
      out.write("\t\t        var paramStr = location.search.substring(1);   \r\n");
      out.write("\t\t        var paramArr = paramStr.split(\"&\");   \r\n");
      out.write("\t\t        var len = paramArr.length;\r\n");
      out.write("\t\t        var index;     \r\n");
      out.write("\t\t        for(var i = 0; i < len; i++) { \r\n");
      out.write("\t\t        \tindex = paramArr[i].indexOf(\"=\");  \r\n");
      out.write("\t\t            PARAMTER_VALUE[paramArr[i].substring(0,index)] = paramArr[i].substring(index+1,paramArr[i].length);   \r\n");
      out.write("\t\t        }   \r\n");
      out.write("\t\t    }   \r\n");
      out.write("\t\t    var paramValue = PARAMTER_VALUE[paramName];   \r\n");
      out.write("\t\t    if(paramValue) {   \r\n");
      out.write("\t\t        return paramValue;   \r\n");
      out.write("\t\t    } else {\r\n");
      out.write("\t\t    \treturn \"\";\r\n");
      out.write("\t\t    }   \r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction createXMLHttpRequest() {\r\n");
      out.write("\t\t\tif (window.ActiveXObject) {\r\n");
      out.write("\t\t\t\txmlHttp = new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("\t\t\t} else if (window.XMLHttpRequest) {\r\n");
      out.write("\t\t\t\txmlHttp = new XMLHttpRequest();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\treturn xmlHttp;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction getList(name,mobile,card) {\t\t\t\r\n");
      out.write("\t\t\txmlHttp1 = createXMLHttpRequest();\r\n");
      out.write("\t\t\txmlHttp1.onreadystatechange = getListProcessor;\r\n");
      out.write("\t\t\txmlHttp1.open(\"GET\",\"AjaxServlet?action=getList&userid=\"+getParamter(\"userid\")+\"&name=\"+encodeURI(name)+\"&mobile=\"+mobile+\"&card=\"+card+\"&tm=\"+new Date().toString());\r\n");
      out.write("\t\t\txmlHttp1.setRequestHeader(\"Content-Type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\t\t\txmlHttp1.send(null);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction getListProcessor() {\r\n");
      out.write("\t\t\tvar html = \"\";\r\n");
      out.write("\t\t\tif (xmlHttp1.readyState == 4) {\r\n");
      out.write("\t\t\t\tif (xmlHttp1.status == 200) {\r\n");
      out.write("\t\t\t\t\toTable.fnDestroy();\r\n");
      out.write("\t\t\t\t\tvar obj = eval('('+xmlHttp1.responseText+')');\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tfor (var i = 0;i < obj.List.length;i++) {\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<tr>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='depot'>\"+obj.List[i].DEPOT+\"</td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='name'>\"+obj.List[i].ACCOUNTNAME+\"</td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='mobile'>\"+obj.List[i].MOBILE+\"</td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='card'>\"+obj.List[i].CARD+\"</td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='date'>\"+obj.List[i].DATE+\"</td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"<td class='operate'><a href='./GetUser?\"+obj.List[i].URL+\"'>查看</a></td>\";\r\n");
      out.write("\t\t\t\t\t\thtml = html + \"</tr>\";\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t$(\"#listData tbody\").html(html);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\toTable = $(\"#listData\").dataTable({\r\n");
      out.write("\t\t\t\t\t\t\"bFilter\": false,\r\n");
      out.write("\t\t\t\t\t\t\"bSort\": true,\r\n");
      out.write("\t\t\t\t\t\t\"bAutoWidth\": true,\r\n");
      out.write("\t\t\t\t\t\t\"bLengthChange\": false,\r\n");
      out.write("\t\t\t\t\t\t\"bInfo\": false,\r\n");
      out.write("\t\t\t\t\t\t\"bProcessing\": true,\r\n");
      out.write("\t\t\t\t\t\t\"bPaginate\": false,\r\n");
      out.write("\t\t\t\t\t\t\"bScrollInfinite\": true,\r\n");
      out.write("\t\t\t\t        \"sScrollX\": \"1000px\",\r\n");
      out.write("\t\t\t\t        \"oLanguage\": {\r\n");
      out.write("\t\t\t\t\t      \"sEmptyTable\": \"没有记录\"\r\n");
      out.write("\t\t\t\t\t    }\r\n");
      out.write("\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("    </script>\r\n");
      out.write("  </head>\r\n");
      out.write("  <body>\r\n");
      out.write("    <div id=\"title\">\r\n");
      out.write("    \t<div id=\"sign\">CRM Assistant</div>\r\n");
      out.write("    \t<div id=\"titleName\">异店查询</div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <div id=\"search\">\r\n");
      out.write("    \t<div>姓名\r\n");
      out.write("    \t\t<input type=\"text\" id=\"name\"/>\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div>手机\r\n");
      out.write("    \t\t<input type=\"text\" id=\"mobile\" maxlength=\"11\" style=\"ime-mode: disabled;\" onkeyup=\"this.value=this.value.replace(/\\D/g,'')\"/>\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div>卡号\r\n");
      out.write("    \t\t<input type=\"text\" id=\"code\"/>\r\n");
      out.write("    \t</div>\r\n");
      out.write("    \t<div>\r\n");
      out.write("    \t\t<input type=\"button\" id=\"sel\" value=\"查询\"/>\r\n");
      out.write("    \t</div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <table id=\"listData\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<thead>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<th class=\"depot\">店铺名称</th>\r\n");
      out.write("    \t\t\t<th class=\"name\">姓名</th>\r\n");
      out.write("    \t\t\t<th class=\"mobile\">手机</th>\r\n");
      out.write("    \t\t\t<th class=\"card\">卡号</th>\r\n");
      out.write("    \t\t\t<th class=\"date\">最近消费日期</th>\r\n");
      out.write("    \t\t\t<th class=\"operate\">操作</th>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</thead>\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("    \t$(\"#sel\").click(function(){\r\n");
      out.write("    \t\tif ($(\"#name\").val() == \"\" && $(\"#mobile\").val() == \"\" && $(\"#code\").val() == \"\")\r\n");
      out.write("    \t\t\talert(\"必须输入一个条件\");\r\n");
      out.write("    \t\telse if ($(\"#name\").val() != \"\" && $(\"#name\").val().length < 2)\r\n");
      out.write("    \t\t\talert(\"姓名长度必须大于等于2位\");\r\n");
      out.write("    \t\telse if ($(\"#mobile\").val() != \"\" && $(\"#mobile\").val().length != 11)\r\n");
      out.write("    \t\t\talert(\"手机号码长度必须为11位\");\r\n");
      out.write("    \t\telse\r\n");
      out.write("    \t\t\tgetList($(\"#name\").val(),$(\"#mobile\").val(),$(\"#code\").val());\r\n");
      out.write("    \t});\r\n");
      out.write("    </script>\r\n");
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
