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
  response.AddHeader "content-disposition", "attachment; filename=�˿�VIP����.xls" 
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
<title>�ޱ����ĵ�</title>
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
    <td align="center">VIP�˿Ͳ�ѯ</td>
  </tr>
</table>
<div style="padding:10px;">
<table  border="0">

<form name="form1" method="post" action="vip_card.asp">
<input type="hidden" value="1" name="p" id="p" />
<input type="hidden" value="0" name="ExportExcel" id="ExportExcel" />
  <tr>
    <td><div style=" float:left">��ѯ��
      <select name="typ" size=1  onChange="changetype(this.value);">
      <%if session("cf_VipSet_bmst") then%>
      <option value=0 <%if typ="0" then response.write "selected=selected"%>>ȫ��</option>
      <% End If %>
	   <option value=1 <%if typ="1" then response.write "selected=selected"%>>��VIP����</option>
       <option value=2 <%if typ="2" then response.write "selected=selected"%>>������</option>
     
     
      <option value=3 <%if typ="3" then response.write "selected=selected"%>>���ֻ���</option>
      <option value=4 <%if typ="4" then response.write "selected=selected"%>>��ְҵ</option>
	  <option value=5 <%if typ="5" then response.write "selected=selected"%>>������</option>
	  <option value=6 <%if typ="6" then response.write "selected=selected"%>>��vip״̬</option>
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
	
	<input type=submit name=subm value=" �� ѯ " onClick="document.all.form1.ExportExcel.value=0;this.disabled=true;this.value='���Ե�...';this.form.submit()" />
	  <%if pexport then%>
	<input type="submit" name=subm value="����Excel" onClick="document.all.form1.ExportExcel.value=1;this.form.submit()">
	��<% end if %>
  <%if session("cf_VipSet_syjm") and session("cf_VipSet_bmst") then%>
  &nbsp;&nbsp;���ˣ�
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck1" value="0" title="����ͨ����δ�����Ŀ�" <%if instr(updatecheck,"0")>0 then response.write "checked"%>>
	����</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck1" value="1" title="���ϲ�����" <%if instr(updatecheck,"1")>0 then response.write "checked"%>>
	�����</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck2" value="2" title="���ϲ�����" <%if instr(updatecheck,"2")>0 then response.write "checked"%>>
	�˻�</label>
	<label>
	<input type="checkbox" name="updatecheck" id="updatecheck3" value="3" title="����������������" <%if instr(updatecheck,"3")>0 then response.write "checked"%>>
	����</label>
	<label>
	<input type="checkbox" name="tempcard" id="tempcard" value="1" title="��ʱ��������һ����������������δͨ�����" <%if tempcard="1" then response.write "checked"%>>
	��ʱ��</label>
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
    '�ж�ˢ�½�ȡ
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

'����鿴ͬ�����µ��̵�VIP������
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
		 " a.pcentum,vipstate=isnull(a.vipstate,'��ͨ'),a.vipcode,(select x.d_name from j_depot x where x.depotid=a.depotid) as d_name,a.comment, "&_
     " a.AgeRange, a.Children, a.YearSums, a.YearNums, a.StyleDemand1, a.StyleDemand2, a.OccasionDemand1, a.OccasionDemand2, a.Hobby1, a.vipbrand1, "&_
         " a.Hobby2, a.Hobby3, a.ChildrenHave, a.ChildrenSex, a.Ayina, a.ToStoreTime1, a.ToStoreTime2, a.Body, a.Fabric, a.WeiXin, "&_
         " case when  a.FollowWeiXin = 1 then '��' else '��' end as FollowWeiXin, a.viplove, "&_
         " a.InforChannel, a.ShoppingType, a.FavouritesBook, a.FavouritesMoive, a.FavouritesColour, a.HopeGift, a.FavouritesActivties "&_
                      "    ,a.FavouritesColour1,a.Fabric1 ,case when a.islunar=1 then '��' else '��' end as islunar ,a.family ,a.remarkFamily ,a.loveFruit ,a.remarkFruit ,a.role ,a.MemorialDay1  "&_
         "   ,a.MemorialDay2 ,a.remarkMemorial,a.firstDisc ,a.profession ,a.Position ,a.Constellation ,a.MarkActivitie1 ,a.MarkActivitie2 "&_
         "    ,a.ShoppingHabits ,a.Vehicle ,a.RemarkVehicle,a.Taboo ,case when a.isReceipt=1 then '��' else '��' end as isReceipt    ,a.ReceiptName ,a.Scarf "&_
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
ҳ����<span style="color:red;"><%=p%></span>/<span style="color:red;"><%=ds.PageCount%></span>
    ÿҳ������ <span style="color:red;"><%=ds.PageSize%></span>
      ������<span style="color:red;"><%=ds.RecordCount%></span>
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(1);"<%end if%>>��ҳ</a>] 
  [<a <%if p<=1 then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p-1%>);"<%end if%>>��һҳ</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=p+1%>);"<%end if%>>��һҳ</a>]
  [<a <%if p>=ds.PageCount then%>disabled="disabled"<%else%>href="javascript:jumpPage(<%=ds.PageCount%>);"<%end if%>>βҳ</a>] 
</div>

<table   width="400%" border="1" cellspacing="1" cellpadding="2" bordercolor="#ECD6D2" class="f12" bordercolorlight="#FFFFFF">
<%else%>
<table   width="400%" border="1" cellspacing="1" cellpadding="2" bordercolor="#FFF" class="f12" bordercolorlight="#FFFFFF">
<% end if %>
  <tr align="center">
    <td width="80">VIP����</td>
    <td width="100">�Ǽ�����</td>
    <td width="60">״̬</td>
    <td width="70">VIP״̬</td>
    <td width="150">��������</td>
	<td width="100">��������</td>
	<td width="120">�����������</td>
    <td width="60">����</td>
    <td width="100">��������</td>
    <td width="60">����</td>
    <td width="30">�Ա�</td>
    <td width="100">�̶��绰</td>
    <td width="85">�ƶ��绰</td>
    
    <td width="100">QQ</td>
    <td width="150">΢��</td>
    <td width="150">E-Mail</td>
    <td width="60">��ַʡ</td>
    <td width="60">��ַ��</td>
    <td width="80">��ַ��</td>
    <td width="300">�ֵ���ַ</td>
    <td width="100">һ�������ѽ��</td>
    <td width="100">һ��������Ƶ��</td>

    <td width="50">�ܻ���</td>
    <td width="60">�ϼ�����</td>
    <td width="80">�ܴ�ֵ</td>

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
    <td width="80">ϲ���ĵ�Ӱ����</td>
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

    <td width="60">����</td>
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
vipstate="����"
uc=ds("updatecheck")
tc=ds("tempcard")
	if uc=1 then
		vipstate=" <span style='color:green'>���������</span>"
	elseif uc=2 then
		vipstate=" <span style='color:blue' title='��VIP���������˻أ���״̬��Ӱ��VIP�������ѣ����뾡���޸ĸù˿�����'>�������˻�</span>"
	elseif uc=3 then
		vipstate=" <span style='color:red'>����������</span>"
	elseif tc=1 then
		vipstate=" <span style='color:red'>��ʱ��</span>"
	end if
	
	if session("cf_VipSet_syjm") then
		if datediff("d",date(),ds("jViplastdate"))<0 or datediff("d",date(),ds("jLimitday"))<0 then
		  vipstate=" <span style='color:gray'>��ʧЧ</span>"
		end if
	else
		if datediff("d",date(),ds("jViplastdate"))<0 or datediff("d",date(),ds("jEnddate"))<0 or isnull(ds("jEnddate"))  then
		  vipstate=" <span style='color:gray'>��ʧЧ</span>"
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
    <a href="javascript:vip('vip_show.asp?act=view&id=<%=ds("vipid")%>');">��ϸ</a>
    <%if uc=2 then %><a href="javascript:vip('../vip/vip_addcard.asp?act=edit&id=<%=ds("vipid")%>');">�޸�</a><%end if%>
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
