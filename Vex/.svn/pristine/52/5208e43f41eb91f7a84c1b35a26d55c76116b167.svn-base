// 名称：percentageDistributionLockConfig.js
// 说明：锁帐分配配置
// 创建人：郭琦琦 
// 创建日期：2014-09-22
// 修改人：
// 修改日期：
// 修改内容：
var editIndex = "";
var m_Com = [{ "id": "雅莹", text: "雅莹" }, { "id": "贝爱", text: "贝爱" }, { "id": "卓莱雅", text: "卓莱雅" }, { "id": "纳卉", text: "纳卉" }
, { "id": "华中", text: "华中" }, { "id": "郑州", text: "郑州" }, { "id": "新疆", text: "新疆" }, { "id": "维姬", text: "维姬" }
, { "id": "西南", text: "西南" }, { "id": "华南", text: "华南" }, { "id": "泓雅", text: "泓雅" }, { "id": "雅斓", text: "雅斓" }
, { "id": "东北", text: "东北" }];
var m_Form = [{ "id": "自营", text: "自营" }, { "id": "加盟", text: "加盟" }];

//初始化
$(function () {

    $('#txtcom').combobox({
        data: m_Com,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    $('#txtform').combobox({
        data: m_Form,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true
    });

    initGird();
});





//加载数据
function initGird(url) {
    $('#tab_list').datagrid(
            {
                title: '', //表格标题
                url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc') + "&XML=" + GetFormJson("", 'GetPercentageDistributionConfig'),
                sortName: 'com', //排序字段
                idField: 'id', //标识字段,主键
                width: '90%', //宽度
                height: $(document).height() - 100, //高度
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                remoteSort: true, //定义是否从服务器给数据排序
                collapsible: false, //可折叠
                sortOrder: 'DESC', //排序类型
                sortable: true,
                striped: true, //True 奇偶行使用不同背景色
                singleSelect: true, //单行选择
                fit: true,
                pagination: true, //是否开启分页
                pageSize: 20, //默认一页数据条数 
                rownumbers: true,//行号
                onClickCell: onClickCell,
                columns: [[
                    { field: 'id', title: 'id', width: 100, hidden: true },
                    { field: 'com', title: '公司', width: 100, search: true, sortable: true },
                    { field: 'form', title: '店铺类型', width: 100, search: true, sortable: true },
                    { field: 'pc', title: '偏差', width: 100, search: true, sortable: true, editor: { required: true, type: 'numberbox', options: { precision: '0', required: false } } },
                    { field: 'date', title: '锁帐日期', width: 150, search: true, sortable: true, formatter: Formater.Date , hidden: true}
                ]]
            });
}

//新增
function addClick() {
    var com = $('#txtcom').combobox('getValue');
    var form = $('#txtform').combobox('getValue');
    var pc = $('#txtpc').val();
    var check = com + form;

    if (com == "" || form == "" || pc == "") {
        alert("请检查新增数据,公司,类型,偏差值是否都填写!");
        return;
    }

    var selectedListData = $("#tab_list").datagrid('getRows'); //获取有行集合对象

    for (var i = 0; i < selectedListData.length; i++) {
        var checklist = selectedListData[i].com + selectedListData[i].form;
        if (check == checklist) {
            alert("该" + com + "店铺类型为" + form + "已经存在请检查数据!");
            return;
        }
    }
    AddNewRow();
}


function AddNewRow() {
    if (endEditing()) {
        $('#tab_list').datagrid('appendRow', { id: '', com: $('#txtcom').combobox('getValue'), form: $('#txtform').combobox('getValue'), pc: $('#txtpc').val() });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#tab_list').datagrid('validateRow', editIndex)) {
        $('#tab_list').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}

function onClickCell(index, field) {
    if (endEditing()) {
        $('#tab_list').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
        editIndex = index;
    }
}

function saveClick() {


    if (endEditing()) {

        $dg = $("#tab_list");
        var allRows = $dg.datagrid('getRows'); //获取当前所有行的数据


        var dateUpdate = [];


        for (var i = 0; i < allRows.length; i++) {
            delete allRows[i].rowindex;
            delete allRows[i].id;
            delete allRows[i].date;
            dateUpdate.push(allRows[i]);
        }

        var XMLData = GetEditJsonbyType(dateUpdate, 'updatePercentageDistributionConfig');
        $.messager.progress({ title: '请稍后', msg: '处理中' });

        $.ajax({
            url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
            type: 'post',
            async: true, //异步,
            data: { "XML": XMLData },
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
}




function deleteClick() {

    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtid", "value": selected.id }
            var XMLData = GetFormJson(data, 'deletePercentageDistributionConfig');
            $.ajax({
                url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $('#tab_list').datagrid("unselectAll");
                            initGird();
                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    })


}


//执行作业
function workClick() {
    var xmlData = GetFormJson("", 'work');
    htmlobj = $.ajax({
        url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
        data: { "XML": xmlData },
        type: 'post',
        async: true
    });
}