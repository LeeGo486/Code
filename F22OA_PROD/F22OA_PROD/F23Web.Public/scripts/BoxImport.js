$(function () {
    $("#id").val($.QueryString().id);
    $("#outid").text($.QueryString().id);
    //$("#getdptid").val($.QueryString().dptid);
    // $("#getdpt").text("[" + $.QueryString().dptid + "]" + unescape($.QueryString().dptname));

    $("#btnclose").click(function () { window.close(); });

    $(".para:eq(0)").numeric({ allow: '-' });
    $(".para:eq(1)").numeric();
    $(".para").click(function () {
        $(this).select();
    }).blur(function () {
        if (isNaN($(this).val())) {
            alert("只能输入数字！");
            $(this).focus();
            $(this).select();
        } else if ($(this).val() == "") {
            $(this).val(0);
        }
    });

    $("#clothingid").bind("keydown", function () {
        if (event.keyCode == 13) {
            addClothing();
        }
    });

    $("#clothingid").focus();

    $("#btnadd").click(function () {

        //addClothing();
        var id = $.QueryString().id;
        var importtype = $.QueryString().importtype;
        var m = $.openModal("readbox.aspx?id=" + id + "&importtype=" + importtype, '950px', '500px');
        if (m) {
            e_query();
        }
    });

    $("#boxtm").change(function () {
        if ($(this).val() == "") return false;
        saveboxtm();
    }).click(function () { $(this).select(); });

    //获取装箱合计数
    getBoxSnums();
});

function btnSureInput() {

    if (!confirm("确认生成单据明细,将会删除原有明细记录?")) {
        return false;
    }
    var czid = $.QueryString().id;
    var obj = { czid: czid };
    $.ajaxWebService("AjaxSureInput", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            alert("生成单据明细成功!");
            returnValue = true;
            window.close();
        } else {
            alert(m.msg);
        }
    });
}

function addClothing() { 
    var czid = $.QueryString().id;
    var clothingid = $("#clothingid").val();
    var nums = $("#nums").val();
    var chktm = $("#chktm").attr("checked");
    var sub = $("#sub").val();

    if (clothingid == "") {return false;}

    var rows = GridControl1.fnGetSelected();
    var boxid = $(rows[0]).find('td:first').text();
    if (!boxid) {
        alert("请先添加箱！");
        return false;
    }

    if (clothingid.length <=parseInt(sub)) {
        alert("条码截取位数不正确！");
        return false;
    }

    if (parseInt(nums) == 0) {
        return false;
    }
    var obj = {
        czid:czid,
        boxid: boxid,
        clothingid: clothingid,
        nums: nums,
        chktm: chktm,
        sub: sub,
        depotid: $(".getdptid").val(),
        importtype: $.QueryString().importtype
    };
    $.ajaxWebService("addClothing", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            //  GridControl2.fnReloadAjax();
            $("#clothingid").val('');

            var n = parseInt($("#log").text()) + parseInt(nums);
            $("#log").text(n);

            var snums = parseInt($("#spsnum").text()) + parseInt(nums);
            $("#spsnum").text(snums);
            e_added(m.obj);
        } else {
            alert(m.msg);
        }
        $("#clothingid").select();
        $("#clothingid").focus();
    });
}

// 添加完成
var e_added = e_added || function (obj) {
    if (!obj) { return; }
    var _d = [];
    $.each(GridControl2.fnSettings().aoColumns, function (i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o);
    });
    var i = GridControl2.dataTable().fnAddData(_d);
    //  fnSelectRow(i);

    var rows = GridControl2.fnGetNodes();
    $(rows[i]).addClass('row_selected').siblings().removeClass('row_selected');

    var body = $('.dataTables_scrollBody', '#GridControl2_table_wrapper');
    var top = $(rows[i]).offset().top;
 
    if (top >= 520) {
        body.scrollTop((body.scrollTop() || 0) + $(rows[i]).offset().top - 20);
    }
}

function boxRowSelect() {
    var rows = GridControl1.fnGetSelected();
    var id = $(rows[0]).find('td:first').text();
    $("#boxid").text(id);
    $("#sellbox").val(id);
    GridControl2.fnReloadAjax();
    getboxtm(id);
}

//获取条码编号
function getboxtm(boxid) {
    var obj = { czid: $.QueryString().id, boxid: boxid };
    $.ajaxWebService("getBoxTm", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            $("#boxtm").val(m.msg);
        } else {
            alert(m.msg);
        }
    });
}

//更新条码编号
function saveboxtm() {
    var obj = { czid: $.QueryString().id, boxid: $("#boxid").text(),boxtm:$("#boxtm").val() };
    $.ajaxWebService("SaveBoxTm", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {

        } else {
            alert(m.msg);
            $("#boxtm").val('');
            $("#boxtm").focus();
        }
    });
}

function e_query() {
    GridControl1.fnReloadAjax();
}

//加载完后选择一条记录
function grdcomplete() {
    var rows = GridControl1.fnGetNodes();
    $(rows[rows.length - 1]).addClass('row_selected');
    boxRowSelect();

}

//获取装箱合计数
function getBoxSnums() {
    var obj = { id: $.QueryString().id };
    $.ajaxWebService("getBoxSnums", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            $("#spsnum").text(m.msg);
        }
    });
}

//添加
function addBox() {
    var obj = {  id: $.QueryString().id  };
    $.ajaxWebService("addBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            e_query();
        } else {
            alert(m.msg);
        }
    });
}

//删除
function delBox() {
    var rows = GridControl1.fnGetSelected();
    var obj = {
        id: $.QueryString().id,
        sellbox: $(rows[0]).find('td:first').text()
    };
    if (!obj.sellbox) return;
    if (!confirm('确定要删除吗？')) return;
    $.ajaxWebService("delBox", obj, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            e_deleted(rows[0]);
            getBoxSnums();
        } else {
            alert(m.msg);
        }
    });
}


// 删除完成
var e_deleted = e_deleted || function (obj) {
    if (!obj) { return; }
    var i = fnGetSelectedRowIndex();
    fnSelectRow(i+1);
    GridControl1.fnDeleteRow(obj);
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

function fnSelectRow(i) {
    var rows = GridControl1.fnGetNodes();
    if (i >= rows.length) { i = rows.length - 2; }
    if (i < 0) { return; }
    $(rows).removeClass('row_selected');
    $(rows[i]).addClass('row_selected');
    boxRowSelect();
}

//打印装箱单
function PrintBox(act) {
    var czid = $.QueryString().id;
    var boxid = $("#sellbox").val();
    var m = $.openModal("BoxImportPrint.aspx?act=" + act + "&czid=" + czid + "&boxid=" + boxid, '800px', '450px');
}

function btncopy() {
    var id = $.QueryString().id;
    var importtype = $.QueryString().importtype;
    var m = $.openModal("copybox.aspx?id=" + id + "&importtype=" + importtype, '950px', '500px');
    if (m) {
        e_query();
    }
}


//文本导入
function BoxTxtImport() {
    var id = $.QueryString().id;
    var boxid = $("#boxid").text();
    if (boxid == "" || GetSheetID() == "" || GetSheetID() == undefined) {
        alert("请选择箱号再导入!");
        return false;
    }
    var m = $.openModal("BoxTxtImport.aspx?id=" + id + "&boxid=" + boxid, '500px', '500px');
    if (m) {
        GridControl2.fnReloadAjax();
        getBoxSnums();
    }
}

//二维电子表格导入
function BoxXlsImport() {
    var m = $.openModal("BoxXlsImport.aspx?czid=" + $.QueryString().id + "&importtype=" + $.QueryString().importtype, '750px', '500px');
    if (m) {
        GridControl1.fnReloadAjax();
        getBoxSnums();
    }
}

//一维电子表格导入
function btnxlsOne() {
    var m = $.openModal("BoxXlsImportOne.aspx?czid=" + $.QueryString().id + "&importtype=" + $.QueryString().importtype, '750px', '500px');
    if (m) {
        GridControl1.fnReloadAjax();
        getBoxSnums();
    }
}

//数据分箱导入
function BoxTxtBox() {
    var m = $.openModal("boxtxt.aspx?czid=" + $.QueryString().id + "&importtype=" + $.QueryString().importtype, '500px', '500px');
    if (m) {
        GridControl1.fnReloadAjax();
        getBoxSnums();
    }
}


// 取得单号
function GetSheetID() {
    return GridControl1.fnGetSelectedIds()[0];
}