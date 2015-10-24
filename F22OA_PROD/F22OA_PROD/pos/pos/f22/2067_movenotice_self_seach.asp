<%option explicit
session("formid")=2070%>
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
<script language="JavaScript" src="" id="aaa"></script>
<SCRIPT language="JavaScript">
var indentid="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	indentid=trim(row.cells[1].outerText);
}

function gtDoDblClick2(t){
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=movenotice','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}


function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=movenotice','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}


function gtDoEnter(t){
}
function mx(){
	if(indentid!=""){
	  showModalDialog('f22_mx.asp?id='+indentid+'&pksname=movenotice','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
	}else{
	  alert("请先选择通知单!");
	}
}
</script>
<base target="_self">
</head>

<body>
<table width="100%"  border="0" bgcolor="#FBFCFB" class="f12" >
<form name="form1" method="get" action="">
  <tr>
    <td>
	
	
	<input name="stype" type="radio" value="0" checked>所有&nbsp;&nbsp;
    <input type="radio" name="stype" value="1" <%if request.QueryString("stype")="1" then response.Write("checked")%>>指定日期&nbsp;&nbsp; 
    开始日期:<input name="sdate" type="text" id="sdate" value="<%=get_date(date()-30)%>" onFocus="setday(this);" size="8" tabindex="-1" readonly>&nbsp;&nbsp;
    结束日期:<input name="edate" type="text" id="edate" value="<%=get_date(date())%>" onFocus="setday(this);" size="8" tabindex="-1" readonly>&nbsp;&nbsp;
	 <input type="submit" name="Submit" value="查 询(S)" accesskey="s">
	 <input type="hidden" name="hiddenField">
   </td>
  </tr>
 
  </form>
</table>
<%dim t,t1,rq1,rq2,stype,UserId,ext,s,sql
rq1=trim(request.QueryString("sdate"))
rq2=trim(request.QueryString("edate"))
stype=trim(request.QueryString("stype"))
UserId=trim(session("dm").System_Userid)
if stype="" then
  stype=0
else
  stype=cint(stype)
end if

set t=new Table
  t.ActiveConnection = cn

     if stype=0 then
	    s=""
	 else
	    s=" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"'"
	 end if
	 
	  
	  t.CommandType = 1
		sql="SELECT case when isnull(cwpz,0)=10 then '完全没货' else "&_
             "case when isnull(cwpz,0)=20 then '部分有货' else "&_
             "case when isnull(cwpz,0)=30 then '已处理' else '处理中…' end end end as ctype "&_
		  ",a.noticeid,a.selltype,convert(char(10),a.setdate,126) as setdate,convert(char(10),a.getdate,126) as getdate,"&_
		  "a.chk_name,a.chk_date,a.sure_date,a.sure_name,"&_
          "(select sum(d.nums) from d_movenoticesub d where d.noticeid=a.noticeid) as nums,"&_
          "(select sum(d.nums*d.s_price1) from d_movenoticesub d where d.noticeid=a.noticeid) as sums,"&_
          "a.set_depotid,b.d_name as setdptname,a.get_depotid,c.d_name as getdptname,a.comment,a.chk_sure,a.sure "&_
          " from d_movenotice a,j_depot b,j_depot c  where  a.set_depotid=b.depotid and a.get_depotid=c.depotid "&_
		  " and a.d_type=2 "&_
          " and isnull(a.sure,0)>0  and a.get_depotid='"&session("dm").System_DepotID&"' "&s

	  t.commandText = sql
	  t.SetField "ctype","状态","60",2
	  t.SetField "noticeid","流水号","150",0
	  t.SetField "selltype","调拨类型","50",2
	  t.SetField "set_depotid","发货地","50",2	  
	  t.SetField "setdptname","发货地名称","80",2
	  t.SetField "get_depotid","收货地","50",2
	  t.SetField "getdptname","收货地名称","80",2
	  t.SetField "nums","数量","40",1
	  t.SetField "sums","金额","40",1
      t.SetField "setdate","调货日期","65",2
	  t.SetField "getdate","收货日期","65",2
	  t.SetField "comment","备注","190",2
	  t.CSureName="chk_sure"
      t.SureName="sure"
  't.IsAutoColor=False
  't.ColorField="phcnt"
  t.height="89%"
  t.Show
  set t=Nothing
  set cn=nothing
%>


</body>
</html>
