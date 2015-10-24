<%Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<%dim oldid,i,typ,vipcode,cnt,seltmp,boxtmp,tsel,box,j,vipid
oldid=trim(request.querystring("oldid"))
typ=trim(request.querystring("typ"))

if typ="" then
   call main()
else
   call sel()
end if


Sub main()%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>退货</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<form name="form1" method="get" action="pos_thnewsub.asp">
<input type="hidden" name="oldid" value="<%=oldid%>">
<input type="hidden" name="typ" value="sel">
<table width="100%"  border="1" cellspacing="0" bordercolor="#ECD5CF" bordercolorlight="#FFFFFF" class="f12">
  <tr><td>选择</td><td>款号</td><td>现价</td><td>折扣</td><td>结算价</td><td>数量</td><td>金额</td></tr>
<%if oldid<>"" then
set ds=server.CreateObject("adodb.recordset")
sql="select b.boxid,b.clothingid,b.x_price,b.discount,b.s_price,b.nums,b.nums*b.s_price as sums,isnull(a.vipcode,'') as vipcode "&_
    "from d_retail a,d_retailsub b where a.retailid=b.retailid and a.sure>0 and a.retailid='"&oldid&"' order by boxid"
ds.open sql,cn,1,1
if not ds.eof then
   vipcode=ds("vipcode")
   while not ds.eof%>
   <tr>
      <td>
	  <input type="checkbox" name="sel" value="<%response.write(ds("boxid")&"^"&ds("clothingid"))%>">
	  </td>
	  <td><%=ds("clothingid")%></td>
	  <td><%=ds("x_price")%></td>
	  <td><%=ds("discount")%></td>
	  <td><%=ds("s_price")%></td>
	  <td><%=ds("nums")%></td>
	  <td><%=ds("sums")%></td>
   </tr>
<%  ds.movenext
   wend%>
   <input type="hidden" name="cnt" value="<%=ds.recordcount%>"> 
   <input type="hidden" name="vipid" value="<%=vipcode%>">
<%else%>
  <tr height=50><td colspan=7 align=center>没有此销售单记录</td></tr>
<%end if
ds.close
set ds=nothing
end if%>
</table>
</form>
</body>
</html>
<%End Sub

Sub sel()
cnt=request.querystring("cnt")
vipid=request.querystring("vipid")
seltmp=request.querystring("sel")

if seltmp="" then
   response.redirect "pos_thnewsub.asp?typ=&oldid="&oldid
   response.end
end if
tsel=split(seltmp,",")

'插入选择的数据
sql="delete from webtmp_retailsub where retailid='"&session("retailid")&"'"
cn.execute sql
sql="update webtmp_retail set comment='"&oldid&"明细退货',vipcode=null,inputvip=0,discount=null where retailid='"&session("retailid")&"'"
cn.execute sql
session("comment")=oldid&"明细退货"

for j=0 to ubound(tsel)
  box=split(tsel(j),"^")
  sql="insert into webtmp_retailsub "&_
      "(retailid,clothingid,styleid,sizeid,s_name,colorid,c_name,nums,j_price,x_price,s_price,discount,zs,back,boxid,code,"&_
      "oldj_price,oldx_price,olds_price,olddiscount,tmid,prodiscount,pros_price,vipcode,vipcentum) "&_
      "select '"&session("retailid")&"',a.clothingid,a.styleid,a.sizeid,b.s_name,a.colorid,c.c_name,-1*a.nums,a.j_price,a.x_price,a.s_price,"&_
	  "a.discount,isnull(a.larg,0),1,a.boxid,a.code,a.j_price,a.x_price,a.s_price,a.discount,a.clothingid,"&_
	  "a.discount,a.s_price,vipcardid,vipcentum "&_
		"from d_retailsub a,j_style b,j_color c "&_
	  "where a.retailid='"&oldid&"' and a.boxid='"&trim(box(0))&"' and a.clothingid='"&trim(box(1))&"' and a.styleid*=b.styleid and a.colorid*=c.colorid"
  cn.execute sql
next
if vipid<>"" then
   sql="update webtmp_retail set vipcode='"&vipid&"',inputvip=1 where retailid='"&session("retailid")&"'"
   cn.execute sql
   sql="update webtmp_retailsub set vipcode='"&vipid&"' where retailid='"&session("retailid")&"'"
   cn.execute sql
   session("posvipcode")=vipid
end if
response.write("<script>window.parent.returnValue=1;window.parent.close();</script>")
End Sub

cn.close
set cn=nothing%>

