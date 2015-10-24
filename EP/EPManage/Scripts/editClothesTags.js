
$(document).ready(function () {
    $('#btnEditClothesTags').click(function () {
        if (getUserSelectedItems().length == 0) {
            alert('您尚未选择特征信息');
        }
        else if (!validSelectItems()) {
            return false;
        }
        else {
            $.post('/Clothes/EditClothesTags', { tags: getUserSelectedItems(), id: $('#clothesId').val() }).success(function (data) {
                if (data == true) {
                    alert('保存成功');
                    $('#clseBtnEditClothesTags').click();
                }
                else
                    alert('保存失败');
            }).fail(function () { alert('保存失败'); });
            return false;
        }
    });

    $('.dropdown-select').multiselect({
        header: false,
        minWidth: '130',
        selectedList: 2,
        'noneSelectedText': 'None'
    });

    $('input[name^="multiselect_"]').not(':first').click(function (a, source) {
        var multiName = $(this).attr('name');
        if ($('input[name="' + multiName + '"]:checked').length > 1) {
            $($('input[name="' + multiName + '"]')[0]).attr('checked', false);
        }
        else if ($('input[name="' + multiName + '"]:checked').length == 0) {
            $($('input[name="' + multiName + '"]')[0]).click();
        }
        return true;
    });
});

function getUserSelectedItems() {
    var items = Array();
    $('input[type="checkbox"]:checked').each(function (index, item) {
        var name = $(item).attr('partId');
        if ($(item).attr('partId') != undefined) {
            var name = $(item).attr('name');
            items.push($(item).attr('partId') + '-' + name);
        }
    });
    $('input[name^="multiselect_"][value!="0"]:checked').each(function (index, item) {
        items.push('Tag-' + $(item).attr('value'));
    });
    return items.join(',');
}

function validSelectItems() {
    var r = true;
    $('ul.nav').each(function (index, item) {
        if ($(item).attr('multiple') == undefined)
            if ($(item).find('input[type="checkbox"]:checked').length > 1) {
                alert('一个属性只可选择一个值');
                r = false;
            }
    })
    return r;
};

