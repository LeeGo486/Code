
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
                    window.location.href = "main_SPWX.html";

                }
                
            }
        }
    });

    init();
    //进入页面，焦点在用户名文本框上
    $("#UserName").focus();

    $("#doLogin").unbind('click')
        .bind('click',function () { doLogin(); });
    $("#doReset").unbind('click')
        .bind('click', function () { doReset(); });
    //回车事件
    $("#Password").textbox('textbox').bind('keydown', function (e) {
        if (e.keyCode == 13) {	// when press ENTER key, accept the inputed value.
            doLogin();
        }
    });
});



function init() {

    $("#UserName").textbox({
        type:'text',
        height:33,
        width:200,
        iconCls:'icon-man',
        iconAlign:'right',
        required: true
    });

    $("#Password").textbox({
        type:'password',
        height:33,
        width:200,
        iconCls:'icon-lock',
        iconAlign:'right',
        required: true
    });

    $("#doLogin").linkbutton({
        iconCls:'icon-ok',
        iconAlign:'left',
        size:'small'
    });

    $("#doReset").linkbutton({
        iconCls:'icon-undo',
        iconAlign:'left',
        size:'small'
    });
}







/**
* Ajax执行登录操作
* @return
*/
function doLogin() {
    
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

    $.messager.progress({ title: '请稍后', msg: '登录中' });

    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetLoginURL(), // 请求的action路径
        data: {
            "UserName": $("#UserName").textbox('getValue'),
            "Password": $("#Password").textbox('getValue')
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
                window.location = "main_SPWX.html";

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

            } else if (data != null && data.Error != null) {//后台异常处理
                
                $("#login_msg").html("错误，请联系信息管理部。");

                $("#UserName").textbox('setValue', "");
                $("#Password").textbox('setValue', "");
                $("#Password").focus();
            }
        }
    });
}

/**
* 执行reset操作
*/
function doReset() {
    $("#UserName").textbox('setValue', "");
    $("#Password").textbox('setValue', "");
    $("#login_msg").html("&nbsp;");
}

