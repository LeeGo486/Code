<%
'option explicit
'on error resume next
'Response.Expires=-1000

Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%
dim rq1,rq2
rq1=trim(request("begdate"))
rq2=trim(request("enddate"))

if rq1="" then rq1 = get_date(date()-1)
if rq2="" then rq2 = get_date(date())
get_depotid=request("get_depotid")
getdptname=request("edptname")

%>

<% if cint(typ)<>2 then
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript">
	function style(id){
		showModalDialog('../clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	function selectMD(str,opt){
		var m=showModalDialog('../SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
		var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
		if(opt==0){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//仓库ID
		edptname=arr[1];//仓库名
		document.form1.set_depotid.value=get_depotid;
		document.form1.sdptname.value=edptname;
		}catch(ex){}
		}else
		 if(opt==1){
		try{
		arr=m.split(",");
		get_depotid=arr[0];//仓库ID
		edptname=arr[1];//仓库名
		document.form1.get_depotid.value=get_depotid;
		document.form1.edptname.value=edptname;
		}catch(ex){}
		}
	}
	function selectStyle(){
		showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
</SCRIPT>
<style>
body{margin:0;}
a{ text-decoration:none; color:black}
a:hover{ text-decoration:none; color:red}
form{padding-bottom:10px;}
</style>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">综 合 收 货、调 货 汇 总 报 表</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>日期：</label>
  <input type="text" name="begdate" id="begdate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:70px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq2%>">
<label>
  <input type="checkbox" name="hj" value="Y"> 显示小计
</label>
  <input name="button2" type="button" class="btn" id="button2" value="选择款式" onClick="javascript:selectStyle()" />
  <input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="10" maxlength="10" readonly />
  <input name="button4" type="button" class="btn" id="button4" value="选择店铺" onClick="javascript:selectMD('move',1);">
  <input name="edptname" type="text" id="edptname" style="border:none;" value="<%=getdptname%>" size="10" readonly />  
  <input name="button" type="submit" class="btn" id="button" value="查 询"
   onClick="this.form.typ.value=1;this.disabled=true;this.value='请稍等...';this.form.submit()" />
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();" />
</form>
<% End If %>
<%on error resume next
Server.ScriptTimeout=999999
dim t,userid,depotid,s1,s2,s3,s4,s5,s6,s7,styleid,act,hj,tmptab

act=trim(request("act"))
hj=request("hj")

if act="true" then
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)

styleid=" in (select styleid from sys_stylepower18ql where userid='"&userid&"' and selection=1 and access=1)"

s =" and isnull(a.set_sure,0)>0 and isnull(a.get_sure,0)>0 and convert(char(10),a.getsure_date,126) between '"&rq1&"' and '"&rq2&"'"
ss =" and isnull(a.sure,0)>0 and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"'"
if get_depotid<>"" then
	sss = " and a.set_depotid='"&get_depotid&"'"
end if

tmptab="##sell"&session("dm").System_Depotid

s1 =" SELECT  '发货收货' as ctype,a.sellid, a.sell, a.quotaid, a.set_depotid,a.get_depotid,"&_
		" a.getcr_name as cr_name, a.getchk_name as chk_name, a.getsure_name as sure_name,"&_
		" a.set_comment as comment,CONVERT(char(10), a.setsure_date, 126) as setsure_date,"&_
		" CONVERT(char(10), a.getsure_date, 126) AS sure_date, "&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 1, 4) "&_
		" AS sureyear, SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 6, 2) AS suremonth,"&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 9, 2) AS sureday, "&_
		" b.clothingid, b.styleid, b.sizeid, b.colorid, b.j_cost, b.j_price,"&_
		" b.x_price, b.discount,b.s_price,b.set_nums as nums, "&_
		" b.j_cost * b.set_nums AS costsums,"&_
		" b.j_price * b.set_nums AS jpricesums,"&_
		" b.x_price * b.set_nums AS pricesums,"&_
		" b.s_price * b.set_nums AS spricesums, "&_
		" c.d_name as setdptname,d.d_name as getdptname "&_
		" ,b.set_nums*t.j_cost as stcostsums,t.j_cost as stylecost,t.j_price as styjprice,b.set_nums*t.j_price as stjpsums,a.selltype "&_
		" into "&tmptab&" FROM d_sell a,d_sellsub b,j_depot c,j_depot d,j_style t "&_
		" where a.sellid =b.sellid and a.get_depotid ='"&depotid &"'"&_
		" and b.styleid=t.styleid "&_
		" and b.styleid "& styleid &_
		" and a.set_depotid*=c.depotid "&_
		" and a.get_depotid*=d.depotid "&sss &s

s2 =" insert into "&tmptab&_
		" SELECT '调拨收货',a.moveid,a.move,a.indentid,a.set_depotid,a.get_depotid,"&_
		" a.getcr_name as cr_name, a.getchk_name as chk_name, a.getsure_name as sure_name,"&_
		" a.set_comment as comment,CONVERT(char(10), a.setsure_date, 126) as setsure_date,"&_
		" CONVERT(char(10), a.getsure_date, 126) AS sure_date, "&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 1, 4) "&_
		" AS sureyear, SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 6, 2) AS suremonth,"&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 9, 2) AS sureday, "&_
		" b.clothingid, b.styleid, b.sizeid, b.colorid, b.j_cost, b.j_price,"&_
		" b.x_price, b.discount,b.s_price,b.set_nums as nums, "&_
		" b.j_cost * b.set_nums AS costsums,"&_
		" b.j_price * b.set_nums AS jpricesums,"&_
		" b.x_price * b.set_nums AS pricesums,"&_
		" b.s_price * b.set_nums AS spricesums,"&_
		" c.d_name,d.d_name "&_
		" ,b.set_nums*t.j_cost as stcostsums,t.j_cost as stylecost,t.j_price as styjprice,b.set_nums*t.j_price as stjpsums,a.selltype "&_
		" FROM d_move a,d_movesub b,j_depot c ,j_depot d,j_style t "&_
		" where a.moveid =b.moveid and a.set_depotid*=c.depotid and a.get_depotid*=d.depotid"&_
		" and b.styleid=t.styleid "&_
		" and a.get_depotid ='"&depotid &"'"&_
		" and b.styleid "& styleid &sss &s

s3 =" insert into "&tmptab&_
		" SELECT   '跨区收货',a.msellid, a.msell, a.noticeid, a.set_depotid,a.get_depotid,"&_
		" a.getcr_name as cr_name, a.getchk_name as chk_name, a.getsure_name as sure_name,"&_
		" a.set_comment as comment,CONVERT(char(10), a.setsure_date, 126) as setsure_date,"&_
		" CONVERT(char(10), a.getsure_date, 126) AS sure_date, "&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 1, 4) "&_
		" AS sureyear, SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 6, 2) AS suremonth,"&_
		" SUBSTRING(CONVERT(char(10), a.getsure_date, 126), 9, 2) AS sureday, "&_
		" b.clothingid, b.styleid, b.sizeid, b.colorid, b.j_cost, b.j_price,"&_
		" b.x_price, b.discount,b.s_price,b.set_nums as nums, "&_
		" b.j_cost * b.set_nums AS costsums,"&_
		" b.j_price * b.set_nums AS jpricesums,"&_
		" b.x_price * b.set_nums AS pricesums,"&_
		" b.s_price * b.set_nums AS spricesums, "&_
		" c.d_name,d.d_name, "&_
		" b.set_nums*t.j_cost as stcostsums,t.j_cost as stylecost,t.j_price as styjprice,b.set_nums*t.j_price as stjpsums,a.selltype "&_
		" FROM d_msell a,d_msellsub b,j_depot c,j_depot d,j_style t "&_
		" where a.msellid =b.msellid and a.get_depotid ='"&depotid &"'"&_
		" and b.styleid=t.styleid "&_
		" and b.styleid "& styleid &_
		" and a.set_depotid*=c.depotid "&_
		" and a.get_depotid*=d.depotid "&sss &s

s5=" select a.ctype as 类型,a.setdptname as 发货地名称,a.sell as 发货单号,a.setsure_date as 发货日期,"&_
	 " a.sure_date as 收货日期,a.clothingid as 款号,b.s_name as 款式名称,"&_
	 " isnull(a.nums,0) as 发货数量,isnull(a.jpricesums,0) as 原价金额,isnull(a.stjpsums,0) as 款式原价金额"&_
	 " from "&tmptab&" a,j_style b where a.styleid=b.styleid "&_
	 " order by 发货单号,款号"
	 
	 
s7="drop table "&tmptab
on error resume next
cn.execute(s7)

cn.execute(s1)
cn.execute(s2)
cn.execute(s3)

'//店铺不用查询d_outindent
	%>
<table width="100%" border="1" cellpadding="2" cellspacing="0"  bordercolor="#003333" bordercolordark="#FFFFFF" style="font-size:12px ">
	<%
set ds=server.createobject("adodb.recordset")
ds.open s5,cn,1,1
dsfc = ds.fields.count
%>
  <tr bgcolor="#336699">
  	<%for i = 0 to dsfc-1%>
    <td><div align="center"><font color="#FFFF00" size="2"><%=ds(i).name%></font></div></td>
    <%Next%>
  </tr>
<%
if ds.eof and ds.bof then
		%>
    <tr>
      <td colspan="<%=dsfc%>"><div align="center"><font size="2">没 有 销 售 数 据</font></div></td>
    </tr>
		<%
else
	a1=0
	a2=0
	a3=0
	c1=0
	c2=0
	c3=0
	e1=0
	e2=0
	e3=0

	do while not ds.eof
			a1=a1+cdbl(ds("发货数量"))
			a2=a2+cdbl(ds("原价金额"))
			a3=a3+cdbl(ds("款式原价金额"))
			
			e1=e1+cdbl(ds("发货数量"))
			e2=e2+cdbl(ds("原价金额"))
			e3=e3+cdbl(ds("款式原价金额"))
			
			c1=c1+cdbl(ds("发货数量"))
			c2=c2+cdbl(ds("原价金额"))
			c3=c3+cdbl(ds("款式原价金额"))
			
			e4=ds("发货单号")&ds("款号")
			c4=ds("发货单号")
			%>
			<tr onMouseOver="this.bgColor='#DCF7D2'" onMouseOut="this.bgColor='#FFFFFF'"> 
			<%for i = 0 to dsfc-1%>
			<td><%
			if ds(i).name="款号" and cint(typ)<>2 then
			 response.write "<a href=""javascript:style('"&ds(i)&"');"">"&ds(i)&"</a>"
			else
			 response.write ds(i)
			end if
			%></td>
			<%Next%>
			</tr>
			<%
			i=i+1
			ds.movenext
				if ds.eof then
					e5 = ""
					c5 = ""
				else
					e5 = ds("发货单号")&ds("款号")
					c5 = ds("发货单号")
				end if
				
	'分组汇总 - 发货单号
	       if hj="Y" then
				if c4<>c5 then
				%>
				<tr bgcolor="#ccccff"> 
					<td colspan="<%=dsfc-8%>">&nbsp;</td>
					<td><div align="center">小&nbsp;&nbsp;&nbsp;&nbsp;计</div></td>
					<td colspan="4">&nbsp;</td>
					<td><%=c1%></td>
					<td><%=c2%></td>
					<td><%=c3%></td>
				</tr>
				<%
				c1=0
				c2=0
				c3=0
				end if
			end if
				
			loop
end if
ds.close
set ds=nothing
%>
  <tr bgcolor="#aaaaff"> 
    <td colspan="<%=dsfc-3%>"><div align="center">合&nbsp;&nbsp;&nbsp;&nbsp; 计</div></td>
    <td><%=a1%></td>
    <td><%=a2%></td>
    <td><%=a3%></td>
  </tr>
</table>
<%
cn.close
set cn=nothing
end if%>

<% if cint(typ)<>2 then
 %>
</div>
</body>
</html>
<% End If %>
