

//初始化
$(function () {
    
    InitGird();
})

//初始化表格
function InitGird() {

    $('#tab_list').datagrid(
        {
            title: '公司信息', //表格标题
            url: GetWSRRURL('ab88c9e0-94a9-4106-89b4-bdf36bfbc538'),
            queryParams: { "XML": GetGetJson([{ "TableName": "dd"}]) },

            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            remoteSort: true, //定义是否从服务器给数据排序

            columns: [[
                { field: '编号', title: '编号', width: 60, search: true, sortable: true },
                { field: '姓名', title: '姓名', width: 160, sortable: true },
                { field: '性别', title: '性别', width: 150, search: true, sortable: true },
                { field: '地址', title: '地址', width: 150, search: true, sortable: true }
            ]],

            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    AddNewRow();
                }
            },
            {
                id: 'btn_Copy',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            },
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete();
                }
            }]
        }
        );

}
 