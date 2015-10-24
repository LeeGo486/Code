<%option explicit%>
<!--#include file="inc/function.asp"-->
<%dim rs,id,sql
dim setdepotid,setdptname,set_nums,set_sums,cr_date
dim Cfname,cdname,cuname,dfname,ddname,duname
id = trim(request.QueryString("id"))
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_inventory"
  session("pkname") = "inventoryid"
  session("pksname")="inventory"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>无标题文档</title>
<script language="javascript">
  function chkform(){
    var clothingid;
    clothingid=window.document.form1.key.value;
	if(clothingid!=""){
	clothingid=clothingid.toUpperCase();
	window.document.form1.key.value=clothingid;
	window.document.form1.clothingid.value=clothingid;
	window.document.form1.key.value="";
	window.document.form1.key.focus();
	return true;
	}else{
	window.document.form1.key.focus();
	return false;
	}
  }
  
  function chksure(opt){
  switch(opt){
  case "chksure":
    str="审核";
	break;
  case "unchksure":
    str="反审核";
	break;
  case "sure":
    str="登帐";
	break;
  case "unsure":
    str="反登帐";
	break;
  default:
    alert("审核登帐参数不正确！");
	return;
  } 
  showModalDialog('f22_DjOperation.asp?id=<%=id%>&opt='+opt+'&str='+str+'&Cfname=<%=Cfname%>&Cdname=<%=Cdname%>&Cuname=<%=Cuname%>&Dfname=<%=Dfname%>&Ddname=<%=Ddname%>&Duname=<%=Duname%>','a','dialogWidth:320px;dialogHeight:260px;dialogTop:200px;center: yes;help:no;resizable:no;status:no');
}

function chkkp()
{
  if(event.keyCode<45||event.keyCode>57){event.returnValue = false;}
}

function chkblur()
{ var obj=document.form1.nums;
  if(isNaN(obj.value))
    {alert('数据类型错误！');obj.focus();}
  obj.value=Math.floor(obj.value);
  if(obj.value<=0)
    {obj.value=1;}
}
</script>
</head>

<body>
<table width="100%" border="0" class="bar">
  <tr>
    <td>业务操作 &gt;&gt; 条码盘点单 </td>
  </tr>
</table> 
<%

set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

sql = "select a.depotid,a.d_name,crdate,isnull(chk_sure,0) as chk_sure from vd_inventory a where inventoryid="&qts(id)
rs.source = sql
rs.open
if rs.eof then
  response.End()
else
  if cint(rs("chk_sure"))>0 then
     response.Write("<script>alert('单据已审核！');history.go(-1);</script>")
     response.end
  end if
  setdepotid=rs("depotid")
  setdptname=rs("d_name")
  cr_date=rs("crdate")
end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
<table width="100%" border="0" class="f14">
  <tr>
    <td>单号: <%=id%> 盘点店铺: <%=setdptname%>(<%=setdepotid%>) 制单日期: <%=cr_date%></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td><form action="2066_inventory_barcode_save.asp" method="get" name="form1" target="is" onSubmit="return chkform();">
      条码:
      <input name="key" type="text" id="key"><input name="clothingid" type="hidden" id="clothingid">
	  数量 <input type="text" name="nums" size="1" value="1" onKeyPress="chkkp()" onBlur="chkblur()">
	  <label><input type="radio" name="typ" value="1" checked>正</label><label><input type="radio" name="typ" value="-1">负</label>
	  <input name="show" type="hidden" id="show"><input type="submit" value=" 确 定 "><input name="id" type="hidden" id="id" value="<%=id%>">
	  条码截取<input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>">
        <!--<input type="button" value=" 审 核 " onClick="chksure('chksure');">-->
    </form>
    </td>
    <td>
计数器：<strong><span id="calNum">0</span></strong>

<input name="bu2" type="button" value="清零" onClick="javascript:document.getElementById('calNum').innerText='0';">
    
    <input name="bu1" type=button value="显示明细" onClick="javascript:document.form1.show.value='M';document.all.is.src='2066_inventory_barcode_sub.asp?id=<%=id%>&show=M';">   
	    <input name="bu2" type=button value="显示总数" onClick="javascript:document.form1.show.value='Z';document.all.is.src='2066_inventory_barcode_sub.asp?id=<%=id%>&show=Z';">
	    <input name="bu3" type="button" value="返回" onClick="javascript:location.href='search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<iframe  name="is" src="2066_inventory_barcode_sub.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="86%" frameborder="0"></iframe>

</body>
</html>
