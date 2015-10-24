<!--#include file="inc/function.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body><%
dim groupid,groupname,usedstatus,comment,depotid,act
groupid=trim(request.Form("groupid"))
groupname=trim(request.Form("groupname"))
usedstatus=trim(request.Form("usedstatus"))
comment=trim(request.Form("comment"))
depotid=trim(session("dm").System_Depotid)
act=trim(request("act"))

if comment="" then
  comment=0
else
  comment=1
end if

dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3
select case act
case "add"
sql="select isnull(max(cast(groupid as int)),0) as groupid from jk_group where IsNumeric(groupid)=1"
ds.Source = sql
ds.open

if groupid="" then '自动生成班次编号
  if ds.eof then
    groupid="00000001"
  else
    groupid=right("00000000"&cstr(ds("groupid")+1),8)
  end if
  if groupname="" then groupname=groupid end if
  ds.close
  ds.source = "select * from jk_group where 1=2"
  ds.open
else '不自动生成
  ds.close
  sql="select 1 from jk_group where groupid="&qts(groupid)
  ds.Source = sql
  ds.Open
  if not ds.eof then
    ds.close
	set ds=nothing
	call mbox("该班次编号已存在!请换一个试试!")
  else
    ds.close
  end if
  sql="select top 1 * from jk_group order by groupid"
  ds.Source = sql
  ds.open
end if
ds.Addnew
ds("groupid")=groupid
ds("depotid")=depotid
ds("groupname")=groupname
ds("usedstatus")=usedstatus
ds("comment")=comment
ds.Update
ds.close
call bclose("添加班次成功!")
case "del"
  groupid=trim(request.QueryString("id"))
  sql="delete from jk_group where groupid="&qts(groupid)
  ds.source = sql
  ds.open
  call bclose("删除班次成功!")
end select
set ds=nothing

%>
<%sub bclose(str)%>
<script language="javascript">
alert("<%=str%>");
window.location.href="pos_option.asp?cid=1";
</script>
<%end sub%>
</body>
</html>
