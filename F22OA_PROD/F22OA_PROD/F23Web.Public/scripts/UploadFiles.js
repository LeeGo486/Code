$(function () {
    var param = $.QueryString();
    var dirtitle = param.dirtitle;
    $("#dirtitle").val(dirtitle);
    var fileExt = param.fileext;  //文件格式
    var isMulti = param.ismulti;  //是否多选         
    var type = param.type;    //上传目录
    var file = [];

    $('#file_upload').uploadify({
        'uploader': '/public/lib/uploadify/uploadify.swf',
        //'script': '/IUploadHandler.ajax',
        'script': '/public/Ajax/UploadHandler.ashx',
        //'scriptAccess': '',
        'cancelImg': '/public/lib/uploadify/cancel.png',
        'folder': type,
        'fileDesc': '请选择要上传的文件（' + fileExt + '）',
        'fileExt': fileExt,
        'auto': true,
        //'buttonImg': '/public/lib/uploadify/cancel.png',
        'multi': isMulti,
        onComplete: function (event, queueID, fileObj, response, data) {
            file.push({
                fileid: 0,
                filename: fileObj.name,
                filePath: param.type + '\\' + response,
                size: fileObj.size,
                date: fileObj.creationDate.time
            });
        },
        onAllComplete: function () {
            var d = { act: "add", file: file }
            window.returnValue = $.toJSON(d);
            window.close();
        },
        onError: function (event, queueID, fileObj) {
            alert("文件:" + fileObj.name + " 上传失败");
        }
    });

    $('#btn_upload').click(function () {
        if ($(this).attr('disabled')) return;
        $('#file_upload').uploadifyUpload();

        $('#btn_upload').attr('disabled', 'disabled');
        $('#btn_clear').attr('disabled', 'disabled');

        return false;
    });

    $('#btn_clear').click(function () {
        if ($(this).attr('disabled')) return;
        $('#file_upload').uploadifyClearQueue();
        return false;
    });

    $('#btn_cancel').click(function () {
        $('#file_upload').uploadifyCancel();
        window.returnValue = null;
        window.close();
        return false;
    });

    $('#btnsubmit').removeAttr('disabled');

});


// cancel
function e_cancel() {
    window.close();
}