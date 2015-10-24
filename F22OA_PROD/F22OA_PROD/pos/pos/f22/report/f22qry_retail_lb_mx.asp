<!--#include file="inc/function.asp" -->
<%styleid=request.QueryString("styleid")
fdate=request.querystring("fdate")
ldate=request.querystring("ldate")
'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=styleid%>的销售明细</title>
</head>
<body oncontextmenu="event.returnValue=false">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr bgcolor="#006633"> 
    <td><font color="#FFFF00" size="4">: : <%=styleid%>的销售明细 : :</font></td>
  </tr>
  <tr> 
    <td rowspan="4" valign="top"> <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
        <tr> 
          <td width="16%"><img src="img/cs.jpg" width="101" height="43"></td>
          <%set rs1=server.createobject("adodb.recordset")
		    sql=" select b.sizeid from d_retail a,d_retailsub b,j_size c "&_
			    " where a.depotid='"&session("dm").System_Depotid&"' and b.styleid='"&styleid&"' and a.retailid=b.retailid and a.sure>0 "&_
				" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' and b.sizeid=c.sizeid "&qrydaytj&_
				" group by b.sizeid order by max(c.s_order)"
			rs1.open sql,cn,1,1
			sizenum=rs1.recordcount
			while not rs1.eof%>
          <td><div align="center"><font size="2"><%=rs1("sizeid")%></font></div></td>
          <%sizes=sizes&rs1("sizeid")&"|"
		    rs1.movenext
		    wend
			rs1.close
			set rs1=nothing
			sizes=left(sizes,len(sizes)-1)
			sizez=split(sizes,"|")%>
        </tr>
        <%set rs=server.createobject("adodb.recordset")
		  sql=" select b.colorid,max(c.c_name) as c_name from d_retail a,d_retailsub b,j_color c "&_
		      " where b.colorid=c.colorid and a.depotid='"&session("dm").System_Depotid&"' and b.styleid='"&styleid&"' "&qrydaytj&_
			  " and a.retailid=b.retailid and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' and a.sure>0 "&_
			  " group by b.colorid"
		  rs.open sql,cn
		  while not rs.eof%>
        <tr> 
          <td><div align="center"><font size="2"> 
              <%response.write(rs("colorid")&"("&rs("c_name")&")")%>
              </font></div></td>
          <%set rs1=server.createobject("adodb.recordset")
		    sql=" select b.sizeid,sum(isnull(b.nums,0)) as nums from d_retail a,d_retailsub b,j_size c "&_
			    " where a.depotid='"&session("dm").System_Depotid&"' and a.retailid=b.retailid and b.styleid='"&styleid&"' "&_
				" and convert(char(10),a.sure_date,126) between '"&fdate&"' and '"&ldate&"' and b.colorid='"&rs("colorid")&"' "&_
				" and b.sizeid=c.sizeid and a.sure>0 "&qrydaytj&" group by b.sizeid order by max(c.s_order)"
			rs1.open sql,cn
			k=0
			while not rs1.eof
			    found=false
			    while not found
			    if rs1("sizeid")=sizez(k) then
			       if not rs1("nums")=0 then response.write("<td><div align=center><font size=2>"&rs1("nums")&"</font></div></td>") else response.write("<td>&nbsp;</td>") end if
				   found=true
				else 
				   response.write("<td>&nbsp;</td>")
				end if
				k=k+1
				wend
			rs1.movenext
		    wend
			if k<sizenum then
			   for j=k+1 to sizenum
			       response.write("<td>&nbsp;</td>")
			   next
		    end if%>
        </tr>
        <%rs.movenext
		 wend
		rs.close
		set rs=nothing%>
      </table></td>
  </tr>
</table>
<br><br>
<center><input type="button" name="Submit" value=": 关 闭 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onclick="javascript:window.opener=null;window.close();"></center>
</body>
</html>
<%cn.close
  set cn=nothing%>
