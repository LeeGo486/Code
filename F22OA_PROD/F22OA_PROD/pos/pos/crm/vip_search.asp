<%option explicit
session("formid")=6101024%>
<!--#include file="inc/function.asp"-->

<%dim opt,where,typ,val,ExportExcel,begindt,enddt,vipsums
opt=trim(request("opt"))
typ=request("typ")
if typ=1 then
  val=trim(request("valcard"))
else
  val=trim(request("val"))
end if
ExportExcel=request("ExportExcel")

begindt=request("rq1")
enddt=request("rq2")

if begindt="" then
 begindt=get_date(date)
end if

if enddt="" then
 enddt=get_date(date)
end if

if cint(ExportExcel)=1 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=�˿�VIP����.xls" 
end if

if opt="" then opt="1"
if opt="0" then
  where=" and isnull(a.vipcode,'')='' "
else
  where=" and isnull(a.vipcode,'')<>'' "
end if

if opt="" then opt="1"

if val="" then
   vipsums=0
else
   vipsums=val
end if 
select case typ
case 0 where=where
case 1 
    '�ж�ˢ�½�ȡ
	if request.cookies("vipflash")("cut")=1 then
	   where=where&" and substring('"&val&"',"&request.cookies("vipflash")("beg")&","&request.cookies("vipflash")("cnt")&") = a.vipcode "
	else
	   where=where&" and a.vipcode = '"&val&"'"
	end if

case 2 where=where&" and a.vipname like '%"&val&"%' "
case 3 where=where&" and a.mobtel = '"&val&"' "
case 4 where=where&" and convert(varchar(10),isnull(b.vipemit,'1900-01-02'),126) >= '"&begindt&"' and convert(varchar(10),isnull(b.vipemit,'1900-01-02'),126) <= '"&enddt&"' "
case 5 where=where&" and a.vipbirth >=convert(varchar(4),DATEPART(year, vipbirth))+'-'+convert(varchar(2),DATEPART(month, '"&begindt&"'))+'-'+ convert(varchar(2),DATEPART(day, '"&begindt&"'))"
where=where&" and a.vipbirth <=convert(varchar(4),DATEPART(year, vipbirth))+'-'+convert(varchar(2),DATEPART(month, '"&enddt&"'))+'-'+ convert(varchar(2),DATEPART(day, '"&enddt&"'))  "
case 6 where=where&" and a.tz_Name like '%"&val&"%' "
case 7  where=where&" and a.sums>= "&vipsums
case else where=where
end select


%>
<% if cint(ExportExcel)<>1 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP�˿����ϲ�ѯ</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript">
function rd(opt){
  window.location.href="vip_search.asp?opt="+opt;
}
function chkall(t)
{
	if(t)	{
		var v = document.forms[0].vipid;
			for(i=0;i<v.length;i++)
			{
				v[i].checked = t.checked;	
			}
			
	}
}
function vip(url){
	if(url){
  	var m=showModalDialog(url,'vipdetail','dialogWidth:590px;dialogHeight:450px;center: yes;help:no;status:no');
	}
}

function tz(url,obj){
	if(url){
  	var m=showModalDialog(url,'vipdetail','dialogWidth:300px;dialogHeight:180px;center: yes;help:no;status:no');
	  if (m!=""&&m!=undefined)
	  {
		  obj.value=m;
	  }
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
	 document.getElementById("divDate").style.display='none';
  }
  else if (typeid==4||typeid==5)
  {
     document.getElementById("divDate").style.display='';
	 document.getElementById("divNormal").style.display='none';
	 document.getElementById("divcard").style.display='none';
	 
  }
  else
  {
    document.getElementById("divDate").style.display='none';
	document.getElementById("divNormal").style.display='';
     document.getElementById("divcard").style.display='none';
  }
  
  if (typeid==7)
  {
     document.all.form1.val.value=0;
  }
  else
  {
    document.all.form1.val.value="";
  }
}
</script>
<style>
.tz{ border:0px; text-decoration: underline; cursor:hand; color:blue}
</style>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP�˿����ϲ�ѯ</td>
  </tr>
</table>

<form name="form1" method="post" action="vip_search.asp">
<input type="hidden" value="1" name="p" id="p" />
<input type="hidden" value="0" name="ExportExcel" id="ExportExcel" />
<table width="100%" border="0" class="f12">
  <tr>
    <td><input type="radio" name="opt" value="0" <%if opt="0" then%>checked<%end if%>>
      δ����
        <input type="radio" name="opt" value="1" <%if opt="1" then%>checked<%end if%>>
    �ѷ���</td>
	<td>
	<div style=" float:left">��ѯ��ʽ��<select name="typ"  onChange="changetype(this.value);" size=1>
	<option value=0></option>
	<option value=1 <% if typ="1" then %>selected <%end if%>>��VIP����</option>
	<option value=2 <% if typ="2" then %>selected <%end if%>>������</option>
	<option value=3 <% if typ="3" then %>selected <%end if%>>���ֻ���</option>
	<option value=4 <% if typ="4" then %>selected <%end if%>>����������</option>
	<option value=5 <% if typ="5" then %>selected <%end if%>>������</option>
	<option value=6 <% if typ="6" then %>selected <%end if%>>����չ��</option>
	<option value=7 <% if typ="7" then %>selected <%end if%>>���ܴ�ֵ</option>
	</select>
	</div>
	
	<div <% if typ="1" then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%> id="divcard" >
	    <input <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> name="valcard"  value="<%=val%>"size=20>
	</div>
	
	<div <% if typ<>"1" and typ<>"4" and typ<>"5"  then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%> id="divNormal" >
	     <input  type=text name="val"  value="<%=val%>"size=20>
	</div>
	
	<div id="divDate" name="divDate"  <% if typ="4" or typ="5" then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%>>
	<input name="rq1" type="text" id="rq1" onFocus="setday(this)" value=<%=begindt%>  size="9" maxlength="10" style="height:20px; ">
    <input name="rq2" type="text" id="rq2" size="9" maxlength="10" value=<%=enddt%>  onFocus="setday(this)" style="height:20px; ">
	</div>
	<input type="submit" name=subm value=" �� ѯ " onClick="document.all.form1.ExportExcel.value=0;this.disabled=true;this.value='���Ե�...';this.form.submit()">
	  <%if pexport then%>
	<input type="submit" name=subm value="����Excel" onClick="document.all.form1.ExportExcel.value=1;this.form.submit()">
	��<% end if %>
        <%
            if session("CF_Pos_SendMas")<>1 and session("psendmsg1")=true then
         %>	    
             <input type="button" value="���Ͷ���" onClick="this.form.action='vip_SMSSender.asp';this.form.submit()" />
         <% 
            end if
         %>
  
  </td>
  </tr>
</table>
<% end if %>
  <%
	
dim ds,sql,depotid
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
'����鿴ͬ�����µ��̵�VIP������
if session("vip_lookunit") then
	where=where&" and a.depotid in (select b.depotid from j_depot a,j_depot b where a.unitid=b.unitid and a.depotid="&qts(depotid)&") "
else
	where=where&" and a.depotid="&qts(depotid)
end if



if cint(typ)<>4 and  cint(typ)<>7 then 
sql= " select a.vipcode,vipemit=convert(varchar(10),b.vipemit,126),viplastdate=convert(varchar(10),b.viplastdate,126),a.vipid,a.vipname,tz_name=case when isnull(employeeid,'')<>'' then tz_name else 'δ����' end,a.vipsex,vipbirth=case when isnull(vipbirth,'')='' then '' else  convert(varchar(10),vipbirth,126) end, "&_
        "sr=case when isnull(vipbirth,'')='' then '' else  substring(convert(varchar(10),vipbirth,126),6,5) end, "&_
        "a.viptel,a.mobtel,a.QQ,a.weibo,a.vipemail,a.add_province,a.add_city,a.add_region,a.vipadd,a.noeyearsums,a.noeyearcnt,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,"&_
		 " a.pcentum,a.vipstate,a.vipcode,a.depotid,c.d_name,comment=isnull(a.comment,''),a.sums, a.viplove, "&_
         " a.AgeRange, a.Children, a.YearSums, a.YearNums, a.StyleDemand1, a.StyleDemand2, a.OccasionDemand1, a.OccasionDemand2, a.Hobby1, a.vipbrand1, "&_
         " a.Hobby2, a.Hobby3, a.ChildrenHave, a.ChildrenSex, a.Ayina, a.ToStoreTime1, a.ToStoreTime2, a.Body, a.Fabric, a.WeiXin, "&_
         " case when  a.FollowWeiXin = 1 then '��' else '��' end as FollowWeiXin, "&_
         " a.InforChannel, a.ShoppingType, a.FavouritesBook, a.FavouritesMoive, a.FavouritesColour, a.HopeGift, a.FavouritesActivties "&_
         "    ,a.FavouritesColour1,a.Fabric1 ,case when a.islunar=1 then '��' else '��' end as islunar ,a.family ,a.remarkFamily ,a.loveFruit ,a.remarkFruit ,a.role ,a.MemorialDay1  "&_
         "   ,a.MemorialDay2 ,a.remarkMemorial,a.firstDisc ,a.profession ,a.Position ,a.Constellation ,a.MarkActivitie1 ,a.MarkActivitie2 "&_
         "    ,a.ShoppingHabits ,a.Vehicle ,a.RemarkVehicle,a.Taboo ,case when a.isReceipt=1 then '��' else '��' end as isReceipt    ,a.ReceiptName ,a.Scarf "&_
		 " ,vitality,FCalcSums,ConsumeTimes,lastSums,lastNums"&_
		 " from vip_user a,vip_cardvip b,j_depot c where a.vipcode*=b.vipcardid and a.depotid*=c.depotid  "&where &" order by  	case when isnull(vipbirth,'')='' then '' else  substring(convert(varchar(10),vipbirth,126),6,5) end"	 
else
 sql= " select a.vipcode,vipemit=convert(varchar(10),b.vipemit,126),viplastdate=convert(varchar(10),b.viplastdate,126),a.vipid,a.vipname,tz_name=case when isnull(employeeid,'')<>'' then tz_name else 'δ����' end,a.vipsex,a.vipbirth,vipbirth=case when isnull(vipbirth,'')='' then '' else  convert(varchar(10),vipbirth,126) end, "&_
  "sr=case when isnull(vipbirth,'')='' then '' else  substring(convert(varchar(10),vipbirth,126),6,5) end, "&_
        "vipbirth=case when isnull(vipbirth,'')='' then '' else  substring(convert(varchar(10),vipbirth,126),6,5) end, "&_
        "a.viptel,a.mobtel,a.QQ,a.weibo,a.vipemail,a.add_province,a.add_city,a.add_region,a.vipadd,a.noeyearsums,a.noeyearcnt,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,"&_
		 " a.pcentum,a.vipstate,a.vipcode,a.depotid,c.d_name,comment=isnull(a.comment,''),a.sums, a.viplove, "&_
         " a.AgeRange, a.Children, a.YearSums, a.YearNums, a.StyleDemand1, a.StyleDemand2, a.OccasionDemand1, a.OccasionDemand2, a.Hobby1, a.vipbrand1, "&_
         " a.Hobby2, a.Hobby3, a.ChildrenHave, a.ChildrenSex, a.Ayina, a.ToStoreTime1, a.ToStoreTime2, a.Body, a.Fabric, a.WeiXin, "&_
          " case when  a.FollowWeiXin = 1 then '��' else '��' end as FollowWeiXin, "&_
         " a.InforChannel, a.ShoppingType, a.FavouritesBook, a.FavouritesMoive, a.FavouritesColour, a.HopeGift, a.FavouritesActivties "&_
             "    ,a.FavouritesColour1,a.Fabric1 ,case when a.islunar=1 then '��' else '��' end as islunar ,a.family ,a.remarkFamily ,a.loveFruit ,a.remarkFruit ,a.role ,a.MemorialDay1  "&_
         "   ,a.MemorialDay2 ,a.remarkMemorial,a.firstDisc ,a.profession ,a.Position ,a.Constellation ,a.MarkActivitie1 ,a.MarkActivitie2 "&_
         "    ,a.ShoppingHabits ,a.Vehicle ,a.RemarkVehicle,a.Taboo ,case when a.isReceipt=1 then '��' else '��' end as isReceipt    ,a.ReceiptName ,a.Scarf "&_
		 " ,vitality,FCalcSums,ConsumeTimes,lastSums,lastNums"&_
		 " from vip_user a,vip_cardvip b,j_depot c where a.vipcode=b.vipcardid and a.depotid=c.depotid  "&where 
end	if 
		 
ds.Open sql,cn,1,1
dim p,i,n

if cint(ExportExcel)<>1 then
ds.PageSize=15
else 
ds.PageSize=1000000
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
ҳ����<span style="color:red;"><%=p%></span>/<span style="color:red;"><%=ds.PageCount%></span>
    ÿҳ������ <span style="color:red;"><%=ds.PageSize%></span>
      ������<span style="color:red;"><%=ds.RecordCount%></span>
����
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(1);"<%end if%>>��ҳ</a>] 
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p-1%>);"<%end if%>>��һҳ</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p+1%>);"<%end if%>>��һҳ</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=ds.PageCount%>);"<%end if%>>βҳ</a>] 
</div>
<% end if %>

 <% if cint(ExportExcel)<>1 then %>
<table border="2" cellspacing="0" cellpadding="0" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF" style="table-layout:fixed;">
  <tr align="center">
 
    <td width="50"><input type="checkbox" name="ckall" id="ckall" onClick="chkall(this)"><label for="ckall">ѡ��</label></td>
    <td width="80">����</td>
	<%else%>
	<table border="1" cellspacing="0" cellpadding="0" bordercolor="#fff" class="f12" bordercolorlight="#FFFFFF" style="table-layout:fixed;">
  <tr align="center">
	<% end if %>
    <td width="60">����</td>
	<td width="60">�ͻ�����</td>
    <td width="30">�Ա�</td>
    <td width="70">��������</td>
    <td width="40">����</td>
    <td width="100">VIP״̬</td>
    <td width="120">VIP����</td>
	<td width="80">��������</td>
	<td width="80">�����������</td>
    <td width="140">��������</td>
    <td width="60">�ܻ���</td>
    <td width="70">�ϼ�����</td>
	<td width="80">�ܴ�ֵ</td>
    <td width="100">�̶��绰</td>
    <td width="100">�ƶ��绰</td>
    <td width="100">QQ</td>
    <td width="150">΢��</td>
    <td width="150">E-Mail</td>
    <td width="60">��ַʡ</td>
    <td width="60">��ַ��</td>
    <td width="60">��ַ��</td>
    <td width="200">�ֵ���ַ</td>
    <td width="60">һ�������ѽ��</td>
    <td width="60">һ��������Ƶ��</td>
    <td width="60">��������</td>
    <td width="60">�Ƿ�����</td>
    <td width="60">��Ů�Ա�</td>
    <td width="60">��Ů����</td>
    <td width="60">��������ѽ��</td>
    <td width="60">��������Ѵ���</td>
    <td width="60">�������һ</td>
    <td width="60">��������</td>
    <td width="60">��������һ</td>
    <td width="60">���������</td>
    <td width="60">���˰���һ</td>
    <td width="60">���˰��ö�</td>
    <td width="60">���˰�����</td>
    <td width="60">���˰�����</td>
    <td width="60">ϲ���ķ�װƷ��</td>
    <td width="60">ϲ���Ĳ�ױƷ��</td>
    <td width="60">ϲ������ʱ��һ</td>
    <td width="60">ϲ������ʱ�ζ�</td>
    <td width="60">����</td>
    <td width="60">���ϳɷ�ϲ��</td>
    <td width="60">΢��</td>
    <td width="60">��ע΢��</td>
    <td width="60">��ȡ��Ϣ������</td>
    <td width="60">��ȡ��������</td>
    <td width="60">ϲ�����鼮</td>
    <td width="60">ϲ���ĵ�Ӱ����</td>
    <td width="60">ɫ��ϲ��</td>
    <td width="60">�����յ�������</td>
    <td width="60">ϲ���Ĺ���</td>


    <td width="60">ɫ�ʰ���2</td>
    <td width="60">���ϳɷ�2</td>
    <td width="60">ũ��</td>
    <td width="60">��ͥ����</td>
    <td width="60">��ͥ���ɱ�ע</td>
    <td width="60">ϲ���ԵĶ���</td>
    <td width="60">ϲ���ԵĶ�����ע</td>
    <td width="60">������Ȧ�еĽ�ɫ</td>
    <td width="60">���ں�������1</td>
    <td width="60">���ں�������2</td>
    <td width="60">���ں������ӱ�ע</td>
    <td width="60">�׵�ʵ���ۿ�</td>
    <td width="60">��ҵ</td>
    <td width="60">ְλ</td>
    <td width="60">����</td>
    <td width="60">���е�Ӫ�������1</td>
    <td width="60">���е�Ӫ�������2</td>
    <td width="60">����ϰ��</td>
    <td width="60">���õĵ��귽ʽ</td>
    <td width="60">���õĵ��귽ʽ��ע</td>
    <td width="60">�˿͵ļɻ�</td>
    <td width="60">�Ƿ񾭳�����Ʊ</td>
    <td width="60">��Ʊ̧ͷ</td>
    <td width="60">�Ƿ�ϲ����Χ��</td>

    <td width="60">�˿ͻ�Ծ��</td>
    <td width="60">��ʵ�����</td>
    <td width="60">�����Ѵ���</td>
    <td width="60">������ѽ��</td>
    <td width="60">������Ѽ���</td>

    <td width="120">��ע</td>
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
%>

  <tr>
  <% if cint(ExportExcel)<>1 then %>
    <td align="center"><input type="checkbox" name="vipid" id="vipid" value="<%=ds("vipid")%>"></td>
    <td align="center">
    <%if pedit then%>
	<a href="vip_add.asp?act=edit&id=<%=ds("vipid")%>">�޸�</a>
	<%end if
	if pdel then%>
	<a href="vip_save.asp?act=del&id=<%=ds("vipid")%>">ɾ��</a>
	<%end if%>
	&nbsp;</td>
  <% end if %> 
    <td><a href="javascript:;" onClick="vip('vip_show.asp?act=view&id=<%=ds("vipid")%>');">
		<%=ds("vipname")%></a></td>
  <% if cint(ExportExcel)<>1 then %>  
	<td>
   <%
   if ds("depotid") = session("dm").System_Depotid then  %>
   <input class="tz" type="text" id="tzName<%=n%>" name="tzname<%=n%>" value="<%=ds("tz_name")%>" onClick="tz('vip_tz.asp?act=view&id=<%=ds("vipid")%>',this);" >&nbsp;
   <%else
    response.write(ds("tz_name"))
   end if %>
   </td>	
  <% else %>
    <td><%=ds("tz_name")%></td>  
  <% end if %>   
    <td><%=ds("vipsex")%></td>
    <td><%=ds("vipbirth")%></td>
    <td><%=ds("sr")%></td>
    <td>&nbsp;<%=ds("vipstate")%></td>
    <td><% if  session("pos_vipshow")=true then response.Write("*****") else  response.Write(""&ds("vipcode")&"")  end if  %>&nbsp;</td>
	<td><%=ds("vipemit")%>&nbsp;</td>
	<td><%=ds("viplastdate")%>&nbsp;</td>
    <td><%=ds("d_name")%>&nbsp;</td>
    <td><%=ds("centum")%></td>
    <td><%=ds("pcentum")%>&nbsp;</td>
	<td><%=ds("sums")%>&nbsp;</td>
    <td><%=ds("viptel")%>&nbsp;</td>
    <td><%=ds("mobtel")%>&nbsp;</td>
    <td><%=ds("QQ")%>&nbsp;</td>
    <td><%=ds("weibo")%>&nbsp;</td>
    <td><%=ds("vipemail")%>&nbsp;</td>
    <td><%=ds("add_province")%>&nbsp;</td>
    <td><%=ds("add_city")%>&nbsp;</td>
    <td><%=ds("add_region")%>&nbsp;</td>
    <td><%=ds("vipadd")%>&nbsp;</td>
    <td><%=ds("noeyearsums")%>&nbsp;</td>
    <td><%=ds("noeyearcnt")%>&nbsp;</td>
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



    <td><%=ds("comment")%>&nbsp;</td>
  </tr>
	<%ds.movenext
  next
  ds.close
  set ds=nothing%>
</table>
</form>
</body>
</html>