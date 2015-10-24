var querystring = location.href.split('?')[1];
var styleid = $.param2obj(querystring).id;



$(function () {
    $('#btnsubmit').removeAttr('disabled');
    $('.showbtn').click(showpic).first().click() ;
});
function showpic(){
    var i = $(this).val();
    //window.open("/ajax/readimage.ashx?styleid=" + styleid + "&pic=" + i);
    $("#pic").attr("src", "/public/ajax/readimage.ashx?styleid=" + styleid + "&pic=" + i);

    $(this).attr("disabled","disabled").siblings().removeAttr('disabled');

}
function e_submit() {
 
     var obj = {
                "styleid": styleid,
                "dh_3": $(".field").val()
            }
    $.ajaxWebService("UpStyleMd", obj, function (result) {
            var obj = result.d || new Object();
            if (obj.success == 1) {
                window.returnValue = true;
                window.close();
            } else {
                alert(obj.msg);
            }
        });
}