//选中
var dgRowSelect = dgRowSelect || function () {
    $('#btnsubmit').removeAttr('disabled');
}

//双击
var dgRowDbClick = dgRowDbClick || function () {
    e_submit();
}

//确定
function e_submit() {
    var id = GridControl1.fnGetSelectedIds(0);
    window.returnValue = id;
    window.close();
}