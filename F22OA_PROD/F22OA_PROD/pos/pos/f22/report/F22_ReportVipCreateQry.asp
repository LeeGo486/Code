<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<%
dim opt,stype,n,setdate,t,depotid,userid,sql,typ
typ=request("typ")
userid=trim(session("dm").System_userid)
depotid=trim(session("dm").System_depotid)
opt=trim(request("opt"))
begdate=trim(request("begdate"))
enddate=trim(request("enddate"))
if begdate="" then begdate= date()-1
if enddate="" then enddate=date()-1

if cint(typ)=2 then
  response.ContentType ="application/vnd.ms-excel"
  response.AddHeader "content-disposition", "attachment; filename=VIP会员建档率报表查询.xls" 
end if
%>
<% if cint(typ)<>2 then %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP会员建档率报表查询</title>
<link href="../css/f22.css" rel="stylesheet" type="text/css">
<link href="../css/gt.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>

    <script type="text/javascript">
        function btnquery() {
            var begdate = document.getElementById("begdate").value;
            var enddate = document.getElementById("enddate").value;

            var myDate = new Date();
            year = myDate.getFullYear();
            month = myDate.getMonth() + 1 < 10 ? "0" + (myDate.getMonth() + 1) : myDate.getMonth() + 1;
            day= myDate.getDate() <10 ? "0"+myDate.getDate() : myDate.getDate() ;
            var date = year + "-" + month + "-" + day;

            if (begdate >= date || enddate >= date) {
                alert("查询日期范围必须小于当天,请重新选择!");
                return false;
            }
            this.form.typ.value = 1;
            this.disabled = true;
            this.value = '请稍等...'; 
            this.form.submit()
        }
    </script>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP会员建档率报表查询</td>
  </tr>
</table>
<table width="100%" border="0">
<form name="form1" method="post" action="">
<input type="hidden" value="1"  name="typ" id="typ" />
  <tr>
    <td>
    开始日期：
  <input name="begdate" type="text" id="begdate" onFocus="setday(this);" 
  onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" 
  onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=get_date(begdate)%>" size="10" maxlength="10" readonly>

  结束日期：<input name="enddate" type="text" id="enddate" onFocus="setday(this);" 
  onKeyPress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" 
  onKeyDown="if(event.keyCode==13)event.keyCode=9" value="<%=get_date(enddate)%>" size="10" maxlength="10" readonly>
 
    &nbsp;<input type="submit" class="btn" name="subm" value=" 查 询 "
     onClick="btnquery();" />
		<%if pexport then%>
    <input name="button3" type="button" class="btn" id="button3" value="导出Excel"
     onClick="document.all.form1.typ.value=2;document.all.form1.submit();">
		<%end if%>
  </td>
  </tr>
</form>
</table>
<%end if%>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
  sql = "F22_ReportVipCreateQry '"&begdate&"','"&enddate&"','"&userid&"','"&depotid&"'"
	t.CommandText=sql
	t.CommandType = 1
	t.SetField "depotid","店铺编号","80",3
	t.SetField "d_name","店铺名称","100",0
	t.SetField "zlscnt","总零售单数","100",1
	t.SetField "oldcnt","老会员消费单数","120",1
	t.SetField "newcnt","新会员消费单数","120",1
	t.SetField "jdl","建档率","80",4
	t.height="90%"
	t.show
	set t=nothing
set cn=nothing

%>
<% if cint(typ)<>2 then %>
<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</div>
</body>
</html>
<% End If %>
