<!--#include file="../f22/inc/function.asp"-->
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>积分换购</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script>
function chkform(t){
	var ysje=document.getElementById("ysje");
	var zhje=document.getElementById("zhje");
	var aa = eval(t.ssje.value) - eval(ysje.innerHTML);
	if(aa<0){
		alert('应收金额不能小于实收金额！');
		t.ssje.focus();
		t.ssje.select();
		return false
	}else{
		zhje.innerHTML = aa;	//将此值负给SPAN
		//document.getElementById("Submit").focus();
		document.getElementById("Submit").disabled=true;
		document.getElementById("Submit").value='请稍等...'
		//event.keyCode=9;			//并跳转到下一个换购按钮
	}
}
</script>
<style>
body{margin:0;}
td,span,input{
font-size:14px;
font-family:arial;
}
span{
font-size:16px;
}
</style>
</head>
<body>
<%
set rs=server.CreateObject("adodb.recordset")
set rs2=server.CreateObject("adodb.recordset")
tmptab =" webtmp_dollar "

if request.Form("act")="checkout" then
	ysums=request.Form("ysums")
	ssje =request.Form("ssje")
	comment =request.Form("comment")
	centum =request.Form("centum")
	vipcode =request.Form("vipcode")
	depotid=session("dm").System_DepotId
	userid=session("dm").System_UserId
	username = session("dm").System_UserName
	retailid=getid("d_retail","retailid","LS",userid)
	
	if centum<>"1" then 
		dtype=2 	'换购方式：总积分
	else 
		dtype=3		'换购方式：上季积分
	end if
	
	'主表
	rs.open "select * from d_retail where 1=2 ",cn,1,3
	rs.addnew
		rs("retailid")=retailid
		rs("retail")=retailid
		rs("depotid")=depotid
		rs("vipcode")=vipcode
		rs("sure")="0"
		rs("chk_sure")="0"
		rs("setdate")=now()
		rs("s_sums")=ssje								'	实收金额
		rs("z_sums")=eval(ssje-ysums)		' 找回金额
		rs("s_name")=username
		rs("x_name")=username
		rs("chk_name")=username
		rs("chk_date")=now()
		rs("cr_date")=now()
		rs("sure_date")=now()
		rs("cr_name")=username
		rs("dtype")=dtype
		rs("comment")=comment
	rs.update
	rs.close
	
	'子表
dim price1,price2,discount0
	sql = "select clothingid,styleid,sizeid,colorid,isnull(nums,0) as nums,isnull(buycentum,0) as buycentum, "&_
		" isnull(dcentum,0) as dcentum,isnull(price,0) as price,begdate,enddate "&_
		" from "&tmptab&" where depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=0"
	rs.open sql,cn,1,1
		do while not rs.eof
			rs2.open "select * from d_retailsub where 1=2",cn,1,3
			rs2.addnew
				rs2("retailid")=retailid
				rs2("boxid")=getboxid()
				rs2("clothingid")=rs(0)
				rs2("styleid")=rs(1)
				rs2("sizeid")=rs(2)
				rs2("colorid")=rs(3)
				rs2("vipcardid")=vipcode
				rs2("vipcentum")=(-1*cdbl(rs("dcentum"))+cdbl(rs("buycentum")))*cdbl(rs("nums"))
				rs2("s_price")=rs(7)
				rs2("nums")=rs(4)
			rs2.update
			rs2.close
			
			'金额
			rs2.open "t18tj_getclothingprice 3,"&qts(depotid)&","&qts(rs("clothingid"))&","&qts(now())&"",cn,1,1
				
				price1 = cdbl(rs("price"))
				price2 = cdbl(rs2("x_price"))
				
				if price<>0 and price2<>0 then
					discount0=formatnumber((price/price2),4,-1)
				else
					discount0=0
				end if
				sql= "update d_retailsub set j_cost="&rs2("j_cost")&",j_price="&rs2("j_price")&", "&_
				"x_price="&rs2("x_price")&",discount="&discount0&",s_price="&rs("price")&","&_
				"old_jprice="&rs2("j_price")&",old_xprice="&rs2("x_price")&",old_sprice="&rs2("s_price")&",old_rate="&rs2("discount")&",comment='积分换购' "&_
				" from d_retailsub where retailid="&qts(retailid)&" and clothingid="&qts(rs("clothingid"))
				cn.execute sql
			rs2.close
		rs.movenext
		loop
	rs.close
	set rs2=nothing
	
	'审核主单
	sql=" update d_retail set chk_sure=1 where retailid="&qts(retailid) 
	cn.execute(sql)
	
	'主单登帐
	sql=" update d_retail set sure=1 where retailid="&qts(retailid) 
	cn.execute(sql)
	
	'清除记录
	cn.execute("delete from "&tmptab&" where depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0")
	
	'提示
	close "换购成功，换购单号是："&retailid

else

centum =request("centum")			 '确认使用的换购方式
vipcode=request("vipcode") 	 '通过VIP卡确定当前积分是否可以换购
hgfs=request("hgfs")
if not isNumeric(hgfs) or isnull(hgfs) then hgfs=0

sql="select isnull(sum(isnull(dcentum,0)*isnull(nums,0)),0) as tcentum, sum(price*nums) as tprice from "&tmptab&""&_
		" where depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0"
rs.open sql,cn,1,1
if rs.eof and rs.eof then
	close "无换购信息"
else
	yk = rs(0)	'应扣积分
	je = rs(1)	'应加费用
	if cdbl(yk)>cdbl(hgfs) then close "当前换购积分需要："&yk&"。\r您当前的积分："&hgfs&"不够扣减！"
	
end if
rs.close
%>
<form name="form1" method="post" target="hs" action="?act=submit" onSubmit="return chkform(this)" style="margin:0;">
  <input type="hidden" value="checkout" name="act" id="act">
  <input type="hidden" value="<%=je%>" name="ysums" id="ysums">
  <input type="hidden" value="<%=hgfs%>" name="hgfs" id="hgfs">
  <input type="hidden" value="<%=comment%>" name="comment" id="comment">
  <input type="hidden" value="<%=centum%>" name="centum" id="centum">
  <input type="hidden" value="<%=vipcode%>" name="vipcode" id="vipcode">
  <table width="100%"  border="0" cellpadding="3" cellspacing="5" style="margin:6px 0">
  <tr>
    <td align="right">换购应减积分：</td>
    <td><%=yk%></td>
  </tr>
  <tr>
    <td align="right">换购应收金额：</td>
    <td><span id="ysje"><%=je%></span> </td>
  </tr>
  <tr>
    <td align="right">换购实收金额：</td>
    <td><input type="text" name="ssje" id="ssje" value="<%=je%>"
       onKeyUp="value=value.replace(/[^\d]/g,'') ;"
       onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));"></td>
  </tr>
  <tr>
    <td align="right">换购找回金额：</td>
    <td><span id="zhje">0</span></td>
  </tr>
	</table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="5"> 
    <tr>
      <td align="center">
      <input type="Submit" name="Submit" value="　换　购　">
      <input type="button" name="Submit" value="关　闭" onClick="window.close()"></td>
    </tr>
  </table>
</form>
<iframe name="hs" src="about:blank" style="display:none"></iframe>
<%
end if	
set rs=nothing
%>
</body>
</html>
