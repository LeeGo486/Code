$(function () {
    $('#btnsubmit').removeAttr('disabled');
});

function e_save(obj) {
    $.ajaxWebService("UpdateSelection", obj, function (result) {
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

function e_submit() {
    MultiSelector1.fnSubmit();
}

function e_cancel() {
    window.returnValue = false;
    window.close();
}