<%option explicit
session("formid")=6100001%>
<!--#include file="inc/function.asp"-->
<%
if not padd then
   call mbox("û������Ȩ�ޣ�")
end if

dim groupname,retailid,userid,dt,depotid,rs,sql,lookupid,oldvalue
dim setdate,vipcode,daystat,s_name,x_name,comment,cookiesdate
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)
session("s_name")=session("dm").System_UserName
dt=time
dt=hour(dt)&"-"&minute(dt)&"-"&second(dt)

setdate=get_date(date)&" "&get_time(time)

cookiesdate=request.Cookies("setdate")

if cookiesdate="" then cookiesdate=get_date(date)

if request.form("x_name2")<>"" then
   session("x_name")=request.form("x_name2")
end if
if request.form("comment2")<>"" then
   session("comment")=request.form("comment2")
end if
if request.form("daystat2")<>"" then
   session("daystat")=request.form("daystat2")
end if
if request.form("setdate2")<>"" then
   response.Cookies("setdate")=request.form("setdate2")
end if

'response.write s_name
'response.end
set rs=server.createobject("adodb.recordset")
rs.Activeconnection = cn
rs.LockType = 1

Function Getzmdate(Dptid)
  sql="select isnull(convert(char(10),zmrqdate,126),'1900-01-01') as zmdate from j_depot where depotid='"&Dptid&"'"
  rs.open sql,cn,1,1
  Getzmdate=rs("zmdate")
  rs.close
End Function

sub get_rs(oldvalue)
set rs=server.CreateObject("adodb.recordset")
	sql="select a.shopcardid,a.shopname,a.rate from vip_shopcard a "&_
			"where a.shopcardid in (select b.shopcardid "&_
			"from vip_shopcarddpt b "&_
			"where b.depotid = '"&depotid&"' )"
	rs.open sql,cn,1,1
	response.write("<option value=''></option>")
		do while not rs.eof
			response.write"<option value="&rs(0)
			if rs(0)=oldvalue then response.Write" selected " end if
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
<title><%=session("dm").System_DepotName%>����</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script type="text/javascript" src="../../../js/sound.js"></script>
<script language="javascript">
var sname=new Array();
var xname=new Array();
var si=0,xi=0;
var oldvalue;
//alert(sname[1,0]);
</script>
<script language="javascript">
function chang(the){
  var v=the.value;
  var s="";
	for(i=0;i<=si;i++){
	  if(sname[i][0]==v){
	    s=s + "<option value="+sname[i][1]+">"+sname[i][2]+"</option>";
	  }
	}
	document.all.xname.innerHTML="<select size=1 name=\"s_name\" style=\"width:80px;\">"+s+"</select>";
}
function checkform(){
  var key=document.form1.key;
  var clothingid;
  var v=trim(key.value);
  if(v==null || v==""){
    document.form1.key.focus();
    return false;
  }else{
    key.value=v.toUpperCase();
    clothingid=document.form1.clothingid;
		clothingid.value=key.value;
    return true;
  }
}

function launchCenter(act){
  switch(act){
  case "xp":
    showModalDialog("pos_cdxp.asp?act="+act,window,"dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no");
	//window.open('pos_cdxp.asp?act="+act');
	return;
  case "qd":
    var sm=showModalDialog("pos_operation.asp?act="+act,window,"dialogWidth:420px;dialogHeight:150px;center: yes;help:no;resizable:no;status:0");
	if(sm==1) window.location.reload();
	return;
  case "zf":
    window.location.href="pos_control.asp?act=zf";
	return;
 // case "th":
	//var s=showModalDialog('pos_th.asp','new','dialogWidth:620px;dialogHeight:360px;center: yes;help:no;resizable:no;status:no');
	//is.location.reload();
  //  return;
	
  case "sy":
    //var sm=showModalDialog("pos_print.asp?id=<%=retailid%>&act="+act,window,"dialogWidth:450px;dialogHeight:450px;center: yes;help:no;resizable:no;status:no");
	window.open("<%=session("xpname")%>?id=<%=retailid%>&act="+act,window,"dialogWidth:450px;dialogHeight:450px;center: yes;help:no;resizable:no;status:no");
    if(sm==1){//window.location.reload();
	  window.location.href="pos_create_retail.asp";
	}
	return true;
  }
  var sm=showModalDialog("pos_operation.asp?act="+act+"&setdate="+document.form1.setdate.value,window,"dialogWidth:320px;dialogHeight:150px;center: yes;help:no;resizable:no;status:no");
  if(sm==1) window.location.reload();
  if(sm==2) is.location.reload();
}

function thnew()
{ var sm=showModalDialog("pos_thnew.asp?setdate="+document.form1.setdate.value,window,"dialogWidth:400px;dialogHeight:280px;center: yes;help:no;resizable:no;status:no");
  //if(typeof(sm)!='undefined'){document.form1.vipcode.value=sm.toUpperCase();}
  if(sm==1)window.location.reload();
  if(sm==2)is.location.reload();
}

function vipdata(v){
if(document.form1.vipcode.value!=''){
	alert('�Ѿ�������VIP���������������룡');
	v.value='';
<%if session("cf_useShopcard") then%>
}else if(document.form1.shopcard.value!=''){
  alert('VIP���������̳���ͬʱʹ��!');
	v.value=''
<%end if %>
}else{
	var vip=trim(v.value);
  v.style.color="#000000"
  vip=vip.toUpperCase();
  v.value='';
  is.location.href="pos_control.asp?act=vip&vipcode="+vip;
  //var sm=showModalDialog("pos_sy.asp?act="+act,window,"dialogWidth:400px;dialogHeight:400px;center: yes;help:no;resizable:no;status:no");
 }
}
<%if session("cf_useShopcard") then%>
function jump(t){
	if(document.form1.vipcode.value!=''){
		t.value=''
		alert('VIP���������̳���ͬʱʹ��!');
	}else{
		is.location.href="pos_control.asp?act=shopcard&shopcard="+t.value;
	}
}
<%end if%>
function sy(){
  form2_submit();
  var act;
  var sm=showModalDialog("pos_zs.asp?act="+act+"&setdate="+document.form1.setdate.value,window,"dialogWidth:400px;dialogHeight:400px;center: yes;help:no;resizable:no;status:no");
  //window.open("pos_zs.asp?act="+act,'','Width=400px;Height=400px;center: yes;');
	//window.open("pos_sy.asp?act="+act,'',"Width=400px;Height=300px;center: yes;help:no;resizable:no;status:no");
	//if(sm==1) {//window.location.reload();
		window.location.href="pos_create_retail.asp";
	//}
}

function vip(){
  var m;
  var v;
  if(document.form1.vipcode.value!=''){
    if(v!=document.form1.vipcode.value){
      v=document.form1.vipcode.value;
	}
  	m=showModalDialog('vip_user.asp?vipcode='+document.form1.vipcode.value,'vipmx','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
    //if(m=="0"){document.form1.vipcode.value="";document.form1.vipcode.focus();}
  }else{
    alert('VIP����Ϊ�գ�');document.form1.tmpvipcode.focus();
  }
}

function ivip(t){
if (t==1){
	<%if session("cf_useShopcard") then%>
		if(document.form1.shopcard.value!=''){
			alert('VIP���������̳���ͬʱʹ��!');
			return false;
		}else{
	<%else%>
		if(1==1){
	<%end if%>
				var m;
				m=showModalDialog("../vip/vip_search.asp",window,"dialogWidth:420px;dialogHeight:230px;center: yes;help:no;resizable:no;status:no");
				if(m!="0" && typeof(m)!='undefined'){
					document.form1.vipcode.value=m.toUpperCase();
					document.form1.vipcode.style.color="#000000";
					is.location.href="pos_control.asp?act=vip&vipcode="+m;
				}
		}
	}else{
		showModalDialog('pos_ivipzk.asp','vipzk','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
	}
}

function ivip2(t){
	if (t==1){
		var m;
		m=showModalDialog('pos_ivip.asp?vipcode='+document.form1.vipcode.value,'vipmx','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
		if(m!="0" && typeof(m)!='undefined'){
			document.form1.vipcode.value=m.toUpperCase();
		document.form1.vipcode.style.color="#000000";
		//document.form1.key.focus();
		is.location.href="pos_control.asp?act=vip&vipcode="+m;
		}else{
		//document.form1.vipcode.value="";
		//document.form1.vipcode.focus();
		}}
	else{
		showModalDialog('pos_ivipzk.asp?act=1&key='+document.form1.vipcode.value,'vipzk','dialogWidth:500px;dialogHeight:390px;center: yes;help:no;status:no');
	}
}


function KeyDown(){
	with (event){ 
		if (keyCode==113){ //F2����
			sy();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
    <% if session("cf_VipSet_syjm") then%>
		}else if(keyCode==114){//F3 VIP�˿Ͳ���
			ivip(1);
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		<%end if%>
		}else if(keyCode==27){//ESC��������״̬
			document.getElementById("key").focus();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==117){//F6����
			if(confirm('ȷ��Ҫ�������ŵ���')){launchCenter('zf');}
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==116){//F5�ҵ�
			launchCenter('gd');
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==118){//F7ȡ��
			launchCenter('qd');
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==119){//F8����
			launchCenter('zs');
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==120){//F9�˻�
			//launchCenter('th');
			thnew();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==122){//F11��������
			launchCenter('zk');
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}else if(keyCode==123){//F12�ش�СƱ
			launchCenter('xp');
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false; 
		}
	}
}
document.onkeydown = KeyDown;
</script>
    <script type="text/javascript">
    function chkzmrq()
	{
		var setdate=document.getElementById("setdate");
		var zmdate=document.getElementById("zmdate");
		if(setdate.value<=zmdate.value)
		{
			setdate.title="��������Ŀ������";
			setdate.style.color="red";
		}else{
			setdate.title="";
			setdate.style.color="";
		}
	}
	setTimeout(chkzmrq,0);
	
	function playSound(n)
    {
	   var count=parseInt(form1.hdcount.value);
	   if (count<parseInt(n))
	   {
	      PlayScanSound();
	   }
	   form1.hdcount.value=parseInt(n);
    }
    </script>
</head>

<body>
<embed id="soundControl" src="../../../sound/scan.wav"  mastersound hidden="true" loop="false" autostart="false"></embed>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bar" >
  <tr>
    <td align="center"> <%=session("dm").System_DepotName%>���� </td>
  </tr>
</table>
<form action="pos_control.asp" method="get" name="form1" target="is" onSubmit="return checkform();">
<input type="hidden" id="hdcount" value="0">
<table width="98%" style="margin:5px 0;" border="0" align="center" cellpadding="0" cellspacing="3" class="bkf12">
  <tr>
    <td>���۵��
      <input name="depotname" type="text" value="<%=session("dm").System_DepotName%>" size="14" maxlength="20" readonly>
      <input name="depotid" type="hidden" id="depotid" value="<%=depotid%>">
       ����Σ�
       <select name="x_name" id="x_name"  style="width:80px; ">
        <%
		  sql="select groupname from jk_group group by groupname"
		  'de sql
		  rs.Cursortype = 1
		  rs.source = sql
		  rs.open
          if not rs.eof then
		    groupname=rs("groupname")
		  else
		    response.write("<script>alert('���Ƚ�����Σ�');window.location='pos_option.asp';</script>")
			response.end
		  end if
		  rs.moveFirst
		  while not rs.eof%>
        <option value="<%=trim(rs("groupname"))%>" 
		<%if session("x_name")=rs("groupname") then 
		groupname=rs("groupname")
		response.Write(" selected") 
		end if%>>
        <%response.write(rs("groupname"))%>
        </option>
        <%
		rs.movenext
		  wend
		  rs.close
		  %>
          </select>
      &nbsp;���ڣ�
        <input name="setdate" type="text" id="setdate"
		    <%if session("ModifySaleDate")=1 then 
			    response.Write("onFocus='setday(this,this,chkzmrq);'") 
              end if %>
            onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"
            onKeyDown="if(event.keyCode==13)event.keyCode=9"
            value="<%=get_date(cookiesdate)%>" size="10" maxlength="10" readonly="readonly" />
		<input name="zmdate" type="hidden" id="zmdate" size="10" value="<%=Getzmdate(session("dm").System_DepotID)%>">
		&nbsp;������
    <input name="daystat" type=text class="box" id="daystat" value="<%=session("daystat")%>" size="13" maxlength="13"></td>
    </tr>
  <tr>
    <td>�������ţ�
      <input name="key" type="text" id="key" size="14" maxlength="30" autocomplete="off" onFocus="this.select();" />
      <input name="clothingid" type="hidden" id="clothingid">
      &nbsp;&nbsp;�����ȡ��
      <input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>">
      &nbsp;&nbsp;��ע��
      <input name="comment" type="text" id="comment" onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=session("comment")%>" size="32" maxlength="50">
      &nbsp;&nbsp;<font size=2 color="#999999">
   <%response.write("���㷽ʽ:")
	  select case session("dm_round")
	  case 0 response.write("��������")
	  case 1 response.write("ֻ�벻��")
	  case 2 response.write("��������")
	  case 3 response.write("ֻ�᲻��")
	  end select%>
   </font>
      <input name="act" type="hidden" id="act" value="add">
      <input type="submit" name="Submit" style="width:0px;">
      </td>
    </tr>
    
</table>
<%
daystat=session("daystat")
s_name=session("s_name")
x_name=session("x_name")
comment=session("comment")
rs.LockType = 3
if session("retailid")="" then
  retailid=depotid&"-"&userid&"-"&dt
  rs.Source = "select * from webtmp_retail where retailid='"&retailid&"'"
  rs.Open
  if rs.Eof then '�µ�
    rs.Addnew
	rs("retailid")=retailid
	rs("depotid")=depotid
    rs("setdate")=setdate
	rs("daystat")=daystat
	rs("s_name")=s_name
	rs("x_name")=x_name
	rs("comment")=comment
	rs("userid")=userid
	rs.Update
  end if
  rs.close
  session("retailid")=retailid
  
else
    rs.Source = "select * from webtmp_retail where retailid='"&session("retailid")&"'"
	rs.Open
	   ' rs("retailid")=retailid
		rs("depotid")=depotid
		'rs("setdate")=setdate
		rs("daystat")=daystat
		rs("s_name")=s_name
		rs("x_name")=x_name
		rs("comment")=comment
	rs.Update
	'response.write daystat&x_name
	'response.end
end if
set rs=nothing
%>
<table width="98%" border="0" align="center" height="65%" cellpadding="0" cellspacing="2" bordercolor="#b2d7db" bgcolor="#e9f6f5" class="bkf12">
  <tr>
      <td><iframe name="is" width="100%" height="100%" frameborder="0" src="pos_create_retail_sub.asp" class="bk" scrolling="auto" style="border-color:#A7918C; "></iframe>
</td>
  </tr>
</table>
<table width="98%" border="0" align="center" style="margin-top:5px;" cellpadding="0" cellspacing="2" bordercolor="#b2d7db" bgcolor="#e9f6f5" class="bkf12">
  <tr><td align="center">
	  <%
      if session("cf_VipSet_symb") = 1 then
        response.write "�����ֻ����루VIP���ţ���"
      else
        response.write "VIP����"
      end if
      %>
  <input name="tmpvipcode" type="text" id="tmpvipcode" onFocus="this.select()"
    onKeyDown="if(event.keyCode==13&&this.value){vipdata(this)}" size="10" autocomplete="off">
	<%if session("cf_VipSet_MoreInput") then%>
  <input type="button" name="Submit" value="����" onClick="ivip2(1);" class="btn btn_sm">
	<%if session("posvipcode")<>"" then%>
  <input type="button" value="�鿴" title="�鿴VIP�������" onClick="ivip(1);" class="btn btn_sm">
    <%end if%>
    <%end if%>
  <input type="button" name="Submit" value="�鿴�ۿ�" onClick="ivip2(2);" class="btn">
      &nbsp;
      ��ǰVIP����
      <input type="text" name="vipcode" id="vipcode" readonly style="background-color:#e6e6e6;" size="10" value="<%=session("posvipcode")%>">
	<%if session("cf_useShopcard") then%>
   &nbsp;&nbsp;�̳�����
   <select name="shopcard" id="shopcard" onChange="jump(this)" class="btn">
        <% get_rs session("shopcard")%>
   </select>
    <% end if%>
       </td>
  </tr>
  <tr>
    <td height="30" align="center">
    <input type="button" name="subm" id="subm" value="�� ��[F2]" title="����" onClick="javascript:sy();" class="btn">
    <% 
	dim vipstr
	if session("cf_VipSet_syjm") and session("cf_VipSet_MoreInput")=false  then
	vipstr = "ʹ��VIP��"
	if session("posvipcode")<>"" then vipstr = "�鿴VIP��"
	%>
	<input type="button" name="vip_button" id="vip_button" value="<%=vipstr%>" title="�½���ʹ��VIP��[F3]"  onClick="ivip(1);" class="btn">
    <% end if%>
	<!--<input type="button" name="subm" id="subm" value="�� ��[F3]" style="width:70px" onClick="javascript:sy();" >-->
	<input name="alldel" type="button" value="��������[F6]"  title="��������" onClick="if(confirm('ȷ��Ҫ�������ŵ���')){launchCenter('zf')}" class="btn">
  <input name="gd" id="gd" type="button"  value="�ҵ�[F5]" title="�ҵ�" onClick="launchCenter('gd')" class="btn">
  <input name="qd" id="qd" type="button"value="ȡ��[F7]" title="ȡ��" onClick="launchCenter('qd')" class="btn">
	<%if not session("pos_nozs") then%>
  <input name="zs" type="button" value="����[F8]" title="����" onClick="launchCenter('zs')" class="btn btn_red">
	<%end if%>
  
  <input name="th" type="button" value="�˻�[F9]" title="�˻�" onClick="thnew()" class="btn btn_yellow">
  <%if session("dm_zk") then%>
	<input name="allzk" type="button" value="��������" title="����������ţ��ٽ����������ۣ�[F11]" onClick="launchCenter('zk')" class="btn">
	<%end if%>
    <%if session("xpname")<>"" then%>
	<input type="button" value="�ش�СƱ" title="�ش�СƱ[F12]"onClick="launchCenter('xp')" class="btn">
    <%end if%>    </td>
  </tr>
</table>
</form>
<form name="form2" action="pos_create_retail.asp" method="post">
<input name="x_name2" type="hidden" id="x_name2">
<input name="comment2" type="hidden" id="comment2">
<input name="daystat2" type="hidden" id="daystat2">
<input name="setdate2" type="hidden" id="setdate2">
</form>
<script language="javascript">

function form2_submit(){
document.form2.x_name2.value=document.form1.x_name.value;
document.form2.comment2.value=document.form1.comment.value;
document.form2.daystat2.value=document.form1.daystat.value;
document.form2.setdate2.value=document.form1.setdate.value;
document.form2.submit();
}

</script>
</body>
</html>