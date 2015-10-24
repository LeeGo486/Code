<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!-- #include file="../inc/const.asp" -->
<%call head("")%>
<style type="text/css">
.tbhide{display:none;}
.tbshow{display:block;}
</style>
<script language="javascript">
function tb(tname){
  var t=document.all.item(tname);
  if(t.className=="tbhide")
    t.className="tbshow";
  else
    t.className="tbhide";
}
</script>

<body topmargin=1 leftmargin="0">
<%
dim i,rmax,cmax
dim tree(10,20)
rmax=10
cmax=20

tree(0,0)="url.gif,VIP管理"
tree(0,1)=8
tree(0,2)="advise.gif,登录顾客资料,vip_add.asp"
tree(0,3)="advise.gif,顾客资料查询,vip_search.asp"
tree(0,4)="advise.gif,发VIP卡,vip_sendcard.asp"
tree(0,5)="advise.gif,VIP客户管理,vip_card.asp"
'tree(0,6)="advise.gif,发储值卡,vip_card.asp"
'tree(0,7)="advise.gif,储值卡管理,vip_card.asp"
tree(0,6)="advise.gif,发生日礼物,vip_sendbrith.asp"
tree(0,7)="advise.gif,积分换购,"
tree(0,8)="advise.gif,积分查询,"
tree(0,9)="advise.gif,VIP贡献率,"

tree(1,0)="url.gif,短信管理"
tree(1,1)=4
tree(1,2)="advise.gif,发送短信,"
tree(1,3)="advise.gif,群发短信,"
tree(1,4)="advise.gif,定时发送短信,"
tree(1,5)="advise.gif,历史短信查询,"

%>
<%for i=0 to rmax
if tree(i,0)=null or tree(i,0)="" then
  exit for
end if
treemain=split(tree(i,0),",")
%>
<table width="170" border="0" cellspacing="0" cellpadding="0" id="tb<%=i%>">
  <tr valign="middle">
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="27"><img src="../skin/<%=session("skindir")%>/image/<%=treemain(0)%>" broder=0 height=25></td>
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="123" height="27"><font class="mainleftf1"><%=treemain(1)%></font></td>
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="20"><font class="mainleftf1"><a href="javascript:tb('tbs<%=i%>');"><img src="../skin/<%=session("skindir")%>/image/Test_35a.gif" border="0"></a></font></td>
  </tr>
</table>
<table width="170" border="0" cellspacing="0" cellpadding="0" id="tbs<%=i%>">
  <%for j=2 to cmax
  if tree(i,j)=null or tree(i,j)="" then
    response.Write("<tr height=8><td colspan=2></td></tr>")
    exit for
  end if
  treesub=split(tree(i,j),",")%>
  <tr>
    <td width="40"><img src="../skin/<%=session("skindir")%>/image/<%call showimg (j-1,tree(i,1))%>" border="0"><img src="../skin/<%=session("skindir")%>/image/<%=treesub(0)%>" border="0"></td>
    <td width="130"> <font class="mainleftf1"><a href="<%=treesub(2)%>" target="main"><%=treesub(1)%></a></font></td>
  </tr>
  <%next%>
</table>
<%next

sub showimg(t,m)
select case t
case 1 response.Write("c1.gif") 
case m response.Write("c3.gif")
case else response.write("c2.gif")
end select
end sub%>
</body>
</html>
