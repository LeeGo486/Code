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

'�жϿ��
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
    call mbox("������û�������ʽ!")
	rs.close
	set rs = nothing
	response.End()
  end if
  rs.close
  
  '�õ�ȡ���۵Ĳ���
  call GetPriceType(id,"outindentPRO")
  
  sql = "select * from d_outindentprosub where outindentid="&qts(id)&" and clothingid="&qts(clothingid)
  rs.source = sql
  rs.open
  if rs.eof then
   ' sql="t18tj_GetClothingPrice "&request.Cookies("GetPriceType")("T1")&",'"&session("dm").system_depotid&"','"&trim(clothingid)&"','',"&request.Cookies("GetPriceType")("T2")
   sql="t18tj_GetClothingPrice 3,'"&session("dm").system_depotid&"','"&trim(clothingid)&"','',3"
	rs1.source = sql
	rs1.open
	if not rs1.eof then
    rs.addnew
	rs("outindentid")=id
	rs("boxid")=boxid
	rs("clothingid")=clothingid
	rs("styleid")=rs1("styleid")
	rs("colorid")=rs1("colorid")
	rs("sizeid")=rs1("sizeid")
	rs("cost")=rs1("j_cost")
	rs("s_price")=rs1("s_price")
	rs("discount")=rs1("discount")
	rs("j_price")=rs1("j_price")
	rs("x_price")=rs1("x_price")
	
	if session("roundcnt")>0 then
	   rs("s_price")=cdbl(rs("s_price"))/session("roundcnt")
	   rs("s_price")=round(rs("s_price"),2)
	   rs("s_price")=cdbl(rs("s_price"))*session("roundcnt")
	   if IsNull(rs("x_price")) or cdbl(rs("x_price"))=0 then
	      rs("discount")=0
	   else
	      rs("discount")=cdbl(rs("s_price"))/cdbl(rs("x_price"))
	   end if
	end if
	
	rs("nums")=cdbl(typ)*nums
	rs.update
	end if
	rs1.close
  else
  	rs("crdate") = now()
	rs("nums")=rs("nums")+cdbl(typ)*nums
	rs.update
  end if
  rs.close
end if
set rs1=nothing
set rs=nothing

if session("iftmlist")=1 then
   savetmlist id,oldclothingid,clothingid,0
end if

response.Redirect("2063_outindent_barcode_sub.asp?id="&id&"&show="&show)
%>