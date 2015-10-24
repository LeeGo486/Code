<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%dim styleid,depotid,begdate,cr_name,ReplyText,AdvanText 
styleid=trim(request.Form("styleid"))
depotid=trim(request.Form("depotid"))
begdate=trim(request.Form("begdate"))
cr_name=trim(request.Form("cr_name"))
ReplyText=trim(request.Form("ReplyText"))
AdvanText=trim(request.Form("AdvanText"))
'调查模板的id
modelcode=trim(request.Form("modelcode"))
'调查主题的id
TitleCode=trim(request.Form("TitleCode"))

dim qid(),qname(),qnum(),qsid(),qsname(),aid(),ano(),ascore(),loption(),ct,i,chktype(),chktext(),comment(),lookupids
ct=request.Form("count")
redim qid(ct)
redim qnum(ct)
redim qname(ct)
redim qsid(ct)
redim qsname(ct)

redim aid(ct)
redim ano(ct)
redim ascore(ct)
'redim lvalue(ct)
'redim loption(ct)
'redim chktype(ct)
'redim chktext(ct)
'redim comment(ct)
for i=1 to ct
  qid(i)=trim(request.Form("qid"&i))
  qname(i)=trim(request.Form("qname"&i))
  qnum(i)=trim(request.Form("qnum"&i))
  qsid(i)=trim(request.Form("qsid"&i))
  qsname(i)=trim(request.Form("qsname"&i))
  aid(i)=trim(request.Form("aid"&i))
 ' loption(i)=trim(request.Form("loption"&i))
  ano(i)=trim(request.Form("ano"&i))
  ascore(i)=trim(request.Form("ascore"&i))
    'chktype(i)=trim(request.Form("chktype"&i))
  'chktext(i)=trim(request.Form("aid"&i))
 ' comment(i)=trim(request.Form("comment"&i))
  'lookupids=trim(request.Form("lookupid"&i))
next
'response.Write request.Form("aid2")&"<br>"

'记录调查的题目，款式，店铺名称
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
ds("styleid")=styleid
'ds("lookupid")=lookupids
ds("setdate")=get_date(date)
ds("depotid")=depotid
ds("modelcode")=modelcode
ds("TitleCode")=TitleCode
ds("begdate")=rq1
ds("enddate")=rq2
ds("chk_sure")=0
ds("sure")=0
ds("cr_date")=get_date(date)
ds("cr_name")= cr_name
if trim(ReplyText)<>"" then 
  ds("IsReply")= 1
else
  ds("IsReply")= 0
end if
ds("ReplyText")= ReplyText
ds("AdvanText")= AdvanText
ds("score")= 0.0
ds.Update
ds.Close

dim scorenum
scorenum=0
'记录子表的内容,记录答题内容及答案
sql="select top 1 * from d_competecxsub order by competecxid"
ds.LockType = 3
ds.Source = sql
ds.Open
for i=1 to ct

  ds.Addnew
  ds("competecxid")=competecxid
  ds("chktype")=qname(i)
  
  answers = Split(aid(i), "☆")
  
  ds("chkText")=answers(0)
  ds("chkCode")=answers(1)
  ds("chkScore")=answers(2)
  ds("crdate")=get_date(date)
  ds.Update
  scorenum=scorenum+qnum(i)*0.01*answers(2)
next
ds.Close


'查询所此店此款的销售数量
'ds.LockType = 3
dim sellnums
sellnums=0
sql="select  isnull(sum(b.nums),0) as nums from d_Retail a inner join "&_
    "d_Retailsub b on a.retailid=b.retailid and a.depotid='"&depotid&"' where b.styleid='"&styleid&"'"
ds.Open sql,cn,1,1
if( ds.eof or ds.bof) then
else
sellnums=ds("nums")
end if
ds.Close

'更新调查记录，此调查项目的总分
'ds.LockType = 3
sql="select * from d_competecx where competecxid='"&competecxid&"'" '00005001
'sql="update  d_competecx set where score="&scorenum&" where competecxid='"&competecxid&"'" '00005001
'sql="select * from WebNew_Style where WN_depotid='"&depotid&"' and WN_styleid='"&styleid&"'" 

'ds.Source = sql
ds.Open sql,cn,1,3
if( ds.eof or ds.bof) then
else
ds("Score")=scorenum
ds("SellNum")=sellnums
ds.Update
end if
ds.Close

'更新调查记录，标记此店铺此款式已调查过
sql="select * from WebNew_StyleS where WN_depotid='"&depotid&"' and WN_styleid='"&styleid&"' and WN_Titlecode='"&TitleCode&"' "  '00005001
'sql="select * from WebNew_Style where WN_depotid='"&depotid&"' and WN_styleid='"&styleid&"'" 
ds.Source = sql
ds.Open
if( ds.eof and ds.bof) then
else
ds("WN_chkstate")=1
ds.Update
end if
ds.Close
set ds=nothing
response.write("<script>alert('保存成功!谢谢!');window.location='dc_newlist.asp'</script>")
%>
</body>
</html>
