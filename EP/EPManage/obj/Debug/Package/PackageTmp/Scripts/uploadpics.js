$(document).ready(function () {
    $('.uploadbutton').each(function (index, item) {
        new AjaxUpload(item, {
            action: '/upload/Index?type=' + $(item).attr('type'),
            name: 'myfile',
            responseType: 'json',
            onSubmit: function (file, ext) {
                var button = $(this._button);
                button.text('正在上传');
                this.disable();
                interval = window.setInterval(function () {
                    var text = button.text();
                    if (text.length < 13) {
                        button.text(text + '.');
                    } else {
                        button.text('正在上传');
                    }
                }, 200);
            },
            onComplete: function (file, response) {
                var button = $(this._button);
                button.text('上传');
                window.clearInterval(interval);
                this.enable();
                if (response.Success) {
                    if ($(button).attr('type') == 'TechnologyFile' ||
                        $(button).attr('type') == 'AssessoriesFile' ||
                        $(button).attr('type') == 'SampleFile') {
                        $(('#file_' + $(button).attr('type'))).html('上传文件:' + response.FileName + '<button class="delText close tdCloseIcon">&times;</button>');
                         var hiddenField = '#' + $(button).attr('type');
                        $(hiddenField).val(response.FileName);
                        bindImageEvent();
                    }
                    else {
                        var img = $('#images_' + button.attr('data'));
                        $('<li><img src="' + response.FileName + '" width="75"/><button class="delImg close tdCloseIcon">&times;</button>').appendTo(img);

                        bindImageEvent();
                    }
                }
                else {
                    alert('上传失败，失败原因：' + response.ErrMsg);
                }
            }
        });
    });
});

function bindImageEvent() {
    $('img').click(function () {
        window.open(this.src);
    });
    $('.delImg').click(function (item) {
        $(this.parentNode).remove();
    });
    $('.delText').click(function (item) {
        var type = $(this).parent().attr('id').substr(5);
        $('#file_' + type).html('');
        $('#' + type).val('');
    });
}