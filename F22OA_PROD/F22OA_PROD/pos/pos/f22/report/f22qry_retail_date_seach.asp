<%Dim act
  set rs=server.createobject("adodb.recordset")
act=request.QueryString("act")
if cint(act)=2 then
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
<!--#include file="inc/function.asp" -->
<%if cint(act)<>2 then%>
<html>
<head>
<%end if%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%if cint(act)<>2 then%>
<title>数据查询</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="ShowProcessBar.js"></script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<script language="javascript">
function op(url){
//window.open(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
    showModalDialog(url,'example05','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
}
function goUrl(date){
     var val=document.getElementById("brid").value;
     if(val==""){
        val=0;
     }
     var path="f22qry_retail_date_seach_mx.asp?par="+val+"|"+date;
     op(path);
}
</script>
<style media="print">.noprint { display: none }</style>
</head>
<body>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<div id="submitok"  style="visibility:hidden;position: absolute; width: 320; height: 100"> 
<table width="320" border="1" align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" ID="Table1">
<tr><td width=100% valign=top>
<table width="320" border="0" height=100 align="center" cellspacing="0" cellpadding="3"  bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor=Honeydew ID="Table2">
<tr><td align=center valign=middle>数据传送中，请稍候……</td></tr>
</table></td></tr></table></div>
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td><font size="2">当前位置：--&gt; 报表查询 --&gt; 销售查询-按日期</font></td>
  </tr>
  <tr><td><hr size="2"></td></tr>
</table>
<table width="100%" class="noprint">
  <tr><td>
  <table width="100%" height="32" border="0" cellspacing="0">
        <form name="form1" method="get" action="f22qry_retail_date_seach.asp" onSubmit="this.Subm.disabled=true">
          <tr> 
            <td><font size="2">
            品　牌：
            <select name="brandid" id="brid">
                <option value=""></option>
            	<%rs.open "select drandid,drname from j_brand order by drandid",cn,1,1
				do while not rs.eof
					response.write "<option value="""&rs("drandid")&""" "
					if request("brandid")=rs("drandid") then response.write " selected=selected"
					response.write ">"&rs("drname")&"</option>"
				rs.movenext
				loop
				rs.close
				%>
            </select></font> </td>
            <td><font size="2">开始日期： 
              <input name="f_date" type="text" id="f_date" size="10" class="box" value="<%=f_date%>" onFocus="setday(this);" readonly onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">结束日期： 
              <input name="l_date" type="text" id="l_date" size="10" class="box" value="<%=l_date%>" onFocus="setday(this);" readonly onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
              </font></td>
            <td><font size="2">排　序：<select name="order" size=1><option value=0>按日期排序</option><option value=1>按数量排序</option><option value=2>按金额排序</option></select></font> </td>
            <td><input type="submit" name="Subm" value=": 确 定 :" class=box onClick="document.all.form1.act.value=1;document.all.form1.submit();"></td>
			<td><input type="hidden" name="act" value="1">
			<input type="button" name="but" value="导出Excel" onClick="document.all.form1.act.value=2;document.all.form1.submit();"></td>
          </tr>
        </form>
      </table>
</td></tr></table>
<%end if%>
<%if f_date="" or l_date="" then%>
<table class="noprint" width="100%" height="102" border="1" cellspacing="0" bordercolorlight="#FFFFFF" bordercolordark="#006633">
  <tr>
    <td><div align="center">请 选 择 条 件</div></td>
  </tr>
</table>
<%else%>
<hr size="1">
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <td width="25%"><div align="left"><font size="2">从<font color="#FF0000"><%=f_date%></font>至<font color="#FF0000"><%=l_date%></font></font></div></td>
  </tr>
</table> 
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
  <tr bgcolor="#336699"> 
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">销售日期</font></div></td>
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">销售总数量</font></div></td>
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">销售总金额</font></div></td>
	<td width="15%"><div align="center"><font color="#FFFF00" size="2">赠送数量</font></div></td>
    <td width="15%"><div align="center"><font color="#FFFF00" size="2">退货数量</font></div></td>
	<td width="15%"><div align="center"><font color="#FFFF00" size="2">退货金额</font></div></td>
  </tr>
  <%order=request("order")
  select case order
  case 0 orderby=" order by suredate desc"
  case 1 orderby=" order by sum(nums) desc"
  case 2 orderby=" order by sum(s_sums) desc"
  end select
  
  '控制查询天数
  if session("QryDay")>0 then
     qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
  end if
  
  if request("brandid")<>"" then
  	brandtj =" inner join j_style c on b.styleid=c.styleid and c.brandid="&qts(request("brandid"))
  else
  	brandtj =""
  end if
  
  sql1="select convert(char(10),a.sure_date,120) as suredate,sum(b.nums) as nums,sum(b.nums*b.s_price) as s_sums,"&_
       "sum(case when isnull(b.larg,0)=1 then b.nums else 0 end) as znums,sum(case when isnull(b.back,0)=1 then b.nums else 0 end) as tnums,"&_
	   "sum(case when isnull(b.back,0)=1 then b.nums*b.s_price else 0 end) as tsums "&_
       "from d_retail a,d_retailsub b "&brandtj&" where a.retailid=b.retailid "&_
	   "and a.depotid='"&session("dm").System_Depotid&"' and isnull(a.sure,0)>0 "&_
	   "and convert(char(10),a.sure_date,120) between '"&f_date&"' and '"&l_date&"' "&qrydaytj&_
	   " group by convert(char(10),a.sure_date,120) "&orderby
  rs.open sql1,cn,1,1
  if not rs.eof then
	while not rs.eof 
    if not rs.eof then%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20">
    <%if cint(act)=2 then%>
		<%=rs("suredate")%>
	<%else%>
        <div align="center"><font size="2">
        <!--<a href="javascript:op('f22qry_retail_date_seach_mx.asp?suredate=<%=rs("suredate")%>');" title="点击看明细"><%=rs("suredate")%></a></font>-->
        <a href="javascript:goUrl('<%=rs("suredate")%>');" title="点击看明细"><%=rs("suredate")%></a></font>
        </div>
	<%end if%>
    </td>
    <td height="20"><div align="center"><font size="2"><%response.write(rs("nums"))
	                                                     nums=nums+cdbl(rs("nums"))%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs("s_sums"))
	                                                            s_sums=s_sums+cdbl(rs("s_sums"))%></font></div></td>
	<td height="20"><div align="center"><font size="2"><%response.write(rs("znums"))
	                                                     znums=znums+cdbl(rs("znums"))%></font></div></td>
	<td><div align="center"><font size="2" color="#FF0000"><%response.write(rs("tnums"))
	                                                            tnums=tnums+cdbl(rs("tnums"))%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%response.write(rs("tsums"))
	                                                            tsums=tsums+cdbl(rs("tsums"))%></font></div></td>	
																													
  </tr>
  <%rs.movenext 
    end if
    wend%>
  <tr bgcolor="#E8FDFF"> 
    <td height="20"><div align="center"><font size="2">合&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp; 计</font></div></td>
    <td height="20"><div align="center"><font size="2" color="#FF0000"><%=nums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%=s_sums%></font></div></td>
	<td height="20"><div align="center"><font size="2" color="#FF0000"><%=znums%></font></div></td>
	<td height="20"><div align="center"><font size="2" color="#FF0000"><%=tnums%></font></div></td>
    <td><div align="center"><font size="2" color="#FF0000">￥ <%=tsums%></font></div></td>
  </tr>
</table>
<%else%>
<tr>
  <td colspan="8"><div align="center"><font size="2">没 有 销 售 数 据</font></div></td>
</tr>
<%end if%>
<%rs.close
  set rs=nothing
  cn.close
  set cn=nothing
end if%>
<%if cint(act)<>2 then%>
</body>
</html>
<%end if%>

