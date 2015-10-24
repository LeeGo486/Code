<!--#include file="inc/function.asp" -->
<%
dim action,clothingid,styleid,s_price,x_price,c_name
action=request("action")
select case action
case "add" add()
case "check" check()
case else main()
end select

sub show()
strPathInfo = Request.ServerVariables("PATH_INFO")
strPathInfo = "http://" & Request.ServerVariables("SERVER_NAME") & ":"& request.ServerVariables("SERVER_PORT") & Left(strPathInfo,InstrRev(strPathInfo,"/"))
%>
<html>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>产品维修登记</title>
<base target="_self">
</head>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<script>
function check(theform){
  if(theform.accept_dname.value==''){alert('受理店铺不能为空！');return false;}
  if(theform.accept_date.value==''){alert('受理日期不能为空！');return false;}
  if(theform.retailname.value==''){alert('顾客姓名不能为空！');return false;}
  if(theform.retailname.value==''){alert('货品编码不能为空！');return false;}
  if(theform.c_name.value==''){alert('颜色不能为空！');return false;}
  if(isNaN(theform.s_price.value)){alert('购买价格类型错误！');return false;}
  return true;
}

function checkclothingid(name1,name3,name2){
    /*var objXMLHTTP=new ActiveXObject("MICROSOFT.XMLHTTP");
	//var url = "<%=strPathInfo%>" + "product_pos.asp?clothingid=" + name1.value +"&action=check";
	var url = "<%=strPathInfo%>" + "XmlHttp.asp?clothingid=" + name1.value +"&ns=check";
	objXMLHTTP.open("GET",url,false);
	objXMLHTTP.send();
	var strReturn=objXMLHTTP.ResponseText;
	if (strReturn=="no"){
		alert("没有此货号，请重新输入！");
		name2.value="";
	    name1.value="";
		name1.focus();
	}else{
		var sr=strReturn.split(",");
		name2.value=sr[0];
		name3.value=sr[1];
	}*/
	document.form1.action='?action=check'
	document.form1.submit();
}

function getcode(name1){
    var objXMLHTTP=new ActiveXObject("MICROSOFT.XMLHTTP");
	//var url = "<%=strPathInfo%>" + "product_pos.asp?clothingid=" + name1.value +"&action=check";
	var url = "<%=strPathInfo%>" + "XmlHttp.asp?code=" + name1.value +"&ns=code";
	//alert(url);
	objXMLHTTP.open("GET",url,false);
	objXMLHTTP.send();
	var s=objXMLHTTP.ResponseText;
	var t=document.form1;
	//document.write(strReturn);
	if (s=="no"){
		alert("此编码在系统销售记录中不存在，请确认后重新输入！");
	    //name1.value="";
		name1.focus();
	}else{
		s=s.split(",");
		t.clothingid.value=s[0];
		t.st_xh.value=s[1];
		t.c_name.value=s[2];
		t.s_price.value=s[3];
		t.x_price.value=s[4];
		t.buy_date.value=s[5];
	}
}

function tj(t){
  document.form1.action='?action=add&t='+t;
  if(check(document.form1))document.form1.submit();
}
</script>
<script language="javascript" src="../inc/js/setday.js"></script>
<body>
<form name="form1" method="post" onSubmit="return check(this)">
  <table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="f12">
  <tr class="label"> 
    <td align="right">区&nbsp;&nbsp;&nbsp;&nbsp;域：</td>
    <td><input name="areaname" type="text" size="15" value="<%=getarea%>" class="chkbox" readonly></td>
    <td align="right">受理店铺：</td>
    <td><input name="accept_dname" type="text" size="15" class="chkbox" value="<%=session("dm").System_DepotName%>" readonly></td>
    <td align="right">受理日期：</td>
    <td><input name="accept_date" id="accept_date" type="text" size="15" class="chkbox" onFocus="setday(this)" value="<%=get_date(date)%>" readonly>    </td>
  </tr>
  <tr class="label"> 
    <td align="right">货品编码：</td>
    <td><input name="clothingid" type="text" class="chkbox" onKeyDown="if(event.keyCode==13){event.keyCode=9;checkclothingid(this,document.form1.st_xh,document.form1.c_name)}" value="<%=clothingid%>" size="15"></td>
    <td align="right">货品型号：</td>
    <td><input name="st_xh" type="text" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=styleid%>" size="15" readonly></td>
    <td align="right">颜&nbsp;&nbsp;&nbsp;&nbsp;色：</td>
    <td><input name="c_name" type="text" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=c_name%>" size="15" readonly></td>
  </tr>
  <tr class="label"> 
    <td align="right">购买价格：</td>
    <td><input name="s_price" type="text" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=s_price%>" size="15"></td>
    <td align="right">零售价：</td>
    <td><input name="x_price" type="text" id="x_price" value="<%=x_price%>" size="15"></td>
    <td align="right">购买日期：</td>
    <td><input name="buy_date" type="text" size="15" class="chkbox"  onFocus="setday(this)" value="<%=get_date(date)%>" readonly></td>
  </tr>
  <tr>
    <td align="right">顾客姓名：</td>
    <td><input name="retailname" type="text" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="15" maxlength="12"></td>
    <td align="right">联系方式：</td>
    <td><input name="tel" type="text" id="tel" size="15" maxlength="30"></td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="right">新旧程度：</td>
    <td><input name="newold" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align="right">维修时限：</td>
    <td><input name="repairday" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    <td align="right">紧急程度：</td>
    <td><input name="exigence" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr> 
      <td align="right">维修内容：</td>
      <td colspan="5"><textarea name="repairtext" cols="70" rows="3" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></textarea></td>
  </tr>
  <tr> 
      <td align="right">运输方式：</td>
      <td><input name="retype" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
	  <td align="right">运输公司：</td>
      <td colspan="3"><input name="recompany" type="text" size="30" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
	  <td align="right">提货电话：</td>
      <td><input name="retel" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">提货地址：</td>
      <td colspan="3"><input name="readd" type="text" size="30" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
	  <td align="right">收货人：</td>
      <td><input name="rename" type="text" size="15" class="chkbox"  onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">收货电话：</td>
      <td colspan="3"><input name="renametel" type="text" size="15" class="chkbox"  onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>   
    </tr>
    <tr> 
      <td align="right">退回意见：</td>
      <td colspan="5"><input name="retext" type="text" size="60" class="chkbox"  onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
  <tr> 
    <td colspan="6" align="center"><input type="button" name="Submit" value=" 保 存 内 容 " onClick="tj(1)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" name="Submit2" value=" 马 上 提 交 " onClick="tj(2)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" name="Submit2" value="  关  闭  " onClick="window.close();"></td>
  </tr>
</table>
</form>
</body>
</html>
<%
set ds=nothing
end sub

sub main()
	dim ds,code,sql
	code=trim(request.QueryString("code"))
	'if code="" then response.End()
	set ds=server.CreateObject("ADODB.RecordSet")
	ds.ActiveConnection = cn
	sql= "select b.clothingid,b.styleid,c.c_name,b.s_price,b.x_price,a.setdate from d_retail a,d_retailsub b,j_color c where b.colorid=c.colorid and a.retailid=b.retailid and b.code="&qts(code)
	ds.Source = sql
	ds.Open
	if ds.eof then
	  ds.close
	  set ds=nothing
	  'call mbox("没有此销售记录,重确认后重新输入!")
	else
	  clothingid=ds("clothingid")
	  styleid=ds("styleid")
	  c_name=ds("c_name")
	  s_price=ds("s_price")
	  x_price=ds("x_price")
	  setdate=ds("setdate")
	  ds.close
	end if
	call show
end sub

sub add()
productid=getid("j_productmaintain","productid","PR",session("dm").System_UserId)
areaname=trim(request.form("areaname"))
accept_depotid=session("dm").System_DepotId
accept_date=trim(request.form("accept_date"))
retailname=trim(request.form("retailname"))
clothingid=trim(request.form("clothingid"))
c_name=trim(request.form("c_name"))
st_xh=trim(request.form("st_xh"))
if trim(request.form("s_price"))="" then s_price=0 else s_price=request("s_price") end if
buy_date=trim(request.form("buy_date"))
newold=trim(request.form("newold"))
repairday=trim(request.form("repairday"))
exigence=trim(request.form("exigence"))
repairtext=replace(request.form("repairtext"),"'","")
code=trim(request.form("code"))
tel=trim(request.Form("tel"))
retype=trim(request.Form("retype"))
recompany=trim(request.Form("recompany"))
retel=trim(request.Form("retel"))
readd=trim(request.Form("readd"))
rename=trim(request.Form("rename"))
renametel=trim(request.Form("renametel"))
retext=replace(request.form("retext"),"'","")

if request("t")=1 then
   s1="insert into j_productmaintain (productid,areaname,retailname,accept_date,accept_depotid,st_xh,"&_
      "clothingid,c_name,s_price,buy_date,newold,repairday,exigence,repairtext,code,tel,"&_
	  "retype,recompany,retel,readd,rename,renametel,retext) values "&_
      "('"&productid&"','"&areaname&"','"&retailname&"','"&accept_date&"','"&accept_depotid&"','"&st_xh&"',"&_
      "'"&clothingid&"','"&c_name&"',"&s_price&",'"&buy_date&"','"&newold&"','"&repairday&"','"&exigence&"',"&_
	  "'"&repairtext&"','"&code&"','"&tel&"','"&retype&"','"&recompany&"','"&retel&"','"&readd&"','"&rename&"','"&renametel&"','"&retext&"')"
   s2="保存成功！"
else
   s1="insert into j_productmaintain (productid,areaname,retailname,accept_date,accept_depotid,st_xh,"&_
      "clothingid,c_name,s_price,buy_date,newold,repairday,exigence,repairtext,setchk_sure,setchk_date,code,tel,"&_
	  "retype,recompany,retel,readd,rename,renametel,retext,set_sure,setsure_date) values "&_
      "('"&productid&"','"&areaname&"','"&retailname&"','"&accept_date&"','"&accept_depotid&"','"&st_xh&"',"&_
      "'"&clothingid&"','"&c_name&"',"&s_price&",'"&buy_date&"','"&newold&"','"&repairday&"','"&exigence&"',"&_
	  "'"&repairtext&"',1,getdate(),'"&code&"','"&tel&"','"&retype&"','"&recompany&"','"&retel&"','"&readd&"','"&rename&"','"&renametel&"','"&retext&"',1,getdate())"
   s2="提交成功！"
end if
cn.execute s1
response.write("<script>alert('"&s2&"');window.close();</script>")
end sub

function getarea
set rs=server.CreateObject("adodb.recordset")
rs.open "select b.shutname from j_depot a,j_area b where a.areaid=b.areaid and a.depotid='"&session("dm").System_DepotId&"'",cn
getarea=rs(0)
rs.close
set rs=nothing
end function

sub check()
'Response.ContentType = "text/xml"
'Response.CharSet = "GB2312"
clothingid=request("clothingid")
set rs=server.CreateObject("adodb.recordset")
rs.open "select b.c_name,a.styleid from j_clothing a,j_color b where a.clothingid='"&clothingid&"' and a.colorid=b.colorid",cn
if rs.eof then
  response.write("no")
else
  styleid=rs("styleid")
  c_name=rs("c_name")
end if
rs.close
set rs=nothing
call show
end sub
%>