$(function () {
    $(':button').click(function () { return false; });
    // auto query;
    //e_query();
    //
    $('#btnquery').bind('click', e_query);
    $('#btnqueryall').bind('click', e_queryall);
    $('#btncheckall').bind('click', e_checkall);
    //
    $(":radio[name='way']").bind('click', function () {
        if ($('#key').val() != '') {
            e_query();
        }
    });
    //
    $('#ok').click(e_ok);
    $('#cancel').click(e_cancel);

    // for ie6 
    $('#key').bind('keydown', 'return', function (e) {
        e_query();
        return false;
    });
});
//
function e_query() {
    //var obj = $(".x-toolbar .field").serializeObject();
    var checked = $(":radio[name='way']:checked").val();
    var type = "name";
    if (checked == 2) { type = "code"; }
    if (checked == 3) { type = "num"; }
    var shopnum = $("#key").val();
    if (shopnum == "") { shopnum = "-"; }
    var obj = "{shopnum:'" + shopnum + "',type:'" + type + "'}";
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("SDBuildVipShopNew.aspx/getList", obj, function (result) {
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
    row.find('td').each(function (i) {
        var n = head.eq(i).attr('name');
        obj[n] = $.trim($(this).text());
    });

    //将整行记录转换成JSON字符窜并返回
    //alert( $.toJSON(obj));
    window.returnValue = obj["depotid"] + "," + obj["d_name"];
    window.close();
}
//
// 取消
//
function e_cancel() { window.returnValue = ""; window.close(); }