//
var getparams = getparams || function () {
    return $(".field").serializeObject();
}
//
function GetSheetID() {
    return GetSheetIdxVal(0);
}
//
function SetControllerState() {
    $('#btnquery').removeClass('disabled')
}
//
var e_add = e_add || function () {
    var id = GetSheetID();
    if (!id) return;
    if (GetSheetIdxVal(1) == "已处理") { alert("此通知单已经生成跨区调拨发货单,不能重复生成!"); return false; }
    if (!confirm("确定要生成跨调拨发货单吗?")) { return false; }
    var data = { id: id }
    $.ajaxWebService("Make", data, function (result) {
        var o = result.d || new Object();
        if (o.success > 0) {
            if (confirm("已生成跨区调拨发货单!单号:" + o.obj['id'] + ",是否跳转到查询界面?")) {
                window.returnValue = o.obj;
                window.close();
            } else {
                SetSheetIdxVal(1, "已处理");
                SetSheetIdxVal(2, o.obj["id"]);
            }
        } else {
            alert(o.msg);
        }
    });
}

// 取得选中的记录中的某列值
function GetSheetIdxVal(index) {
    return GridControl1.fnGetSelectedIds(index)[0]
}

function SetSheetIdxVal(index, val) {
    var rows = GridControl1.fnGetSelected();
    if (rows.length != 1) { return false; };
    var irow = GridControl1.fnGetPosition(rows[0]);
    GridControl1.fnUpdate(val, irow, index);
}

function e_noticedetail() {
    var id = GetSheetID();
    if (!id) return;
    var noticedetailurl = "NoticeDetail.aspx";
    $.openModal(noticedetailurl + '?id=' + id, '90%', '70%');
}

// 显示明细
function e_detail() {
    var id = GetSheetIdxVal(2);
    if (!id) return;
    $.openModal(detailurl + '?id=' + id, '90%', '70%');
}

var st = null;
function e_query() {
    if (st) window.clearTimeout(st);
    st = setTimeout(function () {
        GridControl1.fnReloadAjax();
    }, 300);
}
