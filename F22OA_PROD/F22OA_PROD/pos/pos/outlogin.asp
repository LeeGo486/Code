<%
session.Abandon()
response.write("<script language=JavaScript>top.location.href='../../relogin.aspx';</script>")
%>