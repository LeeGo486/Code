<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>
<!--#include file="inc/function.asp" -->
<%dim act,sql,id,styleid,opt,ds,boxid
dim discount
dim s_price,j_price,x_price,s_name
opt=trim(request.QueryString("opt"))
act=trim(request.QueryString("act"))
id=trim(request.queryString("id"))
styleid=trim(request.QueryString("styleid"))
boxid=trim(request.QueryString("boxid"))

if id="" then call zclose()
if styleid="" then
  call zclose()
else
  styleid=ucase(styleid)
end if

select case opt
case "indent"
  sql="d_indentsub"
  fkname="indentid"
case "quota"
  sql="d_quotasub"
  fkname="quotaid"
case "sell"
  sql="d_sellsub"
  fkname="sellid"
case "move"
  sql="d_movesub"
  fkname="moveid"
case "retail"
  sql="d_retailsub"
  fkname="retailid"
case "outindent"
  sql="d_outindentsub"
  fkname="outindentid"
case "outindentPRO"
  sql="d_outindentPROsub"
  fkname="outindentid"
case "outindentCHK"
  sql="d_outindentCHKsub"
  fkname="outindentid"
case "outindentset"
  sql="d_outindentsetsub"
  fkname="outindentid"
case "inventory"
  sql="d_inventorysub"
  fkname="inventoryid"
case "msell"
  sql="d_msellsub"
  fkname="msellid"
case else

end select

set cd = server.CreateObject("ADODB.Command")
cd.ActiveConnection = cn
cd.CommandType = 1
select case act
case "discount" '修改折扣
  
  discount=trim(request.QueryString("v"))
  if not isnumeric(discount) then
    discount=1
  else
    discount=cdbl(discount)
  end if
  sql="update "&sql&" set discount="&discount&",s_price=x_price*"&discount&" where "&fkname&"="&qts(id)&" and styleid="&qts(styleid)
  cd.CommandText = sql
  cd.Execute
  set cd=nothing
case "s_price" '修改结算价
  
  s_price=trim(request.QueryString("v"))
  if not isnumeric(s_price) then
    s_price=1
  else
    s_price=cdbl(s_price)
  end if
  sql="update "&sql&" set s_price="&s_price&",discount=round("&s_price&"/x_price,3) where "&fkname&"="&qts(id)&" and styleid="&qts(styleid)
  cd.CommandText = sql
  cd.Execute
case "add" '添加款式

case "del" '删除款式

  sql="delete from "&sql&" where "&fkname&"="&qts(id)&" and styleid="&qts(styleid)&" and boxid="&qts(boxid)
  cd.CommandText = sql
  cd.Execute

end select

set cd=nothing
call zclose
%>
</body>
</html>
