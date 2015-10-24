<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<%session("formid")=2065
 response.Redirect "search_frame.asp?pagename="&server.URLEncode(request("pagename"))
%>