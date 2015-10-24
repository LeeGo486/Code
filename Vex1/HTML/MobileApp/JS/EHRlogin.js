/// JS名：Attendance.js
/// 说明：总部人员考勤登入
/// 创建人：郭琦琦 
/// 创建日期：2014-12-25
var type = undefined;
var browser;

$(function () {
    //登入
    //browser = browserRedirect();

    $("#btnSubmit").click(function () {
        if ($.trim($("#UserName").val()).length <= 0) {
            $("#UserName").focus();
            Msg.show('请输入员工号!', 1);
            return;
        }
        if ($.trim($("#password").val()).length <= 0) {
            $("#password").focus();
            Msg.show('请输入密码!', 1);
            return;
        }

        $(this).button("loading");
        Msg.show("加载中...", 3);

        var data = [];
        data[data.length] = { "name": "txtname", "value": $("#UserName").val() };
        data[data.length] = { "name": "txtpassword", "value": $.md5($("#password").val()) };

        var CheckDologin = $.ajax({
            url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'CheckDologin'),
            type: 'post',
            async: false,
            onLoadSuccess: function () {
                Msg.hide();
                $("#btnSubmit").button("reset");
            },
            error: function () {
                Msg.hide();
                $("#btnSubmit").button("reset");
                Msg.show("请求异常！", 1);
            }
        });
        var dologinInfo = $.parseJSON(CheckDologin.responseText);
        if (dologinInfo.rows[0].c_oid == "" || dologinInfo.rows[0].c_oid == undefined) {
            Msg.show("密码或者员工号错误！", 1);
            Msg.hide();
            $("#btnSubmit").button("reset");
        }
        else {
            Msg.hide();
            $("#btnSubmit").button("reset");

            var c_oid = dologinInfo.rows[0].c_oid;
            var c_oid_user = dologinInfo.rows[0].c_oid_user;
            var c_idcard = dologinInfo.rows[0].c_idcard;
            var UserNameC = dologinInfo.rows[0].c_name;
            $.cookie('sfz', c_idcard, { path: "/", expires: 1 * 1 });
            $.cookie('namec', UserNameC, { path: "/", expires: 1 * 1 });
            $.cookie('name', UserName, { path: "/", expires: 1 * 1 });
            $.cookie('c_oid', c_oid, { path: "/", expires: 1 * 1 });
            $.cookie('oid_user', c_oid_user, { path: "/", expires: 1 * 1 });
            $.cookie('devicetype', browser, { path: "/", expires: 1 * 1 });
            alert("验证成功");
            window.location = "../PointToPoint/AttendanceMain.HTML?r=" + Math.random();
        }
    });
});