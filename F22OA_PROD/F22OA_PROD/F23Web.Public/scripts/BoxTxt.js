$(function () {
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    $(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');
    $("#czid").val($.QueryString().czid);
    $("#importtype").val($.QueryString().importtype);

    e_load();

    $('.numeric')
    .numeric()
    .focus(function () { $(this).select(); })
    .bind('keyup', changedemo);

    //$("#msg").focus(function () { $(this).select(); });
});

function changedemo() {

    var tid = $("#testid").val();

    if (!tid) return;

    var txt_cut = $("#txt_cut").val() || 0;
    var txt_split = $("#txt_split").val() || ',';

    var arr = tid.split(txt_split);
    var boxid = arr[0]
    var clothignid = arr[1]
    var nums = arr[2]
    var len = clothignid.length - parseInt(txt_cut)

    if (parseInt(txt_cut) < clothignid.length) {
        clothignid = clothignid.substring(0, len);
    }

    var html = '<b>取样：</b>箱号："' + boxid + '"，款号："' + clothignid + '"，数量："' + nums + '"';
    $("#demo").html(html);
    $("#divdemo").show();
}

function e_load() {
    $.ajaxWebService('GetSysControl', {}, function (result) {
        result = result.d || {};
        if (result) {
            $("#txt_split").val(result["txt_split"]);
            $("#txt_cut").val(result["txt_cut"]);
        } else {
            alert("参数错误!");
        }
    });
}

var e_ckhform = e_ckhform || function () {
    if ($("#filename").val() == "") {
        alert("请先上传文件!");
        return false;
    }
    if ($("#txt_split").val() == "") {
        alert("请输入分隔符!");
        $("#txt_split").focus();
        return false;
    }
    if ($("#txt_cut").val() == "") {
        alert("请输入截取长度!");
        $("#txt_cut").focus();
        return false;
    }
   
    return true;
}

var ajax = null, isError = false;
function e_submit() {
    if (!e_ckhform()) return;
    $("#divmsg").hide();
    if ($('button[name="save"]').is('[disabled]')) return;
    $("#id").val($.QueryString().id);

    var obj = $(".field").serializeObject();

    var data = { obj: obj };
    //alert($.toJSON(obj));return;
    ajax = $.ajaxWebService('ReadData', data, function (result) {
        result = result.d || {};
        if (result.success > 0) {
            importdata(obj);
        } else {
            isError = true;
            $("#divmsg").show();
            $("#msg").val(result.msg);
            $('#btnsubmit').text('继续导入').attr('title', '当前文件存未识别的条码')
            .removeAttr('disabled').unbind('click').bind('click', function () {
                importdata(obj);
            })
            $.unmask();
        }
    }, {
        beforeSend: function () {
            $('#btnsubmit').attr('disabled', 'disabled').text('请稍等...')
            $.mask('正在提取文本数据...', ajax);
        }
    });
}

function importdata(data) {

    ajax = $.ajaxWebService('ImportData', data, function (result) {
        result = result.d || {};

        //alert($.toJSON(result));
        if (result.success > 0) {
            //$("#divmsg").hide();
            window.returnValue = true;
            window.close();
        } else {
            $("#divmsg").show();
            $("#msg").val(result.msg);
            $.unmask();
        }
    }, {
        beforeSend: function () {
            if (isError) {
                $.mask('正在导入数据...', ajax);
            } else {
                $('#loading-mask>span:first').text('正在导入数据...')
            }
        },
        complete: function () {
            $.unmask();
        }
    });
}

function e_cancel() {
    window.close();
}

//载入中的GIF动画
var loadingUrl = "../Public/images/loading.gif";

//选择文件后的事件,iframe里面调用的
var uploading = function (imgsrc) {
    var el = $("#uploading");
    $("#ifUpload").hide();
    el.show();
    el.html("<img src='" + loadingUrl + "' align='absmiddle' /> 上传中...");
    return el;
};

//重新上传方法
var uploadinit = function () {
    //var id = $.QueryString().id;
    //var importtype = $.QueryString().importtype;
    //var url = window.location.href.split('?')[0] + "?id=" + id + "&importtype=" + importtype;
    //$('form:first').attr('action', url).unbind('submit').submit();
    $("#ifUpload").show();
    $("#uploading").hide();
    ifUpload.location = "upload.aspx?filetype=txt";

};

//上传时程序发生错误时，给提示，并返回上传状态
var uploaderror = function () {
    //uploadinit();
};

//上传成功后的处理
var uploadsuccess = function (filename, tid) {
    var html;
    var clothingid;
    var nums;
    $("#uploading").html("文件上传成功.<a href='javascript:void(0);' onclick='uploadinit();'>[重新上传]</a>");
    $("#filename").val(filename);
    $("#testid").val(tid);
    changedemo();
};