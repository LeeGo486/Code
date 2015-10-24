


$(function () {

    changeThemeFun("metro-plm");
    $.ajax({
        url: GetLoginNameURL(),
        options: "JSON",
        success: function (data) {

            if (eval("[" + data + "]")[0].Error) {

            }
            else {
                var user = eval("[" + data + "]")[0].UserName;
                if (user && user != "") {
                    window.location.href = "Main_PLMAS.html?r=" + Math.random()

                }

            }
        }
    });

    //setDialog();

    //进入页面，焦点在用户名文本框上
    $("#UserName").focus();
});

/**
* Ajax执行登录操作
* @return
*/
function doLogin() {

    //验证表单 

    var isValid = $("form_Login").form('validate');
    if ($("#UserName").val() == "" || $("#Password").val() == "") {
        $("#login_msg").html("账号或密码不能为空");
        return;
    }
    if (!isValid) {
        return;
    }

    var m_zt = $('#zt').val();

    if (m_zt == "") {
        $("#login_msg").html("请选择环境");
        return;
    }

    $.cookie('m_zt', m_zt, { path: "/", expires: 365 * 10 });
    m_zt = $.cookie('m_zt');

    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetLoginURL(), // 请求的action路径
        data: {
            "UserName": $("#UserName").val(),
            "Password": $("#Password").val(),
            "zt": m_zt
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
            if (data != null && data.Result != null) {
                $("#login_msg").html("登录成功");
                window.location = "main_PLMAS.html?r=" + Math.random() + "&zt=" + $('#zt').val() + "";

                //郭琦琦增加中文名进session
                var htmlobj = $.ajax({
                    url: GetWSRRURL('m_UserNameC'),
                    options: "JSON",
                    async: false
                });
                var result = $.parseJSON(htmlobj.responseText);
                if (result.m_UserNameC != "") {
                    m_UserNameC = result.m_UserNameC;
                    $.cookie('m_UserNameC', m_UserNameC, { path: "/", expires: 365 * 10 });
                };

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
    $('#login').dialog({
        title: 'VEX系统集成平台 (WSRR & SSO & MDM)——用户登录',
        modal: true,         //模式窗口：窗口背景不可操作
        collapsible: true,  //可折叠，点击窗口右上角折叠图标将内容折叠起来
        resizable: true,    //可拖动边框大小
        closable: false     //不提供关闭窗口按钮
    });
}
