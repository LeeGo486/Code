<!--#include file="inc/function.asp"-->
<%
act=trim(request("act"))
dim employeeid,oldgoupid,oldgoupname,oldPosition,oldPositionname,sql,optiongroup,optionposition
dim usedstatus,valid
dim YearGoal
employeeid=trim(request("employeeid"))
set ds=Server.CreateObject("ADODB.Recordset")
	ds.ActiveConnection = cn
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改职位、班次</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../../Scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
    function save() {
        var employeeid = $("#employeeid").val();
        var groupid = $("#groupid").val();
        var Position = $("#Position").val();
        var usedstatus = $("#usedstatus").val();
        var valid = $("#valid").val();
        var YearGoal = $("#txt_YearGoal").val();
        var reg = /^\d+(\.\d{0,2})?$/;
        if (!reg.test(YearGoal)) {
            alert("输入年销售目标金额错误，请重新输入");
            $("#txt_YearGoal").focus();
            return false;
        }
        var pram = "employeeid=" + employeeid + "&groupid=" + groupid + "&usedstatus=" + usedstatus + "&valid=" + valid + "&Position=" + Position + "&yeargoal=" + YearGoal;
        var m = showModalDialog('pos_employee_Edit_save.asp?'+pram, window, 'dialogWidth:300px;dialogHeight:350px;dialogLeft:500px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
        if (m != undefined && m == "1") {
            window.returnValue = "1";
            window.close();
        }
//        var obj = { "employeeid": employeeid, "groupid": groupid, "usedstatus": usedstatus, "valid": valid, "Position": Position, "dt": new Date() };
//        $.ajax({
//            url: "pos_employee_Edit_save.asp",
//            type: "post",
//            dataType: "html",
//            data: "Position="+Position+"&usedstatus="+usedstatus,
//            success: function (data) {
//                alert(data);
//                if (data == "1") {
//                    window.returnValue = "1";
//                    window.close();
//                }
//            }
//        });
    }

    function winclose() {
        window.close();
    }
</script>
</head>
<body>
<% 
    sql="select employeeid,names,Position,groupid,usedstatus,valid,isnull(YearGoal,0) YearGoal from j_employee where employeeid="&qts(employeeid)
    ds.Source = sql
	ds.open
    oldgoupid=ds("groupid")
    oldPosition=ds("Position")
    valid=ds("valid")
    usedstatus=ds("usedstatus")
    YearGoal=ds("YearGoal")
 %>
 <form id="form1">
    <table border="0" cellpadding="6" cellspacing="1" width="300px">
        <tr>
            <td colspan="2" align="center">
                <b>修改营业员职务、班次</b>
            </td>
        </tr>
        <tr><td width="120px" align="right">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
        <td><input type="text" disabled="disabled" id="employeeid" name="employeeid" value="<%=ds("employeeid") %>" /></td>
        </tr>
        <tr><td align="right">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</td><td><%=ds("names") %></td></tr>
        <%
            ds.close
            sql="select groupid,max(groupname) as groupname from jk_group group by groupid"
            ds.Source = sql
	        ds.open
            optiongroup=""
            dim cheed
            if not ds.eof then
                while not ds.eof
                    cheed=""
                    if oldgoupid=ds("groupid") then
                        oldgoupname=ds("groupname")
                        cheed="selected"
                    end if
                    optiongroup=optiongroup&"<option value='"&ds("groupid")&"' "&cheed&">"&ds("groupname")&"</option>"
                ds.movenext
                wend
            end if
            ds.close
         %>
          
        <tr><td align="right">班&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;次：</td><td><select id="groupid" name="groupid"><% response.Write optiongroup %></select></td></tr>
        <%
            sql="SELECT lookcode,lookname FROM j18_lookupsub WHERE lookupid=1006 order by lookcode "
            ds.Source = sql
	        ds.open
            optionposition=""
            if not ds.eof then
                while not ds.eof
                    cheed=""
                    if oldPosition<>"" then
                        if oldPosition=ds("lookname") then
                            oldPositionname=ds("lookname")
                            cheed="selected"
                        end if
                    end if
                    optionposition=optionposition&"<option value='"&ds("lookname")&"' "&cheed&">"&ds("lookname")&"</option>"
                ds.movenext
                wend
            end if
            ds.close
         %>
        <tr><td align="right">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：</td><td><select id="Position" name="Position"><% response.Write optionposition %></select></td></tr>
        <tr>
        <td align="right">年销售目标：</td>
        <td>
            <input type="text" class="YearGoal" id="txt_YearGoal" value="<%=YearGoal %>" style="width:80px"/>
        </td>
        </tr>
        <tr>
        <td align="right">是否提成：</td>
        <td>
            <select id="usedstatus" name="usedstatus">
            <option value="1" <% if usedstatus then response.Write "selected" end if %> >是</option>
            <option value="0" <% if usedstatus<>true then response.Write "selected" end if %>>否</option>
            </select>
        </td>
        </tr>
        <tr>
        <td align="right">是否在职：</td>
        <td>
            <select id="valid" name="valid">
            <option value="0" <% if valid<>true then response.Write "selected" end if %>>在职</option>
            <option value="1" <% if valid then response.Write "selected" end if %>>离职</option>
            </select>
        </td>
        </tr>
        <tr>
        <td colspan="2" align="center">
        <input type="button" value="提交" onclick="save()" />
        <input type="button" value="关闭" onclick="winclose()" />
        </td>
        </tr>
    </table>
    </form>
</body>
</html>



