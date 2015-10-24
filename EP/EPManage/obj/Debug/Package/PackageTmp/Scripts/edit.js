$(document).ready(function () {
    $('#btnAddClothesPartType').click(function () {
        var data = { 'name': $('#name').val(), 'partId': $('#clothPartId').val() };
        $.post($('#btnAddClothesPartType').attr('href'), data, function (data) {
            $('#nav_' + $('#clothPartId').val() + ' li:last').before('<li data="' + data.Id + '" class="btn btnType">' + data.Name + '<button data="' + data.Id + '" class="close">&times;</button></li>');
            $('#myModal').modal('hide');
            $('#name').val('');
            $('#clothPartId').val('');
            initAllRemoveButtons();
        }).fail(function () { alert('添加失败'); });
        return false;
    });
    $('button[data-target="#myModal"]').click(function () {
        $('#clothPartId').val($(this).attr('data'));
    });

    $('button[data-target="#styleModal"]').click(function () {
        $('#styleType').val($(this).attr('data'));
    });

    $('#btnAddClothesClassicOrBestSelling').click(function () {
        var data = { 'ClassicOrBestSelling': $('#styleModal #ClassicOrBestSelling').val(), 'styleType': $('#styleType').val() };
        $.post($('#btnAddClothesClassicOrBestSelling').attr('href'), data, function (data) {
            $('#nav_' + $('#styleType').val() + ' li:last').before('<li data="' + data.Id + '" class="btn btnType">' + data.Value + '<button data="' + data.Id + '" class="close">&times;</button></li>');
            $('#styleModal').modal('hide');
            $('#styleModal #ClassicOrBestSelling').val('');
            $('#styleType').val('');
            initAllRemoveButtons();
            $('ul').sortable();
        }).fail(function () { alert('添加失败'); });
        return false;
    });

    initAllRemoveButtons();

    $("ul").sortable();

    $('table.tblPartItems button.sortbtn').click(function () {
        var items = Array();
        $('ul#nav_' + $(this).attr('data') + '').children().each(function (index, item) {
            items.push($(item).attr('typeId'));
        });
        $.post('/Main/order', { 'partId': $(this).attr('data'), 'items': items.join(',') }, function (data) {
            alert('保存成功');
        }).fail(function () { alert('保存失败'); });
        return false;
    });

    $('table.tblStyleItems button.sortbtn').click(function () {
        var items = Array();
        $('ul#nav_' + $(this).attr('data') + ' li[data]').each(function (index, item) {
            items.push($(item).attr('data'));
        });
        $.post('/Main/StyleOrder', { 'style': $(this).attr('data'), 'items': items.join(',') }, function (data) {
            alert('保存成功');
        }).fail(function () { alert('保存失败'); });
        return false;
    });

    $('.btnType').dblclick(function () {
        $('#partTypeModal').modal();
        $('#clothesPartChildren').html('正在加载.....');
        $('#clothesPartChildren').data('data', $(this).attr('typeId'));
        $.get('/ClothesPartTypes/index/' + $(this).attr('typeId'), {}, function (data) {
            $('#clothesPartChildren').html(data);
            $('#clothesPartChildren ul').sortable();
            initAddNewClothesPartTypeBtn();
        }).fail(function () { alert('加载失败'); }
        );
    });


    $('#btnSaveClothesPartType').click(function () {
        var items = Array();
        $('#clothesPartChildren li').each(function (index, item) {
            items.push($(item).attr('data'));
        });
        var data = { 'itemIds': items.join(','), 'clothesPartTypeId': $('#clothesPartTypeId').val() };
        $.post('/ClothesPartTypes/SaveClothesPartTypes', data, function (data) {
            $('#clothesPartChildren').html('<div class="alert alert-info">保存成功</div>');
            setTimeout(function () { $('.btnclose').click(); }, 500);
        }).fail(function () { alert('保存失败'); });
        return false;
    });

    $('#partTypeModal').on('hide', function () {
        $('li[typeId="' + $('#clothesPartChildren').data('data') + '"] span[class="caret"]').remove();
        $.post('/ClothesPartTypes/ChildCount', { clothesPartTypeId: $('#clothesPartChildren').data('data') }, function (data) {
            if (data != '0') {
                $('li[typeId="' + $('#clothesPartChildren').data('data') + '"]').append('<span class="caret"></span>');
            }
        });
        return true;
    });
});


function initAddNewClothesPartTypeBtn() {
    $('#btnAddNewClothesPartType').click(function () {
        $.post('/ClothesPartTypes/Add', { 'clothesPartTypeId': $('#clothesPartTypeId').val(), name: $('#newClothesPartType').val() }, function (data) {
            $('#clothesPartChildren').html(data);
            $('#clothesPartChildren ul').sortable();
            initAddNewClothesPartTypeBtn();
        }).fail(function () { alert('添加失败'); });

    });

    $('.btnDelClothesPartTypeChild').click(function () {
        $.post('/ClothesPartTypes/Del', { 'clothesPartTypeId': $('#clothesPartTypeId').val(), 'id': $(this).attr('data') }, function (data) {
            $('#clothesPartChildren').html(data);
            $('#clothesPartChildren ul').sortable();
            initAddNewClothesPartTypeBtn();
        }).fail(function () { alert('删除失败'); });
    });
}

function initAllRemoveButtons() {

    $('table.tblPartItems li button.close').click(function () {
        $('body').data('id', $(this).attr('data'));
        $.post('/Main/DeleteClothesPartType', { id: $(this).attr('data') }, function (data) {
            if (data == true)
                $('button[data="' + $('body').data('id') + '"]').parent().remove();
            else
                alert('删除失败');
        }).fail(function () { alert('删除失败'); });
        return false;
    });

    $('table.tblStyleItems li button.close').click(function () {
        $('body').data('id', $(this).attr('data'));
        $.post('/Main/DeleteStyleItem', { id: $(this).attr('data') }, function (data) {
            if (data == true)
                $('button[data="' + $('body').data('id') + '"]').parent().remove();
            else
                alert('删除失败');
        }).fail(function () { alert('删除失败'); });
        return false;
    });
}