<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<style>
#ShowDivLink{
font-size:12px;
}
#ShowDivLink:hover{
color:#ff3300
}
</style>
<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDivAdd(z){
var z;
var s=document.getElementById("inputAdd_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>

<script language="javascript">
function jump(t){
  window.location.href="jz_ss.asp?depotid="+t.value;
}
function chkFormAdd(t){
  var msg="";
  t.depotid.value=document.form2.depotid.value;
  t.compete.value=document.form2.compete.value;
  t.setdate.value=document.form2.setdate.value;
  if(t.depotid.value==""){
    msg="店铺编号不能为空,请刷新后重试!";
  }
  if(t.compete.value==""){
    msg="竞争品牌编号不能为空,请刷后重试!";
  }
  if(t.styleid.value==""){
    msg="新产品型号不能为空!";
	alert(msg);
	t.styleid.focus();
	return false;
  }
  if(msg=="")
    return true;
  else
    return false;
}

function chkForm1(t){
  var msg="";
  if(t.styleid.value==""){
    msg="新产品型号不能为空!";
	alert(msg);
	t.styleid.focus();
	return false;
  }
  if(t.competechkid.value==""){
    msg="出错了!"
  }
  if(msg=="")
    return true;
  else
    return false;
}
</script>
</head>
<style>
.f14{font-size:12px}
</style>
<body>
<%dim id,sql,ds,ds1,tname,i,depotid,competechkid
depotid=trim(request.QueryString("depotid"))
if depotid="" then
  depotid=trim(session("dm").System_Depotid)
end if
userid=trim(session("dm").System_UserId)
competechkid=trim(request.QueryString("competechkid"))

%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk">
  <tr>
    <td height="21" class="f14"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 竞争品牌新品上市调查<%= competechkid%></td>
  </tr>
</table>
<table width="100"  border="0">
    <tr>
      <td></td>
    </tr>
</table>
<form name="form2" method="post" action="jz_ssNext.asp">
  <table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
    <tr>
      <td width="9%" class="f14">商场名称:</td>
      <td width="16%" class="f14"><select name="depotid" id="depotid">
          <option value="<%=session("dm").System_Depotid%>"><%=session("dm").System_DepotName%></option>
        </select>
&nbsp;</td>
      <td width="9%" class="f14">竞争品牌:</td>
      <td width="13%" class="f14"><select name="compete" id="compete">
          <%
sql="select competename from j_depotcompete where depotid="&qts(depotid)
'sql="select competename from j_depotcompete where depotid=0013"
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.Source = sql
ds.open
i=0
while not ds.eof
i=i+1%>
          <option value="<%=ds(0)%>"><%=ds(0)%></option>
          <%ds.moveNext
 wend
 ds.close%>
        </select>
      </td>
      <td width="10%" class="f14">上市时间:</td>
      <td width="16%" class="f14"><input name="setdate" type="text" id="setdate" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);" readonly> </td>
      <td width="12%" class="f14">填写人:</td>
      <td width="15%" class="f14"><%=session("dm").System_UserName%></td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="下一步">
    </td>
  </tr>
</table>

</form>
<table width="100" border="0">
  <tr>
    <td></td>
  </tr>
</table>

</body>
</html>
