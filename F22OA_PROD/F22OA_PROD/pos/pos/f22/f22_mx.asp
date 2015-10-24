<%
option explicit
Response.Expires=-1000
if not isempty(request.QueryString("formid")) then
session("formid")=request.QueryString("formid")
end if 
%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<base target="_self">
<title>查看单据明细</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">
function pp(id){
    var sm=showModalDialog("<%=session("xpname")%>?id="+id,window,"dialogWidth:450px;dialogHeight:450px;center: yes;help:no;resizable:no;status:no");
}
function mx(){
  //  var sm=showModalDialog("2019_retail_search_mx.asp?<%=request.ServerVariables("QUERY_STRING")%>",window,"dialogWidth:800px;dialogHeight:600px;center: yes;help:no;resizable:no;status:no");
window.location="2019_retail_search_mx.asp?<%=request.ServerVariables("QUERY_STRING")%>";
  
}

function printtest()
{

  // var url="f22_mxSubotherPrn.asp?<%=request.ServerVariables("QUERY_STRING")%>";
   var url='<iframe id=\"printFrame\" src=\"f22_mxSubotherPrn.asp?<%=request.ServerVariables("QUERY_STRING")%>"\" style=\"height:0px;width:0px;overflow:hidden\"></iframe>';
     document.getElementById('printArea').innerHTML=url;
}
</script>
<body>
<table width="100%"  border="0" align="center" cellpadding="3" class="bar">
<form name="form1" method="get" action="f22_mxSub.asp" target="m2kcs">

<tr align="center">
  <!--打印-->
  <%if pprint then%>
	 <%if session("formid")=2019 then%>
        <td></td>
        <td><input type="button" name="but6" value="显示明细" onClick="mx()"></td>
        <%else%>
		<!--
        <td><input type="button" name="but2" value="打印预览（7CM纸张）" onClick="showModalDialog('f22_mxSubPrnmin.asp?<%=request.ServerVariables("QUERY_STRING")%>','e','dialogWidth:220px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"></td>
		-->
		
		<% if session("cf_POS_ReportFormat")<>1 then %> 
        <td><input type="button" name="but3" value="打印预览（A4/链式纸张）" onClick="showModalDialog('f22_mxSubPrn.asp?<%=request.ServerVariables("QUERY_STRING")%>','e','dialogWidth:680px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"></td>
		<%else%>
		 <td><input type="button" name="but3" value="打印(自定义/链式纸张）" onClick="printtest();"></td>
		 <%end if %>
	 <%end if%>
  <%end if%>
  
  <!--导出-->
  <%if pexport then%>
  <td><input type="button" name="but4" value="导出Excel"
   onClick="document.all.form1.submit();"></td>
  <%end if%>
  <td><input type="button" name="but5" value="退出" onClick="window.close();"></td>
</tr>
<input type="hidden" name="id" value="<%=request.QueryString("id")%>">
<input type="hidden" name="tn" value="<%=request.QueryString("tn")%>">
<input type="hidden" name="pksname" value="<%=request.QueryString("pksname")%>">
<input type="hidden" name="formid" value="<%=request.QueryString("formid")%>">
<input type="hidden" name="act" value="1">
 <div id="printArea" style=" display:none; float:left;width:1px; height:1px;"></div>
</form>
</table>
<iframe name="m2kcs" src="f22_mxSub.asp?<%=request.ServerVariables("QUERY_STRING")%>" frameborder="0" width="100%" height="99%"></iframe>
</body>
</html>
