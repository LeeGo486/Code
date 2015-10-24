var m_Url = "";
$(function () {
    var strEnvID = $.getUrlParam('EnvID');
    var strUserName = $.getUrlParam('UserName');
    var strPassWord = $.getUrlParam('PassWord');
    m_Url = $.getUrlParam('URL');

    if (strEnvID == null || strUserName == null || strPassWord == null) {
        alert("非法请求，请正常登录");
        setTimeout("Redirect('login.html')", 1000);
        return;
    }

    if (m_Url == null) {
        m_Url = "main.html";
    }

    $("#UserName").val(strUserName);
    $("#Password").val(strPassWord);

    doLogin();

});

function Redirect(pstrUrl) {
    window.location.href = pstrUrl;

}

/**
* Ajax执行登录操作
* @return
*/
function doLogin() {

    //验证表单
    var isValid = $("form_Login").form('validate');

    if (!isValid) {
        return;
    }

    //$("#login_msg").html("登录中，请稍后...");
    $.messager.progress({ title: '请稍后', msg: '登录中' });

    $.ajax({
        async: true,
        cache: false,
        type: 'POST',
        dataType: "json",
        url: GetWSRRURL('08d42db4-d2b3-4999-a3ea-8b4be8f2333e'), // 请求的action路径MD5
        //url: GetWSRRURL('550fc164-adc8-4f88-bc9d-73c4248050bc'), // 请求的action路径
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
            if (data.Result != null) {
                $("#login_msg").html("登录成功");

                setTimeout("Redirect('"+m_Url+"')", 1000);

            } else if (data.Error != null) {//后台异常处理
                alert(data.Error);
                setTimeout("Redirect('login.html')", 1000);

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



