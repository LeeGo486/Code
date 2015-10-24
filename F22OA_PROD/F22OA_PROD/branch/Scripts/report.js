$(function() {
    $(":text[name='key']").bind('focus', function() { this.select(); })
    $(":radio[name='status']").bind('click', function() { setTimeout(e_query, 0); });

    // 查询
    $("#btnquery").bind('click', e_query);

    // 选仓店
    $("#btnseldepot").bind('click', e_seldepot);

});

// 单据列表
var e_query = e_query || function() {
    var obj = $(".x-toolbar .field").serializeObject();
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("getList", obj, function(result) {
        var html = $.makehtmltable(result.d);
        $('#queryTable').empty();
        $('#queryTable').html(html);
        $('#queryTable table').addClass('tablesorter').tablesorter().fixedgrid();
        e_onload(); //响应加载事件
    });
}

var e_onload = e_onload || function() { 
    
}

// 选仓店
var e_seldepot = e_seldepot || function() {
    var obj = $.openModal('../public/DepotMultiSelector.aspx', 580, 480);
    if (obj) {
        e_query();
    }
}
