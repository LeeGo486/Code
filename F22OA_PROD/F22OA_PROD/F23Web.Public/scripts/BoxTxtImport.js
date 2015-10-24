$(function () {
    $('button[name="save"]').click(e_submit);
    $('button[name="cancel"]').click(e_cancel);
    $(document).bind('keydown', 'esc', e_cancel);
    $(document).bind('keydown', 'return', e_submit);
    $('#btnsubmit').removeAttr('disabled');
    $("#txtboxid").text("当前箱号：" + $.QueryString().boxid);
    $("#boxid").val($.QueryString().boxid);

    $(":radio[name='split']").bind('click', function () {
        var v = $('input:radio[name="split"]:checked').val();
        //splitchang(v);
        changedemo();
    });

    e_load();

    //
    $('.numeric')
    .numeric()
    .focus(function () { $(this).select(); })
    .bind('keyup', changedemo);

    $("#msg").focus(function () { $(this).select(); });
});

function changedemo() {

    var tid = $("#testid").val();

    if (!tid) return;
    var v = $('input:radio[name="split"]:checked').val();
    var clothingid_beg = parseInt($("#clothingid_beg").val()) - 1;
    var clothingid_len = parseInt($("#clothingid_len").val());
    var num_beg = parseInt($("#num_beg").val()) - 1;
    var num_len = parseInt($("#num_len").val());

    var clothingid = "", nums = "";

    if (v == 0) {
        if ((clothingid_beg + clothingid_len) > tid.length) { clothingid_len = tid.length; }
        if ((num_beg + num_len) > tid.length) { num_len = tid.length; }
        clothingid = tid.substr(clothingid_beg, clothingid_len);
        nums = tid.substr(num_beg, num_len);
    } else {
        clothingid = tid.split(',')[$("#clothingid_loc").val() - 1];
        clothingid = clothingid == undefined ? '' : clothingid.substr(0, clothingid_len);
        nums = tid.split(',')[$("#num_loc").val() - 1];
        nums = nums == undefined ? '' : nums.substr(0, num_len);
    }

    clothingid = clothingid == undefined ? '' : clothingid;
    nums = nums == undefined ? '' : nums;

    html = '<b>取样：</b>款号：“' + clothingid + '”，数量：“' + nums + '”';
    $("#demo").html(html);
    $("#divdemo").show();
}

function e_load() {
    $.ajaxWebService('GetSysControl', {}, function (result) {
        result = result.d || {};
        if (result) {
            $("#clothingid_beg").val(result["pd_clothingid_beg"]);
            $("#clothingid_len").val(result["pd_clothingid_len"]);
            $("#num_beg").val(result["pd_num_beg"]);
            $("#num_len").val(result["pd_num_len"]);
            $("#clothingid_loc").val(result["pd_clothingid_loc"]);
            $("#num_loc").val(result["pd_num_loc"]);
            //splitchang(result["pd_separator"]);
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
    if ($("#clothingid_beg").val() == "") {
        alert("请输入款式起始位!");
        $("#clothingid_beg").focus();
        return false;
    }
    if ($("#clothingid_len").val() == "") {
        alert("请输入款式长度!");
        $("#clothingid_len").focus();
        return false;
    }
    if ($("#num_beg").val() == "") {
        alert("请输数量起始位!");
        $("#num_beg").focus();
        return false;
    }
    if ($("#num_len").val() == "") {
        alert("请输入数量长度!");
        $("#num_len").focus();
        return false;
    }
    if ($("#clothingid_loc").val() == "") {
        alert("请输入款号位置!");
        $("#clothingid_loc").focus();
        return false;
    }
    if ($("#num_loc").val() == "") {
        alert("请输入数量位置!");
        $("#num_loc").focus();
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
    $("#type").val($.QueryString().importtype);
    $("#target").val($.QueryString().importtarget);
    $("#reprice").val($.QueryString().importreprice);
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