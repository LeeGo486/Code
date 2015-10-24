function e_save() {
    var obj = $('.field').serializeObject();
    if (obj.setdepotid == undefined || obj.setdepotid == "") {
        alert("转出店铺不能为空！");
        return false;
    }

    if (obj.employeeid == undefined || obj.employeeid == "") {
        alert("入店铺客户经理不能为空！");
        return false;
    }

    var rows = GridControl1.fnGetNodes();
    var len = rows.length;

    if (len == 0) {
        alert("请添加需要转出的VIP客户！");
        return false;
    }

    obj.tz_name = $("#employeeid").find("option:selected").text();
    if (!confirm("确认提交申请吗？")) return false;

    var ids = "";
    $.each(rows, function (i, o) {
        if(ids !="") ids +=",";
        ids += o.cells[0].innerText;
    });

    obj.ids = ids;

    $.ajaxWebService("sure", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            returnValue = true;
            close();
        } else {
            alert(result.msg);
        }
    });



}

$(function () {
    $("#setdepotid").change(function () {
        var obj = { depotid: $(this).val() };
        $.ajaxWebService("GetEmployee", obj, function (result) {
            result = result.d || new Object();
            if (result.success > 0) {
                AddoptionSelect("#set_employeeid", "employeeid", "names", result.msg, true);
            } else {
                alert(result.msg);
            }
        });
    });

    $(".lindel").live("click", function () {
        $(this).parent().parent().addClass('row_selected').siblings().removeClass('row_selected');
         var rows = GridControl1.fnGetSelected();
         GridControl1.fnDeleteRow(rows[0]);
    });
});


function AddoptionSelect(SelectID, optValue, optText, json, AddFirst) {
    var DataArray = eval("(" + json + ")");
    $(SelectID).empty();

    if (AddFirst) {
        $(SelectID).append("<option value='' selected='selected'></option>");
    }

    $(DataArray).each(function (i, o) {
        $(SelectID).append("<option value='" + o[optValue] + "'>" + o[optText] + "</option>");
    });
}


function q_query() {
    GridControl1.fnReloadAjax();
}


