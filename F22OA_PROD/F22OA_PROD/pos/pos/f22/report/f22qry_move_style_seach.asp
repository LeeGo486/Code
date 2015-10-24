<%Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if

f_date=trim(request.QueryString("f_date"))
if f_date="" then
   f_date=get_date(date)
end if
l_date=trim(request.QueryString("l_date"))
if l_date="" then
   l_date=get_date(date)
end if%>
<%
	get_depotid=request("get_depotid")
	getdptname=request("edptname")
	dtype=request("dtype")
	if dtype="" then dtype=0
%>
<!--#include file="inc/function.asp" -->
<%if cint(typ)<>2 then%>
<html>
<head>
<%end if%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%if cint(typ)<>2 then%>
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../inc/abc.js"></script>
<script language="javascript" src="ShowProcessBar.js"></script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function selectMD(str,opt){
  var m=showModalDialog('../SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
  var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
  if(opt==0){
	try{
	arr=m.split(",");
	get_depotid=arr[0];//仓库ID
	edptname=arr[1];//仓库名
	document.form1.set_depotid.value=get_depotid;
	document.form1.sdptname.value=edptname;
	}catch(ex){}
  }else
   if(opt==1){
	try{
	arr=m.split(",");
	get_depotid=arr[0];//仓库ID
	edptname=arr[1];//仓库名
	document.form1.get_depotid.value=get_depotid;
	document.form1.edptname.value=edptname;
	}catch(ex){}
  }
}

function op(url){
showModalDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
</script>
<style media="print">.noprint { display: none }</style>
</head>
<%response.cookies("seachdepot")("z1")=request("poscode")
  response.cookies("seachdepot")("z2")=request("styleact")%>
<body style="cursor:url('img/pen_i.cur')">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>数据传送中，请稍候……</td></tr>
</table></td></tr></table></div>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">当前位置：--&gt; 调拨查询 --&gt; 调拨查询-按款</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>

<table width="100%" class="noprint">
  <tr>
    <td height="40"> 
      <table width="100%" height="76" border="0" cellspacing="0">
        <form name="form1" method="get" action="f22qry_move_style_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td>开始日期： 
              <input name="f_date" type="text" id="f_date" size="10" class="box" value="<%=f_date%>" readonly onFocus="setday(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              &nbsp;&nbsp;结束日期： 
              <input name="l_date" type="text" id="l_date" size="10" class="box" value="<%=l_date%>" readonly onFocus="setday(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              &nbsp;&nbsp;
              <label for="dtype1"><input type="radio" id="dtype1" name="dtype" value="0" <%if cdbl(dtype)=0 then%>checked<%end if%>> 全部</label>
              <label for="dtype2"><input type="radio" id="dtype2" name="dtype" value="1" <%if cdbl(dtype)=1 then%>checked<%end if%>> 调拨发出</label>
              <label for="dtype3"><input type="radio" id="dtype3" name="dtype" value="2" <%if cdbl(dtype)=2 then%>checked<%end if%>> 调拨收回</label>
              
              </td>
            <td width="100"><input type="submit" name="Subm" value=": 确 定 :" class=box onClick="document.all.form1.typ.value=1;document.all.form1.submit();"></td>
			<td width="100"><input type="hidden" name="typ" value="1">
			<input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();"></td>
          </tr>
          <tr> 
            <td height="38" colspan="3">
            查询款式：
            <input type="text" name="style" id="style" class=box size=20>&nbsp;&nbsp;
			<label><input type="radio" name="styleact" value="a" <%if request.cookies("seachdepot")("z2")="a" or request.cookies("seachdepot")("z2")="" then response.write("checked") end if%>>正常（包含模糊查询）</label>
			  <label><input type="radio" name="styleact" value="b" <%if request.cookies("seachdepot")("z2")="b" then response.write("checked") end if%>>助记码</label>
			&nbsp;&nbsp;&nbsp;指定店铺 : <input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="15" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('move',1);">
          <input name="edptname" type="text" id="edptname" style="border:none;" value="<%=getdptname%>" size="16" readonly>
		  </font>	  
          </td>
          </tr>
        </form>
      </table>
</td></tr></table>
<%else%>
<center><h2>调拨查询-按款</h2></center>
<%end if%>
<%if f_date="" or l_date="" then%>
<table width="100%" height="102" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
    <td><div align="center">请 选 择 <%if seach_selectdepot=1 then response.write("店 柜 和 ") end if%>日 期 段、所 查 询 款 式（不录入款式，默认全部款式）</div></td>
  </tr>
</table>
<%else
  style=request("style")
  depotid=session("dm").System_Depotid
  styleact=request.querystring("styleact")
  get_depotid=trim(request.QueryString("get_depotid"))
  if styleact="b" then
     style=getstyle(style)
     str2=" and b.styleid='"&style&"' "
  else
     if style<>"" then str2="and b.styleid like '%"&style&"%'" else str2="" end if
  end if
  if get_depotid<>"" then
     str3=" and a.get_depotid='"&get_depotid&"'"
	 str4=" and a.set_depotid='"&get_depotid&"'"
  else
     str3=""
	 str4=""
  end if

  sss="select '调拨发出' as dtype,max(convert(char(10),a.setsure_date,126)) as suredate,a.moveid as djid,max(a.get_depotid) as depotid,"&_
			"max(c.d_name) as dptname,b.clothingid,max(d.s_name) as s_name,sum(b.set_nums) as nums into #tempstyle "&_
			"from d_move a,d_movesub b,j_depot c,j_style d where a.moveid=b.moveid and a.get_depotid=c.depotid and a.set_depotid='"&depotid&"' "&_
			"and b.styleid=d.styleid and convert(char(10),a.setsure_date,126) between '"&f_date&"' and '"&l_date&"' "&_
			"and isnull(a.set_sure,0)>0 "&str2&str3&" group by a.moveid,b.clothingid order by a.moveid,b.clothingid"
  mmm="insert into #tempstyle "&_
			"select '调拨收回',max(convert(char(10),a.getsure_date,126)),a.moveid,max(a.set_depotid),"&_
			"max(c.d_name),b.clothingid,max(d.s_name),sum(b.set_nums)"&_
			"from d_move a,d_movesub b,j_depot c,j_style d where a.moveid=b.moveid and a.set_depotid=c.depotid and a.get_depotid='"&depotid&"' "&_
			"and b.styleid=d.styleid and convert(char(10),a.getsure_date,126) between '"&f_date&"' and '"&l_date&"' "&_
			"and isnull(a.get_sure,0)>0 "&str2&str3&" group by a.moveid,b.clothingid order by a.moveid,b.clothingid"
			
	dstr=""
	if cdbl(dtype)=1 then dstr=" where dtype='调拨发出'"
	if cdbl(dtype)=2 then dstr=" where dtype='调拨收回'"
  nnn="select suredate,dtype,djid,depotid,dptname,clothingid,s_name,nums from #tempstyle "&dstr&" order by suredate,djid"
	
	%>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="25%"><div align="left"><font size="2">从<font color="#FF0000"><%=f_date%></font>至
    <font color="#FF0000"><%=l_date%></font></font></div></td>
  </tr>
</table> 
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td><div align="center"><font color="#FFFF00" size="2">单据日期</font></div></td>
	<td><div align="center"><font color="#FFFF00" size="2">单据类型</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">单据编号</font></div></td>
	<td><div align="center"><font color="#FFFF00" size="2">收发店铺编号</font></div></td>
    <td><div align=center><font color='#FFFF00' size='2'>收发店铺名称</font></div></td>
	<td><div align=center><font color='#FFFF00' size='2'>款号</font></div></td>
	<td><div align=center><font color='#FFFF00' size='2'>款式名称</font></div></td>
    <td><div align="center"><font color="#FFFF00" size="2">数 量</font></div></td>
  </tr>
  <%
	on error resume next
  cn.execute "drop table #tempstyle"
  'response.Write sss
  'response.End
	cn.execute sss
	cn.execute mmm
  set rs=server.createobject("adodb.recordset")
  rs.open nnn,cn,1,1
  while not rs.eof%>
  <tr bgcolor="#E8FDFF" height="20"> 
    <td><div align="center"><font size="2"><%=rs("suredate")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("dtype")%></font></div></td>
    <td><div align="center"><font size="2"><%=rs("djid")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("depotid")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("dptname")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("clothingid")%></font></div></td>
	<td><div align="center"><font size="2"><%=rs("s_name")%></font></div></td>
    <td height="20"><div align="center"><font size="2"><%response.write(rs("nums"))
										 zz_nums=zz_nums+cdbl(rs("nums"))%></font></div></td>
 </tr>
  <%rs.movenext 
  wend%>
  <tr bgcolor="#FFFF00"> 
    <td height="20" colspan="7"><div align="center"><font size="2">合&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td height="20"><div align="center"><font size="2"><%=zz_nums%></font></div></td>
  </tr>
</table>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing
end if

'取助记码
function getstyle(styleid)
if styleid<>"" then
  set rs10=server.createobject("adodb.recordset")
  rs10.open "select styleid from j_style where styleid='"&styleid&"' or helpid='"&styleid&"'",cn
  if not rs10.eof then getstyle=rs10(0) else getstyle="null" end if
  rs10.close
  set rs10=nothing
else
  getstyle="null"
end if
end function%>
<%if cint(typ)<>2 then%>
</body>
</html>
<%end if%>
