<%Dim oldformid,newformid,retailid,rs
Response.Expires=-1000
oldformid=session("formid")
newformid=request("formid")
if newformid<>"" then
   session("formid")=newformid
end if%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=request.QueryString("retailid")%>销售单的明细</title>
<script language="javascript">
	function printsetup(){
	// 打印页面设置
	wb.execwb(8,1);
	}
	function printpreview(){
	// 打印页面预览
    wb.execwb(7,1);
	}
	function printit()
	{
	if (confirm('确定打印吗？')) {
	wb.execwb(6,6)
	}
	}
	</script>
</head>
<style media="print">
.noprint { display: none }
</style>
<body>
<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 id=wb name=wb width=0></OBJECT>
<%retailid=request.QueryString("id")
  s1="select a.retailid,a.depotid,b.d_name,a.vipcode,a.daystat,a.discount,a.s_name,a.x_name,a.comment,"&_
     "case when isnull(dtype,0)=0 then '正常收银' else case when isnull(dtype,0)=1 then '生日礼物' else '积分换购' end end as dtype,"&_
          "(select sum(nums) from d_retailsub where d_retailsub.retailid=a.retailid) as nums,"&_
		  "(select sum(FSSums) from d_retailsub where d_retailsub.retailid=a.retailid) as price "&_
		  "from d_retail a,j_depot b where a.retailid='"&retailid&"' and a.depotid=b.depotid"
  s2="select a.clothingid,a.styleid,b.s_name,a.colorid,a.sizeid,a.x_price,a.discount,a.s_price,a.nums,a.FSSums as sums,"&_
           "isnull(a.larg,0) as larg,isnull(a.back,0) as back from d_retailsub a,j_style b "&_
		   "where a.retailid='"&retailid&"' and a.styleid=b.styleid"
  set rs=server.CreateObject("adodb.recordset")
  rs.open s1,cn,1,1
	if rs.eof and rs.bof then
		response.Write("该单据缺少明细")
		response.End()
	end if
	%>
<center>
  <font size="5">销 售 单 明 细</font> 
</center>
<br>
<table width="100%" height="108" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="12%" height="22"><div align="right"><font size="2">销售单号：</font></div></td>
    <td width="32%"><font size="2"><%=retailid%></font></td>
    <td width="16%"><div align="right"><font size="2">销售数量：</font></div></td>
    <td width="40%"><font size="2"><%=rs("nums")%></font></td>
  </tr>
  <tr> 
    <td height="21"><div align="right"><font size="2">销售店柜：</font></div></td>
    <td><font size="2"><%=rs("d_name")%></font></td>
    <td><div align="right"><font size="2">销售金额：</font></div></td>
    <td><font size="2"><%=rs("price")%></font></td>
  </tr>
  <tr> 
    <td height="21"><div align="right"><font size="2">单据类型：</font></div></td>
    <td><font size="2"><%=rs("dtype")%></font></td>
    <td><div align="right"><font size="2">VIP卡：</font></div></td>
    <td><font size="2"><%=rs("vipcode")%></font></td>
  </tr>
  <tr> 
    <td height="22"><div align="right"><font size="2">收银员：</font></div></td>
    <td><font size="2"><%=rs("s_name")%></font></td>
    <td><div align="right"><font size="2">班组：</font></div></td>
    <td><font size="2"><%=rs("x_name")%></font></td>
  </tr>
  <tr> 
    <td height="22"><div align="right"><font size="2">营业员：</font></div></td>
    <td colspan=3><font size="2">
	<%set rs5=server.createobject("adodb.recordset")
	  rs5.open "select names from jk_retailhistory where retailid='"&retailid&"'",cn
	  while not rs5.eof
	    response.write(rs5("names")&" ")
		rs5.movenext
	  wend
	  rs5.close
	  set rs5=nothing%>
	</font></td>
  </tr> 
  <tr>
    <td><div align="right"><font size="2">备注：</font></div></td>
	<td><font size="2"><%=rs("comment")%></font></td>
  </tr> 
</table>
<br>
<%rs.close

set rs3=server.CreateObject("adodb.recordset")
rs3.open "select retype,isnull(sums,0) as sums,crtype,(select ISNULL(sum(sellsums),0) "&_
		" from vip_ticket a inner join pos_retailticket b on a.ticketid=b.ticketid "&_
		" where b.retailid=pos_skfs.retailid "&_
		" and b.ttype=case pos_skfs.retype when '现金券' then 1 when '抵值券' then 0 else -1 end) as sxje "&_
		" from pos_skfs where retailid='"&retailid&"'",cn,1,1
if not rs3.eof then%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#009933">
  <tr> 
    <td width="12%" rowspan="2"><div align="center"><font size="2">收款方式</font></div></td>
    <%while not rs3.eof%>
	<td><div align="center"><font size="2"><%=rs3("retype")%></font></div></td>
	<%rs3.movenext
	wend%>
  </tr>
  <tr>
   <%rs3.movefirst
    while not rs3.eof%> 
    <td><div align="center"><font size="2" color="#FF0000">
	<%
	
	if not isnull(rs3("sums")) then
			response.write(rs3("sums"))
		else 
			response.Write("&nbsp;")
	end if
	if trim(rs3("retype"))="抵值券" or trim(rs3("retype"))="现金券" then 
			response.write("(实销："&rs3("sxje")&")")
	end if
	%>
	</font></div></td>
	<%rs3.movenext
	wend%>
  </tr>
</table>
<%else%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#009933">
<tr><td><div align="center"><font size="2" color="#FF0000">无 收 款 方 式</font></div></td></tr>
</table>
<%end if%>
<%rs3.close
set rs3=nothing%>
<br>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr> 
    <td width="100%"><div align="center"> 
        <table width="100%" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#009933">
          <tr> 
            <td width="20%"><div align="center"><font size="2">货号编号</font></div></td>
            <td width="17%"><div align="center"><font size="2">货号名称</font></div></td>
            <td width="13%"><div align="center"><font size="2">现价</font></div></td>
            <td width="11%"><div align="center"><font size="2">折扣</font></div></td>
			<td width="11%"><div align="center"><font size="2">结算价</font></div></td>
            <td width="10%"><div align="center"><font size="2">数量</font></div></td>
            <td width="15%"><div align="center"><font size="2">结算金额价</font></div></td>
          </tr>
          <%rs.open s2,cn
		  while not rs.eof%>
          <tr> 
            <td><div align="center"><font size="2"><%=rs("clothingid")%></font></div></td>
            <td><div align="center"><font size="2"><%=rs("s_name")%></font></div></td>
            <td><div align="center"><font size="2"><%=rs("x_price")%></font></div></td>
            <td><div align="center"><font size="2"><%=rs("discount")%>&nbsp;</font></div></td>
			<td><div align="center"><font size="2"><%=rs("s_price")%></font></div></td>
            <td><div align="center"><font size="2"><%response.write(rs("nums"))
			                                         nums=nums+cdbl(rs("nums"))%></font></div></td>
            <td><div align="center"><font size="2"><%response.write(rs("sums"))
			                                         s_price=s_price+cdbl(rs("sums"))%></font></div></td>
          </tr>
          <%rs.movenext
		   wend
		   rs.close
		   set rs=nothing%>
          <tr> 
            <td colspan="5"><div align="center"><font size="2" color="#FF0000">合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</font></div></td>
            <td><div align="center"><font size="2" color="#FF0000"><%=nums%></font></div></td>
            <td><div align="center"><font size="2" color="#FF0000"><%=s_price%></font></div></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="noprint">
  <tr> 
    <td> <div align="center"> 
        <input type="button" name="Submit" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.opener=null;window.close();">
      </div></td>

  </tr>
</table>
</body>
</html>

