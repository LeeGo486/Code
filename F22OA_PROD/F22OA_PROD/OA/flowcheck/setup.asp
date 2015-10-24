<!-- #include file="conn.asp" -->
<!-- #include file="check.asp" -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" type="text/css" href="Common.css" />
<base target="_self">
<LINK href="../css/project.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="setday.js"></script>
</head>
<script language="javascript">
function ShowWin(Url,W,H){
	showModalDialog(Url,'e','dialogWidth:'+W+'px;dialogHeight:'+H+'px;center: yes;help:no;resizable:yes;status:no');
	self.location.reload();
}
function ShowOpen(Url,I){
	if(I==1){
		showModalDialog(Url,window,'dialogWidth:80;dialogHeight:80;center: yes;help:no;resizable:yes;status:no');
		//self.location.reload();
	}
}
</script>
<body topmargin="0" leftmargin="0" rightmargin="0">
<iframe name="hf" style="display:none;"></iframe>

<%Sub Footer%>
</body>
</html>
<%End Sub%>
