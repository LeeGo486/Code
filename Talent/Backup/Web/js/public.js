$.ajaxWebService = function (url, dataMap, fnSuccess) {  //自定义webservices 方法
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: dataMap,
        async: false,
        dataType: "json",
        success: fnSuccess,
        error: function (XMLHttpRequest, textStatus, errorThrown) { alert("出现错误，请稍后！"); }
    });
}

jQuery.validator.addMethod("moneyCheck", function (value, element) {
    return this.optional(element) || /^[1-9][0-9]*(\.)?([0]){0,5}$|^[0-9](\.)?([0]){0,5}$/.test(value);
}, "请输入整数金额");

function switchjs(obj) {
    var str = $(obj).val();
    str = str.replace(/,/g, "，");
    str = str.replace(/"/g, "“");
    str = str.replace(/'/g, "‘");
    $(obj).val(str);
}