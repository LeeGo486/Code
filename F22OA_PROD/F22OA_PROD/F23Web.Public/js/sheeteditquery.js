/* 查询界面通用脚本a */
/* Author : jackie 2010-08-23 创建 */
//
var editurl = editurl || "sheetedit.aspx";           //编辑
var barcodeurl = barcodeurl || "barcode.aspx";  //条码录入
var detailurl = detailurl || "detail.aspx";     //显示明细
var noticeurl = noticeurl || "notice.aspx";     //通知单
var txtimporturl = txtimporturl || "public/txtimport.aspx"; //盘点机导入
var importtype = importtype || "Inventory"; //导入单据类型
var tempsure = tempsure || 'true'; //是否需要执行更新临时标识

var st = null, qtimer = null, rsTimer;
$(function () {
    $(document).bind('keydown', 'up', function () {
        var i = fnGetSelectedRowIndex();
        fnSelectRow(i - 1);
        return false;
    }).bind('keydown', 'down', function () {
        var i = fnGetSelectedRowIndex();
        fnSelectRow(i + 1);
        return false;
    }).bind('keydown', 'left', function () {
        var s = $('.dataTables_scrollBody').scrollLeft();
        $('.dataTables_scrollBody').scrollLeft(s - $(window).width() / 2);
        return false;
    }).bind('keydown', 'right', function () {
        var s = $('.dataTables_scrollBody').scrollLeft();
        $('.dataTables_scrollBody').scrollLeft(s + $(window).width() / 2);
        return false;
    });
});

//
var getparams = getparams || function () {
    return $(".field").serializeObject();
}

var SetControllerState = SetControllerState || function () {
    var rows = GridControl1.fnGetSelected();
    if (rows.length > 0) {
        $('.st_field').removeClass('disabled');
    } else {
        $('.st_field').addClass('disabled');
    }
    $('#btnquery').removeClass('disabled')
}

// 单据列表
var e_query = e_query || function () {
    if ($('#btnquery').hasClass('disabled')) return;
    GridControl1.fnReloadAjax();
}
// 显示明细
var e_detail = e_detail || function () {
    var id = GetSheetID();
    if (!id) return;

    $.openModal(detailurl + '?id=' + id, '90%', '70%');
}

// 条码录入
var e_barcode = e_barcode || function () {
    var id = GetSheetID();
    if (!id) return;
    var m = $.openModal(barcodeurl + '?id=' + id, '90%', '70%');
    if (m) {
        //self.location.href = self.location.href + '&__=' + (new Date()).valueOf();
    }
}

//盘点机导入
var e_importtxt = e_importtxt || function () {
    var id = GetSheetID();
    if (!id) return;
    var m = $.openModal(txtimporturl + '?id=' + id + "&importtype=" + importtype, '490px', '330px');
    if (m) {
        //self.location.href = self.location.href + '&__=' + (new Date()).valueOf();
    }
}
// 
var e_notice = e_notice || function () {
    var obj = $.openModal(noticeurl, '90%', '70%');
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
var e_add = e_add || function () {
    t_edit(null, e_added);
}

// 删除
var e_delete = e_delete || function () {
    if ($('#btndel').hasClass('disabled')) return;
    var id = GetSheetID();
    if (!id) return;
    if (!confirm('确定要删除吗？')) return;
    t_delete(id);
}

// 执行删除操作
var t_delete = t_delete || function (id) {
    if (!id) return;
    $.ajaxWebService("Delete", { id: id }, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            var rows = GridControl1.fnGetSelected();
            e_deleted(rows[0]);
        } else {
            alert(m.msg);
        }
    });
}

// 编辑
var e_edit = e_edit || function () {
    if ($('#btnedit').hasClass('disabled')) return;
    var id = GetSheetID();
    if (!id) return;
    t_edit(id, e_updated);
    return false;
}

// 弹出编辑/新增窗口
var t_edit = t_edit || function (id, callback) {
    var url = editurl;
    if (id) url += '?id=' + id; //edit

    var m = $.openModal(url, '90%', '70%');
    if (typeof m == 'object' && m != null) {
        if (typeof callback == 'function') {
            callback(m.obj);
        }
        // 需要执行的命令
        if (m.success == 2 || m.success == 3) {
            var rows = GridControl1.fnGetSelected();
            e_deleted(rows[0]);
        }
    }
}

// --------------------------------------
//   事件：增删改后触发的事件（行的操作）
// --------------------------------------
// 添加完成
var e_added = e_added || function (obj) {
    if (!obj) { return; }
    var _d = [];
    $.each(GridControl1.fnSettings().aoColumns, function (i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o);
    });
    var i = GridControl1.dataTable().fnAddData(_d);
    fnSelectRow(i);
}
// 更新完成
var e_updated = e_updated || function (obj) {
    if (!obj) { return; }
    var rowindex = fnGetSelectedRowIndex();
    if (rowindex >= 0) {
        var _d = [];
        $.each(GridControl1.fnSettings().aoColumns, function (i, o) {
            var _o = obj[o.sName];
            _o = _o == null ? '' : _o == undefined ? '' : _o;
            _d.push(_o);
        });
        GridControl1.fnUpdate(_d, rowindex);
        $('input:text:first').select();  //修复双击时选中所有内容的bug
    }
}
// 取得列的位置
function fnGetColumnIndex(sName) {
    var idx = -1;
    $.each(GridControl1.fnSettings().aoColumns, function (i, o) {
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
    SetControllerState();
}

// 删除完成
var e_deleted = e_deleted || function (row) {
    if (!row) { return; }
    var i = GridControl1.fnGetPosition(row);
    if ($(row).next().size()) {
        fnSelectRow(i + 1);
    } else if ($(row).prev().size()) {
        fnSelectRow(i - 1);
    }
    GridControl1.fnDeleteRow(row);
}

// 条码录入
var e_barcode = e_barcode || function () {
    var m = $.openModal(barcodeurl + '?id=' + GetSheetID(), '700px', '400px');
    if (m) { e_query(); }
}

// 单据提交
var e_sure = e_sure || function () {
    if ($('#btnsure').hasClass('disabled')) return;
    var id = GetSheetID();
    t_sure(id);
}
// 执行提交操作
var t_sure = t_sure || function (id) {
    if (!id) return;
    $.doOperation("Sure", id, tempsure, function (obj) {
        var rows = GridControl1.fnGetSelected();
        e_deleted(rows[0]);
    });
}

function getTodayRange() {
    return [new Date(), new Date()];
}

function getWeekRange() {
    var Nowdate = new Date();
    var WeekFirstDay = new Date(Nowdate - (Nowdate.getDay() - 1) * 86400000);
    var WeekLastDay = new Date((WeekFirstDay / 1000 + 6 * 86400) * 1000);
    return [WeekFirstDay, WeekLastDay];
}

function getMonthRange() {
    var Nowdate = new Date();
    var MonthFirstDay = new Date(Nowdate.getYear(), Nowdate.getMonth(), 1);
    var MonthNextFirstDay = new Date(Nowdate.getYear(), Nowdate.getMonth() + 1, 1);
    var MonthLastDay = new Date(MonthNextFirstDay - 86400000);
    return [MonthFirstDay, MonthLastDay];
}

function selectdate() {
    var n = parseInt($('input:radio[name="seldate"]:checked').val()) || 0;
    var d = new Array();
    if (n == 0) {
        d = getTodayRange();
    } else if (n == 1) {
        d = getWeekRange();
    } else if (n == 2) {
        d = getMonthRange();
    } else {
        $('#datefields').show();
        return;
    }
    $('#datefields').hide();
    $('#begdate').val(d[0].asString()).trigger('change');
    $('#enddate').val(d[1].asString()).trigger('change');
    e_query();
}

// 打印
var e_print = e_print || function (url, width, height, act) {
    var id = GetSheetID();
    if (!id) return;
    var url = $.format(url, id);
    $.print(url, width, height, act);
}

// 导出
var e_export = e_export || function () {
    var data = GridControl1.fnGetExportData();
    $.output('excel', data);
}
