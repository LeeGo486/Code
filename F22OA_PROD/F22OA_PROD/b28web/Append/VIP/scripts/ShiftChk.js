function e_sure() {
    if ($("#btnsure").hasClass("disabled")) return false;
    var id = GetSheetID();
    if (id == "" || id == undefined) {
        alert("请选择行!");
        return false;
    }

        $("#get_comment").val('');

        var html = '<div id="divIdentify" style="background-color: #fff; border: 1px solid #cad9ea;font-size:12px;"> ' +
            '<div style="color:White;background-color:#2A92D9;height:35px;vertical-align:middle;" >' +
            '<div style="padding:10px 5px;font-weight:bold;">审批回复<span style="margin-left:280px;cursor:pointer;text-decoration:underline;" onclick="closeDialog()">关闭</span></div>' +
            '</div>' +
            '<div style="padding-top:5px;"><textarea rows="3" cols="67" id="get_comment"></textarea></div>' +
            '<center style="padding:10px 5px;"><input type="button" onclick="btnAgree(1)" value="同  意" />&emsp;&emsp;<input type="button" onclick="btnAgree(2)" value="拒  绝" /></center>' +
            '</div>';

        $.blockUI({
            theme: true,
            themedCSS: {
                width: '380px',
                top: ($(window).height() - 220) / 2 + 'px',
                left: ($(window).width() - 400) / 2 + 'px',
                opacity: 1,
            },
            message: html
        });


}


function q_query() {
    GridControl1.fnReloadAjax();
}

$(function () {
    $("input[name='getchk']").click(function () {
        q_query();

        if($(this).val()=="1"){
            $("#btnsure").attr("disabled","disabled");
        }else{
            $("#btnsure").removeAttr("disabled","disabled");
        }
    });
});


function btnAgree(getchk) {

    var id = GetSheetID();
    if (id == "" || id == undefined) {
        alert("请选择行!");
        return false;
    }
        var get_comment = $("#get_comment").val();
    if(get_comment == "") {
        alert("审批回复不能为空！");
        return false;
    }

    var msg ="";
    if(getchk == "1")
         msg ="同意";
    else{
         msg ="拒绝";
    }

     if (!confirm("确认要【"+msg+"】审批吗!")) {
            return false;
     }

    var obj = { id: id,
                getchk:getchk,
                get_comment:get_comment 
               };
    $.ajaxWebService("sure", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            q_query() ;
             $.unblockUI();
        } else {
            alert(result.msg);
             $.unblockUI();
        }
    });

}

function closeDialog(){
             $.unblockUI();
}

function grdSelected() {
    var id = GetSheetID();
    if (id == undefined || id == "") return false;
    $("#shiftid").val(id);
    GridControl2.fnReloadAjax();
}


function grdComplete() {

    var rows = GridControl1.fnGetNodes();
    var len = rows.length;
    if (len == 0) return;
    $(rows[0]).addClass('row_selected').siblings().removeClass('row_selected');
    grdSelected()
}