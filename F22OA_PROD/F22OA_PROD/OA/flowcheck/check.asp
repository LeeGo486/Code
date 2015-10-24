<%
if request.Cookies("UserID")="" then
   response.Redirect("login.htm")
   response.end
end if
%>
