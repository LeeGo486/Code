$(document).ready(function () {
    bindImageEvent();

    $('#btnAddClothes').click(function () {
        if ($('#SampleNO').val().length == 0) {
            alert('样板编号必须填写');
            return false;
        }
        if ($('#ProductNO').val().length == 0) {
            alert('大货编号必须填写');
            return false;
        }
        if (getClothesSize().length == 0) {
            alert('衣服尺寸必须填写');
            return false;
        }
//        if (getImages('#images_StylePics').length == 0 && !confirm('确认不上传款式图片?')) return false;
//        if (getImages('#images_ClothesPics').length == 0 && !confirm('确认不上传样衣图片?')) return false;
//        if (getImages('#images_ModelVersionPics').length == 0 && !confirm('确认不上传版型图?')) return false;
        var data = {
            'id': $('#clothesId').val(),
            'SampleNO': $('#SampleNO').val(),
            'ProductNO': $('#ProductNO').val(),
            'StylePics': getImages('#images_StylePics'),
            'ClothesPics': getImages('#images_ClothesPics'),
            'ModelVersionPics': getImages('#images_ModelVersionPics'),
            'ClothesSize': getClothesSize(),
            'ProductedCount': $('#ProductedCount').val(),
            'SaledCount': $('#SaledCount').val(),
            'Comment': $('#Comment').val(),
            'TechnologyFile': $('#TechnologyFile').val(),
            'AssessoriesFile': $('#AssessoriesFile').val(),
            'SampleFile': $('#SampleFile').val()
        };
        $.post($('#btnAddClothes').attr('href'), data, function (data) {
            alert('保存成功');
            $('#btnClose').click();
        }, 'json').fail(function () { alert('保存失败'); });
        return false;
    });
});

function getImages(id) {
    var images = '';
    $(id + ' img').each(function (index, item) {
        images = images + $(item).attr('src') + ',';
    });
    if (images.length > 0)
        images = images.substring(0, images.length - 1);
    return images;
}

function getClothesSize() {
    var names = Array();
    var values = Array();
    var r = '';
    $('#clothSizeTable input[name="name"]').each(function (index, item) { names.push($(item).val()); });
    $('#clothSizeTable input[name="size"]').each(function (index, item) { values.push($(item).val()); });
    for (var i = 0; i < names.length; i++) {
        r = r + names[i] + '=' + values[i] + ',';
    }
    if (r.length > 0)
        r = r.substring(0, r.length - 1);
    return r;
}