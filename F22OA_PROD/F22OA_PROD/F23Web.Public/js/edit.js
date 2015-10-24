/* 编辑界面通用脚本 */
/* Author : jackie 2010-05-11 创建 */
//
$(function() {

    $('form:first').bind('submit', function() { e_save(); return false; });

    $(':text').bind('focus', function() { this.select(); });

    $('.field')
	.bind('keydown', 'return', function(e) {
	    var s = false; var t = this;
	    $(':text,:radio,:checkbox,select,button').each(function(i, obj) {
	        if ($(obj).is('[readonly],[disabled]')) { return true; }
	        if (!$(this).is(':visible')) { return false; }
	        var expr = ':radio[name=' + $(t).attr('name') + ']';
	        if (s == true && !$(obj).is(expr)) {
	            this.focus(); return false;
	        }
	        if (t == obj) { s = true; }
	    });
	    return false;
	});

    e_bind();

});

// 表单数据绑定
var e_bind = e_bind || function() {
    var obj = { id: $.QueryString().id || '' };
    $.ajaxWebService("Get", obj, function(result) {
        result = result.d || new Object();
        if (result.success > 0) {
            $('.field').fillFields(result.obj);
            $('#btnsubmit').removeAttr('disabled');
            $('input.field').not(':hidden,[disabled],[readonly]').eq(0).trigger('focus');
        } else {
            alert(result.msg);
            window.close();
        }
    });
}

// 保存
var e_save = e_save || function () {

    if ($('#btnsubmit').is('[disabled]')) return;

    var obj = $(".field").serializeObject();
    if (!e_chkform(obj)) return;
    //if (!confirm('确定提交吗？')) return;
    var data = { obj: obj }
    $.ajaxWebService("Save", data, function (result) {
        var o = result.d || new Object();
        if (o.success > 0) {
            window.returnValue = o;
            window.close();
        } else {
            alert(o.msg);
            $('#btnsubmit').removeAttr('disabled');
        }
    }, {
        beforeSend: function () {
            $('#btnsubmit').attr('disabled', 'disabled');
        }
    });
}

// 表单验证
var e_chkform = e_chkform || function() {
    return true;
}
// cancel
var e_cancel = e_cancel || function() {
    window.returnValue = null;
    window.close();
}