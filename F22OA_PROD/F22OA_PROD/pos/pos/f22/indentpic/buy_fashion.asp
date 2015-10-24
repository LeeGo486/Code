<!--#include file="../inc/function.asp"-->
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select 1 from d_indentsub where indentid='"&request.Cookies("pic_indentid")&"' and styleid='"&request.QueryString("styleid")&"'",cn
if not rs.eof then
   response.Write("<script language=javascript>alert('此款已列入单内！');window.close();</script>")
   response.end
end if
rs.close
set rs=nothing
styleid=request.QueryString("styleid")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=styleid%>的详细资料</title>
<link href="link.css" rel="stylesheet" type="text/css">
<base target="abcdefg">
</head>
<body style="cursor:url('img/pen_i.cur')" onload="document.form1.cs_num1.focus()">
<iframe style="display:none; " name="abcdefg" id="abcdefg"></iframe>
<!-- #include file="fashionzl_rl.asp" -->
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr> 
    <td rowspan="4" valign="top"> <%set rs1=server.CreateObject("adodb.recordset")
	  rs1.open "select colorid from j_clothing where styleid='"&styleid&"' group by colorid",cn,1,1
      while not rs1.eof
		 color1=color1+rs1("colorid")+","
	  rs1.movenext
	  wend
	  rs1.close
	  set rs1=nothing
	  color1=left(color1,len(color1)-1)
	  
	  set rs1=server.createobject("adodb.recordset")
	  rs1.open "select a.sizeid from j_clothing a,j_size b where a.styleid='"&styleid&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)",cn,1,1
	  while not rs1.eof
	      size1=size1+rs1("sizeid")+","
	  rs1.movenext
	  wend
	  rs1.close
	  set rs1=nothing
	  size1=left(size1,len(size1)-1)
	  
	  f_color=split(color1,",")
      f_size=split(size1,",")
	  'session("indentdh_f_color")=f_color
	  'session("indentdh_f_size")=f_size
	  %> 
	  <form method="get" name="form1" id="form1" target="abcdefg"  action="buy_cl.asp">
	  <input type="hidden" name="color_num" value="<%=ubound(f_color)%>">
	  <input type="hidden" name="size_num" value="<%=ubound(f_size)%>">
	  <input type="hidden" name="styleid" value="<%=styleid%>">
	  <input type="hidden" name="color1" value="<%=color1%>">
	  <input type="hidden" name="size1" value="<%=size1%>">
        <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
          <tr> 
            <td width="16%"><img src="img/cs.jpg" width="101" height="43"></td>
            <%for i=0 to ubound(f_size)%>
            <td><div align="center"><font size="2"><%=f_size(i)%></font></div></td>
            <%next%>
          </tr>
          <%for j=0 to ubound(f_color)%>
          <tr> 
            <td><div align="center"><font size="2"> 
                <%set rs1=server.CreateObject("adodb.recordset")
		                                           rs1.open "select c_name from j_color where colorid='"&trim(f_color(j))&"'",cn,1,1
												   response.write(f_color(j)&"("&rs1("c_name")&")")
												   rs1.close
												   set rs1=nothing%>
                </font></div></td>
            <%for i=0 to ubound(f_size)
		       k=k+1%>
            <td><div align="center"><font size="2"> 
                <input name="cs_num<%=k%>" type=text class=editbox1 size="1" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);">
                </font></div></td>
            <%next%>
          </tr>
          <%next%>
        </table>
        <br>
        <div align="center"> 
          <input type="submit" name="Subm" value=" 加  入 " class=box>
          &nbsp;&nbsp;&nbsp; 
          <input type="button" name="Submit" value=" 取  消 " class=box onclick="window.close();">
        </div>
      </form></td>
  </tr>
</table>
</body>
</html>
<%cn.close
set cn=nothing%>