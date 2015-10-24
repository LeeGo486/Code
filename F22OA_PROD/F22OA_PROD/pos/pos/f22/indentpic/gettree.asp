<!--#include file="../inc/function.asp"-->
<%set rs=server.CreateObject("adodb.recordset")
set rs1=server.CreateObject("adodb.recordset")
set rs2=server.CreateObject("adodb.recordset")
rs.open "select st_year from j_style group by st_year order by st_year",cn,1,1
'if config_type=1 then
   'rs1.open "select lookname from j18_lookupsub where lookupid='2001' order by lookcode",cn,1,1
   'rs2.open "select lookname from j18_lookupsub where lookupid='2002' order by lookcode",cn,1,1
'else
   rs1.open "select dh_1 from j_style group by dh_1 order by dh_1",cn,1,1
   rs2.open "select dh_2 from j_style group by dh_2 order by dh_2",cn,1,1
'end if
while not rs.eof
  if rs(0)<>"" or not isnull(rs(0)) then i=i&rs(0)&";" end if
  rs.movenext
wend
if i<>"" then i=left(i,len(i)-1) end if
while not rs1.eof
	  if rs1(0)<>"" or not isnull(rs1(0)) then j=j&rs1(0)&";" end if
	  rs1.movenext
wend
if j<>"" then j=left(j,len(j)-1) end if
while not rs2.eof
	  if rs2(0)<>"" or not isnull(rs2(0)) then k=k&rs2(0)&";" end if
	  rs2.movenext
wend
if k<>"" then k=left(k,len(k)-1) end if
rs.close
rs1.close
rs2.close
set rs=nothing
set rs1=nothing
set rs2=nothing
cn.close
set cn=nothing

tree1=split(i,";")
tree2=split(j,";")
tree3=split(k,";")
%>