<!--#include file="inc/function.asp" -->
<%fdate=request("fdate")
  ldate=request("ldate")
  stat=request("state")
  if stat="" then stat=1 end if
  if fdate="" then fdate=get_date(date) end if
  if ldate="" then ldate=get_date(date) end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<title>产品维修</title>
</head>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<script language="JavaScript">
function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var ge=row.getElementsByTagName("input")[0];
	var id=ge.value;
	showModalDialog('product_posseachsub.asp?id='+id+'&act=<%=stat%>','product','dialogWidth:740px;dialogHeight:570px;center: yes;help:no;resizable:yes;status:no');
	//window.open('product_posseachsub.asp?id='+id+'&act=<%=stat%>')
  }
</script>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<body>
<div id="list" style="width:100%;height:95%;"> 
        <table border="0">
          <thead>
            <tr>
        <td width="70">受理日期</td>
        <td width="90">款号</td>
        <td width="70">款式编号</td>
        <td width="50">颜色</td>
			  <td width="50">维修时限</td>
        <td width="70">退回日期</td>
        <td width="70">收货日期</td>
        <td width="70">处理方式</td>
			  <td width="50">收费金额</td>
			  <td width="50">实收金额</td>
			  <td width="50">抵扣现金</td>
			  <td width="50">抵扣积分</td>
			  <td width="70">发出日期</td>
			  <td width="70">接收日期</td>
			  <td width="70">客户满意度</td>
            </tr>
          </thead>
	 <%select case stat
	   case 1 ss=" and isnull(setchk_sure,0)=0 "
	   case 2 ss=" and isnull(setchk_sure,0)>0 and isnull(chk_sure,0)=0 "
	   case 3 ss=" and isnull(chk_sure,0)>0 and isnull(sure,0)=0 "
	   case 4 ss=" and isnull(sure,0)>0 "
	   case else ss=""
	   end select
	   set rs=server.createobject("adodb.recordset")
	   s1="select a.productid,a.areaname,b.d_name,convert(char(10),a.accept_date,126) as accept_date,a.clothingid,a.st_xh,a.code,"&_
	      "a.c_name,a.repairday,convert(char(10),a.setsure_date,126) as setsure_date,convert(char(10),a.getchk_date,126) as getchk_date,"&_
		  "a.planrepairday,a.taketype,isnull(a.chargesums,0) as chargesums,isnull(jf_price,0) as jf_price , "&_
		  "convert(char(10),a.getsure_date,126) as getsure_date,convert(char(10),a.chksure_date,126) as chksure_date,"&_
		  "convert(char(10),a.sure_date,126) as sure_date,a.my1,isnull(xj_price,0) as xj_price,isnull(centum,0) as centum "&_
		  "from j_productmaintain a,j_depot b where a.accept_depotid=b.depotid "&_
		  "and convert(char(10),a.accept_date,126) between '"&fdate&"' and '"&ldate&"' "&ss&_
		  "and a.accept_depotid='"&session("dm").System_DepotId&"' "&_
		  "order by a.areaname,b.d_name,convert(char(10),a.accept_date,126) desc"
	   rs.open s1,cn,1,1
	   while not rs.eof
	   response.write("<tr>")
	   response.write("<td><input type=hidden value='"&rs("productid")&"'>"&rs("accept_date")&"</td>")
	   response.write("<td>"&rs("clothingid")&"</td>")
	   response.write("<td>"&rs("st_xh")&"</td>")
	   response.write("<td>"&rs("c_name")&"</td>")
	   response.write("<td>"&rs("repairday")&"</td>")
	   response.write("<td>"&rs("setsure_date")&"</td>")
	   response.write("<td>"&rs("getchk_date")&"</td>")
	   response.write("<td>"&rs("taketype")&"</td>")
	   response.write("<td>"&rs("chargesums")&"</td>")
	   response.write("<td>"&rs("xj_price")&"</td>")
	   response.write("<td>"&rs("jf_price")&"</td>")
	   response.write("<td>"&rs("centum")&"</td>")
	   response.write("<td>"&rs("chksure_date")&"</td>")
	   response.write("<td>"&rs("sure_date")&"</td>")
	   response.write("<td>"&rs("my1")&"</td></tr>")
		 		chargesums=chargesums+cdbl(rs("chargesums"))
		 		xj_price=xj_price+cdbl(rs("xj_price"))
		 		jf_price=jf_price+cdbl(rs("jf_price"))
		 		centum=centum+cdbl(rs("centum"))
	   rs.movenext
	   wend
	   rs.close
	   set rs=nothing
	  %>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><%=chargesums%></td>
      <td><%=xj_price%></td>
      <td><%=jf_price%></td>
      <td><%=centum%></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
</body>
</html>
<script language="javascript">
    try{
	 gt = new GtTable("list");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>