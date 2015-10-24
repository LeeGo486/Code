$(function() {
    var butname = $.QueryString().butname || '修&nbsp;&nbsp;正';

    $('#btnsubmit').removeAttr('disabled').html(butname);

});
function e_submit() {
    var obj = $.QueryString();
    $.ajaxWebService("SetModify", obj, function(json) {
        json = json.d || {};
        if (json.success > 0) {
            alert(json.msg);
            window.returnValue = json;
            window.close();
        } else {
            alert(json.msg);
        }
    });
}
function e_cancel() {
    window.returnValue = null;
    window.close();
}

function initcomplete() {
    var that = this;
    $(window).bind('resize', function() {
        that.fnAdjustColumnSizing();
        that.AdjustScrollLayout();
    }).trigger('resize');
}
