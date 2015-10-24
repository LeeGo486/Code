
var e_unsure = e_unsure || function() {
    window.returnValue = 'unsure';
    window.close();
}

// 将数量为0的值替换为空
var NumRender = NumRender || function(obj) {
    return obj.aData[obj.iDataColumn] == '0' ? '' : obj.aData[obj.iDataColumn];
}

// 打印
var e_print = e_print || function(url, width, height, act) {
    var id = $.QueryString().id;
    url = $.format(url, id);
    $.print(url, width, height, act)
}
// 导出
var e_export = e_export || function () {
    var data = GridControl1.fnGetExportData();
    $.output('excel', data);
}


var getparams = getparams || function(obj) {
    return { id: $.QueryString().id }
}


var fnRowDblClick = fnRowDblClick || function (event) {
    var row = event.target.parentNode;
    if (!row) return;
    if ($('td.dataTables_empty', row).size()) return;
    if (row.tagName != 'TR') return;
    var id = $("td:eq(1)", row).text();

    if (id) {
        var m = $.openModal('/public/showstyle.aspx?id=' + id, '630px', '360px');
    }
}