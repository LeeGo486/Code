<%option explicit%>
<!--#include file="inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%dim rs,id,sql,clothingid,userid,rs1,boxid,show,typ,oldclothingid
dim setdepotid,setdptname,set_nums,set_sums,setsure_date,tmln,nums
boxid="000000"
id = trim(request.QueryString("id"))
show=request.QueryString("show")
clothingid=trim(request.QueryString("clothingid"))
oldclothingid=clothingid
typ=request.QueryString("typ")
tmln=request.QueryString("tmln")
userid=trim(session("dm").System_UserId)
nums=request("nums")
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
set rs1 = Server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection = cn
rs.LockType = 3

if round(tmln)>0 then
   clothingid=left(clothingid,len(clothingid)-round(tmln))
end if

'判断款号
sql="select clothingid from j_clothing where oldclothingid="&qts(clothingid)
rs.source = sql
rs.open
if not rs.eof then
   clothingid=rs("clothingid")
end if
rs.close

if clothingid<>"" then
  sql = " select 1 from j_clothing where clothingid="&qts(clothingid)
  rs.source = sql
  rs.open
  if rs.eof then
    call mbox("档案中没有这个款式!")
	rs.close
	set rs = nothing
	response.End()
  end if
  rs.close
  
  sql = "select * from d_movesub where moveid="&qts(id)&" and clothingid="&qts(clothingid)
  rs.source = sql
  rs.open
  if rs.eof then
    'sql="t18tj_GetClothingPrice 1,'"&session("dm").system_depotid&"','"&trim(clothingid)&"'"
	sql="t18tj_GetClothingPrice 3,'"&session("dm").system_depotid&"','"&trim(clothingid)&"','',"&request.Cookies("GetPriceType")("T2")
	rs1.source = sql
	rs1.open
	if not rs1.eof then
    rs.addnew
	rs("moveid")=id
	rs("boxid")=boxid
	rs("clothingid")=clothingid
	rs("styleid")=rs1("styleid")
	rs("colorid")=rs1("colorid")
	rs("sizeid")=rs1("sizeid")
	rs("j_cost")=rs1("j_cost")
	rs("x_price")=rs1("x_price")
	rs("s_price")=rs1("s_price")
	rs("set_nums")=cdbl(typ)*nums
	rs("discount")=rs1("discount")
	rs("j_price")=rs1("j_price")
	rs.update
	end if
	rs1.close
  else
  cn.execute "update d_movesub set set_nums=set_nums+"&cdbl(typ)*nums&" where moveid="&qts(id)&" and clothingid="&qts(clothingid)
	'rs("set_nums")=rs("set_nums")+cdbl(typ)*1
	'rs.update
  end if
  rs.close
end if
set rs1=nothing
set rs=nothing

if session("iftmlist")=1 then
   savetmlist id,oldclothingid,clothingid,0
end if

response.Redirect("2067_move_barcode_sub.asp?id="&id&"&show="&show)
%>