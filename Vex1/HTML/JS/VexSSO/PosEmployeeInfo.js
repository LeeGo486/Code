/// JS名：BindLog.js
/// 说明：VexSSO绑定日志查询
/// 创建人：马卫清 
/// 创建日期：2014-08-30

$(function () {
    InitGird();
})


//初始化表格
function InitGird() {
    var data = [];

    var xmlData = GetFormJson(data, 'GetPosPOSEmployee');
    $('#tab_list').datagrid(
    {
        title: 'Pos导购信息', //表格标题
        url: GetWSRRURL('711bb78a-4190-4568-809b-45c94dc54fb3'), //请求数据的页面
        queryParams: { "XML": xmlData },
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
        { field: 'names', title: '姓名', width: 80, search: true, sortable: true },
        { field: 'employeeid', title: '导购编号', width: 120, search: true, sortable: true },
        { field: 'valid', title: '离职', width: 80, search: true, sortable: true }
        ]],

        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true,
        exportExcel: false
    });

}
