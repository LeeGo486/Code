

$(function () {
    $("#btnclose").click(function () { window.close(); });
    var id = $.QueryString().id;
    var importtype = $.QueryString().importtype;
    $("#selectType ").attr("value", importtype);
    $("#seltype").text($("#selectType").find("option:selected").text());

    $("#selectType").change(function () {
        $("#seltype").text($(this).find("option:selected").text());
        GridControl1.fnReloadAjax();
    });

    $("#id").val($.QueryString().id);


    $("#btnquery").click(function () {
        GridControl1.fnReloadAjax();
    });

    
});

//拷贝箱
function btnCopy() {
    var ids = GridControl1.fnGetSelectedIds();
    if (ids == "" || ids == undefined) {
        alert("请选中行！");
        return;
    }

    if (!confirm("确认拷贝选中箱吗?")) {
        return false;
    }

    var obj = { czid: $.QueryString().id, ids: ids.join(","), importtype: $.QueryString().importtype };
 
    $.ajaxWebService("BtnCopyBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            returnValue = true;
            window.close();
        } else {
            alert(m.msg);
        }
    });
}

function GetSheetID() {
    return GridControl1.fnGetSelectedIds()[0];
}
