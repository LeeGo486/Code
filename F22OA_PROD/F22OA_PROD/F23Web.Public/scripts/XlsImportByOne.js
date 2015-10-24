$(function () {
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    $(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');
    $('#btnquery').click(e_query);
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
    $(document).bind('keydown', 'del', function () { e_delete(); return false; });
});

function e_query() {
    GridControl1.fnReloadAjax();
}

function e_submit() {
    if ($("#filename").val() == "") { alert("请先上传文件!"); return false; }
    if ($('button[name="save"]').is('[disabled]')) return;
    $("#id").val($.QueryString().id);
    $("#type").val($.QueryString().importtype);
    //    $("#id").val('JFz017-2010-09-05-0021');
    //    $("#type").val('sell');
    var obj = $(".field").serializeObject();
    var data = { obj: obj }
    importdata(data);
}

function importdata(data) {
    if (!confirm('确定要导入吗？')) return;
    var error = false;
    var rows = $('tr', GridControl1);
    rows.each(function () {
        if ($(this).find('td').length > 0) {
            if (parseFloat($(this).find('td:eq(8)').text()) < 0) {
                error = true;
            }
        }
    });
    if (error) { alert('存在结算价小于0的记录,不能导入！'); return; }
    $.ajaxWebService('ImportData', data, function (result) {
        result = result.d || {};
        if (result.success > 0) {
            $("#divmsg").hide();
            alert(result.msg);
            window.returnValue = true;
            window.close();
        } else {
            alert(result.msg);
        }
    });
}

function e_delete() {
    var rows = GridControl1.fnGetSelected();
    var obj = {
        id: $(rows[0]).find('td:first').text()
    };
    if (!obj.id) return;
    if (!confirm('确定要删除吗？')) return;
    $.ajaxWebService("Delete", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            e_deleted(rows[0]);
        } else {
            alert(m.msg);
        }
    });
}

// 删除完成
var e_deleted = e_deleted || function (obj) {
    if (!obj) { return; }
    var i = fnGetSelectedRowIndex();
    fnSelectRow(i + 1);
    GridControl1.fnDeleteRow(obj);
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

function e_cancel() {
    window.close();
}

//载入中的GIF动画
var loadingUrl = "../Public/images/loading.gif";

//选择文件后的事件,iframe里面调用的
var uploading = function (imgsrc) {
    var el = $("#uploading");
    $("#ifUpload").hide()
    el.html("<img src='" + loadingUrl + "' align='absmiddle' /> 上传中...").fadeIn("fast");
    return el;
};

//重新上传方法    
var uploadinit = function () {
    var id = $.QueryString().id;
    var importtype = $.QueryString().importtype;
    var url = window.location.href.split('?')[0] + "?id=" + id + "&importtype=" + importtype;
    $('form:first').attr('action', url).unbind('submit').submit();
};

//上传时程序发生错误时，给提示，并返回上传状态
var uploaderror = function () {
    // uploadinit();
};

//上传成功后的处理
var uploadsuccess = function (filename, tid) {
    var html;
    var clothingid;
    var nums;
    $("#uploading").html("文件上传成功.<a href='javascript:void(0);' onclick='uploadinit();'>[重新上传]</a>");
    $("#filename").val(filename);
    $("#testid").val(tid);
    e_query();
};