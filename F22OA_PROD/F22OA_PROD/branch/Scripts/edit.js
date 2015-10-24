/* 编辑界面通用脚本 */
/* Author : jackie 2010-05-11 创建 */
//
$(function() {
    $(':button[name="save"]').click(e_save);
    $(':button[name="cancel"]').click(e_cancel);
    setTimeout(e_bind, 0);
});
// 表单数据绑定
var e_bind = e_bind || function() {
    var obj = {
        id: $.QueryString().id || ''
    }
    $.ajaxWebService("Get", obj, function(result) {
        var obj = result.d || new Object();
        $('.field').fillFields(obj);
    });
}

// 保存
var e_save = e_save || function() {
    var obj = $(".editpanel .field").serializeObject();
    if (!e_chkform(obj)) return;
    //if (!confirm('确定提交吗？')) return;
    var data = {
        obj: obj
    }
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("Save", data, function(result) {
        var o = result.d || new Object();
        if (o.success == 1) {
            window.returnValue = obj;
            window.close();
        } else {
            alert(o.msg);
        }
    });
}

// 表单验证
var e_chkform = e_chkform || function() {
    return true;
}
// 取消
var e_cancel = e_cancel || function() {
    window.returnValue = false; window.close();
}
