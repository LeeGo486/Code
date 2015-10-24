<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim depotid,compete,cr_name,ct,retailid,competecxid
dim setdate,act
ct=trim(request.Form("count"))
act=trim(request.Form("act"))
depotid=trim(request.Form("depotid"))
compete=trim(request.Form("compete"))
cr_name=trim(request.Form("cr_name"))
competecxid=trim(request.Form("competecxid"))
'de competechkid
rq1=trim(request.Form("rq1"))
rq2=trim(request.Form("rq2"))
if not isnumeric(ct) then
  ct=0
else
  ct=cint(ct)
end if

dim chktype(),chktext(),comment()
redim chktype(ct)
redim chktext(ct)
redim comment(ct)
for i=1 to ct
  chktype(i)=trim(request.Form("chktype"&i))
  chktext(i)=trim(request.Form("aid"&i))
  comment(i)=trim(request.Form("comment"&i))
next
for i=1 to ct
  response.Write chktype(i)&" "
  response.Write chktext(i)&" "
  response.Write comment(i)&" <br>"
next
'response.End()

dim ds,sql
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3
sql="select top 1 * from d_competecx order by competecxid"
ds.Source = sql
ds.Open
ds.Addnew
competecxid=getid("d_competecx","competecxid","CX",depotid)
ds("competecxid")=competecxid
ds("competecx")=competecxid
ds("compete")=compete
ds("setdate")=get_date(date)
ds("depotid")=depotid
ds("begdate")=rq1
ds("enddate")=rq2
ds("chk_sure")=0
ds("sure")=0
ds("cr_date")=get_date(date)
ds("cr_name")= cr_name
ds.Update
ds.Close

sql="select top 1 * from d_competecxsub order by competecxid"
ds.Source = sql
ds.Open
for i=1 to ct
  ds.Addnew
  ds("competecxid")=competecxid
  ds("chktype")=chktype(i)
  ds("chktext")=chktext(i)
  ds("comment")=comment(i)
  ds("crdate")=get_date(date)
  ds.Update
next
ds.Close
set ds=nothing
call aclose("保存成功!谢谢!",1)
%>
</body>
</html>
