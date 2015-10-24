
$(function () {
    $('#btnsubmit').removeAttr('disabled');
});

function onnodeclick(item) {
    if (item.hasChildren)
        item.expand();
    else
        $(this).find('IMG.bbit-tree-node-cb').click();
}

var _st = null, _ajax = null;
var _oldval = "";
function oncheckboxclick(item, checkstate) {
    var str = item.value;
    // 不同级
    if (_oldval.split('^')[0] != str.split('^')[0]) {
        AjaxTreeView1.resetCheck();
    }
    _oldval = str;
    if (_st) window.clearTimeout(_st);
    _st = window.setTimeout(LoadMultiSelector, 500);

}
// load data
function LoadMultiSelector(str) {
    if (_ajax) _ajax.abort();
    var data = MultiSelector1.oSettings.data;
    data.value = getSelectedValues();
    _ajax = MultiSelector1.fnAjaxLoad(data);
}
// 
function getSelectedValues() {
    var s = AjaxTreeView1.getCheckedNodes();
    return s.join('$');
}
//save 
function e_save(obj) {

    var act = MultiSelector1.oSettings.data["type"] == "set" ? "UpdateSetSelection" : "UpdateGetSelection";
    $.ajaxWebService(act, obj, function (result) {
        var obj = result.d || new Object();
        if (obj.success == 1) {
            window.returnValue = true;
            window.close();
        } else {
            alert(obj.msg);
        }
    }, {
        beforeSend: function () {
            $('#btnsubmit').attr('disabled', 'disabled');
        },
        complete: function () {
            $('#btnsubmit').removeAttr('disabled');
        }
    });
}

// submit 
function e_submit() {

    var obj = { str: getSelectedValues() };

    if (!obj.str) {
        alert('请选择店铺虚拟结构!');
        return;
    }

    MultiSelector1.fnSubmit(obj);
    return;
}

// cancel
function e_cancel() {
    window.returnValue = false;
    window.close();
}