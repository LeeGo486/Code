<!--#include file="../inc/function.asp"-->
<%
dim getdepotid,sql0,rs0
dim dep_parentid,dttype,dtype
set dttype = Server.CreateObject("ADODB.RECORDSET")

id = trim(request("id"))
clothingid=trim(request("clothingid"))
oldclothingid=clothingid
typ=request("typ")
tmln=request("tmln")
userid=trim(session("dm").System_UserId)
nums=request("nums")
depotid=trim(session("dm").system_depotid)


if round(tmln)>0 then
   clothingid=left(clothingid,len(clothingid)-round(tmln))
end if

CheckBrand()


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
    set dttype=nothing

set rs=server.CreateObject("adodb.recordset")
set rs0=server.CreateObject("adodb.recordset")
set rs1=server.CreateObject("adodb.recordset")
'改出收货地价格,并加上发货地价格
sql="t18tj_GetClothingPrice "&dtype&",'"&session("get_depotid")&"','"&clothingid&"','',"&session("kqdisc")
sql0="t18tj_GetClothingPrice "&dtype&",'"&depotid&"','"&clothingid&"','',"&session("kqdisc")

rs0.open sql0,cn
if rs0.eof then
   response.write("false")
   response.End()
end  if 

rs.open sql,cn
if rs.eof then
   response.write("false")
   response.End()
else
  clothingid=rs("clothingid")
   '扫描正数检查审批单
   if cdbl(typ)=1 then
      CheckTZ()
   end if   
   'if session("iftmlist")=1 and cdbl(typ)=1 then
   CheckFlow(0)
   'end if
   
   sql = "select * from d_msellsub where msellid='"&id&"' and clothingid='"&rs("clothingid")&"'"
   rs1.open sql,cn,1,3
   if rs1.eof then
      rs1.addnew
      rs1("msellid")=id
      rs1("boxid")="000000"
      rs1("clothingid")=rs("clothingid")
      rs1("styleid")=rs("styleid")
      rs1("colorid")=rs("colorid")
      rs1("sizeid")=rs("sizeid")
      rs1("j_cost")=rs("j_cost")
      rs1("x_price")=rs("x_price")
     
	  
	  'if session("roundcnt")>0 then
	  '   rs("s_price")=cdbl(rs("s_price"))/session("roundcnt")
	  '   rs("s_price")=round(rs("s_price"),2)
	  '   rs("s_price")=cdbl(rs("s_price"))*session("roundcnt")
	  'end if
		  
	  'rs1("s_price")=rs("s_price")		  
	  rs1("s_price")=getFormatNumber(rs("s_price"))
	  
      rs1("set_nums")=cdbl(typ)*nums
      rs1("discount")=rs("discount")
      rs1("j_price")=rs("j_price")
      rs1("crdate")=now()
	  
	  '发货地价格
	  rs1("j_price1")=rs0("j_price")
	  rs1("x_price1")=rs0("x_price")
 
 	 
	  
	  'rs1("s_price1")=rs0("s_price")
	  rs1("s_price1")=getFormatNumber(rs0("s_price"))
	  rs1("discount1")=rs0("discount")
	  	  	  
      rs1.update
   else
      rs1("set_nums")=rs1("set_nums")+cdbl(typ)*nums
      rs1("crdate")=now()
	  rs1.update
   end if
   rs1.close
   
   if session("iftmlist")=1 then
      savetmlist id,oldclothingid,clothingid,0
   end if
   
   updprice()
   
   response.write("true")
end if
'rs0.close
rs.close
set rs=nothing
set rs1=nothing

'跨区货品是否在通知单内检查
sub CheckTZ()
if session("noticeid")<>"" and session("noticeid")<>"null" then
  dim ds,sql
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn

  sql = "select top 1 * from d_movenoticesub a  where noticeid='"&session("noticeid")&"' and clothingid='"&clothingid&"'"
  ds.source =sql
  ds.open
  if  ds.eof and  ds.Eof then
     ds.close
     set ds=nothing
	 response.Write("no")
	 response.End()
  else
    ds.close
	
    sql=" select top 1 a.clothingid"&_
        " from  d_msellsub a  "&_
        " inner join d_msell b on a.msellid=b.msellid" &_
        " left join  d_movenoticesub c on b.noticeid=c.noticeid and a.clothingid=c.clothingid "&_
        " where b.msellid='"&id&"' and set_nums>=isnull(nums,0)  and a.clothingid='"&clothingid&"'"
     
	ds.source =sql
	ds.open
    if  not ds.eof or not  ds.Eof then
      ds.close
      set ds=nothing
	  response.Write("nums")
	  response.End()
    else	
      ds.close
	  set ds=nothing
	end if  
  end if

end if
'货品是否在通知单内检查END
end sub


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
'货品是否在通知单内检查END

%>