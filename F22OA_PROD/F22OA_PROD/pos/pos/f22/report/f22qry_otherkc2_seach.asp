<%
session("formid")=6102043
Server.ScriptTimeout=999999
Dim act
act=request.QueryString("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<script language="javascript">
window.name="aaa"
</script>
<style media="print">.noprint { display: none }</style>
<base target="_self">
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
    <td><font size="2">当前位置：--&gt; 数据查询 --&gt; 其它店铺库存查询（二维）</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>

<table width="100%" class="noprint">
  <tr><td>
<table width="100%" height="33" border="0" cellspacing="0">
        <form name="form1" method="get" target="aaa" action="f22qry_otherkc2_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td width="40%"><font size="2">款 式：<input name="styleid" type="text" id="styleid" class="box" size="15"><br>
			  <label><input type="radio" name="styleact" value="a" <%if request.cookies("seachdepot")("z2")="a" or request.cookies("seachdepot")("z2")="" then response.write("checked") end if%>>正常（包含模糊查询）</label>
			  <label><input type="radio" name="styleact" value="b" <%if request.cookies("seachdepot")("z2")="b" then response.write("checked") end if%>>助记码</label>
			  </font> </td>
			<td width="20%"><font size="2">排 序：<select name="order" size=1><option value=0>按款式编号排序</option><option value=1>按款式名称排序</option></select></font></td>
            <td width="10%"><font size="2">&nbsp; </font> <input type="submit" name="Subm" value=" 确 定 " class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
            <td><input type="hidden" name="act" value="1">
			<!--<input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();">--></td>
		  </tr>
        </form>
      </table>
</td></tr></table><hr size=1>
<%if request("order")<>"" then%>
<%order=request("order")
  select case order
  case 0 orderby=" order by stk.styleid "
  case 1 orderby=" order by s_name"
  end select
styleid=request.QueryString("styleid")
styleact=request.querystring("styleact")
userid=trim(session("dm").system_userid)
select case styleact
case "a" styletj="stk.styleid like '%"&styleid&"%' and "
case "b" styletj="stk.styleid='"&getstyle(styleid)&"' and "
end select

if styleid<>"" then
i=1
sql="select stk.depotid,max(c.d_name) as d_name,"&_
    "stk.styleid,max(s_name) as s_name,max(isnull(a.x_price,0)) as x_price,stk.colorid,sum(isnull(stk.k_num,0)) as k_num,sum(isnull(a.x_price*stk.k_num,0)) as price, "
set rs=server.CreateObject("adodb.recordset")
rs.open "select sizeid,s_name from j_size where sizeid in (select sizeid from j_stock where depotid='"&session("dm").System_Depotid&"' and isnull(k_num,0)<>0) order by s_order",cn
if not rs.eof then
while not rs.eof
    sql=sql&"isnull(sum(case when ( ( stk.sizeid= '"&rs("sizeid")&"')) then stk.k_num end),0) as A"&i&", "
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

tj=""
if session("onlybdkc") then
   tj=tj&" and c.depotid = '"&session("dm").System_Depotid&"' "
else
	if session("nozckc") then
	   tj=tj&" and c.depotid not in (select depotid from j_depot where m_type in (0,1,80,90)) "
	end if
end if

sql=left(sql,len(sql)-2)
sql=sql&" from j_stock stk,j_style a,webp_depot b,j_depot c where "&styletj&" a.styleid=stk.styleid and isnull(stk.k_num,0)<>0 "&_
    " and stk.depotid=b.depotid and b.unitid='"&session("dm").System_Unitid&"' and b.userid='"&session("dm").System_userid&"' "&_
	" and c.depotid "&session("QryDepotTj")&_
	" and stk.depotid=c.depotid "&tj&" group by stk.depotid,stk.styleid,stk.colorid "&_
	" union all "&sql&_
	" from j_stock stk,j_style a,j_depot c where "&styletj&" a.styleid=stk.styleid and isnull(stk.k_num,0)<>0 "&_
	" and c.depotid "&session("QryDepotTj")&_
    " and stk.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_Unitid&"' and b.p_kc=1) "&_
    " and stk.depotid=c.depotid "&tj&" group by stk.depotid,stk.styleid,stk.colorid order by stk.depotid,stk.styleid,stk.colorid"
'response.Write(sql)
'response.end
rs.close
%>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">店铺编号</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">店铺名称</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">款式编号</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">款式名称</font></div></td>
    <%if psprice then%>
    <td><div align="center"><font color="#FFFF00" size="2">单 价</font></div></td>
    <%end if%>
    <td><div align="center"><font color="#FFFF00" size="2">颜 色</font></div></td> 
    <td><div align="center"><font color="#FFFF00" size="2">数 量</font></div></td>
    <%if psprice then%>
    <td><div align="center"><font color="#FFFF00" size="2">金 额</font></div></td>
    <%end if%>
	<%
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
    <%if psprice then%>
    <td height="20"><div align="center"><font size="2"><%if price<>round(rs("x_price"),2) then
	                                                        response.Write("￥"&rs("x_price"))
															price=round(rs("x_price"),2)
														 else response.Write("&nbsp;") end if%></font></div></td>
		<%end if%>
    <td height="20"><div align="center"><font size="2"><%set rs3=server.CreateObject("adodb.recordset")
	                                                     rs3.open "select c_name from j_color where colorid='"&rs("colorid")&"'",cn
														 response.write(rs("colorid")&"("&rs3("c_name")&")")
														 rs3.close
														 set rs3=nothing%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000"><%=rs("k_num")%></font></div></td>
    <%if psprice then%>
    <td><div align="center"><font size="2" color="#FF0000">￥<%=rs("price")%></font></div></td>
		<%end if%>
    
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
end if
end if

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