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
'de clothingid
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
  return true;
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
}

function tj(t){
  document.form1.action='?action=add&t='+t;
  if(check(document.form1))document.form1.submit();
}

function okd(){
  var k=event.keyCode;
  var v=document.form1.s_price.value;
  var d=document.form1.discount.value;
  //alert(k);
  if((k>=48 && k <=57)||(k>=96 && k <=105)){
    //alert(event.keyCode);
  }else if(k==8 || k ==46 || k==189 || k==190 || k==110){
    //return event.keyCode;
  }else if(k==13){
   if(v!="" && d!=""){
	 v=parseFloat(v,2);
	 d=parseFloat(d,2);
	 var vd=v*d;
	 vd=vd.toString();
	 vd=vd.substring(0,4);
	 document.form1.ys.value=vd;
   }
  }else{
    //alert(event.keyCode);
    return false;
  }
}
</script>
<script language="javascript" src="../inc/js/setday.js"></script>
<body>
<form name="form1" method="post" onsubmit="return check(this)">
<%
%>
  <table width="600" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="f12">
  <tr class="label"> 
    <td width="57" align="right">区&nbsp;&nbsp;&nbsp;&nbsp;域:</td>
    <td width="133"><input name="areaname" type="text" size="15" value="<%=getarea%>" class="chkbox" readonly></td>
    <td width="67" align="right">受理店铺:</td>
    <td width="117"><input name="accept_dname" type="text" size="15" class="chkbox" value="<%=session("dm").System_DepotName%>" readonly></td>
    <td width="63" align="right">受理日期:</td>
    <td width="149"><input name="accept_date" id="accept_date" type="text" size="15" class="chkbox" onFocus="setday(this)" value="<%=get_date(date)%>" readonly>
    </td>
  </tr>
  <tr class="label"> 
    <td align="right">货品编码:</td>
    <td><input name="clothingid" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13){event.keyCode=9;checkclothingid(this,document.form1.styleid,document.form1.c_name)}" value="<%=clothingid%>"></td>
    <td align="right">货品型号:</td>
    <td><input name="styleid" type="text" class="chkbox" id="styleid" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="15" value="<%=styleid%>"></td>
    <td align="right">颜&nbsp;&nbsp;&nbsp;&nbsp;色:</td>
    <td><input name="c_name" type="text" size="15" class="chkbox" readonly onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=c_name%>"></td>
  </tr>
  <tr class="label"> 
    <td align="right">购买价格:</td>
    <td><input name="s_price" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=s_price%>"></td>
    <td align="right">零售价:</td>
    <td><input name="x_price" type="text" id="x_price" size="15" value="<%=x_price%>"></td>
    <td align="right">购买日期:</td>
    <td><input name="buy_date" type="text" size="15" class="chkbox"  onFocus="setday(this)" value="<%=setdate%>" readonly ></td>
  </tr>
  <tr>
    <td align="right">顾客姓名:</td>
    <td><input name="retailname" type="text" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9" size="15" maxlength="12"></td>
    <td align="right">联系方式:</td>
    <td><input name="tel" type="text" id="tel" size="15" maxlength="30"></td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="right">退货折扣:</td>
    <td><input name="discount" type="text" id="discount" value="1" size="15" maxlength="12" onKeyDown="return okd();"></td>
    <td align="right">应付金额:</td>
    <td><input name="ys" type="text" id="ys" value="<%=s_price%>" size="15" maxlength="12" readonly></td>
    <td align="right">新旧程度:</td>
    <td><input name="newold" type="text" size="15" class="chkbox" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
  </tr>
  <tr> 
      <td align="right">退货原因:</td>
      <td colspan="5"><textarea name="comment" cols="70" rows="6" class="chkbox" id="comment" onKeyDown="if(event.keyCode==13)event.keyCode=9"></textarea></td>
  </tr>
  <tr> 
    <td colspan="6" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        <input type="button" name="Submit" value=" 确  定 " onClick="tj(document.form1)">
      <input name="code" type="hidden" id="code" value="<%=code%>">      
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" name="Submit2" value=" 关  闭 " onClick="window.close();"></td></tr>
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
	if code<>"" then
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
	end if
	'de clothingid
	call show
end sub

sub add()
  retailid=trim(session("retailid"))
  'de retailid
  depotid=trim(session("dm").System_Depotid)
  clothingid=trim(request.form("clothingid"))
  styleid=trim(request.form("styleid"))
  
  comment=replace(request.form("comment"),"'","")
  code=trim(request.form("code"))
  'de code
  discount=trim(request.Form("discount"))
  call insertRsub(clothingid,code)
  response.write("<script>alert('添加成功！');window.close();</script>")
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
  response.write("此款号不存在")
else
  styleid=rs("styleid")
  c_name=rs("c_name")
end if
rs.close
set rs=nothing
call show
end sub


Sub insertRsub(clothingid,code)'款号
  dim ds,cd,sql,styleid,colorid,sizeid,sname,kc,c_name,zs,back,val
  dim sums
  zs=0
  back=1
  clothingid=ucase(clothingid)
  if clothingid<>"" then
	set ds=server.CreateObject("ADODB.RecordSet")
	ds.ActiveConnection = cn
	sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name from j_clothing a,j_style b where a.styleid=b.styleid and clothingid='"&clothingid&"'"
	ds.Source = sql '查货号
	
	ds.open
	if not ds.eof then
	  styleid=ds(0)
	  colorid=ds(1)
	  sizeid=ds(2)
	  sname=ds(3)
	  ds.close
	else
      ds.close
	  '没找到,把此ID作为款式编号来查
	  sql="select s_name from j_style where styleid='"&clothingid&"'"
	  ds.source = sql
	  ds.open
	  if not ds.eof then '查为款式编号,则弹出二维输入界面.
	    ds.close
		set ds=nothing
		call showinput(clothingid)
		response.end
	  else
	    ds.close
		set ds=nothing
	    call aClose("货号 " & clothingid &" 不存在!")
        response.End
	  end if
    end if
	
	
	sql="select p_num,k_num from j_stock where depotid='"&depotid&"' and clothingid='"&clothingid&"'"
	ds.source = sql '求库存
	ds.open
	if not ds.eof then
	  kc=ds("k_num")
	else
	  kc=0
	end if
	set ds=Nothing
  else
	call aClose("货号 不能为空!")
	response.End
  end if

	if styleid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  set cd=Server.CreateObject("ADODB.Command")
	  cd.ActiveConnection = cn
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getstyleprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@styleid", 200, 1, 34, styleid)
	  'cd.Parameters.Append cd.CreateParameter("@pricedate", adVarChar, adParamInput, 10, "")
	  'Response.End
	  Set ds = cd.Execute '求价格
  	  If ds.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  nums=-1
	  If IsNull(ds.Fields.Item("j_cost").value) Then
	    j_cost = "0"
	  Else
	    j_cost = CStr(ds.Fields.Item("j_cost").value)
	  End If
	  If IsNull(ds.Fields.Item("j_price").value) Then
	    j_price = "0"
	  Else
	    j_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("x_price").value) Then
	    x_price = "0"
	  Else
	    x_price = CStr(ds.Fields.Item("x_price").value)
	  End If
	  If IsNull(ds.Fields.Item("s_price").value) Then
	    s_price = "0"
	  Else
	    s_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("discount").value) Then
	    discount = "0"
	  Else
	    discount = CStr(ds.Fields.Item("discount").value)
	  End If
	  ds.Close	
	
	if zs=1 then
	  sums=trim(request.QueryString("sums"))
	  if not isnumeric(sums) then
	    sums=0
	  else
	    sums=cdbl(sums)
	  end if
	else
	  discount=cdbl(discount)
	  if discount=0 or discount=1 then
	    sums=x_price
	  elseif discount>1 then
	    call mbox("折扣必须小于1!")
	  else
	    s_price=x_price*discount
	    sums=s_price
	  end if
	  
	end if
	
	s_price=trim(request.Form("s_price"))
	if not isnumeric(s_price) then
	  s_price=0
	else
	  s_price=cdbl(s_price)
	end if
	discount=trim(request.Form("discount"))
	if not isnumeric(discount) then
	  discount=0
	else
	  discount=cdbl(discount)
	end if
	s_price=s_price*discount
	sums=s_price

	ds.LockType = 3
	sql="select * from webtmp_retailsub where retailid="&qts(retailid)&" and clothingid="&qts(clothingid)&" and zs="&zs&" and back="&back
	ds.Source = sql
	ds.Open
	'de getboxid()
    retailid=trim(session("retailid"))
	if ds.eof then
	  ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("nums")=nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=zs
	  ds("back")=back
	  ds("sums")=sums
	  ds("code")=code
	else
	  ds("styleid")=styleid
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("s_name")=sname
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  ds("x_price")=x_price
	  ds("nums")=ds("nums")+nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("sums")=cdbl(ds("sums"))+sums
	end if
	ds.Update
	ds.close
	  
  end if
	
	set ds=nothing
End Sub

function getboxid()
  dim ds,boxid,bid
  set ds=server.CreateObject("ADODB.RecordSet")
  ds.ActiveConnection = cn
  ds.Source = "Select top 1 boxid from d_retailsub where boxid like 'W_________' order by boxid desc"
  ds.open
  if not ds.eof then
    boxid=ds(0)
  else
    boxid="W000000000"
  end if
  ds.Close
  Set ds=nothing
  bid=right(boxid,9)
  bid=cdbl(bid)
  bid=bid+1
  boxid="000000000" &bid
  boxid=right(boxid,9)
  boxid="W" &boxid
  getboxid=boxid
end function

%>