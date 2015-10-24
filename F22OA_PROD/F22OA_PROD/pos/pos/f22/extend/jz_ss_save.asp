<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim depotid,compete,cr_name,ct,retailid,competechkid,commentsub,ImageUrl
dim setdate,act
ct=trim(request.Form("count"))
act=trim(request.Form("act"))
depotid=trim(request.Form("depotid"))
compete=trim(request.Form("compete"))
cr_name=trim(request.Form("cr_name"))
commentsub=trim(request.Form("comment"))
ImageUrl=trim(request.Form("ImageUrl"))
competechkid=trim(request.Form("competechkid"))
'de competechkid
setdate=trim(request.Form("setdate"))
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

dim styleid,c_name,x_price,styletype,st_lb,i
  styleid=trim(request.Form("styleid"))
  c_name=trim(request.Form("c_name"))
  x_price=trim(request.Form("x_price"))
  styletype=trim(request.Form("styletype"))
  st_lb=trim(request.Form("st_lb"))
  if not isnumeric(x_price) then
    x_price=0
  else
    x_price=cdbl(x_price)
  end if

'response.Write request.Form("aid2")&"<br>"
dim ds,sql
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3
select case act
case "add"
if competechkid="" then
  competechkid=getid("d_competechk","competechkid","SS",depotid)
  sql="select top 1 * from d_competechk order by competechkid"
  ds.Source = sql
  ds.Open
  ds.Addnew
  ds("competechkid")=competechkid
  ds("competechk")=competechkid
  ds("depotid")=depotid
  ds("setdate")=setdate
  ds("compete")=compete
  ds("chk_sure")=0
  ds("sure")=0
  ds("cr_date")=get_date(date)
  ds("cr_name")=cr_name
  ds.Update
  ds.Close
  sql="select top 1 * from d_competechksub order by competechkid"
  ds.Source = sql
  ds.Open
  ds.Addnew
  ds("competechkid")=competechkid
  ds("styleid")=styleid
  ds("c_name")=c_name
  ds("x_price")=x_price
  ds("styletype")=styletype
  ds("st_lb")=st_lb
  ds("comment")=commentsub
  ds("imagesurl")=ImageUrl
  ds.Update
  ds.close
else
  sql="select top 1 * from d_competechksub order by competechkid"
  ds.Source = sql
  ds.Open
  ds.Addnew
  ds("competechkid")=competechkid
  ds("styleid")=styleid
  ds("c_name")=c_name
  ds("x_price")=x_price
  ds("styletype")=styletype
  ds("st_lb")=st_lb
  ds("comment")=commentsub
  ds("imagesurl")=ImageUrl
  ds.Update
  ds.close
end if
case "edit"
  sql="select top 1 * from d_competechksub where competechkid="&qts(competechkid)&" and styleid="&qts(styleid)
  ds.Source = sql
  ds.Open
  if not ds.eof then
    ds("c_name")=c_name
    ds("x_price")=x_price
    ds("styletype")=styletype
    ds("st_lb")=st_lb
	 ds("comment")=commentsub
	 ds("imagesurl")=ImageUrl
    ds.Update
  end if
  ds.close
case else
  act=trim(request.QueryString("act"))
  competechkid=trim(request.QueryString("comid"))
  styleid=trim(request.QueryString("styleid"))
  compete=trim(request.QueryString("compete"))
  setdate=trim(request.QueryString("setdate"))
  select case act 
  case "del"
  sql="delete from d_competechksub where competechkid="&qts(competechkid)&" and styleid="&qts(styleid)
  ds.Source = sql
  ds.Open
  end select
end select
set ds=nothing
'call aclose("保存成功!谢谢!",1)
'response.Write "jz_ssNext.asp?competechkid="&competechkid&"&depotid="&depotid&"&competeid="&server.URLEncode(compete)&"&setdateid="&setdate
response.Redirect "jz_ssNext.asp?competechkid="&competechkid&"&depotid="&depotid&"&competeid="&server.URLEncode(compete)&"&setdateid="&setdate
%>
</body>
</html>
