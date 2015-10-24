/// JS名：Attendance.js
/// 说明：总部人员考勤登入
/// 创建人：郭琦琦 
/// 创建日期：2014-11-24
//初始化
var type = undefined;
var browser;
$(function () {

    //m_name =  Cookies.get("hzyapp.username");
    //m_name = "郭琦琦";
    //m_name = m_name.replace(/\d+/g, '');

    //判断ipad还是iphone
    //if (document.body.clientWidth > 700) {
    //    type = "ipad";
    //} else {
    //    type = "iphone";
    //}
    browser = browserRedirect();

    $('#UserName').focus();
});
function btndologin() {

    var UserName = $('#UserName').val();
    var Password = $('#Password').val();

    if (UserName == "" || UserName == undefined) {
        $("#login_msg").html("请输入员工号");
        return;
    }

    if (Password == "" || Password == undefined) {
        $("#login_msg").html("请输入密码");
        return;
    }

    if (UserName == "" || Password == "") {
        $("#login_msg").html("员工号和密码必须填写!");
        return;
    } else {
        $.messager.progress({ title: '请稍后', msg: '正在验证中' });
        var data = [];
        data[data.length] = { "name": "txtname", "value": UserName };
        data[data.length] = { "name": "txtpassword", "value": $.md5(Password) };

        var CheckDologin = $.ajax({
            url: GetWSRRURL('cc517737-703e-4228-93cd-937d9bc328e6') + "&XML=" + GetFormJson(data, 'CheckDologin'),
            type: 'post',
            async: false,
            onLoadSuccess: function () { $.messager.progress('close'); }
        });
        var dologinInfo = $.parseJSON(CheckDologin.responseText);
        if (dologinInfo.rows[0].c_oid == "" || dologinInfo.rows[0].c_oid == undefined) {
            $.messager.progress('close');
            $("#login_msg").html("验证失败!请输入正确的员工号和密码");
        }
        else {
            var c_oid = dologinInfo.rows[0].c_oid;
            var c_oid_user = dologinInfo.rows[0].c_oid_user;
            var c_idcard = dologinInfo.rows[0].c_idcard;
            var UserNameC = dologinInfo.rows[0].c_name;
            //window.location = "Attendance.HTML?r=" + Math.random() + "&sfz=" + c_idcard + "&namec=" + UserNameC + "&name=" + UserName + "&c_oid=" + c_oid + "&oid_user=" + c_oid_user + "&devicetype=" + browser;
            //window.location = "AttendanceMain.HTML?r=" + Math.random() + "&sfz=" + c_idcard + "&namec=" + UserNameC + "&name=" + UserName + "&c_oid=" + c_oid + "&oid_user=" + c_oid_user + "&devicetype=" + browser;
            $.cookie('sfz', c_idcard, { path: "/", expires: 1 * 1 });
            $.cookie('namec', UserNameC, { path: "/", expires: 1 * 1 });
            $.cookie('name', UserName, { path: "/", expires: 1 * 1 });
            $.cookie('c_oid', c_oid, { path: "/", expires: 1 * 1 });
            $.cookie('oid_user', c_oid_user, { path: "/", expires: 1 * 1 });
            $.cookie('devicetype', browser, { path: "/", expires: 1 * 1 });
            window.location = "AttendanceMain.HTML?r=" + Math.random();
        }
    }
}
function doReset() {
    $('#UserName').val("");
    $('#Password').val("");
}