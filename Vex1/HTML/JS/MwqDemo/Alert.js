
function alert1() {
    $.messager.alert('提示', '提示信息!');
}
function alert2() {
    $.messager.alert('提示', '错误信息!', 'error');
}
function alert3() {
    $.messager.alert('提示', '消息信息!', 'info');
}
function alert4() {

    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {
            return "";
        }
    })
    };
   
    function alert5() {
        $.messager.alert('提示', '警告信息!', 'warning');
    }
