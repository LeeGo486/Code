<!--#include file="../inc/function.asp"-->
<!-- #include file="style_input.asp" -->
<%checked=0%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="link.css" rel="stylesheet" type="text/css">
<title><%=styleid%>的明细</title>
<base target="abcdefg">
</head>
<body onload="document.form1.cs_num1.focus()" style="cursor:url('img/pen_i.cur')" oncontextmenu="event.returnValue=false">
<iframe style="display:none; " name="abcdefg" id="abcdefg"></iframe>
<!-- #include file="fashionzl_rl.asp" -->
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr> 
    <td rowspan="4" valign="top">
	<%'session("indentdh_tq_color1")=colorgrp
	  'session("indentdh_tq_size1")=sizegrp
	  x=0
	  k=0%> <form method="get" name="form1" id="form1" target="abcdefg" action="buy_cl_tq_mx.asp">
	     <input type="hidden" name="color_num" value="<%=ubound(colorgrp)%>">
		 <input type="hidden" name="size_num" value="<%=ubound(sizegrp)%>">
		 <input type="hidden" name="styleid" value="<%=styleid%>">
		 <input type="hidden" name="indentid" value="<%=id%>">
		 <input type="hidden" name="colorid" value="<%=colorid%>">
		 <input type="hidden" name="sizeid" value="<%=sizeid%>">
        <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
          <tr> 
            <td width="16%"><img src="img/cs.jpg" width="101" height="43"></td>
            <%for i=0 to ubound(sizegrp)%>
            <td><div align="center"><font size="2"><%=sizegrp(i)%></font></div></td>
            <%next%>
          </tr>
          <%for j=0 to ubound(colorgrp)%>
          <tr> 
            <td><div align="center"><font size="2"> 
                <%set rs1=server.CreateObject("adodb.recordset")
		                                           rs1.open "select c_name from j_color where colorid='"&trim(colorgrp(j))&"'",cn,1,1
												   response.write(colorgrp(j)&"("&rs1("c_name")&")")
												   rs1.close
												   set rs1=nothing%>
                </font></div></td>
            <%for i=0 to ubound(sizegrp)
			   k=k+1%>
            <td><div align="center"><font size="2">
			    <%if not checked then%>
                <input name="cs_num<%=k%>" type=text class=editbox1 value="<%if cint(num1(x))<>0 then response.write(cint(num1(x))) end if%>" size="1" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);">
                <%elseif cint(num1(x))<>0 then response.Write(cint(num1(x))) else response.Write("&nbsp;") end if%>
				</font></div></td>
            <%x=x+1
		  next%>
          </tr>
          <%next%>
        </table>
        <br>
        <div align="center"><%if not checked then%> 
          <input type="submit" name="Subm" value=": 修改此款 :" class=box>
          &nbsp;&nbsp;&nbsp;<%end if%> 
          <input type="button" name="Submit" value=": 取 消 :" class=box onclick="javascript:window.opener=null;window.close();">
        </div>
      </form></td>
  </tr>
</table>
</body>
</html>
<%cn.close
  set cn=nothing%>