<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<style>
#ShowDivLink{
font-size:12px;
}
#ShowDivLink:hover{
color:#ff3300
}
</style>
<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDivAdd(z){
var z;
var s=document.getElementById("inputAdd_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
<script type="text/javascript" src="../../inc/js/setday.js"></script>

<script language="javascript">
function jump(t){
  window.location.href="jz_ss.asp?depotid="+t.value;
}
function chkFormAdd(t){
  var msg="";
  t.depotid.value=document.form2.depotid.value;
  t.compete.value=document.form2.compete.value;
  t.setdate.value=document.form2.setdate.value;
  if(t.depotid.value==""){
    msg="店铺编号不能为空,请刷新后重试!";
  }
  if(t.compete.value==""){
    msg="竞争品牌编号不能为空,请刷后重试!";
  }
  if(t.styleid.value==""){
    msg="新产品型号不能为空!";
	alert(msg);
	t.styleid.focus();
	return false;
  }
  if(msg=="")
    return true;
  else
    return false;
}

function chkForm1(t){
  var msg="";
  if(t.styleid.value==""){
    msg="新产品型号不能为空!";
	alert(msg);
	t.styleid.focus();
	return false;
  }
  if(t.competechkid.value==""){
    msg="出错了!"
  }
  if(msg=="")
    return true;
  else
    return false;
}
</script>
</head>

<body>
<%dim id,sql,ds,ds1,tname,i,depotid,competechkid
depotid=trim(request.QueryString("depotid"))
if depotid="" then
  depotid=trim(session("dm").System_Depotid)
end if
userid=trim(session("dm").System_UserId)
competechkid=trim(request.QueryString("competechkid"))

compete=trim(request.Form("compete"))
setdate=trim(request.Form("setdate"))
if compete="" then
   compete=trim(request.QueryString("competeid"))
end if
if setdate="" then
   setdate=trim(request.QueryString("setdateid"))
end if
i=0

%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk">
  <tr>
    <td height="21" class="f14"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 竞争品牌新品上市调查 </td>
  </tr>
</table>
<table width="100"  border="0">
    <tr>
      <td></td>
    </tr>
</table>
<form name="form2" method="post" action="jz_ss.asp">
  <table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
    <tr>
      <td width="9%" class="f14">商场名称:</td>
      <td width="16%" class="f14"><select name="depotid" id="depotid" onChange="jump(this);">
	  <%set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
sql="select TOP 1 depotid,d_name from webp_depot where depotid='"&trim(session("dm").System_Depotid)&"'"
ds.Source = sql
ds.Open
while not ds.eof
%>
          <option value="<%=ds(0)%>" <%if depotid=trim(ds(0)) then response.Write "selected" end if%>><%=ds(1)%></option>
          <%ds.movenext
		wend
		ds.Close%>
        </select>
&nbsp;</td>
      <td width="9%" class="f14">竞争品牌:</td>
      <td width="13%" class="f14"><select name="compete" id="compete">
         
          <option value="<%=compete%>"><%=compete%></option>
          
        </select>
      </td>
      <td width="10%" class="f14">上市时间:</td>
      <td width="16%" class="f14"><input name="setdate" type="text" id="setdate" size="11" maxlength="10" value="<%=setdate%>"  readonly> </td>
      <td width="12%" class="f14">填写人:</td>
      <td width="15%" class="f14"><%=session("dm").System_UserName%></td>
    </tr>
  </table>
</form>
<table width="100" border="0">
  <tr>
    <td></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr align="center" bgcolor="#FFF7F7">
    <td width="19%" class="f14">新产品型号</td>
    <td width="17%" class="f14">颜色</td>
    <td width="11%" class="f14">单价</td>
    <td width="20%" class="f14">风格</td>
    <td width="16%" class="f14">原材料类别</td>
	<td width="5%" class="f14">评论</td>
    <td width="12%" class="f14">&nbsp;</td>
  </tr>
  <%

  sql="select * from d_competechksub where competechkid="&qts(competechkid)
  ds.Source = sql
  ds.Open
  j=0
  while not ds.eof
  j=j+1
  %>
  <form name="form1" method="post" action="jz_ss_save.asp" onSubmit="return chkForm1(this);">
  <tr>
    <td class="f14"><%=ds("styleid")%>
      <input name="styleid" type="hidden" id="styleid" value="<%=ds("styleid")%>"></td>
    <td class="f14"><input name="c_name" type="text" id="c_name" value="<%=ds("c_name")%>" size="16" maxlength="20"></td>
    <td class="f14"><input name="x_price" type="text" id="x_price" value="<%=ds("x_price")%>" size="10" maxlength="10"></td>
    <td class="f14"><input name="styletype" type="text" id="styletype" value="<%=ds("styletype")%>" size="20" maxlength="30"></td>
    <td class="f14"><input name="st_lb" type="text" id="st_lb" value="<%=ds("st_lb")%>" size="15" maxlength="30"></td>
	<td class="f14"><a href="#"  onClick="showDiv('<%=j%>')" id="ShowDivLink">评论</a></td>
    <td class="f14"><input type="submit" name="Submit" value="修改">
      <input name="act" type="hidden" id="act" value="edit">
	   <input name="depotid" type="hidden" id="depotid">
	  <input name="compete" type="hidden" id="compete" value="<%=compete%>">
      <input name="setdate" type="hidden" id="setdate" value="<%=setdate%>">
	  <input name="competechkid" type="hidden" id="competechkid" value="<%=competechkid%>">
	  <a href="jz_ss_save.asp?act=del&comid=<%=competechkid%>&styleid=<%=ds("styleid")%>&compete=<%=server.URLEncode(compete)%>&setdate=<%=setdate%>">删除</a></td>
  </tr>
   <tr>
    <td class="f14" colspan="7">
	<div id="input_<%=j%>" style="display:none;">
	<table>
	<tr>
	<td>
	评价理由:<br>
	<textarea rows=5 cols="40"  id="comment" name="comment"><%=ds("comment")%></textarea>
	<td>
	<td>
	 <iframe class="TBGen" style="top:2px" ID="UploadFiles"  src="uploadA.asp" frameborder=0 scrolling=no width="300" height="25"></iframe>
	</td>
	<td>
	<% if ds("imagesurl")="" then %>
	<img id="ImageShopPic" alt="" src="img/tip_uppohto.jpg" width="100" height="100" />
	<% else %>
	
	<img id="ImageShopPic" alt="" src="../..<%=ds("imagesurl")%>" width="100" height="100" />
	<% end if%>
	</td>
	<td> <input name="ImageUrl" type="hidden" value="<%=ds("imagesurl")%>" size="20" readonly="readonly"></td>
	
	</tr>
	</table>
	</div>
	</td>
  </tr>	
  </form>
  <%ds.movenext
  wend
  ds.close
 set ds=nothing%>
  <form name="formadd" method="post" action="jz_ss_save.asp" onSubmit="return chkFormAdd(this);">
  <tr>
    <td class="f14"><input name="styleid" type="text" id="styleid" size="20" maxlength="20"></td>
    <td class="f14"><input name="c_name" type="text" id="c_name" size="16" maxlength="20"></td>
    <td class="f14"><input name="x_price" type="text" id="x_price" size="10" maxlength="10"></td>
    <td class="f14"><input name="styletype" type="text" id="styletype" size="20" maxlength="30"></td>
    <td class="f14"><input name="st_lb" type="text" id="st_lb" size="15" maxlength="30"></td>
	<td class="f14"><a href="#"  onClick="showDivAdd('<%=i%>')" id="ShowDivLink">评论</a></td>
    <td class="f14"><input type="submit" name="Submit" value="添加">
      <input name="depotid" type="hidden" id="depotid">
      <input name="act" type="hidden" id="act" value="add">
      <input name="compete" type="hidden" id="compete">
      <input name="setdate" type="hidden" id="setdate">
      <input name="cr_name" type="hidden" id="cr_name" value="<%=session("dm").System_UserName%>">
	  <input name="competechkid" type="hidden" id="competechkid" value="<%=competechkid%>"></td>
  </tr>
    <tr>
    <td class="f14" colspan="7">
	<div id="inputAdd_<%=i%>" style="display:none;">
	<table>
	<tr>
	<td>
	评价理由:<br>
	<textarea rows=5 cols="40"  id="comment" name="comment"></textarea>
	<td>
	<td valign="middle">
	 <iframe class="TBGen" style="top:2px" ID="UploadFiles"  src="upload.asp" frameborder=0 scrolling=no width="300" height="100"></iframe>
	</td>
		<td><img id="ImageShopPic" alt="" src="img/tip_uppohto.jpg" width="100" height="100" /></td>
	<td> <input name="ImageUrl" type="hidden" value="" size="20" readonly="readonly"></td>
	</tr>
	</table>
	</div>
	</td>
  </tr>
<input name="count" type="hidden" id="count" value="<%=i%>">
</form>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="center"><input type="button" name="Submit" value="完成调查" onClick="JavaScript:window.location='jz_ss.asp'">
    </td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="right">
    </td>
  </tr>
</table>
</body>
</html>
