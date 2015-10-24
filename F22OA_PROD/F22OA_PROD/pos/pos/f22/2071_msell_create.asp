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
    ds.activeconnection = cn%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>添加发货单</title>
<base target="_self">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
function selectMD(str){
  var m=showModalDialog('SelectMD.asp?action='+str+'&getinfo=true',self,'dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
  var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;
	try{
	arr=m.split(",");
	get_depotid=arr[0];//仓库ID
	edptname=arr[1];//仓库名
	get_mchid=arr[2];//店铺ID,二级编号
	parentid=arr[3];//一级编号
	document.form1.get_depotid.value=get_depotid;
	document.form1.edptname.value=edptname;
	document.form1.get_mchid.value=get_mchid;
	document.form1.eparentid.value=parentid;
	}catch(ex){}
}

function checkform(){
  var msellid,msell,set_depotid,set_mchid,get_mchid,get_depotid,msg="";
  with(document){
    msellid=trim(form1.msellid.value);
    msell=trim(form1.msell.value);
    set_depotid=trim(form1.set_depotid.value);
	get_mchid=trim(form1.get_mchid.value);
	get_depotid=trim(form1.get_depotid.value);
	set_mchid=trim(form1.set_mchid.value);
    if(isEmpty(msellid)){
      msg="流水号不能为空!";
	  form1.msellid.focus();
    }
    if(isEmpty(msell)){
      msg="配货单号不能为空!";
      form1.msell.focus();
    }
	
	if(isEmpty(set_depotid)){
	  msg="发货地不能为空!";
	  alert(msg);
	  selectMD('sm');
	  return false;
	}
	if(isEmpty(get_depotid) || isEmpty(get_mchid)){
	  msg="收货地不能为空!";
	  alert(msg);
	  selectMD('msell');
	  return false;
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
<script type="text/javascript">
function j_renull(obj,val)
{
	var str = parseFloat(val).toString();
	if(str=="NaN")
	str="";
	obj.value=str;
}
</script>
</head>

<body>
<%
dim id,sql,action,bar,czid
dim msellid,msell,set_MchId,get_mchid,setdate,sure,chk_sure,set_depotid,getdate,d_type,crname,chkname 'as string
dim chk_date,sure_date,ov_date,ov_sure,ov_name,cr_date,crdate,comment,backrate,selltype,backdate 'as string
dim sdptname,edptname,get_depotid,eparentid,sparentid ' as string
dim fmstype,fmscash,fmsinfo,fmsaddress,fmsmobtel,fmsrname,str1

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
    Err.Raise 50001,"create_msell.edit","请选择要删除的单据!"
  else
    sql="delete from d_msell Where msellid='" & id &"'"
    'de sql
	cn.execute sql
	set cn=nothing
	call close("删除成功!")
  end if
case "save"
  save
case "edit"
  if id="" then
    Err.Raise 50001,"create_msell.edit","请先选择单据，才能编辑！"
  else
    sql="Select a.msellid,a.msell,a.set_depotid,a.get_depotid,a.setdate,a.backrate,a.set_comment,a.set_mchid,a.get_mchid,b.d_name as setdptname,"&_
				" a.fmstype, a.fmscash, a.fmsinfo, a.fmsaddress, a.fmsmobtel, a.fmsrname,"&_
				"c.d_name as getdptname,a.set_parentid,a.get_parentid From d_msell a,j_depot b,j_depot c "&_
				" Where a.set_depotid=b.depotid and a.get_depotid=c.depotid and a.msellid="&qts(id)
	ds.source = sql
    ds.open
    'response.Write(sql)
    if not ds.eof then
			msellid=ds("msellid")
			msell=ds("msell")
			set_depotid=ds("set_depotid")
			sdptname=ds("setdptname")
			set_mchid=ds("set_mchid")
			get_mchid=ds("get_mchid")
			get_depotid=ds("get_depotid")
			edptname=ds("getdptname")
			setdate=ds("setdate")
			sparentid=ds("set_parentid")
			eparentid=ds("get_parentid")
			'getdate=ds("getdate")
			backrate=ds("backrate")
			comment=ds("set_comment")
			
			'货运信息等 2009-02-16
			
			fmstype=ds("fmstype")
			if isnull(fmstype) or isempty(fmstype) or fmstype="" then
			fmstype = 0
			else
			fmstype = cdbl(fmstype)
			end if
			
			if fmscash<>"" then fmscash=ds("fmscash")
			fmsinfo=ds("fmsinfo")
			fmsaddress=ds("fmsaddress")
			fmsmobtel=ds("fmsmobtel")
			fmsrname=ds("fmsrname")

    end if
    ds.close
    set ds=nothing
    call show
  end if
case "create"
  Call getGant("create",0,session("formid"))
  msellid=getid("d_msell","msellid","TD",session("dm").System_UserId)
  msell=msellid
  set_depotid=session("dm").System_Depotid
  sdptname=session("dm").System_DepotName
  set_mchid=session("dm").System_UnitId
  get_mchid=get_mchid
  sparentid=session("dm").System_parentid
  'set_depotid=session("dm").System_Depotid
  'sdptname=session("dm").System_DepotName
  setdate=get_date(date)
  backrate="True"
  session("id")=msellid
  call show
case else
  Err.Raise 50001,"create_msell.else","没有设置命令!"
end select
set cn=nothing
%>
<%sub show%>
<form name="form1" method="post" action="" onSubmit="return checkform();">
<input name="bar" type="hidden" id="bar" value="<%=bar%>">
  <table width="480"  border="0" align="center" class="bar">
    <tr>
      <td align="center">跨区调货单</td>
    </tr>
  </table>
  <table width="480"  border="0" align="center" class="tcontent">
    <tr>
      <td width="19%" align="right"><input name="action" type="hidden" value="save">
        流水号：</td>
      <td width="85%"><input name="msellid" type="text" id="msellid"
       class="intra13" value="<%=msellid%>" size="22" maxlength="22" readonly>
          <input type="hidden" name="hiddenField">
          </td>
    </tr>
    <tr>
      <td align="right">调货单号：</td>
      <td><input name="msell" type="text" id="msell" value="<%=msell%>" class="intra13" size="22" maxlength="22">          </td>
    </tr>
    <tr>
      <td align="right">发货地：</td>
      <td>
        <input name="set_depotid" type="text" id="set_depotid" value="<%=set_depotid%>" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." disabled>
          <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" value="<%=sdptname%>" size="20" readonly>
          <input name="set_mchid" type="hidden" id="set_mchid" value="<%=set_mchid%>">
          <input name="sparentid" type="hidden" id="sparentid" value="<%=sparentid%>">
		  <input name="czid" type="hidden" id="czid" value="<%=czid%>">     </td>
    </tr>
    <tr>
      <td align="right">收货地：</td>
      <td>
        <input name="get_depotid" type="text" id="get_depotid" value="<%=get_depotid%>" size="22" maxlength="10" readonly>
        <input type="button" name="Submit" value="..." onClick="selectMD('msell');">
        <input name="edptname" type="text" class="tcontent" id="edptname" style="border:none;" value="<%=edptname%>" size="20" readonly>
		<input name="get_mchid" type="hidden" id="get_mchid" value="<%=get_mchid%>">
          <input name="eparentid" type="hidden" id="eparentid" value="<%=eparentid%>">
      </td>
    </tr>
    <tr>
      <td align="right">发货日期：</td>
      <td><input name="setdate" type="text" id="setdate" onFocus="setday(this)" value="<%=setdate%>" size="10" readonly></td>
    </tr>
    
    <tr>
      <td align="right">货运费用：</td>
      <td><label for="fmscash"></label>
      <input name="fmscash" type="text" id="fmscash" size="15" value="<%=fmscash%>" onBlur="j_renull(this,this.value)" /></td>
    </tr>
    <tr>
      <td align="right">付款方式：</td>
      <td>
        <input type="radio" name="fmstype" id="fmstype1" value="1" <% if fmstype=1 then response.Write("checked")%> >
        <label for="fmstype1">寄付</label>
        <input type="radio" name="fmstype" id="fmstype2" value="2" <% if fmstype="" or fmstype=2 then response.Write("checked")%> >
        <label for="fmstype2">到付</label></td>
    </tr>
    <tr>
      <td align="right">联系人：</td>
      <td><label for="fmsrname"></label>
      <input name="fmsrname" type="text" id="fmsrname" size="20" value="<%=fmsrname%>"></td>
    </tr>
    <tr>
      <td align="right">联系电话：</td>
      <td><label for="fmsmobtel"></label>
      <input type="text" name="fmsmobtel" id="fmsmobtel" value="<%=fmsmobtel%>"></td>
    </tr>
    <tr>
      <td align="right">收货地址：</td>
      <td><label for="fmsaddress"></label>
      <input name="fmsaddress" type="text" id="fmsaddress" size="50" value="<%=fmsaddress%>"></td>
    </tr>
    <tr>
      <td align="right">货运信息：</td>
      <td><label for="fmsinfo"></label>
      <textarea name="fmsinfo" id="fmsinfo" cols="45" rows="3"><%=fmsinfo%></textarea></td>
    </tr>
    <tr>
      <td align="right">备注：</td>
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
  msellid=trim(request.Form("msellid"))
  msell=trim(request.Form("msell"))
  get_depotid=trim(request.Form("get_depotid"))
  session("get_depotid")=get_depotid
  set_depotid=trim(request.Form("set_depotid"))
  session("set_depotid")=set_depotid
  get_mchid=trim(request.Form("get_mchid"))
  set_mchid=trim(request.Form("set_mchid"))
  sparentid=trim(request.Form("sparentid"))
  eparentid=trim(request.Form("eparentid"))
  setdate=trim(request.Form("setdate"))
  comment=trim(request.Form("comment"))
  czid=trim(request.Form("czid"))
  setdate=get_date(setdate)
	
  fmstype=trim(request.Form("fmstype"))
  fmscash=trim(request.Form("fmscash"))
  fmsinfo=trim(request.Form("fmsinfo"))
  fmsaddress=trim(request.Form("fmsaddress"))
  fmsmobtel=trim(request.Form("fmsmobtel"))
  fmsrname=trim(request.Form("fmsrname"))
	

   '同机构不能做跨区调拨，请做调拨单
   if get_mchid=set_mchid and sparentid=eparentid then
      str1="相同加盟商下的店铺不能做跨区调拨，请做调拨单!"
  	  response.write("<script language='javascript'>alert('"&str1&"');window.close();</script>")
	  response.end
   end if	  
   	
  sql="select * from d_msell where msellid ="& qts(msellid)
  ds.CursorType = 1
  ds.CursorLocation = 2
  ds.LockType = 3
  ds.source = sql
  ds.open
  if ds.eof then
    Call getGant("create",0,session("formid"))
    '保存新增
    ds.AddNew
	ds("msellid")=msellid
	ds("msell")=msell
	ds("noticeid")=czid
	session("noticeid")=czid
	ds("set_depotid")=set_depotid
	ds("set_mchid")=set_mchid
	ds("set_parentid")=sparentid
	ds("get_depotid")=get_depotid
	ds("get_mchid")=get_mchid
	ds("get_parentid")=eparentid
	ds("setdate")=setdate
	ds("set_comment")=comment
	ds("d_type")=0
	ds("setcr_name")=session("dm").System_UserName
	ds("setcr_date")=get_date(date)
	ds("crdate")=get_date(date)
	ds("setchk_sure")=0
	ds("set_sure")=0
	ds("getchk_sure")=0
	ds("get_sure")=0
	
'保存货运信息
	if fmstype<>"" then ds("fmstype") = fmstype
	if fmscash<>"" then ds("fmscash") = fmscash
	ds("fmsinfo") = fmsinfo
	ds("fmsaddress") = fmsaddress
	ds("fmsmobtel") = fmsmobtel
	ds("fmsrname") = fmsrname
    'ds("dtype") = 3
	
	'dtype=1 跨区调拨 代理商下面的加盟商的加盟店 把跨区调拨单的类型标记为1,其余标记为0
	'if set_mchid<>sparentid or get_mchid<>eparentid then
	'  ds("dtype") =1	  
	'else
	 ' ds("dtype") =0
	'end if
	
	ds("dtype") =0 
	ds.Update
	ds.close
	set ds=nothing
	session("noticeid")=""
 	'dtype=1 在跨区调拨那里，如果是代理商下面的直营店调给加盟店 把跨区调拨单的类型标记为1,其余标记为0
	
    'sql= "if exists (select 1 from j_depot where depotid ="&qts(set_depotid)&" and m_type=11)"&_
	'	  "	update a set a.dtype=1 from d_msell a,j_depot b,j_depot c "&_
	'	  "	where a.set_depotid=b.depotid   and a.get_depotid=c.depotid "&_
  	'	  " and ((b.unitid=c.parentid or b.parentid=c.unitid) and (c.unitid=c.parentid or b.unitid=b.parentid)"&_
    '      " or (c.unitid<>c.parentid and b.unitid<>b.parentid ))  and a.msellid="& qts(msellid)
  '	cn.execute sql
	'set cn=nothing
	
	response.Write("<script language='javascript'>")
	if bar="1" then
	  response.Write("window.location.href='ajax/2071_msell.asp?id="&msellid&"';")
	else
	response.Write("showModalDialog('f22_main.asp?id="&msellid&"&pksname=msell&opt=msell&numName=set_nums','es','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');")
	response.Write("window.location.href='search_frame.asp';")
	end if
	response.Write("</script>")
  else
    Call getGant("edit",0,session("formid"))
	ds("msell")=msell
	ds("set_depotid")=set_depotid
	ds("set_mchid")=set_mchid
	ds("set_parentid")=sparentid
	ds("get_depotid")=get_depotid
	ds("get_mchid")=get_mchid
	ds("get_parentid")=eparentid
	ds("setdate")=setdate
	ds("set_comment")=comment
	'ds("dtype") = 3
	'dtype=1 跨区调拨 代理商下面的加盟商的加盟店 把跨区调拨单的类型标记为1,其余标记为0
	if set_mchid<>sparentid or get_mchid<>eparentid then
	  ds("dtype") =1	  
	else
	  ds("dtype") =0
	end if
'保存货运信息 2009-02-17
	if fmstype<>"" then ds("fmstype") = fmstype
	if fmscash<>"" then ds("fmscash") = fmscash
	ds("fmsinfo") = fmsinfo
	ds("fmsaddress") = fmsaddress
	ds("fmsmobtel") = fmsmobtel
	ds("fmsrname") = fmsrname
	ds.update
	ds.close
    set ds=nothing
	
	'sql= "if not exists (select 1 from j_depot where depotid ="&qts(set_depotid)&" and m_type=11)"&_
	'	  "	update a set a.dtype=1 from d_msell a,j_depot b,j_depot c "&_
	'	  "	where a.set_depotid=b.depotid   and a.get_depotid=c.depotid "&_
  	'	  " and ((b.unitid=c.parentid or b.parentid=c.unitid) and (c.unitid=c.parentid or b.unitid=b.parentid)"&_
    '      " or (c.unitid<>c.parentid and b.unitid<>b.parentid ))  and a.msellid="& qts(msellid)
	'cn.execute sql	  
	if czid="notice" then
    	response.write("<script>alert('修改成功！');window.location.href='search_frame.asp';</script>")
	else
	    call close("修改成功!")
	end if
  end if
  
  
 
end sub%>
<%session("SPName")="f22_lrmsellsub"%>
<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
end if%>
<script language="javascript">
 window.dialogWidth="500px";
  window.dialogHeight="460px";
  //window.dialogLeft   X座标   
  //window.dialogTop   Y座标 
</script>
</body>
</html>
