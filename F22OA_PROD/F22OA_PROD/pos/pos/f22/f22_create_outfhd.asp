<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<base target="_self">
</head>

<body>
<%
dim ds,o,sql,UserId,UserName
dim outindentid,outindent
dim indentid,istrue
outindentid=trim(request.QueryString("id"))
istrue=trim(request.QueryString("istrue"))
userid=trim(session("dm").system_userid)
UserName=session("dm").System_Username
indentid=getid("d_outindentset","outindentid","TF",userid)
set ds=server.CreateObject("ADODB.Recordset")
sql="select 1 from d_outindentset where quotaid='"&outindentid&"'"
'de sql
ds.open sql,cn
if not ds.eof then
   response.write("<script>alert('此审批单已生成退货发货单！');window.close();</script>")
   response.End()
end if
ds.close

sql=" insert into d_outindentset (outindentid, outindent, quotaid, MerchantId, depotid, set_depotid, sure, chk_sure, "&_
"setdate, cr_name, cr_date,ov_sure, backrate,  comment, selltype, parentid,Taxonomy)  "& _
" select "&qts(indentid)&","&qts(indentid)&",'"&outindentid&"', MerchantId, depotid, set_depotid, 0, 0, "&_
"setdate, '"&username&"', getdate(),0, backrate,  comment, selltype, parentid,Taxonomy "& _
"  from d_outindentchk  where outindentid="&qts(outindentid)
'de sql
cn.execute sql

if istrue=0	 then
sql="insert into d_outindentSETsub(outindentid, boxid, clothingid, styleid, colorid, sizeid, cost, s_price, nums, discount, j_price, x_price) "& _
	"select "&qts(indentid)&",boxid, clothingid, styleid, colorid, sizeid, cost, s_price, nums, discount, j_price, x_price "& _
	"from d_outindentCHKsub "& _
	"where outindentid="&qts(outindentid)
cn.execute sql
else 

end if 
  
%>
<script language="javascript">
  window.close();
</script>
</body>
</html>
<!--#include file="inc/foot.asp" -->