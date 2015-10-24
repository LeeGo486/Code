<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<%session("formid")=2069%>
<!--#include file="inc/function.asp"-->
<%if not padd then
   response.write("<script>alert('没有新增权限！');history.go(-1);</script>")
   response.end()
end if
response.Redirect "search_frame.asp?pagename="&server.URLEncode(request("pagename"))%>