<%session("formid")=6101028%>
<!--#include file="../f22/inc/function.asp"-->
<%
if not session("cf_VipSet_birthgift") then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"�˹���Ŀǰ�ѽ�ֹʹ�ã��������������������Ա��ϵ��</center>"
	response.End()
end if

if not padd then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"��û�иù��ܵ�ʹ��Ȩ�ޣ�</center>"
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

depotid=session("dm").System_DepotId

%>

<%if vipcode="" or isnull(vipcode) then %>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
    <form action="?" method="get" name="form2" target="is">
    <input type="hidden" value="true" name="inputvip" />
        <tr>
          <td>����VIP���ţ�<input <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> name="vipcode" id="vipcode" size="32" onFocus="this.select()"
           onKeyDown="if(event.keyCode==13){this.form.submit1.click();event.returnValue=false;}" 
           onKeyUp="if(this.value){this.form.submit1.disabled=false}else{this.form.submit1.disabled=true}" />
           <input type="submit" name="submit1" id="submit1" value="�ύ" disabled="disabled"></td>
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

'��֤
sql = chkvip(vipcode,0)
rs.open sql,cn,1,1
if rs.eof and rs.bof then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>��VIP����ʧЧ����ڣ��������е�ǰ����</center>"
	response.End()
end if
rs.close


if act="submit" then
'---------------------------------------------
	vipcode =request.Form("vipcode")
	
	userid=session("dm").System_UserId
	username = session("dm").System_UserName
	retailid=getid("d_retail","retailid","LS",userid)
	
	'����
	rs.open "select * from d_retail where 1=2",cn,1,3
	rs.addnew
		rs("retailid")=retailid
		rs("retail")=retailid
		rs("depotid")=depotid
		rs("vipcode")=vipcode
		rs("setdate")=now()
		rs("s_name")=username
		rs("x_name")=username
		rs("chk_name")=username
		rs("chk_date")=now()
		rs("cr_date")=now()
		rs("sure_date")=now()
		rs("sure_name")=username
		rs("cr_name")=username
		rs("dtype")=1
	rs.update
	rs.close
	
	'�ӱ�
	set rs2=server.CreateObject("adodb.recordset")
	sql="select clothingid,styleid,sizeid,colorid,nums"&_
			" from "&tmptab&" where depotid="&qts(depotid)&""&_
			" and vipcode="&qts(vipcode)&" and dtype=1"
	rs.open sql,cn,1,1
		do while not rs.eof
			sql="insert into d_retailsub (retailid, boxid, clothingid, styleid, sizeid, colorid, vipcardid,nums,larg,comment) "&_
					" values ("&_
					" "&qts(retailid)&","&getboxid()&","&_
					" "&qts(rs(0))&","&qts(rs(1))&","&_
					" "&qts(rs(2))&","&qts(rs(3))&","&_
					" "&qts(vipcode)&","&qts(rs(4))&",1,'��������')"
			cn.execute(sql)
		rs.movenext
		loop
	rs.close
	set rs2=nothing
	
	'���
	sql="update a set a.j_cost=b.j_cost,a.j_price=b.j_price,a.x_price=b.x_price,a.discount=0,a.s_price=0 "&_
		" from d_retailsub a,j_clothing b where a.clothingid=b.clothingid and a.retailid="&qts(retailid)
	cn.execute(sql)

	'�������
	sql=" update d_retail set chk_sure=1 where retailid="&qts(retailid)
	cn.execute(sql)
	
	'��������
	sql=" update d_retail set sure=1 where retailid="&qts(retailid)
	cn.execute(sql)
	
	'�����¼
	cn.execute("delete from "&tmptab&" where depotid="&qts(depotid)&" "&_
				" and vipcode="&qts(vipcode)&" and dtype=1")
	
	'��ʾ
	close "�������﷢�ųɹ������ţ�"&retailid
	
'---------------------------------------------
	
else

'---------------------------------------------
'���������
	'sql="select count(*) from d_retail where dtype=1 and vipcode="&qts(vipcode)&" and year(crdate)=year(getdate())"
	 sql=" select count(*) from d_retail  a "&_
		   "  inner join (select d.vipcardid from VIP_cardvip b inner join VIP_User c on b.vipcardid=c.vipcode"&_
		   "  inner join  VIP_cardvip d on d.vipid=c.vipid where b.vipcardid="&qts(vipcode)&") e on a.vipcode=e.vipcardid"&_
		   "  where dtype=1 and year(a.crdate)=year(getdate()) "
	rs.open sql,cn,1,1
	if not rs.eof and not rs.bof then
		if cdbl(rs(0))>=session("cf_Vip_giftSums") and session("cf_Vip_giftSums")>0 then
			response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>�û�Ա���겻�����������ˡ�</center>"
			response.End()
		end if
	end if
	rs.close

	
	sql = "select vipname,vipbirth from vip_user where vipcode="&qts(vipcode)&" and isnull(vipbirth,'')<>'' and year(vipbirth)<>'1950'"
	rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>�û�Աδ�ṩ������Ϣ���������д˹��ܡ�</center>"
		response.End()
	else
		vipname=rs(0)
		vipbirth=rs(1)
		vbday = day(vipbirth)
		vbmonth = month(vipbirth)
		nextbirth = year(date())&"-"&vbmonth&"-"&vbday
		howdays = datediff("d",date(),nextbirth)
		birthday=""
		if howdays<0 then '�����ѹ�
			nextbirth = year(date())+1&"-"&vbmonth&"-"&vbday
			birthday=birthday&" ���������ջ���"&datediff("d",date(),nextbirth)&"��"
		elseif howdays=0 then '������ʮ����
			birthday=birthday&" <span style='color:red'>��������</span>"
		elseif howdays>0 and howdays<30 then '������ʮ����
			birthday=birthday&" ��������ջ���"&howdays&"��"
		else
			birthday=birthday&" ��������ջ���"&howdays&"��"
		end if
	end if
	rs.close
	
	if abs(howdays) > session("cf_Vip_giftDays") and session("cf_Vip_giftDays")>=0 then
		response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"�û�Ա"&birthday&"���������д˹��ܡ�<br><br>"
		
		if session("cf_Vip_giftDays")=0 then
			response.write "ע��ϵͳ�����˻�Ա���ڵ������ղ����������"
		else
			response.write "ע����Ա�����뷢���ﵱ�����ܴ���"&session("cf_Vip_giftDays")&"�죡"
		end if
		response.write "</center>"
		response.End()
	end if
	
	
	if act<>"" then
		if act="del" then
			cn.execute("delete from "&tmptab&" where clothingid="&qts(id)&" "&_
						" and depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1")
		elseif act="upd" and num<>"" then
			cn.execute("update "&tmptab&" set nums="&num&" where clothingid="&qts(id)&" "&_
						" and depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1")
		elseif act="cancel" then
			cn.execute("delete from "&tmptab&" where depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1")
		end if
		response.Redirect("?vipcode="&vipcode&"&centum="&centum&"&comment="&comment&"")
	end if
	
end if

%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script>
function chkform(t){
if(t.key.value.length<=0){
return false;
}
return true;
}
function cho(){
  var m=showModalDialog("vip_giftsub.asp?vipcode=<%=vipcode%>",window,"dialogWidth:650px;dialogHeight:390px;center: yes;help:no;resizable:no;status:no");
	if(m){
		document.getElementById("key").value=m;
		document.getElementById("form1").submit();		
	}
}
function reform(val){
	document.getElementById('act').value=val;
	document.getElementById('form1').submit();
}
function ck(t,v){
	location.href='?vipcode=<%=vipcode%>&act=upd&num='+v+'&id='+t+'&centum=<%=centum%>&comment=<%=comment%>'
}
function window.onload(){
	document.getElementById('key').focus();
}
</script>
</head>
<body>
<%if request("inputvip")="true" then %>
<center><p style="padding:10px;margin:0;">����������</p></center>
<%end if%>
<form name="form1" id="form1" method="post" action="?vipcode=<%=vipcode%>" onSubmit="return chkform(this)">
<input type="hidden" name="act" id="act" value="" />
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    
    <tr>
      <td align="right">VIP���ţ�</td>
      <td><input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" value="<%=vipcode%>" size="22" readonly=readonly style='background:#efefef;' /></td>
      <td align="right">�������ڣ�</td>
      <td><%=vipbirth%></td>
    </tr>
    <tr>
      <td width="70" align="right">�����ţ�</td>
      <td><input name="key" type="text" id="key" size="20" maxlength="30" autocomplete="off" value="">
      <input type="submit" name="search" id="search" value="���">
      <input type="button" name="search2" id="search2" value="ѡ��..." onClick="cho()"></td>
      <td align="right">���ղ�ࣺ</td>
      <td><%=birthday%></td>
    </tr>
	</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    <td height="260" valign="top">
<%
if instr(key,",")>0 then
keys=split(key,",")
	for i = 0 to ubound(keys)-1
		'������������ж��ֵ����ʹ�ô˶�����뷽��
		addstyle trim(keys(i))
	Next
else
	addstyle key
end if


function addstyle(ikey)
  sql = "select a.clothingid, a.styleid, a.colorid,"&_
		" a.sizeid,b.k_num as kc "&_
		" from j_clothing a,j_stock b "&_
		" where a.styleid in (select a.styleid from vip_birthstyle a,j_style b,vip_cardvip c"&_
		" where a.styleid=b.styleid"&_
		" and a.viptypeid=c.viptypeid and c.vipcardid="&qts(vipcode)&" group by a.styleid) "&_
		" and a.clothingid*=b.clothingid and b.depotid="&qts(depotid)&_
		" and a.clothingid="&qts(ikey)&" "
	rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		if key<>"" then response.write "<script>alert('��Ʒ�����ڣ��������ͷ�Χ�ڣ�')</script>"
	else
		rs2.open "select clothingid from "&tmptab&" where clothingid="&qts(ikey)&" "&_
				 " and depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1",cn,1,1
		if rs2.eof and rs2.bof then
			sql="insert into "&tmptab&" (depotid,vipcode,clothingid,styleid,colorid,sizeid,nums,kc,dtype) "&_
				"values ("&qts(depotid)&","&qts(vipcode)&","&qts(rs("clothingid"))&","&qts(rs("styleid"))&","&_
				qts(rs("colorid"))&","&qts(rs("sizeid"))&",1,"&qts(rs("kc"))&",1)"
		else
			sql="update "&tmptab&" set nums=nums+1 where clothingid="&qts(ikey)&" "&_
				" and depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1"
		end if
			cn.execute(sql)
		rs2.close
	end if
	rs.close
end function



rs.open "select clothingid as ���,styleid as ��ʽ,colorid as ��ɫ,sizeid as ����,nums as ����,kc as Ŀǰ���  from "&tmptab&" where depotid="&qts(depotid)&" and vipcode="&qts(vipcode)&" and dtype=1"
if not rs.eof and not rs.bof then
response.write "<table cellspacing=1 cellpadding=0 width='100%' style='background:#CCC;margin:10px 0;'>"
	response.write "<tr >"
	for i = 0 to rs.fields.count-1
	
		names = rs(i).name
		if len(names)=4 then names=left(names,2)&"<br>"&right(names,2)
	response.write "<TD style='background:#efefef' align=center>"&names&"</TD>"
	Next
			response.write "<TD style='background:#efefef' align=center>����</TD>"
	response.write "</tr>"
do while not rs.eof
	response.write "<tr>"
		for i = 0 to rs.fields.count-1
			if i=4 and session("cf_Vip_giftSumsModify")<>-1 then 
			response.write "<TD style='background:#FFF' align=center><input type=text name='"&rs(0)&"' id='"&rs(0)&"' style='width:40px' value="&RemoveHTML(rs(i))&" onchange='ck(this.id,this.value)'></TD>"
			else
			response.write "<TD style='background:#FFF' align=center>"&RemoveHTML(rs(i))&"</TD>"
			end if
		Next
			response.write "<TD style='background:#FFF' align=center><a href='?act=del&id="&rs(0)&"&vipcode="&vipcode&"&comment="&comment&"&centum="&centum&"' >�Ƴ�</a></TD>"
			'onclick=""if(confirm('ȷ���Ƴ���')==false){return false}""
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
	<table width="100%"  border="0" cellpadding="0" cellspacing="1"> 
    <tr>
      <td align="center"><input type="submit" name="Submit" value="���������š�"
       onclick="if(confirm('ȷ��������')){reform('submit');this.value='���Ե�';this.disabled=true;}"
       <%if disabled then response.write "disabled=disabled"%>>
      &nbsp;
      <input type="button" name="delall" value="�塡��"
       onclick="if(confirm('ȷ�������')){reform('cancel')}"
       <%if disabled then response.write "disabled=disabled"%>></td>
    </tr>
  </table>
</form>
</body>
</html>
