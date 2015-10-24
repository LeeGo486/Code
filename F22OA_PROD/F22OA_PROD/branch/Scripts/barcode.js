/* 条码录入通用界面 */
/* Author : jackie 2010-05-11 创建 */
//
$(function() {
    $(":button").click(function() { return false; });
    $(':button[name="add"]').bind('click', e_add);
    $(':button[name="ok"]').bind('click', e_ok);
    $(':button[name="reset"]').bind('click', e_reset);

    setTimeout(e_bind, 0);

    $('.x-toolbar :text').focus(function() { this.select() }).find(':first').focus();
    $('.x-toolbar :text').not(':first').bind('keypress', txtKeyPress);

    // for ie6 
    $('#key').bind('keydown', 'return', function(e) {
        e_add();
        return false;
    });

});


// 表单数据绑定
var e_bind = e_bind || function() {
    var obj = {
        id: $.QueryString().id || ''
    }
    $.ajaxWebService("Get", obj, function(result) {
        var obj = result.d || new Object();
        $('.info').fillFields(obj);
        $('.field[name="depotid"]').val(obj.set_depotid);
        $('.field[name="setdepotid"]').val(obj.get_depotid);
        e_query();
    });
}

function txtKeyPress(e) {
    //if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    reg = /\d/;
    return reg.test(keychar);
}

//查询
var e_query = e_query || function() {
    var obj = $(".field").serializeObject();

    //alert($.toJSON(obj)); return;
    $.ajaxWebService("getList", obj, function(result) {
        if (obj.clothingid) {
            var n = parseInt($("#calNum").text()) || 0;
            n += obj.typ * obj.nums;
            $("#calNum").text(n.toString(10));
        }

        $('#queryTable').empty();
        var html = $.json2Table(result.d);
        $('#queryTable').html(html);
    });

}
// 录入
var e_add = e_add || function() {
    //客户端处理
    var key = $('#key').val();
    if (!key) { $('#key').focus(); return; }
    key = key.toUpperCase();
    $('#clothingid').val(key);
    $('#key').val('').focus();
    //后台验证
    e_query();
}

// 计数器清零
var e_reset = e_reset || function() {
    $('#calNum').text('0');
}

// 关闭
var e_ok = e_ok || function() {
    window.returnValue = true; window.close();
}
