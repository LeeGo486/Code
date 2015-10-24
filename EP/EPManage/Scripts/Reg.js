$(document).ready(function () {
    $('#btnReg').click(function () {
        if ($('.modal-body #UserName').val().length == 0) {
            alert('用户名必须填写');
            return false;
        }
        if ($('.modal-body #Password').val().length == 0) {
            alert('密码必须填写');
            return false;
        }
        if ($('.modal-body #RealName').val().length == 0) {
            alert('真实姓名必须填写');
            return false;
        }
        var data = {
            username: $('.modal-body #UserName').val(),
            password: $('.modal-body #Password').val(),
            RealName: $('.modal-body #RealName').val()
        };
        $.post('/User/Reg', data, function (data) {
            if (data == "true") {
                alert('注册成功，请用您刚注册的账号密码进行登陆');
                $('#btnClose').click();
            }
            else {
                alert('注册失败，失败原因：' + data);
            }
        }).fail(function (data) { alert('注册失败，服务器返回错误'); });
    });
});