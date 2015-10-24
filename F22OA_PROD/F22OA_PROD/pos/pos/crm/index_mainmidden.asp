<!-- #include file="../inc/const.asp" -->
<html>
<head>
<title>button_title_l</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>
function oa_tool(){
if(window.parent.webframe.cols=="0,10,*"){
frameshow.src="../skin/<%=session("skindir")%>/image/index_50.gif";
oa_tree.title="隐藏工具栏"
window.parent.webframe.cols="188,10,*";
}
else{
frameshow.src="../skin/<%=session("skindir")%>/image/index_50b.gif";
oa_tree.title="显示工具栏"
window.parent.webframe.cols="0,10,*";}
}
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="cccccc">
<table width="10" border="0" height="100%" cellpadding="0" cellspacing="0" align="left" background="../skin/<%=session("skindir")%>/image/index_24.gif">
  <tr align="center">
    <td>
      <div id=oa_tree onclick="oa_tool();" title=隐藏工具栏><img id=frameshow src="../skin/<%=session("skindir")%>/image/index_50.gif" width="10" height="97" ></div>
      </td>
  </tr>
</table>
</body>
</html>
