var idx = 0;
$(function () {
    $("#tabs").tabs();
    $('#tabs').bind('tabsselect', function (event, ui) {
        idx = ui.index;
    });

    $('#btnsubmit').removeAttr('disabled');

    $('#btnyears').bind('click', function () {
        SelectAll("#years option");
    });
    $('#btnunyears').bind('click', function () {
        UnSelectAll("#years option");
    });

    $('#btnmonths').bind('click', function () {
        SelectAll("#months option");
    });
    $('#btnunmonths').bind('click', function () {
        UnSelectAll("#months option");
    });

    $('#btnzl').bind('click', function () {
        SelectAll("#zl option");
    });
    $('#btnunzl').bind('click', function () {
        UnSelectAll("#zl option");
    });

    $('#btndl').bind('click', function () {
        SelectAll("#dl option");
    });
    $('#btnundl').bind('click', function () {
        UnSelectAll("#dl option");
    });

    $('#btnxl').bind('click', function () {
        SelectAll("#xl option");
    });
    $('#btnunxl').bind('click', function () {
        UnSelectAll("#xl option");
    });

    $('#btnbrand').bind('click', function () {
        SelectAll("#brandid option");
    });
    $('#btnunbrand').bind('click', function () {
        UnSelectAll("#brandid option");
    });

    $('#btnsex').bind('click', function () {
        SelectAll("#sex option");
    });
    $('#btnunsex').bind('click', function () {
        UnSelectAll("#sex option");
    });

    $('#btnbd').bind('click', function () {
        SelectAll("#bd option");
    });
    $('#btnunbd').bind('click', function () {
        UnSelectAll("#bd option");
    });
});

function SelectAll(name) {
    $(name).each(function () {
        this.selected = true;
    });
}
function UnSelectAll(name) {
    $(name).each(function () {
        this.selected = false;
    });
}

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
    if (idx == 0) {
        MultiSelector1.fnSubmit();
    } else {
        var d = $(".field").serializeObject();
        var obj = { aps: d };
        $.ajaxWebService("UpdateSelectionOther", obj, function (result) {
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
}

function e_cancel() {
    window.returnValue = false;
    window.close();
}