<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function oa_tool(){
if(window.parent.webframe.cols=="0,10,*"){
  frameshow.src="../skin/<%=session("skindir")%>/image/index_50.gif";
  oa_tree.title="���ع�����"
  window.parent.webframe.cols="188,10,*";
}else{
  frameshow.src="../skin/<%=session("skindir")%>/image/index_50b.gif";
  oa_tree.title="��ʾ������"
  window.parent.webframe.cols="0,10,*";}
}
</script>
<style>body{ margin:0; width:10px; overflow:hidden;background:#e9f6f5;}</style>
</head>
<body>
<table width="10" onClick="oa_tool();"  onMouseOver="this.style.background='#ffe'" onMouseOut="this.style.background=''" border="0" height="100%" cellpadding="0" cellspacing="0" align="left" style="border-left:solid 1px #2d7090;">
  <tr align="center">
    <td><div id="oa_tree"title="���ع�����"><img id=frameshow src="../skin/<%=session("skindir")%>/image/index_50.gif" width="8" height="72" style="cursor:hand; "></div>
      </td>
  </tr>
</table>
</body>
</html>
