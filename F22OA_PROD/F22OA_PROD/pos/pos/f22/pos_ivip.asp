<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查找VIP资料</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
<script language="javascript">
function vip(vipcode){
  if(vipcode!=''){
  	showModalDialog('vip_user.asp?vipcode='+vipcode,'vipmx','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
  }else{
    alert('VIP卡号为空！');
  }
}

function searchvip(vipcode){
  if(vipcode!=''){
  	showModalDialog('../crm/vip_xf.asp?id='+vipcode,'vipmx','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;status:no');
  }else{
    alert('VIP卡号为空！');
  }
}

function onok(vipcode){
  if(vipcode!=""){
    window.returnValue=vipcode;
  }else{
    window.returnValue="0";
  }
  window.close();
}
</script>
</head>

<body onLoad="document.form1.key.focus();">
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">查找VIP资料</td>
  </tr>
</table>
<%dim opt,key
opt=trim(request.QueryString("opt"))
key=trim(request.QueryString("key"))
if not isnumeric(opt) then
  opt=1
else
  opt=cint(opt)
end if
key=replace(key,"'","")
%>
<form name="form1" method="get" action="pos_ivip.asp">
  <table width="100%"  border="0" class="tcontent">
    <tr>
      <td>方式：<input name="opt" type="radio" value="1" <%if opt=1 then response.Write " checked" end if%> >
        VIP卡号 <input type="radio" name="opt" value="2" <%if opt=2 then response.Write " checked" end if%>>
手机号码 <input type="radio" name="opt" value="3" <%if opt=3 then response.Write " checked" end if%>>
身份证号码 <input type="radio" name="opt" value="4" <%if opt=4 then response.Write " checked" end if%>>
姓名 </td>
    </tr>
    <tr>
      <td>关键字：
        <input name="key" type="text" id="key" size="20" maxlength="20" value="<%=key%>">
      <input type="submit" name="Submit" value="查询"></td>
    </tr>
  </table>
</form>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF' class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
    <td width="20%">VIP卡号</td>
    <td width="20%">姓名</td>
	<td width="15%">总积分</td>
    <td width="15%">生日</td>
    <td width="20%">手机号</td>
    <td width="13%">&nbsp;</td>
  </tr>
  <%'dim cn
'set cn=server.createobject("ADODB.Connection")
'cn.open session("cn")
  dim ds,sql
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum from vip_user a,vip_cardvip b where a.vipcode*=b.vipcardid and isnull(a.vipcode,'')<>'' and "
  select case opt
  case 1
    '判断刷新截取
	if request.cookies("vipflash")("cut")=1 then
	  sql=sql&" substring('"&key&"',"&request.cookies("vipflash")("beg")&","&request.cookies("vipflash")("cnt")&")=a.vipcode" 
    else
	  sql=sql&" a.vipcode='"&key&"'"
	end if
  case 2
    sql=sql&" a.mobtel like '%"&key&"%'"
  case 3
    sql=sql&" a.vippassport like '%"&key&"%'"
  case 4
    sql=sql&" a.vipname like '%"&key&"%'"
  end select
  if key="" then sql="select 1 from vip_user where 1=0" 
'  de sql
  ds.Source = sql
  ds.Open
  while not ds.eof%>
  <tr>
    <td><a href="javascript:searchvip('<%=ds("vipid")%>');"><%=ds("vipcode")%></a></td>
    <td><%if trim(ds("depotid"))=session("dm").system_depotid then%><a href="javascript:vip('<%=ds("vipcode")%>');"><%=ds("vipname")%></a><%else response.write ds("vipname") end if%></td>
	<td><%=ds("zcentum")%></td>
    <td><%=ds("vipbirth")%>&nbsp;</td>
    <td><%if trim(ds("depotid"))=session("dm").system_depotid then response.write ds("mobtel")  end if%>&nbsp;</td>
    <td>
	<%if session("posvipcode")="" then%>
	<input type="button" name="Submit" value="确定" onClick="onok('<%=getvip(ds("vipcode"))%>');">
	<%end if%></td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  set ds=nothing%>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFEFEF" class="bk">
  <tr>
    <td align="center"><input type="button" name="Submit" value=" 关 闭 (X)" accesskey="x" onClick="window.close();"></td>
  </tr>
</table>
</body>
</html>