<%option explicit%>
<!--#include file="inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%dim rs,id,sql,clothingid,userid,show,typ,oldclothingid
dim setdepotid,setdptname,set_nums,set_sums,setsure_date,tmln,nums
id = trim(request.QueryString("id"))
show = request.QueryString("show")
clothingid=trim(request.QueryString("clothingid"))
oldclothingid=clothingid
typ=request.QueryString("typ")
tmln=request.QueryString("tmln")
userid=trim(session("dm").System_UserId)
nums=request("nums")
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
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
  sql = " select top 1 isnull(a.getchk_sure,0) as getchk_sure from d_sell a,d_sellsub b where a.sellid=b.sellid and a.sellid="&qts(id)&" and clothingid="&qts(clothingid)
  rs.source = sql
  rs.open
  if rs.eof then
    call mbox("此收货单中没有这个款式!")
	rs.close
	set rs = nothing
	response.End()
  else
    if rs("getchk_sure")>0 then
      call mbox("此单已审核，不允许操作!")
	  rs.close
	  set rs = nothing
	  response.End()
	end if
  end if
  rs.close
  
  sql = "select id,userid,clothingid,nums from webtmp_barcodeget where id="&qts(id)&" and clothingid="&qts(clothingid)
  rs.source = sql
  rs.open
  if rs.eof then
    rs.addnew
	rs("id")=id
	rs("userid")=userid
	rs("clothingid")=clothingid
	rs("nums")=cdbl(typ)*nums
	rs.update
  else
	rs("nums")=rs("nums")+cdbl(typ)*nums
	rs.update
  end if
  rs.close
end if
set rs=nothing

if session("iftmlist")=1 then
   savetmlist id,oldclothingid,clothingid,0
end if

response.Redirect("2062_indent_barcode_sub.asp?id="&id&"&show="&show)
%>