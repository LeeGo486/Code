<!--#include file="../inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ͼ����</title>
<link href="link.css" rel="stylesheet" type="text/css">
</head>
<%st_year=request("st_year")
st_month=request("st_month")
st_dl=request("st_dl")
types=request("types")
act=request("act")

if act="save" then
  set rs=server.CreateObject("adodb.recordset")
  for i=1 to 9 
    tmpstyleid=request("style"&i)
	tmpnums=request("nums"&i)
	if tmpnums="" then
	   tmpnums=0
	end if
	if cdbl(tmpnums)<>0 then
	   sql="delete from d_indentsub where indentid='"&request.Cookies("pic_indentid")&"' and styleid='"&tmpstyleid&"'"
	   cn.execute sql
	   sql="t18tj_getstyleprice 2,'"&session("dm").system_depotid&"','"&tmpstyleid&"','"&get_date(date)&"'"
	   rs.open sql,cn
	    if isnull(rs("j_cost")) then j_cost=0 else j_cost=rs("j_cost") end if
	    if isnull(rs("j_price")) then j_price=0 else j_price=rs("j_price") end if
		if isnull(rs("x_price")) then x_price=0 else x_price=rs("x_price") end if
		if isnull(rs("s_price")) then s_price=0 else s_price=rs("s_price") end if
		if isnull(rs("discount")) then discount=0 else discount=rs("discount") end if
	   sql="insert into d_indentsub (indentid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums) "&_
	       "select top 1 '"&request.Cookies("pic_indentid")&"','AV"&session("dm").system_userid&"',clothingid,styleid,colorid,sizeid,"&j_cost&","&j_price&","&x_price&","&discount&","&s_price&","&tmpnums&_
		   " from j_clothing where styleid='"&tmpstyleid&"'"
	   cn.execute sql
	   rs.close  
	end if
  next
  set rs=nothing
end if%>
<body style="cursor:url('img/pen_i.cur')">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><font size="2">��ǰ��ѯ:
	     <font color=#FF0000><%if st_year="" and st_month="" and st_dl="" then
		               response.write("ȫ����ʽ")
					else
					   response.write(st_year&"��"&st_month&st_dl&"��ʽ")
					end if%></font></font></td>
	<td><font size="2">��ǰ�����ţ�<%=request.Cookies("pic_indentid")%></font></td>
	<td><font size="2">���µ�����<%=getznums(request.Cookies("pic_indentid"))%> ��</font></td>
  </tr>
</table>
<hr size="2">

<%
'if types=1 then sqlstr=" and isnull(a.dh_1,'')<>'' and isnull(a.dh_2,'')<>'' " end if
if types=1 then sqlstr="" end if
if types=2 then sqlstr=" and a.st_year='"&st_year&"' and isnull(a.dh_1,'')<>'' and isnull(a.dh_2,'')<>'' " end if
if types=3 then sqlstr=" and a.st_year='"&st_year&"' and dh_1='"&st_month&"'" end if
if types=4 then sqlstr=" and a.st_year='"&st_year&"' and dh_1='"&st_month&"' and dh_2='"&st_dl&"'" end if

set rs=server.CreateObject("adodb.recordset")
  sql="select a.styleid,max(a.s_name) as s_name,max(isnull(b.styleid,'δ��')) as dh,sum(isnull(b.nums,0)) as nums from j_style a,d_indentsub b "&_
      "where a.styleid*=b.styleid and isnull(a.s_use,0)=1 and isnull(a.freeze,0)=0 "&sqlstr&" and b.indentid ='"&request.Cookies("pic_indentid")&"' "&_
	  "group by a.styleid"
  rs.open sql,cn,1,1
if not rs.eof then
	'���ҳ��
    page=request("page")
    '����ÿҳ��ʾ10����¼
    rs.pagesize=9
    '�ѻ�õ�ҳ��������¼����ǰҳ���� 
    rs.absolutepage=page%>
<form name="form1" method="post" action="">	

<table width="100%" height="117" border="0" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
<%no=2
  j=1
  for page=1 to rs.pagesize
	 if not rs.eof then
	    if no=2 then
		   response.write("<tr><td width='20%'>")
		   no=0
		else
		   no=no+1
		   response.Write("<td width='20%'>")
		end if%> 
	 <table width="200" height="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
        <tr <%if rs("dh")="δ��" then response.write("bgcolor='#E8FDFF'") else response.write("bgcolor='#F0AA00'") end if%>> 
          <td height="145" colspan="2"><div align="center"><font size="2"> 
              <a href="javascript:void(null)" onClick="showModalDialog('showbigimg.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:500px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no')"><img src=showimg.asp?styleid=<%=rs("styleid")%> alt="�����<%=rs("styleid")%>��ͼ" border="0" width="140" ></a> 
              </font></div></td>
        </tr>
        <tr> 
          <td colspan="2"><div align="center"> 
              <table width="100%" height="53" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="24" colspan="2" align="center"><font size=2><%response.write("��ʽ��"&rs("styleid"))%></font></td>
                </tr>
                <tr align="center">
                  <td><input type="button" name="Submit3" value=" �� �� " onClick="showModalDialog('fashionzl.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:750px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no');" class=box></td>
                  <td><font size="2">����</font> 
				  <input type="text" name="nums<%=j%>" size="5" value="<%=rs("nums")%>" onFocus="this.select()" onKeyDown="if(event.keyCode==13)event.keyCode=9" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);">
				  <input type="hidden" name="style<%=j%>" value="<%=rs("styleid")%>">
				  </td>
                  <td></td> 
				</tr>
              </table>
            </div></td>
        </tr>
      </table>
      <%j=j+1
	    rs.movenext
	end if
	if no=0 then
	   response.Write("</td>")
	end if
	next%>
</tr>
</table>
<hr size="1">
&nbsp;&nbsp; 
<font size="2"> 
 <%'�ж��Ƿ�Ϊ��ҳ
   if request("page")<>1 then
'��ӡ�����ӵ�<< <����%>
      <a href=indent_select_sub_j.asp?page=1&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>��ҳ</a>&nbsp;<a href=indent_select_sub_j.asp?page=<%=request("page")-1%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>��һҳ</a> 
 <%else
'�����ӡ�������ӵ�<< <����
      response.write("��ҳ&nbsp;��һҳ")
   end if
   response.Write("&nbsp;")
'�ж��Ƿ�Ϊβҳ
   if cint(request("page"))=rs.pagecount then
     '��ӡ�������ӵ�> >>����
      response.write("��һҳ&nbsp;βҳ")
   else
   '�����ӡ�����ӵ�> >>����%>
      <a href=indent_select_sub_j.asp?page=<%=request("page")+1%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>��һҳ</a>&nbsp;<a href=indent_select_sub_j.asp?page=<%=rs.pagecount%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>βҳ</a> 
   <%end if%>
</font> <font size="2">&nbsp;&nbsp;&nbsp;��<font color="#FF0000"><%=request("page")%></font>ҳ&nbsp;/&nbsp;��<font color="#FF0000"><%=rs.pagecount%></font>ҳ��ÿҳ<font color="#FF0000"><%=rs.pagesize%></font>����ʽ����<font color="#FF0000"><%=rs.recordcount%></font>����ʽ</font>  
<input type="hidden" name="page" value="<%=request("page")%>">
<input type="hidden" name="st_year" value="<%=st_year%>">
<input type="hidden" name="st_month" value="<%=st_month%>">
<input type="hidden" name="st_dl" value="<%=st_dl%>">
<input type="hidden" name="types" value="<%=types%>">
<input type="hidden" name="act" value="save">
<input type="submit" name="submit" value=" �� �� ">
<%else%>
<table width="100%" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
<tr>
  <td colspan="8"><div align="center"><font size="2">�� �� �� �� �� ʽ</font></div></td>
</tr>
</table>
</form>
<%end if

function getznums(id)
set rs10=server.CreateObject("adodb.recordset")
rs10.open "select isnull(sum(nums),0) as cnt from d_indentsub where indentid='"&id&"'",cn
getznums=rs10("cnt")
rs10.close
set rs10=nothing
end function

function getstylenums(id,styleid)
set rs10=server.CreateObject("adodb.recordset")
rs10.open "select isnull(sum(nums),0) as cnt from d_indentsub where indentid='"&id&"' and styleid='"&styleid&"'",cn
getstylenums=rs10("cnt")
rs10.close
set rs10=nothing
end function%>
</body>
</html>
<%rs.close
  cn.close
  set rs=nothing
  set cn=nothing%>
