<%option explicit%>
<!--#include file="../f22/inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP������</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<style>
html,body{ overflow:hidden;}
button{font-size:12px;}

</style>
<base target="vip_main" />
<script type="text/javascript">
function closeWindow(){
	window.close();
	parent.refresh();
}

function buttonclick(t,href){
	var a = document.getElementsByTagName("BUTTON");
	var vip_main = document.getElementById("vip_main")
	vip_main.src=href;
	for(i=0;i<a.length;i++){
			if(a[i].disabled!=true){
				if(a[i]!=t){
					a[i].style.fontWeight='';
				}else{
					a[i].style.fontWeight='bold';
					a[i].blur();
				}
					//alert(a.innerHTML);
			}
	}
}

function KeyDown(){
	with (event){ 
		if(keyCode==27){//ESC��������״̬
			window.close();
			event.keyCode = 0; 
			event.cancelBubble = true; 
			return false;
		}
	}
}
document.onkeydown = KeyDown;



</script>
<style>
button{
width:120px;
text-align:center;
}
</style>
</head>

<body>
<!--
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">VIP������</td>
  </tr>
</table>
-->
<%
dim vipcode,vipurl,vipname,mobtel,zcentum,disabled,updatecheck,updatestr
vipcode = request.QueryString("c")	'VIP����	
disabled = request.QueryString("disabled")	'�Ƿ�ʧЧ��
updatestr = request.QueryString("update")	'�Ƿ������
%>

<table width="100%" border="0" cellspacing="5" cellpadding="0">
<form name="form1" method="post" action="">
<%
if vipcode<>"" then
dim ds,sql,viptypename,vipid,tempcard,pcentum
set ds=Server.CreateObject("ADODB.Recordset")
  sql=" select a.vipname,a.vipid,isnull(a.pcentum,0) as pcentum,isnull(a.centum,0)+isnull(b.starcentum,0) as zcentum,b.vipemit,"&_
			" isnull(a.updatecheck,0) as updatecheck, b.limitday,isnull(b.tempcard,0) as btempcard,c.viptypename from vip_user a,vip_cardvip b, vip_typevip c "&_
			" where a.vipcode=b.vipcardid and isnull(a.vipcode,'')<>'' and c.viptypeid=b.viptypeid and a.vipcode = '"&vipcode&"'"

'  if key="" then sql="select 1 from vip_user where 1=0" 
ds.Open sql,cn,1,1
if not(ds.eof and ds.bof) then
	vipname=ds("vipname")
	zcentum=ds("zcentum")
	updatecheck=ds("updatecheck")
	pcentum=ds("pcentum")
	tempcard=ds("btempcard")
	viptypename=ds("viptypename")
	vipid=ds("vipid")
end if

vipurl = "../crm/vip_xf.asp?id="&vipid&""	'����о���ʾ���Ѽ�¼����

%>
  <tr>
    <td width="130" valign="top">&nbsp;</td>
    <td height="25" align="center">
    �˿ͣ�<%=vipname%>
    �������ţ�<%=ucase(vipcode)%>
    ���������ͣ�<%=viptypename%>
    �������֣�<%=zcentum%>
    �����ϼ����֣�<%=pcentum%></td>
  </tr>
<%
else

vipname=request.QueryString("vipname")
mobtel=request.QueryString("mobtel")

vipurl = "vip_addcard.asp?vipname="&vipname&"&mobtel="&mobtel&""	'���û������ʾ����ҳ��
end if

%>

  
  <tr>
    <td width="130" valign="top"><table width="100%" border="0" cellspacing="5" cellpadding="5">
      <tr>
        <td style="color:#888; ">
        <%if vipcode<>"" then%>
        <button disabled="disabled">�½��˿͵���</button>
        <%else%>
        <button onClick="buttonclick(this,'vip_addcard.asp?vipname=<%=vipname%>&mobtel=<%=mobtel%>');">�½��˿͵���</button>
        <%end if%>
        </td>
      </tr>
      <tr> 
        <td style="color:#888; ">
        <%if vipcode<>"" then%>
        <button onClick="buttonclick(this,'../crm/vip_xf.asp?id=<%=vipid%>');">��ѯ���Ѽ�¼</button>
        <%else%>
        <button disabled="disabled">��ѯ���Ѽ�¼</button>
        <%end if%>
        </td>
      </tr>
      <tr>
        <td style="color:#888; ">
        <%if vipcode<>"" and disabled ="" and updatecheck<>0 then%>
        <button onClick="buttonclick(this,'vip_addcard.asp?act=edit&id=<%=vipid%>');">�޸Ĺ˿͵���</button>
        <%else%>
        <button disabled="disabled" title="�ÿ���ʧЧ">�޸Ĺ˿͵���</button>
        <%end if%>
        </td>
      </tr>
      <tr>
        <td style="color:#888; ">
        <%if updatestr ="true" then%>
        <button onClick="buttonclick(this,'vip_Upgrade.asp?id=<%=vipid%>');">VIP������</button>
        <%else%>
        <button disabled="disabled" title="�ÿ�δ��˻���ʧЧ">VIP������</button>
        <%end if%>
        
        </td>
      </tr>
      <tr>
        <td style="color:#888; ">
        <%if vipcode<>"" and tempcard<>1 and (updatecheck=0 or updatecheck=3) and disabled ="" then%>
        <button onClick="buttonclick(this,'vip_Dollar.asp?vipcode=<%=vipcode%>');">���ֻ���</button>
        <%else%>
        <button disabled="disabled" title="�ÿ�δ��˻���ʧЧ">���ֻ���</button>
        <%end if%>
        </td>
      </tr>
      
      <%if session("cf_VipSet_jfhg")  then%>
      <tr>
        <td style="color:#888; ">
        <%if session("cf_VipSet_jfhg")  and  vipcode<>"" and tempcard<>1 and (updatecheck=0 or updatecheck=3) and disabled ="" then%>
        <button onClick="buttonclick(this,'vip_Award.asp?vipcode=<%=vipcode%>');">���ֽ���</button>
        <%else%>
        <button disabled="disabled" title="�ÿ�δ��˻���ʧЧ">���ֽ���</button>
        <%end if%>
        </td>
      </tr>
      <%end if%>
      <%if session("cf_VipSet_birthgift") then%>
      <tr>
        <td style="color:#888; ">
        <%if vipcode<>"" and tempcard<>1 and (updatecheck=0 or updatecheck=3) and disabled ="" then%>
        <button onClick="buttonclick(this,'vip_Gift.asp?vipcode=<%=vipcode%>');">����������</button>
        <%else%>
        <button disabled="disabled" title="�ÿ�δ��˻���ʧЧ">����������</button>
        <%end if%>
        </td>
      </tr>
      <%end if%>
      <%if session("cf_VipSet_vmbb") then%>
      <tr>
        <td style="color:#888; ">
        <%if vipcode<>"" and tempcard<>1 and (updatecheck=0 or updatecheck=3) and disabled ="" then%>
        <button onClick="buttonclick(this,'vip_ReCard.asp?id=<%=vipid%>');">VIP������</button>
        <%else%>
        <button disabled="disabled" title="�ÿ�δ��˻���ʧЧ">VIP������</button>
        <%end if%>
        </td>
      </tr>
      <%end if%>
      <tr>
        <td style="color:#888; ">
        <button onClick="window.close();">�ر�[Esc]</button>
        </td>
      </tr>
    </table></td>
    <td valign="top"><iframe name="vip_main" id="vip_main" src="<%=vipurl%>"
     frameborder="0" width="100%" height="460" scrolling="auto" marginheight="0" marginwidth="0"></iframe></td>
  </tr>
</form>
</table>
</body>
</html>
