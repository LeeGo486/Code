<!--#include file="inc/function.asp"-->
<%
Response.Expires = 0 
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>给顾客发VIP卡</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
<script language="javascript">

function submitform()
{
	var id=document.forms[0].id;
	if(!id.value){
		alert("VIP卡号不能为空!");
		return false;
	}else{
		document.forms[0].submit();
	}
}

function sendcard(act){
	document.forms[0].act.value=act;
	submitform();
}

function okd(){
  var k=event.keyCode;
  if(k==13){
    sendcard("check");
    return false;
  }
}
</script>
</head>

<body>
<%dim vipid
vipid=trim(request.querystring("id"))
if vipid="" then
  response.write "请关掉重试!"
  response.end
end if
%>

<script language="javascript">
    function selectVipCard() {
        var m = showModalDialog("selectVipCard.asp?vipid=<%=vipid %>", 'example04', 'dialogWidth:450px;dialogHeight:450px;center: yes;help:no;resizable:yes;status:no');
        if (m != "" && m != undefined) {
            document.getElementById("id").value = m;
        } 
    }
</script>


<%
  '查询当前VIP申请的卡类型
  dim str,viptypeid,viptypename
  str=" select a.viptypeid,b.viptypename from vip_user a "&_
         " inner join vip_typevip b on a.viptypeid = b.viptypeid and a.vipid='"&vipid&"'"
  set ds=server.CreateObject("adodb.recordset")
  ds.open str,cn
    if not ds.eof then
        viptypeid=ds("viptypeid")
        viptypename=ds("viptypename")
    else
        viptypeid=""
        viptypename=""
    end if
  ds.close
  set ds=Nothing
 %>

<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">给顾客发VIP卡</td>
  </tr>
</table>
<form name="form1" method="get" action="vip_sendcard_save.asp" onSubmit="return checkform()" target="is">
  <input name="act" type="hidden" id="act" value="add">
    <input name="vipid" type="hidden" id="vipid" value="<%=vipid%>"></td>
  <table width="100%"  border="1" cellspacing="1" bordercolor="#EED9D6">
     <tr>
        <td>申请卡类型:</td>
        <td><%=viptypename %>
            <input type="hidden"   value="<%=viptypename %>" name="viptypename" id="viptypename"  readonly="readonly"/>
            <input type="hidden" value="<%=viptypeid %>"   name="viptypeid"   id="viptypeid"/>
        </td>
    </tr>
    <tr>
      <td width="25%">VIP卡号:</td>
      <td width="75%"><input name="id"  <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %>  id="id" size="28" maxlength="32" onKeyDown="return okd();">
      <input type="button" name="Submit" value="选择卡号" onClick="selectVipCard();"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="button" name="Submit" value="确定(S)" accesskey="s" onClick="sendcard('check');sendcard('add');">
      <input type="button" name="Submit" value="取消(X)" onClick="window.close();" accesskey="x">
    </tr>
  </table>
</form>
<iframe style="display:none" name="is" src="about:blank"></iframe>
</body>
</html>
