<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/function.asp"-->
<%
dim action,id,cd,ds,msg
action=trim(request.QueryString("action"))
id=trim(request.QueryString("id"))
'de id
set cd=server.CreateObject("ADODB.Command")
cd.ActiveConnection = cn
select case action
case "rgant"
  cd.CommandType=4
  cd.CommandText="F21_pwoer"
  cd.Parameters.Append cd.CreateParameter("@id",adVarchar,adParamInput,10,id)
  cd.Execute
  msg="用户 "& id &" 的权限已成功刷新!"
case else
  msg="option.else,没有为action设置命令!"
end select

set cd=nothing
cn.close
set cn=nothing
%>
<script language="javascript">
  alert('<%=msg%>');
  window.close();
  window.history.back();
</script>