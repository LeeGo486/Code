<%session("formid")=6101024%>
<!--#include file="inc/function.asp"-->

<%
dim readonly
readonly=""
dim act,ds,id,userid
set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
id=trim(request.QueryString("id"))
depotid=trim(session("dm").System_depotid)
userid = session("dm").System_userid


if id<>"" then
  sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums "&_
	    "from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
  ds.Open sql,cn,1,1
  if not ds.eof then
	vipname=ds("vipname")
	tzname=ds("tz_name")
    tzid=ds("Employeeid")
   end if
   ds.close
  end if
set ds=nothing

sub get_tz(tzid)
 rs.source="select a.employeeid,'['+employeeid+']'+a.names from j_employee a,jk_group b "&_
 		" where isnull(a.valid,0)=0 and a.groupid=b.groupid and a.depotid="&qts(depotid)
 rs.open
response.write("<option value='请选择'>请选择</option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=tzid then response.Write" selected " end if
response.write">"
response.write rs(1)
response.write"</option>"
rs.movenext
loop
rs.close
set rs=nothing
end sub
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改客户经理资料</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
function oncs(){
  var t=document.form1.tzid;
  var id='['+t.options[t.options.selectedIndex].value+']';
  var name=t.options[t.options.selectedIndex].text.replace(id,"");
  if(name!="请选择")
  {
     document.form1.tzname.value=name;
  }
  else
  {
     document.form1.tzname.value="";
  }
}
function save(){
   
   if ($("#tzid").val()=="请选择"){
       alert('请选择客户经理！');
	   return;
   }
   
   var obj = getjson('vip_tzsave.asp','vipid='+$("#vipid").val()+'&tzname='+escape($("#tzname").val())+'&tzid='+$("#tzid").val());
   if(obj.success=='true'){
	  alert('客户经理资料修改成功!');
	  window.returnValue=$("#tzname").val();
	  window.close();
	  return;
   }
   else
   {
      window.returnValue="未设置";
   	  alert('客户经理资料修改失败！');
	  return;
   }
	
}

function getjson(url,data)
{
	var html = $.ajax({
	url: url,
	type: "POST",
	data: data,
	async: false
	}).responseText;
	return eval('('+html+')');
}
</script>

</head>
<body>
<form name="form1" method="post" action="vip_tzsave.asp">
<input name="act" type="hidden" id="act" value="<%=act%>" />
<br>
<table width="100%"  border="1" cellpadding="3" cellspacing="1" bordercolor="#F0DEDA" class="f12">
    
    <tr>
      <td align="right">顾客姓名：</td>
      <td><%=vipname%></td>
      </tr>
	<tr>
      <td align="right">现客户经理：</td>
      <td><%=tzname%>
	  </td>
    </tr>  
    <tr>
      <td align="right">客户经理：</td>
      <td>
        <select name="tzid" id="tzid" style="width:150px; " tabindex="-1" onChange="oncs();" >
         <% get_tz tzid%>
        </select>
	  <input name="tzname" type="hidden" id="tzname" size="30"
       maxlength="30" value="<%=tzname%>" class="3007" >
	  </td>
    </tr>
   	</table>
 
	<table width="100%"  border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA" class="f12"> 
	<input type="hidden" value="<%=id%>" id="vipid" name="vipid">
	<%if pedit then%>
    <tr>
      <td align="center">
	  <input type="button" name="btnok"  onClick="save();" value="提交(S)">
      <input type="button" name="btnclose"  onClick="window.returnValue='';window.close();" value="关 闭"></td>
    </tr>
	<%end if%>
  </table>
</form>
</body>
</html>
