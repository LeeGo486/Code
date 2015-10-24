package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class orgmutilchecktree_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String loginDeptID = request.getParameter("loginDeptID");
	

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("<html>\r\n");
      out.write("\t\r\n");
      out.write("\t<title>单位树</title>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<base href=\"");
      out.print(basePath);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("\t\t<title>My JSP 'orgmutilchecktree.jsp' starting page</title>\r\n");
      out.write("\r\n");
      out.write("\t\t<meta http-equiv=\"pragma\" content=\"no-cache\">\r\n");
      out.write("\t\t<meta http-equiv=\"cache-control\" content=\"no-cache\">\r\n");
      out.write("\t\t<meta http-equiv=\"expires\" content=\"0\">\r\n");
      out.write("\t\t<meta http-equiv=\"keywords\" content=\"keyword1,keyword2,keyword3\">\r\n");
      out.write("\t\t<meta http-equiv=\"description\" content=\"This is my page\">\r\n");
      out.write("\t\t<!--\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">\r\n");
      out.write("\t-->\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("  <link rel=\"stylesheet\" href=\"ztree/zTreeStyle/zTreeStyle.css\" type=\"text/css\">\r\n");
      out.write("  <script type=\"text/javascript\" src=\"ztree/jquery-1.4.2.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\" src=\"ztree/jquery.ztree-2.6.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\" src=\"ztree/demoTools.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t</head>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("  var zTree1;\r\n");
      out.write("  var lastCheckLevel;\r\n");
      out.write("  var setting = {\r\n");
      out.write("  \tcallback : {\r\n");
      out.write("      click: zTreeOnClick,\r\n");
      out.write("      change: zTreeOnChange\r\n");
      out.write("  \t},\r\n");
      out.write("    showLine: true,\r\n");
      out.write("    checkable: true,\r\n");
      out.write("    showIcon: true,\r\n");
      out.write("    checkType : { \"Y\": \"\", \"N\": \"\" }\r\n");
      out.write("\r\n");
      out.write("\t};\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" var xmlhttp;\r\n");
      out.write(" var myNodeTreeData; \r\n");
      out.write("  function ajaxMain(){\r\n");
      out.write("  \t\r\n");
      out.write("\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t}else{// code for IE6, IE5\r\n");
      out.write("  \t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t}\r\n");
      out.write("\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t \r\n");
      out.write("    \t\tmyNodeTreeData = eval(\"(\" + xmlhttp.responseText + \")\");\r\n");
      out.write("    \t\tzTree1=$(\"#tree\").zTree(setting, [myNodeTreeData]);\r\n");
      out.write("    \t}\r\n");
      out.write("\t};\r\n");
      out.write(" \t\r\n");
      out.write(" \tvar loginDeptID = document.getElementById(\"deptID\").value;\r\n");
      out.write("\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\txmlhttp.send(\"action=getRootNodeTreeData&loginDeptID=\"+loginDeptID);\r\n");
      out.write("\t\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("//function getTreeData(){\r\n");
      out.write("\t//alert(xmlhttp.readyState);\r\n");
      out.write("\t//if (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t\r\n");
      out.write("    \t//myNodeTreeData = eval(\"(\" + response.responseText + \")\");;\r\n");
      out.write("    \t\r\n");
      out.write("    //}\r\n");
      out.write("\t\r\n");
      out.write("//}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function zTreeOnClick(event, treeId, treeNode) {\r\n");
      out.write("\tif(treeNode.isOpenFlag==0){\r\n");
      out.write("\t\r\n");
      out.write("\t\tif(treeNode.loadDataFlag==0){\r\n");
      out.write("\t\t\taddmynode(treeNode);\r\n");
      out.write("\t\t\ttreeNode.loadDataFlag=1;\r\n");
      out.write("\t\t\ttreeNode.isOpenFlag=1;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tzTree1.expandNode(treeNode, true, false);\r\n");
      out.write("\t\t\ttreeNode.isOpenFlag=1;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\tzTree1.expandNode(treeNode, false, false);\r\n");
      out.write("\t\ttreeNode.isOpenFlag=0;\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(" \r\n");
      out.write("function addmynode(parentNode){\r\n");
      out.write("\t//var newNodes = [ {\"name\":\"IT部门\",\"enname\":\"IT\",\"deptid\":\"00011\",\"hasunFlag\":\"0\",\"loadDataFlag\":\"0\",\"isOpenFlag\":\"0\"}, \r\n");
      out.write("\t//\t\t\t\t {\"name\":\"商品部门\",\"enname\":\"PDC\",\"deptid\":\"00012\",\"hasunFlag\":\"0\",\"loadDataFlag\":\"0\",\"isOpenFlag\":\"0\"}];\r\n");
      out.write("\tif(parentNode.hasunFlag=='0'){\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\tparentNode.isParent=true\r\n");
      out.write("\t//var parentDeptID = parentNode.deptid;\r\n");
      out.write("\tgetSunNodes(parentNode);\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("/**function zTreeOnChange(event,treeId,treeNode){\r\n");
      out.write("\tif(treeNode.checked==true){\r\n");
      out.write("\t\tif(lastCheckLevel==null){\r\n");
      out.write("\t\t\tlastCheckLevel=treeNode.level;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tif(lastCheckLevel!=treeNode.level){\r\n");
      out.write("\t\t\t\talert(\"不同级别的部门数据不能一起查询！\");\r\n");
      out.write("\t\t\t\ttreeNode.checked=false;\r\n");
      out.write("\t\t\t}else{\r\n");
      out.write("\t\t\t\tlastCheckLevel=treeNode.level;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\tvar checkedNodes = zTree1.getCheckedNodes(true);\r\n");
      out.write("\t\tif(checkedNodes.length>0){\r\n");
      out.write("\t\t\tlastCheckLevel = checkedNodes[0].level;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tlastCheckLevel=null;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("}*/\r\n");
      out.write("\r\n");
      out.write("function zTreeOnChange(event,treeId,treeNode){\r\n");
      out.write("\t\r\n");
      out.write("\t//if (setting.checkable) {\r\n");
      out.write("\t\t\t//for (var son = 0; son < setting.root[setting.nodesCol].length; son++) {\r\n");
      out.write("\t\t\t\t//var treeNode = setting.root[setting.nodesCol][son];\r\n");
      out.write("\t\t\t\t//treeNode[setting.checkedCol] = checked;\r\n");
      out.write("\t\t\t\t//setSonNodeCheckBox(setting, treeNode, checked);\r\n");
      out.write("\t\t\t//}\r\n");
      out.write("\t\t//}\r\n");
      out.write("\t\r\n");
      out.write("\tif(treeNode.checked==true){\r\n");
      out.write("\t\tvar subTreeNodes = zTree1.getNodesByParam(\"level\",treeNode.level+1,treeNode);\r\n");
      out.write("\t\r\n");
      out.write("\t\t//for(var i=0;i<subTreeNodes.length;i++){\r\n");
      out.write("\t\t//var treeNode = subTreeNodes[i];\r\n");
      out.write("\t\t//treeNode[setting.checkedCol] = true;\r\n");
      out.write("\t\t//zTree1.setSonNodeCheckBox(this.setting, treeNode, true);\r\n");
      out.write("\t//}\r\n");
      out.write("\t\tzTree1.checkSubNodes(true,subTreeNodes);\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\tvar subTreeNodes = zTree1.getNodesByParam(\"level\",treeNode.level+1,treeNode);\r\n");
      out.write("\t\tzTree1.checkSubNodes(false,subTreeNodes);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function selectOrg(){\r\n");
      out.write("\tvar selectOrgString=\"\";\r\n");
      out.write("\tvar selectOrgName=\"\";\r\n");
      out.write("\tvar checkedNodes = zTree1.getCheckedNodes(true);\r\n");
      out.write("\t\r\n");
      out.write("\tif(checkedNodes.length>0){\r\n");
      out.write("\t\tfor(var i=0;i<checkedNodes.length;i++){\r\n");
      out.write("\t\t\tselectOrgString=selectOrgString+checkedNodes[i].deptid+\",\";\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tselectOrgName=selectOrgName+checkedNodes[i].name+\",\";\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\tselectOrgString = selectOrgString.substr(0,selectOrgString.length-1);\r\n");
      out.write("\t\tselectOrgName=selectOrgName.substr(0,selectOrgName.length-1);\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("\topener.setOrg(selectOrgName,selectOrgString);\r\n");
      out.write("\twindow.close();\t\t\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function getSunNodes(parentNode){\r\n");
      out.write("\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t}else{// code for IE6, IE5\r\n");
      out.write("  \t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t}\r\n");
      out.write("\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t \r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\tvar newNodes = eval(\"(\" + xmlhttp.responseText + \")\");\r\n");
      out.write("    \t\tzTree1.addNodes(parentNode, newNodes,false);\r\n");
      out.write("    \t}\r\n");
      out.write("\t};\r\n");
      out.write(" \t\r\n");
      out.write("\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\txmlhttp.send(\"action=getSunNodeTreeData&parentDeptID=\"+parentNode.deptid);\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function selectAllOrg(){\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\tif (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari\r\n");
      out.write("  \t\txmlhttp=new XMLHttpRequest();\r\n");
      out.write("  \t}else{// code for IE6, IE5\r\n");
      out.write("  \t\txmlhttp=new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("  \t}\r\n");
      out.write("\txmlhttp.onreadystatechange=function() {\r\n");
      out.write("\t\tif (xmlhttp.readyState==4 && xmlhttp.status==200){\r\n");
      out.write("    \t \r\n");
      out.write("    \t\tvar rs = xmlhttp.responseText;\r\n");
      out.write("    \t\trsArray = rs.split('-');\r\n");
      out.write("    \t\t\r\n");
      out.write("    \t\topener.setOrg(rsArray[1],rsArray[0]);\r\n");
      out.write("\t\t\twindow.close();\t\t\r\n");
      out.write("    \t}\r\n");
      out.write("\t};\r\n");
      out.write(" \t\r\n");
      out.write(" \tvar loginDeptID = document.getElementById(\"deptID\").value;\r\n");
      out.write("\tif(loginDeptID=='1'){\r\n");
      out.write("\t    alert('对不起，您全选的单位过多!');\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\txmlhttp.open(\"post\",\"ajax.ajaxServlet\",true);\r\n");
      out.write("\txmlhttp.setRequestHeader(\"Content-type\",\"application/x-www-form-urlencoded\");\r\n");
      out.write("\txmlhttp.send(\"action=selectAllOrg&loginDeptID=\"+loginDeptID);\r\n");
      out.write("\t\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\t<body onload=\"ajaxMain()\" >\r\n");
      out.write("\t\r\n");
      out.write("\t\t<input type=\"button\" onclick=\"selectOrg()\" value=\"确定\">\r\n");
      out.write("\t\t<input type=\"button\" onclick=\"selectAllOrg()\" value=\"全选\">\r\n");
      out.write("\t\t<input type=\"hidden\" id=\"deptID\" name=\"deptID\" value=\"");
      out.print(loginDeptID);
      out.write("\" >\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div style=\"height: 80px\">\r\n");
      out.write("\t\t<ul id=\"tree\" class=\"tree\" style=\"width:300px; overflow:auto;\"></ul>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<input type=\"button\" onclick=\"selectOrg()\" value=\"确定\">\r\n");
      out.write("\t</body>\r\n");
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
