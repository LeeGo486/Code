<%
'option explicit
'on error resume next
'Response.Expires=-1000
session("formid")=2019

Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=零售单汇总报表.xls" 
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
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){}

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[3].outerText;
  }

  function gtDoEnter(t){}
  
	function style(id){
		showModalDialog('../clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	}
	
	function retail(id){
		showModalDialog('../f22_mx.asp?id='+id+'&pksname=retail&ext=','e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');	}
	
	
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
    <td align="center">零 售 单 综 合 汇 总 报 表</td>
  </tr>
</table>
<div style="padding:10px;width:100%;font-size:12px">
<form name="form1" method="get" action="">
<input type="hidden" name="act" id="act" value="true">
<input type="hidden" name="typ" id="typ" value="1">
<label>统计日期：</label>
  <input type="text" name="begdate" id="begdate" style="width:90px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq1%>">
  <input type="text" name="enddate" id="enddate" style="width:90px;" readonly="readonly" class="box" onFocus="setday(this);" value="<%=rq2%>">
<label>
  <input type="checkbox" name="hj" value="Y"> 显示单据小计
  <input name="button" type="submit" class="btn" id="button" value="查 询" onClick="document.all.form1.typ.value=1;document.all.form1.submit();">
  <input name="button2" type="button" class="btn" id="button2" value="选择款式" onClick="javascript:selectStyle()">
  <input name="button3" type="button" class="btn" id="button3" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
</label>
</form>
<% End If %>
<%on error resume next
Server.ScriptTimeout=999999
dim t,userid,depotid,s1,s2,s3,s4,s5,s6,s7,styleid,act,hj,tmptab,qrydaytj

act=trim(request("act"))
hj=request("hj")
tmptab="##sell"&session("dm").System_Depotid

if act="true" then
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)

'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if

styleid=" in (select styleid from sys_stylepower18ql where userid='"&userid&"' and selection=1 and access=1)"

s1=" select a.retailid,a.retail,a.depotid,a.vipcode,a.daystat,a.discount as zdiscount,a.s_name,a.x_name,"&_
	 " a.cr_name,a.chk_name,a.sure_name,a.comment,a.poscode,"&_
	 " case when isnull(a.dtype,0)=0 then '正常收银' else case when isnull(a.dtype,0)=1 then '生日礼物' else '积分换购' end end dtype,"&_
	 " CONVERT(char(10), a.sure_date, 126) as sure_date,"&_
	 " SUBSTRING(CONVERT(char(10), a.sure_date, 126), 1, 4) as sureyear,"&_
	 " SUBSTRING(CONVERT(char(10), a.sure_date, 126), 6, 2) as suremonth,"&_
	 " SUBSTRING(CONVERT(char(10), a.sure_date, 126), 9, 2) as sureday,"&_
	 " DATEPART(week,a.sure_date) as weekdate,"&_
	 " b.clothingid,b.styleid,b.colorid,b.sizeid,b.j_cost,b.j_price,b.x_price,b.discount,b.s_price,"&_
	 " case when isnull(b.larg,0)=1 then '赠送' else '零售' end as larg,"&_
	 " case when isnull(b.back,0)=1 then '退货' else '零售' end as back,"&_
	 " cast(a.discount as numeric(8,2)) as discount2,b.nums,b.comment as commentsub, "&_
	 " b.nums*b.j_cost as jcostsums,b.nums*b.j_price as jpricesums,b.nums*b.x_price as xpricesums,"&_
	 " b.nums*b.s_price as spricesums,convert(char(10),a.cr_date,126) as cr_date "&_
	 " into "&tmptab&" from d_retail a,d_retailsub b where a.retailid=b.retailid and a.sure>0 "&_
	 " and a.depotid ='"&depotid&"' and b.styleid "&styleid&_
	 " and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&qrydaytj
						
s5=" select a.dtype as 类型,a.sure_date as 销售日期,a.retailid as 销售单号,a.clothingid as 款号,"&_
	 " b.s_name as 款式名称,a.x_price as 现价,a.discount as 折扣,a.s_price as 结算价,"&_
	 " isnull(a.nums,0) as 销售数量,isnull(a.xpricesums,0) as 现价金额,"&_
	 " isnull(a.spricesums,0) as 结算价金额,"&_
	 " isnull(a.xpricesums,0) - isnull(a.spricesums,0) as 折扣金额"&_
	 " from "&tmptab&" a,j_style b where a.styleid=b.styleid "&_
	 " order by 销售单号,款号"

s7="drop table "&tmptab
on error resume next
cn.execute(s7)
cn.execute(s1)
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
			a1=a1+cdbl(ds("销售数量"))
			a2=a2+cdbl(ds("现价金额"))
			a3=a3+cdbl(ds("结算价金额"))
			
			e1=e1+cdbl(ds("销售数量"))
			e2=e2+cdbl(ds("现价金额"))
			e3=e3+cdbl(ds("结算价金额"))
			
			c1=c1+cdbl(ds("销售数量"))
			c2=c2+cdbl(ds("现价金额"))
			c3=c3+cdbl(ds("结算价金额"))
			
			e4=ds("销售单号")&ds("款号")
			c4=ds("销售单号")
			%>
			<tr onMouseOver="this.bgColor='#DCF7D2'" onMouseOut="this.bgColor='#FFFFFF'"> 
			<%for i = 0 to dsfc-1%>
			<td><%
			if ds(i).name="销售单号" and cint(typ)<>2 then
			 response.write "<a href=""javascript:retail('"&ds(i)&"');"">"&ds(i)&"</a>"
			elseif ds(i).name="款号" and cint(typ)<>2 then
			 response.write "<a href=""javascript:style('"&ds(i)&"');"">"&ds(i)&"</a>"
			elseif ds(i).name="款号" and cint(typ)=2 then
			 response.write "&nbsp;"&ds(i)
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
					e5 = ds("销售单号")&ds("款号")
					c5 = ds("销售单号")
				end if
				
	'分组汇总 - 销售单号
	         if hj="Y" then
				if c4<>c5 then
				%>
				<tr bgcolor="#ccccff"> 
					<td colspan="2">&nbsp;</td>
					<td><div align="center">小&nbsp;&nbsp;&nbsp;&nbsp;计</div></td>
					<td colspan="2">&nbsp;</td>
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
