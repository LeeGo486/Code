<%option explicit%>
<!--#include file="inc/function.asp"-->
<%dim rs,id,sql
dim getdepotid,getdptname,set_nums,set_sums,cr_date
dim Cfname,cdname,cuname,dfname,ddname,duname
id = trim(request.QueryString("id"))
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  session("tablename")="d_msell"
  session("pkname") = "msellid"
  session("pksname")="msell"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<title>�ޱ����ĵ�</title>
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
    str="���";
	break;
  case "unchksure":
    str="�����";
	break;
  case "sure":
    str="����";
	break;
  case "unsure":
    str="������";
	break;
  default:
    alert("��˵��ʲ�������ȷ��");
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
    {alert('�������ʹ���');obj.focus();}
  obj.value=Math.floor(obj.value);
  if(obj.value<=0)
    {obj.value=1;}
}
</script>
</head>

<body>
<table width="100%" border="0" class="bar">
  <tr>
    <td>ҵ����� &gt;&gt; ����������� </td>
  </tr>
</table> 
<%

set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn

rs.source = "select isnull(setchk_sure,0) from d_msell where msellid="&qts(id)
rs.open
if not rs.eof then
if rs(0)>0 then
     response.write("<script>alert('�˵�����ˣ�������ɨ��!');history.go(-1);</script>")
	 response.end
end if
end if
rs.close	

sql = "select a.get_depotid,b.d_name as get_depotname,setcr_date from d_msell a,j_depot b where a.get_depotid=b.depotid and msellid="&qts(id)
rs.source = sql
rs.open
if rs.eof then
  response.End()
else
  getdepotid=rs("get_depotid")
  getdptname=rs("get_depotname")
  cr_date=rs("setcr_date")
end if
rs.close
set rs = nothing
cn.close
set cn= nothing
%>
<table width="100%" border="0" class="f14">
  <tr>
    <td>����: <%=id%> �ջ���: <%=getdptname%>(<%=getdepotid%>) �Ƶ�����: <%=cr_date%></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td><form action="2071_msell_barcode_save.asp" method="get" name="form1" target="is" onSubmit="return chkform();">
      ����:
      <input name="key" type="text" id="key"><input name="clothingid" type="hidden" id="clothingid">
	  ���� <input type="text" name="nums" size="1" value="1" onKeyPress="chkkp()" onBlur="chkblur()">
	  <label><input type="radio" name="typ" value="1" checked>��</label><label><input type="radio" name="typ" value="-1">��</label>
	  <input type="submit" value=" ȷ �� "><input name="show" type="hidden" id="show"><input name="id" type="hidden" id="id" value="<%=id%>">
		<input name="getdptid" type="hidden" value="<%=getdepotid%>">
		�����ȡ<input type="text" name="tmln" size=3 value="<%=session("postm_ln")%>">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--<input type="button" value="�ύ" onClick="chksure('chksure');">-->
    </form>
    </td>
    <td><input name="bu1" type=button value="��ʾ��ϸ" onclick="javascript:document.form1.show.value='M';document.all.is.src='2071_msell_barcode_sub.asp?id=<%=id%>&show=M';">   
	    <input name="bu2" type=button value="��ʾ����" onclick="javascript:document.form1.show.value='Z';document.all.is.src='2071_msell_barcode_sub.asp?id=<%=id%>&show=Z';">
	    <input name="bu3" type="button" value="���ز�ѯ����" onClick="javascript:location.href='search_frame.asp?action=search'">
	</td>
  </tr>
</table>
<iframe  name="is" src="2071_msell_barcode_sub.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="86%" frameborder="0"></iframe>

</body>
</html>
