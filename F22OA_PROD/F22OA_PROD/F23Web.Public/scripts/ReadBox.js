$(function () {
    $("#btnclose").click(function () { window.close(); });
    $("#boxtm").focus();

    $("#boxtm").bind("keydown", function () {
        if (event.keyCode == 13) {
            btnRedTmpBox();
            return false;
        }
    });

    $("#btnred").click(function () {
        btnRedTmpBox();
    });
});

//读入箱
function btnSureInput() {
    var rows = GridControl1.fnGetNodes();
    var r,ids="";

    if (rows.length == 0) {
        alert("当前无箱可读入!");
        return false;
    }
    if (!confirm("确认需要读入以下箱吗?")) {
        return false;
    }

    for (var i = 0; i < rows.length; i++) {
        r = GridControl1.fnGetData(rows[0]);
        if (ids =="")
            ids = r[0] ;        
        else
            ids = ids + "," + r[0];
    }
    
    var obj = { czid: $.QueryString().id, ids: ids, importtype: $.QueryString().importtype };

    $.ajaxWebService("BtnCopyBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            returnValue = true;
            window.close();
        } else {
            alert(m.msg);
        }
    });
 }


//加载完后选择一条记录
function grdcomplete() {
    var rows = GridControl1.fnGetNodes();
    $(rows[rows.length - 1]).addClass('row_selected');
    boxRowSelect();

}

function boxRowSelect() {
    var rows = GridControl1.fnGetSelected();
    var id = $(rows[0]).find('td:first').text();
    var sheetid = GetSheetID();
    if (sheetid == undefined) sheetid = "";
    $("#sellboxid").val(sheetid);
    GridControl2.fnReloadAjax();
//    getboxtm(id);
}

function btnRedTmpBox() {
    var boxtm = $("#boxtm").val();
    if (boxtm == "") { return false; }

    var obj = { boxtm: boxtm };
    $.ajaxWebService("btnRedTmpBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            GridControl1.fnReloadAjax();
            $("#boxtm").val('');
        } else {
            alert(m.msg);
            $("#boxtm").select();
            $("#boxtm").focus();
        }
    });
}

function GetSheetID() {
    return GridControl1.fnGetSelectedIds()[0];
}

//删除
function delBox() {
    var rows = GridControl1.fnGetSelected();
    var obj = {
        sellboxid: $(rows[0]).find('td:first').text()
    };
    if (!obj.sellboxid) return;
    if (!confirm('确定要删除当前箱吗？')) return;
    $.ajaxWebService("delBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            GridControl1.fnReloadAjax();
        } else {
            alert(m.msg);
        }
    });
}

//删除所有箱
function delBoxAll() {
    var obj = {  };
    if (!confirm('确定要删除所有箱吗？')) return;
    $.ajaxWebService("delBoxAll", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            GridControl1.fnReloadAjax();
            $("#sellboxid").val("");
        } else {
            alert(m.msg);
        }
    });
}