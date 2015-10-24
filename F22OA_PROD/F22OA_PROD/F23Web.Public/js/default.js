$(function () {

    $("#logout").click(function () {
        var data = {};
        $.ajaxWebService("default.aspx/WriteLog", data, function (result) {
            var obj = result.d;
            if (obj.success == 1) {
                location.href = "login.aspx?act=logout";
            } else {
                alert(obj.msg);
            }
        });
    });
});

