<!--#include file="../inc/function.asp"-->
<!--#include file="JSON.asp"-->
<%
Response.Charset = "utf-8"
id = trim(request("id"))
act = trim(request("act"))
format=request("format")
record=request("record")		'加载指定记录数
if record="" then record=0

tmln=request("tmln")
clothingid=trim(request("clothingid"))
if round(tmln)>0 then
   clothingid=left(clothingid,len(clothingid)-round(tmln))
end if

select case act
case "d_inventory" 

if session("formid")=2166 then
numstr = "a.d_nums"
else
numstr = "a.nums"
end if
     sql="select a.clothingid,b.s_name,a.colorid+c.c_name,a.sizeid,isnull("&numstr&",0) as nums,"&_
	 	 " a.x_price,isnull("&numstr&"*a.x_price,0) as xsums "&_
         " from d_inventorysub a,j_style b,j_color c where a.inventoryid='"&id&"' "&_
				 "and a.styleid=b.styleid and a.colorid=c.colorid and isnull("&numstr&",0)<>0 order by a.crdate desc"
case "d_sell"
     sql=" select a.clothingid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,a.x_price,isnull(b.nums,0) as snums,"& _
	     "isnull(a.set_nums,0)-isnull(b.nums,0) as ce,"&_
	     "(select c_name from j_color where a.colorid=colorid) as c_name, "& _
	     "(select s_name from j_style where a.styleid=styleid) as s_name "&_
	     "from d_sellsub as a full join webtmp_barcodeget b on a.sellid=b.[id] and a.clothingid=b.clothingid "& _
	     "where a.clothingid="&qts(clothingid)&" and a.sellid="&qts(id)
case "d_outindentpro"
     sql="select a.clothingid,b.s_name,a.colorid,c.c_name,a.sizeid,a.nums,a.x_price,a.nums*a.x_price as xsums "&_
         "from d_outindentprosub a,j_style b,j_color c where a.outindentid='"&id&"' "&_
	     "and a.styleid=b.styleid and a.colorid=c.colorid and isnull(a.nums,0)<>0 order by a.crdate desc"
case "d_outindentset"
     sql="select a.clothingid,b.s_name,c.c_name,a.sizeid,a.nums,a.x_price,a.nums*a.x_price as xsums "&_
         "from d_outindentsetsub a,j_style b,j_color c where a.outindentid='"&id&"' "&_
	     "and a.styleid=b.styleid and a.colorid=c.colorid and isnull(a.nums,0)<>0 order by a.crdate desc"
case "d_moveset"
     sql="select a.clothingid,b.s_name,a.colorid,c.c_name,a.sizeid,a.set_nums as nums,a.x_price,a.set_nums*a.x_price as xsums "&_
         "from d_movesub a,j_style b,j_color c where a.moveid='"&id&"' "&_
	     "and a.styleid=b.styleid and a.colorid=c.colorid and isnull(a.set_nums,0)<>0 order by a.crdate desc"		
case "d_moveget"
     sql=" select a.clothingid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,a.x_price,isnull(b.nums,0) as snums,"& _
	     "isnull(a.set_nums,0)-isnull(b.nums,0) as ce,"&_
	     "(select c_name from j_color where a.colorid=colorid) as c_name, "& _
	     "(select s_name from j_style where a.styleid=styleid) as s_name "&_
	     "from d_movesub as a full join webtmp_barcodeget b on a.moveid=b.[id] and a.clothingid=b.clothingid "& _
	     "where a.moveid="&qts(id)  
case "d_msellset"
     sql="select a.clothingid,b.s_name,a.colorid,c.c_name,a.sizeid,a.set_nums as nums,a.x_price,a.set_nums*a.x_price as xsums "&_
         "from d_msellsub a,j_style b,j_color c where a.msellid='"&id&"' "&_
	     "and a.styleid=b.styleid and a.colorid=c.colorid and isnull(a.set_nums,0)<>0 order by a.crdate desc"
case "d_msellget"
     sql=" select a.clothingid,a.colorid,a.sizeid,isnull(a.set_nums,0) as fnums,a.x_price,isnull(b.nums,0) as snums,"& _
	     "isnull(a.set_nums,0)-isnull(b.nums,0) as ce,"&_
	     "(select c_name from j_color where a.colorid=colorid) as c_name, "& _
	     "(select s_name from j_style where a.styleid=styleid) as s_name "&_
	     "from d_msellsub as a full join webtmp_barcodeget b on a.msellid=b.[id] and a.clothingid=b.clothingid "& _
	     "where a.msellid="&qts(id)	
case "d_indentbh"
     sql="select a.clothingid,b.s_name,a.colorid,c.c_name,a.sizeid,a.nums,a.x_price,a.nums*a.x_price as xsums "&_
         "from d_indentsub a,j_style b,j_color c where a.indentid='"&id&"' "&_
	     "and a.styleid=b.styleid and a.colorid=c.colorid and isnull(a.nums,0)<>0 order by a.crdate desc"	
end select

set rs=server.CreateObject("adodb.recordset")
rs.open sql,cn,1,1
n=0
x=0
if not rs.eof and not rs.bof then
	if format="html" then
		z_nums=0
		z_xprice=0
		html=""
		do while not rs.eof
		n=n+1
			z_nums = cdbl(z_nums)+cdbl(rs(rs.fields.count-3))
			z_xprice = cdbl(z_xprice)+cdbl(rs(rs.fields.count-2))
			z_sums = cdbl(z_sums)+cdbl(rs(rs.fields.count-1))
			if record=0 or cdbl(record)>=n then 
				html=html&"<tr id="""&rs(0)&""">"
					For i = 0 to rs.fields.count-1
					html=html&"<td>"
						if i=0 then html=html&"<a href=javascript:clothing('"&rs(i)&"')>"&rs(i)&"</a>" else html=html&rs(i) end if
					html=html&"</td>"
					Next
				html=html&"</tr>"
			else
				x=x+1
			end if
		rs.movenext
		loop
		
		if x>0 then
				html=html&"<tr><td colspan=""7"" style=""color:gray"">共有"&x&"条记录被省略……</td></tr>"
		end if
		
				html=html&"<tr id=""totaltr""><td>"&session("fromid")&"合 计</td><td>&nbsp;</td><td>&nbsp;</td>"&_
				"<td>&nbsp;</td><td id=""z_nums"">"&z_nums&"</td><td id=""z_xprice"">"&z_xprice&"</td><td id=""z_sums"">"&z_sums&"</td></tr>"
		response.Write(html)
	else
		set js=new JSON
		response.write js.toJSON("data",rs,false)
	end if
end if
rs.close
set rs=nothing
%>