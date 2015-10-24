$(function() {
    $(':button[name="ok"]').click(function() {
        var data = $(".field").serializeObject();
        data.menuid = $('#MenuId').val();
        $.ajaxWebService(data.oType, data, function(result) {
            var obj = result.d || new Object();
            if (obj.success == 1) {
                window.returnValue = true;
                window.close();
            } else {
                alert(obj.msg);
            }
        });

    });
    $(':button[name="cancel"]').click(function() {
        window.returnValue = false;
        window.close();
    });
});

