$(function () {
    $("#type").val($.QueryString().type);
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    //$(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');

    $('input:radio[name="dtype"]').click(function () {
        var v = $(this).val();
        if (v == '0' || v == '1') {
            $('#daterangee').show().siblings().hide();
        } else if (v == '2' || v == '3') {
            $('#centumrangee').show().siblings().hide();
            $('#beg').focus();
        } else if (v == '4') {
            $('#viptype').show().siblings().hide();
            $('#viptypename').focus();
        } else if (v == '5') {
            $('#keyword').show().siblings().hide();
            $('#key').focus();
        } else {
            $('#depot').show().siblings().hide();
        }
    });
    //
    $('#key').focus(function () { $(this).select() })
    .bind('keydown', 'return', function () {
        e_query(); return false;
    })
    $.numberOnly($("#beg"));
    $.numberOnly($("#end"));
    $('#beg').focus(function () { $(this).select() })
    $('#end').focus(function () { $(this).select() })
    $('#btndepot').click(e_depot);
});


function e_chkform() {
    var obj = getparams();
    if ((obj.dtype == '2' || obj.dtype == '3') && (!obj.beg || !obj.end)) {
        alert('请输入范围！');
        $('#beg').focus();
        return false;
    } else if ((obj.dtype == '5') && !obj.key) {
        alert('请输入卡号！');
        $('#key').focus();
        return false;
    }
    return true;
}

function e_depot() {
    var url = "DepotMultiSelector.aspx?type=vip";
    var m = $.openModal(url, "500px", "425px");
}

function e_submit() {  
    if ($('button[name="save"]').is('[disabled]')) return;
    /*
    var rows = GridControl1.fnGetNodes();
    var vips = [];
    for (var i = 0; i < rows.length; i++) {
    vips.push({
    vipid: $(rows[i]).find('td:eq(0)').text()
    });
    }  
    window.returnValue = vips;
    */
    var vips = [];
    var columns = GridControl1.fnSettings().aoColumns;
    var rows = GridControl1.fnGetNodes();
    for (var i = 0; i < rows.length; i++) {
        if ($(rows[i]).hasClass('row_selected')) {
            var obj = new Object();
            var data = GridControl1.fnGetData(rows[i]);
            $.each(columns, function (i, o) {
                obj[o.sName] = data[i];
            });
            vips.push(obj);
        }
    }
    window.returnValue =$.toJSON(vips);
    window.close();

}

//选择全部
function e_selectall() {
    var aTrs = GridControl1.fnGetNodes();
    if ($("#btnsel").text() == "全选") {
        $("#btnsel").removeClass("icon icon-tick");
        $("#btnsel").addClass("icon icon-delete");
        $("#btnsel").text("取消全选");
        for (var i = 0; i < aTrs.length; i++) {
            $(aTrs[i]).addClass('row_selected');
        }
    } else {
        $("#btnsel").text("全选");
        $("#btnsel").removeClass("icon icon-delete");
        $("#btnsel").addClass("icon icon-tick");      
        for (var i = 0; i < aTrs.length; i++) {
            $(aTrs[i]).removeClass('row_selected');
        }
    }   
}

