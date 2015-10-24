<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%
dim rows,cols,v(),indentid,id,styleid,d,action,clothingid
id=trim(request.Form("id"))
styleid=id
rows=trim(request.Form("rows"))
cols=trim(request.Form("cols"))
retailid=session("retailid")
action=trim(request.Form("action"))
'if indentid="" or isnull(indentid) then
'  response.Redirect ""
'end if
redim v(rows,cols)
if rows<> "" then
  rows=cint(rows)
else
  rows=0
end if
if cols<> "" then
  cols=cint(cols)
else
  cols=0
end if
for i=1 to rows
  v(i,0)=request.Form("colorid")(i)'取得每行颜色
  for j=1 to cols
    v(i,j)=request.Form("n"&i&j+1)'取得值
  next
next
dim flag
flag=false
for i=1 to rows
  for j=1 to cols
    if v(i,j)="" then
	  v(i,j)=0
	else
      v(i,j)=cint(v(i,j))
	  flag=true
	end if
  next
next
if not flag then
  call wclose()
  response.End()
end if

for j=1 to cols
  v(0,j)=request.Form("sizeid")(j)'取得每列尺码
next

'for i=0 to rows
'  response.Write "<br>第 "&i&" 行:"
'  for j=0 to cols
'    response.Write v(i,j) &"&nbsp;"
'  next
'next
dim ds
set ds=server.CreateObject("ADODB.RecordSet")
ds.ActiveConnection = cn
  for i=1 to rows
    colorid=v(i,0)
	for j=1 to cols
	  if v(i,j)>0 then
	    sizeid =v(0,j)
        clothingid = styleid & colorid & sizeid
		call insertRsub(clothingid,v(i,j))
	  end if
	next
  next
set ds=nothing
call wclose

Sub insertRsub(clothingid,n)'款号
  dim cd,sql,styleid,colorid,sizeid,sname,kc,c_name,zs,back,val
  dim sums
  zs=0
  back=0
  select case act
  case "zs"
    zs=1
  case "th"
    back=1
  end select
  if clothingid<>"" then
	sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name from j_clothing a,j_style b where a.styleid=b.styleid and clothingid='"&clothingid&"'"
	ds.Source = sql '查货号
	
	ds.open
	if not ds.eof then
	  styleid=ds(0)
	  colorid=ds(1)
	  sizeid=ds(2)
	  sname=ds(3)
	  ds.close
	else
      ds.close
	  '没找到,把此ID作为款式编号来查
	  sql="select s_name from j_style where styleid='"&clothingid&"'"
	  ds.source = sql
	  ds.open
	  if not ds.eof then '查为款式编号,则弹出二维输入界面.
	    ds.close
		set ds=nothing
		call showinput(clothingid)
		response.end
	  else
	    ds.close
		set ds=nothing
	    call aClose("货号 " & clothingid &" 不存在!")
        response.End
	  end if
    end if
	
	
	sql="select p_num,k_num from j_stock where depotid='"&depotid&"' and clothingid='"&clothingid&"'"
	ds.source = sql '求库存
	ds.open
	if not ds.eof then
	  kc=ds("k_num")
	else
	  kc=0
	end if
	set ds=Nothing
  else
	call aClose("货号 不能为空!")
	response.End
  end if

	if styleid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  set cd=Server.CreateObject("ADODB.Command")
	  cd.ActiveConnection = cn
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getstyleprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@styleid", 200, 1, 34, styleid)
	  'cd.Parameters.Append cd.CreateParameter("@pricedate", adVarChar, adParamInput, 10, "")
	  'Response.End
	  Set ds = cd.Execute '求价格
  	  If ds.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  nums=n
	  If IsNull(ds.Fields.Item("j_cost").value) Then
	    j_cost = "0"
	  Else
	    j_cost = CStr(ds.Fields.Item("j_cost").value)
	  End If
	  If IsNull(ds.Fields.Item("j_price").value) Then
	    j_price = "0"
	  Else
	    j_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("x_price").value) Then
	    x_price = "0"
	  Else
	    x_price = CStr(ds.Fields.Item("x_price").value)
	  End If
	  If IsNull(ds.Fields.Item("s_price").value) Then
	    s_price = "0"
	  Else
	    s_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("discount").value) Then
	    discount = "0"
	  Else
	    discount = CStr(ds.Fields.Item("discount").value)
	  End If
	  ds.Close	
	
	if zs=1 then
	  sums=trim(request.QueryString("sums"))
	  if not isnumeric(sums) then
	    sums=0
	  else
	    sums=cdbl(sums)
	  end if
	else
	  if cdbl(discount)=0 or cdbl(discount)=1 then
	    sums=x_price
	  else
	    s_price=x_price*cdbl(discount)
	    sums=s_price
	  end if
	  
	end if
	
	ds.LockType = 3
	sql="select * from webtmp_retailsub where retailid="&qts(retailid)&" and clothingid="&qts(clothingid)&" and zs="&zs&" and back="&back
	ds.Source = sql
	ds.Open
	if ds.eof then
	  ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("nums")=nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=zs
	  ds("back")=back
	  ds("sums")=sums
	else
	  ds("styleid")=styleid
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("s_name")=sname
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  ds("x_price")=x_price
	  ds("nums")=ds("nums")+nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("sums")=cdbl(ds("sums"))+sums
	end if
	ds.Update
	ds.close
	  
  end if
	
End Sub

function getboxid()
  dim ds,boxid
  set ds=server.CreateObject("ADODB.RecordSet")
  ds.ActiveConnection = cn
  ds.Source = "select top 1 boxid from d_retailsub order by boxid desc"
  ds.open
  if ds.eof then
    getboxid="LS0000"
  else
    boxid=ds(0)
	boxid=cint(right(boxid,4))
	boxid=boxid+1
	getboxid="LS"&right("0000"&boxid,4)
  end if
  ds.close
  set ds=nothing
end function

%>

<%sub wclose()%>
<script language="javascript">
  window.close();
</script>
<%end sub%>

</body>
</html>
