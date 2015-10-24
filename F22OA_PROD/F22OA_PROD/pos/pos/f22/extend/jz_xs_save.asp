<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim depotid,months,cr_name,ct,retailid
ct=trim(request.Form("count"))
depotid=trim(request.Form("depotid"))
years=trim(request.form("years"))
months=trim(request.Form("months"))
cr_name=trim(request.Form("cr_name"))
if not isnumeric(months) then
  call aclose("必须选择一个月份!",1)
else
  months=cint(months)
end if
if not isnumeric(ct) then
  ct=0
else
  ct=cint(ct)
end if

dim styleid(),sums(),comment(),i
redim styleid(ct)
redim sums(ct)
redim comment(ct)
for i=1 to ct
  styleid(i)=trim(request.Form("styleid")(i))
  sums(i)=trim(request.Form("sums")(i))
  comment(i)=trim(request.Form("comment")(i))
  if not isnumeric(sums(i)) then
    sums(i)=0
  else
    sums(i)=round((sums(i)),2)
  end if
  if comment(i)="" then
    comment(i)=""
  end if
next
'response.Write request.Form("aid2")&"<br>"
dim ds,sql
sql="select * from d_retailcompete where depotid="&qts(depotid)&" and months="&months&" and years="&years
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3
ds.Source = sql
ds.open
if not ds.eof then
  if chk_sure>0 then
    ds.close
    set ds=nothing
    call aclose("你已经填写了 "&years&"-"&months&" 月份的销售!",1)
  else
    retailid=trim(ds("retailid"))
    ds.close
	sql="delete from d_retailcompetesub where retailid="&qts(retailid)
	ds.Source = sql
	ds.Open
	
    sql="select top 1 * from d_retailcompetesub order by retailid"
	ds.Source = sql
	ds.Open
  for i=1 to ct
	ds.Addnew
	ds("retailid")=retailid
	ds("compete")=styleid(i)
	ds("sums")=sums(i)
	ds("comment")=comment(i)
	ds.Update
  next
  ds.Close
  end if
else
  retailid=getid("d_retailcompete","retailid","XS",depotid)
    ds.AddNew
	ds("retailid")=retailid
	ds("retail")=retailid
	ds("depotid")=depotid
	ds("years")=years
	ds("months")=months
	ds("chk_sure")=0
	ds("sure")=0
	ds("cr_name")=cr_name
	ds("cr_date")=get_date(date())
	ds.Update
	ds.close
  
    sql="select top 1 * from d_retailcompetesub order by retailid"
	ds.Source = sql
	ds.Open
  for i=1 to ct
	ds.Addnew
	ds("retailid")=retailid
	ds("compete")=styleid(i)
	ds("sums")=sums(i)
	ds("comment")=comment(i)
	ds("crdate")=get_date(date())
	ds.Update
  next
  ds.Close
end if
response.write("<script>alert('保存成功!谢谢!');window.location='jz_xs.asp'</script>")
set ds=nothing
%>
<%
function rclose(str,opt)
  response.Write "<script language='javascript'>"
  response.Write "alert('"& str &"');"
  response.Write "window.location.href='jz_xs_save.asp';"
  response.Write "</script>"
end function
%>
</body>
</html>
