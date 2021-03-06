﻿
$(function () {

    $.ajax({
        url: GetLoginNameURL(),
        options: "JSON",
        success: function (data) {

            if (eval("[" + data + "]")[0].Error) {

            }
            else {
                var user = eval("[" + data + "]")[0].UserName;
                if (user && user != "") {
                    window.location.href = "main.html";

                }
                
            }
        }
    });

    setDialog();

    //进入页面，焦点在用户名文本框上
    $("#UserName").focus();
});

/**
* Ajax执行登录操作
* @return
*/
function doLogin() {

    //验证表单
    var isValid = $("#form_Login").form('validate');

    if ($("#UserName").val() == "") {
        $("#UserName").focus();
        $("#login_msg").html("用户名不能为空");
        return;
    }


    if ($("#Password").val() == "") {
        $("#Password").focus();
        $("#login_msg").html("密码不能为空");
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
            //var data = eval('(' + data + ')');
            if (data !=null && data.Result != null) {
                $("#login_msg").html("登录成功");
                window.location = "main.html";

                //郭琦琦增加IP进session
                htmlobj = $.ajax({
                    url: GetWSRRURL('Ip'),
                    options: "JSON",
                    async: false
                });
                var result = $.parseJSON(htmlobj.responseText);
                if (result.Ip != "") {
                    Ip = result.Ip;
                    $.cookie('m_ip', Ip, { path: "/", expires: 365 * 10 });
                };
                //m_ip = $.cookie('m_ip');


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
    $("#UserName").val("");
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
