$(function () {
    // events
    $("#btnsubmit").bind('click', e_submit);

    $("#txtvipcode").bind("keydown", function (e) {
        var key = e.which || e.keyCode;
        if (key == 13) {
            if ($("#txtvipcode").val() != "") {
                $("#txtmobtel").focus();
            }
        }
    });

    $("#txtmobtel").bind("keydown", function (e) {
        var key = e.which || e.keyCode;
        if (key == 13) {
            e_query();
        }
    });
    $("#btnsubmit").attr("disabled", "disabled");

});




function e_query() {
    if ($("#txtvipcode").val() == "") {
        alert("请输入原老V卡号！");
        $("#txtvipcode").focus();
        return false;
    }

    if ($("#txtmobtel").val() == "") {
        alert("请输入老VIP顾客手机！");
        $("#txtmobtel").focus();
        return false;
    }

    var data = {
        vipcode: $("#txtvipcode").val(),
        mobtel: $("#txtmobtel").val()
    }

    $.ajaxWebService("query", data, function (result) {
        var json = eval(result.d);
        //alert($.toJSON(json));
        if (json[0].msg != undefined) {
            alert(json[0].msg.replace('vipcode', $("#txtvipcode").val()));
        } else {
            if (json[0].mobtel != $("#txtmobtel").val()) {
                alert("您输入的老VIP信息有误！");
                return;
            } else {
                $("#txtvipname").val(json[0].vipname);
                $("#btnsubmit").removeAttr("disabled", "disabled");
            }
        }
    });
}


function e_submit() {
    window.returnValue = $("#txtvipcode").val();
    window.close();
    return;
}