$(function() {

    $(':button').click(function() { return false; });
    // auto query;
    //e_query();
    //
    $('#btnquery').bind('click', e_query);
    $('#btnqueryall').bind('click', e_queryall);
    $('#btncheckall').bind('click', e_checkall);
    //
    $(":radio[name='way']").bind('click', function() {
        if ($('#key').val() != '') {
            e_query();
        }
    });
    //
    $('#ok').click(e_ok);
    $('#cancel').click(e_cancel);

    // for ie6 
    $('#key').bind('keydown', 'return', function(e) {
        e_query();
        return false;
    });
});
//
function e_query() {

    var obj = $(".x-toolbar .field").serializeObject();
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("depotselector.aspx/getList", obj, function(result) {
        var html = $.makehtmltable(result.d);
        $('#queryTable').empty();
        $('#queryTable').html(html);
        $('#queryTable table').addClass('tablesorter')
        .tablesorter()
        .fixedgrid({
            bottomHeight: $('#button').height() + 5
        }).makerowselector();

        //
        $('#queryTable table tbody tr').dblclick(e_ok);
    });

}
//
// 显示所有
//
function e_queryall() {
    $('#key').val(''); e_query();
}
//
// 全选
//
function e_checkall() {

}
//
// 确定
//
function e_ok() {
    var row = $('#queryTable tr.selected');
    if (row.length == 0) { return; }
    var obj = new Object();
    var head = $('#queryTable thead tr:first th');
    row.find('td').each(function(i) {
        var n = head.eq(i).attr('name');
        obj[n] = $.trim($(this).text());
    });

    //将整行记录转换成JSON字符窜并返回
    window.returnValue = $.toJSON(obj);
    window.close();
}
//
// 取消
//
function e_cancel() { window.returnValue = false; window.close(); }