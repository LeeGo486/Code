<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<%session("formid")=2071
act=request.QueryString("act")
if act="addsg" then
   response.Redirect "2071_msell_create.asp?action=create"
elseif act="addtm" then
   response.Redirect "2071_msell_create.asp?action=create&bar=1"
else
   response.Redirect "search_frame.asp?jh=''&pagename="&server.URLEncode(request("pagename"))
end if%>