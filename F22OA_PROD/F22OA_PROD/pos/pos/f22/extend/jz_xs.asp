<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<!--#include file="inc/function.asp"-->
</head>
<style>
.f14{font-size:12px}
</style>
<body>
<%dim id,sql,ds,ds1,tname,i,depotid
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
%>
<table width="600"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk">
  <tr>
    <td height="21" class="f14"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 竞争品牌销售调查</td>
  </tr>
</table>
<table width="600"  border="0">
    <tr>
      <td></td>
    </tr>
</table>
<form name="form1" method="post" action="jz_xs_save.asp">
<table width="600" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td width="14%" class="f14">商场名称:</td>
    <td width="21%" class="f14"><select name="depotid" id="depotid">
      <option value="<%=session("dm").System_Depotid%>"><%=session("dm").System_DepotName%></option>
    </select></td>
    <td width="8%" class="f14">年份:</td>
    <td width="10%" class="f14">
	<select name="years" id="years">
    <%for i=0 to 1%>
	  <option value="<%=year(date)-i%>"><%=year(date)-i%></option>
    <%next%>
	</select>
	</td>
    <td width="8%" class="f14">月份:</td>
    <td width="10%" class="f14">
	<select name="months" id="months">
    <%for i=1 to 12%>
	  <option value="<%=i%>"><%=i%></option>
    <%next%>
	</select>
	</td>
    <td width="10%" class="f14">填写人:</td>
    <td width="25%" class="f14"><%=session("dm").System_UserName%>
	<input name="cr_name" type="hidden" id="cr_name" value="<%=session("dm").System_UserName%>"></td>
  </tr>
</table>
<table width="600" border="0">
  <tr>
    <td></td>
  </tr>
</table>
<table width="600" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr align="center" bgcolor="#FFF7F7">
    <td width="33%" class="f14">竞争品牌</td>
    <td width="16%" class="f14">销售额</td>
    <td width="51%" class="f14">备注</td>
    </tr>
<%
'sql="select competename from j_depotcompete where depotid=00009000"
sql="select competename from j_depotcompete where depotid="&qts(depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.Source = sql
ds.open
i=0
while not ds.eof
i=i+1
%>
  <tr>
    <td class="f14"><%=ds(0)%>
      <input name="styleid" type="hidden" id="styleid" value="<%=ds(0)%>"></td>
    <td class="f14"><input name="sums" type="text" id="sums" size="6" maxlength="6" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);"></td>
    <td class="f14"><input name="comment" type="text" id="comment" size="30"></td>
  </tr>
 <%ds.moveNext
 wend
 ds.close
 set ds=nothing%>
</table>
<input name="count" type="hidden" id="count" value="<%=i%>">
<table width="600" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="完成调查">
      </td>
  </tr>
</table>
</form>
</body>
</html>
