$(function () {
    $(':button[name="ok"]').click(e_save);
    $(':button[name="cancel"]').click(e_cancel);

    $(document).bind('keydown', 'f5', e_save);
    $(document).bind('keydown', 'esc', e_cancel);

    $("#start").keydown(function () {
        var key = event.keyCode;
        if (key >= 48 && key <= 57 || key == 8) {
            return true;
        } else {
            return false;
        }
    }).click(function () {
        $(this).select();
    });
});
function e_save() {
    var depotids = [];
    var t = $.QueryString().act;
    $('#RightSelector option').each(function() {
        depotids.push(this.value);
    });
    var obj = { depotids: depotids, t: t };
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("Save", obj, function(result) {
        var obj = result.d || new Object();
        if (obj.success == 1) {
            window.returnValue = true;
            window.close();
        } else {
            alert(obj.msg);
        }
    });
}

function e_cancel() {
    window.returnValue = false;
    window.close();
}