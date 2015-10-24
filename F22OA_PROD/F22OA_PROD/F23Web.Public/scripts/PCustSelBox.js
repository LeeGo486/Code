$(function() {
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    $('#btnadd').click(e_add);
    $(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');
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

function e_submit() {
    if ($('button[name="save"]').is('[disabled]')) return;
    var rows = GridControl1.fnGetSelected();
    if (rows.length != 1) { alert("请选择一条记录!"); return ''; };
    var columns = GridControl1.fnSettings().aoColumns;
    var data = GridControl1.fnGetData(rows[0]);
    var obj = new Object();
    $.each(columns, function(i, o) {
        obj[o.sName] = data[i];
    });
    window.returnValue = obj;
    window.close();
}

function e_add() {    
    var url = "../pos/Customer/SheetEdit.aspx";
    var m = $.openModal(url, "615px", "230px");
    if (typeof m == 'object'&&m) {
        e_added(m.obj);
    }
}

function e_cancel() {
    window.close();
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

function fnSelectRow(i) {
    var rows = GridControl1.fnGetNodes();
    if (i >= rows.length) { i = rows.length - 1; }
    if (i < 0) { return; }
    $(rows).removeClass('row_selected');
    $(rows[i]).addClass('row_selected');
}