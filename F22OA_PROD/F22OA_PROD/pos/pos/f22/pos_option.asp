<%session("formid")=6103061%>
<!--#include file="inc/function.asp"-->
<%dim depotid,userid
depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_userid)
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>设置营业员及班次</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../Scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
    function employeeEdit(employeeid) {
        var m = showModalDialog('pos_employee_Edit.asp?act=edit&employeeid=' + employeeid, window, 'dialogWidth:300px;dialogHeight:320px;dialogLeft:500px;dialogTop:200px;center: yes;help:no;resizable:yes;status:no');
        if (m!= undefined && m == "1") {
            alert("修改成功");
            window.location = "pos_option.asp?cid=0"
        }
    }

    $(function () {
        $(".YearGoal").keydown(function (e) {
            if (e.keyCode == 13) {
                var id = $(this).attr("id");
                var employeeid = id.split('_')[1];
                var yeargoal = $(this).val();
                saveYearGoal(id, employeeid, yeargoal);
            }
        });
    });

    function saveYearGoal(id,employeeid, yeargoal) {
        var mrg = /^\d+(\.\d{0,2})?$/;
        if (!mrg.test(yeargoal)) {
            alert("输入年销售目标金额错误，请重新输入");
            $("#" + id).focus();
            return false;
        }
        $.ajax({
            url: "pos_employee_Edit_save.asp",
            type: "post",
            dataType: "html",
            data: { "act": "saveYearGoal", "employeeid": employeeid, "yeargoal": yeargoal, "dt": new Date() },
            success: function (data) {
                if (data == "1") {
                    alert("年销售目标修改成功");
                }
            }
        });
    }
</script>
</head>
<style>
.f14{font-size:12px}
</style>
<body>
<table width="100%" border="0" class="bar">
  <tr>
    <td align="center">设置营业员及班次</td>
  </tr>
</table>
<table width="100%" border="0">
  <tr class="f14">
    <td>[<a href="pos_option.asp?cid=0">营业员</a>] 
	<!--[<a href="pos_option.asp?cid=1">班次</a>] --></td>
  </tr>
</table>

<%dim ds,sql,cid
cid=trim(request.queryString("cid"))
if cid="" then cid=0

	set ds=Server.CreateObject("ADODB.Recordset")
	ds.ActiveConnection = cn
	
select case cid
case 0
  call s_name
case 1
  call x_name
end select
set ds=nothing
%>
<%sub s_name()%>
<table width="100%" border="1" cellspacing="0" bordercolor="#EBD5D0" class="f14" bordercolorlight="#FFFFFF">
  <tr align="center">
    <td width="8%"><a href="pos_employee_add.asp">添加营业员</a></td>
    <td width="6%">编号</td>
    <td width="6%">姓名</td>
    <td width="6%">工号</td>
    <td width="6%">职务</td>
    <td width="4%">班次</td>
    <td width="4%">性别</td>
    <td width="8%">电话</td>
    <td width="6%">生日</td>
    <td width="6%">入职日期</td>
    <td width="18%">地址</td>
    <td width="8%">年销售目标</td>
    <td width="6%">是否在职</td>
    <td width="6%">是否提成</td>
  </tr>
  <%
	'sql="select * from j_employee where depotid="&qts(depotid)
    sql="select a.employeeid,a.names,a.Position,b.lookname Positionname,a.groupid,c.groupname,a.sex,a.telephone,"&_
        "a.birthday,a.workdate,a.[address],a.YearGoal,a.usedstatus,a.valid,job_number "&_
        "FROM j_employee a LEFT JOIN j18_lookupsub b ON a.Position=b.lookname AND b.lookupid=1006"&_
        "LEFT JOIN jk_group c ON a.groupid=c.groupid WHERE a.depotid="&qts(depotid)
	ds.Source = sql
	ds.open
	while not ds.eof%>
  <tr>
    <td>
    <%if pedit then%>
    <a href="pos_employee_add.asp?id=<%=ds("employeeid")%>&act=edit">修改</a>
		<%end if%>
    <%if pdel then%>
    <a href="pos_employee_save.asp?id=<%=ds("employeeid")%>&act=del">删除</a>
		<%end if%>    </td>

	<td><%=ds("employeeid")%></td>
    <td><a style="text-decoration:underline;color:Blue;cursor:pointer" onclick="employeeEdit('<%=ds("employeeid") %>')"><%=ds("names")%></a></td>
    <td><%=ds("job_number") %>&nbsp;</td>
    <td><%=ds("Positionname")%>&nbsp;<input type="hidden" id="hidp_<%=ds("employeeid")%>" value="<%=ds("Position")%>" /></td>
    <td><%=ds("groupname")%>&nbsp;<input type="hidden" id="hidg_<%=ds("employeeid")%>" value="<%=ds("groupid")%>" /></td>
    <td><%=ds("sex")%></td>
    <td><%=ds("telephone")%>&nbsp;</td>
    <td><%=ds("birthday")%>&nbsp;</td>
    <td><%=ds("workdate")%>&nbsp;</td>
    <td><%=ds("address")%>&nbsp;</td>
    <td><%=ds("YearGoal")%>&nbsp;</td>
   	<td align="center"><input type="checkbox" disabled="disabled" <%if ds("valid")<>true then%> checked="checked"<%end if%>/></td>
	<td align="center"><input type="checkbox" disabled="disabled" <%if ds("usedstatus") then%> checked="checked"<%end if%>/></td>

  </tr>
  <%ds.movenext
  wend
  ds.close
  %>
</table>
<%end sub%>
<%sub x_name()%>
<table width="100%" border="1" cellspacing="0" bordercolor="#EBD5D0" class="f14" bordercolorlight="#FFFFFF">
  <tr>
    <td>编号</td>
    <td>名称</td>
    <td><a href="pos_group_add.asp">添加班次</a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%sql="select groupid,max(groupname) as groupname from jk_group group by groupid"
  ds.source = sql
  ds.open
  while not ds.eof%>
  <tr>
    <td><%=ds("groupid")%></td>
    <td><%=ds("groupname")%></td>
    <td><a href="pos_group_save.asp?act=del&id=<%=ds("groupid")%>">删除</a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%ds.movenext
  wend
  ds.close
  %>
</table>
<%end sub%>
</body>
</html>
