//初始化
$(function () {
    $("#txtID").val("dddddddddddd");
})


function GetMonthDay() {
    var temp = $('#txtDate').val()
    var nowDate = new Date(temp);
    nowDate = new Date(nowDate.getFullYear() + "/" + (nowDate.getMonth() + 1) + "/" + "01")
    //alert(Date.parse(nowDate));

    nowDate = nowDate.DateAdd('m', 1).DateAdd('d', -1);
    alert(nowDate.Format("YYYY/MM/DD"));
    var strDate = nowDate.getFullYear() + "/" + (nowDate.getMonth() + 1) + "/" + nowDate.getDate();
    alert(strDate);

}


