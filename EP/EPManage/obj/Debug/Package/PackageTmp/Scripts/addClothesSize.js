$(document).ready(function () {
    $('#addClothesSize').click(function () {
        var html = '<tr><td>';
        html = html + '<input type="text" name="name" class="input-mini"/>';
        html = html + '</td><td><input type="text" name="size" class="input-mini"/><button class="close tdCloseIcon">&times;</button></td></tr>';
        $(html).appendTo($('#clothSizeTable'));
        bindTdCloseIcon();
    });
});

function bindTdCloseIcon() {
//    $('.tdCloseIcon').click(function () {
//        $(this).parentsUntil('tbody').remove();
//    });
    $('input[name="name"] :last').autocomplete({
        source: ['样板尺寸', '前衣长', '后中长', '外侧长', '内长', '胸围', '腰围', '臀围', '摆围', '腿围', '肩宽', '背宽', '胸宽', '领围', '前领宽', '后领宽', '袖窿', '袖长', '袖肥', '袖口', '中档', '脚口', '前浪连腰', '后浪连腰', '肩带长', '腰带长'],
        minLength: 0
    }).autocomplete('search', '');
}