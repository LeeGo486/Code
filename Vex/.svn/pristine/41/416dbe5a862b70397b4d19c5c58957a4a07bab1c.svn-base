/// JS名：Attendance.jsm_sfz
/// 说明：总部人员考勤info
/// 创建人：郭琦琦 
/// 创建日期：2014-10-22
//初始化
var type = undefined;
var m_Nowyear;
var m_Lastyeay;
var m_month;
var m_name;//登入名字
var m_app;//获取所有审批人
var m_c_oid;//员工编号
var m_sfz;//身份证
var m_oid_user;//操作人
var m_approvedata = undefined;//获取审批数据
var checkedInfo = [];//审批数据
var m_usernamec;//姓名
$(function () {

    //m_name =  Cookies.get("hzyapp.username");
    //m_name = "郭琦琦";
    //m_name = m_name.replace(/\d+/g, '');

    //function getQueryString(name) {
    //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    //    var r = window.location.search.substr(1).match(reg);
    //    if (r != null) return unescape(r[2]); return null;
    //}
    //m_c_oid = getQueryString("c_oid");
    //m_sfz = getQueryString("sfz");
    //m_oid_user = getQueryString("oid_user");
    //m_usernamec = getQueryString("namec");
    //m_devicetype = getQueryString("devicetype");

    m_sfz = $.cookie('sfz');
    m_c_oid = $.cookie('c_oid');
    m_oid_user = $.cookie('oid_user');
    m_usernamec = $.cookie('namec');
    m_devicetype = $.cookie('devicetype');


    if ((m_sfz == "" || m_sfz == undefined) || (m_c_oid == "" || m_c_oid == undefined) || (m_devicetype == "" || m_devicetype == undefined)) {
        window.location = "AttendanceIndex.HTML";
    }

    //$.cookie('sfz', m_sfz, { path: "/", expires: 1 * 1 });
    //$.cookie('namec', m_usernamec, { path: "/", expires: 1 * 1 });
    //$.cookie('c_oid', m_c_oid, { path: "/", expires: 1 * 1 });
    //$.cookie('oid_user', m_oid_user, { path: "/", expires: 1 * 1 });
    //$.cookie('devicetype', m_devicetype, { path: "/", expires: 1 * 1 });

    type = m_devicetype;
    if (m_devicetype == "pc") {
        type = "ipad";
    }
    //type = "iphone";

    //获取时间,
    var nowDate = new Date();
    m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//去年
    m_month = nowDate.DateAdd('m', 0).format("MM");


    $("#ipad").hide();
    $("#iphone").hide();
    $("#" + type).show();
    $('input').val("");//清空所有input值

    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };
    data[data.length] = { "name": "txtsfz", "value": m_sfz };
    var m_appHt = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'ApplyInfo'),
        type: 'post',
        async: false
    });
    m_app = $.parseJSON(m_appHt.responseText);

});

//切换菜单栏
function btnClickMenu(myMenu) {

    $("#" + type + "OvertimeWork").hide();
    $("#" + type + "Holiday").hide();
    $("#" + type + "Business").hide();
    $("#" + type + "Attendance").hide();
    $("#" + type + myMenu).siblings('div').hide();
    $("#" + type + myMenu).show();
    $("#" + type + myMenu.substr(3, myMenu.length - 1)).show();
}

//切换类型
function btnChange(menu, style) {
    var myLabel = '#' + type + menu + style;
    $(myLabel).siblings().hide();//其他兄弟元素都隐藏
    $(myLabel).show();
    if (style.toUpperCase() == "APPROVE") {
        if (menu == "OvertimeWork") {
            overtimeInitGrid();//加载加班审批信息
        }
        else if (menu == "Holiday") {
            holidayInitGrid();//加载休假审批信息
        }
        else if (menu == "Business") {
            businessInitGrid()//加载公出审批信息
        }
        else if (menu == "Attendance") {
            initGird();//加载漏打卡审批信息
        }
    }

    selectOption(myLabel);//添加select下拉年月
};

//下拉年月值
function selectOption(style) {

    if (type == undefined) {
        alert("请请重新登入");
        return;
    } else {

        //动态添加年月
        var selyearObj = $(style + "year");
        var selmonthObj = $(style + "month");

        selyearObj.empty();
        selmonthObj.empty();

        selyearObj.append("<option >" + m_Lastyeay + "</option>");
        selyearObj.append("<option selected>" + m_Nowyear + "</option>");

        var value = new Array("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
        var text = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")

        for (var i = 0; i < 12; i++) {
            if (value[i] == m_month) {
                selmonthObj.append("<option value='" + value[i] + "' selected='selected'>" + text[i] + "</option>");
            } else {
                selmonthObj.append("<option value='" + value[i] + "'>" + text[i] + "</option>");
            }
        }
    }
    //默认附上最新的一月
   // $("#" + style + "month").val(m_month);
}


//切换审批人
//approve:审批人类型
//name：审批人名字
function changeAP(approve, name) {
    var $st1 = $("#" + type + approve);
    var $st1add = $("#" + type + name);

    var text1 = $st1.find("option:selected").val();   //获取Select选中项的Text一级审批人
    $st1add.empty();

    if (text1 == "0") {
        return;
    } else if (text1 == "1") {
        for (var i = 0; i < m_app.rows.length; i++) {
            if (m_app.rows[i].type == text1) {
                $st1add.append("<option value='" + m_app.rows[i].sjc_oid + "'>" + m_app.rows[i].sjc_name + "</option>");
            }
        }
    } else if (text1 == "2") {
        for (var i = 0; i < m_app.rows.length; i++) {
            if (m_app.rows[i].type == text1) {
                $st1add.append("<option value='" + m_app.rows[i].sjc_oid + "'>" + m_app.rows[i].sjc_name + "</option>");
            }
        }
    }
}

//全选或者全不选
function checkboxSelectALL(chkid, chkName) {
    if ($("#" + chkid).attr("checked")) {
        $("[name='" + chkName + "']").attr("checked", "true");//全选
    } else {
        $("[name='" + chkName + "']").removeAttr("checked");//取消全选
    }
}

//选择选中行
function btnSelectAPP(myCHK, myid) {

    var checked = [];
    checkedInfo = [];
    $("input[name='" + myCHK + "']:checkbox:checked").each(function () {
        checked.push($(this).val());
    });

    for (var i = 0; i < checked.length; i++) {
        var checkedid = checked[i];
        for (var p = 0; p < m_approvedata.rows.length; p++) {
            var checkedid1 = m_approvedata.rows[p][myid]; //c_approveflowid
            if (checkedid == checkedid1) {
                checkedInfo.push(m_approvedata.rows[p]);
            }
        }
    }
}

//自动计算休假时长
function autocalCulate(mytype) {
    var beginDate = $('#' + type + mytype + 'BeginDate').val();
    var beginTime = $('#' + type + mytype + 'BeginTime').val();
    var endDate = $('#' + type + mytype + 'EndDate').val();
    var endTime = $('#' + type + mytype + 'EndTime').val();
    if (beginDate == "" || beginTime == "" || endDate == "" || endTime == "") {
        return;
    }
    var begin = beginDate + " " + beginTime;
    var end = endDate + " " + endTime;

    var begintime_ms = Date.parse(new Date(begin.replace(/-/g, "/"))); //begintime 为开始时间  

    var endtime_ms = Date.parse(new Date(end.replace(/-/g, "/")));   // endtime 为结束时间  

    var ms = endtime_ms - begintime_ms;

    if (ms < 0) {
        alert("开始时间大于结束时间");
        return;
    }

    var hours = ms / 1000 / 3600;

    $('#' + type + mytype + 'Hours').val(parseInt(hours));
}


//*------------------------------------------------------------加班--------------------------------------------------------------*//
//加班查询
function btnovertimeWorkList() {
    //获取考勤数据
    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };

    var searchListData = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetOvertimeSearch'),
        type: 'post',
        async: false
    });
    var result = $.parseJSON(searchListData.responseText);
    //判断类型,动态添加table内容
    if (type == "ipad") {
        $("#" + type + "OvertimeWorkListTable").html("<thead><tr><th style='width: 150px;'>加班类型</th><th style='width:18%'>加班原因</th><th style='width:22%'>开始时间</th><th style='width:22%'>结束时间</th><th style='width:9%'>时长</th><th style='width:10%'>审批状态</th></tr></thead>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_attitemname + "</td><td>" + result.rows[i].c_reason_cn + "</td><td>" + result.rows[i].c_begindate +
                "</td><td>" + result.rows[i].c_enddate + "</td><td>" + result.rows[i].c_value +
                "</td><td>" + result.rows[i].c_applystatus + "</td></tr>";
            $("#" + type + "OvertimeWorkListTable").append(html);
        }
    } else {

        $("#" + type + "OvertimeWorkListTable").html("<thead><tr><th style='width:28%'>加班类型</th><th style='width:23%'>开始时间</th><th  style='width:23%'>结束时间</th><th style='width:20%'>审批状态</th></tr></thead>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_attitemname + "</td><td>" + result.rows[i].c_begindate +
                "</td><td>" + result.rows[i].c_enddate + "</td><td>" + result.rows[i].c_applystatus + "</td></tr>";
            //"<tr><th>" + result.rows[i].c_begindate + "</th><td style='word-wrap:break-word;word-break:break-all;text-align:right'><span >" + result.rows[i].c_enddate + "</span></td></tr>"
            $("#" + type + "OvertimeWorkListTable").append(html);
        }
    }
}

//加班申请
function btnovertimeWorkApply() {
    var myType = "#" + type + "OvertimeWorkApply";
    var Applytype = $(myType + 'Type').val();
    var reason = $(myType + 'Reason').val();
    var applyApproveType1 = $(myType + 'ApproveType1').val();
    var applyApproveName1 = $(myType + 'ApproveName1').val();
    var applyBeginDate = $(myType + 'BeginDate').val();
    var applyBeginTime = $(myType + 'BeginTime').val();
    var applyEndDate = $(myType + 'EndDate').val();
    var applyEndTime = $(myType + 'EndTime').val();
    var hours = $(myType + 'Hours').val();
    var remark = $(myType + 'Remark').val();

    if (Applytype == "0") {
        alert('请选择加班类型');
        return;
    }
    if (applyApproveType1 == "0" || applyApproveName1 == "") {
        alert('请选择一级审批人');
        return;
    }
    if (applyBeginDate == "" || applyBeginTime == "") {
        alert('请选择加班开始时间');
        return;
    }
    if (applyEndDate == "" || applyEndTime == "") {
        alert('请选择加班结束时间');
        return;
    }
    if (hours == "") {
        alert('请填写时长');
        return;
    }
    var applyBegin = applyBeginDate + " " + applyBeginTime;
    var applyEnd = applyEndDate + " " + applyEndTime;

    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            var data = [];
            data[data.length] = { "name": "txtsp1", "value": applyApproveName1 };//审批人员工编号
            data[data.length] = { "name": "txtc_oid", "value": m_c_oid };//员工号
            data[data.length] = { "name": "txtc_remark", "value": remark };//备注
            data[data.length] = { "name": "txtbegindate", "value": applyBegin };//开始时间
            data[data.length] = { "name": "txtenddate", "value": applyEnd };//结束时间
            data[data.length] = { "name": "txtc_value", "value": hours };//时长
            data[data.length] = { "name": "txtc_reason", "value": reason };//原因
            data[data.length] = { "name": "txtc_attitemid", "value": Applytype };//加班类型

            var XMLData = GetFormJson(data, 'ApplyOvertime');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                type: 'post',
                async: false, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message);
                            $("#t" + type + "OvertimeWorkApply").form('clear');
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    })
}

//审批加班
//加载已申请，但未审批的加班数据
function overtimeInitGrid() {
    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid }; //81505586

    var m_approve = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetApplyOvertime'),
        type: 'post',
        async: false
    });
    m_approvedata = $.parseJSON(m_approve.responseText);

    //判断类型,动态添加table内容
    if (m_approvedata.rows[0].c_applyid == "") {
        if (type == "ipad") {
            $("#" + type + "OvertimeWorkApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkovertime' onclick='checkboxSelectALL(&quot;chkovertime&quot;,&quot;chkovertime2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>加班开始时间</th><th style='width:30%;'>加班结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
        }
        else {
            if (type == "iphone") {
                $("#" + type + "OvertimeWorkApproveList").html("<thead><tr><th style='width: 5px;'><input type='checkbox' id = 'chkovertime' onclick='checkboxSelectALL(&quot;chkovertime&quot;,&quot;chkovertime2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>加班开始时间</th><th style='width:30%;'>加班结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            }
        }
    } else {
        if (type == "ipad") {
            $("#" + type + "OvertimeWorkApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkovertime' onclick='checkboxSelectALL(&quot;chkovertime&quot;,&quot;chkovertime2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>加班开始时间</th><th style='width:30%;'>加班结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td><input type='checkbox' name = 'chkovertime2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_begindate + "</td><td>" + m_approvedata.rows[i].c_enddate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "OvertimeWorkApproveList").append(html);
            }
        } else {
            $("#" + type + "OvertimeWorkApproveList").html("<tr><td style='width: 5px;'><input type='checkbox' id = 'chkovertime' onclick='checkboxSelectALL(&quot;chkovertime&quot;,&quot;chkovertime2&quot;)' ></td><th >员工姓名</th><th >开始时间</th><th>结束时间</th><th>审批状态</th></tr>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td><input type='checkbox' name = 'chkovertime2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td><span >" + m_approvedata.rows[i].c_begindate + "</span></td><td>" + m_approvedata.rows[i].c_enddate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "OvertimeWorkApproveList").append(html);
            }
        }
    }
}

//批量审批
function btnovertimeWorkApprove(approveType) {
    btnSelectAPP('chkovertime2', 'c_approveflowid');
    if (checkedInfo.length == "0") {
        return;
    }
    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            for (var k = 0; k < checkedInfo.length; k++) {
                var data = [];
                data[data.length] = { "name": "txtc_oid_overtimeapply", "value": checkedInfo[k].c_oid_overtimeapply };//申请流程号
                data[data.length] = { "name": "txtapplec_oid", "value": checkedInfo[k].c_empoid };//申请人员工号
                data[data.length] = { "name": "txtc_renewremark", "value": checkedInfo[k].c_remark };//备注
                data[data.length] = { "name": "txtc_approveflowid", "value": checkedInfo[k].c_approveflowid };//流程号
                data[data.length] = { "name": "txtc_oid", "value": m_c_oid };//审批人员工号
                data[data.length] = { "name": "txtm_oid_user", "value": m_oid_user };//员工编号(操作员)审批
                data[data.length] = { "name": "txtc_remark", "value": checkedInfo[k].c_remark1 };//审批备注
                data[data.length] = { "name": "txtovertimetype", "value": approveType };//审批类型
                var XMLData = GetFormJson(data, 'ApproveOvertime');
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                    type: 'post',
                    async: false, //同步,
                    data: { "XML": XMLData },
                    error: function () {
                        $.messager.progress('close');
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
            $.messager.progress('close');
            $.messager.alert("提示", "成功！", 'ok');
            overtimeInitGrid();
        }
    })
}



//*-----------------------------------------------------------休假-----------------------------------------------------------------*//
//休假申请
function btnHolidayApply() {
    var myType = "#" + type + "HolidayApply";
    var holiday = $(myType + 'Type').val();
    var year = $(myType + 'Year').val();
    var beginDate = $(myType + 'BeginDate').val();
    var beginTime = $(myType + 'BeginTime').val();
    var endDate = $(myType + 'EndDate').val();
    var endTime = $(myType + 'EndTime').val();
    var hours = $(myType + 'Hours').val();
    var approveType = $(myType + 'ApproveType1').val();
    var approveName = $(myType + 'ApproveName1').val();
    var reason = $(myType + 'Reason').val();
    var tmpEmp = $(myType + 'TmpName').val();
    var emergency = $(myType + 'Emergency').val();
    var remark = $(myType + 'Remark').val();

    if (holiday == "0") {
        alert("请选择考勤项目");
        return;
    }
    if (year == "") {
        alert("请填写年度");
        return;
    }
    if (beginDate == "" || beginTime == "") {
        alert("请填写开始时间");
        return;
    }
    if (endDate == "" || endTime == "") {
        alert("请填写结束时间");
        return;
    }
    if (hours == "") {
        alert("请填写休假时长");
        return;
    }
    if (approveType == "0" || approveName == "") {
        alert("请选择一级审批人");
        return;
    }

    var begin = beginDate + " " + beginTime;
    var end = endDate + " " + endTime;

    //验证该时段是否有休假
    var chkdata = [];
    chkdata[chkdata.length] = { "name": "txtc_oid", "value": m_c_oid };
    chkdata[chkdata.length] = { "name": "txtc_begintime", "value": begin };
    chkdata[chkdata.length] = { "name": "txtc_endtime", "value": end };

    var chkXmlData = GetFormJson(chkdata, 'CheckVacation');
    var chk = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
        type: 'post',
        data: { "XML": chkXmlData },
        async: false, //异步,
    });
    var myCHK = $.parseJSON(chk.responseText);
    if (myCHK.rows[0].count * 1 > 0) {
        //已有休假
        $.messager.progress("提示框", "该天已有休假安排");
    }
    else {
        var data = [];
        data[data.length] = { "name": "txtc_oid", "value": m_c_oid };
        data[data.length] = { "name": "txtsp1", "value": approveName };
        data[data.length] = { "name": "txtc_attitemoid", "value": holiday };
        data[data.length] = { "name": "txtc_year", "value": year };
        data[data.length] = { "name": "txtbegindate", "value": begin };
        data[data.length] = { "name": "txtenddate", "value": end };
        data[data.length] = { "name": "txtc_value", "value": hours };
        data[data.length] = { "name": "txtc_reason", "value": reason };
        data[data.length] = { "name": "txtc_principal", "value": tmpEmp };
        data[data.length] = { "name": "txtc_linkman", "value": emergency };
        data[data.length] = { "name": "txtc_remark", "value": remark };
        var XMLdata = GetFormJson(data, 'ApplyVacation');
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
            type: 'post',
            async: false, //异步,
            data: { "XML": XMLdata },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');
                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message);
                        $("#t" + type + "HolidayApply").form('clear');
                    }
                } catch (ex) {
                    $.messager.progress('close');

                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
        return false;
    }
}

//休假记录查询
function btnHolidayList() {
    //获取考勤数据
    var year = $('#' + type + 'HolidayListyear option:selected').text();
    var month = $('#' + type + 'HolidayListmonth option:selected').text();
    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };
    data[data.length] = { "name": "txtyear", "value": year };
    data[data.length] = { "name": "txtmonth", "value": month };

    var searchListData = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetVacationSearch'),
        type: 'post',
        async: false
    });
    var result = $.parseJSON(searchListData.responseText);
    //判断类型,动态添加table内容
    if (type == "ipad") {
        $("#" + type + "HolidayListTable").html("<thead><tr><th style='width:200px'>考勤项目</th><th style='width:20%'>申请日期</th><th style='width:20%'>开始时间</th><th style='width:20%'>结束时间</th><th style='width:20%'>休假原因</th></tr></thead>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_name + "</td><td>"+result.rows[i].c_applydate+"</td><td>" + result.rows[i].c_begintime +
                "</td><td>" + result.rows[i].c_endtime+"</td><td>"+result.rows[i].c_reason + "</td></tr>";
            $("#" + type + "HolidayListTable").append(html);
        }
    } else {

        $("#" + type + "HolidayListTable").html("<tr><th style='width:20%'>考勤项目</th><th style='width:25%'>开始时间</th><th style='width:25%'>结束时间</th></tr>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_name + "</td><td>" + result.rows[i].c_begintime +
                "</td><td>" + result.rows[i].c_endtime + "</td></tr>";
            //"<tr><th>" + result.rows[i].c_begindate + "</th><td style='word-wrap:break-word;word-break:break-all;text-align:right'><span >" + result.rows[i].c_enddate + "</span></td></tr>"
            $("#" + type + "HolidayListTable").append(html);
        }
    }
}

//休假审批
//加载已申请，但未审批的休假数据
function holidayInitGrid() {
    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };// 81505586

    var m_approve = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetApproveVacationInfo'),
        type: 'post',
        async: false
    });
    m_approvedata = $.parseJSON(m_approve.responseText);

    //判断类型,动态添加table内容
    if (m_approvedata.rows[0].c_approveflow == "") {
        if (type == "ipad") {
            $("#" + type + "HolidayApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkHoliday' onclick='checkboxSelectALL(&quot;chkHoliday&quot;,&quot;chkHoliday2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>加班开始时间</th><th style='width:30%;'>加班结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
        }
        else {
            if (type == "iphone") {
                $("#" + type + "HolidayApproveList").html("<thead><tr><th style='width: 5px;'><input type='checkbox' id = 'chkHoliday' onclick='checkboxSelectALL(&quot;chkHoliday&quot;,&quot;chkHoliday2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>开始时间</th><th style='width:30%;'>结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            }
        }
    } else {
        if (type == "ipad") {
            $("#" + type + "HolidayApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkHoliday' onclick='checkboxSelectALL(&quot;chkHoliday&quot;,&quot;chkHoliday2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>开始时间</th><th style='width:30%;'>结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td><input type='checkbox' name = 'chkHoliday2' value=" + m_approvedata.rows[i].c_oid_vocationapply + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_begintime + "</td><td>" + m_approvedata.rows[i].c_endtime + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "HolidayApproveList").append(html);
            }
        } else {
            $("#" + type + "HolidayApproveList").html("<tr><td style='width: 5px;'><input type='checkbox' id = 'chkHoliday' onclick='checkboxSelectALL(&quot;chkHoliday&quot;,&quot;chkHoliday2&quot;)' ></td><th >员工姓名</th><th>开始时间</th><th>结束时间</th><th>审批状态</th></tr>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td style='width: 5px;'><input type='checkbox' name = 'chkHoliday2' value=" + m_approvedata.rows[i].c_oid_vocationapply + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_begintime + "</td><td>" + m_approvedata.rows[i].c_endtime + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "HolidayApproveList").append(html);
            }
        }
    }
}

//批量审批
function btnHolidayApprove(approveType) {
    btnSelectAPP('chkHoliday2', 'c_oid_vocationapply');
    if (checkedInfo.length == "0") {
        return;
    }
    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            for (var k = 0; k < checkedInfo.length; k++) {
                var data = [];
                data[data.length] = { "name": "txtc_oid", "value": checkedInfo[k].c_oid_overtimeapply };//申请人编号
                data[data.length] = { "name": "txtc_remark", "value": checkedInfo[k].c_empoid };//审批备注
                data[data.length] = { "name": "txtm_oid_user", "value": checkedInfo[k].c_remark };//员工编号(操作员)审批
                data[data.length] = { "name": "txtc_approveflowid", "value": checkedInfo[k].c_approveflowid };//流程号
                data[data.length] = { "name": "txtc_oid_vocationapply", "value": m_c_oid };//休假申请流程号
                data[data.length] = { "name": "txtvacationtype", "value": approveType };//审批类型

                //approve(data, 'ApproveOvertime');
                var XMLData = GetFormJson(data, 'ApproveVacationInfo');
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                    type: 'post',
                    async: false, //同步,
                    data: { "XML": XMLData },
                    error: function () {
                        $.messager.progress('close');
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
            $.messager.progress('close');
            $.messager.alert("提示", "成功！", 'ok');
            holidayInitGrid();
        }
    })
}


//*--------------------------------------------------------------------公出-----------------------------------------------------*//
//公出申请
function btnBusinessApply() {
    var businessType = "#" + type + "BusinessApply";
    var beginDate = $(businessType + 'BeginDate').val();
    var beginTime = $(businessType + 'BeginTime').val();
    var endDate = $(businessType + 'EndDate').val();
    var endTime = $(businessType + 'EndTime').val();
    var approveType = $(businessType + 'Type1').val();
    var approveName = $(businessType + 'Name1').val();
    var remark = $(businessType + 'Remark').val();
    var days = $(businessType + 'Hours').val();
    var destname = $(businessType + 'Destname').val();
    var destination = $(businessType + 'Address').val();
    var address = $(businessType + 'Destaddress').val();
    var reason = $(businessType + 'Reason').val();
    var contactperson = $(businessType + 'ContactPerson').val();
    var contactphone = $(businessType + 'ContactPhone').val();
    var vehicle = $(businessType + 'Vehicle').val();
    var attitemid = $(businessType + 'Type').val();
    if (attitemid == "0") {
        alert("请选择公出项目");
        return;
    }
    if (approveType == "0" || approveName == "") {
        alert("请选择一级审批人");
        return;
    }
    if (beginDate == "" || beginTime == "") {
        alert("请填写公出开始时间");
        return;
    }
    if (endDate == "" || endTime == "") {
        alert("请填写公出结束时间");
        return;
    }
    var begin = beginDate + " " + beginTime;
    var end = endDate + " " + endTime;

    var chkData = [];
    chkData[chkData.length] = { "name": "txtc_oid", "value": m_c_oid };
    chkData[chkData.length] = { "name": "txtc_beginTime", "value": begin };
    chkData[chkData.length] = { "name": "txtc_endTime", "value": end };

    var chkXmlData = GetFormJson(chkData, 'CheckBusinessOut');
    var chk = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
        type: 'post',
        data: { "XML": chkXmlData },
        async: false, //异步,
    });
    var myCHK = $.parseJSON(chk.responseText);
    if (myCHK.rows[0].count * 1 > 0) {
        //已有出差
        $.messager.progress("提示框", "该天已有出差安排");
    }
    else {
        var data = [];
        data[data.length] = { "name": "txtc_oid", "value": m_c_oid };
        data[data.length] = { "name": "txtsp1", "value": approveName };
        data[data.length] = { "name": "txtc_remark", "value": remark };
        data[data.length] = { "name": "txtbegindate", "value": begin };
        data[data.length] = { "name": "txtenddate", "value": end };
        data[data.length] = { "name": "txtc_value", "value": days };
        data[data.length] = { "name": "txtc_attitemid", "value": attitemid };
        data[data.length] = { "name": "txtc_vehicle", "value": vehicle };
        data[data.length] = { "name": "txtc_reason", "value": reason };
        data[data.length] = { "name": "txtc_destname", "value": destname };
        data[data.length] = { "name": "txtc_destaddress", "value": address };
        data[data.length] = { "name": "txtc_destination", "value": destination };
        data[data.length] = { "name": "txtc_contactperson", "value": contactperson };
        data[data.length] = { "name": "txtc_contactphone", "value": contactphone };

        var XMLdata = GetFormJson(data, 'ApplyBusinessOut');
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
            type: 'post',
            async: false, //异步,
            data: { "XML": XMLdata },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');
                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message);
                        $("#t" + type + "HolidayApply").form('clear');
                    }
                } catch (ex) {
                    $.messager.progress('close');

                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
        return false;
    }
}

//公出审批
//加载已申请,但未审批的公出申请记录
function businessInitGrid() {
    var data = [];
    //data[data.length] = { "name": "txtc_oid", "value": '81505586' }; m_c_oid
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };

    var m_approve = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetApproveBusinessOutInfo'),
        type: 'post',
        async: false
    });
    m_approvedata = $.parseJSON(m_approve.responseText);

    //判断类型,动态添加table内容
    if (m_approvedata.rows[0].c_approveflowid == "") {
        if (type == "ipad") {
            $("#" + type + "BusinessApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkBusiness' onclick='checkboxSelectALL(&quot;chkBusiness&quot;,&quot;chkBusiness2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>开始时间</th><th style='width:30%;'>结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
        }
        else {
            if (type == "iphone") {
                $("#" + type + "BusinessApproveList").html("<thead><tr><th style='width: 5px;'><input type='checkbox' id = 'chkBusiness' onclick='checkboxSelectALL(&quot;chkBusiness&quot;,&quot;chkBusiness2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>开始时间</th><th style='width:30%;'>结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            }
        }
    } else {
        if (type == "ipad") {
            $("#" + type + "BusinessApproveList").html("<thead><tr><th><input type='checkbox' id = 'chkBusiness' onclick='checkboxSelectALL(&quot;chkBusiness&quot;,&quot;chkBusiness2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:30%;'>开始时间</th><th style='width:30%;'>结束时间</th><th style='width: 10%;'>审批状态</th></tr></thead>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td><input type='checkbox' name = 'chkBusiness2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_begindate + "</td><td>" + m_approvedata.rows[i].c_enddate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "BusinessApproveList").append(html);
            }
        } else {
            $("#" + type + "BusinessApproveList").html("<tr><td style='width: 5px;'><input type='checkbox' id = 'chkBusiness' onclick='checkboxSelectALL(&quot;chkBusiness&quot;,&quot;chkBusiness2&quot;)' ></td><th >员工姓名</th><th >开始时间</th><th>结束时间</th><th>审批状态</th></tr>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td style='width: 5px;'><input type='checkbox' name = 'chkBusiness2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_begindate + "</td><td>" + m_approvedata.rows[i].c_enddate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "BusinessApproveList").append(html);
            }
        }
    }
}

//批量审批
function btnBusinessApprove(approveType) {
    btnSelectAPP('chkBusiness2', 'c_approveflowid');
    if (checkedInfo.length == "0") {
        return;
    }
    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            for (var k = 0; k < checkedInfo.length; k++) {
                var data = [];
                data[data.length] = { "name": "txtc_oid", "value": checkedInfo[k].c_oid };//申请人编号
                data[data.length] = { "name": "txtc_remark", "value": checkedInfo[k].c_remark };//备注
                data[data.length] = { "name": "txtm_oid_user", "value": m_c_oid };//员工编号(操作员)审批
                data[data.length] = { "name": "txtapplec_oid", "value": "" };
                data[data.length] = { "name": "txtc_approveflowid", "value": checkedInfo[k].c_approveflowid };//流程号
                data[data.length] = { "name": "txtc_oid_outapply", "value": m_c_oid };//休假申请流程号
                data[data.length] = { "name": "txtbusinessouttype", "value": approveType };//审批类型

                //approve(data, 'ApproveOvertime');
                var XMLData = GetFormJson(data, 'ApproveBusinessOutInfo');
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                    type: 'post',
                    async: false, //同步,
                    data: { "XML": XMLData },
                    error: function () {
                        $.messager.progress('close');
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
            $.messager.progress('close');
            $.messager.alert("提示", "成功！", 'ok');
            businessInitGrid();
        }
    })
}

//公出查询
function btnBusinessList() {
    var year = $('#' + type + 'BusinessListyear option:selected').text();
    var month = $('#' + type + 'BusinessListmonth option:selected').text();

    var data = [];
    data[data.length] = { "name": "txtc_oid", "value": m_c_oid };
    data[data.length] = { "name": "txtyear", "value": year };
    data[data.length] = { "name": "txtmonth", "value": month };

    var searchListData = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetBusinessOutSearch'),
        type: 'post',
        async: false
    });
    var result = $.parseJSON(searchListData.responseText);
    //判断类型,动态添加table内容
    if (type == "ipad") {
        $("#" + type + "BusinessListTable").html("<thead><tr><th style='width:120px'>公出项目</th><th style='width:30%'>开始时间</th><th style='width:30%'>结束时间</th><th>出差地点</th></tr></thead>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_name + "</td><td>" + result.rows[i].c_begindate +
                "</td><td>" + result.rows[i].c_enddate + "</td><td>" + result.rows[i].c_destination + "</td></tr>";
            $("#" + type + "BusinessListTable").append(html);
        }
    } else {

        $("#" + type + "BusinessListTable").html("<tr><th>考勤项目</th><th>开始时间</th><th>结束时间</th><th>出差地点</th></tr>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_name + "</td><td>" + result.rows[i].c_begindate +
                "</td><td>" + result.rows[i].c_enddate + "</td><td>" + result.rows[i].c_destination + "</td></tr>";
            //"<tr><th>" + result.rows[i].c_begindate + "</th><td style='word-wrap:break-word;word-break:break-all;text-align:right'><span >" + result.rows[i].c_enddate + "</span></td></tr>"
            $("#" + type + "BusinessListTable").append(html);
        }
    }
}



//*---------------------------------------------------------------------出勤------------------------------------------------------*//
//提交申请漏打卡
function btnAdd() {

    //var inputname = $("#" + type + "add" + "inputname").val();
    //var sfz = $("#" + type + "add" + "sfz").val();
    var addDate = $("#" + type + "addDate").val();//申请时间

    var addDate1 = $("#" + type + "addDate1").val();//班次1
    var addDate2 = $("#" + type + "addDate2").val();//班次2
    if (addDate1 == "") {
        addDate1 = "";
    } else {
        addDate1 = addDate + " " + addDate1;
    }
    if (addDate2 == "") {
        addDate2 = "";
    } else {
        addDate2 = addDate + " " + addDate2;
    }

    var addcause = $("#" + type + "addcause").val();//申请原因
    var addchangeAP1 = $("#" + type + "addapprove1").val();//一级审批
    var addchangeAP2 = $("#" + type + "addapprove2").val();//二级审批
    if (addchangeAP1 == null) {
        addchangeAP1 = "";
    }
    if (addchangeAP2 == null) {
        addchangeAP2 = "";
    }
    var addremarks = $("#" + type + "addremarks").val();//备注

    if (addDate == "") {
        alert("请填写补签考勤时间!");
        return;
    }
    if (addDate2 == "" && addDate1 == "") {
        alert("请填写班段!");
        return;
    }
    if (addcause == "") {
        alert("请填写补签考勤原因!");
        return;
    } if (addchangeAP2 == "" && addchangeAP1 == "") {
        alert("请选择审批人!");
        return;
    }

    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            var data = [];
            data[data.length] = { "name": "txtname", "value": m_usernamec }//姓名
            data[data.length] = { "name": "txtadddate", "value": addDate }//申请时间
            data[data.length] = { "name": "txtadddate1", "value": addDate1 }//班次1
            data[data.length] = { "name": "txtadddate2", "value": addDate2 }//班次2
            data[data.length] = { "name": "txtaddcause", "value": addcause }//申请原因
            data[data.length] = { "name": "txtaddchangeap1", "value": addchangeAP1 }//一级审批
            data[data.length] = { "name": "txtaddchangeap2", "value": addchangeAP2 }//二级审批
            data[data.length] = { "name": "txtaddremarks", "value": addremarks }//备注
            data[data.length] = { "name": "txtc_oid", "value": m_c_oid }//员工号

            var XMLData = GetFormJson(data, 'ApplyEdit');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                type: 'post',
                async: false, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message);
                            $("#t" + type + "add").form('clear');
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    })
}

//查询考勤数据
function btnSearchList(searchType) {

    var year = $("#" + type + searchType + "year").val();
    var month = $("#" + type + searchType + "month").val();

    //获取考勤数据
    var data = [];
    data[data.length] = { "name": "txtyear", "value": year };
    data[data.length] = { "name": "txtmonth", "value": month };
    //data[data.length] = { "name": "txtname", "value": escape(m_usernamec) };
    data[data.length] = { "name": "txtsfz", "value": m_sfz };

    var searchListData = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetCheckWorkAttendance'),
        type: 'post',
        async: false
    });
    var result = $.parseJSON(searchListData.responseText);

    //判断类型,动态添加table内容
    if (type == "ipad") {
        $("#" + type + searchType + "Table").html("<thead><tr><th style='width: 200px;'>考勤日期</th><th style='width: 80%;'>考勤时间</th></tr></thead>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_cardrecorddate + "</td><td style='word-wrap:break-word;word-break:break-all;'>" + result.rows[i].c_cardrecordtime + "</td></tr>";
            $("#" + type + searchType + "Table").append(html);
        }
    } else {

        $("#" + type + searchType + "Table").html("<tr><th style='width: 40%' >考勤日期</th><th style='width: 55%%;'>考勤时间</th></tr>");

        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_cardrecorddate + "</td><td><span>" + result.rows[i].c_cardrecordtime + "</span></td></tr>";
            $("#" + type + searchType + "Table").append(html);
        }
    }
}

//查询漏打卡数据
function btnSearchFill(searchType) {

    var year = $("#" + type + searchType + "year").val();
    var month = $("#" + type + searchType + "month").val();

    //获取考勤数据
    var data = [];
    data[data.length] = { "name": "txtyear", "value": year };
    data[data.length] = { "name": "txtmonth", "value": month };
    data[data.length] = { "name": "txtname", "value": escape(m_usernamec) };
    data[data.length] = { "name": "txtsfz", "value": m_sfz };

    var searchFillData = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetMangeCardRecordInfo'),
        type: 'post',
        async: false
    });
    var result = $.parseJSON(searchFillData.responseText);

    //判断类型,动态添加table内容
    if (type == "ipad") {
        $("#" + type + searchType + "Table").html("<thead><tr><th style='width: 200px;'>补签考勤时间</th><th style='width:40%;'>状态</th><th style='width: 40%;'>原因</th></tr></thead>");
        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><td>" + result.rows[i].c_renewtimecardtime + "</td><td style='word-wrap:break-word;word-break:break-all;'>" + result.rows[i].c_status + "</td><td>" + result.rows[i].c_uncardrecordreason + "</td></tr>"

            $("#" + type + searchType + "Table").append(html);
        }
    } else {
        $("#" + type + searchType + "Table").html("<tr><th style='width: 50%;'>补签考勤时间</th><th style='width: 25%' >状态</th><th style='width: 25%'>原因</th></tr>");
        for (var i = 0; i < result.rows.length; i++) {
            var html = "";
            html = "<tr><th>" + result.rows[i].c_renewtimecardtime + "</th><td style='word-wrap:break-word;word-break:break-all;'><span >" + result.rows[i].c_status + "</span></td><td>" + result.rows[i].c_uncardrecordreason + "</td></tr>"
            $("#" + type + searchType + "Table").append(html);
        }
    }
    $("#" + type + searchType + "Table").resize;

}

//审批漏打卡
function initGird() {

    var data = [];
    data[data.length] = { "name": "txtoid", "value": m_c_oid };

    var m_approve = $.ajax({
        url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'GetApprove'),
        type: 'post',
        async: false
    });
    m_approvedata = $.parseJSON(m_approve.responseText);
    //判断类型,动态添加table内容
    if (m_approvedata.rows[0].c_approveflowid == "") {
        if (type == "ipad") {
            $("#" + type + "approvelist").html("<thead><tr><th ><input type='checkbox' id = 'checkbox1' onclick='checkboxSelectALL(&quot;checkbox1&quot;,&quot;checkbox2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:40%;'>补签考勤申请时间</th><th style='width: 30%;'>审批状态</th></tr></thead>");
        }
        else {
            if (type == "iphone") {
                $("#" + type + "approvelist").html("<thead><tr><th style='width: 5px;'><input type='checkbox' id = 'checkbox1' onclick='checkboxSelectALL(&quot;checkbox1&quot;,&quot;checkbox2&quot;)'></th><th>员工姓名</th><th>补签考勤申请时间</th><th>审批状态</th></tr></thead>");
            }
        }
    } else {
        if (type == "ipad") {
            $("#" + type + "approvelist").html("<thead><tr><th><input type='checkbox' id = 'checkbox1' onclick='checkboxSelectALL(&quot;checkbox1&quot;,&quot;checkbox2&quot;)'></th><th style='width: 200px;'>员工姓名</th><th style='width:40%;'>补签考勤申请时间</th><th style='width: 30%;'>审批状态</th></tr></thead>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td><input type='checkbox' name = 'checkbox2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_applydate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "approvelist").append(html);
            }
        } else {
            $("#" + type + "approvelist").html("<tr><td style='width: 5px;'><input type='checkbox' id = 'checkbox1' onclick='checkboxSelectALL(&quot;checkbox1&quot;,&quot;checkbox2&quot;)' ></td><th >员工姓名</th><th >申请时间</th><th>审批状态</th></tr>");
            for (var i = 0; i < m_approvedata.rows.length; i++) {
                var html = "";
                html = "<tr><td style='width: 5px;'><input type='checkbox' name = 'checkbox2' value=" + m_approvedata.rows[i].c_approveflowid + "></td><td>" + m_approvedata.rows[i].c_name + "</td><td>" + m_approvedata.rows[i].c_applydate + "</td><td>" + m_approvedata.rows[i].c_applystatus + "</td></tr>"
                $("#" + type + "approvelist").append(html);
            }
        }
    }
}

//批量审批
function btnBatAPP(appType) {

    btnSelectAPP('checkbox2', 'c_approveflowid');
    if (checkedInfo.length == "0") {
        return;
    }
    $.messager.confirm('提示框', "是否确定", function (e) {
        if (e) {
            for (var k = 0; k < checkedInfo.length; k++) {
                var data = [];
                data[data.length] = { "name": "txtapptype", "value": appType }//状态
                data[data.length] = { "name": "txtc_oid", "value": m_c_oid }//员工号81505586
                data[data.length] = { "name": "txtm_oid_user", "value": "82757372" }//员工编号(操作员)
                data[data.length] = { "name": "txtc_approveflowid", "value": checkedInfo[k].c_approveflowid }//流程号
                data[data.length] = { "name": "txtc_oid_renewcardsign", "value": checkedInfo[k].c_oid_renewcardsign }//审批流程号
                data[data.length] = { "name": "txtc_remark", "value": checkedInfo[k].c_remark }//备注
                data[data.length] = { "name": "txtc_renewremark", "value": checkedInfo[k].c_renewremark }//备注
                var XMLData = GetFormJson(data, 'Approve');
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6'),
                    type: 'post',
                    async: false, //同步,
                    data: { "XML": XMLData },
                    error: function () {
                        $.messager.progress('close');
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
            $.messager.progress('close');
            $.messager.alert("提示", "成功！", 'ok');
            initGird();
        }
    })
}
