<%option explicit
response.AddHeader "Pragma","No-Cache"
response.AddHeader "Cache-Control","No-Cache"
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>读入通知明细</title>
</head>

<body>
<br>
<br>
<%
dim cd,id,sql,rs,czid
id=trim(request.QueryString("id"))
set rs = server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
rs.Source = "select isnull(noticeid,'') as noticeid,setchk_sure from d_msell where msellid="&qts(id)
rs.open
if rs.eof then
  call close("发生参数错误，请重新操作!")
  rs.close
  set rs=nothing
  response.end
elseif cint(rs("setchk_sure"))>0 then
  call close("单据已经审核，不能再读入!")
  rs.close
  set rs=nothing
  response.end
elseif rs("noticeid")="" then
  call close("此单据没有参照通知单!")
  rs.close
  set rs=nothing
  response.end
else
  czid=rs("noticeid")
end if
rs.close
set rs=nothing

set cd = server.CreateObject("ADODB.Command")
cd.ActiveConnection = cn
cd.CommandType = 1
Sql="delete from d_msellsub where msellid="&qts(id)
cd.CommandText = Sql
cd.Execute
Sql="insert into d_msellsub (msellid,boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,set_nums,"&_
    "j_price1,x_price1,discount1,s_price1) "&_
	"select "&qts(id)&",boxid,clothingid,styleid,colorid,sizeid,j_cost,j_price,x_price,discount,s_price,nums,j_price1,x_price1,"&_
	"discount1,s_price1 from d_movenoticesub where noticeid="&qts(czid)
cd.CommandText = Sql
cd.Execute
set cd = nothing
set cn=nothing
call close("读入完成!")
%>
</body>
</html>
