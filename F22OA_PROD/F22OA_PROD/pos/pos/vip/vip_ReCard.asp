<%session("formid")=6101032%>
<!--#include file="../f22/inc/function.asp"-->
<%
if not session("cf_VipSet_vmbb") then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"�˹���Ŀǰ�ѽ�ֹʹ�ã��������������������Ա��ϵ��</center>"
	response.End()
end if

if not padd then
	response.write "<br /><br /><br /><br /><br /><br /><center style='font-size:9pt;color:red'>"&_
		"��û�иù��ܵ�ʹ��Ȩ�ޣ�</center>"
	response.End()
end if	

set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
set fs=server.CreateObject("adodb.recordset")
set fs1=server.CreateObject("adodb.recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
fs.activeconnection = cn
fs1.activeconnection = cn
id=trim(request("id"))
depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_UserId)

act=trim(request("act"))
vipcode=trim(request("vipcode"))
oldvipcode=trim(request("oldvipcode"))


if vipcode<>"" and id="" then
sql="select vipid from vip_cardvip where vipcardid='"&vipcode&"'"
rs.open sql,cn,1,1
	if not rs.eof and not rs.bof then
		id=rs("vipid")
	end if
rs.close
end if

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
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP������</title>
<base target="_self" />
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
function checkForm(t){
<%if session("cf_VipSet_reCardType")>0 then%>
	var vipcode = t.vipcode;

	if(vipcode.value<=0){
		alert('����д�µ�VIP������!');
		vipcode.focus();
		return false;
	}
<%end if%>
}

<%if session("cf_VipSet_reCardType")>0 then%>
$(function(){
	$("#chknewcard").attr('disabled','disabled');
	$("#submit1").attr('disabled','disabled');
	$("#vipcode")
	.keydown(function(){									
			if(event.keyCode==13)
			{
				$("#chknewcard").click();
				event.keyCode=0;
				return false;
			}
	})
	.change(function(){
		$("#submit1").attr('disabled','disabled');
	})
	.keyup(function(){
			if($(this).val().length>0)
				$("#chknewcard").attr('disabled','');
			else
				$("#chknewcard").attr('disabled','disabled');
	});
	$("#chknewcard").click(function(){									
				if($(this).attr('disabled')=='')
				{
					var obj = getjson('vip_recardchk.asp','vipcode='+$("#vipcode").val()+'&typeid='+$("#typeid").val());
					if(obj.success=='true')
					{
						$("#chkspan").text(obj.msg).css('color','green');
						$("#submit1").attr('disabled','');
						$("#submit1").focus();
					}
					else
					{
						//alert(obj.msg);
						$("#chkspan").text(obj.msg).css('color','red');
						$("#vipcode").select();
					}
				}
		});
  });

	//����AJAX����JSON����
	function getjson(url,data)
	{
			var html = $.ajax({
			url: url,
			type: "POST",
			data: data,
			async: false
			}).responseText;
			return eval('('+html+')');;
	}
<%end if%>
</script>
</head>
<body>
<%
if id="" then ebox "��������"

if act="submit" then

	'�����¿�
	if vipcode="" then vipcode=getVipid("BK"&depotid) 
	
	'����ԭ��������
	'2010.09.17,�ɿ��ĳ�ʼ���֡���ʼ��ֵ�ۼӵ��¿�
	sql=" UPDATE a SET a.vipid=b.vipid,a.vipemit=b.vipemit,a.vipemitadd=b.vipemitadd,a.vipsellcode=b.vipsellcode,"&_
			" a.starcentum=isnull(a.starcentum,0)+isnull(b.starcentum,0),a.starsums=isnull(a.starsums,0)+isnull(b.starsums,0),"&_
			" a.MaxDay=b.MaxDay,a.vipup=b.vipup,a.vipuse=b.vipuse, "&_
			" a.begdate=b.begdate,a.enddate=b.enddate,a.vipcentum=b.vipcentum,a.vipsums=b.vipsums,a.basecentum=b.basecentum,"&_
			" a.viplastdate=b.viplastdate,a.limitday=b.limitday "&_
			" FROM vip_cardvip a,vip_cardvip b where a.vipcardid="&qts(vipcode)&" and b.vipcardid="&qts(oldvipcode)&""
	cn.execute(sql)
	
	'���¹˿͵������VIP����
	sql="update vip_user set vipcode="&qts(vipcode)&" where vipid="&qts(id)
	cn.execute(sql)

	'���ɿ������ڴ���
	sql="update vip_cardvip set enddate=getdate(),comment='�˿��Ѹ���Ϊ��"&vipcode&"' where vipcardid="&qts(oldvipcode)&""
	cn.execute(sql)

    if  session("pos_vipshow")=true  then
      vipcodejm="*****"
    else
      vipcodejm=vipcode
    end if 

	call close("����ɹ�!�µ�VIP����Ϊ��"&vipcodejm&"")
	
else
	sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums "&_
	",b.tempcard,b.viptypeid as bviptypeid, b.vipuse as bvipuse from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
	ds.Open sql,cn,1,1
	if not ds.eof then
	vipname=ds("vipname")
	vipsex=ds("vipsex")
	vipbirth=ds("vipbirth")
	vippassport=ds("vippassport")
	vipemail=ds("vipemail")
	viptel=ds("viptel")
	vipadd=ds("vipadd")
	vippostalcode=ds("vippostalcode")
	vipoccupation=ds("vipoccupation")
	mobtel=ds("mobtel")
	comment=ds("comment")
	vippaper=ds("vippaper")
	vipuse=ds("bvipuse")
	vipmax=ds("vipmax")
	tempcard=ds("tempcard")
	viptypeid=ds("bviptypeid")
	vipcode=ucase(ds("vipcode"))
	zcentum=ds("zcentum")
	zsums=ds("zsums")
	vipdepotid=ds("depotid")
	end if
	ds.close
end if
set ds=nothing




sub get_viptype(typeid)
	sql="select viptypename,levelsums from vip_typevip where viptypeid="&qts(typeid)&" order by viptypeid"
	rs.open sql,cn,1,1
	if not rs.eof and not rs.bof then
	response.write rs(0)
	end if
	rs.close
end sub
%>
<%if request("inputvip")="true" then %>
<center><p style="padding:10px;margin:0;">VIP������</p></center>
<%end if%>

<form name="form1" method="post" action="?" onSubmit="return checkForm(this)">
<input name="act" id="act" type="hidden" value="submit">
<input name="id" id="id" type="hidden" value="<%=id%>">
  <table width="100%"  border="0" cellpadding="5" cellspacing="1" class="f12 Fbox">
    <tr>
      <td align="right">ԭ�����ͣ�</td>
      <td> <% get_viptype viptypeid%>
      <input name="typeid" id="typeid" type="hidden" value="<%=viptypeid%>">
      </td>
    </tr>
    <tr>
      <td align="right">��VIP���ţ�</td>
      <td><% if  session("pos_vipshow")=true then response.Write("*****") else response.Write(""&vipcode&"")  end if %>
      <input name="oldvipcode" id="oldvipcode" type="hidden" value="<%=vipcode%>">
      </td>
    </tr>
    <%if session("cf_VipSet_reCardType")>0 then%>
    <tr>
      <td align="right">
			<%if session("cf_VipSet_reCardType")>0 then response.write " <font color=red>*</font>"%>
      ��VIP���ţ�</td>
      <td>
      <input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" size="22" style=" text-transform:uppercase;font-family:arial;font-size:14px; font-weight:bold">
      <input type="button" name="chknewcard" id="chknewcard" value="����Ƿ����">
      <div id="chkspan"></div>
      </td>
    </tr>
		<%Else%>
    <input name="vipcode" id="vipcode" type="hidden" value="">
    <%End if%>
    <tr>
      <td width="12%" align="right">�˿�������</td>
      <td width="38%"><%=vipname%></td>
    </tr>
    <tr>
      <td align="right">�Ա�</td>
      <td><%= vipsex%></td>
    </tr>
    <tr>
      <td align="right">�ֻ����룺</td>
      <td><%if depotid=vipdepotid then response.write(mobtel) end if%></td>
    </tr>
    <tr>
      <td align="right">֤�����ͣ�</td>
      <td><%= vippaper%></td>
    </tr>
    <tr>
      <td align="right">֤�����룺</td>
      <td><%= vippassport%></td>
    </tr>
    <tr>
      <td align="right">�������ڣ�</td>
      <td><%= vipbirth %></td>
    </tr>
    <tr>
      <td align="right">�������䣺</td>
      <td><%= vipemail%></td>
    </tr>
    <tr>
      <td align="right">�ʼĵ�ַ��</td>
      <td><%= vipadd %></td>
    </tr>
    <tr>
      <td align="right">��ע��</td>
      <td><%=comment%></td>
    </tr>
	</table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" > 
	<input type="hidden" value="<%=qts(id)%>" name="vipid">
    <tr>
      <td align="center">
      <input type="submit" name="submit1"  id="submit1"  value="�������졡" onClick="if(!confirm('ȷ�ϲ����µ�VIP����')){return false}"> </td>
    </tr>
  </table>
</form>
</body>
</html>
