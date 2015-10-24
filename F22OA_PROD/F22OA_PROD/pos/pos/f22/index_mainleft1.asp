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

tree(0,0)="url.gif,进货管理"
tree(0,1)=4
tree(0,2)="advise.gif,下生产计划,"
tree(0,3)="advise.gif,录入载床数量,"
tree(0,4)="advise.gif,生产入库,"
tree(0,5)="advise.gif,次品退厂,"


tree(1,0)="url.gif,加盟发货管理"
tree(1,1)=6
tree(1,2)="advise.gif,加盟商订货,f22_index.asp?com=2-1-1"
tree(1,3)="advise.gif,加盟商补货,f22_index.asp?com=2-1-2"
tree(1,4)="advise.gif,做铺场计划,f22_index.asp?com=2-1-2"
tree(1,5)="advise.gif,给加盟商配货,f22_index.asp?com=2-1-3"
tree(1,6)="advise.gif,给加盟商发货,f22_index.asp?com=2-1-4"
tree(1,7)="advise.gif,加盟商收货,f22_index.asp?com=2-1-5"

tree(2,0)="url.gif,加盟换货管理"
tree(2,1)=5
tree(2,2)="advise.gif,加盟商申请正常换货,f22_index.asp?com=5-1-1"
tree(2,3)="advise.gif,加盟商申请特殊换货,f22_index.asp?com=5-1-2"
tree(2,4)="advise.gif,审批换货申请,f22_index.asp?com=5-1-2"
tree(2,5)="advise.gif,加盟商退货发货,f22_index.asp?com=5-1-5"
tree(2,6)="advise.gif,仓库收货,f22_index.asp?com=2-2-2"

tree(3,0)="url.gif,店铺管理"
tree(3,1)=4
tree(3,2)="advise.gif,调拨发货,f22_index.asp?com=3-2-1"
tree(3,3)="advise.gif,调拨收货,f22_index.asp?com=3-2-2"
tree(3,4)="advise.gif,店铺零售,f22_index.asp?com=3-2-3"
tree(3,5)="advise.gif,盘点管理,f22_index.asp?com=3-2-4"

tree(4,0)="url.gif,财务管理"
tree(4,1)=5
tree(4,2)="advise.gif,供应商付款凭证管理,"
tree(4,3)="advise.gif,供应商的对帐单,"
tree(4,4)="advise.gif,加盟商收款凭证管理,"
tree(4,5)="advise.gif,加盟商的对帐单,"
tree(4,6)="advise.gif,加盟商订金管理,"

tree(5,0)="url.gif,计划管理"
tree(5,1)=3
tree(5,2)="advise.gif,根据销售制定补货建议,"
tree(5,3)="advise.gif,根据销售制定销售预测,"
tree(5,4)="advise.gif,根据订单制定生产计划,"

tree(6,0)="url.gif,报表查询"
tree(6,1)=3
tree(6,2)="advise.gif,库存查询,"
tree(6,3)="advise.gif,销售查询,"
tree(6,4)="advise.gif,进销存查询,"

tree(7,0)="url.gif,扩展功能"
tree(7,1)=3
tree(7,2)="advise.gif,调价管理,"
tree(7,3)="advise.gif,巡店登记,"
tree(7,4)="advise.gif,竞争品牌调查,"

tree(8,0)="f22_01.jpg,档案管理"
tree(8,1)=15
tree(8,2)="f22_02.jpg,地区档案,"
tree(8,3)="f22_03.jpg,店铺类别档案,"
tree(8,4)="f22_04.jpg,常用资料档案,"
tree(8,5)="f22_05.jpg,收付款方式档案,"
tree(8,6)="f22_06.jpg,供应商档案,"
tree(8,7)="f22_06.jpg,分机支构档案,"
tree(8,8)="f22_02.jpg,颜色档案,"
tree(8,9)="f22_03.jpg,尺码档案,"
tree(8,10)="f22_04.jpg,尺码组档案,"
tree(8,11)="f22_05.jpg,品牌档案,"
tree(8,12)="f22_03.jpg,款式资料档案,"
tree(8,13)="f22_04.jpg,店铺虚拟结构分类,"
tree(8,14)="f22_05.jpg,款式虚拟结构分类,"
tree(8,15)="f22_06.jpg,营业员班次档案,"
tree(8,16)="f22_06.jpg,营业员档案,"

tree(9,0)="url.gif,系统设置"
tree(9,1)=17
tree(9,2)="advise.gif,加盟商发换货参数设置,"
tree(9,3)="advise.gif,店铺冻结,"
tree(9,4)="advise.gif,设置款式单价,"
tree(9,5)="advise.gif,设置新旧条码对照关系,"
tree(9,6)="advise.gif,设置款式面料号,"
tree(9,7)="advise.gif,设置单据打印标题,"
tree(9,8)="advise.gif,设置预警控制,"
tree(9,9)="advise.gif,锁定或取消锁定帐目,"
tree(9,10)="advise.gif,创建工作组,"
tree(9,11)="advise.gif,给工作组分配权限,"
tree(9,12)="advise.gif,给操作员分配权限,"
tree(9,13)="advise.gif,重算库存,"
tree(9,14)="advise.gif,重算供应商余额,"
tree(9,15)="advise.gif,重算加盟商余额,"
tree(9,16)="advise.gif,制定库存系数,"
tree(9,17)="advise.gif,制定安全库存系数,"
tree(9,18)="advise.gif,维护操作日志,"

%>
<%for i=0 to rmax
if tree(i,0)=null or tree(i,0)="" then
  exit for
end if
treemain=split(tree(i,0),",")
%>
<table width="170" border="0" cellspacing="0" cellpadding="0" id="tb<%=i%>">
  <tr valign="middle">
    <td background="../skin/<%=session("skindir")%>/image/index_151.gif"  width="27"><img src="../skin/<%=session("skindir")%>/image/<%=treemain(0)%>" broder=0></td>
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
    <td width="50"><img src="../skin/<%=session("skindir")%>/image/<%call showimg (j-1,tree(i,1))%>" border="0"><img src="../skin/<%=session("skindir")%>/image/<%=treesub(0)%>" border="0"></td>
    <td width="120"> <font class="mainleftf1"><a href="<%=treesub(2)%>" target="main"><%=treesub(1)%></a></font></td>
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
