<%Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache"%>
<!--#include file="inc/function.asp" -->
<%id=request("id")
action=request("action")
act=request("act")
select case action
case "edit" edit()
case "del" del()
case else main()
end select

sub main()
strPathInfo = Request.ServerVariables("PATH_INFO")
strPathInfo = "http://" & Request.ServerVariables("SERVER_NAME") & ":"& request.ServerVariables("SERVER_PORT") & Left(strPathInfo,InstrRev(strPathInfo,"/"))
set rs=server.createobject("adodb.recordset")
sql="select *,isnull(chargesums,0) as chargesums,isnull(xj_price,0) as xj_price,isnull(jf_price,0) as jf_price,isnull(centum,0) as centum "&_
				"from j_productmaintain where productid='"&id&"'"
rs.open sql,cn,1,1%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>产品维修明细</title>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
.f12 {
	font-size:12px;
}
input{border:solid 1px #999;}
</style>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
</head>
<script>
function check(theform)
{if(theform.accept_dname.value==''){alert('受理店铺不能为空！');return false;}
if(theform.accept_date.value==''){alert('受理日期不能为空！');return false;}
if(theform.retailname.value==''){alert('顾客姓名不能为空！');return false;}
if(theform.retailname.value==''){alert('货品编码不能为空！');return false;}
if(theform.c_name.value==''){alert('颜色不能为空！');return false;}
if(isNaN(theform.s_price.value)){alert('购买价格类型错误！');return false;}
return true;}

function tj(a,t)
{document.form1.action='?id=<%=id%>&action='+a+'&act=<%=act%>&t='+t;
 if(t!=3)
   {if(check(document.form1))document.form1.submit();}
 else{document.form1.submit();}
}

function checkclothingid(name1,name2)
{
    var objXMLHTTP=new ActiveXObject("MICROSOFT.XMLHTTP");
	var url = "<%=strPathInfo%>" + "product_pos.asp?clothingid=" + name1.value +"&action=check";
	//alert(url);
	objXMLHTTP.open("GET",url,false);
	objXMLHTTP.send();
	var strReturn=objXMLHTTP.ResponseText;
	if (strReturn=="no")
	   {alert("没有此货号，请重新输入！");
	    name1.value="";
		name2.value="";
		name1.focus();}
	else
	   {name2.value=strReturn;}
}
function jfCard(){

		var v = document.getElementById('vipcode');
		var c = document.getElementById('chargesums');
		var jf=document.getElementById('jf_price');
		var xj = document.getElementById('xj_price');
		var jn = document.getElementById('centum');
		var sm=showModalDialog('pos_cashjf.asp?ys='+c.value+'&xvipcode='+v.value,'jf','dialogWidth:300px;dialogHeight:280px;center:yes;help:no;resizable:no;status:no');
		if(sm){
			var a = sm.split('{$}');
			if(a.length==3){
				v.value = a[0];		//VIP卡号
				var c = parseFloat(xj.value) + parseFloat(jf.value) - parseFloat(a[1]);
				xj.value = c.toFixed(2);			//现价
				jf.value = parseFloat(a[1]).toFixed(2);	//积分兑换的金额
				jn.value=a[2]
				document.getElementById('jfText').innerText = a[2]+'积分';
			}
		}else{
			v.value="";
			var c = parseFloat(xj.value) + parseFloat(jf.value);
			xj.value = c.toFixed(2);
			jf.value = "0.00";	//积分兑换的金额
			jn.value="0"
			document.getElementById('jfText').innerText = "";
		}
}

</script>
<script language="javascript" src="inc/js/setday.js"></script>
<body>
<form name="form1" method="post" onSubmit="return check(this)">
  <table width="100%" border="0" align="center" class="bar">
    <tr> 
      <td colspan="8" align="center">产 品 维 修 明 细</td>
    </tr>
  </table>
	<%if act=1 then
	 types=" "
	 types2=" "
	  else 
	 types=" readonly=readonly "
	 types2=" disabled=disabled "
	  end if%>
	<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="box1">
    <tr> 
      <td align="right">区域：</td>
      <td><input name="areaname" type="text" size="12" value="<%=rs("areaname")%>" class="chkbox" readonly></td>
      <td align="right">受理店铺：</td>
      <td><input name="accept_dname" type="text" size="12" class="chkbox"  value="<%=rs("accept_depotid")%>" readonly></td>
      <td align="right">受理日期：</td>
      <td><input name="accept_date" id="accept_date" type="text" size="12" class="chkbox" onFocus="setday(this)"  value="<%=rs("accept_date")%>" readonly <%=types%>></td>
      <td align="right">顾客姓名：</td>
      <td><input name="retailname" type="text" size="12" class="chkbox" <%=types%> value="<%=rs("retailname")%>" onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
      <td align="right">货品编码：</td>
      <td><input name="clothingid" type="text" size="12" class="chkbox" value="<%=rs("clothingid")%>" <%=types%> onKeyDown="if(event.keyCode==13){event.keyCode=9;checkclothingid(this,document.form1.c_name)}"></td>
      <td align="right">颜色：</td>
      <td><input name="c_name" type="text" size="12" class="chkbox" value="<%=rs("c_name")%>" readonly onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">货品型号：</td>
      <td><input name="st_xh" type="text" size="12" class="chkbox" value="<%=rs("st_xh")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">购买价格：</td>
      <td><input name="s_price" type="text" size="12" class="chkbox" value="<%=rs("s_price")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
      <td align="right">购买日期：</td>
      <td><input name="buy_date" type="text" size="12" class="chkbox" onFocus="setday(this)" value="<%=rs("buy_date")%>" readonly <%=types%>></td>
      <td align="right">新旧程度：</td>
      <td><input name="newold" type="text" size="12" class="chkbox" value="<%=rs("newold")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">维修时限：</td>
      <td><input name="repairday" type="text" size="12" class="chkbox" value="<%=rs("repairday")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">紧急程度：</td>
      <td><input name="exigence" type="text" size="12" class="chkbox" value="<%=rs("exigence")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
      <td align="right">维修内容：</td>
      <td colspan="5"><input name="repairtext" type="text" class="chkbox" id="repairtext" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("repairtext")%>" size="65" maxlength="66" <%=types%>></td>
      <td align="right">登记日期：</td>
      <td><input name="setchk_date" type="text" size="12" class="chkbox" value="<%=rs("setchk_date")%>" disabled onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
	<tr> 
      <td align="right">运输方式：</td>
      <td><input name="retype" type="text" size="12" class="chkbox" value="<%=rs("retype")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
	  <td align="right">运输公司：</td>
      <td colspan="5"><input name="recompany" type="text" size="60" class="chkbox" value="<%=rs("recompany")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
	  <td align="right">提货电话：</td>
      <td><input name="retel" type="text" size="12" class="chkbox" value="<%=rs("retel")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">提货地址：</td>
      <td colspan="5"><input name="readd" type="text" size="60" class="chkbox" value="<%=rs("readd")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
    <tr> 
	  <td align="right">收货人：</td>
      <td><input name="rename" type="text" size="12" class="chkbox" value="<%=rs("rename")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
      <td align="right">收货电话：</td>
      <td colspan="5"><input name="renametel" type="text" size="12" class="chkbox" value="<%=rs("renametel")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>   
    </tr>
    <tr> 
      <td align="right">退回意见：</td>
      <td colspan="7"><input name="retext" type="text" size="87" class="chkbox" value="<%=rs("retext")%>" <%=types%> onKeyDown="if(event.keyCode==13)event.keyCode=9"></td>
    </tr>
  </table>
<%if act<>1 then 
	  types="readonly=readonly"%>
    <br><strong>工厂维修结果</strong>
	<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="label1">
    <tr> 
      <td align="right">质量检测内容：</td>
      <td><input name="qualitytext" type="text" class="chkbox" id="qualitytext" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("qualitytext")%>" size="70" <%=types%>></td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align="right">处理意见：</td>
      <td><input name="taketext" type="text" class="chkbox" id="taketext" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("taketext")%>" size="70" <%=types%>></td>
      <td align="center"><input type="button" class="btn" onClick="showModalDialog('show_photo.asp?action=product&id=<%=id%>','pic','dialogWidth:500px;dialogHeight:500px;center:yes;help:no;resizable:yes;status:no');" value="查看图片"></td>
    </tr>
    <tr> 
      <td align="right">检测异议：</td>
      <td><input name="takedissent" type="text" class="chkbox" id="takedissent" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("takedissent")%>" size="70" <%=types%>></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3"><table width="100%"  border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
          <td align="right" class="f12">处理方式：</td>
          <td class="f12"><%call showtake(rs("taketype"),types2,"taketype")%></td>
          <td align="right" class="f12">是否收费：</td>
          <td class="f12"><input type="checkbox" name="charge" <%if rs("charge") then response.write("checked") end if%> <%=types2%> style="border:none"></td>
          <td align="right" class="f12">收费内容：</td>
          <td class="f12"><input name="chargetext" type="text" class="chkbox" id="chargetext" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("chargetext")%>" size="25" <%=types%>></td>
          <td align="right" class="f12">收费金额：</td>
          <td class="f12"><input name="chargesums" type="text" class="chkbox" id="chargesums" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("chargesums")%>" size="15" <%=types%>></td>
        </tr>
        
      </table></td>
      </tr>
  </table>
<%end if
%>
  <table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#ECD4D0" bordercolorlight="#FFFFFF" class="box1">

<%
	if act=0 or act=3 or act=4 then
	if act=3 then
	 types=" "
	 types2=" "
	  else 
	 types=" readonly=readonly "
	 types2=" disabled=disabled "
	  end if%>
  
  
    <br><strong>客户验收结果</strong>
    <tr> 
      <td align="right">收货日期：</td>
      <td><input name="sure_date" type="text" disabled class="chkbox" id="sure_date" value="<%=rs("sure_date")%>" size="15" ></td>
      <td align="right">对产品满意度：</td>
      <td><%call showmy(rs("my1"),types2,"my1")%></td>
      <td align="right">对服务满意度：</td>
      <td><%call showmy(rs("my2"),types2,"my2")%></td>
    </tr>
    <tr>
      <td align="right" class="f12">实收现金：</td>
      <td class="f12"><input name="xj_price" type="text" class="chkbox" id="xj_price" value="<%=cdbl(rs("chargesums"))-cdbl(rs("jf_price"))%>" size="15" readOnly="readOnly"></td>
      
      <td align="right"><span class="f12">积分抵扣现金：</span></td>
      <td colspan="3"><span class="f12">
        <input name="jf_price" type="text" class="chkbox" id="jf_price" value="<%=rs("jf_price")%>" size="10" readOnly="readOnly">
        <span id="jfText" style="color:red"><%
				if cdbl(rs("centum"))>0 then
					response.write rs("centum")&"积分"
				end if
				%></span>
        <%if session("cf_VipSet_wxdx") then%>
        <input type="button" class="btn" onClick="jfCard()"  value="积分抵扣" <%=types2%>>
        <%end if%>
				<input name="centum" type="hidden" id="centum" value="<%=rs("centum")%>">
        <input name="vipcode" type="hidden" id="vipcode" value="">
      </span></td>
      
    </tr>
    <tr> 
      <td align="right">客户建议：</td>
      <td colspan="5"><input name="clienttext" type="text" class="chkbox" id="clienttext" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=rs("clienttext")%>" size="70" <%=types%>></td>
    </tr>
	<%end if
	if act=1 or act=3 then
	if act=1 then
	str="马上提交"
	else
	str="客户验收"
	end if
	%>
	<tr align="center"> 
      <td colspan="6">
      <input name="Submit" type="button" class="btn" onClick="tj('edit',1)" value=" 保存内容 ">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <input name="Submit2" type="button" class="btn" onClick="tj('edit',2)" value="<%=str%>">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <%if act=1 then%>
	  <input name="Submit2" type="button" class="btn" onClick="tj('del',3)" value="  删  除  ">
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <%end if%>
	  <input name="Submit2" type="button" class="btn" onClick="window.close();" value="  关  闭  "></td>
    </tr>
	<%else%>
	<tr align="center"> 
      <td colspan="6"><input name="Submit2" type="button" class="btn" onClick="window.close();" value="  关  闭  "></td>
    </tr>
	<%end if%>
  </table>
</form>
<script type="text/javascript">
function window.onload(){
var ipt=document.getElementsByTagName('INPUT')
	for(i=0;i<ipt.length;i++){
		if(ipt[i].type=='text'&&(ipt[i].readOnly||ipt[i].disabled)){
			ipt[i].style.background='#efefef'
		}
	}
}
</script>
</body>
</html>
<%rs.close
set rs=nothing
end sub

sub showmy(a,b,c)
with response 
  .write("<select name='"&c&"' size=1 "&b&"><option></option>")
  .write("<option value='非常满意' ")
  if "非常满意"=trim(a) then .write("selected") end if
  .write(">非常满意</option>")
  .write("<option value='满意' ")
  if "满意"=trim(a) then .write("selected") end if
  .write(">满意</option>")
  .write("<option value='一般' ")
  if "一般"=trim(a) then .write("selected") end if
  .write(">一般</option>")
  .write("<option value='不满意' ")
  if "不满意"=trim(a) then .write("selected") end if
  .write(">不满意</option>")
  .write("</select>")
end with
end sub

sub showtake(a,b,c)
with response 
  .write("<select name='"&c&"' size=1 "&b&"><option></option>")
  .write("<option value='正常维修' ")
  if "正常维修"=trim(a) then .write("selected") end if
  .write(">正常维修</option>")
  .write("<option value='不可维修退货' ")
  if "不可维修退货"=trim(a) then .write("selected") end if
  .write(">不可维修退货</option>")
  .write("<option value='未检出问题返回' ")
  if "未检出问题返回"=trim(a) then .write("selected") end if
  .write(">未检出问题返回</option>")
  .write("</select>")
end with
end sub

sub edit()
t=request("t")
if act=1 then
accept_date=request("accept_date")
retailname=request("retailname")
clothingid=request("clothingid")
c_name=request("c_name")
st_xh=request("st_xh")
if request("s_price")="" then s_price=0 else s_price=request("s_price") end if
buy_date=request("buy_date")
newold=request("newold")
repairday=request("repairday")
exigence=request("exigence")
repairtext=replace(request("repairtext"),"'","")
retype=request("retype")
recompany=request("recompany")
retel=request("retel")
readd=request("readd")
rename=request("rename")
renametel=request("renametel")
retext=replace(request("retext"),"'","")
   if t=1 then
      s1="update j_productmaintain set accept_date='"&accept_date&"',retailname='"&retailname&"',clothingid='"&clothingid&_
	     "',c_name='"&c_name&"',st_xh='"&st_xh&"',s_price="&s_price&",buy_date='"&buy_date&"',newold='"&newold&_
		 "',repairday='"&repairday&"',exigence='"&exigence&"',repairtext='"&repairtext&"',retype='"&retype&"',recompany='"&recompany&"',"&_
		 "retel='"&retel&"',readd='"&readd&"',rename='"&rename&"',renametel='"&renametel&"',retext='"&retext&"' where productid='"&id&"'"
	  s2="保存成功！"
   else
      s1="update j_productmaintain set accept_date='"&accept_date&"',retailname='"&retailname&"',clothingid='"&clothingid&_
	     "',c_name='"&c_name&"',st_xh='"&st_xh&"',s_price="&s_price&",buy_date='"&buy_date&"',newold='"&newold&_
		 "',repairday='"&repairday&"',exigence='"&exigence&"',repairtext='"&repairtext&"',setchk_sure=1,setchk_date=getdate(),"&_
		 "retype='"&retype&"',recompany='"&recompany&"',retel='"&retel&"',readd='"&readd&"',rename='"&rename&"',"&_
		 "renametel='"&renametel&"',retext='"&retext&"',set_sure=1,setsure_date=getdate() where productid='"&id&"'"
	  s2="提交成功！"
   end if
   'response.Write(s1)
   'response.End()
   cn.execute s1
   response.write("<script>alert('"&s2&"');window.parent.location.reload();window.close();</script>")
end if

if act=3 then
   my1=request("my1")
   my2=request("my2")
   clienttext=request("clienttext")
	 
	xj_price=request("xj_price")
	jf_price=request("jf_price")
	centum=request("centum")
	vipcode=request("vipcode")

	 
   if t=1 then
       s1="update j_productmaintain set xj_price="&xj_price&",jf_price="&jf_price&",centum="&centum&",vipcode='"&vipcode&"',"&_
					"my1='"&my1&"',my2='"&my2&"',clienttext='"&clienttext&"' where productid='"&id&"'"
	  s2="保存成功！"
   else
      s1="update j_productmaintain set xj_price="&xj_price&",jf_price="&jf_price&",centum="&centum&",vipcode='"&vipcode&"',"&_
					"my1='"&my1&"',my2='"&my2&"',clienttext='"&clienttext&"',sure=1,sure_date=getdate() where productid='"&id&"'"
			s3="update vip_user set centum=centum-"&centum&" where vipcode='"&vipcode&"'"
			cn.execute(s3)
	  s2="提交成功！"
   end if
   cn.execute s1
   response.write("<script>alert('"&s2&"');window.parent.location.reload();window.close();</script>")
end if
end sub

sub del()
cn.execute "delete from j_productmaintain where productid='"&id&"'"
response.write("<script>alert('删除成功！');window.parent.location.reload();window.close();</script>")
end sub%>