<%Dim act
act=request.QueryString("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

rq1=trim(request.QueryString("rq1"))
if rq1="" then
   rq1=get_date(date)
end if
rq2=trim(request.QueryString("rq2"))
if rq2="" then
   rq2=get_date(date)
end if%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<SCRIPT language="JavaScript" src="inc/setday.js"></SCRIPT>
<script language="javascript">window.name="aaa"</script>
<style media="print">.noprint { display: none }</style>
</head>
<%response.cookies("seachdepot")("z1")=request.QueryString("poscode")
response.cookies("seachdepot")("z2")=request.QueryString("styleact")%>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>数据传送中，请稍候……</td></tr>
</table></td></tr></table></div>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">当前位置：--&gt; 数据查询 --&gt; 其它店铺销售查询（二维）</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>

<table width="100%" class="noprint">
  <tr><td>
<table width="100%" height="33" border="0" cellspacing="0">
        <form name="form1" method="get" target="aaa" action="f22qry_otherretail2_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td><font size="2">
		  <input type="text" value="日期范围:" size="10" style="border-bottom:0px;border-top:0px;border-left:0px;border-right:0px">
          <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=rq1%>" onFocus="setday(this);">
          <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=rq2%>" onFocus="setday(this);">
			款式：<input name="styleid" type="text" id="styleid" class="box" size="15">
			  <label><input type="radio" name="styleact" value="a" <%if request.cookies("seachdepot")("z2")="a" or request.cookies("seachdepot")("z2")="" then response.write("checked") end if%>>正常（包含模糊查询）</label>
			  <label><input type="radio" name="styleact" value="b" <%if request.cookies("seachdepot")("z2")="b" then response.write("checked") end if%>>助记码</label>
			  </font> </td>
           <td><font size="2">&nbsp; </font> <input type="submit" name="Subm" value=" 确 定 " class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
           <td><input type="hidden" name="act" value="1">
			<!--<input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();">--></td>
		 </tr>
        </form>
      </table>
</td></tr></table><hr size=1>
<%
styleid=request.QueryString("styleid")
styleact=request.querystring("styleact")
select case styleact
case "a" styletj="b.styleid like '%"&styleid&"%' and "
case "b" styletj="b.styleid='"&getstyle(styleid)&"' and "
end select
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if
userid=trim(session("dm").system_userid)

i=1
sql="select a.depotid,max(c.d_name) as d_name,"&_
    "b.styleid,max(e.s_name) as s_name,max(isnull(b.s_price,0)) as s_price,b.colorid,sum(isnull(b.nums,0)) as nums,sum(isnull(b.s_price*b.nums,0)) as price, "
set rs=server.CreateObject("adodb.recordset")
rs.open "select sizeid,s_name from j_size where sizeid in (select b.sizeid from d_retail a,d_retailsub b,webp_depot c where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
        " and a.depotid=c.depotid and c.unitid='"&session("dm").system_unitid&"' "&qrydaytj&_
		
	    " and c.userid='"&userid&"' and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&_
	    " group by b.sizeid) order by s_order",cn
if not rs.eof then
while not rs.eof
    sql=sql&"isnull(sum(case when ( ( b.sizeid= '"&rs("sizeid")&"')) then b.nums end),0) as A"&i&", "
	sizestr=sizestr&rs("sizeid")&","&"A"&i&";"
	i=i+1
rs.movenext
wend
sizestr=left(sizestr,len(sizestr)-1)
size1=split(sizestr,";")
for k=0 to ubound(size1)
    size2=split(size1(k),",")
	size3=size3&size2(0)&","
next
size3=left(size3,len(size3)-1)
size4=split(size3,",")
if session("nozckc") then
   tj=" and d.depotid not in (select depotid from j_depot where m_type in (0,1,80,90)) "
else
   tj=""
end if
sql=left(sql,len(sql)-2)
sql=sql&" from d_retail a,d_retailsub b,j_depot c,webp_depot d,j_style e where "&styletj&" e.styleid=b.styleid and isnull(b.nums,0)<>0 "&_
    " and a.depotid=d.depotid and d.unitid='"&session("dm").System_Unitid&"' and d.userid='"&userid&"' "&_
	" and a.depotid=c.depotid and a.retailid=b.retailid and isnull(a.sure,0)>0 "&qrydaytj&_
	
	" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&tj&" group by a.depotid,b.styleid,b.colorid "&_
	" union all "&sql&_
	" from d_retail a,d_retailsub b,j_depot c,j_style e where "&styletj&" e.styleid=b.styleid and isnull(b.nums,0)<>0 "&_
    " and a.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_retail=1) "&_
	" and a.depotid=c.depotid and a.retailid=b.retailid and isnull(a.sure,0)>0 "&qrydaytj&_
	
	" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid,b.styleid,b.colorid "&_
	" order by a.depotid,b.styleid,b.colorid"
rs.close
set rs=nothing%>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">店铺编号</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">店铺名称</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td>
	<td><div align="center"><font color="#FFFF00" size="2">单 价</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">颜 色</font></div></td> 
    <td><div align="center"><font color="#FFFF00" size="2">数 量</font></div></td>
	<td><div align="center"><font color="#FFFF00" size="2">金 额</font></div></td>
	<%set rs=server.CreateObject("adodb.recordset")
	 rs.open sql,cn,1,1
	 l=0
	 for j=8 to rs.fields.count-1%>
	<td><div align="center"><font color="#FFFF00" size="2"><%=size4(l)%></font></div></td>
	<%l=l+1
	next
	while not rs.eof%>
  </tr>  
    <tr>
	<td height="20"><div align="center"><font size="2"><%if depotid<>rs("depotid") then
	                                                        response.Write(rs("depotid"))
															depotid=rs("depotid")
														 else response.Write("&nbsp;") end if%></font></div></td>
	<td height="20"><div align="center"><font size="2"><%if d_name<>rs("d_name") then
	                                                        response.Write(rs("d_name"))
															d_name=rs("d_name")
														 else response.Write("&nbsp;") end if%></font></div></td> 
    <td height="20"><div align="center"><font size="2"><%if styleid1<>rs("styleid") then
	                                                        response.Write(rs("styleid"))
															styleid1=rs("styleid")
														 else response.Write("&nbsp;") end if%></font></div></td>
	<td height="20"><div align="center"><font size="2"><%if s_name1<>rs("s_name") then
	                                                        response.Write(rs("s_name"))
															s_name1=rs("s_name")
														 else response.Write("&nbsp;") end if%></font></div></td>
	<td height="20"><div align="center"><font size="2"><%if price<>round(rs("s_price"),2) then
	                                                        response.Write("￥"&rs("s_price"))
															price=round(rs("s_price"),2)
														 else response.Write("&nbsp;") end if%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%set rs3=server.CreateObject("adodb.recordset")
	                                                     rs3.open "select c_name from j_color where colorid='"&rs("colorid")&"'",cn
														 response.write(rs("colorid")&"("&rs3("c_name")&")")
														 rs3.close
														 set rs3=nothing%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000"><%=rs("nums")%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000">￥<%=rs("price")%></font></div></td>
	<%for j=8 to rs.fields.count-1%>
	<td><div align="center"><font size="2"><%if rs("A"&j-7)<>0 then response.Write(rs("A"&j-7)) else response.Write("&nbsp;") end if%></font></div></td>
	<%next%>
  </tr>
  <%rs.movenext
  wend
  rs.close
  set rs=nothing%>
</table>
<%else%>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
<tr>
  <td height="60"><div align="center">没 有 数 据</div></td>
</tr>
</table>
<%end if
cn.close
set cn=nothing

'取助记码
function getstyle(styleid)
if styleid<>"" then
  set rs10=server.createobject("adodb.recordset")
  rs10.open "select styleid from j_style where styleid='"&styleid&"' or helpid='"&styleid&"'",cn
  if not rs10.eof then getstyle=rs10(0) else getstyle="null" end if
  rs10.close
  set rs10=nothing
else
  getstyle="null"
end if
end function%>
</body>
</html>