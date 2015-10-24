$(document).ready(function () {
    bindDetailIcon();
    bindPagerLinks();
});

function bindDetailIcon() {
    $('.detailIcon').click(function () {
        $.post('/Clothes/Pics', { id: $(this).attr('data'), type: $(this).attr('data-type') }, function (data) {
            $('#viewPicsModalBody').html(data);
            $('#viewPicsModal').modal();
        }).fail(function (data) { alert('加载失败'); });
    });
}

function bindPagerLinks() {
    $('.pager a').click(function () {
        var page = $(this).attr('href').substring($(this).attr('href').indexOf('page=') + 5);
        searchClothes(function () {
            return { 'tags': getUserSelectedItems(), 'pageIndex': page, 'clothesTypeId': $('#clothesTypeId').val() };
        });
        return false;
    });
}