<%Response.Expires=-1000%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>收银</title>
<!--#include file="inc/function.asp"-->
<%
	session("fjfcash")=""
	session("fjfnums")=""
%>
<style type="text/css">
.red{
color:red;
font-size:12px;
}
.h {
	font-size:24px;
}
.it{
	font-size:24px;
	border:none;
}
.f12 {
	font-size:12px;
}
.bk {
	border:1px solid;
}
.btn{
	background-color: #FFF;
	background-image:url(img/button_blue.gif);
	background-repeat:no-repeat;
	border: #FFF 0px solid;
	color: #1652a3;
	font-size:12px;
	font-family:tahoma;
	height: 21px;
	width: 74px;
	cursor: hand;	
	text-align:center;
}
</style>
<script language="javascript">
var flag=false;
var cn=0;
function b1(){
  if(event.keyCode==13){
    var ys=document.form1.ys;
	var ss=document.form1.ss;
	var zl=document.form1.zl;
	//var ysn=parseInt(ys.value);
	var ysn=parseFloat(ys.value);
	//var ssn=parseInt(ss.value);
	var ssn=parseFloat(ss.value)
	if(ssn<ysn){
	 alert("应收数不能小于实收数!");
	  cn=0;
	}else{
	  zl.value=Math.round((ssn-ysn)*100)/100;
	  document.form1.a.focus();
	  document.form1.a.select();
	  event.returnValue=false;
	  cn=cn+1;
	}
	if(cn==2)document.form1.submit();
  }else if((event.keyCode>=48 && event.keyCode <=57)||(event.keyCode>=96 && event.keyCode <=105)||(event.keyCode=190)){
    //alert(event.keyCode);
	cn=0;
  }else if(event.keyCode==8){
    cn=0;
    return event.keyCode;
  }else{
    //alert(event.keyCode);
	cn=0;
    return false;
  }
}

function b2(){
  if(event.keyCode==13){
    cn=cn+1;
	event.returnValue=false;
    flag=true;
  }
}

function ontxtblur()
{
    var ys=document.form1.ys;
	var ss=document.form1.ss;
	var zl=document.form1.zl;
	var ysn=parseFloat(ys.value);
	var ssn=parseFloat(ss.value)
	if(ssn<ysn){
	 alert("应收数不能小于实收数!");
	}else{
	  zl.value=Math.round((ssn-ysn)*100)/100;
	}

}

function b3(t){
  var k=event.keyCode;
  if(k==13){ 
    //event.keyCode=9;
  }else if((k>=48 && k <=57)||(k>=96 && k <=105)||(k=190)){
    //alert(event.keyCode);
  }else if(k==8){
    return event.keyCode;
  }else{
    //alert(event.keyCode);
    return false;
  }
}

function cf(){
    var ys=document.form1.ys;
	var ss=document.form1.ss;
	var zl=document.form1.zl;
	var ename=document.form1.empname;
	//var ysn=parseInt(ys.value);
	//var ssn=parseInt(ss.value);
	var ysn=parseFloat(ys.value);
	var ssn=parseFloat(ss.value);
	if(ename.value==''){alert('请选择营业员！');return false;}
	if(ssn<ysn){
	  alert("应收数不能小于实收数!");
	  ss.focus();
	  ss.select();
	  event.returnValue=false;
	  return false;
	}else{
	  zl.value=Math.round((ssn-ysn)*100)/100;
	  if(cn==2){
	    document.form1.Submit.disabled=true;
		document.form1.resets.disabled=true;
	    return true;
	  }else{
	    cn=cn+1;
	    return false;
	  }
	}
	
}

function usecard(v){
	var ys2 = document.getElementById('ys2').value
    var m=document.form1.n[0];
	//充值卡
	if(v==0){
		var m2=document.getElementById('cashcard');
			if(m.value==""){	m.value=0}
			if(m2.value==""){	m2.value=0}
			
		var mv=parseFloat(parseFloat(m.value)+parseFloat(m2.value));
		var sm=showModalDialog('cashcard_search.asp?m='+mv,'cashcard','dialogWidth:300px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no');
		if(sm){
			var cc = m.value;
			if(cc==""){	cc=0}
			cc = parseFloat(cc).toFixed(2);
			sm = parseFloat(sm).toFixed(2);
			m.value=parseFloat(cc-sm+parseFloat(m2.value)).toFixed(2);
			m2.value=sm;
			document.form1.Submit.focus();
		}
		
	//积分抵扣
	}else if(v==1){
		var m2=document.getElementById('cashjf');
			if(m.value==""){	m.value=0}
			if(m2.value==""){	m2.value=0}
		var mv=parseFloat(parseFloat(m.value)+parseFloat(m2.value));
		
		var sm=showModalDialog('pos_cashjf.asp?vipcode=<%=session("posvipcode")%>&ys='+ys2,'cashjf','dialogWidth:300px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no');
		if(sm){
			var a=sm.split('{$}');
			var cc=ys2;
			if(cc==""){	cc=0}
			cc = parseFloat(cc).toFixed(2);
			b = parseFloat(a[1]).toFixed(2);
			
			//如果扣减的现金大于应收现金，则扣减现金等于现金
			if(b>parseFloat(ys2)) b = parseFloat(ys2)
			
			m.value=parseFloat(cc-b).toFixed(2);
			m2.value=b;
			document.getElementById('cashjfText').innerHTML="扣"+a[2]+"积分";
			document.form1.Submit.focus();
		}
	}
	document.getElementById('ys').value=parseFloat(m.value);
	document.getElementById('ss').value=parseFloat(m.value);
}

function akd(){
  var k=event.keyCode;
  if(k==13){
    var id=document.form1.a.value;
    if(id!=""){
      var ms=showModalDialog('pos_getsname.asp?id='+id,'e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no');
	  if(ms!="n"){
	    document.form1.empname.value=document.form1.empname.value+","+ms;
	    document.form1.a.value="";
		document.form1.a.focus();
		document.form1.hsname.value=document.form1.hsname.value+","+id;
	  }else{
	    alert("没有此营业员！");
	    //document.form1.a.value="";
		document.form1.a.focus();
		return;
	  }
	  event.returnValue=false;
    } else {
	  event.keyCode=9;
	}
  }else if((k>=48 && k <=57)||(k>=96 && k <=105)){
    //alert(event.keyCode);
  }else if(k==8){
    return event.keyCode;
  }else{
    //alert(event.keyCode);
    return false;
  }
  cn=0;
}

function oncs(){
  var t=document.form1.s_name;
  var id=t.options[t.options.selectedIndex].value;
  var name=t.options[t.options.selectedIndex].text;
  if(id!="请选择" || name!="请选择")
  {
		if(document.form1.hsname.value.indexOf(","+id)<0){
		document.form1.hsname.value=document.form1.hsname.value+","+id;
		document.form1.empname.value=document.form1.empname.value+","+name;
		}
  }
}
function renull(val)
{
	val=parseFloat(val).toString();
	if(val=="NaN") val = 0;
	return val
}
	
function form_submit(){
	document.form1.Submit.disabled=true;
	document.form1.submit();
}

function changecash(obj){
   if (document.form1.retype1.value=="现金"){
      var other=0;
      var value=0;
      for(var i=1;i<document.form1.n.length;i++){
        if (document.form1.n[i].name!=obj.name&&document.form1.n[i].value!=""){
	    other+=parseFloat(document.form1.n[i].value);
	    }	 
	  }
   
      if (obj.value!=""){
        value=obj.value;
      }
	  var yhje=document.form1.yhje.value;
	
      var cash=parseFloat(document.form1.ss.value)+parseFloat(yhje)-parseFloat(value)-parseFloat(other);
      if (cash<0){
        alert('现金金额不能小于0');
		obj.value="";
	    return;
      }	
      else
     {
	    document.form1.n1.value=cash;
	 }
   }	 
}
</script>
<base target="_self">
</head>

<body onLoad="ol();">
<%dim ds,retailid,ys,sums,discount,t,i,depotid
retailid=trim(session("retailid"))
depotid=trim(session("dm").System_Depotid)
setdate=trim(request("setdate"))
set ds=server.CreateObject("ADODB.RecordSet")
ds.ActiveConnection = cn

'判断有无记录
ds.Source = "select 1 from webtmp_retailsub where retailid='"&retailid&"'"
ds.open
if ds.eof then
   call close("没有收银记录，不能收银！")
end if
ds.close

'判断盘点单
Sql="select 1 from d_inventory where depotid='"&depotid&"' and isnull(sure,0)>0 "&_
    "and convert(char(10),setdate,126)>='"&setdate&"' and substring(inventoryid,1,2) = 'PD'"
ds.Source =Sql 
ds.open
if not ds.eof then
   call close("当天或当天以后已有盘点单，不能收银！")
end if
ds.close

'插入赠送记录
sql="insert into webtmp_retailsub (retailid,boxid,clothingid,styleid,sizeid,colorid,nums,x_price,s_price,discount,j_price,oldj_price,oldx_price,olds_price,olddiscount,cszs) "&_
    "select '"&retailid&"','WB"&session("dm").System_UserId&"',clothingid,styleid,sizeid,colorid,nums,x_price,s_price,discount,j_price,j_price,x_price,s_price,discount,1 "&_
	"from webtmp_zs where retailid='"&retailid&"'"
cn.execute sql
sql="delete from webtmp_zs where retailid='"&retailid&"'"
cn.execute sql

t=0
ys=0

sql="select isnull(sum(nums*s_price),0) from webtmp_retailsub where retailid="&qts(retailid)
ds.Source = sql
ds.open
if not ds.eof then
  ys=cdbl(ds(0))
end if
ds.close
'sql="select isnull(sum(nums*s_price),0) from webtmp_retailsub where isnull(zs,0)=1 and retailid="&qts(retailid)
'ds.Source = sql
'ds.open
'if not ds.eof then
'  ys=ys+cdbl(ds(0))
'end if
'ds.close
'得到促销优惠
ds.open "select sums from webtmp_skfs where retailid='"&retailid&"'",cn
if not ds.eof then
   csyh=cdbl(ds(0))
else
   csyh=0
end if
ds.close

dim yhje
ds.open "select isnull(sums,0) as sums from webtmp_skfs where retailid='"&retailid&"' and retype='促销优惠'",cn
if not ds.eof then
	yhje=cdbl(ds("sums"))
else
	yhje=0
end if
ds.close
dk_price = 0
if session("oldid")<>"" then
		set ds1=server.CreateObject("adodb.recordset")
		ds1.open "select isnull(dk_price,0),isnull(dk_centum,0) from d_retail where retailid='"&session("oldid")&"'",cn,1,1
			dk_price = cdbl(ds1(0))
			dk_centum = cdbl(ds1(1))
		
			if dk_price<>0 and dk_centum<>0 then
				dk_price = dk_price * -1
				dk_centum = dk_centum * -1
				session("fjfcash") = dk_price
				session("fjfnums") = dk_centum
				dk_centum = "扣 "&dk_centum&" 积分"
			end if
		ds1.close
		set ds1=nothing
end if

%> 
<form name="form1" method="post" action="pos_control.asp" onSubmit="return cf();">
  <table width="380"  border="0" align="center" bordercolor="#ECD4D0" class="bk">
	<tr>
      <td align="center"><font color=red>消费额:<%=ys%>&nbsp;&nbsp;&nbsp;促销优惠:<%=yhje%></font>
	  </td>
    </tr>
    <tr>
      <td align="center">应收金额:
        <input name="ys" type="text" class="it" id="ys" value="<%=ys-yhje-dk_price%>" size="10" maxlength="10" readonly>
        <input name="ys2" type="hidden" id="ys2" value="<%=ys-yhje%>">
        <input name="sureys" type="hidden" id="sureys" value="<%=ys-yhje%>">
        <input name="act" type="hidden" id="act" value="sy">
		<input name="yhje" type="hidden" id="yhje" value="<%=yhje%>">
      </td>
    </tr>
    <tr>
      <td align="center">实收金额: 
        <input name="ss" type="text" class="it" id="ss" value="<%=ys-yhje-dk_price%>"
        			 size="10" maxlength="10"  onFocus="this.select()" onBlur="ontxtblur();"  onKeyDown="return b1();">
	  </td>
    </tr>
    <tr>
      <td align="center">找零:
      <input name="zl" type="text" class="it" id="zl" value="0" size="10" maxlength="10"
      		 readonly onKeyDown="return b2();"></td>
    </tr>
    <tr>
      <td align="center">选择导购员：<input name="a" type="text" id="a" size="10" maxlength="10" onKeyDown="return akd();">
        <select name="s_name" id="s_name" style="width:80px; " tabindex="-1" onChange="oncs();">
        <option value="请选择">请选择</option>
            <%
              'sql="select a.names from j_employee a,jk_group b where b.groupname='"&groupname&"' and a.groupid=b.groupid and a.depotid="&qts(depotid)
              sql=" select a.employeeid,a.names from j_employee a,jk_group b "&_
									" where isnull(a.valid,0)=0 and a.groupid=b.groupid and a.depotid="&qts(depotid)
          ds.source = sql
          ds.open
          while not ds.eof%>
            <option value="<%=trim(ds("employeeid"))%>">
            <%response.write(ds("names"))%>
            </option>
            <%ds.movenext
          wend
          ds.close%>
        </select></td>
    </tr>
    <tr>
      <td align="center">导购员：
        <input name="empname" type="text" class="it" id="empname" size="20" maxlength="20">
        <input name="hsname" type="hidden" id="hsname"></td>
    </tr>
	<%if session("sysendmsg")=1 and session("posvipcode")="" then%>
	<tr><td align="center">顾客姓名：<input type="text" name="sellname" size=10 onKeyDown="if(event.keyCode==13)event.keyCode=9"> 
	手机：<input type="text" name="sellnametel" size=15></td></tr>
	<%end if%>
    <tr>
      <td align="center" height="50">
      <input type="submit" name="Submit" value="确定(S)" accesskey="s" onClick="form_submit();" class="btn">
			<%if session("cf_VipSet_jfdx")>0 and session("posvipcode")<>"" then
			%>
      	<%if session("oldid")="" then %>
            <input type="button" name="jfdx" id="jfdx" onClick="usecard(1)" value="积分抵扣" class="btn">
        <%end if%>
			<%end if%>
			<%if session("cf_useCashcard") then%>
        <input type="button" onClick="usecard(0)" class="btn"
         name="useCashcard"
         id="useCashcard" value="使用充值卡" />
			<%end if%>
      <input name="resets" type="button" id="resets" accesskey="x" onClick="javascript:window.returnValue=0;window.close();" class="btn" value="取消(X)"></td>
    </tr>
  </table>
<table width="380" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#ECD4D0" bordercolordark="#FFFFFF">
  <tr>
    <td>付款方式</td>
  </tr>
</table>
<table width="380" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#ECD4D0" bordercolordark="#FFFFFF">
<%sql="select lookname,lookcode from j18_lookupsub where lookupid='1002' order by lookcode"
ds.open sql,cn,1,1
i=1
do while not ds.eof
if ds(0)="现金" then
i=i+1

%>
  <tr>
    <td align="right"><%=ds(0)%>：</td>
    <td><input name="n1" type="text" id="n" value="<%=(ys-csyh-dk_price)%>" size="7" maxlength="10"
    onchange="this.value=renull(this.value);" 
     onKeyDown="return b3(this);" onBlur="ontxtblur();" onClick="this.select();">
      <input name="retype1" type="hidden" id="retype1" value="<%=ds(0)%>"></td>
  </tr>
<%
elseif ds(0)="充值卡" then
	if session("cf_useCashcard") then
	i=i+1
	%>
		<tr>
			<td align="right"><%=ds(0)%>：</td>
			<td align=left><input name="n<%=i%>" type="text"   id="cashcard" size="7" maxlength="10" readonly="readonly">
				<input type="hidden" name="retype<%=i%>" value="<%=ds(0)%>"></td>
		</tr>
	<%end if
elseif ds(0)="积分抵扣" then
	if session("cf_VipSet_jfdx") then
	i=i+1
	%>
		<tr>
			<td align="right"><%=ds(0)%>：</td>
			<td align=left><input name="n<%=i%>" type="text" id="cashjf" size="7" maxlength="10" value="<%=dk_price%>" readonly="readonly" >
				<input type="hidden" name="retype<%=i%>" value="<%=ds(0)%>"><span id="cashjfText" class="red"><%=dk_centum%></span></td>
		</tr>
	<%end if
else
i=i+1
%>
  <tr>
    <td width="140" align="right"><%=ds(0)%>：</td>
    <td align=left><input name="n<%=i%>" type="text" id="n" size="7" maxlength="10" 
     onClick="this.select();"  onKeyUp="changecash(this);" onChange="this.value=renull(this.value);">
      <input type="hidden" name="retype<%=i%>" value="<%=ds(0)%>"></td>
  </tr>
<%
end if
ds.movenext
loop
ds.close
i=i+1
ds.open "select retype,sums from webtmp_skfs where retailid='"&retailid&"'",cn,1,1
if not ds.eof then%>
  <tr>
    <td width="140" align="right"><%=ds(0)%>：</td>
    <td width="279"><input name="n<%=i%>" type="text" id="n" size="7" maxlength="10" onKeyDown="return b3(this);" onClick="this.select();" value="<%=ds(1)%>" readonly>
      <input type="hidden" name="retype<%=i%>" value="<%=ds(0)%>"></td>
  </tr>
<%end if
ds.close%>
  <!--<tr>
    <td align="right">尚未分配：</td>
    <td><input name="lost" type="text" id="lost" style="border:none; " value="<%=ys%>" size="5" maxlength="10">
      </td>
  </tr>-->
</table>
<input name="rows" type="hidden" id="rows" value="<%=i%>">
</form>
<%set ds=nothing%>
<script language="javascript">
function ol(){
  document.form1.ss.select();
}
var wh=300+25*<%=i%>;
window.dialogHeight=wh+"px";
//window.height=wh+"px";
</script>
</body>
</html>
