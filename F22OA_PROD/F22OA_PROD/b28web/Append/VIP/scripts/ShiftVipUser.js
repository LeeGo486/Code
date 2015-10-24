$(function () {
    $("input[name='states']").click(function () {
        q_query();
    });
});

function q_query() {
    GridControl1.fnReloadAjax();
}

function e_edit() {
    var id = GetSheetID();
    if(id == undefined || id =="") return false;
    var m = $.openModal("ShiftVipUserEdit.aspx?id=" + id, "1000px", "500px");
    if (m) q_query();
}

function e_add() {
    var m = $.openModal("ShiftVipUserEdit.aspx?id=", "1000px", "500px");
    if (m) q_query();
}


function e_Sure() {
    if ($("#btnsure").hasClass("disabled")) return false;

    var id = GetSheetID();
    if (id == "" || id == undefined) {
        alert("请选择行!");
        return false;
    }
    if (!confirm("确认要提交申请吗,提交后将不能再修改!")) {
        return false;
    }
    var obj = { id: id };
    $.ajaxWebService("sure", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            var rows = GridControl1.fnGetSelected();
            GridControl1.fnDeleteRow(rows[0]);
        } else {
            alert(result.msg);
        }
    });

}

function dblclick() {
    e_edit();
}

function e_del() {
    if ($("#btndel").hasClass("disabled")) return false;
    var id = GetSheetID();
    if (id == "" || id == undefined) {
        alert("请选择行!");
        return false;
    }
    if (!confirm("确认需要删除吗?")) {
        return false;
    }

    var obj = { id: id };
    $.ajaxWebService("Delete", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            q_query();
        } else {
            alert(result.msg);
        }
    });
}


function grdSelected() {
    var id = GetSheetID();
    if (id == undefined || id == "") return false;
    $("#shiftid").val(id);
    GridControl2.fnReloadAjax();
}


function grdComplete() {

    var rows = GridControl1.fnGetNodes();
    var len = rows.length;
    if (len == 0) return;
    $(rows[0]).addClass('row_selected').siblings().removeClass('row_selected');
    grdSelected()
}