$(document).ready(function () {
    $('#editClothes').click(function () {
        $('#myModal').modal();
        $('#myModal #divAddClothes').load('/Clothes/edit/' + $('#clothesId').val());
    });

    $('#editClothesTags').click(function () {
        $('#tagsModal').modal();
        $('#tagsModal #divEditClothesTags').load('/Clothes/EditClothesTags/' + $('#clothesId').val());;
    });

    $('#btnDelClothes').click(function () {
        if (confirm('确认要删除吗？删除后不可恢复')) {
            $.get('/Clothes/Del/' + $('#clothesId').val(), null, function (data) {
                if (data == 'true') {
                    alert('删除成功');
                    $('#myModal').modal('hide');
                    window.close();
                }
            }).fail(function () { alert('删除失败'); });
            return false;
        }
        return false;
    });
});