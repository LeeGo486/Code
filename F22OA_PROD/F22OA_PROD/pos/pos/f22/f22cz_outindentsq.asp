<%option explicit
session("formid")=2165%>
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
  if(indentid!=""){
    showModalDialog("f22_create_outfhdsq.asp?id="+indentid,window,'dialogWidth:1px;dialogHeight:1px;dialogLeft:0px;dialogTop:0px;center: yes;help:no;resizable:yes;status:no;scroll:no;');
    //alert("f22_create_outfhd.asp?id="+indentid)
		//window.history.go(0)
  }else{
    alert("请先选择审批单,才能根据该审批单生成发货单!");
  }

}
</script>
<base target="_self">
</head>

<body>
<%
dim rq1,rq2,stype
stype=trim(request.QueryString("stype"))
if stype="" then
  stype=2
else
  stype=cint(stype)
end if
rq1=trim(request.QueryString("sdate"))
if rq1="" then rq1=get_date(date()-30)
rq2=trim(request.QueryString("edate"))
if rq2="" then rq2=get_date(date())

'call cbanner(" >> 根据审批单生成发货单")%>
<table width="100%"  border="0" bgcolor="#FBFCFB" class="f12" >
<form name="form1" method="get" action="">
  <tr>
    <td>
    <label for="stype1">
    <input name="stype" id="stype1" type="radio" value="0" <%if stype=0 then response.Write("checked")%>>
      所有
      </label>
      </td>
    <td>
    <label for="stype2">
    <input type="radio" id="stype2" name="stype" value="1" <%if stype=1 then response.Write("checked")%>>
      已生成单
      </label></td>
    <td><label for="stype3">
      <input type="radio" id="stype3" name="stype" value="2" <%if stype=2 then response.Write("checked")%>>
      未生成
    </label>
      </td>
    <td>开始日期：</td>
    <td><input name="sdate" type="text" id="sdate" value="<%=rq1%>" onFocus="setday(this);" size="9" tabindex="-1" readonly></td>
    <td>结束日期：</td>
    <td><input name="edate" type="text" id="edate" value="<%=rq2%>" onFocus="setday(this);" size="9" tabindex="-1" readonly></td>
    <td><input type="submit" name="Submit" value="查询" accesskey="s">
	<%if padd then%>
      <input type="button" name="Submit" value="生成退货发货单" onClick="create();"  style="width:100px;" accesskey="c">
	<%end if%>
      <input type="hidden" name="hiddenField">
      <input type="button" name="Submit" value="查看明细" onClick="mx();"></td>
  </tr></form>
</table>
<%dim t,UserId,ext,s,sql,ss,depotid,DepotName
depotid=trim(session("dm").System_depotid)
DepotName=trim(session("dm").System_DepotName)
UserId=trim(session("dm").System_Userid)
ext="4"
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
		sql="select a.outindentsqid, a.outindentsq, a.MerchantId, d.shutname, a.depotid,a.setdate,a.d_type,a.cr_name, a.selltype, "&_
			"a.cr_date, a.sq_tjcomment,a.set_depotid,a.parentid,a.sq_spsure,a.sq_spname,a.sq_spdate,a.sq_sure, "&_
			"a.sq_name,a.sq_date,'"&DepotName&"' as dptname,a.sq_tjsure,e.d_name,a.sq_tjname,a.sq_tjdate, "&_
			"(select count(*) from d_outindentset where d_outindentset.quotaid=a.outindentsqid) as cnt, "&_
			"(select sum(d_outindentsetsub.nums) from d_outindentsetsub,d_outindentset "&_
			"where d_outindentset.outindentid=d_outindentsetsub.outindentid and d_outindentset.quotaid=a.outindentsqid and d_outindentset.sure>0 ) as fhnums, "&_
			"(select sum(d_outindentsqsub.sq_nums) from d_outindentsqsub where d_outindentsqsub.outindentsqid=a.outindentsqid) as nums, "&_
			"(select sum(d_outindentsqsub.sq_nums*d_outindentsqsub.s_price) from d_outindentsqsub where d_outindentsqsub.outindentsqid=a.outindentsqid) as sums "&_
			" from d_outindentsq a "&_
			" left join j_merchant d on a.MerchantId=d.MerchantId "&_
			" left join j_depot e on a.depotid=e.depotid "&_
			" where isnull(a.sq_spsure,0)>0 and isnull(a.sq_tjsure,0)>0 and isnull(a.sq_sure,0)>0 and a.d_type=3 and isnull(a.ov_sure,0)<1 "&_
			" and a.set_depotid='"&depotid&"' "
			
'			" from d_outindentsq a left join v22p_setdepot c on a.set_depotid=c.depotid "&_
'			" left join j_merchant d on a.MerchantId=d.MerchantId "&_
'			" left join j_depot e on a.depotid=e.depotid "&_
'			" where a.sq_spsure>0 and a.sq_tjsure>0 and a.sq_sure>0 and a.d_type=3 and a.ov_sure<1 "&_
'			" and c.userid='"&UserId&"' and a.set_depotid='"&depotid&"' "

		   sql=sql&" and convert(char(10),a.sq_date,126) between  '"&rq1&"' and '"&rq2&"'"
			 
		if stype="1" then
		   sql=sql&" and (select count(*) from d_outindentset where d_outindentset.quotaid=a.outindentsqid)>0 "
		elseif stype="2" then
		   sql=sql&" and (select count(*) from d_outindentset where d_outindentset.quotaid=a.outindentsqid)=0 "
		else
		
		end if
'			
'		select case ext
'		case "0"
'		  sql="select a.* "&s&" from d_outindentchk a where set_depotid="&qts(session("dm").System_depotid)
'		case "1"
'		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
'		case "2"
'		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
'		case "3"
'		  sql="select a.* "&s&" from d_outindentchk a where  isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
'		case "4"
'		  sql="select a.* "&s&" from d_outindentchk a where isnull(ov_sure,0)=0 and isnull(sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)&ss
'		end select
	  t.commandText = sql
	 'de sql
	  t.SetField "outindentsqid","退货单编号","140",2
	  t.SetField "cnt","参照次数","50",2
	  t.SetField "MerchantId","机构编号","60",2
	  t.SetField "shutname","机构名称","100",2

	  t.SetField "set_depotid","发货地","60",2
	  t.SetField "dptname","发货地名称","100",2
	  t.SetField "depotid","收货地","60",2
	  t.SetField "d_name","收货地名称","100",2	 
	  t.SetField "selltype","退货类型","100",2	 
		
	  t.SetField "nums","审批数量","50",1
	  t.SetField "sums","审批金额","80",1
		 
	  t.SetField "sq_name","确认人","50",2
	  t.SetField "sq_date","确认日期","80",2
		
	  t.CSureName="sq_tjsure"
      t.SureName="sq_spsure"
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
