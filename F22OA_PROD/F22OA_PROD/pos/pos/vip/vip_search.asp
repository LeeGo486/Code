<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../f22/inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ʹ��VIP��</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<base target="_self">
<script language="javascript">
function vipmanage(vipcode,disabled,update){
var sm;

	if(vipcode==0){
		vipname=document.getElementById("vip_username").value;
		//mobtel=document.getElementById("vip_mobile").value;
		mobtel=document.getElementById("vipmbid").value;
		sm=showModalDialog('vip_manage.asp?vipname='+vipname+'&mobtel='+mobtel+'','vipmanage','dialogWidth:850px;dialogHeight:500px;center: yes;help:no;status:no');
	}else{
		sm=showModalDialog('vip_manage.asp?c='+vipcode+'&disabled='+disabled+'&update='+update,'vipmanage','dialogWidth:850px;dialogHeight:500px;center: yes;help:no;status:no');
	}

	if(sm){
		var esm=sm.split("||");	//�ָ�
		document.getElementById("vip_username").value=esm[0];
		document.getElementById("vip_mobile").value=esm[1];
		document.getElementById("vipmbid").value=esm[1];
	}
	
	//�ر��������ʱ�Ի���ʱ��Ӧ�����¼�
	var sch = document.getElementById("search");
	sch.click();
}

function onok(vipcode){
  if(vipcode!=""){
    window.returnValue=vipcode;
  }else{
    window.returnValue="0";
  }
  window.close();
}


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
		if(keyCode==27){//ESC��������״̬
			window.close();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}else if(keyCode==116){//F5 ʹ��
			var vip_use = document.getElementById('vip_use');
			if(vip_use){//
				if(vip_use.disabled==false){//
					vip_use.click();
				}
			}
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}else if(keyCode==119){//F8 ����
			var vip_manage = document.getElementById('vip_manage');
			if(vip_manage){ vip_manage.click() }
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}else if(keyCode==120){//F9 �½�
		
			var vip_add = document.getElementById('vip_add');
			if(vip_add){ vip_add.click() }

			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}
	}
}
document.onkeydown = KeyDown;
</script>
</head>

<body onLoad="document.form1.vip_username.focus();">
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">ʹ��VIP��</td>
  </tr>
</table>
<%dim vip_username,vip_mobile
vip_username=trim(request.QueryString("vip_username"))
vip_mobile=trim(request.QueryString("vip_mobile"))

vip_username=replace(vip_username,"'","")
vip_mobile=replace(vip_mobile,"'","")

'dim cn
'set cn=server.createobject("ADODB.Connection")
'cn.open session("cn")
  dim ds,sql,vipbirth,vipdepotid
  set ds=Server.CreateObject("ADODB.Recordset")

  sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,b.vipemit,isnull(b.limitday,0) as limitday,"&_
			" c.viptypename, isnull(c.levelsums,0) as levelsums , isnull(a.updatecheck,0) as updatecheck"&_
			" from vip_user a,vip_cardvip b, vip_typevip c "&_
			" where a.vipcode=b.vipcardid and isnull(a.vipcode,'')<>'' and c.viptypeid=b.viptypeid "
			
			if session("posvipcode")<>"" and vip_username="" then
				sql=sql&" and a.vipcode = '"&session("posvipcode")&"'"
			else
				sql=sql&" and vipname = '"&vip_username&"' and a.mobtel = '"&vip_mobile&"'"
			end if

	'  if key="" then sql="select 1 from vip_user where 1=0" 
  'ds.Source = sql
  ds.Open sql,cn,1,1
	if not(ds.eof and ds.bof) then
		updatecheck=reNull(ds("updatecheck"))
		vip_username=ds("vipname")
		vipbirth=ds("vipbirth")
		vipdepotid=ds("depotid")
		if year(vipbirth)<>"1950" then
		
			vbday = day(vipbirth)
			vbmonth = month(vipbirth)
			nextbirth = year(date())&"-"&vbmonth&"-"&vbday
			howdays = datediff("d",date(),nextbirth)
			
			if howdays<0 then '�����ѹ�
				nextbirth = year(date())+1&"-"&vbmonth&"-"&vbday
				vipbirth=vipbirth&" <span style='color:green'>(����"&datediff("d",date(),nextbirth)&"������)</span>"
			elseif howdays=0 then '������ʮ����
				vipbirth=vipbirth&" <span style='color:red'>(��������)</span>"
			elseif howdays>0 and howdays<30 then '������ʮ����
				vipbirth=vipbirth&" <span style='color:blue'>(����"&howdays&"������)</span>"
			else
				vipbirth=vipbirth&" <span style='color:green'>(����"&howdays&"������)</span>"
			end if
		else
			vipbirth="<span style='color:blue'>(δ�ṩ)</span>"
		end if
		
		vip_mobile=ds("mobtel")
	else
	  vipdepotid=session("dm").system_depotid
	end if
%>

<form name="form1" method="get" action="vip_search.asp" onSubmit="return checkForm(this);">
  <table width="100%"  border="0" class="tcontent">
  <!--
    <tr>
      <td>��ʽ��<input name="opt" type="radio" value="1" < %if opt=1 then response.Write " checked" end if%> >
        VIP���� <input type="radio" name="opt" value="2" < %if opt=2 then response.Write " checked" end if%>>
�ֻ����� <input type="radio" name="opt" value="3" < %if opt=3 then response.Write " checked" end if%>>
���֤���� <input type="radio" name="opt" value="4" < %if opt=4 then response.Write " checked" end if%>>
���� </td>
    </tr>
    -->
    <tr>
      <td>
      ������
      <input name="vip_username" type="text" id="vip_username" 
       style="width:80px;"
       maxlength="10"
       value="<%=vip_username%>">
      ���ֻ����룺
      <input name="vip_mobile" type="<%if session("dm").system_depotid=vipdepotid then response.write("text") else response.write("password") end if%>" id="vip_mobile"
       style="width:130px;" 
        maxlength="11"
       onKeyUp="value=value.replace(/[^\d]/g,'');"
       onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''));"
        value="<%=vip_mobile%>">
	  <input name="vipmbid" type="hidden" id="vipmbid" value="<%=vip_mobile%>">
      <input type="submit" name="search" id="search" value="��ѯ"></td>
    </tr>
  </table>
</form>

<%
if not (ds.eof and ds.bof) then
dim zcentum,levelsums,vipstate,updstr
vipstate="����"
zcentum = reNull(ds("zcentum"))
levelsums = reNull(ds("levelsums"))

	if updatecheck=1 then
		vipstate=" <span style='color:green'>(���������)</span>"
	elseif updatecheck=2 then
		vipstate=" <span style='color:blue' title='��VIP���������˻أ���״̬��Ӱ��VIP�������ѣ����뾡���޸ĸù˿�����'>(�������˻�)</span>"
	elseif updatecheck=3 then
		vipstate=" <span style='color:red'>(����������)</span>"
	else
			'����û�ȵ�ǰ�ʸ���ִ�Ŀ�����
			set rsj=server.CreateObject("adodb.recordset")
			sql="select isnull(levelsums,0) as levelsums from vip_typevip "&_
					" where isnull(levelsums,0)<="&cdbl(levelsums)+cdbl(zcentum)&_
					" and levelsums>"&cdbl(levelsums)
			rsj.open sql,cn,1,1
			if not(rsj.eof and rsj.bof) then
				'��������VIP��
					vipstate=" <span style='color:red'>(������)</span>"
					updstr="true"
			end if
		rsj.close
		set rsj=nothing
	end if
viptypename = ds("viptypename")

%>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF'  style="margin:10px 0;">
  <tr>
    <td width="20%" align="right" bgcolor='#FFEFEF'>�������ţ�</td>
    <td><%=ucase(ds("vipcode"))%></td>
    <td align="right" bgcolor='#FFEFEF'>״��̬��</td>
    <td><%=vipstate%></td>
  <tr>
    <td align="right" bgcolor='#FFEFEF'>��ǰ���֣�</td>
    <td width="30%"><%=zcentum%></td>
    <td width="20%" align="right" bgcolor='#FFEFEF'>�����ͣ�</td>
    <td width="30%"><%=viptypename%>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" bgcolor='#FFEFEF'>��Ա���գ�</td>
    <td colspan="3"><%=vipbirth%>&nbsp;</td>
  </tr>
  <tr>
    <td width="20%" align="right" bgcolor='#FFEFEF'>��&nbsp;Ч&nbsp;�ڣ�</td>
    <td colspan="3"><%
		vipemit=ds("vipemit")
		limitday=ds("limitday")
		getvipstr=""
		mgrstr=""
		if limitday<>"" and limitday<>"" then
			if datediff("d",vipemit,Now())>limitday then
					response.write "<span style='color:red'>"& FormatDateTime(vipemit,2)&" �� "&FormatDateTime(vipemit+limitday,2)&" (��ʧЧ)</span>"
					getvipstr = " ��ʧЧ "
					mgrstr="true"
					updstr=""
			else
					response.write FormatDateTime(vipemit,2)&" �� "&FormatDateTime(vipemit+limitday,2)
			end if
		else
			response.write "<span style='color:red'>(��ʧЧ)</span>"
					getvipstr = " ��ʧЧ "
					mgrstr="true"
					updstr=""
		end if
		%></td>
  </tr>
</table>
<%
	getvipcode = getvip(ds("vipcode"))
elseif vip_username<>"" then
	response.write "<p style='color:green;text-align:center;'>ϵͳ�в����ڴ˹˿����ϣ���Ҫ�½��밴��F9����</p>"
		
	addvipstr = " onClick=""vipmanage(0)"" "
		
else
	response.write "<p style='color:red;text-align:center;'>Ҫ�½��˿����ϣ����������������ֻ����룬ȷ��ϵͳ�в�������ͬ����</p>"
	addvipstr = " disabled=disabled "
end if
  ds.close
  set ds=nothing
%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    <%if session("posvipcode")="" and getvipcode<>"" and getvipstr=""  then
			getvipstr = " onClick=""onok('"&getvip(getvipcode)&"');"" "
		else
			getvipstr = " disabled=disabled "
		end if
		%>
    
		<%if getvipcode<>"" then%>
    <input type="button" name="vip_use" value=" ʹ �� [F5]" <%=getvipstr%>>
    <input type="button" name="vip_manage" value=" �� �� [F8]" onClick="vipmanage('<%=getvip(getvipcode)%>','<%=mgrstr%>','<%=updstr%>')" >
    <%else%>
    <input type="button" name="vip_add" value=" �� �� [F9]" <%=addvipstr%> >
    <%end if%>
    
    <input type="button" name="vip_close" value=" �� �� [Esc] " onClick="window.close();"></td>
  </tr>
</table>
<iframe style="display:none" name="hiddenform" id="hiddenform" src=""></iframe>
</body>
</html>