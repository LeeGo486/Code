<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
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
menu(0,1)="��ʱ���ѯ"
menu(0,2)=2
  menusub(0,0,0)=""
  menusub(0,0,1)="�����۲�ѯ"
  menusub(0,1,0)="tbFrame.asp?cid=3014"
  menusub(0,1,1)="�����۲�ѯ"
  menusub(0,2,0)="tbFrame.asp?cid=3013"
  menusub(0,2,1)="��ʱ��β�ѯ"
menu(1,0)=""
menu(1,1)="�����̲�ѯ"
  i=-1
  while not ds.eof
  i=i+1
  menusub(1,i,0)="tbFrame.asp?cid=3017&depotid="&ds(0)
  menusub(1,i,1)=ds(1)
  ds.moveNext
  wend
  ds.close
  i=i+1
  menusub(1,i,0)="tbFrame.asp?cid=3002"
  menusub(1,i,1)="���̻��ܲ�ѯ"
menu(1,2)=i
  
menu(2,0)=""
menu(2,1)="��ӪҵԱ"
menu(2,2)=0
  menusub(2,0,0)="tbFrame.asp?cid=3003"
  menusub(2,0,1)="��ӪҵԱ���ܲ�ѯ"
menu(3,0)=""
menu(3,1)="����Ʒ��ѯ"
menu(3,2)=7
  menusub(3,0,0)="tbFrame.asp?cid=3010"
  menusub(3,0,1)="����Ʒ����"
  menusub(3,1,0)="tbFrame.asp?cid=3011"
  menusub(3,1,1)="����ƷС��"
  menusub(3,2,0)="tbFrame.asp?cid=3009"
  menusub(3,2,1)="����ʽ����"
  menusub(3,3,0)="tbFrame.asp?cid=3015"
  menusub(3,3,1)="������"
  menusub(3,4,0)="tbFrame.asp?cid=3016"
  menusub(3,4,1)="�����"
  menusub(3,5,0)="tbFrame.asp?cid=3012"
  menusub(3,5,1)="������"
  menusub(3,6,0)=""
  menusub(3,6,1)="���۸��"
  menusub(3,7,0)="tbFrame.asp?cid=3008"
  menusub(3,7,1)="��Ʒ�ֻ��ܲ�ѯ"
%>
<table width="149"  border="0" class="bar">
  <tr>
    <td height="16" align="center">���۲�ѯ</td>
  </tr>
</table>

<%dim i,j
for i=0 to 3%>
<table width="149" border="0" cellspacing="0" onClick="menu(<%=i%>);" class="menu" id="menu<%=i%>">
  <tr>
    <td><%=menu(i,1)%></td>
  </tr>
</table>

<table width="150" border="0" cellspacing="1" id="menusub<%=i%>">
<%for j=0 to menu(i,2)%>
  <tr>
    <td id="menuitem<%=i%><%=j%>" onClick="menuitem('<%=i%><%=j%>');" onMouseOver="miover('<%=i%><%=j%>');" onMouseOut="miout('<%=i%><%=j%>');" class="mistand">
	��
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
