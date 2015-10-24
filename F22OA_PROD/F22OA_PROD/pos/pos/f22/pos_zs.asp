<%Response.Expires=-1000%>
<%
Response.Charset = "gb2312"
dim depotname,retailid,sum,setdate
retailid=trim(session("retailid"))
depotname=trim(session("dm").System_depotname)
setdate=trim(request("setdate"))
dim ds,cn,tmp,i,totalzsnums,kclothingid,sql
sum=0
set cn=server.createobject("ADODB.Connection")
cn.open session("cn")
set rs=server.createobject("adodb.recordset")

'判断是否有销售记录
sql="select 1 from webtmp_retailsub where retailid='"&retailid&"'"
rs.open sql,cn,1,1
if rs.eof then
   response.write("<script>alert('没有销售记录！');window.close();</script>")
   rs.close
   set rs=nothing
   response.end
end if
rs.close

'判断是否有无库存不能销售控制
if session("ifkc") then
	sql="select clothingid from webtmp_retailsub "&_
					" where isnull(kc,0)-isnull(nums,0)<0 and isnull(back,0)=0 and retailid='"&retailid&"'"
	rs.open sql,cn,1,1
	if not rs.eof and not rs.bof then
	kclothingid=""
		do while not rs.eof
			kclothingid = kclothingid&"\n"&rs("clothingid")
		rs.movenext
		loop
		 response.write("<script>alert('以下货品销售后库存将小于0，不能销售！"&kclothingid&"');window.close();</script>")
		 response.End()
	end if
	rs.close
end if

rs.open "select isnull(totalzsnums,0) as nums from webtmp_retail where retailid='"&retailid&"'",cn
session("totalzsnums")=rs("nums")
rs.close
set rs=nothing
'清除赠送表
cn.execute "delete from webtmp_zs where retailid='"&retailid&"'"

%>
<HTML>
  <HEAD><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <title>赠送列表</title>
  <link href="css/f22.css" rel="stylesheet" type="text/css">
  <script language="javascript">
  function b5(){
	window.location.href="pos_sy.asp?id=<%=retailid%>&setdate=<%=setdate%>";
  }
  
  </script>
<base target="_self">
  </HEAD>
 <body>
  <form action="pos_sy.asp" method="get">
    <style media='print'>
   .Noprint { DISPLAY: none }
   .PageNext { PAGE-BREAK-AFTER: always }
  </style>
<center>
<iframe name="zssub" frameborder="0" scrolling="auto" src="pos_zssub.asp" width="450" height="150"></iframe><br>
<span style="font-size:16px ">赠送选择列表</span>
<hr width="400" size="1" noshade>
<table width='450' border="0" align="center"  class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
    <td>编号</td>
    <td>名称</td>
	<td>颜色</td>
    <td>现价</td>
    <td>单价</td>
    <td>金额</td>
  </tr>
  <%
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = "select a.styleid,b.s_name,a.colorid,c.c_name,a.x_price,a.rate,a.s_price,a.nums,nums*s_price as sums  "&_
              " from d_retailzstmp a,j_style b,j_color c "& _
  			  " where a.styleid=b.styleid and a.colorid=c.colorid and retailid='"&retailid&"'"
  'response.Write "<textarea>"& ds.Source&"</textarea>"
  ds.Open
  i=0
  if ds.eof then
    response.redirect "pos_sy.asp?id="&retailid&"&setdate="&setdate
    response.End()
  end if
  while not ds.eof
  i=i+1%>
  <tr>
    <td>&nbsp;<%=ds("styleid")%></td>
    <td>&nbsp;<%=ds("s_name")%></td>
	<td>&nbsp;<%response.write(ds("colorid")&"("&ds("c_name")&")")%></td>
    <td>&nbsp;<%=ds("x_price")%></td>
    <td>&nbsp;<%=ds("s_price")%></td>
    <td>
	<%sums=cdbl(ds("sums"))
	um=sum+sums
	response.write sums
'	 if ds("zs")=false then
'	   response.Write sums
'	   
'	  elseif ds("zs")=true then
'	    response.write sums&"(<font color=#FF0000>赠送</font>)"
'	  end if%></td>
  </tr>
  <%ds.MoveNext
  wend
  ds.Close
  set ds=nothing%>
  <!--<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>总计:</td>
    <td><%=sum%></td>
  </tr>-->

</table>
<br><br>
<input type="submit" name="" value=" 确 定 ">
<input name="id" type="hidden" id="id" value="<%=retailid%>">
<input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
</center> 
</form>
<script language="javascript">
var wh=300+20*<%=i%>;
window.dialogWidth="500px";
window.dialogHeight=wh+"px";
</script>
 </body>
</HTML>

