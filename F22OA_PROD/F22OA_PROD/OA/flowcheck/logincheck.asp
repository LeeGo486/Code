<!-- #include file="conn.asp" -->
<%
dim rs,tbuser,tbpwd,s1
tbuser=HTMLEncode(request.form("tbuser"))
tbpwd=HTMLEncode(request.form("tbpwd"))
set rs=server.CreateObject("adodb.recordset")
s1="select userid,username from j_user where userid='"&tbuser&"' and pwd='"&tbpwd&"'"
rs.open s1,conn,1,1
if rs.eof then
   response.write("<script>alert('ÕÊºÅ»òÃÜÂë²»¶Ô£¡');location='login.htm';</script>")
   response.End()
end if
response.Cookies("UserID")=rs("userid")
response.Cookies("UserName")=rs("username")
rs.close
set rs=nothing
response.redirect "flowcheck.asp"
%>