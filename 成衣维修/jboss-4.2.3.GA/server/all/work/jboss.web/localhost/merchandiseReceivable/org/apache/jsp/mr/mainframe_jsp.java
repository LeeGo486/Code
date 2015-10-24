package org.apache.jsp.mr;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.hy.SSO.mode.Menu;
import java.util.List;
import org.hy.mr.mode.UserInfo;

public final class mainframe_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction.release();
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.release();
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
      response.setContentType("text/html; charset=GBK");
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
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
String webContext = request.getContextPath(); 
  UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");

      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("\t<title>百货应收系统</title>\r\n");
      out.write("\t<meta http-equiv=\"Access-Control-Allow-Origin\" content=\"*\">\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/themes/default/easyui.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext);
      out.write("/css/cmcommon.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/demo/demo.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/themes/icon.css\">\r\n");
      out.write("\t<script src=\"http://192.168.0.89:8001/MenuClick.aspx\" type=\"text/javascript\" defer=\"defer\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/jquery-1.8.0.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/jquery.easyui.min.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext);
      out.write("/jquery-easyui-1.3.1/src/jquery.parser.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.print(webContext);
      out.write("/myjs/authority.js\"></script>\r\n");
      out.write("\t<script>\r\n");
      out.write("\tvar isExistsTab1 = 1;\r\n");
      out.write("\tfunction openTab(url,title,menuid){\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar ssoSessionID = $('#ssoSessionID').attr('value');\r\n");
      out.write("\t\t//var authorityFlag = validateMenuAccessAuthority(menuid,ssoSessionID);\r\n");
      out.write("\t\t//if(validateMenuAccessAuthority(menuid,ssoSessionID)==false){\r\n");
      out.write("\t\t\t//return;\r\n");
      out.write("\t\t//}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(isExistsTab1==1){\r\n");
      out.write("\t\t\t$('#tt').tabs('close','欢迎');\r\n");
      out.write("\t\t\tisExistsTab1 = isExistsTab1-1;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tvar tab = $('#tt').tabs('getTab',title);\r\n");
      out.write("\t\tif(tab==null || tab=='null'){\r\n");
      out.write("\t\t\taddTab(url,title);\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t//$('#tt').tabs('select',title);\r\n");
      out.write("\t\t\t//tab.panel('options').content='<iframe width=\"100%\" height=\"100%\" frameborder=\"0\" src=\"'+url+'\"></iframe>';\r\n");
      out.write("\t\t\t$('#tt').tabs('close',title);\r\n");
      out.write("\t\t\taddTab(url,title);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction addTab(url,title){\r\n");
      out.write("\t\t\t$('#tt').tabs('add',{\r\n");
      out.write("\t\t\t\ttitle:title,\r\n");
      out.write("\t\t\t\t//content:'Tab Body ' + index,\r\n");
      out.write("\t\t\t\t//iconCls:'icon-save',\r\n");
      out.write("\t\t\t\tclosable:true,\r\n");
      out.write("\t\t\t\tcontent:'<iframe width=\"100%\" height=\"100%\" frameborder=\"0\" src=\"'+url+'\"></iframe>'\r\n");
      out.write("\t\t\t\t//tools:[{\r\n");
      out.write("\t\t\t\t\t//iconCls:'icon-mini-refresh',\r\n");
      out.write("\t\t\t\t\t//handler:function(){\r\n");
      out.write("\t\t\t\t\t\t//var tabpanel = $('#tt').tabs('getTab',title);//格局title获取tab\r\n");
      out.write("\t\t\t\t\t\t//alert(tabpanel.document.getElementByID('test1').value);\r\n");
      out.write("\t\t\t\t\t\t//alert($('#tt').tabs('getTab','title').panel('options').content);\r\n");
      out.write("\t\t\t\t\t//}\r\n");
      out.write("\t\t\t\t//}]\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction openMainWindow(url){\r\n");
      out.write("\t\t$(\"#mainWindow\").attr('src',$('#webContext').attr('value')+url);\r\n");
      out.write("\t}\t\r\n");
      out.write("\t\r\n");
      out.write(" \tfunction logout(){\r\n");
      out.write(" \t\twindow.location.href=$('#webContext').attr('value')+'/web/logout!logout';\r\n");
      out.write(" \t}\r\n");
      out.write("\t\t\r\n");
      out.write("\tfunction freshSubWindow(){\r\n");
      out.write("\t\tdocument.getElementById('mainWindow').contentWindow.document.forms[0].submit();\r\n");
      out.write("\t}\t\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"easyui-layout\">en<br>\r\n");
      out.write("\t<input type=\"hidden\" id=\"webContext\" value=\"");
      out.print(webContext);
      out.write("\">\r\n");
      out.write("\t<input type=\"hidden\" id=\"ssoSessionID\" value=\"");
      out.print(userInfo.getSsoSessionID());
      out.write("\">\r\n");
      out.write("\t");
      //  s:form
      org.apache.struts2.views.jsp.ui.FormTag _jspx_th_s_005fform_005f0 = (org.apache.struts2.views.jsp.ui.FormTag) _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction.get(org.apache.struts2.views.jsp.ui.FormTag.class);
      _jspx_th_s_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_s_005fform_005f0.setParent(null);
      // /mr/mainframe.jsp(87,1) name = action type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setAction("/web/cm-main-frame!initFrame");
      // /mr/mainframe.jsp(87,1) name = theme type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_s_005fform_005f0.setTheme("simple");
      int _jspx_eval_s_005fform_005f0 = _jspx_th_s_005fform_005f0.doStartTag();
      if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_s_005fform_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_s_005fform_005f0.doInitBody();
        }
        do {
          out.write("\r\n");
          out.write("\t\r\n");
          out.write("\t<div style=\"position: absolute; left:95%;top:5px;z-index: 10\"><a onclick=\"logout()\"><font style=\"color:#15428B;cursor: pointer;font-weight: bold; \">注销</font></a></div>\r\n");
          out.write("\t<div data-options=\"region:'west',split:true\" title=\"百货应收系统\" style=\"width:160px;padding1:1px;overflow:hidden;\">\r\n");
          out.write("\t\t<div class=\"easyui-accordion\" data-options=\"fit:true,border:false\">\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t<div title=\"百货应收系统菜单\" style=\"padding:10px;overflow:auto;\">\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
          out.write("\r\n");
          out.write("\t\t\t\t");
 
				if(userInfo.getUserid().equals("俞晓东")){
				
          out.write("\r\n");
          out.write("\t\t\t\t");
          out.write("\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/acct-period-input!initInput','账期录入');\">账期录入 </a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/acct-period-input!initImport','账期批量导入');\">账期批量导入</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/daily-business!init','主操作界面');\">主操作界面</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/received-import!init','到款流水导入');\">到款流水导入</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/reveiced-flow-query!init','到款流水查询');\">到款流水查询</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/merchan-receivable-query!init','分公司百货应收查询');\">分公司百货应收查询</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/exclude-style!init','款式排除配置');\">款式排除配置</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/acct-config!queryConfigList','账期档案维护');\">账期档案维护</a><br><br>\r\n");
          out.write("\t\t\t\t");
          out.write("\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/note-import!init','开票导入');\">开票导入</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/finance-data-import','财务数据导入');\">财务数据导入</a><br><br>\r\n");
          out.write("\t\t\t\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.write("/web/market-archives!queryMarketList','物业维护');\">物业维护</a><br><br>\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
}else{ 
					List<Menu> list = (List<Menu>)request.getAttribute("menuList");
					
					for(Menu menu:list){
          out.write("\r\n");
          out.write("\t\t\t\t\t\t<font size=\"6\" color=\"#15428B\"> <b>");
          out.print(menu.getMenu_Name());
          out.write("</b></font> <br><br>\r\n");
          out.write("\t\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t\r\n");
          out.write("\t\t\t\t\t");

						List<Menu> subList = menu.getSubMenuList();
						for(Menu subMenu:subList){ 
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          out.print(subMenu.getActionURL());
          out.write("'+'?menuID='+");
          out.print(subMenu.getMenu_Id());
          out.write(',');
          out.write('\'');
          out.print(subMenu.getMenu_Name());
          out.write('\'');
          out.write(',');
          out.write('\'');
          out.print(subMenu.getMenu_Id());
          out.write("')\"    >");
          out.print(subMenu.getMenu_Name());
          out.write("</a><br><br>\r\n");
          out.write("\t\t\t\t\t\t");
}
					
					}
				
          out.write("\r\n");
          out.write("\t\t\t\t<!--  \t<p onclick=\"openMainWindow( '");
          if (_jspx_meth_s_005fproperty_005f0(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write(" ');\" style=\"cursor: pointer;color: #15428B;\" > ");
          if (_jspx_meth_s_005fproperty_005f1(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </p>-->\r\n");
          out.write("\t\t\t\t<!--\t<a style=\"cursor: pointer;color: #15428B;text-decoration:none\" onclick=\"openTab('");
          out.print(webContext);
          if (_jspx_meth_s_005fproperty_005f2(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write("'+'?menuID='+");
          if (_jspx_meth_s_005fproperty_005f3(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write(',');
          out.write('\'');
          if (_jspx_meth_s_005fproperty_005f4(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write('\'');
          out.write(',');
          out.write('\'');
          if (_jspx_meth_s_005fproperty_005f5(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write("')\"   style=\"cursor: pointer;color: #15428B;text-decoration:none\" >");
          if (_jspx_meth_s_005fproperty_005f6(_jspx_th_s_005fform_005f0, _jspx_page_context))
            return;
          out.write(" </a><br><br><!-->\r\n");
          out.write("\t\t\t\t\r\n");
          out.write("\t\t\t\t");
} 
          out.write("\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t<!--  \r\n");
          out.write("\t\t\t<div title=\"Title2\" data-options=\"selected:true\" style=\"padding:10px;\">\r\n");
          out.write("\t\t\t\tcontent2\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t\t<div title=\"Title3\" style=\"padding:10px\">\r\n");
          out.write("\t\t\t\tcontent3\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t\t-->\r\n");
          out.write("\t\t</div>\r\n");
          out.write("\t</div>\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t\r\n");
          out.write("\t<div data-options=\"region:'center'\" title=\"百货应收\" >\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t<div id=\"tt\" class=\"easyui-tabs\" data-options=\"tools:'#tab-tools'\" style=\"overflow:hidden;height: 580px\" >\r\n");
          out.write("\t\t\t<div title=\"欢迎\" data-options=\"closable:true,cache:false,href:'");
          out.print(webContext);
          out.write("/mr/mainBlank.jsp'\" style=\"padding:20px;\">\r\n");
          out.write("\t\t\t</div>\r\n");
          out.write("\t\t</div>\t\r\n");
          out.write("\t\t\r\n");
          out.write("\t<!-- \t<iframe id=\"mainWindow\" name=\"mainWindow\" width=\"100%\" height=\"100%\" frameborder=\"0\" src=\"");
          out.print(webContext);
          out.write("/mr/mainBlank.jsp\"></iframe> -->\r\n");
          out.write("\t\t\t\r\n");
          out.write("\t\t\t\r\n");
          out.write(" \t</div>\r\n");
          int evalDoAfterBody = _jspx_th_s_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_s_005fform_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_s_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction.reuse(_jspx_th_s_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fs_005fform_005ftheme_005faction.reuse(_jspx_th_s_005fform_005f0);
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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

  private boolean _jspx_meth_s_005fproperty_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f0 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f0.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(145,40) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f0.setValue("actionURL");
    int _jspx_eval_s_005fproperty_005f0 = _jspx_th_s_005fproperty_005f0.doStartTag();
    if (_jspx_th_s_005fproperty_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f0);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f1 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f1.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(145,119) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f1.setValue("menu_Name");
    int _jspx_eval_s_005fproperty_005f1 = _jspx_th_s_005fproperty_005f1.doStartTag();
    if (_jspx_th_s_005fproperty_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f1);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f2 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f2.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(146,105) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f2.setValue("actionURL");
    int _jspx_eval_s_005fproperty_005f2 = _jspx_th_s_005fproperty_005f2.doStartTag();
    if (_jspx_th_s_005fproperty_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f2);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f3(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f3 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f3.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(146,149) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f3.setValue("menu_Id");
    int _jspx_eval_s_005fproperty_005f3 = _jspx_th_s_005fproperty_005f3.doStartTag();
    if (_jspx_th_s_005fproperty_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f3);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f4(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f4 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f4.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(146,180) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f4.setValue("menu_Name");
    int _jspx_eval_s_005fproperty_005f4 = _jspx_th_s_005fproperty_005f4.doStartTag();
    if (_jspx_th_s_005fproperty_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f4);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f5(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f5 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f5.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(146,214) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f5.setValue("menu_Id");
    int _jspx_eval_s_005fproperty_005f5 = _jspx_th_s_005fproperty_005f5.doStartTag();
    if (_jspx_th_s_005fproperty_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f5);
    return false;
  }

  private boolean _jspx_meth_s_005fproperty_005f6(javax.servlet.jsp.tagext.JspTag _jspx_th_s_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  s:property
    org.apache.struts2.views.jsp.PropertyTag _jspx_th_s_005fproperty_005f6 = (org.apache.struts2.views.jsp.PropertyTag) _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.get(org.apache.struts2.views.jsp.PropertyTag.class);
    _jspx_th_s_005fproperty_005f6.setPageContext(_jspx_page_context);
    _jspx_th_s_005fproperty_005f6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_s_005fform_005f0);
    // /mr/mainframe.jsp(146,310) name = value type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_s_005fproperty_005f6.setValue("menu_Name");
    int _jspx_eval_s_005fproperty_005f6 = _jspx_th_s_005fproperty_005f6.doStartTag();
    if (_jspx_th_s_005fproperty_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fs_005fproperty_005fvalue_005fnobody.reuse(_jspx_th_s_005fproperty_005f6);
    return false;
  }
}
