var rsTimer, currentRow, currentAjax, isEditMode;
$(function () {
    //  window.setTimeout(e_query, 300);
});

function e_query() {
    GridControl1.fnReloadAjax();
    // parent.progress(100);
    // parent.$('.st_field').removeClass('disabled');
    //query();
}

var getparams = getparams || function () {
    return $(".field").serializeObject();
}

//var loaded = false;
function query(url, data, callback) {

    if (currentAjax) { currentAjax.abort(); currentAjax = null; } //中断上一次的请求

    var obj = arrToObject(data);
    var d = getparams(obj); // 界面查询条件
    $.extend(d, $.QueryString()); // 传入参数
    $.extend(d, obj);

    d = $.toJSON({ aps: d });

    // call ajax
    currentAjax = $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: d,
        dataType: "json",
        success: function (obj) {
            if (obj != null) {
                //alert($.toJSON(obj));
                callback.call(this, obj);
            }
        },
        error: function (xml, str) {
            if (xml.responseText != "") {
                alert(xml.responseText);
            }
        }
    });
}


function arrToObject(arr) {
    var obj = new Object();
    for (var i = 0; i < arr.length; i++) {
        var key = arr[i].name;
        obj[key] = arr[i].value;
    }
    return obj;
}


// 导出
function e_export() {

    var data = $.QueryString();

    $.ajaxWebService('ExportData', data, function (obj) {
        $('.loading-mask-panel', '#loading-mask')
    .html('<a href="#close" style="float:right;">[关闭]</a>'
    + '<span>文件生成成功！请<a href="' + obj.d + '" target="_blank">点击此处</a>下载</span>')
    .find('A').click($.unmask);
    }, {
        beforeSend: function () {
            $.mask('正在导出，请稍等。。。');
        }
    });
}

function e_exporttxt() {
    $.mask('');
    $('.loading-mask-panel', '#loading-mask')
    .html('<label><input type="radio" name="t" value="1" checked/> 用逗号分隔</label>&nbsp;&nbsp;&nbsp;'
    + '<label><input type="radio" name="t" value="0"/>自定义</label><input type="text" style="width:40px" id="txttype" />'
    + '&nbsp;&nbsp;<a href="javascript:exporttxt()">[导出]</a>&nbsp;&nbsp;<a id="aclose" href="#close">[关闭]</a>').find('A[id="aclose"]').click($.unmask);
    //showModalDialog('export.aspx', window, 'dialogHeight:200px;dialogWidth:300px;center:yes;help:no;resizable:no;status:no');
}

function exporttxt() {
    var data = $.QueryString();
    var type = $("input:radio[name='t'][checked]").val();
    var splitStr = "";
    if (type == "1") {
        splitStr = ",";
    } else {
        splitStr = $("#txttype").val();
    }
    if (splitStr == "") {
        splitStr = ",";
    }
    data["t"] = splitStr;
    $.ajaxWebService('ExportDataTxT', data, function (obj) {
        $('.loading-mask-panel', '#loading-mask')
        .html('<a href="#close" style="float:right;">[关闭]</a>'
        + '<span>文本生成成功！请<a href="Export.aspx?filename=' + obj.d + '">点击此处</a>下载</span>')
        .find('A').click($.unmask);
    }, {
        beforeSend: function () {
            $('.loading-mask-panel', '#loading-mask').html('正在导出，请稍等。。。');
        }
    });
}

function ShowDialog() {

    var columnIndex = GridControl1.fnGetColumnIndex("STYLEID");
    if (columnIndex == -1) {
        columnIndex = GridControl1.fnGetColumnIndex("CLOTHINGID");
    }
   
    if (columnIndex == -1) {
        return;
    }

    var id = GridControl1.fnGetSelectedIds(columnIndex);
    if (id) {
        var m = $.openModal('/public/showstyle.aspx?id=' + id, '630px', '360px');
    }
 
}