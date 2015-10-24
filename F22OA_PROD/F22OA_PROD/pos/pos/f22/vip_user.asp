<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP会员资料</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<%sub rf(str)%>
<script language="javascript">
function rvip(){
  alert("<%=str%>");
  window.returnValue="0";
  window.close();
}
rvip();

</script>
<%end sub%>
<script language="javascript">
function get_vipCode(vipCode){
 window.returnValue=vipCode;
 window.close();
}
</script>
</head>

<body>
<!--#include file="inc/function.asp"-->
<%
dim ds,sql,depotid,id
id=trim(request.QueryString("vipcode"))

if id="" then call close("VIP卡号不能为空!")
depotid=trim(session("dm").System_depotid)
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum from vip_user a,vip_cardvip b where a.vipcode="&qts(id)&" and a.vipcode=b.vipcardid"
ds.Source = sql
ds.Open
if ds.eof then
  ds.close
  set ds=nothing
  'call close("没有此VIP客户,请核对后重新输入!")
  call rf("没有此VIP客户,请核对后重新输入!")
else
%>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP会员资料</td>
  </tr>
</table>
<form name="form1" method="post" action="vip_save.asp">
  <table width="100%"  border="1" cellspacing="1" bordercolor="#F0DEDA" class="f12">
    <tr>
      <td width="16%" align="right">姓名:</td>
      <td width="84%"><%=ds("vipname")%>      </td>
    </tr>
    <tr>
      <td align="right">性别:</td>
      <td><%=ds("vipsex")%></td>
    </tr>
    <tr>
      <td align="right">出生日期:</td>
      <td><%=ds("vipbirth")%></td>
    </tr>
    <tr>
      <td align="right">身高:</td>
      <td><%=ds("stature")%></td>
    </tr>
    <tr>
      <td align="right">证件类型:</td>
      <td><%=ds("vippaper")%></td>
    </tr>
    <tr>
      <td align="right">证件号码:</td>
      <td><%=ds("vippassport")%></td>
    </tr>
    <tr>
      <td align="right">民族:</td>
      <td><%=ds("people")%></td>
    </tr>
    <tr>
      <td align="right">职业:</td>
      <td><%=ds("vipname")%></td>
    </tr>
    <tr>
      <td align="right">固定电话:</td>
      <td><%if ds("depotid")=session("dm").system_depotid then response.write(ds("viptel")) end if%></td>
    </tr>
    <tr>
      <td align="right">手机:</td>
      <td><%if ds("depotid")=session("dm").system_depotid then response.write(ds("mobtel")) end if%></td>
    </tr>
    <tr>
      <td align="right">电子邮箱:</td>
      <td><%=ds("vipemail")%></td>
    </tr>
    <tr>
      <td align="right">籍贯:</td>
      <td><%=ds("vipadd")%></td>
    </tr>
    <tr>
      <td align="right">邮编:</td>
      <td><%=ds("vippostalcode")%></td>
    </tr>
    <tr>
      <td align="right">通信地址:</td>
      <td><%=ds("vipname")%></td>
    </tr>
    <tr>
      <td align="right">积分:</td>
      <td><%=ds("zcentum")%></td>
    </tr>
    <tr>
      <td align="right">备注:</td>
      <td><%=ds("comment")%></td>
    </tr>
    <tr>
      <td align="right">&nbsp;</td>
      <td align="center"><input type="button" name="Submit" value="确定(S)" onClick="javascript:get_vipCode('<%=id%>');">
      <input type="reset" name="Submit" value="取消(X)" onClick="window.close();"></td>
    </tr>
  </table>
</form>
<%end if%>
</body>
</html>
