<!-- #include file="inc/const.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href='skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<title>ZHX_OA</title>
<script language="javascript">
function oa_tool(){
if(window.top.mf.rows=="62,25,*"){
  window.top.mf.rows="0,25,*";
}else{
  window.top.mf.rows="62,25,*";
 }
}
</script>
</head>
<body background="skin/<%=session("skindir")%>/image/index_14.gif" topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20%" background="skin/<%=session("skindir")%>/image/zhxlogo.jpg"><img src="skin/default/image/zhxlogo.jpg" width="199" height="60"></td>
    <td width="58%" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="index_top">
        <tr align="center">
          <td><a href="person/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/person.jpg" border="0"><br>个人事务</a></td>
          <td><a href="f22/index_main.asp" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/f22.jpg" border="0"><br>业务中心</a></td>
          <td><a href="report/index_main.asp" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/kcmpartitions.gif" border="0"><br>
          数据查询</a></td>
          <td><a href="message/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/message.jpg" border="0"><br>信息中心</a></td>
          <td><a href="communion/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/communion.jpg" border="0"><br>交流中心</a></td>
          <td><a href="manage/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/manage.jpg" border="0"><br>行政中心</a></td>
		  <td><a href="crm/index_main.htm" target="mainFrame" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/admin.jpg" border="0"><br>CRM管理</a></td>
        </tr>
    </table></td>
    <td width="220" background="skin/<%=session("skindir")%>/image/index_16.gif" align="right">
	<table width="100%" height="62" border="0" cellspacing="0" cellpadding="0">
	<tr><td height="35" align="right" valign="bottom">
	<a href="http://www.zhxit.com.cn" target="_blank" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/index_20.gif" alt="访问志华网站" onMouseOver="this.src='skin/<%=session("skindir")%>/image/index_201.gif'" onMouseOut="this.src='skin/<%=session("skindir")%>/image/index_20.gif'" width="26" height="26" border="0"></a>
	<a href="outlogin.asp" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/index_21.gif" alt="注销系统" onMouseOver="this.src='skin/<%=session("skindir")%>/image/index_211.gif'" onMouseOut="this.src='skin/<%=session("skindir")%>/image/index_21.gif'" width="26" height="26" border="0"></a>
	<a href="outlogin.asp" target="_top" onFocus=this.blur()><img src="skin/<%=session("skindir")%>/image/index_22.gif" alt="退出系统" onMouseOver="this.src='skin/<%=session("skindir")%>/image/index_221.gif'" onMouseOut="this.src='skin/<%=session("skindir")%>/image/index_22.gif'" width="26" height="26" border="0"></a></td>
	</tr>
	<tr><td height="27" align=right><div id="jnkc" class="index_head" align="right"></div>
    <script>setInterval("jnkc.innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);</script>
	</td></tr>
	</table>
	</td>
  </tr>
</table>
</body>
</html>
