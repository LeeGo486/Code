<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="inc/function.asp"-->
<%
act=request("act")
cardtype=request.Form("cardtype")

m=request("m")								'M取的是现金
if m="" then m=0							'如果是空则为0
if not(isnumeric(m)) then m=0	'如果不是数字也是0

sums="0.00"
'检测卡号
if act="check" then
	if cardtype="0" then
	
		response.write "<script>parent.document.getElementById('sums').value='"&sums&"';"&_
										"parent.document.getElementById('xfsums').value='0.00';</script>"
		set rs=server.createobject("adodb.recordset")
			dbname=session("dbname")
			cardid=request.Form("cardid")
			password=request.Form("password")
	'卡验证
			sql="select sums,isnull([start],0),password from cashcard.dbo.j_card "&_
					" where cardid='"&cardid&"' and dbname='"&dbname&"'"
			rs.open sql,cn,1,1
			if rs.eof and rs.bof then
				response.write "<script>parent.document.getElementById('cardid').value='';parent.document.getElementById('cardid').focus();</script>"
				ebox "卡号不存在！"
			else
				if rs(2)<>password then
				response.write "<script>parent.document.getElementById('password').value='';parent.document.getElementById('password').focus();</script>"
				ebox "充值卡密码错误!"
				elseif rs(1)=0 then
				ebox "该充值卡未生效，暂不能使用！"
				else
					m = formatNumber(m,2,-1,-1,0)
					sums=formatNumber(rs(0),2,-1,-1,0)
					if cdbl(sums)<cdbl(m) then
					m=sums			'如果卡上余额不足以支付，则使用全部
					response.write "<script>parent.document.getElementById('sums').style.color='red';"&_		
													"parent.document.getElementById('sums').title='该充值卡余额不足以支付本次消费';</script>"
					else
					response.write "<script>parent.document.getElementById('sums').style.color='';"&_		
													"parent.document.getElementById('sums').title='';</script>"
					end if
					
					response.write "<script>parent.document.getElementById('cashcard').value='"&cardid&"';</script>"
					
				end if
				
			end if
		rs.close
		set rs=nothing
	'负值
		response.write "<script>parent.document.getElementById('sums').value='"&sums&"'</script>"
		response.write "<script>parent.document.getElementById('xfsums').value='"&m&"';"&_
									 "parent.document.getElementById('xfsums').focus();parent.document.getElementById('xfsums').select();</script>"
		response.end()
	end if
	
'提交
elseif act="submit" then
	xfsums= trim(request.form("xfsums"))
	cashcard= trim(request.form("cashcard"))
	if cashcard<>"" and cdbl(xfsums)>0 then
		session("cashcard")=ucase(cashcard)
		response.write "<script>javascript:window.returnValue='"&xfsums&"';window.close();</script>"
		response.end()
	else
		response.write "<script>javascript:window.close();</script>"
		response.end()
	end if
end if
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>使用充值卡</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
<script language="javascript">
function checkForm(form){
	var u = form.vip_username;
	var m = form.vip_mobile;
	if(u.value.length==0){
		u.focus();
		return false;
	}else if(m.value.length==0){
		m.focus();
		return false;
	}
	return true;
}

function KeyDown(){
	with (event){ 
		if(keyCode==27){//ESC返回输入状态
			window.close();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}
	}
}
document.onkeydown = KeyDown;
</script>
</head>

<body onLoad="document.forms[0].cardid.focus();">
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">使用充值卡</td>
  </tr>
</table>
<!--验证表单-->
<form name="form1" method="post" action="?act=check" target="hf">
<input type="hidden" name="m" value="<%=m%>">
<table width='96%' border=0 align="center" cellpadding="3" cellspacing=0 style="margin:10px 0;">
    <tr>
      <td width="40%" align="right">收款方式：</td>
      <td><label>
        <select name="cardtype" id="cardtype">
          <option value="0">充值卡</option>
        </select>
      </label></td>
    </tr>
    <tr>
      <td align="right">输入卡号：</td>
      <td>
      <input name="cardid" type="text" class="box" id="cardid" value="<%=session("cashcard")%>" size="25" maxlength="255"></td>
    </tr>
    <tr>
      <td align="right">卡号密码：</td>
      <td><input name="password" type="password" id="password" maxlength="11" class="box"></td>
    </tr>
  </table>
  <div style="height:25px;text-align:center" align="center">
  <input type="submit" name="search" id="search" value=" 查 询 " class="btn"></div>
</form>
<!--提交表单-->
<form name="form2" method="post" action="?act=submit" target="hf">
<input type="hidden" name="cashcard" id="cashcard" value="">
<table width='96%' border=0 align="center" cellpadding="3" cellspacing=0  style="margin:10px 0;">
  <tr>
    <td width="40%" align="right">卡上余额：</td>
    <td><input name="sums" type="text" id="sums" value="<%=sums%>" size="20" maxlength="8" class="box"
     readonly=readonly style="background-color:#e6e6e6;"></td>
  </tr>
  <tr>
    <td align="right">消费金额：</td>
    <td><input name="xfsums" type="text" id="xfsums" onkeypress="return isNumber()" onBlur="this.value=parseFloat(this.value).toFixed(2)" class="box" value="0.00" size="20" maxlength="8"></td>
  </tr>
  <tr>
    <td width="40%" align="right">扣减后余额：</td>
    <td><input name="kj" type="text" id="kj" value="" size="20" maxlength="8" class="box"
     readonly=readonly style="background-color:#e6e6e6;"></td>
  </tr>
</table>
<script type="text/javascript" defer>
function isNumber(){
	with (event){ 
		if((keyCode>=48&&keyCode<=57)||keyCode==190||keyCode==46||keyCode==8||keyCode==13||keyCode==27){
			return true;
		}
	}
	return false
}
function kj(){
		var a = document.getElementById("sums");
		var b = document.getElementById("xfsums");
		
		if(b.value==""){ b.value=0 };
		var d = document.getElementById("kj");
		var c=(parseFloat(a.value)-parseFloat(b.value)).toFixed(2);
		
		if(c<0){b.value=0};
		d.value=c;
		setTimeout(kj,100)
}
kj();
</script>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    <input type="submit" name="vip_use" value=" 确 定 " class="btn">
    <input type="button" name="vip_close" value=" 取消[Esc] " onClick="window.close();" class="btn"></td>
  </tr>
</table>
</form>
<iframe style="display:none" name="hf" id="hf" src="about:blank"></iframe>
</body>
</html>