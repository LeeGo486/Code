package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.math.BigDecimal;

public final class viewAppraise_jsp extends org.apache.jasper.runtime.HttpJspBase
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
ArrayList appraiseList = (ArrayList)request.getAttribute("appraiseList");
int listLen = 0;
if(appraiseList != null){
	listLen = appraiseList.size();
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("    \r\n");
      out.write("    <title>查看评分</title>\r\n");
      out.write("    \r\n");
      out.write("\t<meta http-equiv=\"pragma\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"cache-control\" content=\"no-cache\">\r\n");
      out.write("\t<meta http-equiv=\"expires\" content=\"0\">    \r\n");
      out.write("\t<meta http-equiv=\"keywords\" content=\"keyword1,keyword2,keyword3\">\r\n");
      out.write("\t<meta http-equiv=\"description\" content=\"This is my page\">\r\n");
      out.write("\t<!--\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">\r\n");
      out.write("\t-->\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  \r\n");
      out.write("  <body bgcolor=\"#F32110\">\r\n");
      out.write("    <table>\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td colspan=\"4\" align=\"center\">\r\n");
      out.write("    \t\t\t<b> 星级党员评选总分排名</b>\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td><b>排名</b></td>\r\n");
      out.write("    \t\t<td><b>党员姓名</b></td>\r\n");
      out.write("    \t\t<td></td>\r\n");
      out.write("    \t\t<td><b>总分</b></td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t\r\n");
      out.write("    \t");

    	String dyname=null;
    	int totalpoint=0;
    	float ratio = 0;
    	if(listLen!=0){
    		
    		ratio = (float) 600/((BigDecimal)((Map)appraiseList.get(0)).get("totalpoint")).intValue();
    	}
    	for(int i=0;i<listLen;i++){ 
    		Map appraise = (Map)appraiseList.get(i);
    		dyname =(String) appraise.get("dyname");
    		totalpoint=((BigDecimal)((Map)appraiseList.get(i)).get("totalpoint")).intValue();
    		System.out.println(totalpoint*ratio);
    	
      out.write("\r\n");
      out.write("    \t\r\n");
      out.write("    \t<tr>\r\n");
      out.write("    \t\t<td width=\"40\">\r\n");
      out.write("    \t\t\t");
      out.print(i+1);
      out.write("\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td width=\"80\">\r\n");
      out.write("    \t\t\t");
      out.print(dyname);
      out.write("\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\t<td width=\"600\">\r\n");
      out.write("    \t\t\t<hr size=\"10\" width=\"");
      out.print(totalpoint*ratio);
      out.write("\" color=\"blue\" align=\"left\">\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t\t\t\r\n");
      out.write("    \t\t<td width=\"80\">\r\n");
      out.write("    \t\t\t");
      out.print(totalpoint);
      out.write("分\r\n");
      out.write("    \t\t</td>\r\n");
      out.write("    \t</tr>\r\n");
      out.write("    \t\r\n");
      out.write("    \t");
}
      out.write("\r\n");
      out.write("    \t\r\n");
      out.write("    </table>\r\n");
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
