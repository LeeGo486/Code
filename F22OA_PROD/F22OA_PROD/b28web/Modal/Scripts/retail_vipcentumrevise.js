$(function () {

    $("#btnsubmit").bind('click', e_submit);
    $("#btncancel").bind('click', e_cancel);
});



function e_submit() {
    if ($("#txtretailid").val() == "") {
        alert("请输入零售单号！");
        $("#txtretailid").focus();
        return false;
    }

    if ($("#txtvipcode").val() == "") {
        alert("请输入原老V卡号！");
        $("#txtvipcode").focus();
        return false;
    }

    if ($("#txtnewvipcode").val() == "") {
        alert("请输入现老V卡号！");
        $("#txtnewvipcode").focus();
        return false;
    }

    var data = { retailid: $("#txtretailid").val(),
        vipcode: $("#txtvipcode").val(),
        newvipcode: $("#txtnewvipcode").val()
    }

    $("#btnsubmit").attr("disabled", "disabled");
    $.ajaxWebService("Save", data, function (result) {
        var json = eval(result.d);
        alert(json[0].msg);
        if (json[0].success == 1) {
            $("#txtretailid").val('');
            $("#txtvipcode").val('');
            $("#txtnewvipcode").val('');
        }
        $("#btnsubmit").removeAttr("disabled", "disabled");
    });
}


function e_cancel() {
    $("#txtretailid").val('');
    $("#txtvipcode").val('');
    $("#txtnewvipcode").val('');
    $("#btnsubmit").removeAttr("disabled", "disabled");
}