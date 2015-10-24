var idx = 0; isload = false;
$(function () {

    try {
        //可否选择自己
        $("#allowself").val($.QueryString().allowself);
    } catch (e) {
    }

    $("#tabs").tabs();
    $('#tabs').bind('tabsselect', function (event, ui) {
        idx = ui.index;
        if (idx == 1 && !isload) {
            isload = true;
            expandtree();
            loaddptuser();
        }

        if (idx == 0) {
            if (idx == 0) {
                setTimeout(function () {
                    GridControl1.fnAdjustColumnSizing();
                }, 0)
            }
            $("#key").focus();
        }
    });

    $("#key")
    .focus(function () {
        $(this).select();
        $(':radio[name="usertype"]').attr("readonly", "readonly");
    })
    .blur(function () {
        $(':radio[name="usertype"]').removeAttr("readonly", "readonly");
    })
    .bind("keydown", "return", e_query)
    .focus();
    $('#btnsubmit').removeAttr('disabled');

    window.setTimeout(function () { $("#key").focus(); }, 0)

});

function expandtree() {
    AjaxTreeView1.reflash("tree_0");
}

function e_query() {
    GridControl1.fnReloadAjax();
    $("#key").focus();
}

function getparams() {
    return $(".field").serializeObject();
}

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

//加载本部门人员
function loaddptuser() {
    $.ajaxWebService("GetUserDepartId", {}, function (result) {
        var obj = result.d || new Object();
        if (obj != "") {
            var data = { act: "getorgpersonnelstruct", value: "0^" + obj, allowself: $("#allowself").val() };
            _ajax = MultiSelector1.fnAjaxLoad(data);
        } else {
            alert("加载发生异常!");
        }
    });
}
// 
function getSelectedValues() {
    var s = AjaxTreeView1.getCheckedNodes();
    return s.join('$');
}
//save 
function e_save(obj) {
    return false;
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

// submit 
function e_submit() {
    var isupdate = 0;
    var d = [];
    var t = [];
    if (idx == 0) {
        var rows = GridControl1.fnGetSelected();
        // if (rows.length != 1) { alert("请选择一条记录!"); return ''; };
        var data = GridControl1.fnGetData(rows[0]);
        $.each(rows, function (i, row) {
            var arr = GridControl1.fnGetData(row);
            d.push(arr[0]);
            t.push(arr[1]);
        });
    } else {
        d = MultiSelector1.fnGetSelected();
        t = MultiSelector1.fnGetSelectedText();
        isupdate = 0;
        //        if ($.QueryString().type == "filelend") {
        //            var str = "myVar   =   msgbox('借阅人是否可以修改文件？',VbYesNo   +   VbQuestion   +   vbDefaultButton1,'确认')";
        //            window.execScript(str, "vbscript");
        //            if (myVar == "6") {
        //                isupdate = 1;
        //            } else {
        //                isupdate = 0;
        //            }
        //        } else       
        if ($.QueryString().selecttype != "Multiple") {
            if (d.length > 1) { alert("只能单选!"); return false; }
        }
    }
    var data = { isupdate: isupdate, users: d, usernames: t };
    window.returnValue = $.toJSON(data);
    window.close();
}

// cancel
function e_cancel() {
    window.returnValue = "";
    window.close();
}