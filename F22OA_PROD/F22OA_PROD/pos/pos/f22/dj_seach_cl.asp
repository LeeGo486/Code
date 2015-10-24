<!--#include file="inc/function.asp"-->
<%
types=request.QueryString("types")
id=request.QueryString("id")
userid=session("dm").System_userid

select case types
case "sure" cn.execute "update d_retaildj set ov_date=getdate(),ov_name='"&userid&"' where retaildjid='"&id&"'"
			cn.execute "update d_retaildj set ov_sure=1 where retaildjid='"&id&"'"
case "unsure" cn.execute "update d_retaildj set ov_sure=0 where retaildjid='"&id&"'"
              cn.execute "update d_retaildj set ov_date=getdate(),ov_name='"&userid&"' where retaildjid='"&id&"'"
case "del" cn.execute "delete from d_retaildj where retaildjid='"&id&"'"
end select
cn.close
set cn=nothing
response.Redirect("dj_seach.asp")
%>