
function q_query() {
    GridControl1.fnReloadAjax();
}

function e_sure() {
    var obj = {};
    obj.employeeid = $("#employeeid").val();
    obj.tz_name = $("#employeeid").find("option:selected").text();
    
    if (obj.employeeid == null || obj.employeeid == "") {
        alert("请选择客户经理！");
        return false;
    }


    var rows = GridControl1.fnGetNodes();
    var len = rows.length;

    if (len == 0) {
        alert("请添加需要修改的VIP客户！");
        return false;
    }

    if (!confirm("确认修改客户经理吗？")) return false;
    var ids = "";
    $.each(rows, function (i, o) {
        if (ids != "") ids += ",";
        ids += o.cells[0].innerText;
    });

    obj.ids = ids;

    $.ajaxWebService("sure", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            q_query();
        } else {
            alert(result.msg);
        }
    });
}


$(function () {
    $(".lindel").live("click", function () {
        $(this).parent().parent().addClass('row_selected').siblings().removeClass('row_selected');
        var rows = GridControl1.fnGetSelected();
        GridControl1.fnDeleteRow(rows[0]);
    });
});