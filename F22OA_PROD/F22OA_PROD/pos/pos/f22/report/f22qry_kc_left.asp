<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<style type="text/css">
.menu {
	background-color:#ECD5CF;
	cursor:Hand;
	font-size:14px;
}
.msshow {
	display:block;
}
.mshide {
	display:none;
}
.mistand {
	background-color:#FFEFEF;
	font-size:12px;
}
.miover {
	background-color:#FFFFFF;
	font-size:12px;
}
.midown {
	background-color:#D7D0C0;
	font-size:12px;
}
.midown a{
	text-decoration:none;
	color:#FF0000;
}
.midown a:visited {
	color:#FF0000;
}

body {
	margin-left: 2px;
	margin-top: 2px;
	margin-right: 2px;
	margin-bottom: 2px;
}
a:hover {
	color:#FF0000;
	text-decoration:none;
}
a:visited {
	color:#0000FF;
}
.bar {
	font-size: 14px;
	background-image: url(../img/index_15.gif);
	border: 1px solid #CECECE;
}
</style>
<script language="javascript">
var flag='0';
function menu(id){
  var msid=document.all.item("menusub"+id);
  if(msid.className=="mshide")
	msid.className="msshow";
  else
	msid.className="mshide";
}

function menuitem(id){
  var mpid=document.all.item("menuitem"+flag);
  if(mpid!=null)
    mpid.className="mistand";
  var miid=document.all.item("menuitem"+id);
  miid.className="midown";
  flag=id;
}

function miover(id){
  if(flag!=id){
    var miid=document.all.item("menuitem"+id);
	miid.className="miover";
  }
}

function miout(id){
  if(flag!=id){
    var miid=document.all.item("menuitem"+id);
	miid.className="mistand";
  }
}
</script>
</head>

<body>
<!--#include file="inc/function.asp" -->
<%dim userid,depotid,ds,sql,rc
userid=trim(session("dm").System_Userid)
set ds=server.createobject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.CursorType = 1
sql="select depotid,d_name from webp_depot where userid="&qts(userid)&" order by depotid"
ds.source = sql
ds.open

dim menu(6,2)
dim menusub(6,10,1)
menu(0,0)=""
menu(0,1)="总库存查询"

  i=-1
  while not ds.eof
  i=i+1
  menusub(0,i,0)="kctbFrame.asp?act=1&depotid="&ds(0)
  menusub(0,i,1)=ds(1)
  ds.moveNext
  wend
  ds.close
  i=i+1
  menusub(0,i,0)="kctbFrame.asp?act=2&id="&userid
  menusub(0,i,1)="店铺汇总查询"
menu(0,2)=i
 
menu(1,0)=""
menu(1,1)="库存结构查询"
menu(1,2)=7
  menusub(1,0,0)="kctbFrame.asp?act=3&cid=3010"
  menusub(1,0,1)="按产品大类"
  menusub(1,1,0)="kctbFrame.asp?act=3&cid=3011"
  menusub(1,1,1)="按产品小类"
  menusub(1,2,0)="kctbFrame.asp?act=3&cid=3009"
  menusub(1,2,1)="按款式种类"
  menusub(1,3,0)="kctbFrame.asp?act=3&cid=3015"
  menusub(1,3,1)="按季节"
  menusub(1,4,0)="kctbFrame.asp?act=3&cid=3016"
  menusub(1,4,1)="按风格"
  menusub(1,5,0)="kctbFrame.asp?act=3&cid=3012"
  menusub(1,5,1)="按布种"
  menusub(1,6,0)=""
  menusub(1,6,1)="按价格段"
  menusub(1,7,0)=""'kctbFrame.asp?act=3&cid=3008
  menusub(1,7,1)="按品种汇总查询"
%>
<table width="149"  border="0" class="bar">
  <tr>
    <td height="16" align="center">库存查询</td>
  </tr>
</table>

<%dim i,j
for i=0 to 1%>
<table width="149" border="0" cellspacing="0" onClick="menu(<%=i%>);" class="menu" id="menu<%=i%>">
  <tr>
    <td><%=menu(i,1)%></td>
  </tr>
</table>

<table width="150" border="0" cellspacing="1" id="menusub<%=i%>">
<%for j=0 to menu(i,2)%>
  <tr>
    <td id="menuitem<%=i%><%=j%>" onClick="menuitem('<%=i%><%=j%>');" onMouseOver="miover('<%=i%><%=j%>');" onMouseOut="miout('<%=i%><%=j%>');" class="mistand">
	·
	<%if menusub(i,j,0)="" then%>
	 <%=menusub(i,j,1)%>
	<%else%>
	<a href="<%=menusub(i,j,0)%>" target="mainFrame"><%=menusub(i,j,1)%></a>
	<%end if%>
	</td>
  </tr>
  <%next%>
</table>
<%next%>
</body>
</html>
