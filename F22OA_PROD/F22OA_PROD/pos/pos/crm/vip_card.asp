<%option explicit
session("formid")=6101025
function i2s(val)
	if val>0 then
		i2s="<font color='green'>"&val&"</font>"
	elseif val<0 then
		i2s="<font color='red'>"&val&"</font>"
	else
		i2s="-"
	end if
end function
%>
<!--#include file="../f22/inc/function.asp"-->

<% dim ExportExcel

ExportExcel=request("ExportExcel")

if cint(ExportExcel)=1 then
  response.Write "<meta http-equiv='Content-Type' content='text/html' charset='gb2312' />"  
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=顾客VIP资料.xls" 
end if


dim ds,sql,depotid,typ,val,ss,updatecheck,vipstate,tempcard,vipoccupation,vippay,vipstate2
typ=request("typ")
if typ="" then 
  typ=1
end if
if typ=1 then
  val=trim(request("valcard"))
else
  val=trim(request("val"))
end if
vipoccupation=trim(request("vipoccupation"))
vippay=trim(request("vippay"))
vipstate2=trim(request("vipstate2"))
updatecheck=request("updatecheck")
tempcard=request("tempcard")

%>

<%
dim  rs

set rs=server.CreateObject("ADODB.Recordset")

rs.ActiveConnection = cn


sub get_rs(lookupid,oldvalue)
 rs.source="select lookname from j18_lookupsub where lookupid='"&lookupid&"' order by lookcode"
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=oldvalue then response.Write" selected " end if
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub


%>


<% if cint(ExportExcel)<>1 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function vip(url){
	if(url){
  	var m=showModalDialog(url,'vipdetail','dialogWidth:600px;dialogHeight:520px;center: yes;help:no;status:no');
	}
}
function jumpPage(p)
{
	document.forms[0].p.value = p;
	document.forms[0].submit();
}

function changetype(typeid)
{
  if (typeid==1)
  {
  	 document.getElementById("divcard").style.display='';
	 document.getElementById("divNormal").style.display='none';
	 document.getElementById("divDate4").style.display='none';
	 document.getElementById("divDate5").style.display='none';
	 document.getElementById("divDate6").style.display='none';
	 
	 
  }
  else  if (typeid==4||typeid==5||typeid==6)
  {
     var divname="divDate"+typeid;
	 document.getElementById("divNormal").style.display='none';
	 document.getElementById("divDate4").style.display='none';
	 document.getElementById("divDate5").style.display='none';
	 document.getElementById("divDate6").style.display='none';
	 document.getElementById("divcard").style.display='none';
	 document.getElementById(divname).style.display='';
  }
  else
  {
    document.getElementById("divDate4").style.display='none';
	document.getElementById("divDate5").style.display='none';
	document.getElementById("divDate6").style.display='none';
    document.getElementById("divcard").style.display='none';
	document.getElementById("divNormal").style.display='';
    
  }
}

</script>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP顾客查询</td>
  </tr>
</table>
<div style="padding:10px;">
<table  border="0">

<form name="form1" method="post" action="vip_card.asp">
<input type="hidden" value="1" name="p" id="p" />
<input type="hidden" value="0" name="ExportExcel" id="ExportExcel" />
  <tr>
    <td><div style=" float:left">查询：
      <select name="typ" size=1  onChange="changetype(this.value);">
      <%if session("cf_VipSet_bmst") then%>
      <option value=0 <%if typ="0" then response.write "selected=selected"%>>全部</option>
      <% End If %>
	   <option value=1 <%if typ="1" then response.write "selected=selected"%>>按VIP卡号</option>
       <option value=2 <%if typ="2" then response.write "selected=selected"%>>按姓名</option>
     
     
      <option value=3 <%if typ="3" then response.write "selected=selected"%>>按手机号</option>
      <option value=4 <%if typ="4" then response.write "selected=selected"%>>按职业</option>
	  <option value=5 <%if typ="5" then response.write "selected=selected"%>>按收入</option>
	  <option value=6 <%if typ="6" then response.write "selected=selected"%>>按vip状态</option>
      </select>
	  
	  </div>
	  
	<div <% if typ="1" then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%> id="divcard" >
	    <input <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> name="valcard"  value="<%=val%>"size=20>
	</div>  
	
	<div <% if typ<>"1" and typ<>"4" and typ<>"5" and typ<>"6"  then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%> id="divNormal" >
	     <input type=text name="val"  value="<%=val%>"size=15>
	</div>
	
	<div id="divDate4" name="divDate4"  <% if typ="4"  then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%>>
	 <select name="vipoccupation" id="vipoccupation" class="2009">
        <option></option>
         <% get_rs 3001,vipoccupation%>
	 </select>
	</div>
	
	<div id="divDate5" name="divDate5"  <% if  typ="5" then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%>>
	 <select name="vippay" id="vippay" class="2009">
        <option></option>
         <% get_rs 3002,vippay%>
	 </select>
	</div>
	
	<div id="divDate6" name="divDate6"  <% if  typ="6" then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%>>
	 <select name="vipstate2" id="vipstate2" class="2009">
        <option></option>
        <% get_rs 3010,vipstate2%>
	 </select>
	</div>
	
	<input type=submit name=subm value=" 查 询 " onClick="document.all.form1.ExportExcel.value=0;this.disabled=true;this.value='请稍等...';this.form.submit()" />
	  <%if pexport then%>
	<input type="submit" name=subm value="导出Excel" onClick="document.all.form1.ExportExcel.value=1;this.form.submit()">
	　<% end if %>
  <%if session("cf_VipSet_syjm") and session("cf_VipSet_bmst") then%>
  &nbsp;&nbsp;过滤：
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck1" value="0" title="升级通过或未升级的卡" <%if instr(updatecheck,"0")>0 then response.write "checked"%>>
	正常</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck1" value="1" title="资料不完整" <%if instr(updatecheck,"1")>0 then response.write "checked"%>>
	审核中</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck2" value="2" title="资料不完整" <%if instr(updatecheck,"2")>0 then response.write "checked"%>>
	退回</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck3" value="3" title="被撤消的升级申请" <%if instr(updatecheck,"3")>0 then response.write "checked"%>>
	撤消</label>
	<label>
	<input type="checkbox" name="tempcard" id="tempcard" value="1" title="临时卡：符合一次性消费升级，并未通过审核" <%if tempcard="1" then response.write "checked"%>>
	临时卡</label>
  <% End If %>
  </td>
  </tr>
</form>
</table>
<% end if %>

<%if typ="" then response.end()%>
<%
select case typ
case 1 
    '判断刷新截取
	if request.cookies("vipflash")("cut")=1 then
	   ss=" and substring('"&val&"',"&request.cookies("vipflash")("beg")&","&request.cookies("vipflash")("cnt")&") = a.vipcode "
	else
	   ss=" and a.vipcode = '"&val&"'"
	end if
case 2
	if session("cf_VipSet_bmst") then
		 ss=" and a.vipname like '%"&val&"%' "
 	else
		 ss=" and a.vipname = '"&val&"' "
	end if
 
case 3 ss=" and a.mobtel = '"&val&"' "

case 4 ss=" and a.vipoccupation  = '"&vipoccupation&"' "
case 5 ss=" and a.vippay  = '"&vippay&"' "
case 6 ss=" and a.vipstate  = '"&vipstate2&"' "
case else ss=""
end select

if  typ=4 and  vipoccupation="" then ss=""
if  typ=5 and  vippay="" then ss=""
if  typ=6 and  vipstate2="" then ss=""

Dim uc,tc
depotid=trim(session("dm").System_depotid)

'允许查看同机构下店铺的VIP卡资料
if session("vip_lookunit") then
	ss=ss&" and a.depotid in (select b.depotid from j_depot a,j_depot b where a.unitid=b.unitid and a.depotid="&qts(depotid)&") "
else
	ss=ss&" and a.depotid="&qts(depotid)
end if

set ds=server.CreateObject("ADODB.Recordset")
dim sqlstr
sqlstr=""
if updatecheck<>"" then 
	sqlstr=" and isnull(a.updatecheck,0) in("&updatecheck&") "
end if
if tempcard<>"" then 
	sqlstr=sqlstr&" and isnull(b.tempcard,0)="&tempcard&""
end if

sql= "select a.vipid,vipemit=convert(varchar(10),b.vipemit,126),viplastdate=convert(varchar(10),b.viplastdate,126),a.vipcode,a.vipname,a.vipsex,a.viptel,a.mobtel,a.crdate,"&_
		 " isnull(a.sums,0)+isnull(b.starsums,0) sums,isnull(b.tempcard,0) as tempcard, "&_
		 " convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126) as jViplastdate, "&_
		 " convert(char(10),b.enddate,126) as jEnddate,"&_
		 " convert(char(10),b.vipemit+isnull(b.limitday,0),126) as jLimitday,"&_
     " isnull(a.centum,0)+isnull(b.starcentum,0) centum,convert(char(10),a.vipbirth,126) as vipbirth,substring(convert(char(10),a.vipbirth,126),6,5) as sr,"&_
		 " isnull(updatecheck,0) as updatecheck,a.QQ,a.weibo,a.vipemail,a.add_province,a.add_city,a.add_region,a.vipadd,a.noeyearsums,noeyearcnt, "&_
		 " a.pcentum,vipstate=isnull(a.vipstate,'普通'),a.vipcode,(select x.d_name from j_depot x where x.depotid=a.depotid) as d_name,a.comment, "&_
     " a.AgeRange, a.Children, a.YearSums, a.YearNums, a.StyleDemand1, a.StyleDemand2, a.OccasionDemand1, a.OccasionDemand2, a.Hobby1, a.vipbrand1, "&_
         " a.Hobby2, a.Hobby3, a.ChildrenHave, a.ChildrenSex, a.Ayina, a.ToStoreTime1, a.ToStoreTime2, a.Body, a.Fabric, a.WeiXin, "&_
         " case when  a.FollowWeiXin = 1 then '是' else '否' end as FollowWeiXin, a.viplove, "&_
         " a.InforChannel, a.ShoppingType, a.FavouritesBook, a.FavouritesMoive, a.FavouritesColour, a.HopeGift, a.FavouritesActivties "&_
                      "    ,a.FavouritesColour1,a.Fabric1 ,case when a.islunar=1 then '是' else '否' end as islunar ,a.family ,a.remarkFamily ,a.loveFruit ,a.remarkFruit ,a.role ,a.MemorialDay1  "&_
         "   ,a.MemorialDay2 ,a.remarkMemorial,a.firstDisc ,a.profession ,a.Position ,a.Constellation ,a.MarkActivitie1 ,a.MarkActivitie2 "&_
         "    ,a.ShoppingHabits ,a.Vehicle ,a.RemarkVehicle,a.Taboo ,case when a.isReceipt=1 then '是' else '否' end as isReceipt    ,a.ReceiptName ,a.Scarf "&_
		 " ,vitality,FCalcSums,ConsumeTimes,lastSums,lastNums"&_
     " from vip_user a,vip_cardvip b where a.vipcode=b.vipcardid and isnull(a.vipcode,'')<>'' "&sqlstr&ss
'de sql
ds.Open sql,cn,1,1

dim p,i,n
if cint(ExportExcel)<>1 then 
ds.PageSize=15
else 
ds.PageSize=10000000
end if 
p=1

if Request("p")<>"" then
	p=cint(Request("p"))
	if p<1 then
		p=1
	end if
	if p>ds.PageCount then
		p=ds.PageCount
	end if
end if
%>
<% if cint(ExportExcel)<>1 then %>

<div style="line-height:25px;padding:10px;font-size:12px;">
页数：<span style="color:red;"><%=p%></span>/<span style="color:red;"><%=ds.PageCount%></span>
    每页数量： <span style="color:red;"><%=ds.PageSize%></span>
      总数：<span style="color:red;"><%=ds.RecordCount%></span>
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(1);"<%end if%>>首页</a>] 
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p-1%>);"<%end if%>>上一页</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p+1%>);"<%end if%>>下一页</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=ds.PageCount%>);"<%end if%>>尾页</a>] 
</div>

<table   width="400%" border="1" cellspacing="1" cellpadding="2" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
<%else%>
<table   width="400%" border="1" cellspacing="1" cellpadding="2" bordercolor="#FFF" class="f12" bordercolorlight="#FFFFFF">
<% end if %>
  <tr align="center">
    <td width="80">VIP卡号</td>
    <td width="100">登记日期</td>
    <td width="60">状态</td>
    <td width="70">VIP状态</td>
    <td width="150">发卡店铺</td>
	<td width="100">发卡日期</td>
	<td width="120">最后消费日期</td>
    <td width="60">姓名</td>
    <td width="100">出生日期</td>
    <td width="60">生日</td>
    <td width="30">性别</td>
    <td width="100">固定电话</td>
    <td width="85">移动电话</td>
    
    <td width="100">QQ</td>
    <td width="150">微博</td>
    <td width="150">E-Mail</td>
    <td width="60">地址省</td>
    <td width="60">地址市</td>
    <td width="80">地址区</td>
    <td width="300">街道地址</td>
    <td width="100">一年内消费金额</td>
    <td width="100">一年内消费频次</td>

    <td width="50">总积分</td>
    <td width="60">上季积分</td>
    <td width="80">总储值</td>

    <td width="60">年龄区间</td>
    <td width="60">是否育儿</td>
    <td width="60">子女性别</td>
    <td width="60">子女年龄</td>
    <td width="60">本年度消费金额</td>
    <td width="60">本年度消费次数</td>
    <td width="60">风格需求一</td>
    <td width="60">风格需求二</td>
    <td width="60">场合需求一</td>
    <td width="60">场合需求二</td>
    <td width="60">个人爱好一</td>
    <td width="60">个人爱好二</td>
    <td width="60">个人爱好三</td>
    <td width="60">个人爱好四</td>
    <td width="60">喜爱的服装品牌</td>
    <td width="60">喜爱的彩妆品牌</td>
    <td width="60">喜欢来店时段一</td>
    <td width="60">喜欢来店时段二</td>
    <td width="60">身型</td>
    <td width="60">面料成分喜好</td>
    <td width="60">微信</td>
    <td width="60">关注微信</td>
    <td width="60">获取信息的渠道</td>
    <td width="60">获取购物渠道</td>
    <td width="60">喜爱的书籍</td>
    <td width="80">喜爱的电影类型</td>
    <td width="60">色彩喜好</td>
    <td width="60">期望收到的礼物</td>
    <td width="60">喜欢的公益活动</td>

        <td width="60">色彩爱好2</td>
    <td width="60">面料成份2</td>
    <td width="60">农历</td>
    <td width="60">家庭构成</td>
    <td width="60">家庭构成备注</td>
    <td width="60">喜欢吃的东西</td>
    <td width="60">喜欢吃的东西备注</td>
    <td width="60">在朋友圈中的角色</td>
    <td width="60">最在乎的日子1</td>
    <td width="60">最在乎的日子2</td>
    <td width="60">最在乎的日子备注</td>
    <td width="60">首单实销折扣</td>
    <td width="60">行业</td>
    <td width="60">职位</td>
    <td width="60">星座</td>
    <td width="60">敏感的营销活动类型1</td>
    <td width="60">敏感的营销活动类型2</td>
    <td width="60">购物习惯</td>
    <td width="60">常用的到店方式</td>
    <td width="60">常用的到店方式备注</td>
    <td width="60">顾客的忌讳</td>
    <td width="60">是否经常开发票</td>
    <td width="60">发票抬头</td>
    <td width="60">是否喜欢带围巾</td>

    <td width="60">顾客活跃度</td>
    <td width="60">总实销金额</td>
    <td width="60">总消费次数</td>
    <td width="60">最后消费金额</td>
    <td width="60">最后消费件数</td>

    <td width="60">操作</td>
  </tr>

  <%
if not ds.Bof and not ds.Eof then
ds.ABSolutePage=p
end if
i=1
for n=0 to ds.PageSize-1
if ds.Eof then
		exit for
	end if
vipstate="正常"
uc=ds("updatecheck")
tc=ds("tempcard")
	if uc=1 then
		vipstate=" <span style='color:green'>升级审核中</span>"
	elseif uc=2 then
		vipstate=" <span style='color:blue' title='该VIP卡升级被退回，此状态不影响VIP正常消费，但请尽快修改该顾客资料'>升级被退回</span>"
	elseif uc=3 then
		vipstate=" <span style='color:red'>升级被撤消</span>"
	elseif tc=1 then
		vipstate=" <span style='color:red'>临时卡</span>"
	end if
	
	if session("cf_VipSet_syjm") then
		if datediff("d",date(),ds("jViplastdate"))<0 or datediff("d",date(),ds("jLimitday"))<0 then
		  vipstate=" <span style='color:gray'>已失效</span>"
		end if
	else
		if datediff("d",date(),ds("jViplastdate"))<0 or datediff("d",date(),ds("jEnddate"))<0 or isnull(ds("jEnddate"))  then
		  vipstate=" <span style='color:gray'>已失效</span>"
		end if
	end if
	
%>
  <tr>
    <td>&nbsp;<a href="javascript:vip('vip_xf.asp?id=<%=ds("vipid")%>')" ><% if  session("pos_vipshow")=true then response.Write("*****") else response.Write(""&ds("vipcode")&"")  end if  %></a></td>
    <td><%=get_date(ds("crdate"))%></td>
    <td><%=vipstate%></td>
    <td><%=ds("vipstate")%>&nbsp;</td>
    <td><%=ds("d_name")%>&nbsp;</td>
	<td><%=ds("vipemit")%>&nbsp;</td>
	<td><%=ds("viplastdate")%>&nbsp;</td>
    <td><%=ds("vipname")%></td>
    <td><%=ds("vipbirth")%></td>
    <td><%=ds("sr")%></td>
    <td><%=ds("vipsex")%></td>
    <td><%=ds("viptel")%>&nbsp;</td>
    <td><%=ds("mobtel")%></td>
    
    <td><%=ds("QQ")%>&nbsp;</td>
    <td><%=ds("weibo")%>&nbsp;</td>
    <td><%=ds("vipemail")%>&nbsp;</td>
    <td><%=ds("add_province")%>&nbsp;</td>
    <td><%=ds("add_city")%>&nbsp;</td>
    <td><%=ds("add_region")%>&nbsp;</td>
    <td><%=ds("vipadd")%>&nbsp;</td>
    <td><%=ds("noeyearsums")%>&nbsp;</td>
    <td><%=ds("noeyearcnt")%>&nbsp;</td>

    <td><%=ds("centum")%></td>
    <td><%=ds("pcentum")%></td>
    <td><%=ds("sums")%></td>

    <td><%=ds("AgeRange")%>&nbsp;</td>
    <td><%=ds("ChildrenHave")%>&nbsp;</td>
    <td><%=ds("ChildrenSex")%>&nbsp;</td>
    <td><%=ds("Children")%>&nbsp;</td>
    <td><%=ds("YearSums")%>&nbsp;</td>
    <td><%=ds("YearNums")%>&nbsp;</td>
    <td><%=ds("StyleDemand1")%>&nbsp;</td>
    <td><%=ds("StyleDemand2")%>&nbsp;</td>
    <td><%=ds("OccasionDemand1")%>&nbsp;</td>
    <td><%=ds("OccasionDemand2")%>&nbsp;</td>
    <td><%=ds("viplove")%>&nbsp;</td>
    <td><%=ds("Hobby1")%>&nbsp;</td>
    <td><%=ds("Hobby2")%>&nbsp;</td>
    <td><%=ds("Hobby3")%>&nbsp;</td>
    <td><%=ds("vipbrand1")%>&nbsp;</td>
    <td><%=ds("Ayina")%>&nbsp;</td>
    <td><%=ds("ToStoreTime1")%>&nbsp;</td>
    <td><%=ds("ToStoreTime2")%>&nbsp;</td>
    <td><%=ds("Body")%>&nbsp;</td>
    <td><%=ds("Fabric")%>&nbsp;</td>
    <td><%=ds("WeiXin")%>&nbsp;</td>
    <td><%=ds("FollowWeiXin")%>&nbsp;</td>
    <td><%=ds("InforChannel")%>&nbsp;</td>
    <td><%=ds("ShoppingType")%>&nbsp;</td>
    <td><%=ds("FavouritesBook")%>&nbsp;</td>
    <td><%=ds("FavouritesMoive")%>&nbsp;</td>
    <td><%=ds("FavouritesColour")%>&nbsp;</td>
    <td><%=ds("HopeGift")%>&nbsp;</td>
    <td><%=ds("FavouritesActivties")%>&nbsp;</td>

        <td><%=ds("FavouritesColour1")%>&nbsp;</td>
    <td><%=ds("Fabric1")%>&nbsp;</td>
    <td><%=ds("islunar")%>&nbsp;</td>
    <td><%=ds("family")%>&nbsp;</td>
    <td><%=ds("remarkFamily")%>&nbsp;</td>
    <td><%=ds("loveFruit")%>&nbsp;</td>
    <td><%=ds("remarkFruit")%>&nbsp;</td>
    <td><%=ds("role")%>&nbsp;</td>
    <td><%=ds("MemorialDay1")%>&nbsp;</td>
    <td><%=ds("MemorialDay2")%>&nbsp;</td>
    <td><%=ds("remarkMemorial")%>&nbsp;</td>
    <td><%=ds("firstDisc")%>&nbsp;</td>
    <td><%=ds("profession")%>&nbsp;</td>
    <td><%=ds("Position")%>&nbsp;</td>
    <td><%=ds("Constellation")%>&nbsp;</td>
    <td><%=ds("MarkActivitie1")%>&nbsp;</td>
    <td><%=ds("MarkActivitie2")%>&nbsp;</td>
    <td><%=ds("ShoppingHabits")%>&nbsp;</td>
    <td><%=ds("Vehicle")%>&nbsp;</td>
    <td><%=ds("RemarkVehicle")%>&nbsp;</td>
    <td><%=ds("Taboo")%>&nbsp;</td>
    <td><%=ds("isReceipt")%>&nbsp;</td>
    <td><%=ds("ReceiptName")%>&nbsp;</td>
    <td><%=ds("Scarf")%>&nbsp;</td>
    <td><%=ds("vitality")%>&nbsp;</td>
    <td><%=ds("FCalcSums")%>&nbsp;</td>
    <td><%=ds("ConsumeTimes")%>&nbsp;</td>
    <td><%=ds("lastSums")%>&nbsp;</td>
    <td><%=ds("lastNums")%>&nbsp;</td>

    <td>
    <a href="javascript:vip('vip_show.asp?act=view&id=<%=ds("vipid")%>');">详细</a>
    <%if uc=2 then %><a href="javascript:vip('../vip/vip_addcard.asp?act=edit&id=<%=ds("vipid")%>');">修改</a><%end if%>
    </td>
  </tr>
	<%ds.movenext
  next
  ds.close
  set ds=nothing%>
</table>
</div>
</body>
</html>
