<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>查看款式</title>
<base target="_self" />
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
<script type="text/javascript">
function clothing(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>',window,'dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}
function rtval()
{
	var ck = document.getElementsByTagName("input");
	var str="";
	for(i=0;i<ck.length;i++)
	{
		if(ck[i].type=="checkbox")
		{
			if(ck[i].checked) str+=ck[i].value+"|";
		}
	}
	window.returnValue=str;
	window.close();
}
function sc(obj,type)
{
	if(type==0)
	{
	var ck = obj.getElementsByTagName("input")[0];
	if(!ck.checked)
	{
	obj.style.fontWeight='bold'
	ck.checked=true;
	
	}else
	{
	obj.style.fontWeight='normal'
	ck.checked=false;
		}
	}
	else if(type==1)
	{
	obj.style.background='#FFefef'
	}
	else if(type==2)
	{
	obj.style.background='#FFF'	
	}
	
}
</script>
</head>

<body>
<table width="100%" border="0">
  <tr valign="top">
    <td width="68%">
<%
	dim ds,id,sql,i,cid
	id=trim(request.QueryString("id"))
	set ds=server.CreateObject("ADODB.Recordset")
	cid = id
	sql="select styleid from j_clothing where clothingid="&qts(id)
	ds.open  sql,cn,1,1
	if not ds.eof then
	  id=ds(0)
	end if
	ds.close
	
	
	if id="" then
	  sql="select top 1 styleid,s_name,st_cloth,st_by1,isnull(dh_3,'') as dh_3,st_year,st_month,st_dl,st_xz,st_xb,x_price,comment from j_style"
	else
	  sql="select styleid,s_name,st_cloth,st_by1,isnull(dh_3,'') as dh_3,st_year,st_month,st_dl,st_xz,st_xb,x_price,comment "&_
				" from j_style where styleid = "&qts(id)
	end if

	ds.open  sql,cn,1,1
	if ds.eof and ds.bof then
	  ds.close
	  set ds=nothing
	  call close("没有找到这个款式!")
	  response.End()
	end if
	%>
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
      <td width="15%">原料:</td>
      <td width="18%"><%=ds("st_cloth")%></td>
    </tr>
    <tr>
      <td>款式大类:</td>
      <td><%=ds("st_dl")%></td>
      <td>款式小类:</td>
      <td><%=ds("st_xz")%></td>
      <td>款式性别:</td>
      <td><%=ds("st_xb")%></td>
    </tr>
    <tr>
      <td>零售价:</td>
      <td class="notice"><%=ds("x_price")%></td>
      <td>目前库存:</td>
      <td>&nbsp;</td>
      <td>计量单位:</td>
      <td><%=ds("st_by1")%></td>
    </tr>
  </table>
  <table width="100%" border="1" bordercolor="#ECE9D8" class="f14">
    <tr>
      <td>卖点说明</td>
    </tr>
  </table><textarea name="intra"  style="width:98%;" rows="6" id="intra"><%=ds("dh_3")%></textarea>
</td>
    <td width="32%" align="center"><img src="show_photo_sub.asp?action=style&id=<%=ds("styleid")%>" alt="<%=ds("s_name")%>" width="160" height="200"></td>
  </tr>
</table><%
ds.close
sql="select a.Yclothingid,a.dclothingid,a.dstyleid,b.s_name,a.dcolorid,c.c_name,a.dsizeid,isnull(a.nums,0) as nums "&_
		" from j_quotadpsub a"&_
		" left join j_style b on b.styleid=a.dstyleid"&_
		" left join j_color c on c.colorid=a.dcolorid"&_
		" where Yclothingid='"&cid&"' "&_
		" and isnull(sure,0)=1"&_
		" order by a.dstyleid,c.c_order,a.dsizeid"
ds.open sql,cn,1,1
if not ds.eof and not ds.bof then
%>
<div style="overflow-y:scroll;height:250px;">
<table width="100%" border="0" bordercolor="#C6AEA5" bgcolor="#FFF7F7" class="bk" style="margin:10px 0;">
  <tr>
    <td align="center">
    <strong>搭配款</strong>
    </td>
  </tr>
  <tr>
    <td align="center" style="background:#FFFeFe;">
      <table width="100%" border="0" cellpadding="2" cellspacing="0">
        <tr>
        <td align="center"> <strong>选择</strong> </td>
<!--          <td align="center"> <strong>主款</strong> </td>
-->          <td align="center" style="width:120px;"> <strong>搭配款</strong> </td>
          <td align="center"> <strong>款式编号</strong> </td>
          <td align="center"> <strong>款式名称</strong> </td>
          <td align="center"> <strong>颜色编号</strong> </td>
          <td align="center"> <strong>颜色名称</strong> </td>
          <td align="center"> <strong>尺码</strong> </td>
          <td align="center"> <strong>搭配数量</strong> </td>
        </tr>
  <%
	do while not ds.eof
		%>
        <tr onMouseOver="sc(this,1)" onMouseOut="sc(this,2)" onClick="sc(this,0)">
          <td><input type="checkbox" value="<%=ds(1)%>" id="ck" name="ck"></td>
<!--          <td><%=ds(0)%></td>
-->       <td><a href="javascript:;" onClick="clothing('<%=ds(1)%>')" title="详细"><%=ds(1)%></a></td>
          <td><%=ds(2)%></td>
          <td><%=ds(3)%></td>
          <td><%=ds(4)%></td>
          <td><%=ds(5)%></td>
          <td><%=ds(6)%></td>
          <td><%=ds(7)%></td>
        </tr>
		<%
	ds.movenext
	loop
	%>
      </table>
    </td>
  </tr>
</table>
</div>
<script type="text/javascript">
  window.dialogHeight="540px";
</script>

<%
end if
ds.close


set ds=nothing%>

<table width="100%" border="0" bordercolor="#C6AEA5" bgcolor="#FFF7F7" class="bk">
  <tr>
    <td align="center"><input type="button" name="Submit" value="确定(S)" onClick="rtval();" accesskey="s">
      <input type="button" name="Submit" value="取消(X)" onClick="window.close();" accesskey="x"></td>
  </tr>
</table>
</body>
</html>
