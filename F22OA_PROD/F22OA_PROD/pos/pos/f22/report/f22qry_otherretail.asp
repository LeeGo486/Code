<%option explicit
Dim typ
typ=request.QueryString("typ")
if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
end if
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim t,rq1,rq2,userid,depotid,sql,act,tmp,tmp1,tmps,cd,wdl,lkc,wldc,cid,ds,tj,dtype,qrydaytj,qrydepottj
dim clothingid
clothingid=trim(request.QueryString("clothingid"))
rq1=trim(request.QueryString("rq1"))
rq2=trim(request.QueryString("rq2"))
depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
dtype=request("dtype")
if dtype="" then dtype="depot" end if

if rq1="" then rq1=get_date(date)
if rq2="" then rq2=get_date(date)%>
<%if cint(typ)<>2 then%>
<html>
<link href="css/report.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../inc/js/setday.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
  var querystring="<%=request.ServerVariables("QUERY_STRING")%>";
  function gtDoSelect(t){
  }

  function gtDoDblClick(t){
  <%if act<>3 then%>
	var row = t.getSelectedRow();
	var id2=row.cells[2].outerText;
	style(id2);
	<%end if%>
  }

  function gtDoEnter(t){}
  
function style(id){
  showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}

function open2(str){
showModalDialog(str,window,'dialogWidth:800px;dialogHeight:600px;center: yes;help:no;resizable:no;status:no');
}
</SCRIPT>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td><form name="form1" method="get" action="f22qry_otherretail.asp">
      日期：<input name="rq1" type="text" id="rq1" size="10" maxlength="10" value="<%=rq1%>" onFocus="setday(this);">
            <input name="rq2" type="text" id="rq2" size="10" maxlength="10" value="<%=rq2%>" onFocus="setday(this);">
      款式：<input name="clothingid" type="text" id="clothingid" size="10" maxlength="20" style="height:20px; " value="<%=clothingid%>">
	  汇总：<select name="dtype" size="1">
            <option value="depot" <%if dtype="depot" then response.write "selected=selected"%>>按店铺</option>
            <option value="style" <%if dtype="style" then response.write "selected=selected"%>>按款式</option>
            <option value="detail" <%if dtype="detail" then response.write "selected=selected"%>>按明细</option>
          </select>
    <input type="submit" value="重新查询"  onClick="document.all.form1.typ.value=1;">
	<input type="button" value="二维查询" onClick="open2('f22qry_otherretail2_seach.asp?styleid='+document.form1.clothingid.value+'&rq1='+document.form1.rq1.value+'&rq2='+document.form1.rq2.value+'&styleact=a')">
    <input type="button" value="按日期查询" onClick="open2('f22qry_otherretail_date_seach.asp?rq1='+document.form1.rq1.value+'&rq2='+document.form1.rq2.value)">
	<input type="hidden" name="typ" value="1">
	<input type="button" name="but" value="导出Excel" onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
	</form></td>
  </tr>
</table>
<%end if%>
<%'控制查询天数
if session("QryDay")>0 then
   qrydaytj=replace(session("QryDayTj"),"sure_date","a.sure_date")
end if

set t=new Table
t.Activeconnection = cn
		
	t.CommandType = 1
	if session("nozckc") then
	   tj=" and d.depotid not in (select depotid from j_depot where m_type in (0,1,80,90)) "
	else
	   tj=""
	end if
	
	if dtype="depot" then
	sql=" select a.depotid,max(d.d_name) as d_name,sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,webp_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 "&qrydaytj&_
		" and a.depotid "&session("QryDepotTj")&_
		" and a.depotid=d.depotid and d.unitid="&qts(session("dm").System_unitid)& _
		" and e.clothingid like '"&clothingid&"%' and d.userid='"&session("dm").System_Userid&"' "&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&_
		" and isnull(e.nums,0)<>0 "&tj&" group by a.depotid "&_
		" union all "&_
		" select a.depotid,max(d.d_name) as d_name,sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,j_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 and a.depotid=d.depotid "&qrydaytj&_
		
		" and a.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_retail=1) "& _
		" and e.clothingid like '"&clothingid&"%' and isnull(e.nums,0)<>0 "&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid order by a.depotid"
	t.SetField "depotid","店铺号","60",0
	t.SetField "d_name","店铺名","100",0
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1

    elseif dtype="style" then
	
	sql=" select a.depotid,max(d.d_name) as d_name,e.clothingid,max(e.styleid) as styleid,max(b.s_name) as s_name,"&_
	    " sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,j_style b,webp_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 and e.styleid=b.styleid "&qrydaytj&_
		" and a.depotid "&session("QryDepotTj")&_
		" and a.depotid=d.depotid and d.unitid="&qts(session("dm").System_unitid)& _
		" and e.clothingid like '"&clothingid&"%' and d.userid='"&session("dm").System_Userid&"' "&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&_
		" and isnull(e.nums,0)<>0 "&tj&" group by a.depotid,e.clothingid "&_
		" union all "&_
		" select a.depotid,max(d.d_name) as d_name,e.clothingid,max(e.styleid) as styleid,max(b.s_name) as s_name,"&_
	    " sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,j_style b ,j_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 and e.styleid=b.styleid and  a.depotid=d.depotid "&qrydaytj&_
		
		" and a.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_retail=1) "& _
		" and e.clothingid like '"&clothingid&"%' and isnull(e.nums,0)<>0 "&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid,e.clothingid order by a.depotid,e.clothingid"
		t.SetField "depotid","店铺号","60",0
		t.SetField "d_name","店铺名","100",0
		t.SetField "clothingid","款号","100",0
		t.SetField "styleid","款式编号","80",1
		t.SetField "s_name","款式名称","60",1
		t.SetField "nums","销售数量","80",1
		t.SetField "sums","销售金额","80",1
    else
	
	sql=" select a.depotid,max(d.d_name) as d_name,e.clothingid,max(e.styleid) as styleid,max(b.s_name) as s_name,"&_
	    " max(c.c_name) as c_name,sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,j_style b,j_color c,webp_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 and e.styleid=b.styleid and e.colorid=c.colorid "&_
		" and a.depotid "&session("QryDepotTj")&_
		" and a.depotid=d.depotid and d.unitid="&qts(session("dm").System_unitid)&qrydaytj& _
		" and e.clothingid like '"&clothingid&"%' and d.userid='"&session("dm").System_Userid&"' "&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' "&_
		" and isnull(e.nums,0)<>0 "&tj&" group by a.depotid,e.clothingid "&_
		" union all "&_
		" select a.depotid,max(d.d_name) as d_name,e.clothingid,max(e.styleid) as styleid,max(b.s_name) as s_name,"&_
	    " max(c.c_name) as c_name,sum(e.nums) as nums,sum(e.nums*e.s_price) as sums"& _
		" from d_retail a,j_style b,j_color c,j_depot d,d_retailsub e "& _
		" where a.retailid=e.retailid and isnull(a.sure,0)>0 and e.styleid=b.styleid and e.colorid=c.colorid and a.depotid=d.depotid "&_
	
		" and a.depotid in (select a.depotid from j_depot a,j_merchantsub b where a.unitid=b.depotid and b.merchantid='"&session("dm").System_unitid&"' and b.p_retail=1) "& _
		" and e.clothingid like '"&clothingid&"%' and isnull(e.nums,0)<>0 "&qrydaytj&_
		" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid,e.clothingid order by a.depotid,e.clothingid"
	t.SetField "depotid","店铺号","60",0
	t.SetField "d_name","店铺名","100",0
	t.SetField "clothingid","款号","100",0
	t.SetField "styleid","款式编号","80",1
	t.SetField "s_name","款式名称","60",1
	t.SetField "c_name","颜色","60",1
	t.SetField "nums","销售数量","80",1
	t.SetField "sums","销售金额","80",1
  end if
  t.CommandText=sql
 ' de sql
  t.height="86%"
  t.show
  set t=nothing
'de sql
set cn=nothing

%>
</div>
<%if cint(typ)<>2 then%>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
<%end if%>