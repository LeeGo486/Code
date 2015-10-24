<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查看款式</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {overflow:hidden;}
.bk {
	border: 1px solid;
}
#intra {
	line-height:20px;
}
</style>
</head>

<body>
<table width="90%" border="0">
  <tr valign="top">
    <td width="68%" height="278">  <%dim ds,id,sql,i
	id=trim(request.QueryString("id"))
	set ds=server.CreateObject("ADODB.Recordset")
	ds.Activeconnection=cn
	sql="select styleid from j_style where styleid="&qts(id)
	ds.source = sql
	ds.open
	if not ds.eof then
	  id=ds(0)
	else
	  ds.close
	  set ds=nothing
	  call close("没有找到这个款式!")
	  response.End()
	end if
	ds.close
	
	if id="" then
	  sql="select top 1 styleid,s_name,st_cloth,st_by1,isnull(dh_3,'') as dh_3,st_year,st_month,st_dl,st_xz,st_xb,x_price,comment from j_style"
	else
	  sql="select styleid,s_name,st_cloth,st_by1,isnull(dh_3,'') as dh_3,st_year,st_month,st_dl,st_xz,st_xb,x_price,comment from j_style where styleid = "&qts(id)
	end if
	ds.source = sql
    ds.open%>
  <table width="100%" border="1" cellpadding="0" bordercolor="#FFEFEF" class="f12">
    <tr>
      <td colspan="6"><table width="100%"  border="0" cellpadding="0" cellspacing="0" class="f12">
          <tr>
            <td width="14%">款式名称: </td>
            <td width="33%" class="ts"><%=ds("s_name")%></td>
            <td width="14%">款式编码:</td>
            <td width="39%" class="notice"><%=ds("styleid")%></td>
          </tr>
        </table></td>
      </tr>
    <tr>
      <td width="15%">款式年份:</td>
      <td width="21%"><%=ds("st_year")%></td>
      <td width="17%">款式季节:</td>
      <td width="14%"><%=ds("st_month")%></td>
    
    </tr>
    <tr>
      <td>款式大类:</td>
      <td><%=ds("st_dl")%></td>
      <td>款式小类:</td>
      <td><%=ds("st_xz")%></td>
     
    </tr>
    <tr>
      <td>原料:</td>
      <td class="notice"><%=ds("st_cloth")%></td>
      <td>款式性别:</td>
      <td><%=ds("st_xb")%></td>
     
    </tr>
	    <tr>
      <td>零售价:</td>
      <td class="notice"><%=ds("x_price")%></td>
      <td>计量单位:</td>
      <td><%=ds("st_by1")%></td>
    
    </tr>

  </table>
  <table width="100%" border="1" bordercolor="#ECE9D8" class="f14">
    <tr>
      <td>卖点说明</td>
    </tr>
  </table><textarea name="intra" cols="55" rows="11" id="intra"><%=ds("dh_3")%></textarea>
</td>
    <td width="32%" align="center"><img src="../show_photo_sub.asp?id=<%=qts(id)%>?action=style"  width="160" height="200"></td>
  </tr>
</table><%ds.close
set ds=nothing%>


</body>
</html>
