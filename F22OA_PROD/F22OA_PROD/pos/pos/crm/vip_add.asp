<%session("formid")=6101021%>
<%if session("cf_VipSet_ShowPic")=1 then 
    response.redirect "vip_addForImg.asp?id="&trim(request.QueryString("id"))&"&act="&trim(request.QueryString("act"))                
  end if
%>
<!--#include file="inc/function.asp"-->

<%
if not padd then
    call mbox("û������Ȩ�ޣ�")
end if
dim readonly
readonly=""
dim act,ds,id,userid
set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
set fs=server.CreateObject("adodb.recordset")
set fs1=server.CreateObject("adodb.recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
fs.activeconnection = cn
fs1.activeconnection = cn
id=trim(request.QueryString("id"))
depotid=trim(session("dm").System_depotid)
userid = session("dm").System_userid
act=trim(request.QueryString("act"))
if act="" then act="add"

select case act
case "del"

case "add"

case "view","edit"

	'�����޸���
	if act="edit" then
		sql="select readid from vip_read where isnull(change,0)=1"
		rs.open sql,cn,1,1
			do while not rs.eof
				if readonly<>"" then readonly=readonly&","
				readonly=readonly&"."&rs("readid")
			rs.movenext
			loop
		rs.close
	end if

  if id<>"" then
    sql="select a.*,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,isnull(a.sums,0)+isnull(b.starsums,0) as zsums "&_
	    "from vip_user a,vip_cardvip b where a.vipid="&qts(id)&" and a.vipcode*=b.vipcardid"
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
  vipstyle=ds("vipstyle")
	
  vipcolor=ds("vipcolor")
	
  vipbrand1=ds("vipbrand1")
  vipbrand2=ds("vipbrand2")
  vipbrand3=ds("vipbrand3")
	
  vipsize=ds("vipsize")
  vipsize1=ds("vipsize1")
  city=ds("city")
  vipapply=ds("vipapply")
  viplove=ds("viplove")
  vipmax=ds("vipmax")
  vipmin=ds("vipmin")
  vipplace=ds("vipplace")
  tjname=ds("tj_name")
  tzname=ds("tz_name")
  tzid=ds("Employeeid")
  fbuyid=ds("fbuyid")
  fbuydate=ds("fbuydate")
  fbuysums=ds("fbuysums")
  fremark=ds("fremark")
  viptypeid=ds("viptypeid")
  vipcode=ds("vipcode")
  zcentum=ds("zcentum")
  zsums=ds("zsums")
  schools=ds("schools")
  parents=ds("parents")
  relation=ds("relation")
  add_city=ds("add_city")
  add_region=ds("add_region")
  age=ds("age")
	end if
	ds.close
  end if
end select

set ds=nothing

sub get_rs(lookupid,oldvalue)
 rs.source="select lookname from j18_lookupsub where lookupid='"&lookupid&"' order by lookcode"
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

sub get_viptype(typeid)
 rs.source="select viptypeid,viptypename from vip_typevip "&_
 		" where viptypeid in(select viptypeid from sys_viptypepower18ql where userid='"&userid&"' and isnull(p_sure,0)=1)"
 rs.open
response.write("<option value=''></option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=typeid then response.Write" selected " end if
response.write">"
response.write rs(1)
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

sub get_tz(tzid)
 rs.source="select a.employeeid,'['+employeeid+']'+a.names from j_employee a,jk_group b "&_
 		" where isnull(a.valid,0)=0 and a.groupid=b.groupid and a.depotid="&qts(depotid)
 rs.open
response.write("<option value='��ѡ��'>��ѡ��</option>")
do while not rs.eof
response.write"<option value="&rs(0)
if rs(0)=tzid then response.Write" selected " end if
response.write">"
response.write rs(1)
response.write"</option>"
rs.movenext
loop
rs.close
end sub
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���VIP����</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
<%
dim chkstr
'������
	chkstr="var json = ["
	'sql="select readid,comment,reg,tooltip,length=5 from vip_read where isnull(sure,0)=1"
	sql="select readid,comment,reg,tooltip,length=isnull(b.length,0) from vip_read  a  "&_
		" left join  syscolumns  b on a.columnname=b.name "&_
		" where object_name(id)='vip_user' and isnull(sure,0)=1  order by readid " 
	rs.open sql,cn,1,1
		do while not rs.eof
		reg=rs("reg")
		if isnull(reg) or isempty(reg) or reg="NULL" then reg=""
		if instr(reg,"\") then reg = replace(reg,"\","\\")
			chkstr=chkstr&"{'id':'"&rs("readid")&"','comment':'"&rs("comment")&"','reg':'"&reg&"','tooltip':'"&rs("tooltip")&"','length':'"&rs("length")&"'},"
		rs.movenext
		loop
		chkstr = left(chkstr,(len(chkstr)-1))&"]"
	rs.close
	response.write chkstr

%>

$(function()
{
//�ѷ�����ֻ����
		<%if readonly<>"" and vipcode<>"" then %>
			$('<%=readonly%>').each(function(){
				$(this).before($(this).val()).css('display','none')
			})
		<%end if%>
//�������Ժ�ɫ�Ǻ���ʾ
			$(json).each(function(i,o){
				$('.'+o.id).after(' <span style="color:red">*</span>');
			})
			
//����ͨ��AJAX��֤
			$("#buyid").blur(
			  function(){
				$("#buydate2").val('');
				$("#buysums2").val('');
				$("#chkretailidText").html('');
				
				if($(this).val().length>0)
				{
						var obj = getjson('vip_chkretailid.asp','fbuyid='+$(this).val())
						if(obj.success=='true'){
							var v = obj.msg.split('|');
							$("#buydate2").val(v[0]);
							$("#buysums2").val(v[1]);
							$("#chkretailidText").html('');
	
						}else{
							$("#chkretailidText").html('<br />'+obj.msg).css('color','red');
							$(this).val('')
						}
				}
			});
//���ύ�¼�
			$("form").submit(function()
			{
				var rt = true;
					$(json).each(function(i,o)
						{
								$('.'+o.id).each(function(){
										if($(this).css('display')!='none')
										{
										
										    if ((o.length>0)&&($(this).val().length>o.length))
											{
											   alert(o.comment+"���ܳ���"+o.length+"�ַ�!(ע:1�������ִ���2���ַ�)");
												rt = false;
											}
											
											if($(this).val()=='')
											{
													alert(o.comment+"����Ϊ��!");
													rt = false;
											}else if(o.reg != ""){
													if(!$(this).val().match(o.reg))
													{
													alert(o.tooltip);
													rt = false;
													}
											}
										}
								})
								
								if(!rt) {
										$(this).eq(0).focus();
										rt = false;
										return false;
								}

								
							
						});
				return rt;
			})

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
		return eval('('+html+')');
}

function oncs(){
  var t=document.form1.tzid;
  var id='['+t.options[t.options.selectedIndex].value+']';
  var name=t.options[t.options.selectedIndex].text.replace(id,"");
  if(name!="��ѡ��")
  {
     document.form1.tzname.value=name;
  }
  else
  {
     document.form1.tzname.value="";
  }
}
</script>

</head>
<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP��Ա���ϵǼ�</td>
  </tr>
</table>
<form name="form1" method="post" action="vip_save.asp">
<input name="act" type="hidden" id="act" value="<%=act%>" />
<table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
    <tr>
      <td width="100" align="right">�������ͣ�</td>
      <td width="325"><select name="typeid" id="typeid" class="2011">
          <% get_viptype viptypeid%>
      </select></td>
      <td width="79" align="right">���򵥺ţ�</td>
      <td width="217">
      <input name="buyid" type="text" id="buyid" value="<%=fbuyid%>" size="25"  class="2012"
                 onKeyDown="if(event.keyCode==13){event.keyCode=9}" />
      <span id="chkretailidText"></span>      </td>
    </tr>
    <tr>
      <td align="right">�˿�������</td>
      <td><input name="vipname" type="text" id="vipname" value="<%=vipname%>" size="20" class="1001">          </td>
      <td align="right"> �������ڣ�</td>
      <td><input name="buydate2" id="buydate2" type="text" value="<%=fbuydate%>" size="10" readonly style="background-color: #cccccc">
        �����<input name="buysums2" id="buysums2" type="text" value="<%=fbuysums%>" size="8" readonly style="background-color: #cccccc"></td>
    </tr>
    <tr>
      <td align="right">�Ƽ��ˣ�</td>
      <td>
      <input name="tjname" type="text" id="tjname"  size="12" maxlength="30"
	  value="<%=tjname%>" class="2013"/>
	  ��չ�ˣ�
	 <select name="tzid" id="tzid" style="width:150px; " tabindex="-1" onChange="oncs();" >
         <% get_tz tzid%>
        </select>
	  <input name="tzname" type="hidden" id="tzname" size="30"
       maxlength="30" value="<%=tzname%>" class="3007" ></td>
      <td align="right" nowrap>��װ���</td>
      <td>
      <select name="vipgrab" id="vipgrab" class="2014">
      <option></option>
       <% get_rs 3006,vipgrab%>
       </select>      </td>
    </tr>
    <tr>
      <td align="right">�Ա�</td>
      <td>
      <input name="vipsex" id="vipsex1" type="radio" value="��" 
	  <%if vipsex="��" or (vipsex="" and session("cf_VipSet_dsex") =1) then response.write "checked" end if%> >
       ��</label>
      <label for="vipsex2"><input name="vipsex" id="vipsex2" type="radio" value="Ů"
       <%if vipsex="Ů" or (vipsex="" and session("cf_VipSet_dsex") =2) then response.write "checked" end if%>>
        Ů</label>			</td>
      <td align="right">ϲ����ʽ��</td>
      <td><select name="vipstyle" id="vipstyle" class="2015">
          <option></option>
 	        <% get_rs 2008,vipstyle%>
          </select>          </td>
    </tr>
    <tr>
      <td align="right">ϲ��Ʒ�ƣ�</td>
      <td>
      <input name="vipbrand1" type="text" id="vipbrand1" value="<%=vipbrand1%>" size="12" maxlength="50" class="3010"/>
      <input name="vipbrand2" type="text" id="vipbrand2" value="<%=vipbrand2%>" size="12" maxlength="50" class="3011"/>
      <input name="vipbrand3" type="text" id="vipbrand3" value="<%=vipbrand3%>" size="12" maxlength="50" class="3012"/>      </td>
      <td align="right">��װ��ɫ��</td>
      <td><select name="vipcolor" id="vipcolor" class="3009">
        <option></option>
        <% get_rs 3007,vipcolor%>
        </select></td>
    </tr>
    <tr>
      <td align="right">�������ڣ�</td>
      <td><select name="byear" id="byear" class="2005">
	  <option></option>
	  <%
		dim styear,edyear
		if session("cf_VipBirthdayBeg")<>"" and session("cf_VipBirthdayEnd")<>"" then 
			styear = year(date)-cdbl(session("cf_VipBirthdayEnd"))
			edyear = year(date)-cdbl(session("cf_VipBirthdayBeg"))
		else
			styear = 1950
			edyear = year(date)
		end if
		for i=styear to edyear%>
        <option value="<%=i%>" <%if year(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>><%=i%>|<%=year(date)-i%></option>
		<%next%>
      </select>
        ��
        <select name="bmonth" id="bmonth" class="2005">
		<option></option>
	  <%for i=1 to 12%>
        <option value="<%=i%>" <%if month(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>><%=i%></option>
		<%next%>
      </select>
        ��
        <select name="bday" id="bday" class="2005">
		<option></option>
	  <%for i=1 to 31%>
        <option value="<%=i%>" <%if day(vipbirth)=i and vipbirth<>"" then response.write "selected" end if%>><%=i%></option>
		<%next%>
      </select>
        ��        </td>
      <td align="right">��װ���룺</td>
      <td><select name="vipsize" id="vipsize" class="2016">
        <option></option>
	      <%getsize vipsize%>
            </select>
			��װ���룺
          <select name="vipsize1" id="vipsize1" class="2017">
		<option></option>
				<%getsize vipsize1%>
            </select>            </td>
    </tr>
    <tr>
      <td align="right">֤�����ͣ�</td>
      <td><select name="vippaper" id="vipgrap" class="2003">
          <option></option>
          <% get_rs 3004,vippaper%>
         </select>
		 ֤�����룺
         <input name="vippassport" type="text" id="vippassport" 
      		value="<%=vippassport%>" size="20" maxlength="30" class="2004">
	</td>	
      <td align="right">��췽ʽ��</td>
      <td>
	  <select name="vipapply" id="vipapply" class="2019">
		<option></option>
	   <% get_rs 3008,vipapply%>
            </select>
	  </td>
    </tr>
    
    <tr>
      <td align="right">���壺</td>
      <td><select name="people" id="people" class="2021">
		<option></option>
			 <% get_rs 3005,people%>
      </select>
	  ���᣺
       <input name="country" type="text" id="country"
       value="<%=country%>" size="20" maxlength="50" class="3008">      </td>
      <td align="right">���˰��ã�</td>
      <td>
      <select name="viplove" id="viplove" class="2022">
      <option></option>
			 <% get_rs 3009,viplove%>
      </select> 
	  </td>
    </tr>
    <tr>
      <td align="right">�̶��绰��</td>
      <td nowrap>
      <input name="viptel" type="text" id="viptel" value="<%=viptel%>" 
      size="14" maxlength="14" class="2030">
      �ƶ��绰��<input name="mobtel" type="text" id="mobtel" value="<%=mobtel%>"
       size="15" maxlength="15" class="1002">
	</td>
      <td align="right">���ﳡ����</td>
      <td>
      <select name="vipplace" id="vipplace" class="2027">
      <option></option>
			 <% get_rs 3011,vipplace%>
      </select>
	  </td>
    </tr>
    <tr>
      <td align="right">ְҵ��</td>
      <td nowrap><select name="vipoccupation" id="vipoccupation" class="2009">
        <option></option>
        <% get_rs 3001,vipoccupation%>
      </select>
      </td>
      <td align="right">���룺</td>
      <td>
        <select name="vippay" id="vippay" class="2026">
        <option></option>
           <% get_rs 3002,vippay%>
        </select>
      </td>
    </tr>
    <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
      <td align="right">���ܼ�λ��</td>
      <td>
      <input name="vipmin" type="text" id="vipmin" size="10" maxlength="30" value="<%=vipmin%>" class="2028"> ��
	  <input name="vipmax" type="text" id="vipmax" size="10" maxlength="30" value="<%=vipmax%>" class="2028">
	  </td>
      <td align="right">��ߣ� </td>
      <td><input name="stature" type="text" id="stature" value="<%=stature%>" 
      size="5" maxlength="5" class="2023"/>
        CM������Χ:
          <input name="waistline" type="text" id="waistline" value="<%=waistline%>"
           size="5" maxlength="5" class="2024"/>
          CM
	</td>
    </tr>
    <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
      <td align="right">ѧУ��</td>
      <td><input name="schools" type="text" id="schools" value="<%=schools%>" size="30" class="3001">      </td>
      <td align="right">�ҳ���</td>
      <td>
	  <input name="parents" type="text" id="parents" size="30"value="<%=parents%>" class="3002">
	  </td>
    </tr>
    <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
      <td align="right">����Σ�</td>
      <td><input name="age" type="text" id="age" value="<%=age%>" size="30" class="3003">      </td>
      <td align="right">��ϵ��</td>
      <td><input name="relation" type="text" id="relation" size="30" value="<%=relation%>" class="3004">      </td>
    </tr>
    <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
      <td align="right">��ַ�У�</td>
      <td><input name="add_city" type="text" id="add_city" value="<%=add_city%>" size="30" class="3005">      </td>
      <td align="right">��ַ����</td>
      <td><input name="add_region" type="text" id="add_region" size="30" value="<%=add_region%>" class="3006">      </td>
    </tr>
    <tr <%if session("cf_VipSet_gjxx")=false then response.write "style='display:none;'"%>>
		  <td align="right">��������</td>
      <td><select name="city" id="city" class="2018">
          <option></option>
				 <% get_rs 3003,city%>
            </select>
	   </td>
      <td align="right">�ʱࣺ</td>
      <td><input name="vippostalcode" type="text" id="vippostalcode"
       value="<%=vippostalcode%>" size="6" maxlength="6"  class="2008"> 
		</td>
    </tr>
    <tr>
      <td align="right">��ϸ��ַ��</td>
      <td>
      <input name="vipadd" type="text" id="vipadd" value="<%=vipadd%>" size="40" maxlength="100" class="2007">      </td>
      <td align="right">�������䣺</td>
      <td><input name="vipemail" type="text" id="vipemail" value="<%=vipemail%>" 
      		size="30" maxlength="30" class="2006">
	  </td>
    </tr>
    <tr>
      <td align="right">��ע��</td>
      <td	colspan="3">
      <input name="comment" type="text" id="comment" value="<%=comment%>" size="40" maxlength="50" class="2010">
      <input type="checkbox" value="1" name="getmag" id="getmag" /><label for="getmag">ͬ���������</label>      </td>
    </tr>
	<tr>
      <td align="right">���Ա�ע��</td>
      <td colspan="3">
      <textarea name="remark" cols="50" rows="3" wrap="VIRTUAL" class="2029"><%=fremark%></textarea>      </td>
    </tr>
	<tr>
	  <td align="right">VIP����</td><td><%=vipcode%></td>
	  <td colspan="2">�ܻ���: <%=zcentum%>&nbsp;&nbsp;&nbsp;�ܴ�ֵ: <%=zsums%></td>
	</tr>
	</table>
<%if id="" then%>
    <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
      <tr> 
          <td align="center" colspan="2">������ �� �� �ϣ���</font></td>
      </tr>
        <%fs.source = "select lookname from j18_lookupsub where lookupid='3501' order by lookcode" 
		 fs.open 
		 if not fs.eof then
		 i=1
		   while not fs.eof%>
        <tr> 
          <td align="right"><font size="2"><%=fs("lookname")%>��</font></td>
          <td><input type="text" name="vip_p<%=i%>" size=35 class="editbox1" onKeyDown="if(event.keyCode==13)event.keyCode=9">
		                  <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs("lookname")%>"></td>
        </tr>
        <%fs.movenext
		i=i+1
		wend
		response.write("<input type=hidden name=vip_pnum value="&i-1&">")
		else%>
        <tr> 
          <td align="center" colspan="2"><font size="2">�� �� �� �� ��</font></td>
        </tr>
        <%end if
		fs.close%>
 </table><%else%>
	 <table width="100%"  border="0" cellpadding="3" cellspacing="1" class="f12 Fbox">
<tr> 
          <td align="center" colspan="2">������ �� �� �ϣ���</font></td>
       </tr>
        <%fs.source = "select lookname from j18_lookupsub where lookupid='3501' order by lookcode"
		  fs.open
		 if not fs.eof then
		 i=1
		   while not fs.eof
		     found=false
		     fs1.source = "select p_name,p_value from vip_usersub where vipid='"&id&"'"
			 fs1.open
			 while not fs1.eof
		  if fs1("p_name")=fs("lookname") then
		     found=true%>
		  <tr>
          <td align="right"><font size="2"><%=fs1("p_name")%>��</font></td>
          <td><input type="text" name="vip_p<%=i%>" size=35 value="<%=fs1("p_value")%>" 
          class="editbox1" onKeyDown="if(event.keyCode==13)event.keyCode=9">
		                  <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs1("p_name")%>"></td>
     </tr>
		<%end if
		  fs1.movenext
		  wend
		  fs1.close
		  if not found then%>
		  <tr>
          <td align="right"><font size="2"><%=fs("lookname")%>��</font></td>
          <td><input type="text" name="vip_p<%=i%>" size=35 class="editbox1" onKeyDown="if(event.keyCode==13)event.keyCode=9">
		                  <input type="hidden" name="vip_p<%=i%>_name" value="<%=fs("lookname")%>"></td>
     </tr>
   <%end if
		  fs.movenext
		  i=i+1
		  wend
		response.write("<input type=hidden name=vip_pnum value="&i-1&">")
		else%>
        <tr> 
          <td align="center" colspan="2"> 
            <div align="center"><font size="2">�� �� �� �� ��</font></div></td>
        </tr>
        <%end if
		fs.close%>
</table><%end if%>
	<table width="100%"  border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA" class="f12"> 
	<input type="hidden" value="<%=qts(id)%>" name="vipid">
	<%if act="add" or act="edit" then%>
    <tr>
      <td align="center"><input type="submit" name="Submit" value="�ύ(S)">
      <input type="reset" name="Submit" value="�� ��"></td>
    </tr>
	<%end if%>
  </table>
</form>
</body>
</html>
