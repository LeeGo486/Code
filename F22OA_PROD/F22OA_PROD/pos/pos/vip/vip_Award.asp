<%session("formid")=6101030%>
<!--#include file="../f22/inc/function.asp"-->
<%

if not session("cf_VipSet_jfhg")  then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"�˹���Ŀǰ�ѽ�ֹʹ�ã��������������������Ա��ϵ��</center>"
	response.End()
end if
if not padd then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"��û�иù��ܵ�ʹ��Ȩ�ޣ�</center>"
	response.End()
end if
vipcode=ucase(request("vipcode"))
act=request("act")
id=request.QueryString("id")
num=request.QueryString("num")

%>

<%if (vipcode="" or isnull(vipcode) or isempty(vipcode)) and id="" then %>
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


key=trim(request("key"))
key = RemoveHTML(key)
comment=trim(request("comment"))
comment = RemoveHTML(comment)
tmptab=" webtmp_dollar "

set rs=server.CreateObject("adodb.recordset")
'VIP����֤
sql =  chkvip(vipcode,0)
rs.open sql,cn,1,1
if rs.eof and rs.bof then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>��VIP����ʧЧ����ڣ��������е�ǰ����</center>"
	response.End()
else
	vipid=rs(0)
end if
rs.close

'---------------------------------------------
if act="submit" then
	userid=session("dm").System_UserId
	username = session("dm").System_UserName
	depotid=session("dm").System_DepotId
	retailid=getid("vip_shopscore","scoreid","JF",userid)
	cids=request.form("cid")
	
	'�ж�����ѡ����뷽ʽ
	
	if cids="" then
		response.Redirect("?vipcode="&vipcode&"")
		response.End()
	end if
	'������ѡ�Ľ�������
	sql="select isnull(sum(centum),0) as centum from vip_typecentum where typeid in ("&cids&")"
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		jf1=cdbl(rs(0))
	else
		response.Redirect("?vipcode="&vipcode&"")
		response.end()
	end if
	rs.close
	'��ʷ��������ܺ�
	sql="select isnull(sum(isnull(b.dote,0)),0) as dote from vip_shopscore a,vip_shopscoresub b where a.scoreid=b.scoreid and a.vipcode="&qts(vipcode)
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		jf2=cdbl(rs(0))
	else
		response.Redirect("?vipcode="&vipcode&"")
		response.end()
	end if
	rs.close
	'��ǰ�����ͻ�������
	sql="select b.viptypename,isnull(b.setcentum,0) as setcentum  "&_
	"from vip_cardvip a,vip_typevip b "&_
	"where a.viptypeid=b.viptypeid and a.vipcardid="&qts(vipcode)
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		cardType=rs(0)
		jf3=cdbl(rs(1))
	else
		response.Redirect("?vipcode="&vipcode&"")
		response.end()
	end if
	rs.close
	'�����Ƿ���Ͻ���Ҫ��
	if jf1+jf2>jf3 then
		jbox cardType&"��������������Ϊ "&jf3&",���λ����ۼƺ�Ϊ "&jf1+jf2&",�ѳ��������������ޣ����������ܻ��֣�"
		response.end()
	end if
	
	'����
	sql="select scoreid,vipid,vipcode,depotid,setdate,crdate,comment,crname from vip_shopscore"
	rs.open sql,cn,1,3
	rs.addnew
		rs("scoreid")=retailid
		rs("vipid")=vipid
		rs("vipcode")=vipcode
		rs("depotid")=depotid
		rs("setdate")=now()
		rs("crdate")=now()
		rs("comment")=comment
		rs("crname")=username
	rs.update
	rs.close
	
	'�ӱ�
	sql="select typeid,pricis,isnull(centum,0) as centum,comment from vip_typecentum where typeid in ("&cids&")"
	rs.open sql,cn,1,1
	do while not rs.eof
		sql="insert into vip_shopscoresub (scoreid,dtypeid,pricis,dote,readme,crdate,comment)"&_
					" values ("&qts(retailid)&","&qts(rs(0))&","&qts(rs(1))&","&rs(2)&","&qts(rs(3))&",'"&now()&"',"&qts(comment)&")" 
		cn.execute(sql)
	rs.movenext
	loop
	rs.close
	'��ʾ
	close "�������ֵǼǳɹ������ֵ����ǣ�"&retailid
end if
	
'---------------------------------------------
	
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֽ���</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function ck(t){
	if(t){
		var tc=t.getElementsByTagName("INPUT");
			for(i=0;i<tc.length;i++){
				if(tc[i].checked==true){
					tc[i].checked=false;
					t.className="";
				}else{
					tc[i].checked=true;
					t.className="seltrue";
				}
			}
		
	}else{
		var ts=document.getElementsByTagName("INPUT");
		var str="";
		for(i=0;i<ts.length;i++){
			if(ts[i].name=="cid"){
				if(ts[i].checked==true){
					str+=ts[i].value+",";
				}
			}
		}
		if(str.length>1){ window.returnValue=str; }
		window.close();
	}
}
function sel(t,o){
var color;
	if(t){
		if(t.className!="seltrue"){
			var tt=t.getElementsByTagName("TD");
				if(o==1){
					color="#DDE";
				}else{
					color="#FFF";
				}
			for(i=0;i<tt.length;i++){
				tt[i].style.background=color;
			}
		}
	}
}
</script>
</head>
<body>
<%if request("inputvip")="true" then %>
<center><p style="padding:10px;margin:0;">���ֽ���</p></center>
<%end if%>
<form name="form1" id="form1" method="post" action="?vipcode=<%=vipcode%>" target="_self">
<input type="hidden" name="act" id="act" value="submit" />
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    <tr>
      <td width="70" align="right">VIP���ţ�</td>
      <td><input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" value="<%=vipcode%>" size="22" readonly=readonly style='background:#efefef;' ></td>
      <td align="right">��ע��</td>
      <td><input name="comment" type="text" id="comment" size="30" maxlength="255"></td>
    </tr>
	</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    <td height="290" valign="top">
<%
sql = "select typeid,pricis,isnull(centum,0) as centum,comment from vip_typecentum order by typeid"
	rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		response.write "<p>&nbsp;</p>"
		response.write "<p>&nbsp;</p>"
		response.write "<p style=color:red>�޿�ѡ���뷽ʽ!</p>"
	else
	response.write "<table cellspacing=1 cellpadding=0 width='100%' style='background:#CCC;margin:10px 0;'>"
		response.write "<tr>"
		response.write "<TD style='background:#efefef' align=center width=60>ѡ��</TD>"
		response.write "<TD style='background:#efefef' align=center width=40>���</TD>"
		response.write "<TD style='background:#efefef' align=center>���뷽ʽ</TD>"
		response.write "<TD style='background:#efefef' align=center width=80 height=30>��������</TD>"
		response.write "<TD style='background:#efefef' align=center>˵��</TD>"
		response.write "</tr>"
	do while not rs.eof
		response.write "<tr onClick=""ck(this)"" onmouseover='sel(this,1)' onmouseout='sel(this,0)'>"
			response.write "<TD style='background:#FFF' align=center><input name=""cid"" id=""cid"" type=""checkbox"" value="""&rs(0)&"""></TD>"
			response.write "<TD style='background:#fff' align=center>"&rs(0)&"</TD>"
			response.write "<TD style='background:#fff' align=center>"&rs(1)&"</TD>"
			response.write "<TD style='background:#fff' align=center>"&rs(2)&"</TD>"
			response.write "<TD style='background:#fff' align=center>"&rs(3)&"</TD>"
		response.write "</tr>"
	rs.movenext
	loop
		response.write "</table>"
	end if
rs.close
set rs=nothing

%>
    </td>
   </tr>
	</table>
	<table width="100%"  cellpadding="0" cellspacing="1" > 
    <tr>
      <td align="center">
      <input type="submit" name="Submit" id="submit" value="������������"
       onclick="if(!confirm('ȷ��������')){return false}" >
      &nbsp;
      <input type="button" name="delall" value="�塡��" id="delall"
       onclick="if(confirm('ȷ�������')){location.href=location.href}" /></td>
    </tr>
  </table>
</form>
</body>
</html>
