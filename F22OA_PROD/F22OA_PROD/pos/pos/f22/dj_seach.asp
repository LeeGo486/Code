<%
session("formid")=6100014
%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<link href="css/link.css" rel="stylesheet" type="text/css">
<title>�������</title>
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript">
function openwin(url,width,height)
{
	var m=showModalDialog(url,window,'dialogWidth:'+width+'px;dialogHeight:'+height+'px;center: yes;help:no;resizable:yes;status:no');
	if(m)location.reload();
	return false;
	}
</script>
</head>
<body>
<table width="400" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">��ǰλ�ã�--&gt; ҵ����� --&gt; �������</font></td>
  <%if padd then%>
  <td><input type="button" name="but" value="����¶���" class=box onClick="openwin('dj_seach_add.asp','600','400')"></td>
  <%end if%>
  </tr>
</table>
<hr size="2">
  <table width="100%" class="noprint">
    <tr><td>
      <table width="750" height="66" border="0" cellspacing="0">
        <form name="form1" method="get" action="dj_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td><font size="2">��ѯ��ʽ��</font> 
                <select name="types" id="types">
                  <option value="0">����δ��</option>
                  <option value="1">�����ѽ�</option>
                  <option value="2">��������ѯ</option>
                  <option value="3">ȫ��</option>
                </select></td>
            <td><font size="2">������
            <input name="names" type="text" size="12" class="editbox2"></font>
			    &nbsp;&nbsp;
			    <font size="2">��ʽ��
          <input name="styleid" type="text" size="20" class="editbox2" /></font><br><br>
                <font size="2">�¶����ڣ�
                <input name="setdate" type="text" id="setdate" size="10" class="editbox2" readonly 
                onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></font>
                &nbsp;&nbsp;
				<font size="2">������ڣ�
        <input name="getdate" type="text" id="getdate" size="10" class="editbox2" readonly onFocus="setday(this)"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></font>
                &nbsp;&nbsp;<font size="2">״̬��</font><select name="ov"><option value=0>δ��</option><option value=1>�ѽ�</option><option value=2>ȫ��</option></select></td>
			<td><input type="submit" name="Subm" value=" �� ѯ " class=box ></td>
          </tr>
        </form>
      </table>
    </td></tr></table><hr size="1">
<%
depotid=session("dm").System_depotid
types=request("types")
if types="" then types=0 end if
names=request("names")
styleid=request("styleid")
setdate=request("setdate")
getdate=request("getdate")
ov=request("ov")%>
 <table width="300" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="30" bgcolor='#FFFFFF' class="t1">&nbsp;</td>
          <td width="120"><font size="2">&nbsp;&nbsp;δ�ᶩ��</font></td>
          <td width="30" bgcolor='#CCCCF1' class="t1">&nbsp;</td>
          <td width="120"><font size="2">&nbsp;&nbsp;�ѽᶩ��</font></td>
        </tr>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr>
    <td width="18%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">������</font></div></td>
	<td width="8%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">����</font></div></td>
    <td width="10%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">�ƶ��绰</font></div></td>
    <td width="18%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">������ʽ</font></div></td>
    <td width="4%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">����</font></div></td>
    <td width="8%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">ȫ�۽��</font></div></td>
    <td width="8%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">������</font></div></td>
    <td width="8%" bgcolor="#336699"><div align="center"><font color="#FFFF00" size="2">�¶�����</font></div></td>
	<td width="8%" bgcolor="#336699"> <div align="center"><font color="#FFFF00" size="2">�������</font></div></td>
    <td width="5%" bgcolor="#336699"><div align="center"><font color="#FFFF00" size="2">�᰸</font></div></td>
    <td width="5%" bgcolor="#336699"><div align="center"><font color="#FFFF00" size="2">ɾ��</font></div></td>
  </tr>
  <%
	set rs=server.createobject("adodb.recordset")
     select case cint(types)
     case 0 sql="select retaildjid,names,mobel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
	            "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,isnull(ov_sure,0) as ov_sure from d_retaildj "&_
				"where depotid='"&depotid&"' and isnull(ov_sure,0)=0 order by convert(char(10),setdate,126)"
     case 1 sql="select retaildjid,names,mobel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
	            "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,isnull(ov_sure,0) as ov_sure from d_retaildj "&_
				"where depotid='"&depotid&"' and isnull(ov_sure,0)>0 order by convert(char(10),setdate,126)"
	 case 2 if names<>"" then str1=" and names like '"&names&"%' " else str1="" end if
	        if styleid<>"" then str2=" and styleid like '"&styleid&"%' " else str2="" end if
			if setdate<>"" then str3=" and convert(char(10),setdate,126)='"&setdate&"' " else str3="" end if
			if getdate<>"" then str4=" and convert(char(10),getdate,126)='"&getdate&"' " else str4="" end if
			select case cint(ov)
			case 0 str5=" and isnull(ov_sure,0)=0 "
			case 1 str5=" and isnull(ov_sure,0)>0 "
			case 2 str5=""
			end select
			sql="select retaildjid,names,mobel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
	            "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,isnull(ov_sure,0) as ov_sure from d_retaildj "&_
				"where depotid='"&depotid&"' "&str1&str2&str3&str4&str5&_
				"order by convert(char(10),setdate,126)"
	 case 3 sql="select retaildjid,names,mobel,styleid,isnull(nums,0) as nums,isnull(fullprice,0) as fullprice,isnull(djprice,0) as djprice,"&_
	            "convert(char(10),setdate,126) as setdate,convert(char(10),getdate,126) as getdate,isnull(ov_sure,0) as ov_sure from d_retaildj "&_
				"where depotid='"&depotid&"' order by convert(char(10),setdate,126)"
	 end select
  rs.open sql,cn,1,1
	while not rs.eof%>
  <tr <%if rs("ov_sure")=0 then response.Write("bgcolor='#FFFFFF'") else response.Write("bgcolor='#CCCCF1'") end if%>>
	<td><div align="center"><font size="2">
  <%if pedit then%>
  <a href="#" onClick="openwin('dj_seach_edit.asp?id=<%=rs("retaildjid")%>','600','400')"><%=rs("retaildjid")%></a>
  <%else%>
  <%=rs("retaildjid")%>
  <%end if%>
  </font></div></td>
	<td><div align="center"><font size="2"><%=rs("names")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("mobel")%></font></div></td> 
	<td><div align="center"><font size="2"><%=rs("styleid")%></font></div></td>
	<td><div align="center"><font size="2"><%response.write(rs("nums"))
	                                         nums=nums+cint(rs("nums"))%></font></div></td>
	<td><div align="center"><font size="2">�� <%response.write(rs("fullprice"))
	                                         fullprice=fullprice+round(rs("fullprice"),2)%></font></div></td>
	<td><div align="center"><font size="2">�� <%response.write(rs("djprice"))
	                                         djprice=djprice+round(rs("djprice"),2)%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("setdate")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("getdate")%></font></div></td>
    <td><div align="center"><font size="2"> 
        <%if rs("ov_sure")=0 then
	     if psure then%>
        <input type="button" value="�᰸" class=box 
        onClick="if(confirm('ȷ��Ҫ�᰸��')){location.href='dj_seach_cl.asp?id=<%=rs("retaildjid")%>&types=sure'}">
        <%else response.write("&nbsp;") end if
	  else
	     if punsure then%>
        <input type="button" value="���᰸" class=box1 
        onClick="if(confirm('ȷ�����᰸��')){location.href='dj_seach_cl.asp?id=<%=rs("retaildjid")%>&types=unsure'}">
        <%else response.write("&nbsp;") end if
	  end if%>
        </font></div></td>
    <td><div align="center"><%if rs("ov_sure")=0 then
		if pdel then%>
        <input type="button" value="ɾ��" class=box 
  			onClick="if(confirm('ȷ��ɾ����')){location.href='dj_seach_cl.asp?id=<%=rs("retaildjid")%>&types=del'}">
		<%else response.write("&nbsp;") end if
    else response.write("&nbsp;") end if%>
    </div></td>
  </tr>
  <%rs.movenext
   wend
   rs.close
   set rs=nothing%>
  <tr> 
    <td height="20" colspan="4"><div align="center"><font color="#FF0000" size="2">��&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��</font></div></td>
    <td><div align="center"><font size="2" color="#FF0000"><%=nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">�� <%=fullprice%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">�� <%=djprice%></font></div></td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
  </tr>
</table>
<%cn.close
  set cn=nothing%>
</body>
</html>