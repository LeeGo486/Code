<%option explicit
Response.Expires=-1000
'on error resume next%>
<!--#include file="inc/function.asp" -->
<%
if not padd and trim(request("action"))="create" then
   call mbox("û������Ȩ�ޣ�")
end if

dim ds
set ds=server.CreateObject("ADODB.Recordset")
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ӻ�����</title>
<base target="_self" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call SelectSF()%>
function checkform(){
  var outindentid,outindent,set_depotid,get_mchid,backrate,get_depotid,msg="",Taxonomy;
  with(document){
    outindentid=trim(form1.outindentid.value);
    outindent=trim(form1.outindent.value);
    set_depotid=trim(form1.set_depotid.value);
	get_mchid=trim(form1.get_mchid.value);
	get_depotid=trim(form1.get_depotid.value);
	backrate=trim(form1.backrate.value);
	Taxonomy=trim(form1.Taxonomy.value);

    if(isEmpty(outindentid)){
      msg="��ˮ�Ų���Ϊ��!";
	  form1.outindentid.focus();
    }
    if(isEmpty(outindent)){
      msg="������Ų���Ϊ��!";
      form1.outindent.focus();
    }
	
	if(isEmpty(set_depotid)){
	  msg="�ջ��ֿⲻ��Ϊ��!";
	  alert(msg);
	  selectMD('out_sd');
	  return false;
	}
	if(isEmpty(get_depotid) || isEmpty(get_mchid)){
	  msg="�����ֿⲻ��Ϊ��!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	}

    if(isEmpty(Taxonomy)){
      msg="�����׼����Ϊ��!";
	  form1.Taxonomy.focus();
    }

	if(isEmpty(backrate)){
	  form1.backrate.value="0";
	}
  }
  if(msg=="")
    return true;
  else{
    alert(msg);
    return false;
  }
}

</script>
<base target="_self">
</head>

<body>
<%
dim id,sql,action,bar,Taxonomy
dim outIndentid,outindent,MerchantId,setdate,sure,chk_sure,set_depotid,getdate,d_type,crname,chkname,parentid 'as string
dim chk_date,sure_date,ov_date,ov_sure,ov_name,cr_date,crdate,comment,backrate,selltype,backdate 'as string
dim sdptname,edptname,merchantname,get_depotid,get_mchid,eparentid,sparentid ' as string
id=trim(request("id"))
action=trim(request("action"))
bar=trim(request("bar"))
if id<>"" then session("id")=id
if action="" then action=trim(request("action"))

'response.Write(action)

select case action
case "del"
  Call getGant("del",0,session("formid"))
  if id="" then 
    Err.Raise 50001,"create_quota.edit","��ѡ��Ҫɾ���ĵ���!"
  else
    sql="delete from d_outIndentpro Where outindentid='" & id &"'"
    cn.execute sql
	set cn=nothing
	call close("ɾ���ɹ�!")
  end if
case "save"
  save
case "edit"
  if id="" then
    Err.Raise 50001,"create_quota.edit","����ѡ�񵥾�,���ܱ༭!"
  else
    sql="Select a.outindentid,a.outindent,a.depotid,a.set_depotid,a.setdate,a.selltype,a.backrate,a.comment,a.merchantid,b.d_name as setdptname,"&_
	    "c.d_name as getdptname,b.parentid as setparentid,c.parentid as getparentid,a.Taxonomy From d_outindentpro a,j_depot b,j_depot c "&_
		" Where a.set_depotid=b.depotid and a.depotid=c.depotid and a.outindentid="&qts(id)
	ds.source = sql
    ds.open
    'response.Write(sql)
    if not ds.eof then
	  outindentid=ds("outindentid")
	  outindent=ds("outindent")
      set_depotid=ds("depotid")
	  sdptname=ds("getdptname")
      merchantid=ds("merchantid")
	  get_depotid=ds("set_depotid")
	  edptname=ds("setdptname")
	  setdate=ds("setdate")
	  selltype=ds("selltype")
	  parentid=ds("setparentid")
      eparentid=ds("getparentid")
	  'getdate=ds("getdate")
      backrate=ds("backrate")
      comment=ds("comment")
      Taxonomy=ds("Taxonomy")
      
    end if
    ds.close
    set ds=nothing
    call show
  end if
case "create"
  Call getGant("create",0,session("formid"))
  outindentid=getid("d_outindentpro","outindentid","SQ",session("dm").System_UserId)
  outindent=outindentid
  get_depotid=session("dm").System_Depotid
  edptname=session("dm").System_DepotName
  get_mchid=session("dm").System_UnitId
  parentid=session("dm").System_ParentId
  merchantid=get_mchid
  
  'set_depotid=session("dm").System_Depotid
  'sdptname=session("dm").System_DepotName
  setdate=get_date(date)
  backrate="True"
  session("id")=outindentid
  call show
case else
  Err.Raise 50001,"create_quota.else","û����������!"
end select
set cn=nothing
%>
<%sub show%>
<form name="form1" method="post" action="?bar=<%=bar%>" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td align="center">�˻�����</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" value="save">
        ��ˮ��:</td>
      <td width="85%"><input name="outindentid" type="text" id="outindentid"
       value="<%=outindentid%>" size="22" maxlength="22" class="intra13" readonly>
          <input type="hidden" name="hiddenField"></td>
    </tr>
    <tr>
      <td align="right">���뵥��:</td>
      <td><input name="outindent" type="text" id="outindent" class="intra13" value="<%=outindent%>" size="22" maxlength="22">          </td>
    </tr>
    <tr>
      <td align="right">�˻��ֵ�:</td>
      <td>
        <input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm');" disabled>
          <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;width:200px;"
           value="<%=edptname%>" readonly>
          <input name="get_mchid" type="hidden" id="get_mchid" value="<%=merchantid%>">
          <input name="parentid" type="hidden" id="parentid" value="<%=parentid%>">
     </td>
    </tr>
    <tr>
      <td align="right">�ջ��ֵ�:</td>
      <td>
        <input name="set_depotid" type="text" id="set_depotid" value="<%=set_depotid%>" size="22" maxlength="10" readonly>
        <input type="button" name="Submit" value="..." onClick="selectMD('out_sd');" >
          <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;width:200px;"
           value="<%=sdptname%>" readonly>
      </td>
    </tr>
    <tr>
      <td align="right">�˻�����:</td>
      <td><input name="setdate" type="text" id="setdate" onFocus="setday(this)" value="<%=setdate%>" size="10" readonly ></td>
    </tr>
    <tr>
      <td align="right">ռ���˻��ʣ�</td>
      <td>      
      <input name="backrate" type="checkbox" id="backrate" value="1"  <%if backrate="True" then response.Write("checked='true'") end if%> <%if (action="edit") then response.Write("disabled='disabled'") end if %> />
      <span style="color:red">ע���˴�����Ϊ�����˻�</span></td>
    </tr>
    <tr>
      <td align="right">�˻����ͣ�</td>
      <td><%=getLookupByName(4003,selltype)%></td>
    </tr>

    <tr>
      <td align="right">�����׼��</td>
      <td><%=getLookupByName2(4007,Taxonomy,"Taxonomy")%></td>
    </tr>

    <tr>
      <td align="right">��ע:</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>
" size="50"></td>
    </tr>
  </table>
  <table width="480"  border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <div align="center">
    <table width="480"  border="0" class="tcontent">
      <tr>
        <td align="center"><input type="submit" name="Submit" value="����(S)" accesskey="s">
            <input type="button" name="Submit" value="ȡ��(X)" onClick="window.close();" accesskey="x"></td>
      </tr>
    </table>
  </div>
</form>
<%end sub%>
<%sub save
  outindentid=trim(request.Form("outindentid"))
  outindent=trim(request.Form("outindent"))
  get_depotid=trim(request.Form("get_depotid"))
  session("set_depotid")=get_depotid
  set_depotid=trim(request.Form("set_depotid"))
  session("get_depotid")=set_depotid
  merchantid=trim(request.Form("get_mchid"))
  sparentid=trim(request.Form("sparentid"))
  eparentid=trim(request.Form("eparentid"))
  setdate=trim(request.Form("setdate"))
  selltype=trim(request.Form("selltype"))
  backrate=trim(request.Form("backrate"))
  Taxonomy=trim(request.Form("Taxonomy"))
  
  if backrate="" then backrate=0 else backrate=1 end if
  
  comment=trim(request.Form("comment"))
  setdate=get_date(setdate)
  sql="select * from d_outindentpro where outindentid ="& qts(outindentid)
  ds.CursorType = 1
  ds.CursorLocation = 2
  ds.LockType = 3
  ds.source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0,session("formid"))
    '��������
    ds.AddNew
	ds("outindentid")=outindentid
	ds("outindent")=outindent
	ds("depotid")=set_depotid
	ds("merchantid")=merchantid
	ds("set_depotid")=get_depotid
	ds("setdate")=setdate
	ds("selltype")=selltype
	ds("backrate")=backrate
	ds("parentid")=session("dm").System_ParentId
	
	ds("comment")=comment
	ds("cr_name")=session("dm").System_UserName
	ds("cr_date")=get_date(date)
	'ds("crdate")=get_date(date)
	ds("chk_sure")=0
	ds("sure")=0
	ds("ov_sure")=0
	ds("Taxonomy")=Taxonomy

    
	'ds("ass_sure")=0
	'ds("prop_sure")=0
	'ds("propdate")=get_date(date)
	'ds("propname")=session("dm").System_UserName
	ds.Update
	ds.close
	set ds=nothing
	response.Write("<script language='javascript'>")
	if bar="1" then
	  response.Write("window.location.href='ajax/2063_outindent.asp?id="&outindentid&"';")
	else
	response.Write("showModalDialog('f22_main.asp?id="&outindentid&"&pksname=outindent&opt=outindentPRO&numName=nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	response.Write("window.location.href='search_frame.asp';")
	end if
	response.Write("</script>")
  else
    Call getGant("edit",0,session("formid"))
	ds("outindent")=outindent
	ds("depotid")=set_depotid
	ds("merchantid")=merchantid
	ds("set_depotid")=get_depotid
	ds("setdate")=setdate
	ds("selltype")=selltype
	ds("comment")=comment
	ds("Taxonomy")=Taxonomy
	
	ds("backrate")=backrate

	
	
	ds.update
	ds.close
    set ds=nothing
	call close("�޸ĳɹ�!")
  end if
end sub%>
<%session("SPName")="f22_lroutindentsub"%>
<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
end if%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="280px";
  //window.dialogLeft   X����   
  //window.dialogTop   Y���� 
</script>
</body>
</html>
