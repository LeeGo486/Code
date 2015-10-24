
$(function () {
    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=MDM2',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(XLSX|xlsx|xls|XLS)$/.test(ext))) {
                alert('只能上传excel格式', '系统提示');
                return false;
            }
            // change button text, when user selects file
            button.val('文件上传中');
            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('上传');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

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
                    $("#txtFile").val(result[0].rows[0].message);
                    //$('#txtimgupload').html("");
                    //var value = result[0].rows[0].message;
                    //var strSmallImg = value.substr(0, value.length - 4) + "small" + value.substr(value.length - 4);
                    //$("<img style='width:150px;height:90px'/>").appendTo($('#txtimgupload')).attr("src", strSmallImg);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });
    //文件上传相关-----------------
})