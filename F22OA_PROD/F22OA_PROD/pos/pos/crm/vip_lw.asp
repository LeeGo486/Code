<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
dim ds,sql,depotid,t
dim vipcode,clothingid
dim flag,i
flag=false
depotid=trim(session("dm").System_depotid)
set ds=server.createobject("adodb.recordset")
ds.activeconnection=cn

if trim(request.form("clothingid"))<>"" then
   flag=true
   clothingid=trim(request.form("clothingid"))
   ds.source="select c.clothingid,a.styleid,b.s_name,c.colorid,c.sizeid,d.k_num "& _
	" from vip_birthstyle a,j_style b,j_clothing c,j_stock d "& _
	" where a.styleid=b.styleid and a.styleid=c.styleid and a.styleid*=d.styleid and a.sel=1"
   ds.open
   if ds.eof then
    response.write"<script>alert('��Ų����ڻ��������\r\n����������!');</script>"
	'else
	'sql="select * from vip_user where vipcode='"&vipcode&"'"
   end if
   
end if
%>
<table border=0 width=100% bgcolor=#ffffff>
  <tr>
    <form name="get_form" method="post" action="">
      <td width="60%" vAlign=top> ��������������:
          <input name="clothingid" type="text" id="clothingid" size="20" onKeyDown="if(event.keyCode==13){submit();}">
          <input type="button" name="Submit" value="ѡ����������">
      </td>
    </form>
    <td width="40%" height="20" vAlign=top>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" vAlign=top>
          <table border=1 cellpadding="1" cellspacing="0" bordercolordark="#ffffff" bordercolorlight="#00000f" >
            <thead>
              <tr bgcolor="#FFCC99">
                <th width="28">&nbsp;</th>
                <th width="110">���</th>
                <th width="101">��ʽ</th>
                <th width="89">��ɫ</th>
                <th width="78">����</th>
                <th width="72">����</th>
                <th width="100">���</th>
              </tr>
			  <%if flag then show %>
            </thead>
          </table>
</td>
  </tr>
</table>
<%
sub show
i=0
do while not ds.eof
i=i+1
%>
              <tr>
                <th><%=i%></th>
                <th width="87"><%=ds("clothingid")%></th>
                <th width="101"><%=ds("styleid")%></th>
                <th width="89"><%=ds("colorid")%></th>
                <th width="78"><%=ds("sizeid")%></th>
                <th width="72">&nbsp;</th>
                <th width="100">&nbsp;</th>
              </tr>
 <%
 ds.movenext
 loop
 end sub
%>
</body>
</html>
