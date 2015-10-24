<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<!--#include file="inc/function.asp"-->
</head>

<body>
<%
dim rows,cols,v(),indentid,id,styleid,d,act,clothingid,opt,tn,numName,boxid,dtype,ratelx_type
dim dep_parentid
opt=trim(request.Form("opt"))
id=trim(request.Form("id"))

styleid=trim(request.Form("styleid"))
rows=trim(request.Form("rows"))
cols=trim(request.Form("cols"))
act=trim(request.Form("act"))
numName=trim(request.Form("numName"))
'if indentid="" or isnull(indentid) then
'  response.Redirect ""
'end if
'de numName
if id="" then call zclose()
if styleid="" then
  call zclose()
else
  styleid=ucase(styleid)
end if

set dttype = Server.CreateObject("ADODB.RECORDSET")

select case opt
case "indent"
  tn="d_indentsub"
  fkname="indentid"
  dtype=3
  '订货0
  '补货1
  '铺货2
 
  select case UCase(Left(id,2))
  case "DH"   ratelx_type=0
  case "BH"   ratelx_type=1
  case "PC"   ratelx_type=2
  case else  response.Write("<script>alert('订货类型不正确！')</script>") 
             response.End() 
  end select
 
case "quota"
  tn="d_quotasub"
  fkname="quotaid"
  dtype=3
  ratelx_type=request.cookies("GetPriceType")("T2")
case "sell"
  tn="d_sellsub"
  fkname="sellid"
  dtype=3
  ratelx_type=request.cookies("GetPriceType")("T2")
case "move"
  tn="d_movesub"
  fkname="moveid"
  dtype=3

  ratelx_type=request.cookies("GetPriceType")("T2")
case "retail"
  tn="d_retailsub"
  fkname="retailid"
  ' 此类型不改
  dtype=request.cookies("GetPriceType")("T1")
  ratelx_type=request.cookies("GetPriceType")("T2")
case "outindent"
  tn="d_outindentsub"
  fkname="outindentid"
  '退货3
  dtype=3
  ratelx_type=3
case "outindentPRO"
  tn="d_outindentPROsub"
  fkname="outindentid"
    '2014-03-24 xhp 判断店铺是否2级加盟店铺
    sql="select b.parentid from d_outindentpro a inner join j_depot b on a.depotid=b.depotid where a.outindentid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    end if
    dttype.close
   
    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if
  '退货3
  'dtype=3
  ratelx_type=3
case "outindentsq"
  tn="d_outindentsqsub"
  fkname="outindentsqid"
  '退货3
  dtype=3
  ratelx_type=3
case "outindentCHK"
  tn="d_outindentCHKsub"
  fkname="outindentid"
  '退货3
  dtype=3
  ratelx_type=3
case "outindentset"
  tn="d_outindentsetsub"
  fkname="outindentid"
  '退货3
    sql="select b.parentid from d_outindentset a inner join j_depot b on a.depotid=b.depotid where a.outindentid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    end if
    dttype.close

    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if
  ratelx_type=3
case "inventory"
  tn="d_inventorysub"
  fkname="inventoryid"
  dtype=3
  ratelx_type=request.cookies("GetPriceType")("T2")
case "msell"
  tn="d_msellsub"
  fkname="msellid"
  '2补货
  sql="select b.parentid from d_msell a inner join j_depot b on a.get_depotid=b.depotid where a.msellid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    end if
    dttype.close
   
    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if
  ratelx_type=session("kqdisc")
case else

end select
set dttype=nothing
'de tn
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
  v(i,0)=request.Form("colorid")(i)			'取得每行颜色
  for j=1 to cols
    v(i,j)=request.Form("n"&i&j+1)			'取得值
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
  v(0,j)=request.Form("sizeid")(j)			'取得每列尺码
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
boxid=getboxid()
  for i=1 to rows
    colorid=v(i,0)
	for j=1 to cols
	  if opt="inventory" then '盘点单0也可以保存
	      sizeid =v(0,j)
          clothingid = styleid & colorid & sizeid
		  call insertRsub(styleid,clothingid,v(i,j))
	  else
	    if v(i,j)<>0 then
	      sizeid =v(0,j)
          clothingid = styleid & colorid & sizeid
		  call insertRsub(styleid,clothingid,v(i,j))
	    end if
	  end if
	next
  next
set ds=nothing
call wclose

Sub insertRsub(stid,clothingid,n)'款号'stid为款号,只是用来获得BOXID
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
	
	set ds=Nothing
  else
	call aClose("货号 不能为空!")
	response.End
  end if
  
  
  '是否控制品牌销售BEGIN,盘点不检查
  if session("stylepower")=1 and (tn<>"d_inventorysub") then
    
	dim cd0,ds0
			
	set ds0=Server.CreateObject("ADODB.Recordset")
	ds0.ActiveConnection = cn
 
	sql = " select b.styleid from J_clothing a inner join j_style b on a.styleid=b.styleid "&_
  		" inner join j_branddepot c on b.brandid=c.drandid "&_
		" inner join j_branddepot d on b.brandid=d.drandid "&_
		" where clothingid='"&trim(clothingid)&"'"&_
		" and c.depotid='"&session("get_depotid")&"'"&_
		" and d.depotid='"&session("set_depotid")&"'"

  	ds0.source =sql
  	ds0.open
  	if ds0.eof then
      ds0.close
      set ds0=nothing
      response.Write("<script>alert('此款式收货方或发货方没有经营权限!');self.close();</script>")
	  response.End()
	  
    else
     ds0.close
	 set ds0=nothing
    end if
  end if
  

  '款式经营品牌END
  
  
  ''同区货品、跨区货品是否在通知单内检查
  if (tn="d_msellsub" or tn="d_movesub") and session("noticeid")<>"" and session("noticeid")<>"null" then
    
	dim ds1
			
	set ds1=Server.CreateObject("ADODB.Recordset")
	ds1.ActiveConnection = cn
 
    sql = "select top 1 * from d_movenoticesub a  where noticeid='"&session("noticeid")&"' and clothingid='"&clothingid&"'"
	ds1.source =sql
  	ds1.open

	if  ds1.eof and ds1.bof  then
	  ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品不在通知单内!');self.close();</script>")  
	  response.End()
	else
	  ds1.close  
	end if	
	
	sql = "select top 1 * from d_movenoticesub a  where noticeid='"&session("noticeid")&"' and clothingid='"&clothingid&"'"&_
		  " and nums<"&n
	ds1.source =sql
  	ds1.open

	if not ds1.eof  then
	  ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品的发货数量超过通知单内的发货数量!');self.close();</script>")  
	  response.End()
	else
	  ds1.close  
	end if	
	if tn="d_msellsub" then	
	  sql=" select top 1 c.clothingid"&_
      " from  d_msellsub a  "&_
      " inner join d_msell b on a.msellid=b.msellid" &_
      " inner join d_movenoticesub c on b.noticeid=c.noticeid and a.clothingid=c.clothingid and a.clothingid='"&clothingid&"'"&_
      " where b.msellid='"&id&"' and set_nums>=isnull(nums,0)  "
	else
	  sql=" select top 1 c.clothingid"&_
      " from  d_movesub a  "&_
      " inner join d_move b on a.moveid=b.moveid" &_
      " inner join d_movenoticesub c on b.indentid=c.noticeid and a.clothingid=c.clothingid and a.clothingid='"&clothingid&"'"&_
      " where b.moveid='"&id&"' and set_nums>=isnull(nums,0)  " 
	end if  
		
  	ds1.source =sql
  	ds1.open
  	if not ds1.eof then
      ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品的发货数量超过通知单内的发货数量!');self.close();</script>")  
	  response.End()
	else
     ds1.close
	 set ds1=nothing
    end if
  end if
  

  '跨区货品是否在通知单内检查end
    	 
  '退货货品是否在通知单内检查
  if tn="d_outindentsetsub" and session("quotaid")<>"" and session("quotaid")<>"null" then
    				
	set ds1=Server.CreateObject("ADODB.Recordset")
	ds1.ActiveConnection = cn
 
    sql = "select top 1 * from d_outindentCHKsub a  where outindentid='"&session("quotaid")&"' and clothingid='"&clothingid&"'"
	ds1.source =sql
  	ds1.open

	if  ds1.eof and ds1.bof  then
	  ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品不在通知单内!');self.close();</script>")  
	  response.End()
	else
	  ds1.close  
	end if	
	
	sql = "select top 1 * from d_outindentCHKsub a where outindentid='"&session("quotaid")&"' and clothingid='"&clothingid&"'"&_
		  " and nums<"&n
   	ds1.source =sql
  	ds1.open

	if not ds1.eof   then
	  ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品的发货数量超过通知单内的发货数量!');self.close();</script>")  
	  response.End()
	else
	  ds1.close  
	end if	
		
    sql=" select top 1 a.clothingid"&_
        " from  d_outindentsetsub a  "&_
        " inner join d_outindentset b on a.outindentid=b.outindentid" &_
        " left join  d_outindentCHKsub c on b.quotaid=c.outindentid and a.clothingid=c.clothingid "&_
        " where b.outindentid='"&id&"' and a.nums>=isnull(c.nums,0)  and a.clothingid='"&clothingid&"'"
'	de 	sql
  	ds1.source =sql
  	ds1.open
  	if not ds1.eof then
      ds1.close
      set ds1=nothing 
	  response.Write("<script>alert('此货品的发货数量超过通知单内的发货数量!');self.close();</script>")  
	  response.End()
	else
     ds1.close
	 set ds1=nothing
    end if
  end if
  

  '退货货品是否在通知单内检查end
  
	if styleid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  set cd=Server.CreateObject("ADODB.Command")
	  cd.ActiveConnection = cn
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getstyleprice"
	  v = Session("dm").System_DepotId
		
	  'cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, request.cookies("GetPriceType")("T1"))
      cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, dtype)
      '如果不是d_msell，否则取收货方 
      if tn<>"d_msellsub" then
	    cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  else
	   	cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, session("get_depotid"))
	  end if 
	  
	  cd.Parameters.Append cd.CreateParameter("@styleid", 200, 1, 34, styleid)
	  cd.Parameters.Append cd.CreateParameter("@pricedate", adVarChar, adParamInput, 10, "")
	  'cd.Parameters.Append cd.CreateParameter("@rate_lx", 3, 1, 4, request.cookies("GetPriceType")("T2"))
	  cd.Parameters.Append cd.CreateParameter("@rate_lx", 3, 1, 4, ratelx_type)
	   
	  Set ds = cd.Execute '求价格
  	  If ds.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if

	  nums=n
	  If IsNull(ds.Fields.Item("j_cost").value) Then
	    j_cost = 0
	  Else
	    j_cost = Cdbl(ds.Fields.Item("j_cost").value)
	  End If
	  If IsNull(ds.Fields.Item("j_price").value) Then
	    j_price = 0
	  Else
	    j_price = Cdbl(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("x_price").value) Then
	    x_price = 0
	  Else
	    x_price = Cdbl(ds.Fields.Item("x_price").value)
	  End If
	  If IsNull(ds.Fields.Item("s_price").value) Then
	    s_price = 0
	  Else
	    s_price = Cdbl(ds.Fields.Item("s_price").value)
	  End If
	  
	  If IsNull(ds.Fields.Item("discount").value) Then
	    discount = 0
	  Else
	    discount = Cdbl(ds.Fields.Item("discount").value)
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
	
	sql="select boxid from "&tn&" where "&fkname&"="&qts(id)&" and styleid="&qts(styleid)
	ds.Source = sql
	ds.Open
	if not ds.eof then
	  boxid=ds(0)
	end if
	ds.Close
 
	sql="select * from "&tn&" where "&fkname&"="&qts(id)&" and clothingid="&qts(clothingid)
	ds.Open sql,cn,1,3
	if ds.eof then
	  ds.Addnew
            
	  ds("boxid")=boxid

	  ds(fkname)=id
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  if fkname="outindentid" then
	    ds("cost")=j_cost
	  else
	    ds("j_cost")=j_cost
	  end if
	  
	  'ds("s_price")=x_price*discount
	  ds("s_price")=getFormatNumber(s_price)
	  	 
	  
	  select case tn
	  case "d_quotasub"
	    ds("px_price")=x_price
		ds("pj_price")=j_price
	  case else
	    ds("x_price")=x_price
		ds("j_price")=j_price
	  end select
	  
	  ds(numName)=nums
	  ds("discount")=discount
	else
	  ds(numName)=ds(numName)+nums
	end if
	
	'20090917 针对D_MSELL
	if styleid<>"" and tn="d_msellsub" and session("noticeid")="" then
	  dim ds9
	  'dim j_price,x_price,discount,s_price,v,j_cost
	  set cd=Server.CreateObject("ADODB.Command")
	  cd.ActiveConnection = cn
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getstyleprice"
	  v = Session("dm").System_DepotId
	  	  
	  'cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, request.cookies("GetPriceType")("T1"))
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, dtype)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@styleid", 200, 1, 34, styleid)
	  cd.Parameters.Append cd.CreateParameter("@pricedate", adVarChar, adParamInput, 10, "")
	  'cd.Parameters.Append cd.CreateParameter("@rate_lx", 3, 1, 4, request.cookies("GetPriceType")("T2"))
	  cd.Parameters.Append cd.CreateParameter("@rate_lx", 3, 1, 4, ratelx_type)
	  
	  Set ds9 = cd.Execute '求价格
  	  If ds9.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if

	  nums=n
	  If IsNull(ds9.Fields.Item("j_cost").value) Then
	    j_cost = 0
	  Else
	    j_cost = Cdbl(ds9.Fields.Item("j_cost").value)
	  End If
	  If IsNull(ds.Fields.Item("j_price").value) Then
	    j_price = 0
	  Else
	    j_price = Cdbl(ds9.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds9.Fields.Item("x_price").value) Then
	    x_price = 0
	  Else
	    x_price = Cdbl(ds9.Fields.Item("x_price").value)
	  End If
	  If IsNull(ds9.Fields.Item("s_price").value) Then
	    s_price = 0
	  Else
	    s_price = Cdbl(ds9.Fields.Item("s_price").value)
	  End If
	  
	  If IsNull(ds9.Fields.Item("discount").value) Then
	    discount = 0
	  Else
	    discount = Cdbl(ds9.Fields.Item("discount").value)
	  End If
	  ds9.Close	
	
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
	  'ds("s_price1")=x_price*discount 
	  ds("s_price1")=getFormatNumber(s_price)
 
	  ds("x_price1")=x_price
	  ds("j_price1")=j_price
	  ds("discount1")=discount
	  
	end if
  end if 
  ' 取价结束
	
	
	ds.Update
	ds.close
	  
  end if
  
  updprice()	
End Sub

function getboxid()
  dim ds,boxid
  set ds=server.CreateObject("ADODB.RecordSet")
  ds.ActiveConnection = cn
  ds.Source = "Select top 1 boxid from "&tn&" where boxid like 'W_________' order by boxid desc"
  ds.open
  if not ds.eof then
    boxid=ds(0)
  else
    boxid="W000000000"
  end if
  ds.Close
  Set ds=nothing
  bid=right(boxid,9)
  bid=cdbl(bid)
  bid=bid+1
  boxid="000000000" &bid
  boxid=right(boxid,9)
  boxid="W" &boxid
  getboxid=boxid
end function

'同步通知单内的价格
sub updprice()
if session("noticeid")<>"" and session("noticeid")<>"null" then
  dim sql
  sql =  " update d_msellsub "&_
         " set x_price=c.x_price,discount=c.discount,s_price=c.s_price, "&_
		 "    x_price1=c.x_price1,s_price1=c.s_price1,discount1=c.discount1"&_
		 " from  d_msellsub a "&_
		 " inner join d_msell b on a.msellid=b.msellid "&_
		 " inner join  d_movenoticesub c on b.noticeid=c.noticeid and a.clothingid=c.clothingid " &_
		 " where b.msellid='"&id&"' and a.clothingid='"&clothingid&"'"
  cn.execute sql		 
end if
end sub
'同步通知单内的价格END

%>

<%sub wclose()%>
<script language="javascript">
  window.returnValue=true;
  window.close();
</script>
<%end sub%>

</body>
</html>
