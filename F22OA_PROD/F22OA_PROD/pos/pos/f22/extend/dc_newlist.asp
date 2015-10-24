<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>款式调查列表</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<!--#include file="inc/function.asp"-->


<script language="javascript">

  function clothingid(id){
	showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:350px;center: yes;help:no;resizable:yes;status:no');
  }
  function styleid(id){
	showModalDialog('style.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:350px;center: yes;help:no;resizable:yes;status:no');
  }

</script>
</head>

<body style="font-size:12px ">
<%dim depotid
deoptid=trim(session("dm").System_depotid)%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk" style="font-size:12px ">
  <tr>
    <td height="21"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 款式调查</td>
  </tr>
</table>
<table width="100"  border="0">
  <tr>
    <td></td>
  </tr>
</table>
<table width="100%"  border="0" class="bk">
  <tr>
    <td align="center">未完成调查的产品</td>
  </tr>
</table>
<table width="100%"  border="1" cellspacing="0" bordercolor="#FFEFEF" bordercolorlight="#EED9D6" class="bk" bordercolordark="#FFFFFF">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

<%
'set ds=server.CreateObject("ADODB.Recordset")
'ds.Activeconnection = cn

	'sql="Select A.MN_ID,convert(varchar(10),A.MN_FindDateBegin,120) as "& _
	'" MN_FindDateBegin,convert(varchar(10), A.MN_FindDateEnd, 120) as MN_FindDateEnd ,"& _
	 '   " A.MN_FindSoure,A.MN_SureState"& _
     '   " from dbo.Webfind_Main A"& _
     '   " inner join dbo.Webfind_Shop B"& _
     '   " ON A.MN_ID=B.SP_Billid"& _
       ' " where "& _
      '  " (convert(varchar(10), getdate(), 120)  >= "& _
      '  " convert(varchar(10), MN_FindDateBegin, 120)"& _
      ' " and"& _
      '  " convert(varchar(10), getdate(), 120)<="& _
      ' " convert(varchar(10),  MN_FindDateEnd, 120)) "& _
    ' " and B.SP_ShopID="&qts(depotid)& "order by MN_CreatDate desc "
	
'ds.source=sql
'ds.open
'while not ds.eof%>
 <tr>
    <td width="19%"></td>
    <td  align="center" colspan="4"></td>
  </tr>
		  <%set ds2=server.CreateObject("ADODB.Recordset")
				ds2.Activeconnection = cn
				' sql2="select A.SY_ID, A.SY_Billid, A.SY_StyleNo, B.s_name,B.st_month, "& _
					'	" B.st_xb  "& _
					'	" from dbo.Webfind_Style A "& _
					'  " inner join dbo.J_style B  "& _
					'	" ON A.SY_StyleNo=B.styleid  "& _
					 ' " where A.SY_State=0 and A.SY_Billid="&ds("MN_ID")
					   'sql2="select WN_styleid , B.s_name,B.st_month, B.st_xb "& _  
 	 '" from WebNew_Style A "& _
  	 '"inner join"& _
  	 '" dbo.J_style B "& _
  	 ''" ON A.WN_styleid=B.styleid "& _ 
  	' " where A.WN_chkstate=0 "& _
  	'" AND WN_ovsure=0 AND WN_depotid ='"&qts(depotid)&"' order by WN_crdate desc "'00005001
	  sql2="select WN_ID, WN_styleid , B.s_name,B.st_month, B.st_xb "& _  
 	 " from WebNew_StyleS A "& _
  	 "inner join"& _
  	 " dbo.J_style B "& _
  	 " ON A.WN_styleid=B.styleid "& _ 
  	 " where isnull(A.WN_chkstate,0)=0 "& _
  	" AND isnull(WN_ovsure,0)=0 AND WN_depotid ='"&session("dm").System_Depotid&"' order by WN_crdate desc "

				ds2.source=sql2
		ds2.open
		while not ds2.eof%>
  <tr>
      <td  colspan="5">
	  <table  width="100%">
	  		<tr>
				<td width="19%"><a href="javascript:styleid('<%=ds2("WN_styleid")%>');"><%=ds2("WN_styleid")%></a></td>
				<td width="22%"><%=ds2("s_name")%></td>
				<td width="20%"><%=ds2("st_month")%></td>
				<td width="21%"><%=ds2("st_xb")%></td>
				<td width="18%"><a href="dc_new.asp?id=<%=ds2("WN_ID")%>">填写调查</a></td>
			  </tr>
	  </table>
	  </td>
  </tr>
 <%ds2.movenext
wend
ds2.close
set ds2=nothing%>

<%
'ds.movenext
'wend
'ds.close
'set ds=nothing%>
</table>
</body>
</html>
