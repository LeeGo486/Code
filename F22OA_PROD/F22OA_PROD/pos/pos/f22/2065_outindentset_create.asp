<%option explicit
Response.Expires=-1000
'on error resume next%>
<!--#include file="inc/function.asp" -->
<%
if not padd and trim(request("action"))="create" then
   call mbox("没有新增权限！")
end if

dim ds
set ds=server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<base target="_self">
<title>添加发货单</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call SelectSF()%>
function checkform(){
  var outindentid,outindent,set_depotid,get_mchid,backrate,get_depotid,msg="",Taxonomy;
  Taxonomy =""
  with(document){
    outindentid=trim(form1.outindentid.value);
    outindent=trim(form1.outindent.value);
    set_depotid=trim(form1.set_depotid.value);
	get_mchid=trim(form1.get_mchid.value);
	get_depotid=trim(form1.get_depotid.value);
	backrate=trim(form1.backrate.value);
	Taxonomy=trim(form1.Taxonomy.value);
    if(isEmpty(outindentid)){
      msg="流水号不能为空!";
	  form1.outindentid.focus();
    }
    if(isEmpty(outindent)){
      msg="配货单号不能为空!";
      form1.outindent.focus();
    }
	
	if(isEmpty(set_depotid)){
	  msg="收货仓库不能为空!";
	  alert(msg);
	  selectMD('out_sd');
	  return false;
	}
	if(isEmpty(get_depotid) || isEmpty(get_mchid)){
	  msg="发货仓库不能为空!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	}
    if(isEmpty(Taxonomy)){
      msg="分类标准不能为空!";
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
dim id,sql,action,bar,czid,Taxonomy
dim outIndentid,outindent,MerchantId,setdate,sure,chk_sure,set_depotid,getdate,d_type,crname,chkname,parentid,quotaid 'as string
dim chk_date,sure_date,ov_date,ov_sure,ov_name,cr_date,crdate,comment,backrate,selltype,backdate 'as string
dim sdptname,edptname,merchantname,get_depotid,get_mchid,eparentid,sparentid ' as string
id=trim(request("id"))
czid=trim(request("czid"))
action=trim(request.Form("action"))
bar=trim(request("bar"))
if id<>"" then session("id")=id
if action="" then action=trim(request.QueryString("action"))
'response.Write(action)
select case action
case "del"
  Call getGant("del",0,session("formid"))
  if id="" then 
    Err.Raise 50001,"create_quota.edit","请选择要删除的单据!"
  else
    sql="delete from d_outIndentset Where outindentid='" & id &"'"
    'de sql
	cn.execute sql
	set cn=nothing
	call close("删除成功!")
  end if
case "save"
  save
case "edit"
  if id="" then
    Err.Raise 50001,"create_quota.edit","请先选择单据,才能编辑!"
  else
    sql="Select isnull(a.quotaid,'') quotaid,a.outindentid,a.outindent,a.depotid,a.set_depotid,a.setdate,a.backrate,a.comment,a.merchantid,b.d_name as setdptname,"&_
	    "c.d_name as getdptname,b.parentid as setparentid,c.parentid as getparentid,isnull(a.Taxonomy,'') Taxonomy From d_outindentset a,j_depot b,j_depot c "&_
		" Where a.set_depotid=b.depotid and a.depotid=c.depotid and a.outindentid="&qts(id)
    ds.open sql,cn,1,3
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
	  parentid=ds("setparentid")
      eparentid=ds("getparentid")
	  'getdate=ds("getdate")
      backrate=ds("backrate")
      comment=ds("comment")
      Taxonomy=ds("Taxonomy")
      quotaid=ds("quotaid")
    end if
    ds.close
    set ds=nothing
    call show
  end if
case "create"
  Call getGant("create",0,session("formid"))
  outindentid=getid("d_outindentset","outindentid","FH",session("dm").System_UserId)
  outindent=outindentid
  get_depotid=session("dm").System_Depotid
  edptname=session("dm").System_DepotName
  get_mchid=session("dm").System_UnitId
  merchantid=get_mchid
  parentid=trim(session("dm").System_ParentId)
  'set_depotid=session("dm").System_Depotid
  'sdptname=session("dm").System_DepotName
  setdate=get_date(date)
  backrate="True"
  session("id")=outindentid
  call show
case else
  Err.Raise 50001,"create_quota.else","没有设置命令!"
end select
set cn=nothing
%>
<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td align="center">退货发货单</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" value="save">
        流水号:</td>
      <td width="85%"><input name="outindentid" type="text" id="outindentid"  class="intra13"  value="<%=outindentid%>" size="22" maxlength="22" readonly>
          <input type="hidden" name="hiddenField">          </td>
    </tr>
    <tr>
      <td align="right">退货单号:</td>
      <td><input name="outindent" type="text" id="outindent"  class="intra13"  value="<%=outindent%>" size="22" maxlength="22">          </td>
    </tr>
    <tr>
      <td align="right">退货仓店:</td>
      <td>
        <input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sm');" disabled>
          <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;" value="<%=edptname%>" size="20" readonly>
          <input name="get_mchid" type="hidden" id="get_mchid" value="<%=merchantid%>">
          <input name="parentid" type="hidden" id="parentid" value="<%=parentid%>">
		  <input name="czid" type="hidden" id="czid" value="<%=czid%>">     
		  <input name="bar" type="hidden" id="bar" value="<%=bar%>"></td>
    </tr>
    <tr>
      <td align="right">收货仓店:</td>
      <td>
        <input name="set_depotid" type="text" id="set_depotid" value="<%=set_depotid%>" size="22" maxlength="10" readonly>
        <input type="button" name="Submit" value="..." onClick="selectMD('out_sd');">
        <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" value="<%=sdptname%>" size="20" readonly>      </td>
    </tr>
    <tr>
      <td align="right">退货日期:</td>
      <td><input name="setdate" type="text" id="setdate" onFocus="setday(this)" value="<%=setdate%>" size="10" readonly>
      占有退货率:
      <input name="backrate" type="checkbox" id="backrate" value="1" <%if backrate="True" then response.Write(" checked") end if%>></td>
    </tr>
    
    <tr>
      <td align="right">分类标准：</td>
      <td>
        <%if quotaid = "" or Taxonomy="" then 
             getLookupByName2 4007,Taxonomy,"Taxonomy"
            else  %>
              <select id="Taxonomy" name="Taxonomy">
                    <option value="<%=Taxonomy %>" ><%=Taxonomy %></option>
              </select>
        <%end if %>    
      </td>
    </tr>
    <tr>
      <td align="right">备注:</td>
      <td><input name="comment" type="text" id="comment" value="<%=comment%>" size="50"></td>
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
        <td align="center"><input type="submit" name="Submit" value="保存(S)" accesskey="s">
            <input type="button" name="Submit" value="取消(X)" onClick="window.close();" accesskey="x"></td>
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
  sparentid=trim(request.Form("parentid"))
  eparentid=trim(request.Form("eparentid"))
  setdate=trim(request.Form("setdate"))
  backrate=trim(request.Form("backrate"))
  comment=trim(request.Form("comment"))
  czid=trim(request.Form("czid"))
  setdate=get_date(setdate)
  Taxonomy=trim(request.Form("Taxonomy"))
  
  if set_depotid="" then
    response.Write("<script>alert('请选择收货仓店!');window.history.back();</script>")
    response.End()
  end if
  
  if session("ctrlback")=0 and  session("m_type")<>6 then
     sql="select * from j_depot where depotid='"&set_depotid&"' and m_type in (0,1)"
	 ds.open sql,cn,1,3
	 if ds.eof and ds.bof then
       ds.close
	 else
	   ds.close
	   response.Write("<script>alert('总部未允许此机构无条件退货,不能直接向总部退货,请先做退货申请!');window.history.back();</script>")
       response.End()
	 end if   
  end if	
  
  sql="select * from d_outindentset where outindentid ="& qts(outindentid)
  ds.open sql,cn,1,3
  if ds.eof then
    Call getGant("create",0,session("formid"))
    '保存新增
    ds.AddNew
	ds("outindentid")=outindentid
	ds("outindent")=outindent
	ds("quotaid")=czid
	session("quotaid")=czid
	ds("depotid")=set_depotid
	ds("merchantid")=merchantid
	ds("parentid")=sparentid			' add by jackie 20090618
	ds("set_depotid")=get_depotid
	ds("setdate")=setdate
	ds("backrate")=1
	ds("comment")=comment
	ds("cr_name")=session("dm").System_UserName
	ds("cr_date")=get_date(date)
	'ds("crdate")=get_date(date)
	ds("chk_sure")=0
	ds("sure")=0
	ds("ov_sure")=0
	ds("ass_sure")=0
	ds("prop_sure")=0
	ds("propdate")=get_date(date)
	ds("propname")=session("dm").System_UserId
	ds("Taxonomy")=Taxonomy
	ds.Update
	ds.close
	set ds=nothing
	response.Write("<script language='javascript'>")
	if bar="1" then
	  response.Write("window.location.href='ajax/2065_outindent.asp?id="&outindentid&"';")
	else
	response.Write("showModalDialog('f22_main.asp?id="&outindentid&"&pksname=outindent&opt=outindentset&numName=nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
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
	ds("comment")=comment
	ds("Taxonomy")=Taxonomy
	ds.update
	ds.close
    set ds=nothing
	call close("修改成功!")
  end if
end sub%>
<%session("SPName")="f22_lroutindentsub"%>
<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
end if%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="280px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>
</body>
</html>
