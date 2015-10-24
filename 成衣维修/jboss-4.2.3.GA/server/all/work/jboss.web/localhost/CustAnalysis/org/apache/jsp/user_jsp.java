package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import com.custanalysis.entity.Category;
import com.custanalysis.entity.Communication;
import com.custanalysis.entity.Style;

public final class user_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.release();
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
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>一对一客户分析</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"./css/common.css\" type=\"text/css\"></link>\r\n");
      out.write("    <script type=\"text/javascript\" src=\"./js/jquery-1.7.2.min.js\"></script>\r\n");
      out.write("  </head>\r\n");
      out.write("  \r\n");
      out.write("  <body>\r\n");
      out.write("    <div id=\"title\">\r\n");
      out.write("    \t<div id=\"sign\">CRM Assistant</div>\r\n");
      out.write("    \t<div id=\"titleName\">一对一客户分析</div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <table id=\"basic\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"7\">基本资料</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">姓名：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ACCOUNTNAME}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">VIP卡号：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CODE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">手机：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${MOBILE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td id=\"photo\" rowspan=\"8\" class=\"toCenter\">照片</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">电话：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${PHONE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">客户经理：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${USERNAME}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">性别：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SEX}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">年龄：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${AGE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">生日：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${BIRTHDAY}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">发展日期：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${DEVELOP}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">身高：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${HEIGHT}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">体型：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${HABITUS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">肤色：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SKINCOLOR}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">性格特征：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${XGTZ}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">从事行业：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${INDUSTRY}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">岗位：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${JOB}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">Email：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${EMAIL}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">微信号：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">手机类型：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${PHONETYPE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">客户等级：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${VIPLEV}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">是否大客户：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ISCUSTOMER}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">方便接听电话时间：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CALLTIME}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">省份：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${PROVINCE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">城市：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CITY}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">是否愿意接收短信：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ISRECEVIED}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">地址：</td>\r\n");
      out.write("    \t\t\t<td colspan=\"6\" class=\"toLeft\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SHIPPINGADDRESS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">发票地址：</td>\r\n");
      out.write("    \t\t\t<td colspan=\"6\" class=\"toLeft\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${BILLINGADDRESS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"preferences\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"6\">会员偏好信息</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">个人爱好：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${PERSONALHABIT}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">家庭年收入：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ANNUALREVENUE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">消费类型：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${XFLX}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">经常消费的品牌：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CONSUMEBRANDS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">经常穿着的色系：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${DRESSCOLOR}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">颜色：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COLOR}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">获取品牌的渠道：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CHANNEL}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">接受的沟通方式：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${GTFS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">期望收到的惊喜：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${EXPECTGIFT}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的书籍：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${BOOKS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的杂志：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${MAGAZINE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的电影：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${MOVIE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的化妆品：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COSMETIC}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的香水：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${PERFUME}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的饮品：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${DRINKS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">喜爱的运动：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SPORTS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">美容保健：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${MRBJ}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">美容保健大类：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${MRBJDL}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">经常关注的信息：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${FOUCSINFO}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">是否热衷慈善：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${CHARITY}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">是否愿意收到本品牌的信息：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${RECEIVEMESSAGE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"spending\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"6\">消费信息</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">总消费金额：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ZSUMS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">总消费次数：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ZNUMS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">首单折扣：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${FDISCOUNT}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">首单实销金额：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${FBUYSUMS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">目前POS积分：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${POSJF}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\">12个月内消费金额：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SUMS12}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"recently\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"5\">最近一次消费情况</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter time\">时间</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter amount\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter nums\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter discount\">折扣</td>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toLeft\" id=\"skc\">款式：");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SKC}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${LBUYDATE}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${LBUYSUMS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${LNUMS}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${LDISCOUNT}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"plot\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td>最近一次消费情节</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toLeft\"></td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"comparison\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"11\">同期消费对比</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td colspan=\"2\" class=\"toCenter\">一季度</td>\r\n");
      out.write("    \t\t\t<td colspan=\"2\" class=\"toCenter\">二季度</td>\r\n");
      out.write("    \t\t\t<td colspan=\"2\" class=\"toCenter\">三季度</td>\r\n");
      out.write("    \t\t\t<td colspan=\"2\" class=\"toCenter\">四季度</td>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toCenter\">平均折扣</td>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toCenter\">消费次数</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">件数</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.year}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[0].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[0].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[1].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[2].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[2].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[3].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.quarter[3].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.discount}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR1.counts}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.year}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[0].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[0].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[1].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[2].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[2].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[3].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.quarter[3].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.discount}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR2.counts}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">合计：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[0].sumsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[0].numsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[1].sumsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[1].numsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[2].sumsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[2].numsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[3].sumsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.quarter[3].numsRateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.discount}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${YEAR3.counts}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"category\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>    \t\t\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"17\">消费品类（当前或上季）</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"3\" class=\"toCenter category\">春夏品类：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">品类：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">外套</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">衬衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裙子</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">连衣裙</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">针织衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裤子</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">风衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">大衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">毛衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">尼克服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">皮衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裘皮</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">棉服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">羽绒服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">饰品</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">件数：</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">全部：</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"3\" class=\"toCenter category\">秋冬品类：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">品类：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">外套</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">衬衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裙子</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">连衣裙</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">针织衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裤子</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">风衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">大衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">毛衫</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">尼克服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">皮衣</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">裘皮</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">棉服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">羽绒服</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">饰品</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">件数：</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter subcategory\">全部：</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"style\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t");

    		List<Style> s1 = (List<Style>)request.getAttribute("STYLE1");
    		List<Style> s2 = (List<Style>)request.getAttribute("STYLE2");
    		List<Style> s3 = (List<Style>)request.getAttribute("STYLE3");
    		int StyleNums1 = 1;
    		int StyleNums2 = 1;
    		int StyleNums3 = 1;
    		
    		if (s1 != null && s1.size() != 0) {
    			StyleNums1 = s1.size();
    		}  		
    		if (s2 != null && s2.size() != 0) {
    			StyleNums2 = s2.size();
    		}
    		if (s3 != null && s3.size() != 0) {
    			StyleNums3 = s3.size();
    		}
    		
      out.write("\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"");
      out.print(StyleNums1+StyleNums2+StyleNums3+1);
      out.write("\">消费产品的生活方式</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td colspan=\"");
      out.print(StyleNums2);
      out.write("\" class=\"toCenter\">EP</td>\r\n");
      out.write("    \t\t\t<td colspan=\"");
      out.print(StyleNums3);
      out.write("\" class=\"toCenter\">EPJ</td>\r\n");
      out.write("    \t\t\t<td colspan=\"");
      out.print(StyleNums1);
      out.write("\" class=\"toCenter\">E.PROSPER</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f4 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f4.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f4.setParent(null);
      // /user.jsp(383,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f4.setVar("i");
      // /user.jsp(383,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f4.setBegin(1);
      // /user.jsp(383,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f4.setEnd(StyleNums2);
      // /user.jsp(383,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f4.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f4 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f4 = _jspx_th_c_005fforEach_005f4.doStartTag();
        if (_jspx_eval_c_005fforEach_005f4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE2[i-1].name}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f4.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f4[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f4.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f4.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f4);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f5 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f5.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f5.setParent(null);
      // /user.jsp(386,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f5.setVar("i");
      // /user.jsp(386,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f5.setBegin(1);
      // /user.jsp(386,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f5.setEnd(StyleNums3);
      // /user.jsp(386,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f5.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f5 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f5 = _jspx_th_c_005fforEach_005f5.doStartTag();
        if (_jspx_eval_c_005fforEach_005f5 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE3[i-1].name}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f5.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f5[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f5.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f5.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f5);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f6 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f6.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f6.setParent(null);
      // /user.jsp(389,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f6.setVar("i");
      // /user.jsp(389,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f6.setBegin(1);
      // /user.jsp(389,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f6.setEnd(StyleNums1);
      // /user.jsp(389,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f6.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f6 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f6 = _jspx_th_c_005fforEach_005f6.doStartTag();
        if (_jspx_eval_c_005fforEach_005f6 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE1[i-1].name}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f6.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f6[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f6.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f6.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f6);
      }
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">去年消费</td>\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f7 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f7.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f7.setParent(null);
      // /user.jsp(395,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f7.setVar("i");
      // /user.jsp(395,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f7.setBegin(1);
      // /user.jsp(395,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f7.setEnd(StyleNums2);
      // /user.jsp(395,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f7.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f7 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f7 = _jspx_th_c_005fforEach_005f7.doStartTag();
        if (_jspx_eval_c_005fforEach_005f7 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE2[i-1].lastYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f7.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f7[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f7.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f7.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f7);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f8 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f8.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f8.setParent(null);
      // /user.jsp(398,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f8.setVar("i");
      // /user.jsp(398,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f8.setBegin(1);
      // /user.jsp(398,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f8.setEnd(StyleNums3);
      // /user.jsp(398,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f8.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f8 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f8 = _jspx_th_c_005fforEach_005f8.doStartTag();
        if (_jspx_eval_c_005fforEach_005f8 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE3[i-1].lastYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f8.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f8[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f8.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f8.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f8);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f9 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f9.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f9.setParent(null);
      // /user.jsp(401,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f9.setVar("i");
      // /user.jsp(401,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f9.setBegin(1);
      // /user.jsp(401,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f9.setEnd(StyleNums1);
      // /user.jsp(401,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f9.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f9 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f9 = _jspx_th_c_005fforEach_005f9.doStartTag();
        if (_jspx_eval_c_005fforEach_005f9 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE1[i-1].lastYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f9.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f9[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f9.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f9.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f9);
      }
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">今年消费</td>\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f10 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f10.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f10.setParent(null);
      // /user.jsp(407,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f10.setVar("i");
      // /user.jsp(407,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f10.setBegin(1);
      // /user.jsp(407,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f10.setEnd(StyleNums2);
      // /user.jsp(407,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f10.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f10 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f10 = _jspx_th_c_005fforEach_005f10.doStartTag();
        if (_jspx_eval_c_005fforEach_005f10 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE2[i-1].thisYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f10.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f10[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f10.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f10.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f10);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f11 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f11.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f11.setParent(null);
      // /user.jsp(410,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f11.setVar("i");
      // /user.jsp(410,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f11.setBegin(1);
      // /user.jsp(410,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f11.setEnd(StyleNums3);
      // /user.jsp(410,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f11.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f11 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f11 = _jspx_th_c_005fforEach_005f11.doStartTag();
        if (_jspx_eval_c_005fforEach_005f11 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE3[i-1].thisYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f11.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f11[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f11.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f11.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f11);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f12 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f12.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f12.setParent(null);
      // /user.jsp(413,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f12.setVar("i");
      // /user.jsp(413,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f12.setBegin(1);
      // /user.jsp(413,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f12.setEnd(StyleNums1);
      // /user.jsp(413,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f12.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f12 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f12 = _jspx_th_c_005fforEach_005f12.doStartTag();
        if (_jspx_eval_c_005fforEach_005f12 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE1[i-1].thisYearNums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f12.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f12[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f12.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f12.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f12);
      }
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">销售占比</td>\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f13 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f13.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f13.setParent(null);
      // /user.jsp(419,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f13.setVar("i");
      // /user.jsp(419,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f13.setBegin(1);
      // /user.jsp(419,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f13.setEnd(StyleNums2);
      // /user.jsp(419,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f13.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f13 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f13 = _jspx_th_c_005fforEach_005f13.doStartTag();
        if (_jspx_eval_c_005fforEach_005f13 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE2[i-1].rateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f13.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f13[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f13.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f13.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f13);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f14 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f14.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f14.setParent(null);
      // /user.jsp(422,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f14.setVar("i");
      // /user.jsp(422,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f14.setBegin(1);
      // /user.jsp(422,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f14.setEnd(StyleNums3);
      // /user.jsp(422,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f14.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f14 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f14 = _jspx_th_c_005fforEach_005f14.doStartTag();
        if (_jspx_eval_c_005fforEach_005f14 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE3[i-1].rateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f14.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f14[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f14.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f14.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f14);
      }
      out.write("\r\n");
      out.write("    \t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f15 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      _jspx_th_c_005fforEach_005f15.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f15.setParent(null);
      // /user.jsp(425,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f15.setVar("i");
      // /user.jsp(425,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f15.setBegin(1);
      // /user.jsp(425,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f15.setEnd(StyleNums1);
      // /user.jsp(425,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f15.setStep(1);
      int[] _jspx_push_body_count_c_005fforEach_005f15 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f15 = _jspx_th_c_005fforEach_005f15.doStartTag();
        if (_jspx_eval_c_005fforEach_005f15 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("    \t\t\t\t<td class=\"toCenter\">");
            out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${STYLE1[i-1].rateString}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
            out.write("</td>\r\n");
            out.write("    \t\t\t");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f15.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          return;
        }
      } catch (Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f15[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f15.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f15.doFinally();
        _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f15);
      }
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"frequency\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"13\">顾客消费频率分析</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">统计条件</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">1月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">2月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">3月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">4月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">5月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">6月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">7月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">8月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">9月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">10月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">11月</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">12月</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">消费金额</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f16(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\">消费次数</td>\r\n");
      out.write("    \t\t\t");
      if (_jspx_meth_c_005fforEach_005f17(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"ready\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"6\">顾客到店前的准备</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toLeft title\" id=\"skc\">准备：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter time\">时间</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter amount\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter nums\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter discount\">折扣</td>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toLeft\" id=\"skc\">款式：</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toLeft title\" id=\"skc\">购买：</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter time\">时间</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter amount\">金额</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter nums\">件数</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter discount\">折扣</td>\r\n");
      out.write("    \t\t\t<td rowspan=\"2\" class=\"toLeft\" id=\"skc\">款式：</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter\"></td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t</tbody>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table id=\"communication\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("    \t<tbody>\r\n");
      out.write("    \t\t<tr class=\"head\">\r\n");
      out.write("    \t\t\t<td colspan=\"4\">沟通记录（最近5次的沟通记录）</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t<tr>\r\n");
      out.write("    \t\t\t<td class=\"toCenter date\">维护时间</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter mode\">沟通方式</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter content\">维护内容</td>\r\n");
      out.write("    \t\t\t<td class=\"toCenter feedback\">顾客反馈</td>\r\n");
      out.write("    \t\t</tr>\r\n");
      out.write("    \t\t");
      if (_jspx_meth_c_005fforEach_005f18(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    \t</tbody>\r\n");
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

  private boolean _jspx_meth_c_005fforEach_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f0.setParent(null);
    // /user.jsp(310,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setVar("i");
    // /user.jsp(310,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setBegin(1);
    // /user.jsp(310,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setEnd(15);
    // /user.jsp(310,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
      if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SEASON1[i-1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f1 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f1.setParent(null);
    // /user.jsp(316,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setVar("i");
    // /user.jsp(316,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setBegin(1);
    // /user.jsp(316,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setEnd(15);
    // /user.jsp(316,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f1 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f1 = _jspx_th_c_005fforEach_005f1.doStartTag();
      if (_jspx_eval_c_005fforEach_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SEASON2[i-1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f1.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f2 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f2.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f2.setParent(null);
    // /user.jsp(341,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f2.setVar("i");
    // /user.jsp(341,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f2.setBegin(1);
    // /user.jsp(341,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f2.setEnd(15);
    // /user.jsp(341,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f2.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f2 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f2 = _jspx_th_c_005fforEach_005f2.doStartTag();
      if (_jspx_eval_c_005fforEach_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SEASON3[i-1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f2.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f2[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f2.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f2.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f3 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f3.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f3.setParent(null);
    // /user.jsp(347,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f3.setVar("i");
    // /user.jsp(347,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f3.setBegin(1);
    // /user.jsp(347,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f3.setEnd(15);
    // /user.jsp(347,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f3.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f3 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f3 = _jspx_th_c_005fforEach_005f3.doStartTag();
      if (_jspx_eval_c_005fforEach_005f3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${SEASON4[i-1].nums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f3.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f3[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f3.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f3.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f16(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f16 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f16.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f16.setParent(null);
    // /user.jsp(453,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f16.setVar("i");
    // /user.jsp(453,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f16.setBegin(0);
    // /user.jsp(453,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f16.setEnd(11);
    // /user.jsp(453,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f16.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f16 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f16 = _jspx_th_c_005fforEach_005f16.doStartTag();
      if (_jspx_eval_c_005fforEach_005f16 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${FREQUENCY[i].sums}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f16.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f16[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f16.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f16.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f16);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f17(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f17 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f17.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f17.setParent(null);
    // /user.jsp(459,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f17.setVar("i");
    // /user.jsp(459,7) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f17.setBegin(0);
    // /user.jsp(459,7) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f17.setEnd(11);
    // /user.jsp(459,7) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f17.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f17 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f17 = _jspx_th_c_005fforEach_005f17.doStartTag();
      if (_jspx_eval_c_005fforEach_005f17 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${FREQUENCY[i].counts}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("    \t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f17.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f17[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f17.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f17.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f17);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f18(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f18 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f18.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f18.setParent(null);
    // /user.jsp(511,6) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f18.setVar("i");
    // /user.jsp(511,6) name = begin type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f18.setBegin(1);
    // /user.jsp(511,6) name = end type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f18.setEnd(5);
    // /user.jsp(511,6) name = step type = int reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f18.setStep(1);
    int[] _jspx_push_body_count_c_005fforEach_005f18 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f18 = _jspx_th_c_005fforEach_005f18.doStartTag();
      if (_jspx_eval_c_005fforEach_005f18 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    \t\t\t<tr>\r\n");
          out.write("\t    \t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COMMUNICATION[i-1].date}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t    \t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COMMUNICATION[i-1].mode}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t    \t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COMMUNICATION[i-1].content}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t    \t\t\t<td class=\"toCenter\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${COMMUNICATION[i-1].feedback}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t    \t\t</tr>\r\n");
          out.write("    \t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f18.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f18[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f18.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f18.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_005fvar_005fstep_005fend_005fbegin.reuse(_jspx_th_c_005fforEach_005f18);
    }
    return false;
  }
}
