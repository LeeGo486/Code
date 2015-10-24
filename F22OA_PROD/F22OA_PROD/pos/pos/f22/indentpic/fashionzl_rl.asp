<%set rs=server.createobject("adodb.recordset")
  rs.open "select * from j_style where styleid='"&request.querystring("styleid")&"'",cn,1,1%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title><%=rs("styleid")%>的详细资料</title>
<link href="link.css" rel="stylesheet" type="text/css">
<script runat="server" language="VBScript">
function ubb(fstring)
          ubb=chkstring(formatstr(fstring))
end function

function formatstr(fstring)
          on error resume next
		  fstring=replace(fstring,"<","<")
		  fstring=replace(fstring,">",">")
		  fstring=replace(fstring,chr(13),"")
		  fstring=replace(fstring,chr(10)&chr(10),"</p><p>")
		  fstring=replace(fstring,chr(10),"<br>")
		  fstring=replace(fstring,chr(32),"&nbsp")
		  formatstr=fstring
end function

function docode(fstring,fotag,fctag,frotag,frctag)
          fotagpos=instr(1,fstring,fotag,1)
		  fctagpos=instr(1,fstring,fctag,1)
		  if (fctagpos>0 and fotagpos>0) then
		      fstring=replace(fstring,fotag,frotag)
			  fstring=replace(fstring,fctag,frctag)
		  end if
		  docode=fstring
end function

function addlink(fstring)
          fotag="<a>"
		  fctag="</a>"
		  fotagpos=instr(1,fstring,fotag,1)
		  fctagpos=instr(1,fstring,fctag,1)
		  while (fctagpos>0 and fotagpos>0)
		         strlink=mid(fstring,fotagpos+3,fctagpos-fotagpos-3)
				 if instr(1,strlink,fotag,1) or instr(1,strlink,fctag,1) then
				     addlink=fstring
					 exit function
				 end if
		         strlink="<a href="&chr(34)&strlink&chr(34)&" target="&chr(34)&"_blank"&chr(34)&">"
				 fstring=replace(fstring,fotag,strlink,1,1,1)
				 fotagpos=instr(fotagpos,fstring,fotag,1)
				 if fotagpos>0 then
				    fctagpos=instr(fotagpos,fstring,fctag,1)
                                 end if
		  wend
		  addlink=fstring
end function

function chkstring(fstring)
          fstring=trim(fstring)
		  if fstring="" then
		     fstring=" "
			 exit function
		  end if
		  fstring=docode(fstring,"[b]","[/b]","<b>","</b>")
		  fstring=docode(fstring,"[u]","[/u]","<u>","</u>")
		  fstring=docode(fstring,"[i]","[/i]","<i>","</i>")
		  fstring=docode(fstring,"[red]","[/red]","<font color=red>","</font id=red>")
		  fstring=docode(fstring,"[green]","[/green]","<font color=green>","</font id=green>")
		  fstring=docode(fstring,"[blue]","[/blue]","<font color=blue>","</font id=blue>")
		  fstring=docode(fstring,"[white]","[/white]","<font color=white>","</font id=white>")
		  fstring=docode(fstring,"[purple]","[/purple]","<font color=purple>","</font id=purple>")
		  fstring=docode(fstring,"[yellow]","[/yellow]","<font color=yellow>","</font id=yellow>")
		  fstring=docode(fstring,"[violet]","[/violet]","<font color=violet>","</font id=violet>")
		  fstring=docode(fstring,"[brown]","[/brown]","<font color=brown>","</font id=brown>")
		  fstring=docode(fstring,"[black]","[/black]","<font color=black>","</font id=black>")
		  fstring=docode(fstring,"[pink]","[/pink]","<font color=pink>","</font id=pink>")
		  fstring=docode(fstring,"[orange]","[/orange]","<font color=orange>","</font id=orange>")
		  fstring=docode(fstring,"[gold]","[/gold]","<font color=gold>","</font id=gold>")
		  fstring=docode(fstring,"[h1]","[/h1]","<h1>","</h1>")
 		  fstring=docode(fstring,"[h2]","[/h2]","<h2>","</h2>")
		  fstring=docode(fstring,"[h3]","[/h3]","<h3>","</h3>")
		  fstring=docode(fstring,"[h4]","[/h4]","<h4>","</h4>")
		  fstring=docode(fstring,"[h5]","[/h5]","<h5>","</h5>")
		  fstring=docode(fstring,"[h6]","[/h6]","<h6>","</h6>")
		  fstring=docode(fstring,"[size=1]","[/size=1]","<font size=1>","</font id=size1>")
		  fstring=docode(fstring,"[size=2]","[/size=2]","<font size=2>","</font id=size2>")
		  fstring=docode(fstring,"[size=3]","[/size=3]","<font size=3>","</font id=size3>")
		  fstring=docode(fstring,"[size=4]","[/size=4]","<font size=4>","</font id=size4>")
		  fstring=docode(fstring,"[size=5]","[/size=5]","<font size=5>","</font id=size5>")
		  fstring=docode(fstring,"[size=6]","[/size=6]","<font size=6>","</font id=size6>")
		  fstring=docode(fstring,"[left]","[/left]","<div align=left>","</div id=left>")
		  fstring=docode(fstring,"[center]","[/center]","<center>","</center>")
		  fstring=docode(fstring,"[right]","[/right]","<div align=right>","</div id=right>")
		  fstring=docode(fstring,"[code]","[/code]","<pre id=code><font face=courier size=3 id=code>","</font id=code></pre id=code>")
		  fstring=docode(fstring,"[url]","[/url]","<a>","</a>")
		  fstring=addlink(fstring)
		  chkstring=fstring
end function		  
</script>
</head>

<body style="cursor:url('img/pen_i.cur')">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
  <tr bgcolor="#006633"> 
    <td colspan="7"><font color="#FFFF00" size="4">: : <%=rs("styleid")%>的详细资料 : :</font></td>
  </tr>
  <tr> 
    <td width="249" height="25"><div align="center"><font size="2">款&nbsp; 式&nbsp; 图&nbsp; 
        片</font></div></td>
    <td width="70"><div align="center"><font size="2">款式编号</font></div></td>
    <td width="128"><div align="center"><font color="#009933" size="2"><%=rs("styleid")%></font></div></td>
    <td width="69"><div align="center"><font size="2">款式品牌</font></div></td>
    <td width="88"><div align="center"><font color="#009933" size="2"> 
        <%set rs1=server.CreateObject("adodb.recordset")
	  rs1.open "select * from j_brand where drandid='"&rs("brandid")&"'",cn,1,1
	  if not rs1.eof then response.Write(rs1("drname")) end if
	  rs1.close
	  set rs1=nothing%>
        &nbsp;</font></div></td>
    <td width="65"><div align="center"><font size="2">款式年份</font></div></td>
    <td width="101"><div align="center"><font color="#009933" size="2"><%=rs("st_year")%>年</font></div></td>
  </tr>
  <tr> 
    <td rowspan="10"><div align="center"><font size="2">
	<img src=showimg.asp?styleid=<%=rs("styleid")%> onload="javascript:if(this.width>250){this.width=250;}if(this.height>350){this.height=350;}" onMousedown="alert('不允许下载！')"></font></div></td>
    <td><div align="center"><font size="2">款式名称</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("s_name")%>&nbsp;</font></div></td>
    <td><div align="center"><font size="2">款式季节</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_month")%>&nbsp;</font></div></td>
    <td><div align="center"><font size="2">款式性别</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_xb")%>&nbsp;</font></div></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">款式科目</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_type")%>&nbsp;</font></div></td>
    <td><div align="center"><font size="2">款式布种</font></div></td>
    <td colspan="3"><div align="center"><font color="#009933" size="2"><%=rs("st_cloth")%>&nbsp;</font></div></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">款式种类</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_xl")%>&nbsp;</font></div></td>
    <td><div align="center"><font size="2">款式大类</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_dl")%>&nbsp;</font></div></td>
    <td><div align="center"><font size="2">款式小类</font></div></td>
    <td><div align="center"><font color="#009933" size="2"><%=rs("st_xz")%>&nbsp;</font></div></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">零售价</font></div></td>
    <td colspan="5"><font color="#FF0000" size="2">&nbsp;￥ <%=rs("x_price")%></font></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">款式颜色</font></div></td>
    <td colspan="5"><font color="#009933" size="2">&nbsp;
	<%set rs1=server.CreateObject("adodb.recordset")
	  rs1.open "select colorid from j_clothing where styleid='"&rs("styleid")&"' group by colorid",cn,1,1
	  while not rs1.eof
		 set rs2=server.CreateObject("adodb.recordset")
		 rs2.open "select c_name from j_color where colorid='"&rs1("colorid")&"'",cn 
		 f_color=f_color+rs1("colorid")+"("+trim(rs2("c_name"))+"),"
	     rs2.close
		 set rs2=nothing
	  rs1.movenext
	  wend
	  rs1.close
	  set rs1=nothing
	  response.Write(left(f_color,len(f_color)-1))%>
	</font></td>
  </tr>
  <tr> 
    <td><div align="center"><font size="2">款式尺码</font></div></td>
    <td colspan="5"><font color="#009933" size="2">&nbsp;
	<%set rs1=server.createobject("adodb.recordset")
	  rs1.open "select a.sizeid from j_clothing a,j_size b where a.styleid='"&rs("styleid")&"' and a.sizeid=b.sizeid group by a.sizeid order by max(b.s_order)",cn,1,1
	  while not rs1.eof
	      f_size=f_size+rs1("sizeid")+","
	  rs1.movenext
	  wend
	  rs1.close
	  set rs1=nothing
	  response.write(left(f_size,len(f_size)-1))%>
	</font></td>
  </tr>
  <tr> 
    <td colspan="6" valign="top"><font size="2">款式备注</font> <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006666">
        <tr> 
          <td><font color="#009933" size="2"><%=ubb(rs("comment"))%>&nbsp;</font></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
<%rs.close
  set rs=nothing%>