

var m_data = null;
$.ajax({
    url: GetComboxWSRRURL('026dab94-eb33-4dd4-b57f-2cb06de57aea'),
    options: "JSON",
    success: function (data) {
        m_data = data;
    }
});

//初始化
$(function () {
    $("#txtDate").datebox({
        onSelect: function(date){
            alert(date.getFullYear()+":"+(date.getMonth()+1)+":"+date.getDate());
        },
        onHidePanel: function () {
            alert("onHidePanel:txtDate");
        }
    });
    $('#tabList').datagrid({
        title: 'WS列表', //表格标题
        url: GetWSRRURL('026dab94-eb33-4dd4-b57f-2cb06de57aea'),
        queryParams: { "XML": GetGetJson([{ "entity": "entity" }]) },
        width: 1200,
        height: 220,
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        sortOrder: 'asc', //排序类型
        remoteSort: false, //定义是否从服务器给数据排序
        singleSelect: true, //单行选择

        columns: [[
            { field: 'colvalue11', title: '测试库服务器', width: 150 },
            { field: 'id', title: '编号', search: true, sortable: true },
            {
                field: 'col1', title: '测试列1', width: 100, search: true, sortable: true
                , editor: {
                    type: 'combobox', options: {
                        valueField: 'id',
                        textField: 'text',
                        data: m_data,
                        editable: false,
                        panelHeight: "100",
                        onShowPanel: function () {
                        },
                        onSelect: function (record) {
                        },
                        onHidePanel: function () {
                            alert("onHidePanel:col1");
                        }

                    }
                }
            },

            {
                field: 'col2', title: '类型', width: 60, search: true, sortable: true

                , editor: {
                    type: 'combobox', options: {
                        valueField: 'id',
                        textField: 'text',
                        data: m_data,
                        editable: false,
                        panelHeight: "100",
                        onShowPanel: function () {
                        },
                        onSelect: function (record) {
                        },
                        onHidePanel: function () {
                            alert("onHidePanel:col2");
                        }

                    }
                }
            },
            { field: 'colint', title: '说明', width: 160, sortable: true, align: 'right', halign: 'right', formatter: Formater.Nums },
            { field: 'coldecimal', title: '状态', width: 50, sortable: true, align: 'right', formatter: Formater.Account },
            { field: 'coldatetime', title: '正式库服务器', width: 150, sortable: true, formatter: Formater.DateTime }

        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 3, //默认一页数据条数
        rownumbers: true,
        exportExcel: true
    }
       );



})


function Test() {
    startEditing(0);
}

var editIndex = undefined;
function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#tabList').datagrid('validateRow', editIndex)) {
        $('#tabList').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}

function startEditing(index) {
    if (endEditing()) {
        $('#tabList').datagrid('selectRow', index).datagrid('beginEdit', index);
        editIndex = index;
    }
}