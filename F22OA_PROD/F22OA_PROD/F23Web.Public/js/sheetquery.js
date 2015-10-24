/* create by jackie 2010-09-16 单据查询通用脚本 */

//
var detailurl = detailurl || "detail.aspx";     //明细页
var sediturl = sediturl || "sheetedit.aspx";    //编辑页
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
    //GridControl1_table_filter
});
//

var getparams = getparams || function () {
    return $(".field").serializeObject();
}
var e_chkform = e_chkform || function () {
    return true;
}
var SetControllerState = SetControllerState || function () {
    var rows = GridControl1.fnGetSelected();
    if (rows.length > 0) {
        $('.st_field').removeClass('disabled');
    } else {
        $('.st_field').addClass('disabled');
    }
}

// 单据列表
var qtimer = null;
var e_query = e_query || function () {
    if (!e_chkform()) { return; }
    if (qtimer) window.clearTimeout(qtimer);
    qtimer = setTimeout(function () {
        GridControl1.fnReloadAjax()
    }, 300);
}
// 显示明细
var e_detail = e_detail || function () {
    var id = GetSheetID();
    if (!id) return;

    var obj = $.openModal(detailurl + '?id=' + id, '90%', '70%');

    if (typeof obj == 'string') {
        if (obj == 'unsure') {
            e_unsure();
        }
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
}

// 撤消
var e_unsure = e_unsure || function () {
    if ($('#btnunsure').hasClass('disabled')) return;
    var id = GetSheetID();
    $.doOperation("UnSure", id, tempsure, function (obj) {
        var rows = GridControl1.fnGetSelected();
        e_deleted(rows[0]);
    });
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

function getTodayRange() {
    return [new Date(), new Date()];
}

function getWeekRange() {
    //    var Nowdate = new Date();   //'2010/09/10 00:00:000'
    //    var WeekFirstDay = new Date(Nowdate - (Nowdate.getDay() - 1) * 86400000);
    //    var WeekLastDay = new Date((WeekFirstDay / 1000 + 6 * 86400) * 1000);

    var now = new Date();
    var currentWeek = now.getDay();
    if (currentWeek == 0) { currentWeek = 7; }
    var monday = now.getTime() - (currentWeek - 1) * 24 * 60 * 60 * 1000;
    var sunday = now.getTime() + (7 - currentWeek) * 24 * 60 * 60 * 1000;
    return [new Date(monday), new Date(sunday)];
}

function getMonthRange() {
    var Nowdate = new Date();
    var MonthFirstDay = new Date(Nowdate.getFullYear(), Nowdate.getMonth(), 1);
    var MonthNextFirstDay = new Date(Nowdate.getFullYear(), Nowdate.getMonth() + 1, 1);
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

// 查看差异
var e_showdiff = e_showdiff || function () {
    var id = GetSheetID();
    if (!id) return;
    var url = 'ShowDiff.aspx?id=' + id
    $.openModal(url, '800px', '500px');
}

// 生成发货单
var e_crset = e_crset || function () {
    var id = GetSheetID();
    if (!id) return;
    //if (GetSheetIdxVal(1) == "已处理") { alert("此通知单已经生成发货单，不能重复生成!"); return false; }
    if (!confirm("确定要生成发货单吗?")) { return false; }

    $.ajaxWebService("CreateSet", { id: id }, function (result) {
        var o = result.d || new Object();
        if (o.success > 0) {
            // check sheet
            if (confirm("发货单生成成功！\n单号：" + o.obj.id + "\n\n现在查看此发货单吗？")) {
                var m = $.openModal(sediturl + '?id=' + o.obj.id + '&noticeid=' + o.obj.noticeid, '90%', '70%');
                if (m && m.success == 3) {
                    return;
                }
            }
            // update values
            var i = fnGetSelectedRowIndex();
            GridControl1.fnUpdate('已处理', i, 1);
            GridControl1.fnUpdate(o.obj.id, i, 2);
        } else {
            alert(o.msg);
        }
    });
}

// 导出
var e_export = e_export || function () {
    var data = GridControl1.fnGetExportData();
    $.output('excel', data);
}

var sbwidth = sbwidth || '600px'
var sbheight = sbheight || '460px'

// 选款
var e_selstyle = e_selstyle || function () {
    $.openModal('/public/StyleSelector.aspx', sbwidth, sbheight);
}

// 选择加盟商
var e_selmerchant = e_selmerchant || function () {
    $.openModal('/public/MerchantMultiSelector.aspx?action=getmerchant', sbwidth, sbheight);
}
// 选择发货地
var e_selsetdepot = e_selsetdepot || function () {
    $.openModal('/public/DepotMultiSelector.aspx?action=getdepot&type=set&title=选择发货地', sbwidth, sbheight);
}
// 选择收货地
var e_selgetdepot = e_selgetdepot || function () {
    $.openModal('/public/DepotMultiSelector.aspx?action=getdepot&type=get&title=选择收货地', sbwidth, sbheight);
}
// 选择店铺（POS）
var e_seldepot = e_seldepot || function () {
    $.openModal('/public/DepotMultiSelector.aspx?action=getdepot&type=get&title=选择仓店', sbwidth, sbheight);
}