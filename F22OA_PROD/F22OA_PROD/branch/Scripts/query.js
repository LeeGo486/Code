/* 查询界面通用脚本 */
/* Author : jackie 2010-05-11 创建 */
//
var editurl = editurl || GetUrl("Edit");
var inputurl = inputurl || GetUrl("Input");
var barcodeurl = barcodeurl || GetUrl("Barcode");

var st = null;
$(function() {

    $(":text[name='key']").bind('focus', function() { this.select(); })
    $(":radio[name='status']").bind('click', function() { setTimeout(e_query, 0); });

    // events
    $("#btnquery").bind('click', e_query);
    $("#btnadd").bind('click', e_add);
    $("#btnedit").bind('click', e_edit);
    $("#btndelete").bind('click', e_delete);
    $("#btninput").bind('click', e_input);
    $("#btnbarcode").bind('click', e_barcode);
    $("#btncheck").bind('click', e_check);
    $("#btnuncheck").bind('click', e_uncheck);
    $("#btnsure").bind('click', e_sure);
    $("#btnunsure").bind('click', e_unsure);
    $("#btndetail").bind('click', e_detail);

    // selector
    $("#btnseldepot").bind('click', e_seldepot);
    $("#btnexcel").bind('click', e_excel);

    // auto query;
    e_query();

    // layout splitter
    e_initSplitter();
});

var e_initSplitter = e_initSplitter || function() {
    // auto height
    $(window).bind("resize", function() {
        var $ms = $("#MySplitter");
        var t = $ms.offset().top;
        var wh = $(window).height();
        var mrg = parseInt($ms.css("marginBottom")) || 0;
        var brd = parseInt($ms.css("borderBottomWidth")) || 0;
        $ms.css("height", (wh - t - mrg - brd) + "px");
        if (!jQuery.browser.msie) {
            $ms.trigger("resize");
        }
    }).trigger("resize");

    //
    $("#MySplitter").splitter({
        type: "h",
        sizeTop: true,
        accessKey: "P"
    });
    if (!$('.icon-detail').hasClass('toggle')) {
        $("#MySplitter").trigger("resize", [parseInt($("#MySplitter").height()) || 0, 0]);
    }

}

// Toolbar 状态
function SetToolbarStatus() {
    var selrow = $('#queryTable .selected');
    if (selrow.length == 0) {
        $('.selendabled').attr('disabled', 'disabled')
    } else if (selrow.hasClass('trsure')) {
        $('.selendabled').attr('disabled', 'disabled');
        $('#btnunsure').removeAttr('disabled');
    } else if (selrow.hasClass('trchksure')) {
        $('.selendabled').attr('disabled', 'disabled')
        $('#btnuncheck,#btnsure').removeAttr('disabled');
    } else {
        $('.selendabled').removeAttr('disabled');
        $('#btnuncheck,#btnsure,#btnunsure').attr('disabled', 'disabled')
    }
    //特别处理
    if (selrow.length == 0) {
        $('.spebutton').attr('disabled', 'disabled')
    } else {
        $('.spebutton').removeAttr('disabled');
    }
}

function autoTableLayout() {
    var th = $('#TopPane').height() - $('#queryTable .fixedgrid-header').height();
    var bh = $('#BottomPane').height() - $('#detailTable .fixedgrid-header').height();
    $('#queryTable .fixedgrid-body').height(th);
    $('#detailTable .fixedgrid-body').height(bh);
    window.clearTimeout(st);
    st = window.setTimeout(autoTableLayout, 1000);
}

var e_rowclick = e_rowclick || function() {
    var id = $(this).find('td:first').text();
    id = $.trim(id);
    if (!id) return;
    if (id == $('#sheeteid').val()) return;
    SetToolbarStatus();
    showdetail(id);
}
//导出excel
function e_excel() {
    var obj = $(".x-toolbar .field").serializeObject();
    var prams = "?";
    for (var o in obj) {
        prams += o + "=" + obj[o] + "&";
    }
    prams += "dt=" + new Date().toString();
    window.location = "expPosBankQuery.aspx" + prams;
}

// 单据列表
var e_query = e_query || function () {
    var obj = $(".x-toolbar .field").serializeObject();
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("getList", obj, function (result) {
        var html = $.makehtmltable(result.d);
        $('#queryTable,#detailTable').empty();

        $('#queryTable').html(html);
        $('#queryTable table').addClass('tablesorter')
        .tablesorter()
        .fixedgrid({
            height: $('#TopPane').height() - $('#queryTable .fixedgrid-header').height()
        }).makerowselector();
        autoTableLayout();
        $('#queryTable table tbody tr').click(e_rowclick);
        // set toolbar status
        SetToolbarStatus();
    });
}
// 显示明细
var e_detail = e_detail || function() {
    if ($(this).hasClass('toggle')) {
        $(this).removeClass('toggle');
        $("#MySplitter").trigger("resize", [parseInt($("#MySplitter").height()) || 0, 0]);
    } else {
        $(this).addClass('toggle');
        $("#MySplitter").trigger("resize", [200]);
        GetSelectRows().click();
    }
    $(this).blur();
}
// 根据文件命自动取得返回文件名
function GetUrl(str) {
    var s = location.href.split('/');
    return s[s.length - 2] + str + ".aspx";
}
///
function GetSelectRows() {
    return $('#queryTable tbody tr.selected');
}
// 取得所有选中的单号
function GetSheetIDs() {
    var r = [];
    var rows = GetSelectRows();
    rows.each(function() {
        var id = $(this).find('td:first').text();
        id = $.trim(id);
        if (!id) return true;
        r.push(id);
    });
    return r;
}
// 取得单号
function GetSheetID() {
    return GetSheetIDs()[0];
}
// 取得指定字段所在位置
function getColumnIndex(fieldname) {
    var h = $('#queryTable thead tr:last');
    return h.find('th').index(h.find('th[name="' + fieldname + '"]'));
}
// 选仓店
var e_seldepot = e_seldepot || function() {
    var obj = $.openModal('../public/DepotMultiSelector.aspx', 580, 480);
    if (obj) {
        e_query();
    }
}

// 单据基本操作（增加、删除、修改）
var e_add = e_add || function() {
    var m = $.openModal(editurl, 450, 360);
    if (m) e_query();
}

// 删除
var e_delete = e_delete || function() {
    if (!confirm('确定要删除吗？')) return;
    var obj = {
        id: GetSheetID()
    }
    doAction("Delete", obj);
}
// 编辑
var e_edit = e_edit || function() {

    var obj = $.openModal(editurl + '?id=' + GetSheetID(), 450, 360);
    if (obj) {
        e_query();
    }
}

//// 更新一行的数据
//var e_update = e_update || function(obj, row) {
//    row = row || GetSelectRows();
//    if (row.length == 0) return;
//    row = row.eq(0);
//    for (var key in obj) {
//        var idx = getColumnIndex(key);
//        if (idx >= 0)
//            row.find('td').eq(idx).text(obj[key])
//    }
//}
// 手工录入
var e_input = e_input || function() {
    var m = $.openModal(inputurl + '?id=' + GetSheetID(), 900, 400);
    if (m) { e_query(); }
}
// 条码录入
var e_barcode = e_barcode || function() {
    var m = $.openModal(barcodeurl + '?id=' + GetSheetID(), 900, 400);
    if (m) { e_query(); }
}

// 单据操作（审核、反审核、登账、反登账）
var e_check = e_check || function() { doOperation("Check"); }
var e_uncheck = e_uncheck || function() { doOperation("UnCheck"); }
var e_sure = e_sure || function() { doOperation("Sure"); }
var e_unsure = e_unsure || function() { doOperation("UnSure"); }

// 显示明细
var showdetail = showdetail || function(id) {
    if (!$('#btndetail').hasClass('toggle')) { return; }
    var obj = { id: id }
    $.ajaxWebService("getDetail", obj, function(result) {
        $('#detailTable').empty();
        var html = $.makehtmltable(result.d);
        $('#detailTable').html(html);
        $('#detailTable table').fixedgrid({
            height: $('#BottomPane').height() - $('#detailTable .fixedgrid-header').height()
        });
        $('#detailTable').append('<input type="hidden" id="sheeteid" value="' + id + '" />');
        autoTableLayout();
    });
}

// 提交后台操作
var doAction = function(act, data) {
    //
    $.ajaxWebService(act, data, function(result) {
        var obj = result.d || new Object();
        if (obj.success == 1) {
            e_query();
        } else {
            alert(obj.msg);
        }
    });
}

// 单据操作通用方法
var doOperation = function(op) {

    if (!op) return;
    var obj = $.openModal("../public/operation.aspx?o=" + op + "&id=" + GetSheetID() + "&m=" + $('#MenuId').val(), 420, 300);
    if (obj) e_query(); //操作成功，重载列表
}