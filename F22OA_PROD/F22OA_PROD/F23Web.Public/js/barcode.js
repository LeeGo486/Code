/* 条码录入通用界面 */
/* Author : jackie 2010-05-11 创建 */
var msg = "";
$(function () {
    $(":button").click(function () { return false; });
    $(':button[name="add"]').bind('click', e_add);
    $(':button[name="reset"]').bind('click', e_reset);
    $('#btnmsg').bind('click', e_msg);

    setTimeout(e_bind, 0);

    $('.field:text').focus(function () { this.select() });
    // for ie6 
    $('#key').bind('keydown', 'return', function (e) {
        e_add();
        return false;
    }).focus();
    $('#nums,#tmln').bind('keydown', 'return', function (e) {
        $('#key').focus();
        return false;
    }).numeric();

    // 保存条码设置
    $('#tmln').bind('change', function () {
        $.post('/ajax/ajaxfoundation.ashx', { act: 'SaveBarcodeCutLenth', value: $(this).val() })
    })
});

// 表单数据绑定
var e_bind = e_bind || function () {
    var obj = {
        id: $.QueryString().id || ''
    }
    $("#id").text($.QueryString().id);
    $.ajaxWebService("Get", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            e_filldata(m.obj);
        } else {
            alert(m.msg);
        }
    });
}

var e_filldata = e_filldata || function (obj) {
    $('.info').fillFields(obj);
    $('.field').fillFields(obj);
    if (obj.m_type == undefined) {
        $('#stype').val('1');
    } else {
        var stype = $.inArray(parseInt(obj.m_type), [0, 1]) == -1 ? '3' : '2';
        $('#stype').val(stype);
    }
    $("#dtype0").attr("checked", "checked");
}

//function txtKeyPress(e) {
//    //if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;
//    var key = window.event ? e.keyCode : e.which;
//    var keychar = String.fromCharCode(key);
//    reg = /\d/;
//    return reg.test(keychar);
//}

// 录入
var e_add = e_add || function () {
    //客户端处理
    var key = $('#key').val();
    if ((!key) || (key == "")) { $('#key').focus(); return; }
    key = key.toUpperCase();
    $('#clothingid').val(key);
    $('#key').val('').focus();
    var nums = parseInt($("#nums").val());
    var dtype = parseInt($('input:radio[name="dtype"]:checked').val());
    var boxid = GetNewBoxId(key.toLowerCase());
    $("#boxid").val(boxid);
    var data = $(".field").serializeObject();
    $.ajaxWebService("add", data, function (result) {
        //alert($.toJSON(result.d)); return;
        var m = result.d || new Object();
        if (m.success == 1) {
            if (!m.obj) {
                //alert('扫描成功，但没有任何值返回！');
                SetRowNums(key);
                return;
            }
            e_deleted(GetRowById(m.obj.clothingid.toLowerCase()));
            if (m.obj) { e_added(m.obj); }
            $("#clothingid").val("");
            var n = parseInt($("#snum").text()) || 0;
            n += nums * dtype;
            $("#snum").text(n.toString(10));
            window.returnValue = true;    //关闭时返回
            $.playSound('/Public/sound/success.wav');

        } else {
            var n = parseInt($("#fnum").text()) || 0;
            n += nums * dtype;
            $("#fnum").text(n.toString(10));
            alert(m.msg);
            // modify by jackie 暂时改成直接弹出错误 2010-10-03
            //e_saveerror(key, m.msg);
            //$.playSound('/Public/sound/error.wav');
        }
        fnSelectRow(-1);
        $('#key').focus();
    });
}

// 获取最新序号
function GetNewBoxId(clothingid) {
    var maxid = 0;
    var boxid = "";
    var styleid = "";
    var rows = GridControl1.fnGetNodes();
    $.each(rows, function (i, row) {
        var m = $.string2int($('td', row).first().text());
        styleid = $('td', row).eq(2).text().toLowerCase();
        if (styleid == clothingid.toString().substring(0, styleid.length)) {
            boxid = $('td', row).first().text();
            return false;
        }
        maxid = maxid > m ? maxid : m;
    });

    if (boxid == "") {
        boxid = 'W' + $.padLeft(maxid + 1, 7);
    }
    return boxid;
}

function GetRowById(id) {
    var aTrs = GridControl1.fnGetNodes();
    for (var i = 0; i < aTrs.length; i++) {
        if ($(aTrs[i]).find('td:eq(1)').text().toLowerCase() == id) {
            return aTrs[i];
        }
    }
    return null;
}
function SetRowNums(id) {
    var id = id.toLowerCase();
    var aTrs = GridControl1.fnGetNodes();
    for (var i = 0; i < aTrs.length; i++) {
        var clothingid = $(aTrs[i]).find('td:eq(1)').text().toLowerCase();
        var len = clothingid.length;
        if (clothingid == id.substr(0, len)) {
            $(aTrs[i]).find('td:eq(7)').text(0)
        }
    }
    return null;
}

// 计数器清零
var e_reset = e_reset || function () {
    $('#snum').text('0');
    $('#fnum').text('0');
    msg = "";
}

// 取得所选列的位置
function fnGetSelectedRowIndex() {
    var idx = -1;
    var aTrs = GridControl1.fnGetNodes();
    for (var i = 0; i < aTrs.length; i++) {
        if ($(aTrs[i]).hasClass('row_selected')) {
            idx = i; break;
        }
    }
    return idx;
}

// 
function fnSelectRow(i) {
    var rows = GridControl1.fnGetNodes();
    if (i >= rows.length) { i = rows.length - 1; }
    if (i < 0) { return; }
    $(rows).removeClass('row_selected');
    $(rows[i]).addClass('row_selected');
}

// --------------------------------------
//   事件：增删改后触发的事件（行的操作）
// --------------------------------------
// 添加完成
var e_added = e_added || function (obj) {
    if (!obj) { return; }
    var _d = [];
    $.each(GridControl1.fnSettings().aoColumns, function (i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o);
    });
    GridControl1.dataTable().fnAddData(_d);
    //GridControl1.fnSort([[0, 'desc']])
}


// 删除完成
var e_deleted = e_deleted || function (obj) {
    if (!obj) { return; }
    //var i = fnGetSelectedRowIndex();
    //fnSelectRow(i + 1);
    GridControl1.fnDeleteRow(obj);
}


function e_msg() {
    if (msg == "") { msg = "当前没有扫描失败记录!"; }
    alert(msg);
}

function e_saveerror(key, message) {
    msg += "条码：" + key + "扫描失败!" + message + "\n";
}