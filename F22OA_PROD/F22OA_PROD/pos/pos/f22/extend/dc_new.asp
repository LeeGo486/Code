<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
		       <script type="text/javascript">
        var GB_ROOT_DIR = "./greybox/";
    </script>

    <script type="text/javascript" src="greybox/AJS.js"></script>
    <script type="text/javascript" src="greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="greybox/gb_scripts.js"></script>
   <link href="greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
<!--#include file="inc/function.asp"-->
<style>
#ShowDivLink{
font-size:12px;
}
#ShowDivLink:hover{
color:#ff3300
}
</style>
<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
</head>

<body style="font-size:12px ">
<%dim userid
userid=trim(session("dm").System_UserId)
%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk" style="font-size:12px ">
  <tr>
    <td height="21"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 款式调查</td>
	<td align="right"><a href="dc_newlist.asp">返 回</a></td>
  </tr>
</table>
<%
dim styleid
id=trim(request.QueryString("id"))
modelcode=trim(request.QueryString("modelcode"))
sql="select a.WN_ID, a.WN_TitleCode, a.WN_depotid, a.WN_modelcode, a.WN_styleid,b.TitleDateBegin,b.TitleDateEnd,b.TitleName,b.Commet from "&_
   " WebNew_StyleS a inner join webfind_Bill b on  a.WN_TitleCode=b.TitleCode where WN_ID="&id
set dss=server.CreateObject("adodb.recordset")
dss.open sql,cn
if not dss.eof then
modelcode=dss("WN_modelcode")
btime=dss("TitleDateBegin")
etime=dss("TitleDateEnd")
stylid=dss("WN_styleid")
TitleCode=dss("WN_TitleCode")
TitleName=dss("TitleName")
Commet=dss("Commet")
dss.close
end if
%><form name="form1" method="post" action="dc_new_save.asp">

<table width="100%"  border="0">
    <tr>
      <td align="center"><h1><% =TitleName %></h1></td>
    </tr>
	   <tr>
      <td align="left"><% if Commet<>"" then %><%=Commet%> <% else %> <% end if %></td>
    </tr>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF" class="f12">
  <tr>
    <td width="15%">商场:</td>
    <td width="16%">
	<select name="depotid" id="depotid">
      <option value="<%=session("dm").System_Depotid%>"><%=session("dm").System_DepotName%></option>
    </select></td>
    <td width="15%">调查人:</td>
    <td width="22%"><%=session("dm").System_UserName%> 
	  <input name="cr_name" type="hidden" id="cr_name" value="<%=userid%>">
	  </td>
    <td colspan="2" rowspan="3" align="center" valign="top">
	<a href="clothing.asp?id=<%=stylid%>" target="_blank"><img src="dc_showphoto.asp?id=<%=stylid%>&action=style" border="0" width="80"  height="100"></a>
	</td>
    </tr>
  <tr>
    <td>产品型号:</td>
    <td><%=stylid%><a href="clothing.asp?id=<%=stylid%>" target="_blank">查看详细</a>
      <input name="styleid" type="hidden" id="styleid" value="<%=stylid%>">
	  <input name="modelcode" type="hidden" id="modelcode" value="<%=modelcode%>">
	  <input name="TitleCode" type="hidden" id="TitleCode" value="<%=TitleCode%>">
	  </td>
    <td >调查时间:</td>
    <td><%=date%> <input name="begdate" type="hidden" id="begdate"  value="<%=date%>"></td>
    </tr>
    <tr>
    <td>调查开始时间:</td>
    <td><%=btime%>
	  </td>
    <td>调查结束时间:</td>
    <td><%=etime%></td>
    </tr>
</table>
<table width="100%" border="0" class="f12">
  <tr>
    <td align="left">调查内容:</td>
  </tr>
 
</table>
<%

'sql="select * from j18_lookupsub where lookupid=8002 order by lookcode"
sql="select BillQuestionID,ModelSubid,ModelSubname,ModelNum  from webfind_BillQuestion  where TitleCode='"&TitleCode&"' order by ModelSubid"
set ds=server.CreateObject("adodb.recordset")
ds.open sql,cn
i=0%>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF" class="f12">
<%while not ds.eof
   i=i+1
%>
  <tr>
    <td height="28" bgcolor="#FFF7F7">
	<input name="qid<%=i%>" type="hidden" id="qid<%=i%>" value="<%=ds("ModelSubid")%>">
    <%=ds("ModelSubname")%>    <input name="chktype<%=i%>" type="hidden" id="chktype<%=i%>" value="<%=ds("ModelSubname")%>">
	<input name="qname<%=i%>" type="hidden" id="qname<%=i%>" value="<%=ds("ModelSubname")%>">
	 <input name="qnum<%=i%>" type="hidden" id="qnum<%=i%>" value="<%=ds("ModelNum")%>">
	  </td>
  </tr>
  <tr>
    <td height="40">
	<%

' set ds1=server.CreateObject("ADODB.Recordset")
'ds1.ActiveConnection = cn
 ' sql2="select * from j18_lookupsubsub where lookupid='"&ds("lookupid")&"' and lookname="&qts(ds("lookname"))&" order by lookcode"
 ' ds1.open sql2 %>
	<table  border="0" cellpadding="0" cellspacing="0" class="f12">
  <tr>
  <td>
  <table class="f12">
    <tr>
<%
 set ds1=server.CreateObject("ADODB.Recordset")
ds1.ActiveConnection = cn
  'sql2="select * from j18_lookupsubsub where lookupid='"&ds("lookupid")&"' and lookname="&qts(ds("lookname"))&" order by lookcode"
  sql2="select BillAnswerID, BillQuestionID,AnswerNo, AnswerName, AnswerScore, AnswerNum  from webfind_BillAnswer  where BillQuestionID="&ds("BillQuestionID")&" order by  AnswerNo"
  ds1.open sql2
  while not ds1.eof
	AnswerNo=ds1("AnswerNo")
	%>
    <td height="24" align="left">
		<table class="f12">
		<tr>
		<td height="24" align="left">
      <label for="aid<%=i%>.<%=AnswerNo%>">
		  <input type="radio" id="aid<%=i%>.<%=AnswerNo%>" name="aid<%=i%>" checked  value="<%=ds1("AnswerName")%>☆<%=ds1("AnswerNo")%>☆<%=ds1("AnswerScore")%>" >
			<%=AnswerNo%>.<%=ds1("AnswerName")%>
      </label>
		  &nbsp;
		  <input name="qsname<%=i%>" type="hidden" id="qsname<%=i%>" value="<%=ds("ModelSubname")%>">
		  <input name="qsid<%=i%>" type="hidden" id="qsid<%=i%>" value="<%=ds("ModelSubid")%>">
		  <input name="ano<%=i%>" type="hidden" id="ano<%=i%>" value="<%=ds1("AnswerNo")%>">
		   <input name="ascore<%=i%>" type="hidden" id="ascore<%=i%>" value="<%=ds1("AnswerScore")%>">
		   
		  </td>
		  </tr>
		  </table>
	  </td>
	<%ds1.movenext
	wend
	ds1.close
	set ds1=nothing
	%>
	  </tr>
  </table>
	  </td>
  </tr>
  <tr>
  	<td>
	
	
	</td>
  </tr>
</table>
</td>
  </tr>

<%ds.movenext

wend
ds.close

set ds=nothing%>
</table>

<input name="count" type="hidden" id="count" value="<%=i%>">
<table class="f12">
	<tr>
	<td>
	<a href="#"  onClick="showDiv(1)" id="ShowDivLink">我要回复</a>
	<div id="input_1" style="display:none;">
	回复内容:<br>
	<textarea rows=5 cols="40"  id="ReplyText" name="ReplyText"></textarea>
	</div>
	<td>
	</tr>
  </table>
	<table>
	<tr>
	<td>
	<a href="#"  onClick="showDiv(2)" id="ShowDivLink">我有建议</a>
	<div id="input_2" style="display:none;">
	建议内容:<br>
	<textarea rows=5 cols="40"  id="AdvanText" name="AdvanText"></textarea>
	</div>
	<td>
	</tr>
	</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF" class="f12">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="完成调查">
      </td>
  </tr>
</table>
</form>
</body>
</html>
