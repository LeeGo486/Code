<%session("formid")=6101031%>
<!--#include file="../f22/inc/function.asp"-->
<%
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
vipcode=trim(request("vipcode"))

if  session("pos_vipshow")=true  then
  vipcodejm="*****"
else
  vipcodejm=vipcode
end if   

act=trim(request("act"))
chkstr=""

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
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
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

<%
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
function checkForm(t){
//
//byear
//
//vipemail
//vipccupation
//vippostalcode
//comment
		
        var tviplen=document.getElementById("vipcode").value;
        if(tviplen.length == 0){
            alert("��������VIP����!");
            return false;
        }
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
			alert('�ֻ����벻��Ϊ��');
			t.mobtel.focus();
			return false;
<%
	end if
	if redTips(chkstr,"2001")<>"" then
	'�������ж�
%>
//		}else if(!t.vipcode.value){
//			alert('VIP������Ϊ��');
//			t.vipcode.focus();
//			return false;
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
</head>
<body>
<%
if id<>"" then
	if act="submit" then
	
	   depotid=trim(session("dm").System_depotid)
	   userid=trim(session("dm").System_UserId)

	   confirm=trim(request.Form("confirm"))
	   zcentum=trim(request.Form("zcentum"))
	
		'-------------------/ vip_cardvip /--------------------------
		typeid_old=trim(request.Form("typeid_old"))
		typeid=trim(request.Form("typeid"))

		vipcode=trim(request.Form("vipcode"))
		vipcodeold=trim(request.Form("vipcodeold"))
		'-------------------/ vip_user /--------------------------
		vipsex=trim(request.Form("vipsex"))
		
		byear=trim(request.Form("byear"))
		bmonth=trim(request.Form("bmonth"))
		bday=trim(request.Form("bday"))
		
		vippaper=trim(request.Form("vippaper"))
		vippassport=trim(request.Form("vippassport"))
		vipoccupation=trim(request.Form("vipoccupation"))
		mobtel=trim(request.Form("mobtel"))
		vipemail=trim(request.Form("vipemail"))
		vipadd=trim(request.Form("vipadd"))
		comment=trim(request.Form("comment"))

		vipbirth=byear&"-"&bmonth&"-"&bday
		vipbirth=get_date(vipbirth)
		
	  '�Ƿ�ѡ����������
	  if typeid=typeid_old then ebox "��ѡ��Ҫ�����Ŀ�����"
		
	  '����ǲ�����������ֻ�ı俨����,�����ж�
	  if LCase(vipcodeold)<>LCase(vipcode) then 
		
		'���ɿ���
		if vipcode<>"" then
			sql="select vipcardid,vipid,viptypeid from vip_cardvip where vipcardid="&qts(vipcode)
			rs.open sql,cn,1,1
				if not(rs.eof and rs.bof) then
					if rs("viptypeid")<>typeid then	'�ÿ������Ƿ���ѡ��Ŀ�����һ��
						ebox "ѡ��Ŀ������뿨�����е����Ͳ�һ�£�"
					elseif vipid<>"" then						'�ÿ��Ƿ�ʹ��
						ebox "���ţ�"&vipcode&"�ѱ���һ���˿�ʹ�ã�"
					else
						if confirm<>"true" then				'��ʾ��û�У�
							response.write "<script language=""javascript"">"
							response.write "if(confirm('���ţ�"&vipcodejm&"����ʹ�ã�ȷ��������VIP����')){"&_
											"parent.document.getElementById('confirm').value='true';"&_
											"parent.document.forms[0].submit();"&_
										"}; </script>"
							response.end()
						else
							isaddcard=false		'���¿�
						end if
					end if
				else
					if confirm<>"true" then			
							response.write "<script language=""javascript"">"
							response.write "alert('���ţ�"&vipcodejm&"�����ڣ�����ʧ�ܣ�')</script>"
							response.end()					
					end if
				end if
			rs.close
		else
			'����û�������һ������
			vipcode=getVipid("LC"&depotid)
			isaddcard=true
		end if
		
	  end if
'------------------------------------------------------------------------
		'�ж������ʸ�
		sql=" select isnull(a.levelsums,0) as levelsums,isnull(a.limitday,"&session("cf_Vip_limitday") &") as limitday, "&_
				" (isnull(a.levelsums,0)-isnull(b.levelsums,0)) as jLevelsums,"&_
				" isnull(a.MaxDay,"&session("cf_Vip_MaxDay")&") as MaxDay from vip_typevip a,vip_typevip b "&_
				" where isnull(a.levelsums,0)>=isnull(b.levelsums,0) "&_
				" and (isnull(a.levelsums,0)-isnull(b.levelsums,0))<="&zcentum&" "&_
				" and b.viptypeid="&qts(typeid_old)&" and a.viptypeid="&qts(typeid)&" "
		ds.open sql,cn,1,1
		if not(ds.eof and ds.bof) then
			levelsums=ds("levelsums")
			limitday=ds("limitday")
			MaxDay=ds("MaxDay")
			jLevelsums=ds("jLevelsums")
		else
			ebox "�˹˿͵�ǰ���ֲ����۳�����������ֻ������Ч"
		end if
		ds.close

         'VIP����ʼ����,��ʼ��ֵ
		dim starcentum,starsums
		starcentum=0
		starsums=0
		sql="select isnull(starcentum,0),isnull(starsums,0) from vip_user a inner join vip_cardvip b on a.vipcode=b.vipcardid where a.vipid="&qts(id)
		rs.open sql,cn,1,3
		if not(rs.eof and rs.bof) then
		  starcentum=rs(0)
		  starsums=rs(1)
		end if
		rs.close
		

		'���¹˿͵���
		
		vipid=id
		sql="select isnull(centum,0) as icentum,* from vip_user where vipid="&qts(id)
		rs.open sql,cn,1,3
		if not(rs.eof and rs.bof) then
		  oldvipcode=rs("vipcode")
		  rs("Yvipcode")=oldvipcode
		  rs("vipcode")=vipcode
		   '2010.09.17,��ǰ���ĳ�ʼ�����ۼӵ��¿�
		  rs("centum")=cdbl(rs("centum"))-cdbl(jLevelsums)
		  rs("vipsex")=vipsex
		  if byear<>"1950" then rs("vipbirth")=vipbirth	'���˵�Ĭ�ϵ���������
		  rs("vippaper")=vippaper
		  rs("vippassport")=vippassport
		  rs("vipoccupation")=vipoccupation
		  rs("mobtel")=mobtel
		  rs("vipemail")=vipemail
		  rs("vippostalcode")=vippostalcode
		  rs("vipadd")=vipadd
		  rs("comment")=comment
		  rs("kjcentum")=jLevelsums 
		  rs("updatecheck")=session("cf_Vip_UpdateType")			'�ύ��ˣ�ȡconfig.asp����
		end if
		rs.update
		rs.close
		
		'����ǲ�����������ֻ�ı俨����,
		if LCase(vipcodeold)<>LCase(vipcode) then  
		  '���ɿ���ʧЧ����
		   sql="update vip_cardvip set enddate=getdate(),comment='�˿�������' where vipcardid="&qts(oldvipcode)&""
		   cn.execute(sql)
		else
		   '���ɿ������������޸Ĵ���
		   sql="update vip_cardvip set viptypeid='"&typeid&"',comment='�˿�������,�޸��˿�����' where vipcardid="&qts(oldvipcode)&""
		   cn.execute(sql)   
        end if  
		
		'��ӻ���¿����ϱ�
		if isaddcard then									'û�п���������½�һ������¼
			sql="select * from vip_cardvip"
			ds.open sql,cn,1,3
			ds.AddNew
			ds("vipid")=vipid
			ds("viptypeid")=typeid
			ds("vipcardid")=vipcode
			ds("MaxDay")=MaxDay
			ds("limitday")=limitday
			ds("vipemit")=Now()
			'2010.09.17,�ɿ��ĳ�ʼ���֡���ʼ��ֵ�ۼӵ��¿�
			if IsNull(ds("starcentum")) then
    		    starcentum = cdbl(starcentum)
			  else
			    starcentum = cdbl(ds("starcentum"))+cdbl(starcentum)	
			  end if
			  
			  if IsNull(ds("starsums")) then
    		    starsums = cdbl(starsums)
			  else
			    starsums = cdbl(ds("starsums"))+cdbl(starsums)	
			  end if			  
			ds("starcentum")=starcentum
			ds("starsums")=starsums			
			ds.Update
			ds.Close
		else												'���п�������¸��¿�����
			sql="select * from vip_cardvip where vipcardid="&qts(vipcode)
			ds.open sql,cn,1,3
			ds("vipid")=vipid	
			ds("vipemitadd")=depotid
			ds("vipemit")=Now()					'����ʱ��
			'2010.09.17,�ɿ��ĳ�ʼ����,��ʼ��ֵ�ۼӵ��¿�
			if LCase(vipcodeold)<>LCase(vipcode) then	
			  if IsNull(ds("starcentum")) then
    		    starcentum = cdbl(starcentum)
			  else
			    starcentum = cdbl(ds("starcentum"))+cdbl(starcentum)	
			  end if
			  
			  if IsNull(ds("starsums")) then
    		    starsums = cdbl(starsums)
			  else
			    starsums = cdbl(ds("starsums"))+cdbl(starsums)	
			  end if			  
			ds("starcentum")=starcentum
			ds("starsums")=starsums			
			end if
			ds.Update
			ds.Close
		end if
			if session("posvipcode")<>"" then session("posvipcode")=""
			response.Write("<script>parent.document.getElementById('btnok').disabled='disabled';</script>")
			call close("�����ɹ�!")
			
	else
		sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums "&_
		",b.tempcard,b.viptypeid as bviptypeid, b.vipuse as bvipuse from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
		ds.Open sql,cn,1,1
		if not ds.eof then
		vipname=ds("vipname")
		vipsex=ds("vipsex")
		vipbirth=ds("vipbirth")
		vippassport=ds("vippassport")
		'country=ds("country")
		'people=ds("people")
		'stature=ds("stature")
		'waistline=ds("waistline")
		'city=ds("city")
		vipemail=ds("vipemail")
		viptel=ds("viptel")
		vipadd=ds("vipadd")
		vippostalcode=ds("vippostalcode")
		vipoccupation=ds("vipoccupation")
		'crname=ds("crname")
		mobtel=ds("mobtel")
		'vipup=ds("vipup")
		comment=ds("comment")
		'vippay=ds("vippay")
		vippaper=ds("vippaper")
		'vipgrab=ds("vipgrab")
		vipuse=ds("bvipuse")
		'vipstyle=ds("vipstyle")
		'vipsize=ds("vipsize")
		'vipsize1=ds("vipsize1")
		'city=ds("city")
		'vipapply=ds("vipapply")
		'viplove=ds("viplove")
		vipmax=ds("vipmax")
		'vipmin=ds("vipmin")
		'vipplace=ds("vipplace")
		'tjname=ds("tj_name")
		tempcard=ds("tempcard")
		'fbuyid=ds("fbuyid")
		'fbuydate=ds("fbuydate")
		'fbuysums=ds("fbuysums")
		'fremark=ds("fremark")
		viptypeid=ds("bviptypeid")
		vipcode=ds("vipcode")
		zcentum=ds("zcentum")
		zsums=ds("zsums")
		'schools=ds("schools")
		'parents=ds("parents")
		'relation=ds("relation")
		'add_city=ds("add_city")
		'add_region=ds("add_region")
		'age=ds("age")
		end if
		ds.close
	end if
else
	ebox "��������"
end if
	
	
if vipuse then
	checkStr=" readonly=readonly style='background:#efefef;' "
else
	checkStr=""
end if
	
	
'end select

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
%>
<%if request("inputvip")="true" then %>
<center><p style="padding:10px;margin:0;">VIP������</p></center>
<%end if%>
<form id="form1" name="form1" method="post" action="?" onSubmit="return checkForm(this)" target="hs">
<input name="confirm" type="hidden" id="confirm" value="false">
<input name="act" id="act" type="hidden" value="submit">
<input name="id" id="id" type="hidden" value="<%=id%>">
<input name="zcentum" id="zcentum" type="hidden" value="<%=zcentum%>">
<input name="vipcodeold" id="vipcodeold" type="hidden" value="<%=vipcode%>">
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    <tr>
      <td align="right">�����ͣ�</td>
      <td><select name="typeid" id="typeid">
          <% get_viptype viptypeid,zcentum%>
        </select><input name="typeid_old" type="hidden" id="typeid_old" value="<%=viptypeid%>">
          <font color="red">*</font></td>
    </tr>
    <tr>
      <td align="right">��VIP���ţ�</td>
      <td><input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %>  id="vipcode" onChange="if(this.value.length>0){document.getElementById('form1').target='hs'}else{document.getElementById('form1').target='_self'}" size="22" >
      <span style="color:#999">(����ʵ�￨,��ѡ��ÿ������ͼ����Ͽ���,�������ʹ�þɿ�,�������VIP����)</span></td>
    </tr>
    <tr>
      <td width="12%" align="right">�˿�������</td>
      <td width="38%"><input name="vipname" type="text" id="vipname" value="<%=vipname%>" size="15" readonly=readonly style='background:#efefef;' >
      <%=redTips(chkstr,"1001")%></td>
    </tr>
    <tr>
      <td align="right">�Ա�</td>
      <td>
      
      <label for="vipsex1"><input name="vipsex" id="vipsex1" type="radio" value="��" <%if vipsex="" then response.write "checked" end if
	                                                     if vipsex="��" then response.write "checked" end if%>>
       ��</label>
        
      <label for="vipsex2"><input name="vipsex" id="vipsex2" type="radio" value="Ů" <%if vipsex="Ů" then response.write "checked" end if%>>
        Ů</label>
				<%=redTips(chkstr,"2002")%></td>
    </tr>
    <tr>
      <td align="right">�ֻ����룺</td>
      <td><input name="mobtel" type="text" id="mobtel" value="<%=mobtel%>" size="20" maxlength="11" onKeyUp="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" readonly=readonly style='background:#efefef;' >
        <%=redTips(chkstr,"1002")%></td>
    </tr>
    <tr>
      <td align="right">֤�����ͣ�</td>
      <td><select name="vippaper" id="vippaper">
          <% get_rs 3004,vippaper%>
      </select>
      <%=redTips(chkstr,"2003")%></td>
    </tr>
    <tr>
      <td align="right">֤�����룺</td>
      <td><input name="vippassport" type="text" id="vippassport" value="<%=vippassport%>"
      onchange="calBirth(this.value)"
       size="30" maxlength="20">
        <%=redTips(chkstr,"2003")%></td>
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
      <td><input name="vipemail" type="text" id="vipemail3" value="<%=vipemail%>" size="30" maxlength="30">
       <%=redTips(chkstr,"2006")%></td>
    </tr>
    <tr>
      <td align="right">�ʼĵ�ַ��</td>
      <td><input name="vipadd" type="text" id="vipadd" value="<%=vipadd%>" size="50" maxlength="50">
        <%=redTips(chkstr,"2007")%></td>
    </tr>
    <tr>
      <td align="right">��ע��</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="50" maxlength="50">
      <%=redTips(chkstr,"2010")%>
      </td>
    </tr>
	</table>
	<table width="100%"  border="0" cellpadding="0" cellspacing="1" > 
	<input type="hidden" value="<%=qts(id)%>" name="vipid">
    <tr>
      <td align="center"><input type="submit" id="btnok" name="btnok"   value="�ύ(S)">
      <input type="reset" name="Submit" value="�� ��"></td>
    </tr>
  </table>
</form>
<iframe name="hs" src="about:blank" style="display:none"></iframe>
</body>
</html>
