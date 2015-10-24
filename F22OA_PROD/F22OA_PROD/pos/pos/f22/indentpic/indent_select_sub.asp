<!--#include file="../inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>看图订货</title>
<link href="link.css" rel="stylesheet" type="text/css">
</head>
<%st_year=request.QueryString("st_year")
st_month=request.QueryString("st_month")
st_dl=request.QueryString("st_dl")
types=request.querystring("types")%>
<body style="cursor:url('img/pen_i.cur')">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><font size="2">当前查询:
	     <font color=#FF0000><%if st_year="" and st_month="" and st_dl="" then
		               response.write("全部款式")
					else
					   response.write(st_year&"年"&st_month&st_dl&"款式")
					end if%></font></font></td>
	<td><font size="2">当前订单号：<%=request.Cookies("pic_indentid")%></font></td>
	<td><font size="2">总下单量：<%=getznums(request.Cookies("pic_indentid"))%> 件</font></td>
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
  sql="select a.styleid,max(a.s_name) as s_name,max(isnull(b.styleid,'未订')) as dh from j_style a,d_indentsub b "&_
      "where a.styleid*=b.styleid and isnull(a.s_use,0)=1 and isnull(a.freeze,0)=0 "&sqlstr&" and b.indentid ='"&request.Cookies("pic_indentid")&"' "&_
	  "group by a.styleid"
  rs.open sql,cn,1,1
if not rs.eof then
	'获得页数
    page=request.QueryString("page")
    '定义每页显示10条记录
    rs.pagesize=9
    '把获得的页数赋给记录集当前页属性 
    rs.absolutepage=page%>

<!--#列表显示-->


<!--#大图显示-->
    
<table width="100%" height="117" border="0" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">	
<%no=2
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
        <tr <%if rs("dh")="未订" then response.write("bgcolor='#E8FDFF'") else response.write("bgcolor='#F0AA00'") end if%>> 
          <td height="145" colspan="2"><div align="center"><font size="2"> 
              <a href="javascript:void(null)" onClick="showModalDialog('showbigimg.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:500px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no')"><img src=showimg.asp?styleid=<%=rs("styleid")%> alt="点击看<%=rs("styleid")%>大图" border="0"
              width="120" ></a> 
              </font></div></td>
        </tr>
        <tr> 
          <td colspan="2"><div align="center"> 
              <table width="100%" height="53" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td height="24" colspan="3" align="center"><font size=2><%response.write("款式："&rs("styleid")&"&nbsp;&nbsp;数量："&getstylenums(request.Cookies("pic_indentid"),rs("styleid"))&" 件")%></font></td>
                </tr>
                <tr align="center">
                  <td><input type="button" name="Submit3" value=" 档 案 " onClick="showModalDialog('fashionzl.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:750px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no');" class=box></td>
                  <td><input type="button" name="Submit22" value=" 下 单 " onClick="showModalDialog('buy_fashion.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:750px;dialogHeight:600px;center: yes;help:no;resizable:no;status:no');" class=box></td>
                  <td><%if rs("dh")<>"未订" then%>
				  <input type="button" name="Submit22" value=" 修 改 " onClick="showModalDialog('indent_mxview_tq.asp?styleid=<%=rs("styleid")%>&indentid=<%=request.Cookies("pic_indentid")%>&try=1&lx=indent',window,'dialogWidth:750px;dialogHeight:600px;center: yes;help:no;resizable:no;status:no');" class=box>
				  <%end if%></td> 
				</tr>
              </table>
            </div></td>
        </tr>
      </table>
      <%rs.movenext
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
 <%'判断是否为首页
   if request.QueryString("page")<>1 then
'打印带连接的<< <符号%>
      <a href=indent_select_sub.asp?page=1&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>首页</a>&nbsp;<a href=indent_select_sub.asp?page=<%=request.QueryString("page")-1%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>上一页</a> 
 <%else
'否则打印不带连接的<< <符号
      response.write("首页&nbsp;上一页")
   end if
   response.Write("&nbsp;")
'判断是否为尾页
   if cint(request.QueryString("page"))=rs.pagecount then
     '打印不带连接的> >>符号
      response.write("下一页&nbsp;尾页")
   else
   '否则打印带连接的> >>符号%>
      <a href=indent_select_sub.asp?page=<%=request.QueryString("page")+1%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>下一页</a>&nbsp;<a href=indent_select_sub.asp?page=<%=rs.pagecount%>&st_year=<%=st_year%>&st_month=<%=st_month%>&st_dl=<%=st_dl%>&types=<%=types%>>尾页</a> 
   <%end if%>
</font> <font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 第<font color="#FF0000"><%=request.QueryString("page")%></font>页&nbsp;/&nbsp;共<font color="#FF0000"><%=rs.pagecount%></font>页，每页<font color="#FF0000"><%=rs.pagesize%></font>个款式，共<font color="#FF0000"><%=rs.recordcount%></font>个款式</font>  
<%else%>
<table width="100%" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
  <td colspan="8"><div align="center"><font size="2">无 订 补 货 款 式</font></div></td>
</tr>
</table>
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
