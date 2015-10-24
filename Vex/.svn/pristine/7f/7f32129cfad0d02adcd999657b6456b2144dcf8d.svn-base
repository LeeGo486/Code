
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

    $.messager.progress({ title: '请稍后', msg: '登录中' });

    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetWSRRURL('81093d5a-0ef6-4c70-9a89-0ec8f3160a9c'), // 请求的action路径
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
            if (data.Result != null) {
                $("#login_msg").html("登录成功");
                window.location = "main.html";
            } else if (data.Error != null) {//后台异常处理
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
    //$('#login').panel({
    //    width: 500,
    //    height: 150,
    //    title: 'MyPanel'
    //});
}

function SetTextBoxStyle(text) {


    var txtTextBox = $(text);

    if (txtTextBox.val() != "") {
        $(txtTextBox).css("backgroundImage", "");
    }
    else {
        if (txtTextBox.attr("id") == "UserName") {
            $(txtTextBox).css("backgroundImage", "url('../../image/username.png')");
        }
        else {
            $(txtTextBox).css("backgroundImage", "url('../../image/password.png')");
        }

    }

}