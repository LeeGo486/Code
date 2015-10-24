<%
styleid=request.QueryString("styleid")
try=request.QueryString("try")
if try=1 then aaa="nums" else aaa="d_nums" end if
lx=request.QueryString("lx")
select case lx
case "indent" id=request.querystring("indentid")
case "move" id=request.QueryString("moveid")
case "inventory" id=request.QueryString("inventoryid")
case "sell" id=request.QueryString("sellid")
end select

'取得款式的尺码组编号
set rs=server.CreateObject("adodb.recordset")
rs.open "select sizegrpid from j_style where styleid='"&styleid&"'",cn
sizegrpid=rs("sizegrpid")
rs.close
set rs=nothing
'取得款式的最新颜色
set rs=server.CreateObject("adodb.recordset")
rs.open "select colorid from j_sizegrpsubc where sizegrpid='"&sizegrpid&"'",cn
while not rs.eof
   colorid=colorid&rs("colorid")&","
rs.movenext
wend
rs.close
set rs=nothing
'取得款式的最新尺码
set rs=server.CreateObject("adodb.recordset")
rs.open "select a.sizeid from j_sizegrpsubs a,j_size b where a.sizegrpid='"&sizegrpid&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)",cn
while not rs.eof
   sizeid=sizeid&rs("sizeid")&","
rs.movenext
wend
rs.close
set rs=nothing

colorid=left(colorid,len(colorid)-1)
sizeid=left(sizeid,len(sizeid)-1)

colorgrp=split(colorid,",")
sizegrp=split(sizeid,",")

'按最新颜色、尺码进行排列
set rs=server.CreateObject("adodb.recordset")
select case lx
case "indent" rs.open "select colorid,sizeid,isnull(nums,0)as nums from d_indentsub where indentid='"&id&"' and styleid='"&styleid&"'",cn
case "move" rs.open "select colorid,sizeid,isnull(set_nums,0) as nums from d_movesub where moveid='"&id&"' and styleid='"&styleid&"'",cn
case "inventory" rs.open "select colorid,sizeid,isnull("&aaa&",0) as nums from d_inventorysub where inventoryid='"&id&"' and styleid='"&styleid&"'",cn
case "sell" rs.open "select colorid,sizeid,isnull(set_nums,0) as nums from d_sellsub where sellid='"&id&"' and styleid='"&styleid&"'",cn
end select
while not rs.eof
      oldgrp=oldgrp&rs("colorid")&","&rs("sizeid")&","&rs("nums")&";"
rs.movenext
wend
rs.close
set rs=nothing
oldgrp=left(oldgrp,len(oldgrp)-1)
oldgrp_1=split(oldgrp,";")

newgrp=""
for i=0 to ubound(colorgrp)
    for j=0 to ubound(sizegrp)
	    a=true
		for k=0 to ubound(oldgrp_1)
            oldgrp_2=split(oldgrp_1(k),",")
			if trim(colorgrp(i))=trim(oldgrp_2(0)) then
			   if trim(sizegrp(j))=trim(oldgrp_2(1)) then
			      newgrp=newgrp&oldgrp_2(0)&","&oldgrp_2(1)&","&oldgrp_2(2)&";"
				  a=false
			   end if
            end if
		next
		if a then newgrp=newgrp&colorgrp(i)&","&sizegrp(j)&",0;" end if
	next
next

'把数量单独取到数组中
newgrp=left(newgrp,len(newgrp)-1)
newgrp1=split(newgrp,";")
for m=0 to ubound(newgrp1)
    newgrp2=split(newgrp1(m),",")
	num=num&newgrp2(2)&","
next
num=left(num,len(num)-1)
num1=split(num,",")%>