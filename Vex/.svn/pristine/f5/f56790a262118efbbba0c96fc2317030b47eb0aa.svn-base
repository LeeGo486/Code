// 名称：EhrShopPayImport.js
// 说明：EHR店铺工资导入
// 创建人：郭琦琦
// 创建日期：2014-10-10

var m_month = [{ "id": 1, "text": "1月" }, { "id": 2, "text": "2月" }, { "id": 3, "text": "3月" }, { "id": 4, "text": "4月" }, { "id": 5, "text": "5月" }, { "id": 6, "text": "6月" },
            { "id": 7, "text": "7月" }, { "id": 8, "text": "8月" }, { "id": 9, "text": "9月" }, { "id": 10, "text": "10月" }, { "id": 11, "text": "11月" }, { "id": 12, "text": "12月" }];

$(function () {
    //上传初始化
    UpFiles();

    var nowDate = new Date();
    var m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    var m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//当年


    $('#txtyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Lastyeay, "text": m_Lastyeay }],
        panelHeight: 'auto',
        editable: false
    })

    $('#txtmonth').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_month,
        panelHeight: 'auto',
        editable: false,
        required: true
    })

});

//文件上传的方法
function UpFiles() {
    //文件上传相关-----------------
    var btnUpExcel = $('#txtBrowseUp'), interval;

    new AjaxUpload(btnUpExcel, {
        action: '/Handler_3S.ashx?filePath=3S&ExcelImport=true',
        data: { "WSID": "9a8180de-191f-4403-a84e-0744fd0d4ffd", "XML": GetGetJson('', 'EHRForShopPayImportSQL') },
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
            //var k = response.replace("<pre>", "").replace("</pre>", "");
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    var errormessage = result[0].rows[1].message;

                    $.messager.progress('close');

                    alert(result[0].rows[0].message + '\r' + errormessage);
                }
                else {
                    //$("#txtRoute").val(result[0].rows[0].message);
                    $.messager.alert("提示", result[0].rows[0].message);
                    $.messager.progress('close');
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

        }
    });
    //文件上传相关-----------------
};


function Upload() {
    window.open("/DownLoad/工资导入格式.xlsx", "newwindow", "");
}

function onDelete() {
    $('#divEdit').window({
        title: "删除数据",
        top: 100
    }).window('open');
}


//增加提交
function submit() {
    $('#form_Delete').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Delete').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            var data = [];

            data[data.length] = { "name": "txtyear", "value": $('#txtyear').combobox('getValue') };
            data[data.length] = { "name": "txtmonth", "value": $('#txtmonth').combobox('getValue') };

            var XMLData = GetFormJson(data, 'deletedata');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('9a8180de-191f-4403-a84e-0744fd0d4ffd'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        } else if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.progress('close');
                            $('#divEdit').window('close')
                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.progress('close');

                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    });
}


function cancel() {
    $('#divEdit').window('close')
}