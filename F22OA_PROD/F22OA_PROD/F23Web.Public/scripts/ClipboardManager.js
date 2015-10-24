$(function () {
    $(".SelType").change(function () {
        query();
    });
});

function initComplete() {
    var that = this;
    $(window).bind('resize', function () {
        that.AdjustScrollLayout();
        that.fnAdjustColumnSizing();
    }).trigger('resize');
}

function query() {
    GridControl1.fnReloadAjax(); 
}

function getparams() {
    var obj = $.QueryString();
    obj.selType = $(".SelType").val();
    return obj;
}

var _currentRow;
function rowselected(row) {
    _currentRow = row;
}

function RowDoubleClick() {
    var row = _currentRow;
    var data = GridControl1.fnGetData(row);
    if (!data) { return; }
    styleid = data[0];
    var url = "clipboardinput.aspx?styleid=" + styleid + "&seltype=" + $(".SelType").val() + "&IndentDept=Z0001000";
    var m = $.openModal(url, '600px', '450px');
    if (m) {
        GridControl1.fnReloadAjax(); 
    }
}

function edit() {
    var row = _currentRow;
    var data = GridControl1.fnGetData(row);  
    if (!data) { return; }
    styleid = data[0];
    var url = "clipboardinput.aspx?styleid=" + styleid + "&seltype=" + $(".SelType").val() ;
    var m = $.openModal(url, '600px', '450px');
    if (m) {
        GridControl1.fnReloadAjax(); 
    }
}

function del() {
    if (!confirm('确认删除当前记录,\n您确定要执行此操作吗？')) return;
    var row = _currentRow;
    var data = GridControl1.fnGetData(row);
    if (!data) { return; }
   
    var obj = {
                'styleid' : data[0],
                'colorid' : data[2],
                'userid': $.QueryString().userid,
                'type': $(".SelType").val()
    };

    $.ajaxWebService("Delete", obj, function (result) {
        var m = result.d || new Object();

        if (m.success == 1) {
            var rows = GridControl1.fnGetSelected();
            GridControl1.fnDeleteRow(rows[0]);
        } else {
            alert(m.msg);
        }
    });
}
