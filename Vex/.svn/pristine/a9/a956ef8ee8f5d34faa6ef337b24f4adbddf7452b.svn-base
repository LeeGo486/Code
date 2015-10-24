
$(function () {
    var button = $('#btnUp'), interval;
    button.text('上传图片(只允许上传JPG,GIF,PNG格式的图片,大小不得大于4M)');

    new AjaxUpload(button, {
        action: '/Handler.ashx?filePath=HZY_mat',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeggif|bmp|png|xls|xlsx)$/.test(ext))) {
                alert('图片格式不正确,请选择 jpg,gif,png 格式的文件!', '系统提示');
                return false;
            }

            // change button text, when user selects file
            button.text('文件上传中');

            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();

            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.text();
                if (text.length < 10) {
                    button.text(text + '.');
                } else {
                    button.text('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.text('上传图片(只允许上传JPG,GIF,PNG格式的图片,大小不得大于4M)');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {

                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#txtFileName").val(result[0].rows[0].message);

                    $("<img />").appendTo($('#imglist')).attr("src", result[0].rows[0].message);

                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

        }
    });



    var btnUpExcel = $('#btnUpExcel'), interval1;
    btnUpExcel.text('Excel导入(只允许上传 xls,xlsx格式的文件)');
    
    new AjaxUpload(btnUpExcel, {
        action: '/Handler.ashx?filePath=HZY_mat&ExcelImport=true',
        data: { "WSID": "1feb3f48-4baf-4f1e-914d-164bee30959c", "XML": GetGetJson([{ "entity": "entity" }]) },
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(xls|xlsx)$/.test(ext))) {
                alert('文件格式不正确,请选择 xls,xlsx 格式的文件!', '系统提示');
                return false;
            }

            // change button text, when user selects file
            btnUpExcel.text('处理中');

            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();

            // Uploding -> Uploading. -> Uploading...
            interval1 = window.setInterval(function () {
                var text = btnUpExcel.text();
                if (text.length < 10) {
                    btnUpExcel.text(text + '.');
                } else {
                    btnUpExcel.text('text');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            btnUpExcel.text('Excel导入(只允许上传 xls,xlsx格式的文件)');

            window.clearInterval(interval1);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {

                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#txtFileName").val(result[0].rows[0].message);

                    $("<img />").appendTo($('#imglist')).attr("src", result[0].rows[0].message);

                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }

        }
    });


});
