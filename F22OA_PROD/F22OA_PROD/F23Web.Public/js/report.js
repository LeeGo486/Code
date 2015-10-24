
var st = null, qtimer = null, rsTimer;


var e_chkform = e_chkform || function() {
    return true;
}

var e_query = e_query || function() {
    if (e_chkform()) {
        GridControl1.fnReloadAjax();
    }
}

function getparams() {
    return $(".field").serializeObject();
}

function query(url, data, callback) {

    if (qtimer) { qtimer.abort(); qtimer = null; } //中断上一次的请求

    if (url.indexOf('/') == -1) {
        url = location.href.split('?')[0].split('#')[0] + '/' + url;
    }
    var d = {}
    if (data == null) {
        var a = [];
        var cols = this.aoColumns == null ? this.fnSettings().aoColumns : this.aoColumns;
        $.each(cols, function(i, o) {
            a.push(o.sName);
        });
        d.sColumns = a.join(',');
    } else {
        $.each(data, function(i, obj) {
            d[obj["name"]] = obj["value"];
        });
    }

    // 界面查询条件
    var obj = $(".field").serializeObject();
    $.extend(d, obj);
    d = $.toJSON({ aps: d });

    qtimer = $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: d,
        dataType: "json",
        complete: function(json) {

        },
        success: callback,
        error: function(xml, str) {
            alert(xml.responseText);
        }
    });
}

function e_selstyle() {
    $.openModal('/public/StyleSelector.aspx', '600px', '460px')
}
function e_seldepot() {
    $.openModal('/public/DepotMultiSelector.aspx?action=powerdepot&type=pos', '600px', '460px')
}
function e_selmerchant() {
    $.openModal('/public/MerchantMultiSelector.aspx?action=getmerchant', '600px', '460px')
}
// 导出
var e_export = e_export || function () {
    var data = GridControl1.fnGetExportData();
    $.output('excel', data);
}
