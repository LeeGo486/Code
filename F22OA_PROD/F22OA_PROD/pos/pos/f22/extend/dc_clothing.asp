<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�鿴��ʽ</title>
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
	  call close("û���ҵ������ʽ!")
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
            <td width="14%">��ʽ����: </td>
            <td width="33%" class="ts"><%=ds("s_name")%></td>
            <td width="14%">��ʽ����:</td>
            <td width="39%" class="notice"><%=ds("styleid")%></td>
          </tr>
        </table></td>
      </tr>
    <tr>
      <td width="15%">��ʽ���:</td>
      <td width="21%"><%=ds("st_year")%></td>
      <td width="17%">��ʽ����:</td>
      <td width="14%"><%=ds("st_month")%></td>
    
    </tr>
    <tr>
      <td>��ʽ����:</td>
      <td><%=ds("st_dl")%></td>
      <td>��ʽС��:</td>
      <td><%=ds("st_xz")%></td>
     
    </tr>
    <tr>
      <td>ԭ��:</td>
      <td class="notice"><%=ds("st_cloth")%></td>
      <td>��ʽ�Ա�:</td>
      <td><%=ds("st_xb")%></td>
     
    </tr>
	    <tr>
      <td>���ۼ�:</td>
      <td class="notice"><%=ds("x_price")%></td>
      <td>������λ:</td>
      <td><%=ds("st_by1")%></td>
    
    </tr>

  </table>
  <table width="100%" border="1" bordercolor="#ECE9D8" class="f14">
    <tr>
      <td>����˵��</td>
    </tr>
  </table><textarea name="intra" cols="55" rows="11" id="intra"><%=ds("dh_3")%></textarea>
</td>
    <td width="32%" align="center"><img src="../show_photo_sub.asp?id=<%=qts(id)%>?action=style"  width="160" height="200"></td>
  </tr>
</table><%ds.close
set ds=nothing%>


</body>
</html>
