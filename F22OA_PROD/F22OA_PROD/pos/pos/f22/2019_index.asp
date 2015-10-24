<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/main.css" rel="stylesheet" type="text/css">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title></title>
<style type="text/css">
.mover {
	background-image: url(img/smbgh.gif);
	font-size: 14px;
	font-weight: bold;
	color: #FF0000;
	cursor: hand;
}
.mout {
	background-image: url(img/smbg.gif);
	font-size: 14px;
	/*font-weight: bold;
	color: #FF0000;*/
	cursor: hand;
}
</style>
<script language="javascript">
var strlist = new Array();
strlist[1]="";

var rid,rt="";
function show(t,id,nums,types){
  if(rt!=""){
    if(rt!=t){
	  rid.innerHTML="";
	  rt.className="mout";
      id.innerHTML='<img src="../skin/<%=session("skindir")%>/image/arrow.jpg" width=35 height=35>';
      document.all.content.innerHTML=strlist[nums];
      t.className="mover";
	  rt=t;
	  rid=id;
	}
  }else{
    id.innerHTML='<img src="../skin/<%=session("skindir")%>/image/arrow.jpg" width=35 height=35>';
    document.all.content.innerHTML=strlist[nums];
    t.className="mover";
	rt=t;
	rid=id;
  }
}
function sd(url){
  window.location.href=url;
}
</script>

</head>
<body>
<%session("formid")=2019%>
<table width="100%" height="46" border="0" cellspacing="0" class="f14">
  <tr valign="middle" class="tcontent"> 
    <td height="30" bordercolor="#C6AEA5" background="img/smbg_b.gif" class="bk">业务操作 &gt;&gt; 零售查询 </td>
  </tr>
  <tr><td height=15><hr size="1" noshade></td></tr>
</table>
<table width="100%" height=350 border="0">
  <tr> 
    <td width="10%" rowspan=2></td>
  </tr>
  <tr> 
    <td width="300" height="350" valign="top"> 
      <table width="300" height="45" border="0">
        <tr>
          <td width="40" height="41" id="t1">&nbsp;</td>
          <a href="search_frame.asp?action=create&pagename=<%=server.URLEncode("查询零售单")%>">
          <td width="236" height="22" align="center" background="img/smbg.gif" class="mout" onClick="" onMouseOver="show(this,document.all.t1,1,1)" onMouseOut="show(this,document.all.t1,1,2)">查询零售单</td>
          </a> </tr>
      </table>
    </td>
    <td width="280" valign="top">
      <table width="280" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="8"><img src="img/smbg_l.gif" width="9"></td>
          <td width="264" align="center" background="img/smbg_b.gif">功 能 说 明</td>
          <td width="10"><img src="img/smbg_r.gif"></td>
        </tr>
      </table>
      <table width="200" border="0">
        <tr>
          <td></td>
        </tr>
      </table>
      <table width="280" height="344" border="0" cellpadding="0" cellspacing="0" bordercolor="#C6AEA5">
        <tr>
          <td width="7" height="8"><img src="img/bkc/bk_t_l.gif" width="8" height="8"></td>
          <td width="260" background="img/bkc/bk_t_b.gif"></td>
          <td width="10"><img src="img/bkc/bk_t_r.gif" width="8" height="8"></td>
        </tr>
        <tr>
          <td height="322" background="img/bkc/bk_l.gif">&nbsp;</td>
          <td valign="top"><div id="content" class="gnsm"> 查询出来的“VIP是否打折”和“VIP是否积分”由收银系统F2边上的打勾选项决定</div></td>
          <td background="img/bkc/bk_r.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="13" valign="top"><img src="img/bkc/bk_f_l.gif" width="8" height="8"></td>
          <td background="img/bkc/bk_f_b.gif"></td>
          <td valign="top"><img src="img/bkc/bk_f_r.gif" width="8" height="8"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
