<%Dim act
act=request.QueryString("act")
if cint(act)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

f_date=trim(request.QueryString("f_date"))
if f_date="" then
   f_date=get_date(date)
end if
l_date=trim(request.QueryString("l_date"))
if l_date="" then
   l_date=get_date(date)
end if%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ݲ�ѯ</title>
<base target="_self" />
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
window.name="aaa";
function op(url){
showModalDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
function op2(url){
showModelessDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
</script>
<style media="print">.noprint { display: none }</style>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>���ݴ����У����Ժ򡭡�</td></tr>
</table></td></tr></table></div>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">��ǰλ�ã�--&gt; ���۲�ѯ-������</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>
<table width="100%" class="noprint">
  <tr><td>
  <table width="100%" height="32" border="0" cellspacing="0">
        <form name="form1" method="get" target="aaa" action="f22qry_otherretail_date_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td><font size="2"><input type="text" value="��ʼ���ڣ�" size="10" style="border-bottom:0px;border-top:0px;border-left:0px;border-right:0px"> 
              <input name="f_date" type="text" id="f_date" size="10" class="box" value="<%=f_date%>" onFocus="setday(this);" readonly onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">�������ڣ� 
              <input name="l_date" type="text" id="l_date" size="10" class="box" value="<%=l_date%>" onFocus="setday(this);" readonly onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font></td>
            <td><font size="2">�� ��<select name="order" size=1><option value=0>����������</option><option value=1>����������</option><option value=2>���������</option></select></font> </td>
            <td><input type="submit" name="Subm" value=" ȷ �� " class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
            <td><input type="hidden" name="act" value="1">
			<!--<input type="button" name="but" value="����Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();">--></td>
		  </tr>
        </form>
      </table>
</td></tr></table>
<%if f_date="" or l_date="" then%>
<table class="noprint" width="100%" height="102" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
    <td><div align="center">�� ѡ �� �� ��</div></td>
  </tr>
</table>
<%else%>
<hr size="1">
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="25%"><div align="left"><font size="2">��<font color="#FF0000"><%=request.querystring("f_date")%></font>��<font color="#FF0000"><%=request.querystring("l_date")%></font></font></div></td>
  </tr>
</table> 
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">��������</font></div></td>
    <td width="19%"><div align="center"><font color="#FFFF00" size="2">���۵���</font></div></td>
    <td width="16%"><div align="center"><font color="#FFFF00" size="2">��������</font></div></td>
    <td width="17%"><div align="center"><font color="#FFFF00" size="2">���۽��</font></div></td>
  </tr>
  <%order=request("order")
  select case order
  case 0 orderby=" order by suredate desc"
  case 1 orderby=" order by sum(nums) desc"
  case 2 orderby=" order by sum(s_sums) desc"
  end select
  set rs=server.createobject("adodb.recordset")
  if session("nozckc") then
	 tj=" and d.m_type in (0,1,80,90) "
  else
	 tj=""
  end if
  
'���Ʋ�ѯ����
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if 
userid=trim(session("dm").system_userid) 
  
  sql1=" select convert(char(10),a.sure_date,120) as suredate,a.depotid,max(d.d_name) as d_name,sum(b.nums) as nums,sum(b.nums*b.s_price) as s_sums "&_
       " from d_retail a,d_retailsub b,webp_depot c,j_depot d where a.retailid=b.retailid "&_
	   " and a.depotid "&session("QryDepotTj")&_
	   " and a.depotid=c.depotid and c.unitid='"&session("dm").System_Unitid&"' and c.userid='"&userid&"' and isnull(a.sure,0)>0 "&_
	   " and '"&f_date&"'<=convert(char(10),a.sure_date,120) and convert(char(10),a.sure_date,120)<='"&l_date&"' "&qrydaytj&_
	   " and a.depotid=d.depotid "&tj&" group by convert(char(10),a.sure_date,120),a.depotid "&_
	   " union all "&_
	   " select convert(char(10),a.sure_date,120) as suredate,a.depotid,max(d.d_name) as d_name,sum(b.nums) as nums,sum(b.nums*b.s_price) as s_sums "&_
       " from d_retail a,d_retailsub b,j_depot d where a.retailid=b.retailid and a.depotid "&session("QryDepotTj")&_
	   " and a.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_retail=1) and isnull(a.sure,0)>0 "&_
	   " and '"&f_date&"'<=convert(char(10),a.sure_date,120) and convert(char(10),a.sure_date,120)<='"&l_date&"' "&qrydaytj&_
	   " and a.depotid=d.depotid group by convert(char(10),a.sure_date,120),a.depotid "&orderby
  rs.open sql1,cn,1,1
  if not rs.eof then
	while not rs.eof 
    if not rs.eof then%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2"><a href="javascript:;" onClick="op2('f22qry_otherretail_date_seach_mx.asp?dptid=<%=rs("depotid")%>&suredate=<%=rs("suredate")%>');" title="�������ϸ"><%=rs("suredate")%></a></font></div></td>
    <td height=20><div align="center"><font size="2"><%=rs("d_name")%></font></div></td>
	<td height="20"><div align="center"><font size="2"><%response.write(rs("nums"))
	                                                     nums=nums+round(rs("nums"),4)%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">�� <%response.write(rs("s_sums"))
	                                                            s_sums=s_sums+round(rs("s_sums"),4)%></font></div></td>
  </tr>
  <%rs.movenext 
    end if
    wend%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20" colspan=2><div align="center"><font size="2">��&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp; ��</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000"><%=nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">�� <%=s_sums%></font></div></td>
  </tr>
</table>
<%else%>
<tr>
  <td colspan="8"><div align="center"><font size="2">û �� �� �� �� ��</font></div></td>
</tr>
<%end if%>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing
end if%>
</body>
</html>

