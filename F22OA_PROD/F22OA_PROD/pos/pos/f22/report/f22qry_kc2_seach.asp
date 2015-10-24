<%
session("formid")=6102041
Dim act
act=request.QueryString("act")
if cint(act)=2 then  
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=库存.xls" 
 
end if

Server.ScriptTimeOut=9999
%>
<%
response.cookies("seachdepot")("z1")=request.QueryString("poscode")
response.cookies("seachdepot")("z2")=request.QueryString("styleact")
begdate=request("begdate")
if begdate="" then begdate=get_date(date) end if%>
<!--#include file="inc/function.asp" -->

<%if cint(act)<>2 then%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<script language="javascript" src="ShowProcessBar.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%> ";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	if (id!=' '&&id!=null)
	{
	  style(id);
	}
  }

  function gtDoEnter(t){}
function style(id){
  
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

</SCRIPT>
<script language="javascript">
function selectStyle(){
  showModalDialog('select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}
</script>
</head>
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
    <td><font size="2">当前位置：--&gt; 报表查询 --&gt; 库存查询（二维）</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>

<table width="100%" class="noprint">
  <tr><td>
<table width="100%" height="33" border="0" cellspacing="0">
        <form name="form1" method="get" action="f22qry_kc2_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td><font size="2">款式：<input name="styleid" type="text" id="styleid" class="box" size="15">
			  <label><input type="radio" name="styleact" value="a" <%if request.cookies("seachdepot")("z2")="a" or request.cookies("seachdepot")("z2")="" then response.write("checked") end if%>>正常（包含模糊查询）</label>
			  <label><input type="radio" name="styleact" value="b" <%if request.cookies("seachdepot")("z2")="b" then response.write("checked") end if%>>助记码</label>
			  <label><input type="radio" name="styleact" value="c" <%if request.cookies("seachdepot")("z2")="c" then response.write("checked") end if%>>选款</label>
			  <input type=button value=" 选 款 " onClick="javascript:selectStyle();">
			  </font> </td>
            <td><input type="submit" name="Subm" value=" 确 定 "
             class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
		  </tr>
		  <tr>
		    <td><input type="checkbox" name="seldate" value="Y"> 指定日期库存
			    <input type="text" name="begdate" id="begdate" size=10 readonly="readonly" class="box" onFocus="setday(this);" value="<%=begdate%>">
			&nbsp;&nbsp;
			<input type="checkbox" name="hj" value="Y"> 显示重复行、去除小计
			&nbsp;&nbsp;
			排 序：<select name="order" size=1><option value=0>按款式编号排序</option><option value=1>按款式名称排序</option></select></td>
			<td>
            <input type="hidden" name="act" value="1">
			<%if pexport then%>
                <input type="button" name="but" value="导出Excel"
                 onClick="document.all.form1.act.value=2;document.all.form1.submit();">
            <%end if%>     
            </td>
		  </tr>
        </form>
      </table>
</td></tr></table><hr size=1>
<%end if%>
<%on error resume next
if request("order")<>"" then%>
<%order=request("order")
  select case order
  case 0 orderby=" order by stk.styleid "
  case 1 orderby=" order by s_name"
  end select
styleid=request.QueryString("styleid")
styleact=request.querystring("styleact")
seldate=request("seldate")



select case styleact
case "a" styletj="stk.styleid like '%"&styleid&"%' and "
case "b" styletj="stk.styleid='"&getstyle(styleid)&"' and "
case "c" styletj="stk.styleid in (select styleid from sys_stylepower18ql where userid='"&session("dm").System_Userid&"' and selection=1 and access=1) and "
end select

if seldate="Y" then
  tmptab="##stock"&session("dm").System_Depotid

  sql1="create table "&tmptab&" (depotid varchar(8),clothingid varchar(32),styleid varchar(20),colorid varchar(6),sizeid varchar(6),k_num int)"
  if styleact="c" then
    sql2="insert into "&tmptab&" exec f22qry_kcdpt '"&begdate&"','"&session("dm").System_Userid&"','"&session("dm").System_Depotid&"',1"
  else
    sql2="insert into "&tmptab&" exec f22qry_kcdpt '"&begdate&"','"&session("dm").System_Userid&"','"&session("dm").System_Depotid&"',0"
  end if
  cn.execute sql1
  cn.execute sql2
  stocktab=tmptab
else
  stocktab="j_stock"
end if

i=1
sql="select case when (grouping(stk.styleid)= 1) THEN '总 计' ELSE stk.styleid END AS styleid,max(s_name) as s_name,max(isnull(a.x_price,0)) as x_price,case when (grouping(stk.colorid)= 1) THEN '小 计' ELSE stk.colorid END AS colorid,sum(isnull(stk.k_num,0)) as k_num,sum(isnull(a.x_price*stk.k_num,0)) as price, "
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
sql=left(sql,len(sql)-2)
sql=sql&" from "&stocktab&" stk,j_style a where "&styletj&" a.styleid=stk.styleid and isnull(stk.k_num,0)<>0 and stk.depotid='"&session("dm").System_Depotid&"' group by stk.styleid,stk.colorid with rollup"
rs.close

rs.open sql,cn,1,1
%>
<div id="gt1" style="width:100%;height:80%;">
<table border="0">
<thead>
    <tr>
        <td style="border:#ddd 1px solid"  width="70">款式编号</td>
        <td style="border:#ddd 1px solid" width="100">款式名称</td>
        <%if psprice then%><td style="border:#ddd 1px solid" width="50">单价</td><%end if%>
        <td style="border:#ddd 1px solid" width="60">颜色</td> 
        <td style="border:#ddd 1px solid" width="50">数量</td>
        <%if psprice then%><td style="border:#ddd 1px solid" width="60">金额</td><%end if%>
				<%l=0%>
        <% For j=6 to rs.fields.count-1 %>
        <td style="border:#ddd 1px solid" swidth="30"><%=size4(l)%></td>
				<%l=l+1%>
        <% Next %>
        
    </tr>  
</thead>
 <tbody>
    <%
	hj=request("hj")
	while not rs.eof
	if hj="Y"  then
	  if (rs("colorid")<>"小 计" or rs("styleid")="总 计") then
	 %>
    <tr><td style="border:#ddd 1px solid"><%=rs("styleid")%></td>
	<td style="border:#ddd 1px solid"><%if rs("styleid")<>"总 计" then response.write("&nbsp;"&rs("s_name")&"") else response.write("&nbsp;") end if%></td>
	<%if psprice then%>
	<td style="border:#ddd 1px solid"><%if rs("styleid")<>"总 计" then response.Write("￥"&rs("x_price")) else response.write("&nbsp;") end if%></td>
  <%end if%>
    <td style="border:#ddd 1px solid"><%if rs("styleid")<>"总 计" then
						 set rs3=server.CreateObject("adodb.recordset")
						 rs3.open "select c_name from j_color where colorid='"&rs("colorid")&"'",cn
						 response.write(rs("colorid")&"("&rs3("c_name")&")")
						 rs3.close
						 set rs3=nothing
						 else response.write("&nbsp;") end if%></td>
    <td style="border:#ddd 1px solid"><%=rs("k_num")%></td>
	<%if psprice then%>
  <td style="border:#ddd 1px solid"><%=rs("price")%></td>
  <%end if%>
	<%for j=6 to rs.fields.count-1%>
	<td style="border:#ddd 1px solid" ><%if rs("A"&j-5)<>0 then response.Write(rs("A"&j-5)) else response.Write("&nbsp;") end if%></td>
	<%next%>
  </tr>
  <%end if
  else%>
  <tr> 
    <td style="border:#ddd 1px solid"><%if styleid1<>rs("styleid") then
						response.Write(rs("styleid"))
						styleid1=rs("styleid")
					 else response.Write("&nbsp;") end if%></td>
                             
	<td style="border:#ddd 1px solid"><%if styleid1<>"总 计" then
						 if s_name1<>rs("s_name") then
							response.Write(rs("s_name"))
							s_name1=rs("s_name")
						 else response.Write("&nbsp;") end if
						 else response.Write("&nbsp;") end if%></td>
	<%if psprice then%>
	<td style="border:#ddd 1px solid"><%if styleid1<>"总 计" then
						 if price<>round(rs("x_price"),2) then
							response.Write rs("x_price")
							price=round(rs("x_price"),2)
						 else response.Write("&nbsp;") end if
						 else response.Write("&nbsp;") end if%></td>
	<%end if%>
    <td style="border:#ddd 1px solid"><%if rs("colorid")<>"小 计" then
						 set rs3=server.CreateObject("adodb.recordset")
						 rs3.open "select c_name from j_color where colorid='"&rs("colorid")&"'",cn
						 response.write(rs("colorid")&"("&rs3("c_name")&")")
						 rs3.close
						 set rs3=nothing
						 else response.Write(rs("colorid")) end if%></td>
    <td style="border:#ddd 1px solid"><%=rs("k_num")%></td>
	<%if psprice then%>  
	<td style="border:#ddd 1px solid"><%=rs("price")%></td>
  <%end if%>
	<%for j=6 to rs.fields.count-1%>
	<td style="border:#ddd 1px solid"><%if rs("A"&j-5)<>0 then response.Write(rs("A"&j-5)) else response.Write("&nbsp;") end if%></td>
	<%next%>
  </tr>
  <%end if
  rs.movenext
  wend
  rs.close
  set rs=nothing
  %>
 </tbody>
</table>
</div>
	<%if cint(act)<>2 then%>
		<script language="javascript">
            try{
             gt = new GtTable("gt1");
             gtTables.addTable(gt);
             gt.loadTable();
            }catch(ex){}
        </script>
	<%end if%>
<%else%>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF"> 
<tr>
  <td height="60"><div align="center">没 有 数 据</div></td>
</tr>
</table>
<%end if
if seldate="Y" then
   cn.execute "drop table "&tmptab
end if
cn.close
set cn=nothing
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
<%if cint(act)<>2 then%>
</body>
</html>
<%end if%>
