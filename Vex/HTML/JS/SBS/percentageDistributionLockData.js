// 名称：percentageDistributionLockData.js
// 说明：锁帐分配
// 创建人：郭琦琦 
// 创建日期：2014-09-22
// 修改人：
// 修改日期：
// 修改内容：
var editIndex = "";
var m_month = [{ "id": "1", "text": "1月" }, { "id": "2", "text": "2月" }, { "id": "3", "text": "3月" }, { "id": "4", "text": "4月" }, { "id": "5", "text": "5月" }, { "id": "6", "text": "6月" },
            { "id": "7", "text": "7月" }, { "id": "8", "text": "8月" }, { "id": "9", "text": "9月" }, { "id": "10", "text": "10月" }, { "id": "11", "text": "11月" }, { "id": "12", "text": "12月" }];
var flag = "";

//初始化
$(function () {
    flag = "1";
    $('#txtmonth').combobox({
        valueField: 'id',
        textField: 'text',
        data: m_month,
        panelHeight: 'auto',
        editable: false,
        multiple: false
    })


});

function searchClick() {
    var month = $('#txtmonth').combobox('getValue');
    if (month == "") {
        alert("请选择月");
        return;
    }



    var data = [];
    data[data.length] = { "name": "txtmonth", "value": month };

    var urlGetDepot = GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc') + "&XML=" + GetFormJson(data, 'getDepot');
    initGird(urlGetDepot);
}

//加载数据
function initGird(url) {
    $('#tab_list').datagrid(
            {
                title: '', //表格标题
                url: url,
                sortName: 'depotid', //排序字段
                idField: 'depotid', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 100, //高度
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                remoteSort: true, //定义是否从服务器给数据排序
                collapsible: false, //可折叠
                sortOrder: 'DESC', //排序类型
                sortable: true,
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: false, //单行选择
                fit: true,
                pagination: true, //是否开启分页
                pageSize: 20, //默认一页数据条数 
                rownumbers: true,//行号
                //onClickCell: onClickCell,
                selectOnCheck: false,
                checkOnSelect: true,
                columns: [[
                    { field: 'ck', checkbox: true },
                    { field: 'd_dq', title: '大区', width: 80, search: true, sortable: true },
                    { field: 'parentid', title: '父级ID', width: 60, search: true, sortable: true },
                    { field: 'parentname', title: '父级名称', width: 100, search: true, sortable: true },
                    { field: 'unitid', title: '上级ID', width: 60, search: true, sortable: true },
                    { field: 'parentname1', title: '上级名称', width: 100, search: true, sortable: true },
                    { field: 'depotid', title: '店铺编号', width: 100, search: true, sortable: true },
                    { field: 'd_name', title: '店铺名称', width: 100, search: true, sortable: true },
                    { field: 'm_type', title: '类别', width: 50, search: true, sortable: true },
                    { field: 'brandid', title: '品牌', width: 100, search: true, sortable: true, hidden: true },
                    { field: 'szmonth', title: '锁帐月份', width: 60, search: true, sortable: true },
                    { field: 'szrq', title: '锁帐日期', width: 150, search: true, sortable: true },
                    //, formatter: Formater.Date
                ]],
                onLoadSuccess: function (data) {
                    flag = "2";
                }

            });
    //var col = $('#tab_list').datagrid('getColumnOption', 'szrq');
    //col.editor = {
    //    type: 'datebox', options: {
    //        editable: false,
    //        required: true,
    //        formatter: function (date) { return date.format("yyyy-MM-dd") }
    //    }
    //}
}


function saveClick() {

   
    var SelectedDate = $('#txtDate').datebox('getValue');
    //var rowsData = $('#tab_list').datagrid('getRows');

    if (flag == "1") {
        alert("请先加载数据!");
        return;
    }

    var Selected = $('#tab_list').datagrid('getChecked');

    if (Selected.length == "" || Selected.length == undefined || Selected.length == "0") {
        alert("请先选择需要设置锁帐的店铺!");
        return;
    }
    if (SelectedDate == "") {
        alert("请选择设置日期!");
        return;
    }

    for (var i = 0; i < Selected.length; i++) {
        delete Selected[i].brandid;
        delete Selected[i].shutname;
        delete Selected[i].parentid;
        delete Selected[i].parentname;
        delete Selected[i].unitid;
        delete Selected[i].parentname1;
        delete Selected[i].d_name;
        delete Selected[i].m_type;
        delete Selected[i].brandid;
        delete Selected[i].rowindex;
        delete Selected[i].d_dq;
        Selected[i].szrq = SelectedDate;
    }
    var updateJSON = GetEditJsonbyType(Selected, "updateDepot");
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
        type: 'post',
        async: true, //异步,
        data: { "XML": updateJSON },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $.messager.progress('close');
                    $('#tab_list').datagrid("unselectAll");
                    $('#tab_list').datagrid("reload");

                    $.messager.alert("提示", result[0].rows[0].message);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}






//            var updateJSON = GetEditJsonbyType(updated, "updateDepot");




//function endEditing() {
//    if (editIndex == undefined) { return true }
//    if ($('#tab_list').datagrid('validateRow', editIndex)) {
//        $('#tab_list').datagrid('endEdit', editIndex);
//        editIndex = undefined;
//        return true;
//    } else {
//        return false;
//    }
//}

//function onClickCell(index, field) {
//    if (endEditing()) {
//        $('#tab_list').datagrid('selectRow', index)
//                .datagrid('editCell', { index: index, field: field });
//        editIndex = index;
//    }
//}