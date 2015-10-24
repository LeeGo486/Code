$(document).ready(function () {
    $('#btnAddUser').click(function () {
        $.post('/User/Add', { 'UserName': $('#UserName').val(), 'RealName': $('#RealName').val(), 'Department': $('#Department').val() }, function (data) {
            if (data == true) {
                alert('添加成功');
                $('#btnClose').click();
                document.location.reload();
            }
            else {
                alert('添加失败,失败原因' + data);
            }
        }).fail(function () { alert('添加失败'); });
        bindTdCloseIcon();
    });
});

function bindTdCloseIcon() {
//    $('.tdCloseIcon').click(function () {
//        $(this).parentsUntil('tbody').remove();
    //    });
    $('#Department').val().propertyIsEnumerable;
    $('#Department').val().autocomplete({
        source: ['研发部门', '设计部门'],
        minLength: 0
    }).autocomplete('search', '');
    $('input[name="Department"] :last').autocomplete({
        source: ['研发部门', '设计部门'],
        minLength: 0
    }).autocomplete('search', '');
}