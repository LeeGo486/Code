﻿
$(function () {
    //登陆div位置
    var winHeight = $(window).height();
    $("#login").css("top", (winHeight * 0.4));

    //按钮

    document.onkeydown = function (e) {
        var ev = document.all ? window.event : e;
        if (ev.keyCode == 13) {
            doLogin();
        };
    };
    $("#sumbit").click(doLogin);
    $("#clean").click(doReset);

    //设置焦点
    $("#UserName").focus();
});

/**
* Ajax执行登录操作
* @return
*/
function doLogin() {

    //验证表单
    if ($("#UserName").val() == "") {
        $("#UserName").focus();
        $("#login_msg").html("<span style=\"font-size:18px;\">用户名不能为空</span>");
        return;
    }

    if ($("#Password").val() == "") {
        $("#Password").focus();
        $("#login_msg").html("<span style=\"font-size:18px;\">密码不能为空</span>");
        return;
    }


    //$("#login_msg").html("登录中，请稍后...");
    $.messager.progress({ title: '请稍后', msg: '登录中' });

    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetLoginURL(), // 请求的action路径
        data: {
            "UserName": $("#UserName").val(),
            "Company": $("#environment").val(),
            "Password": $("#Password").val()
        },
        error: function () {// 请求失败处理函数
            $.messager.progress('close');

            alert(GetErrorMsg('E0001'));
        },
        onSubmit: function () {
        },
        success: function (data) { // 请求成功后处理函数。
            $.messager.progress('close');

            if (data != null && data.Result != null) {
                $("#login_msg").html("登录成功");

                $.cookie("compName", $("#environment").val(), { path: "/", expires: 365 * 10 });

                window.location = "Main_Hawk2.html";


            } else if (data != null && data.Error != null) {//后台异常处理
                $("#login_msg").html(data.Error);
                $("#Password").val("");
                $("#Password").focus();
            }
        }
    });
}

/**
* 执行reset操作
*/
function doReset() {
    $("#UserName").val("").focus();
    $("#Password").val("");
    $("#login_msg").html("&nbsp;");
}


/**--------------操作弹出框------------------**/
//设置弹出框的属性
function setDialog() {
    //$('#login').dialog({
    //    title: 'VEX系统集成平台 (WSRR & SSO & MDM)——用户登录',
    //    modal: true,         //模式窗口：窗口背景不可操作
    //    collapsible: true,  //可折叠，点击窗口右上角折叠图标将内容折叠起来
    //    resizable: true,    //可拖动边框大小
    //    closable: false     //不提供关闭窗口按钮
    //});
}
