<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim depotid,clothingid,userid
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_Userid)
dt=time
dt=hour(dt)&"-"&minute(dt)&"-"&second(dt)

setdate=get_date(date)
daystat=session("daystat")
s_name=session("s_name")
x_name=session("x_name")
comment=session("comment")

set rs=server.createobject("adodb.recordset")
rs.Activeconnection = cn
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
	rs.Update
  end if
  rs.close
  session("retailid")=retailid
end if

%>
<table width="100%"  border="0" class="bar">
  <tr>
    <td>���������б��е���Ʒ [��ɱ�������] [ȡ����������] </td>
  </tr>
</table>
<table width="100%" border="1" class="f12" bordercolorlight="#ECD6D2" bordercolordark="#FFFFFF">
  <tr>
    <td width="15%">����</td>
    <td width="21%">���</td>
    <td width="19%">��ʽ���</td>
    <td width="15%">��ɫ</td>
    <td width="9%">����</td>
    <td width="7%">���</td>
    <td width="14%">&nbsp;</td>
  </tr>
<%dim ds,sql,i
sql=" select c.clothingid,a.styleid,b.s_name,c.colorid,c.sizeid,d.k_num "& _
	" from vip_birthstyle a,j_style b,j_clothing c,j_stock d "& _
	" where a.styleid=b.styleid and a.styleid=c.styleid and a.styleid*=d.styleid and a.sel=1"
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.Source= sql
ds.Open
while not ds.eof%>
  <tr>
    <td><%=ds("s_name")%></td>
    <td><%=ds("styleid")%></td>
    <td><%=ds("clothingid")%></td>
    <td><%=ds("s_name")%></td>
    <td><%=ds("sizeid")%></td>
    <td><%=ds("k_num")%>&nbsp;</td>
    <td>ɾ��</td>
  </tr>
<%ds.movenext
wend
ds.close
set ds=nothing%>
</table>
</body>
</html>
