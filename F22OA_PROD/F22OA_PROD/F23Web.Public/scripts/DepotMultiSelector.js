$(function () {
    $('#btnsubmit').removeAttr('disabled');

});
function e_change(obj) {
    var data = MultiSelector1.oSettings.data;
    data.value = $(this).val(); 
    MultiSelector1.fnAjaxLoad(data);

}

function e_save(obj) {

    var str = MultiSelector1.oSettings.data.value == "2" ? "UpdateAreaSelection" : "UpdateSelection";

    //alert($.toJSON(obj));
    $.ajaxWebService(str, obj, function (result) {
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

    var p = $.QueryString();

    MultiSelector1.fnSubmit(p);
}

function e_cancel() {
    window.returnValue = false;
    window.close();
}
