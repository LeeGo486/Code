<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function jump(t){
  window.location.href="jz_cx.asp?depotid="+t.value;
}
</script>
</head>

<body>
<%dim id,sql,ds,ds1,tname,i,userid,depotid
depotid=trim(request.QueryString("depotid"))
if depotid="" then
  depotid=trim(session("dm").System_Depotid)
end if
userid=trim(session("dm").System_UserId)
%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk">
  <tr>
    <td height="21" class="f14"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 竞争品牌促销效果调查</td>
  </tr>
</table>
<table width="100"  border="0">
    <tr>
      <td></td>
    </tr>
</table>
<form name="form1" method="post" action="jz_cx_save.asp">
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td width="14%" class="f14">商场名称:</td>
    <td width="18%" class="f14">
      <select name="depotid" id="depotid" onChange="jump(this);">
<%set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
set ds1=server.CreateObject("ADODB.Recordset")
ds1.ActiveConnection = cn
sql="select depotid,d_name from webp_depot where userid="&qts(userid)
ds.Source = sql
ds.Open
while not ds.eof%>
        <option value="<%=ds(0)%>" <%if depotid=trim(ds(0)) then response.Write "selected" end if%>><%=ds(1)%></option>
		<%ds.movenext
		wend
		ds.Close%>
      </select> 
	    
      &nbsp;</td>
    <td width="14%" class="f14">竞争品牌:</td>
    <td width="22%" class="f14">
	<select name="compete" id="compete">
<%
sql="select competename from j_depotcompete where depotid="&qts(depotid)
ds.Source = sql
ds.open
i=-1
while not ds.eof
%>
	  <option value="<%=ds(0)%>"><%=ds(0)%></option>
 <%ds.moveNext
 wend
 ds.close
%>
	</select>
	</td>
    <td width="14%" class="f14">填写人:</td>
    <td width="18%" class="f14"><%=session("dm").System_UserName%>
	<input name="cr_name" type="hidden" id="cr_name" value="<%=session("dm").System_UserName%>"></td>
    </tr>
  <tr>
    <td class="f14">促销时间:</td>
    <td colspan="5" class="f14"><input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date()-1)%>" onFocus="setday(this);" readonly>
      -      
        <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);" readonly></td>
    </tr>
</table>
<table width="100" border="0">
  <tr>
    <td></td>
  </tr>
</table>
  <%sql="select lookname,lookupid,lookcode from j18_lookupsub where lookupid=8004 order by lookcode"
  ds.Source =sql
  ds.Open
  i=0
  while not ds.eof
  i=i+1
%>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr bgcolor="#FFF7F7">
    <td width="17%" class="f14"><%=ds(0)%>
      <input name="chktype<%=i%>" type="hidden" id="chktype<%=i%>" value="<%=ds(0)%>"></td>
    </tr>
  <tr><td class="f14">
  <%ds1.source="select * from j18_lookupsubsub where lookupid='"&ds("lookupid")&"' and lookname="&qts(ds("lookname"))&" order by lookcode"
  ds1.open
  while not ds1.eof%>
          <input type="radio" name="aid<%=i%>" value="<%=ds1("lvalue")%>"><%=ds1("loption")%><br>
	<%ds1.movenext
	wend
	ds1.close%><br>
备注:<input name="comment<%=i%>" type="text" id="comment<%=i%>" size="50" maxlength="50"></td>
    </tr>
</table>
 <%ds.movenext
 wend
 ds.close
 set ds=nothing
 set ds1=nothing%>
<input name="count" type="hidden" id="count" value="<%=i%>">
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="完成调查">
      </td>
  </tr>
</table>
</form>
</body>
</html>
