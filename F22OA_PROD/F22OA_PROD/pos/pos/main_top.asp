<%
if request.QueryString="logout" then
	session.Abandon()
	response.write("<script language=JavaScript>top.location.href='../../relogin.aspx';</script>")
end if
if request.QueryString="quit" then
	session.Abandon()
	response.write("<script language=JavaScript>top.window.close();</script>")
end if
%>
<!-- #include file="inc/const.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href='skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<script language="javascript">
function oa_tool(){
if(window.top.mf.rows=="62,25,*"){
  window.top.mf.rows="0,25,*";
}else{
  window.top.mf.rows="62,25,*";
 }
}
</script>
<style>
.traDiv{
font-size:12px;
line-height:16px;
color:white;
background:#000;
filter:alpha(opacity=50);       /* IE */
-moz-opacity:0.5;              /* Moz + FF */
opacity: 0.5;           /* 支持CSS3的浏览器（FF 1.5也支持）*/
}
</style>
</head>
<body background="skin/<%=session("skindir")%>/image/index_14.gif" topmargin="0" leftmargin="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:no-repeat right url(skin/<%=session("skindir")%>/image/cc_03.gif);">
  <tr>
    <td width="220" style="background:no-repeat center url(skin/<%=session("skindir")%>/image/zhxlogo.jpg);" height="60"></td>
    <td align="center">&nbsp;<table width="100%" border="0" cellspacing="0" cellpadding="0" class="index_top">
        <tr align="center"><!--
          <td><a href="../person/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/person.jpg" border="0"><br>
          个人事务</a></td>
          <td><a href="f22/index_main.asp" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/f22.jpg" border="0"><br>业务中心</a></td>
		  <td><a href="index_main.asp" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/kcmpartitions.gif" border="0"><br>
          数据查询</a></td>
          <td><a href="../message/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/message.jpg" border="0"><br>
          信息中心</a></td>
          <td><a href="../communion/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/communion.jpg" border="0"><br>
          交流中心</a></td>
          <td><a href="../manage/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/manage.jpg" border="0"><br>
          行政中心</a></td>
		  <td><a href="crm/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/admin.jpg" border="0"><br>CRM管理</a></td>-->
        </tr>
    </table></td>
    <td width="250" align="center">
	<table width="80%" height="62" border="0" cellspacing="0" cellpadding="0" align="left">
	<tr><td height="35" align="right" valign="bottom" style="display:none;">
	<a href="f22/index_main.asp"  target="mainFrame" onFocus=this.blur()>
    <img src="skin/<%=session("skindir")%>/image/home.gif" alt="返回POS首页" style="display:none;" border="0"></a>
	<a href="http://www.f18erp.com" target="_blank" onFocus=this.blur()>
    <img src="skin/<%=session("skindir")%>/image/f18erp.gif" alt="访问志华F18ERP网站" border="0"></a>
	<a href="?logout" onFocus="this.blur()" onClick="return confirm('确定要注销吗？')">
    <img src="skin/<%=session("skindir")%>/image/exit2.gif" alt="注销用户" border="0"></a></td>
	</tr>
	<tr><td height="27" align="right">
    <div id="jnkc" class="traDiv" align="center">加载当前时间中...</div>
    <script>setInterval("jnkc.innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);</script>
	</td></tr>
	</table>
	</td>
  </tr>
</table>
</body>
</html>
