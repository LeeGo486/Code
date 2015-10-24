/* 明细编辑界面 */
/* Author : jackie 2010-06-21 创建 */
//
var st = null;
$(function() {

    $('#btnadd').click(e_add);
    $(':button[name="save"]').click(e_save);
    $(':button[name="cancel"]').click(e_cancel);
    $(':button[name="ok"]').click(e_ok);
    $('#btndelete').click(e_delete);

    // hotkeys
    $(document).bind('keydown', 'del', function() { e_delete(1); return false; });
    $(document).bind('keydown', 'ctrl+s', function() { e_save(); return false; });

    $(':text').focus(function() { this.select(); })

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
    $("#MySplitter").splitter({ type: 'v' });
    $("#MySplitter").trigger("resize", [570]);
    //
    setTimeout(e_query, 0);
});

// Toolbar 状态
function SetToolbarStatus() {
    var selrow = $('#queryTable .selected');
    if (selrow.length == 0) {
        $('.selendabled').attr('disabled', 'disabled')
    } else {
        $('.selendabled').removeAttr('disabled');
    }
}
function autoTableLayout() {
    $('#queryTable .fixedgrid').width($('#LeftPane').width());
    $('#queryTable .fixedgrid-header').width($('#LeftPane').width());
    $('#queryTable .fixedgrid-body').width($('#LeftPane').width());
    window.clearTimeout(st);
    st = window.setTimeout(autoTableLayout, 300);
}
// query
var e_query = e_query || function() {
    var obj = {
        id: $(':hidden[name="sheetid"]').val()
    }
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("getDetail", obj, function(result) {
        var html = $.makehtmltable(result.d);
        $('#queryTable').empty().html(html);
        $('#queryTable table').addClass('tablesorter').tablesorter().fixedgrid({
            width: $('#LeftPane').width()
        }).makerowselector();
        autoTableLayout();
        $('#queryTable table tbody tr').click(e_rowclick);
        SetToolbarStatus();
        e_add();
    });
}

// add new
var e_add = e_add || function() {
    var newid = getboxid();
    e_showdetail(newid);    //新增一条记录
    $('#queryTable .selected').removeClass('selected');
}

/* 行单击事件
----------------------------------------------------------------*/
var e_rowclick = e_rowclick || function() {
    var id = $(this).find('td:first').text();
    if (!id) return;
    SetToolbarStatus();
    e_showdetail(id);
}

/* 加载并显示明细
----------------------------------------------------------------*/
var e_showdetail = e_showdetail || function(id) {
    var obj = {
        bankid: $(':hidden[name="sheetid"]').val(),
        id: id
    }
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("showDetail", obj, function(result) {
        var obj = result.d || new Object();
        $('.field').fillFields(obj);
    });
}

// 保存
var e_save = e_save || function() {
    var obj = $(".editpanel .field").serializeObject();
    if (!e_chkform(obj)) return;
    //if (!confirm('确定提交吗？')) return;
    var data = {
        obj: obj
    }
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("SaveDetail", data, function(result) {
        var o = result.d || new Object();
        if (o.success == 1) {
            e_query();
        } else {
            alert(o.msg);
        }
    });
}
// 取消
var e_cancel = e_cancel || function() {
    window.returnValue = false;
    window.close();
}
// 录入完成
var e_ok = e_ok || function() {
    window.returnValue = true;
    window.close();
}

/* 删除 
----------------------------------------------------------------*/
var e_delete = e_delete || function() {
    var row = $('#queryTable tbody tr.selected');
    if (row.length == 0) return;
    if (!confirm('确定要删除吗？')) return;
    var obj = {
        id: $(':hidden[name="sheetid"]').val(),
        sid: row.find('td').eq(0).text()
    }

    //alert($.toJSON(obj)); return;
    $.ajaxWebService("Delete", obj, function(result) {
        if (result.d.success != 1) { alert(result.d.msg); return; }
        e_query();
    });
}


/* 获取一个新的序号
----------------------------------------------------------------*/
function getboxid() {
    var maxid = 0;
    var rows = $('#queryTable tbody tr')
    $.each(rows, function() {
        var id = $(this).find('td').eq(0).text();
        maxid = maxid > id ? maxid : id;
    });

    maxid = $.string2int(maxid);
    return 'W' + $.padLeft(maxid + 1, 5);
}
