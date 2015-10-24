<!--#include file="inc/function.asp" -->
<%styleid=request.QueryString("styleid")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=styleid%>的库存明细</title>
</head>
<body>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr bgcolor="#006633"> 
    <td><font color="#FFFF00" size="4">: : <%=styleid%>的库存明细 : :</font></td>
  </tr>
  <tr> 
    <td rowspan="4" valign="top"> <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
        <tr> 
          <td width="16%"><img src="img/cs.jpg" width="101" height="43"></td>
          <%set rs1=server.createobject("adodb.recordset")
			rs1.open "select a.sizeid from j_stock a,j_size b where a.depotid='"&session("dm").System_Depotid&"' and a.styleid='"&styleid&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)",cn,1,1
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
		  rs.open "select a.colorid,max(b.c_name) as c_name from j_stock a,j_color b where a.colorid=b.colorid and a.depotid='"&session("dm").System_Depotid&"' and a.styleid='"&styleid&"' group by a.colorid",cn
		  while not rs.eof%>
        <tr> 
          <td><div align="center"><font size="2"> 
              <%response.write(rs("colorid")&"("&rs("c_name")&")")%>
              </font></div></td>
          <%set rs1=server.createobject("adodb.recordset")
			rs1.open "select a.sizeid,sum(isnull(a.k_num,0)) as k_num from j_stock a,j_size b where a.depotid='"&session("dm").System_Depotid&"' and a.styleid='"&styleid&"' and a.colorid='"&rs("colorid")&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)",cn
			k=0
			while not rs1.eof
			    found=false
			    while not found
			    if trim(rs1("sizeid"))=trim(sizez(k)) then
			       if not rs1("k_num")=0 then response.write("<td><div align=center><font size=2>"&rs1("k_num")&"</font></div></td>") else response.write("<td>&nbsp;</td>") end if
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
