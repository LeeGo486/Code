<%option explicit%>
<!--#include file="inc/function.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>
<%
dim groupid,employeeid,names,sex,telphone,address,comment,usedstatus,depotid,act,Position,YearGoal,job_number
dim byear,bmonth,bday,birthday,IDcard,valid,workdate
groupid=trim(request.Form("groupid"))
employeeid=trim(request.Form("employeeid"))
names=trim(request.Form("names"))
sex=trim(request.Form("sex"))
telphone=trim(request.Form("telphone"))
address=trim(request.Form("address"))
comment=trim(request.Form("comment"))
usedstatus=trim(request.Form("usedstatus"))
depotid=trim(session("dm").System_depotid)
birthday=trim(request.Form("birthday"))
workdate=trim(request.Form("workdate"))
IDcard=trim(request.Form("IDcard"))
act=trim(request("act"))
valid=trim(request.Form("valid"))
Position=trim(request.Form("Position"))
YearGoal=trim(request.Form("YearGoal"))
job_number=trim(request.Form("job_number"))
if YearGoal="" then
    YearGoal="0"
end if
if usedstatus="" then
  usedstatus=0
else
  usedstatus=1
end if

if valid="" then
  valid=1
else
  valid=0
end if


dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

select case act
case "add"
ds.LockType = 3
sql="select isnull(max(cast(employeeid as int)),0) as employeeid from j_employee where IsNumeric(employeeid)=1"
ds.Source = sql
ds.open
	if employeeid="" then '自动生成班次编号
		if ds.eof or ds("employeeid")="0"  then
			employeeid="00000001"
		else
		  employeeid=right("00000000"&cstr(ds("employeeid")+1),8)
		end if
		if names="" then names=employeeid end if
		ds.close
		ds.Source = "select * from j_employee where 1=2"
		ds.open
	else '不自动生成
		ds.close
		sql="select 1 from j_employee where employeeid="&qts(employeeid)
		ds.Source = sql
		ds.Open
		if not ds.eof then
			ds.close
		set ds=nothing
		call mbox("该营业员编号已存在!")
		else
			ds.close
		end if
		sql="select top 1 * from j_employee order by employeeid"
		ds.Source = sql
		ds.open
	end if
	'de employeeid
	ds.Addnew
	ds("groupid")=groupid
	ds("employeeid")=employeeid
	ds("names")=names
	ds("usedstatus")=usedstatus
	ds("comment")=comment
	ds("birthday")=birthday
	ds("workdate")=workdate
	ds("IDcard")=IDcard
	ds("sex")=sex
	ds("telephone")=telphone
	ds("address")=address
	ds("comment")=comment
	ds("depotid")=depotid
	ds("valid")=valid
    ds("Position")=Position
    ds("YearGoal")=YearGoal
    ds("job_number")=job_number
	ds.Update
	ds.close
	call bclose("添加营业员成功!")

case "edit"
	sql="select * from j_employee where employeeid="&qts(employeeid)
	ds.open sql,cn,1,3
	if ds.eof and ds.bof then
		call mbox("该营业员编号不存在!")
	else
		ds("groupid")=groupid
		ds("employeeid")=employeeid
		ds("names")=names
		ds("usedstatus")=usedstatus
		ds("comment")=comment
		ds("birthday")=birthday
		ds("workdate")=workdate
		ds("IDcard")=IDcard
		ds("sex")=sex
		ds("telephone")=telphone
		ds("address")=address
		ds("comment")=comment
		ds("depotid")=depotid
		ds("valid")=valid
        ds("Position")=Position
        ds("YearGoal")=YearGoal
        ds("job_number")=job_number
		ds.Update
	end if
	ds.close
	call bclose("营业员资料更新成功!")
case "del"
  employeeid=trim(request.QueryString("id"))
	sql="select 1 from jk_retailhistory where employeeid="&qts(employeeid)
  ds.source = sql
  ds.open
	if not(ds.eof and ds.bof) then
		call bclose("此营业员已有销售，不能删除！")
		response.end()
	end if
	ds.close
  sql="delete from j_employee where employeeid="&qts(employeeid)
  ds.source = sql
  ds.open
  call bclose("删除营业员成功!")
end select
set ds=nothing

%>
<%Sub bClose(msg)%>
<script language="javascript">
  alert("<%=msg%>");
  //window.history.back();
  window.location.href="pos_option.asp?cid=0";
</script>
<%End Sub%>

</body>
</html>
