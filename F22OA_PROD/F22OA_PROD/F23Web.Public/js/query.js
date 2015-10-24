/* 查询界面通用脚本 */
/* Author : jackie 2010-08-23 创建 */
//
var editurl = editurl || "sheetedit.aspx";           //编辑
var barcodeurl = barcodeurl || "barcode.aspx";  //条码录入
var detailurl = detailurl || "detail.aspx";     //显示明细
var noticeurl = noticeurl || "notice.aspx";     //通知单

var st = null, qtimer = null, rsTimer;
$(function() {
    $(document).bind('keydown', 'up', function() {
        var i = fnGetSelectedRowIndex();
        fnSelectRow(i - 1);
        return false;
    }).bind('keydown', 'down', function() {
        var i = fnGetSelectedRowIndex();
        fnSelectRow(i + 1);
        return false;
    }).bind('keydown', 'left', function() {
        var s = $('.dataTables_scrollBody').scrollLeft();
        $('.dataTables_scrollBody').scrollLeft(s - $(window).width() / 2);
        return false;
    }).bind('keydown', 'right', function() {
        var s = $('.dataTables_scrollBody').scrollLeft();
        $('.dataTables_scrollBody').scrollLeft(s + $(window).width() / 2);
        return false;
    });
});
//

var getparams = getparams || function() {
    return $(".field").serializeObject();
}

var SetControllerState = SetControllerState || function() {
    var v = $('input:radio[name="status"]:checked').val();
    v = parseFloat(v) || 0;
    var rows = GridControl1.fnGetSelected();
    var btns = $('.st_field').addClass('disabled');

    if (rows.length > 0) {
        $((v == 0 ? '.st_edit' : v == 1 ? '.st_chk' : '.st_sure') + ',.st_all').removeClass('disabled');
    }
    if (v == 2) {
        $('#dtype,#begdate,#enddate').removeAttr('disabled');
    } else {
        $('#dtype,#begdate,#enddate').attr('disabled', 'disabled');
    }
}

// 单据列表
var e_query = e_query || function() {
    setTimeout(function() { GridControl1.fnReloadAjax() }, 0);
}
// 显示明细
var e_detail = e_detail || function() {
    var id = GetSheetID();
    if (!id) return;

    $.openModal(detailurl + '?id=' + id, '80%', '80%');
}

// 条码录入
var e_barcode = e_barcode || function() {
    var id = GetSheetID();
    if (!id) return;
    var m = $.openModal(barcodeurl + '?id=' + id, '80%', '80%');
    if (m) {
        //self.location.href = self.location.href + '&__=' + (new Date()).valueOf();
    }
}

var e_notice = e_notice || function() {
    var obj = $.openModal(noticeurl, '80%', '80%');
    if (obj != undefined) { e_added(obj); }
}

//// 取得指定字段所在位置
//function getColumnIndex(fieldname) {
//    var h = $('#queryTable thead tr:last');
//    return h.find('th').index(h.find('th[name="' + fieldname + '"]'));
//}

//// 选仓店
//var e_seldepot = e_seldepot || function() {
//    var obj = $.openModal('../public/DepotMultiSelector.aspx', '580px', '480px');
//    if (obj) {
//        e_query();
//    }
//}

// --------------------------------------
//   单据基本操作（增加、删除、修改）
// --------------------------------------
var e_add = e_add || function() {
    var obj = $.openModal(editurl, '90%', '80%');
    e_added(obj)
}

// 删除
var e_delete = e_delete || function() {
    if ($('#btndel').hasClass('disabled')) return;
    var rows = GridControl1.fnGetSelected();
    var obj = { id: GetSheetID() };
    if (!obj.id) return;
    if (!confirm('确定要删除吗？')) return;

    $.ajaxWebService("Delete", obj, function(result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            e_deleted(rows[0]);
        } else {
            alert(m.msg);
        }
    });
}
// 编辑
var e_edit = e_edit || function() {
    if ($('#btndel').hasClass('disabled')) return;
    var id = GetSheetID();
    if (!id) return;
    var obj = $.openModal(editurl + '?id=' + id, '90%', '70%');
    e_updated(obj);
}
// --------------------------------------
//   事件：增删改后触发的事件（行的操作）
// --------------------------------------
// 添加完成
var e_added = e_added || function(obj) {
if (!obj) { return; }
    
    var _d = [];
    $.each(GridControl1.fnSettings().aoColumns, function(i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o);
    });
    var i = GridControl1.dataTable().fnAddData(_d);
    fnSelectRow(i);
}
// 更新完成
var e_updated = e_updated || function(obj) {
    if (!obj) { return; }
    var rowindex = fnGetSelectedRowIndex();
    var _d = [];
    $.each(GridControl1.fnSettings().aoColumns, function(i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o);
    });

    GridControl1.fnUpdate(_d, rowindex);
}
// 取得列的位置
function fnGetColumnIndex(sName) {
    var idx = -1;
    $.each(GridControl1.fnSettings().aoColumns, function(i, o) {
        if (o.sName == sName) { idx = i; return false; }
    });
    return idx;
}

// 取得所选列的位置
function fnGetSelectedRowIndex() {
    var idx = -1;
    var aTrs = GridControl1.fnGetNodes();
    for (var i = 0; i < aTrs.length; i++) {
        if ($(aTrs[i]).hasClass('row_selected')) {
            idx = i; break;
        }
    }
    return idx;
}
// 取得单号
function GetSheetID() {
    return GridControl1.fnGetSelectedIds()[0];
}
// 
function fnSelectRow(i) {
    var rows = GridControl1.fnGetNodes();
    if (i >= rows.length) { i = rows.length - 1; }
    if (i < 0) { return; }
    $(rows).removeClass('row_selected');
    $(rows[i]).addClass('row_selected');
}

// 删除完成
var e_deleted = e_deleted || function(obj) {
    if (!obj) { return; }
    var i = fnGetSelectedRowIndex();
    fnSelectRow(i + 1);
    GridControl1.fnDeleteRow(obj);
}

// 条码录入
var e_barcode = e_barcode || function() {
    var m = $.openModal(barcodeurl + '?id=' + GetSheetID(), '900px', '400px');
    if (m) { e_query(); }
}

// 单据操作
var e_sure = e_sure || function() { doOperation("Sure"); }
var e_unsure = e_unsure || function() { doOperation("UnSure"); }
var e_chk = e_chk || function() { doOperation("Check"); }
var e_unchk = e_unchk || function() { doOperation("UnCheck"); }

var doOperation = function(op) {

    var id = GetSheetID();
    if (!id) return;
    var url = '../public/sheetchecker.aspx?' + $.param({ o: op, id: id, m: $('#MenuId').val() });
    var obj = $.openModal(url, '380px', '400px');
    if (obj) {
        //TODO：移除选中行（提交或撤消成功后将不会在此状态列表下显示，所以需要移除）
        var rows = GridControl1.fnGetSelected();
        e_deleted(rows[0]);
    }
}

function showWeekRange() {
    var Nowdate = new Date();
    var WeekFirstDay = new Date(Nowdate - (Nowdate.getDay() - 1) * 86400000);
    var WeekLastDay = new Date((WeekFirstDay / 1000 + 6 * 86400) * 1000);
    return [WeekFirstDay, WeekLastDay];
}
function showMonthRange() {
    var Nowdate = new Date();
    var MonthFirstDay = new Date(Nowdate.getYear(), Nowdate.getMonth(), 1);
    var MonthNextFirstDay = new Date(Nowdate.getYear(), Nowdate.getMonth() + 1, 1);
    var MonthLastDay = new Date(MonthNextFirstDay - 86400000);
    return [MonthFirstDay, MonthLastDay];
}

function selectdate() {
    var n = parseInt($('input:radio[name="seldate"]:checked').val()) || 0;
    if (n == 3) {
        $('#datefields').show();
    } else {

        switch (n) {
            case 0: break;
        }
        $('#datefields').show();
        $('#begdate').val();

        //e_query();
    }
}
// 导出
var e_export = e_export || function () {
    var data = GridControl1.fnGetExportData();
    $.output('excel', data);
}
