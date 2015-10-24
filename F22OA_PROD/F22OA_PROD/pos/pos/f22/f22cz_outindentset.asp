<%option explicit
session("formid")=2064%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript" src="inc/abc.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var indentid="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	indentid=trim(row.cells[0].outerText);
}

function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	//showModalDialog('f22_mx.asp?id='+id+'&pksname=indent','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
	iq.location.href="f22cz_indent_d_quota.asp?action=cz_outindentCHK&id="+id;
}

function gtDoEnter(t){
}
function mx(){
	if(indentid!=""){
	  showModalDialog('f22_mx.asp?id='+indentid+'&pksname=outindentchk','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
	}else{
	  alert("请先选择单据,才能查看明细!");
	}
}
function create(){
	var a;
  if(indentid!=""){
	if(confirm("是否生成明细？"))   
    {  
	 a=0;
	}   
  else   
    {
		a=1;
	}   
 
    showModalDialog("f22_create_outfhd.asp?id="+indentid+"&istrue="+a,window,'dialogWidth:1px;dialogHeight:1px;dialogLeft:0px;dialogTop:0px;center: yes;help:no;resizable:yes;status:no;scroll:no;');
    //alert("f22_create_outfhd.asp?id="+indentid)
	if(confirm('操作完成,是否跳转到查询界面?')){ window.location.href='2065_index_2.asp?action=search&pagename=%B2%E9%D1%AF%CD%CB%BB%F5%B7%A2%BB%F5%B5%A5'} 
  }else{
    alert("请先选择审批单,才能根据该审批单生成发货单!");
  }
}
</script>
<base target="_self">
</head>

<body>
<%'call cbanner(" >> 根据审批单生成发货单")%>
<table width="100%"  border="0" bgcolor="#FBFCFB" class="f12" >
<form name="form1" method="get" action="">

  <tr>
    <td><input name="stype" type="radio" value="0" checked>
      所有单据</td>
    <td><input type="radio" name="stype" value="1" <%if request.QueryString("stype")="1" then response.Write("checked")%>>
      指定日期内单据</td>
    <td>开始日期:</td>
    <td><input name="sdate" type="text" id="sdate" value="<%=get_date(date()-30)%>" onFocus="setday(this);" size="10" tabindex="-1" readonly></td>
    <td>结束日期:</td>
    <td><input name="edate" type="text" id="edate" value="<%=get_date(date())%>" onFocus="setday(this);" size="10" tabindex="-1" readonly></td>
    <td><input type="submit" name="Submit" value="查询(S)" accesskey="s">
	<%if padd then%>
      <input type="button" name="Submit" value="生成退货发货单(C)" onClick="create();" accesskey="c">
	<%end if%>
      <input type="hidden" name="hiddenField">
      <input type="button" name="Submit" value="查看明细(M)" onClick="mx();"></td>
  </tr></form>
</table>
<%dim t,rq1,rq2,stype,UserId,ext,s,sql,ss
rq1=trim(request.QueryString("sdate"))
rq2=trim(request.QueryString("edate"))
stype=trim(request.QueryString("stype"))
UserId=trim(session("dm").System_Userid)
ext="4"
if stype="" then
  stype=0
else
  stype=cint(stype)
end if
set t=new Table
  t.ActiveConnection = cn
'  t.CommandType=4
'	  t.CommandText="webqry_outindentchk"
'      t.setParam "@rq1",adVarchar,30,rq1
'      t.setParam "@rq2",adVarchar,30,rq2
'      t.setParam "@userid",adVarchar,10,UserId
'      t.setParam "@type",adInteger,4,stype
'	  t.setParam "@worktype",adVarChar,20,ext
	  
	  t.CommandType = 1
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		
		if stype=0 then
		   ss=""
		else
		   ss=" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"'"
		end if
			
		select case ext
		case "0"
		  sql="select a.* "&s&" from d_outindentchk a where set_depotid="&qts(session("dm").System_depotid)
		case "1"
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case "2"
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case "3"
		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case "4"
		  sql="select a.* "&s&" from d_outindentchk a where isnull(ov_sure,0)=0 and isnull(sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)&ss
		end select
	  t.commandText = sql
	  'de sql
	  t.SetField "outindentid","退货单编号","140",2
	  t.SetField "set_depotid","发货地","80",0
	  t.SetField "setdptname","发货地名称","100",2
	  t.SetField "depotid","收货地","80",2
	  t.SetField "getdptname","收货地名称","100",2	  
	  t.SetField "sqnums","申请数量","50",1
	  t.SetField "chknums","审核数量","50",1
	  t.SetField "setnums","发货数量","50",1
	  t.SetField "getnums","收货数量","50",1
	  t.SetField "chk_name","审批人","50",2
	  t.SetField "chk_date","审批日期","80",2
      t.SetField "sure_name","登帐人","50",2
	  t.SetField "sure_date","登帐日期","80",2
	  t.SetField "comment","备注","80",2
	  t.SetField "backrate","正常退货","50",2
      t.SetField "outindent","申请单号","140",2
	  t.CSureName="chk_sure"
      t.SureName="sure"
  't.IsAutoColor=False
  't.ColorField="phcnt"
  t.Height="55%"
  t.Show
  set t=Nothing
  set cn=nothing
%>
</div>
<table width="100%" border="0" class="bar">
  <tr>
    <td>参照生成的退货发货单</td>
    <td>&nbsp;</td>
  </tr>
</table>
<iframe src="f22cz_indent_d_quota.asp" id="iq" name="iq" frameborder="0" height="30%" width="100%;"></iframe>
</body>
</html>
