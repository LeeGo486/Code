<!--#include file="inc/function.asp"-->
<html>
<head>
<title>���ֵֿ��ֽ�</title>
<base target="_self">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function KeyDown()
{ if(window.event.keyCode==27)//ESC��������״̬
   {//window.opener.document.form1.clothingid.focus();
    window.close();}
}
function jsradio(radio,li){
	var b = document.getElementById("grid_body");
	var a = document.getElementsByTagName("LI");
	for(i=0;i<a.length;i++){
		a[i].className="";
	}
		li.className="gridSel";
		radio.checked=true;
}
function sch(a,b){
	document.getElementById(a).style.display=''
	document.getElementById(b).style.display='none'
}

function rt(_this)
{
	_this.value=parseFloat(reNumber(_this.value)).toFixed(<%=session("cf_VipSet_jfxs") %>);

	if(_this.value>=0){
	
	//����
		var ctp=document.getElementById("ctp");
	//�����
		var rtp=document.getElementById("rtp");
	//������
		var rtj=document.getElementById("rtj");
	
		var inputrtp=document.getElementById("inputrtp");
		var inputrtj=document.getElementById("inputrtj");
		var inputrtp2=document.getElementById("inputrtp2");
		var inputrtj2=document.getElementById("inputrtj2");
		
		var centum=document.getElementById("centum");
		var ys=document.getElementById("ys");
		var qh=document.getElementById("qh");
		var tf=document.getElementById("tf");
		
		ctp = parseFloat(reNumber(ctp.value));
		rtp = parseFloat(reNumber(rtp.value));
		rtj = parseFloat(reNumber(rtj.value));
		
		if(parseFloat(reNumber(inputrtp.value))>rtp){
			inputrtp.value=rtp.toFixed(2);;
			alert('����Ľ���ѳ������ֿ۽��');
			
		}else if(parseFloat(reNumber(inputrtj.value))>rtj){
			inputrtj.value=rtj.toFixed(2);;
			alert('����Ļ����ѳ������ֿ۽��');
			
		}else if(parseFloat(reNumber(inputrtp.value))%tf.value!=0&&tf.value>0){
			inputrtp.value=rtp.toFixed(2);;
			alert('����Ľ������� '+tf.value+' �ı���!');
			
		}else if(parseFloat(reNumber(inputrtj.value))%qh.value!=0&&qh.value>0){
			inputrtj.value=rtj.toFixed(2);;
			alert('�ֿۻ��ֱ����� '+qh.value+' �ı���!');
		}
		
		if(_this==inputrtp){
			inputrtj.value = (ctp*parseFloat(inputrtp.value)).toFixed(2);
		}else if(_this==inputrtj){
			inputrtp.value = (parseFloat(inputrtj.value)/ctp).toFixed(2);
		}

		inputrtp2.value = (parseFloat(ys.value)-parseFloat(inputrtp.value)).toFixed(2);
		inputrtj2.value = (parseFloat(centum.value)-parseFloat(inputrtj.value)).toFixed(2);
	}
}

//�ж��Ƿ�Ϊ��������
function reNumber(str){
	if(parseFloat(str).toFixed(2)>0){
		str=parseFloat(str).toFixed(2);
	}else{
		str=(0).toFixed(2);
	}
return str;
}

</script>
<body onkeydown="KeyDown()">
<form name="form1" method="post" action="pos_cashjf_save.asp">
<%
vipcode=trim(request("vipcode"))
ys =request("ys")
msg=request("msg")
set rs=server.createobject("adodb.recordset")
if vipcode<>"" then
	sql=chkvip(vipcode,0)
	rs.open sql,cn,1,1
	if rs.eof then
		close("��VIP�������ڻ���ʧЧ!")
	else
		 zcentum=rs("centum")
	end if
	rs.close
astr ="<br>���˿��ĵ�ǰ�ܻ���Ϊ��"&zcentum
else
%>
    <div>
    <label>
    <input name="schtype" type="radio" id="schtype" value="vip" checked onClick="sch('sch_vip','sch_mobile')">
    VIP����</label><label>
    <input name="schtype" type="radio" id="schtype" value="mobile" onClick="sch('sch_mobile','sch_vip')">
    ����+�ֻ�</label>
    </div>
    <div id="sch_vip">
    ��VIP���ţ�
    <input type="text" name="xvipcode" id="xvipcode" value="<%=v%>">
    </div>
    <div style="display:none" id="sch_mobile">
    ��������
    <input type="text" name="vipname" id="vipname" size="12">
    �ֻ���
    <input type="text" name="mobtel" id="mobtel" size="12" >
    </div>
</from>
<%
end if
astr="<span style='color:red'>"&msg&"</span>"
%>
<div id="jfText"><%=astr%></div>
<input type="hidden" name="centum" value="<%=zcentum%>">
<input type="hidden" name="vipcode" value="<%=vipcode%>">
<%if session("cf_VipSet_jfdx")=1 then%>
  <div id="grid">
    <div id="grid_header">
      <ul>
        <li>
        <div style="width:60px;">ѡ��</div>
        <div style="width:100px;">������</div>
        <div style="width:50px;">����</div>
        <div style="width:50px;">��</div>
        </li>
      </ul>
    </div>
    <div id="grid_body" style="height:110px; text-align:center;">
      <ul>
      <li onClick="jsradio(document.getElementById('val0'),this)" id="li0"
			<%if reNull(session("fjfnums"))=0 then response.write "class='gridSel'"%>>
        <div style="width:60px;"><input type="radio" name="val" id="val0" onClick="jsradio(this,document.getElementById('li0'))"
         value="" <%if reNull(session("fjfnums"))=0 then response.write "checked=checked"%>  /></div>
        <div style="width:100px;">��ʹ��</div>
        <div style="width:50px;">-</div>
        <div style="width:50px;">-</div>
      </li>
		<%
		sql="select fjfcertid,fjfcertname,isnull(fjfnums,0) as fjfnums,isnull(fjfcash,0) as fjfcash "&_
				" from "&session("vipver_db")&"vip_jfcert where fisuse=1 order by fjfcertid"
		rs.open sql,cn,1,1
    if not rs.eof then
    i=1
    while not rs.eof
			fjfnums = rs("fjfnums")
		%>
      <li onClick="jsradio(document.getElementById('val<%=i%>'),this)" id="li<%=i%>"
       <%if reNull(fjfnums)=reNull(session("fjfnums")) then response.write "class='gridSel'"%>>
        <div style="width:60px;"><input type="radio"
                                     name="val" id="val<%=i%>" onClick="jsradio(this,document.getElementById('li<%=i%>'))"
                                     value="<%=rs("fjfcertid")%>" <%if reNull(fjfnums)=reNull(session("fjfnums")) then response.write "checked=checked"%> /></div>
        <div style="width:100px;"><%=rs("fjfcertname")%></div>
        <div style="width:50px;"><%=fjfnums%></div>
        <div style="width:50px;"><%=rs("fjfcash")%></div>
      </li>
    <%i=i+1
    rs.movenext
    wend
    else
      response.write("<script>alert('û�����û��ֵֿ۽���¼��');window.close();</script>")
        response.end
    end if
    rs.close

	%>
      </ul>
    </div>
  </div>
<%elseif session("cf_VipSet_jfdx")=2 then%>

<%


rtp=0
rtj=0

ys =request.querystring("ys")
if ys = "" then ys=0

if ys<>0 then
	sql=" select isnull(a.centumtoprice,1), isnull(a.retaildkbl,0), isnull(a.gocentum,0), isnull(a.tofromdip,0) "&_
		" from vip_typevip a,vip_cardvip b "&_
		" where a.viptypeid=b.viptypeid and b.vipcardid='"&vipcode&"'"
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		ctp = rs(0)
		retaildkbl = rs(1)
		gocentum = rs(2)	'�𻻻���
		tofromdip = rs(3)	'����
		
		'��ʹ�û���
		if cdbl(zcentum)>cdbl(gocentum) and tofromdip>0 then
			oldzcentum = zcentum
			zcentum = Int(cdbl(zcentum)/(cdbl(ctp)*cdbl(tofromdip)))*(cdbl(ctp)*cdbl(tofromdip))
			weishu = cdbl(oldzcentum) - cdbl(zcentum)
			
		elseif tofromdip>0 then
			zcentum = 0
			weishu = 0
		end if

		
	end if
	rs.close
	
if session("posvipcode")<>vipcode then
	retaildkbl = 100
end if

	'����ֿܵ۵Ľ��
	if cdbl(ctp)>0 then
	  '����ֶܵ���Ǯ
	  retaildkbl = formatNumber((cdbl(ys)*cdbl(retaildkbl)/100),session("cf_VipSet_jfxs") ,-1,-1,0)

	  '��ǰ��������ֶܵ���Ǯ
	  centumtoprice =  formatNumber((cdbl(zcentum)/cdbl(ctp)),session("cf_VipSet_jfxs") ,-1,-1,0)
			
	if session("cf_VipSet_jfxs") >0 then
		rtp=cdbl(ys)-formatNumber((cdbl(ys)-retaildkbl),0,-1,-1,0)
	else
		rtp=cdbl(retaildkbl)
	end if
	rtj=formatNumber(cdbl(rtp)*cdbl(ctp),session("cf_VipSet_jfxs") ,-1,-1,0)
	  
	  	if cdbl(rtj)>cdbl(zcentum) then
			rtp=centumtoprice
			rtj=cdbl(zcentum)
		end if
		if tofromdip>0 then
			if not(cdbl(rtp) mod cdbl(tofromdip)=0) then
				rtp = (cdbl(rtp)\ cdbl(tofromdip))*cdbl(tofromdip)
				rtj = rtp*cdbl(ctp)
			end if
		end if
	end if

%><br>
<input name="qh" type="hidden" value="<%=gocentum%>">
<input name="tf" type="hidden" value="<%=tofromdip%>">
<input name="ys" type="hidden" value="<%=ys%>">
<input name="ctp" type="hidden" value="<%=ctp%>">
<input name="rtp" type="hidden" value="<%=rtp%>">
<input name="rtj" type="hidden" value="<%=rtj%>">
  <table width="100%" height="60" border="0" cellpadding="0" cellspacing="3">
    <tr> 
      <td align=right>�ֿ۽�</td>
      <td>
      <input type="text" name="inputrtp" id="inputrtp" style="width:100px" value="<%=rtp%>" class="box"
       onKeyDown="if(event.keyCode==13){event.keyCode=9}" onChange="rt(this)">
      </td>
    </tr>
    <tr>
      <td align=right>�ֿۻ��֣�</td>
      <td>
      <input type="text" name="inputrtj" id="inputrtj" style="width:100px" value="<%=rtj%>" class="box" 
      onKeyDown="if(event.keyCode==13){event.keyCode=9}"  onChange="rt(this)">
      </td>
    </tr>
    <tr>
      <td align=right>�ֿۺ�Ӧ����</td>
      <td><input type="text" name="inputrtp2" id="inputrtp2" style="width:100px"
       value="<%=formatNumber((cdbl(ys)-rtp),2,-1,-1,0)%>" readonly class="box box1"></td>
    </tr>
    <tr>
      <td align=right>�ֿۺ��ϻ��֣�</td>
      <td><input type="text" name="inputrtj2" id="inputrtj2" style="width:100px" 
      value="<%=formatNumber(cdbl(zcentum)-rtj+weishu,2,-1,-1,0)%>" readonly class="box box1"></td>
    </tr>
</table>
<%
end if
end if%>
  <table width="100%" height="60" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td><div align="center">
	  <input type="submit" name="Submit" value="  ȷ�ϵֿ� " class=box>
	  <input type="button" name=but value=" ȡ��[Esc] " onClick="window.close()" class=box>
	  </div></td>
    </tr>
</table>
</form>
</body>
</html>
<%
set rs=nothing
cn.close
set cn=nothing%>