<!--#include file="../f22/inc/function.asp"-->
<%
dim act,ds,id,aastr,chkstr,sql
set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
set fs=server.CreateObject("adodb.recordset")
set fs1=server.CreateObject("adodb.recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
fs.activeconnection = cn
fs1.activeconnection = cn
id=trim(request.QueryString("id"))
act=trim(request.QueryString("act"))
if act="" then act="add"


chkstr=""
sql="select readid,comment from vip_read where isnull(sure,0)=1"
rs.open sql,cn,1,1
	do while not rs.eof
		chkstr=chkstr&rs(0)&","
	rs.movenext
	loop
rs.close

function redTips(chkstr,readid)
	if instr(chkstr,readid)>0 then 
		redTips="<span style='color:red;'>*</span>"
	else
		redTips=""
	end if
end function
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�½����޸�VIP�˿͵���</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function calBirth(s){
	var nian,yue,ri;
	var sb=0;
	if (s.length==15 )
	{
	y="19"+s.substr(6,2);	//ʮ��λ����ݶ���19��ͷ��
	m=eval(s.substr(10,2));
	d=eval(s.substr(12,2));
	sb=1;
	}
	else if(s.length==18)
	{
	y=eval(s.substr(6,4));
	m=eval(s.substr(10,2));
	d=eval(s.substr(12,2));
	sb=1;
	}
	if(sb==1){
		document.getElementById("byear").value = y;
		document.getElementById("bmonth").value = m;
		document.getElementById("bday").value = d;
	}
}

function checkForm(t){
		if(!t.typeid.value){
			alert('�����Ͳ���Ϊ��');
			t.typeid.focus();
			return false;
	<%if redTips(chkstr,"1001")<>"" then%>
		}else if(!t.vipname.value){
			alert('�˿���������Ϊ��');
			t.vipname.focus();
			return false;
<%
	end if
	if redTips(chkstr,"1002")<>"" then
%>
		}else if(t.mobtel.value.length!=11){
			alert('�ֻ��������Ϊ 11 λ');
			t.mobtel.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2001")<>"" then
%>
		}else if(!t.vipcode.value){
			alert('VIP������Ϊ��');
			t.vipcode.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2002")<>"" then
%>
		}else if(!t.vipsex1.checked&&!t.vipsex2.checked){
			alert('��ѡ��˿��Ա�');
			t.vipsex1.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2003")<>"" then
%>
		}else if(!t.vippaper.value){
			alert('��ѡ��֤������');
			t.vippaper.focus();
			return false;
		}else if(!t.vippassport.value){
			alert('����д֤������');
			t.vippassport.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2005")<>"" then
		'���ղ����ж�
	end if
	if redTips(chkstr,"2006")<>"" then
%>
		}else if(!t.vipemail.value){
			alert('�����ʼ���ַ����Ϊ��');
			t.vipemail.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2007")<>"" then
%>
		}else if(!t.vipadd.value){
			alert('�ʼĵ�ַ����Ϊ��');
			t.vipadd.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2008")<>"" then
%>
		}else if(!t.vippostalcode.value){
			alert('�������벻��Ϊ��');
			t.vippostalcode.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2009")<>"" then
%>
		}else if(!t.vipoccupation.value){
			alert('ְҵ����Ϊ��');
			t.vipoccupation.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2010")<>"" then
%>
		}else if(!t.comment.value){
			alert('��ע����Ϊ��');
			t.comment.focus();
			return false;
<%
	end if
%>
		}
}
</script>
<script type="text/javascript">
function vip(url){
	if(url){
  	var m=showModalDialog(url,'vipdetail','dialogWidth:600px;dialogHeight:520px;center: yes;help:no;status:no');
	}
}
</script>
</head>
<body>
<%
select case act
case "del"

case "add"
	aastr="<font color=blue>*</font>"
	vipname=request.QueryString("vipname")
	mobtel=request.QueryString("mobtel")

case "view","edit"
	aastr="<font color=red>*</font>"
  if id<>"" then
    sql="select a.*,isnull(a.updatecheck,0) as updatecheck,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums "&_
	    ",b.tempcard,b.viptypeid as bviptypeid, b.vipuse as bvipuse from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
	ds.Open sql,cn,1,1
	if not ds.eof then
	vipname=ds("vipname")
	vipsex=ds("vipsex")
	vipbirth=ds("vipbirth")
	vippassport=ds("vippassport")
	country=ds("country")
	people=ds("people")
	stature=ds("stature")
	waistline=ds("waistline")
	city=ds("city")
	vipemail=ds("vipemail")
	viptel=ds("viptel")
	vipadd=ds("vipadd")
	vippostalcode=ds("vippostalcode")
	vipoccupation=ds("vipoccupation")
	crname=ds("crname")
	mobtel=ds("mobtel")
	vipup=ds("vipup")
	comment=ds("comment")
	vippay=ds("vippay")
	vippaper=ds("vippaper")
	vipgrab=ds("vipgrab")
	vipuse=ds("bvipuse")
	vipstyle=ds("vipstyle")
	vipsize=ds("vipsize")
	vipsize1=ds("vipsize1")
	city=ds("city")
	vipapply=ds("vipapply")
	viplove=ds("viplove")
	vipmax=ds("vipmax")
	vipmin=ds("vipmin")
	vipplace=ds("vipplace")
	tjname=ds("tj_name")
	tempcard=ds("tempcard")
	fbuyid=ds("fbuyid")
	fbuydate=ds("fbuydate")
	fbuysums=ds("fbuysums")
	fremark=ds("fremark")
	viptypeid=ds("bviptypeid")
	vipcode=ds("vipcode")
	zcentum=ds("zcentum")
	zsums=ds("zsums")
	schools=ds("schools")
	parents=ds("parents")
	relation=ds("relation")
	add_city=ds("add_city")
	add_region=ds("add_region")
	age=ds("age")
	updatecheck=ds("updatecheck")
	
	end if
	ds.close
  end if
	
	if vipuse then
		checkStr=" readonly=readonly style='background:#efefef;' "
	else
		checkStr=" readonly=readonly "
	end if
	
end select

set ds=nothing

sub get_rs(lookupid,oldvalue)
 rs.source="select lookname from j18_lookupsub where lookupid='"&lookupid&"' order by lookcode"
 rs.open
response.write("<option value=''></option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=oldvalue then response.Write" selected " end if
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub getsize(oldvalue)
 rs.source="select sizeid from j_size order by s_order"
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=oldvalue then response.Write" selected " end if
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">�½����޸�VIP�˿͵���</td>
  </tr>
</table>

<%
	if updatecheck=2 or updatecheck=3 then
			sql="select dtype,comment,crdate,crusername from vip_comment where vipid='"&id&"' order by orderid desc"
			rs.open sql,cn,1,1
			if not(rs.eof and rs.bof) then
				response.write "<div style=""padding:10px;color:red;"">"
					response.write "<strong>"&rs("dtype")&"��</strong>"
					response.write rs("comment")
				response.write "&nbsp;<a href=""javascript:vip('vip_chklog.asp?vipid="&id&"');"">ȫ��("&rs.recordcount&")</a>"
				response.write "</div>"
			end if
			rs.close
	end if
%>
</div>
<form name="form1" id="form1" method="post" action="vip_savecard.asp" onSubmit="return checkForm(this)">
  <input name="confirm" type="hidden" id="confirm" value="false">
  <input name="act" type="hidden" id="act" value="<%=act%>">
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    <tr>
      <td align="right">�����ͣ�</td>
      <td><select name="typeid" id="typeid">
          <% get_viptype viptypeid,""%>
        </select> <span style="color:red;">*</span></td>
    </tr>
    <tr>
      <td align="right">VIP���ţ�</td>
      <td><input name="vipcode" type="text" id="vipcode" onChange="if(this.value.length>0){document.getElementById('form1').target='hs'}else{document.getElementById('form1').target='_self'}" value="<%=vipcode%>" 
      size="22" <%if vipcode<>"" then response.write " readonly=readonly style='background:#efefef;' "%>>
       <%=redTips(chkstr,"2001")%>
      <span style="color:#999">��Ĭ��Ϊ��ʱϵͳ���Զ�����һ��VIP���ţ�</span>
      </td>
    </tr>
    <tr>
      <td width="12%" align="right">�˿�������</td>
      <td width="38%"><input name="vipname" type="text" id="vipname" value="<%=vipname%>" size="15" <%=checkStr%>>
      <%=redTips(chkstr,"1001")%></td>
    </tr>
    <tr>
      <td align="right">�Ա�</td>
      <td>
      <label for="vipsex1"><input name="vipsex" id="vipsex1" type="radio" value="��" 
	  <%if vipsex="��" or (vipsex="" and session("cf_VipSet_dsex") =1) then response.write "checked" end if%>>
       ��</label>
      <label for="vipsex2"><input name="vipsex" id="vipsex2" type="radio" value="Ů"
       <%if vipsex="Ů" or (vipsex="" and session("cf_VipSet_dsex") =2) then response.write "checked" end if%>>
        Ů</label>
        <%=redTips(chkstr,"2002")%>
        </td>
    </tr>
    <tr>
      <td align="right">�ֻ����룺</td>
      <td><input name="mobtel" type="text" id="mobtel" value="<%=mobtel%>" size="20" maxlength="11" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" <%=checkStr%>>
      <%=redTips(chkstr,"1002")%>
      </td>
    </tr>
    <tr>
      <td align="right">֤�����ͣ�</td>
      <td><select name="vippaper" id="vipgrap">
          <% get_rs 3004,vippaper%>
      </select>
      <%=redTips(chkstr,"2003")%>
      </td>
    </tr>
    <tr>
      <td align="right">֤�����룺</td>
      <td><input name="vippassport" type="text" id="vippassport" value="<%=vippassport%>"
      onchange="calBirth(this.value)" size="30" maxlength="20">
      <%=redTips(chkstr,"2003")%>
      </td>
    </tr>
    <tr>
      <td align="right">�������ڣ�</td>
      <td><select name="byear" id="byear">
	  <%for i=1950 to year(date)%>
        <option value="<%=i%>" <%if year(vipbirth)=i then response.write "selected" end if%>><%=i%></option>
		<%next%>
      </select>
        ��
        <select name="bmonth" id="bmonth">
	  <%for i=1 to 12%>
        <option value="<%=i%>" <%if month(vipbirth)=i then response.write "selected" end if%>><%=i%></option>
		<%next%>
      </select>
        ��
        <select name="bday" id="bday">
	  <%for i=1 to 31%>
        <option value="<%=i%>" <%if day(vipbirth)=i then response.write "selected" end if%>><%=i%></option>
		<%next%>
      </select>
        ��
        <%=redTips(chkstr,"2005")%>
         </td>
    </tr>
    <tr>
      <td align="right">�������䣺</td>
      <td><input name="vipemail" type="text" id="vipemail" value="<%=vipemail%>" size="30" maxlength="30">
      <%=redTips(chkstr,"2006")%>
      </td>
    </tr>
    <tr>
      <td align="right">�ʼĵ�ַ��</td>
      <td><input name="vipadd" type="text" id="vipadd" value="<%=vipadd%>" size="50" maxlength="50">
      <%=redTips(chkstr,"2007")%>
      </td>
    </tr>
    
    <tr>
      <td align="right">�ʱࣺ</td>
      <td><input name="vippostalcode" type="text" id="vippostalcode" value="<%=vippostalcode%>" size="12" maxlength="6">
      <%=redTips(chkstr,"2008")%>
      </td>
    </tr>
    
    <tr>
      <td align="right">ְҵ��</td>
      <td nowrap><select name="vipoccupation" id="vipoccupation">
        <% get_rs 3001,vipoccupation%>
      </select>
      <%=redTips(chkstr,"2009")%>
      </td>
    </tr>
    
    <tr>
      <td align="right">��ע��</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="50" maxlength="50">
      <%=redTips(chkstr,"2010")%>
      </td>
    </tr>
	</table>
	<table width="100%"  border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA" class="f12"> 
	<input type="hidden" value="<%=qts(id)%>" name="vipid">
	<%if act="add" or act="edit" then%>
    <tr>
      <td align="center"><input type="submit" name="Submit" value="�ύ(S)" <%if updatecheck=0 and act<>"add" then response.write "disabled=disabled"%> >
      <input type="reset" name="Submit" value="�� ��">
      <input type="button" name="button" onClick="window.close()" value="�� ��"></td>
    </tr>
	<%end if%>
  </table>
</form>
<iframe name="hs" src="about:blank" style="display:none"></iframe>
</body>
</html>
