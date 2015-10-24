// 名称：EhrCouseImport.js
// 说明：导入
// 创建人：郭琦琦
// 创建日期：2015-01-19
var courseid = "";
var type = "";
$(function () {
    //上传初始化

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }

    //courseid = 'a77fc116-00f0-4f13-bb49-e95e929f8ee9';
    //type = '2';
    courseid = getQueryString("courseid");
    type = getQueryString("type");

    UpFiles();
});

//文件上传的方法
function UpFiles() {
    var data = [];
    data[data.length] = { "name": "txtcourseid", "value": courseid };
    data[data.length] = { "name": "txttype", "value": type };

    //文件上传相关-----------------
    var btnUpExcel = $('#txtBrowseUp'), interval;

    new AjaxUpload(btnUpExcel, {
        action: '/Handler_3S.ashx?filePath=3S&ExcelImport=true',
        data: { "WSID": "9a8180de-191f-4403-a84e-0744fd0d4ffd", "XML": GetFormJson(data, 'EhrCouseImportSQL') },
        name: 'myfile',
        onSubmit: function (file, ext) {
            $.messager.progress({ title: '请稍后', msg: '请耐心等待' });
            if (!(ext && /^(xls|xlsx)$/.test(ext))) {
                $.messager.progress('close');
                alert('文件格式不正确,请选择 xls,xlsx 格式的文件!', '系统提示');
                return false;
            }

            btnUpExcel.text('浏览');

            this.disable();
            interval1 = window.setInterval(function () {
                var text = btnUpExcel.text();
                if (text.length < 1) {
                    btnUpExcel.text(text + '.');
                } else {
                    btnUpExcel.text('浏览');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            btnUpExcel.text('浏览');

            window.clearInterval(interval1);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");
            $.messager.progress('close');

            if (k.indexOf("True") > -1) {
                $.messager.alert("提示", "成功");
            } else {
                $.messager.alert("提示", "失败");
            }

            //一下google 不支持
            //try {
            //    var result = eval("[" + k + "]");
            //    if (result[0].Error) {
            //        $.messager.progress('close');

            //        $.messager.alert("系统错误", result[0].Error, 'error');
            //    }
            //    else if (result[0].rows[0].result == "False") {
            //        //var errormessage = result[0].rows[0].message;
            //        $.messager.progress('close');

            //        alert("异常!请联系信息管理部");
            //    }
            //    else {
            //        //$("#txtRoute").val(result[0].rows[0].message);
            //        $.messager.alert("提示", "成功");
            //        $.messager.progress('close');
            //    }
            //} catch (ex) {
            //    $.messager.progress('close');

            //    $.messager.alert("提示", ex, 'error');
            //}

        }
    });
    //文件上传相关-----------------
};
function Upload() {
    window.open("/DownLoad/课程人员导入模版.xlsx", "newwindow", "");
}