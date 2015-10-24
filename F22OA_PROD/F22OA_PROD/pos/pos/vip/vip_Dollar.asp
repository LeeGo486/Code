<%session("formid")=6101029%>
<!--#include file="../f22/inc/function.asp"-->
<%
if not padd then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"你没有该功能的使用权限！</center>"
	response.End()
end if
vipcode=ucase(request.QueryString("vipcode"))
act=request("act")
id=request.QueryString("id")
num=request.QueryString("num")

key=trim(request("key"))
key = RemoveHTML(key)
comment=trim(request("comment"))
comment = RemoveHTML(comment)

%>
<%if vipcode="" or isnull(vipcode) then %>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
    <form action="?" method="get" name="form2" target="is">
    <input type="hidden" value="true" name="inputvip" />
        <tr>
          <td>输入VIP卡号：<input <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> name="vipcode" id="vipcode" size="32" onFocus="this.select()"
           onKeyDown="if(event.keyCode==13){this.form.submit1.click();event.returnValue=false;}" 
           onKeyUp="if(this.value){this.form.submit1.disabled=false}else{this.form.submit1.disabled=true}" />
           <input type="submit" name="submit1" id="submit1" value="提交" disabled="disabled"></td>
        </tr>
    </form>
  </table>
<iframe name="is" id="is" width="100%" height="90%" frameborder="0" src="about:blank" onload="document.getElementById('vipcode').value=''"></iframe>
<%
response.End()
end if%>

<%
tmptab=" webtmp_dollar "
set rs=server.CreateObject("adodb.recordset")
set rs2=server.CreateObject("adodb.recordset")

sql = chkvip(vipcode,0)
rs.open sql,cn,1,1
if rs.eof and rs.bof then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>该会员卡已失效或过期，不允许使用积分换购功能</center>"
	response.End()
else
	centum=request("centum")
	if centum<>"1" then
	 hgfs=rs("centum")	'总积分
	else
	 hgfs=rs("pcentum")	'上季积分
	end if
end if
rs.close

if act<>"" then
	if act="del" then
		cn.execute("delete from "&tmptab&" where clothingid="&qts(id)&" and depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0")
	elseif act="upd" and num<>"" then
		cn.execute("update "&tmptab&" set nums="&num&" where clothingid="&qts(id)&" "&_
					" and depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0")
	elseif act="cancel" then
		cn.execute("delete from "&tmptab&" where depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0")
	end if
	response.Redirect("?vipcode="&vipcode&"&centum="&centum&"&comment="&comment&"")
end if

%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>积分换购</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script>
function chkform(t){
if(t.key.value.length<=0){
return false;
}
return true;
}

function reform(){
	document.getElementById('act').value='cancel';
	document.getElementById('form1').submit();
}
function ck(t,v){
	location.href='?vipcode=<%=vipcode%>&act=upd&num='+v+'&id='+t+'&centum=<%=centum%>&comment=<%=comment%>'
}
function cho(){
  var m=showModalDialog("vip_dollarsub.asp?hgfs=<%=hgfs%>",window,"dialogWidth:650px;dialogHeight:390px;center: yes;help:no;resizable:no;status:no");
	if(m){
		document.getElementById("key").value=m;
		document.getElementById("form1").submit();		
	}
}
function checkout(){
	var comment=document.getElementById('comment').value;
	
	showModalDialog("vip_dollarcheckout.asp?centum=<%=centum%>&hgfs=<%=hgfs%>&vipcode=<%=vipcode%>&comment="+comment,window,"dialogWidth:350px;dialogHeight:230px;center: yes;help:no;resizable:no;status:no");
		location.href='?vipcode=<%=vipcode%>&hgfs=<%=hgfs%>&centum=<%=centum%>&comment='+comment
}
function window.onload(){
	document.getElementById('key').focus();
}
</script>
</head>
<body>
<%if request("inputvip")="true" then %>
<center><p style="padding:10px;margin:0;">积分换购</p></center>
<%end if%>
<form name="form1" id="form1" method="post" action="?vipcode=<%=vipcode%>" onSubmit="return chkform(this)">
<input type="hidden" name="act" id="act" value="" />
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    <tr>
      <td width="70" align="right">VIP卡号：</td>
      <td><input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" value="<%=vipcode%>" size="22" readonly=readonly style='background:#efefef;' ></td>
      <td width="70" align="right">换购方式：</td>
      <td><label for="centum"><input type="radio" id="centum" name="centum" value="0" onClick="reform()"
       <%if centum<>"1" then response.write "checked=checked"%> >
        总积分</label>
        <label for="pcentum"><input type="radio" id="pcentum" name="centum" value="1" onClick="reform()"
         <%if centum="1" then response.write "checked=checked"%> >
        上季积分</label></td>
    </tr>
    <tr>
      <td align="right">货　号：</td>
      <td><input name="key" type="text" id="key" size="20" maxlength="30" autocomplete="off" value="">
      <input type="submit" name="search" id="search" value="添加">
      <input type="button" name="search2" id="search2" value="选择..." onClick="cho()"></td>
      <td align="right">换购备注：</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="30" maxlength="255"></td>
    </tr>
	</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    <td height="260" valign="top">
<%
if instr(key,",")>0 then
keys=split(key,",")
	for i = 0 to ubound(keys)-1
		'如果传过来的有多个值，则使用此多个插入方法
		addstyle trim(keys(i)),hgfs,tmptab
	Next
else
	addstyle key,hgfs,tmptab
end if


function addstyle(ikey,hgfs,tmptab)
	sql = "select a.clothingid,b.styleid,b.colorid,a.sizeid,isnull(b.buycentum,0) as buycentum,isnull(b.dcentum,0) as dcentum,"&_
				" isnull(b.price,0) as price,b.begdate,b.enddate,isnull(c.k_num,0) as k_num from j_clothing a,vip_stycentum b,j_stock c "&_
				" where a.styleid=b.styleid and a.colorid=b.colorid and b.depotid="&qts(session("dm").System_DepotId)&""&_
				" and convert(char(10),getdate(),126)>=convert(char(10),b.begdate,126) "&_
				" and convert(char(10),getdate(),126)< convert(char(10),b.enddate,126) "&_
				" and "&hgfs&">=isnull(b.dcentum,0) and isnull(b.dcentum,0)<>0 "&_
				" and b.styleid+b.colorid=substring("&qts(ikey)&",1,len(b.styleid)+len(b.colorid)) "&_
				" and a.clothingid*=c.clothingid and c.depotid="&qts(session("dm").System_DepotId)&_
				" and a.clothingid="&qts(ikey)&" "
	rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		'如果查询到有此商品
		if key<>"" then response.write "<script>alert('货品不存在或不在所需积分范围内！')</script>"
	else
		
		'如果存在
		rs2.open "select clothingid from "&tmptab&" where clothingid="&qts(ikey)&" "&_
				 " and depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0",cn,1,1
		if rs2.eof and rs2.bof then
			sql="insert into "&tmptab&" (depotid,vipcode,clothingid,styleid,colorid,sizeid,nums,kc,buycentum,dcentum,price,begdate,enddate,dtype) "&_
									"values ("&qts(session("dm").System_DepotId)&","&qts(vipcode)&","&qts(rs("clothingid"))&","&qts(rs("styleid"))&","&_
										qts(rs("colorid"))&","&qts(rs("sizeid"))&",1,"&rs("k_num")&","&rs("buycentum")&","&rs("dcentum")&","&_
										rs("price")&","&qts(rs("begdate"))&","&qts(rs("enddate"))&",0)"
		else
			sql="update "&tmptab&" set nums=nums+1 where clothingid="&qts(ikey)&" "&_
				" and depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0"
		end if
			cn.execute(sql)
		rs2.close
	end if
	rs.close
end function



rs.open "select clothingid as 款号,styleid as 款式,colorid as 颜色,sizeid as 尺码,nums as 数量,kc as 目前库存,buycentum as 消费积分,dcentum as 换购积分,price as 费用,begdate as 开始日期,enddate as 结束日期 from "&tmptab&" where depotid="&qts(session("dm").System_DepotId)&" and vipcode="&qts(vipcode)&" and dtype=0"
if not rs.eof and not rs.bof then
response.write "<table cellspacing=1 cellpadding=3 width='100%' style='background:#CCC;margin:10px 0;'>"
	response.write "<tr>"
	for i = 0 to rs.fields.count-1
	
		names = rs(i).name
		if len(names)=4 then names=left(names,2)&"<br>"&right(names,2)
	response.write "<TD style='background:#efefef' align=center>"&names&"</TD>"
	Next
			response.write "<TD style='background:#efefef'>操作</TD>"
	response.write "</tr>"
do while not rs.eof
	response.write "<tr>"
		for i = 0 to rs.fields.count-1
			if i=4 then 
			response.write "<TD style='background:#FFF' align=center>"&_
					"<input type=text name='"&rs(0)&"' id='"&rs(0)&"' style='width:40px' "&_
					" value="&RemoveHTML(rs(i))&" onchange='ck(this.id,this.value)'></TD>"
			else
			response.write "<TD style='background:#FFF' align=center>"&RemoveHTML(rs(i))&"</TD>"
			end if
		Next
			response.write "<TD style='background:#FFF'><a href='?act=del&id="&rs(0)&"&vipcode="&vipcode&"&comment="&comment&"&centum="&centum&"' >移除</a></TD>"
			'onclick=""if(confirm('确定移除吗？')==false){return false}""
	response.write "</tr>"
rs.movenext
loop
	response.write "</table>"
	disabled=false
else
	disabled=true
end if
rs.close
set rs2=nothing
set rs=nothing
%>
    </td>
   </tr>
	</table>
	<table width="100%"  cellpadding="0" cellspacing="1" > 
    <tr>
      <td align="center"><input type="submit" name="Submit" value="　换　　购　"
       onClick="checkout()"
        <%if disabled then response.write "disabled=disabled"%>>
      &nbsp;
      <input type="button" name="delall" value="清　空"
       onclick="if(confirm('确定清空吗？')==true){reform()}"
       <%if disabled then response.write "disabled=disabled"%>></td>
    </tr>
  </table>
</form>
</body>
</html>
