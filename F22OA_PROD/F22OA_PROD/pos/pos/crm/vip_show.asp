<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim act,ds,id
set ds=server.CreateObject("ADODB.Recordset")
set rs=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
rs.ActiveConnection = cn
id=trim(request.QueryString("id"))
act=trim(request.QueryString("act"))
if act="" then
  act="add"
end if

select case act
case "del"

case "add"


case "view","edit"
  if id<>"" then
    sql="select * from vip_user where vipid="&qts(id)
	ds.Source= sql
	ds.Open
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
  vipsize=ds("vipsize")
  vipsize1=ds("vipsize1")
  city=ds("city")
  vipapply=ds("vipapply")
  viplove=ds("viplove")
  vipmax=ds("vipmax")
  vipmin=ds("vipmin")
  vipplace=ds("vipplace")
	
	end if
	ds.close
  end if
end select

set ds=nothing


%>

<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP��Ա����</td>
  </tr>
</table>

<form name="form1" method="post" action="vip_save.asp">
  <table width="100%"  border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA" class="f12">
    <tr>
      <td width="12%" align="right">����:</td>
      <td width="38%"><%=vipname%>     </td>
      <td width="8%" align="right" nowrap>��װ���:</td>
      <td width="42%">

	  <%=vipgrab%>
	 </td>
    </tr>
    <tr>
      <td align="right">�Ա�:</td>
      <td><%=vipsex%></td>
      <td align="right">ϲ����ʽ:</td>
      <td><%=vipstyle%></td>
    </tr>
    <tr>
      <td align="right">��������:</td>
      <td><%=vipbirth%>&nbsp;</td>
      <td align="right">��װ����:</td>
      <td><%=vipsize%></td>
    </tr>
    <tr>
      <td align="right">���:</td>
      <td><%=stature%>
        CM ��Χ:
          <%=waistline%>
          CM
</td>
      <td align="right">��װ����:</td>
      <td><%=vipsize1%></td>
    </tr>
    <tr>
      <td align="right">֤������:</td>
      <td><%=vippaper%>&nbsp;</td>
      <td align="right">��������:</td>
      <td>
	   <%=city%>
            </td>
    </tr>
    <tr>
      <td align="right">֤������:</td>
      <td><%=vippassport%>&nbsp;</td>
      <td align="right">��췽ʽ:</td>
      <td><%=vippassport%></td>
    </tr>
    <tr>
      <td align="right">����:</td>
      <td><%=people%></td>
      <td align="right">���˰���:</td>
      <td><%=viplove%></td>
    </tr>
    <tr>
      <td align="right">ְҵ:</td>
      <td nowrap><%=vipoccupation%>
        ����:
        <%=vippay%>
</td>
      <td align="right">���ﳡ��:</td>
      <td><%=vipplace%></td>
    </tr>
    <tr>
      <td align="right">�̶��绰:</td>
      <td nowrap><%=viptel%>
      �ƶ��绰:      <%=mobtel%></td>
      <td align="right">���ܼ�λ1:</td>
      <td><%=vipmin%></td>
    </tr>
    <tr>
      <td align="right">��������:</td>
      <td><%=vipemail%></td>
      <td align="right">���ܼ�λ2:</td>
      <td><%=vipmax%></td>
    </tr>
    <tr>
      <td align="right">����:</td>
      <td colspan="3"><%=country%></td>
    </tr>
    <tr>
      <td align="right">�ʱ�:</td>
      <td colspan="3"><%=vippostalcode%></td>
    </tr>
    <tr>
      <td align="right">ͨ�ŵ�ַ:</td>
      <td colspan="3"><%=vipadd%></td>
    </tr>
    <tr>
      <td align="right">��ע:</td>
      <td colspan="3"><%=comment%></td>
    </tr>

    <tr align="center">
      <td colspan="4">
      <input type="button" name="Submit" id="btn" value="����" onClick="javascript:history.go(-1)"></td>
      </tr>

  </table>
  <script>
  function window.onload(){
		if(!window.name){
		var btn=document.getElementById('btn');
			btn.value='�ر�';
			btn.onclick=function(){window.close()};
		}
	}
  </script>
</form>
</body>
</html>
