/// JS名：BindLog.js
/// 说明：VexSSO绑定日志查询
/// 创建人：马卫清 
/// 创建日期：2014-08-30

$(function () {
    InitGird();
})

//初始化表格
function InitGird() {
    var xmlData = GetFormJson([], 'GetBindLog');
    $('#tab_list').datagrid(
    {
        title: '单点登录绑定日志', //表格标题
        url: GetWSRRURL('711bb78a-4190-4568-809b-45c94dc54fb3'), //请求数据的页面
        queryParams: { "XML": xmlData },
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
            { field: 'logid', title: '日志编号', width: 80, sortable: true },
            { field: 'logtime', title: '日志时间', width: 120, search: true ,sortable: true},
            { field: 'vexssologinuser', title: '单点登录账户', width: 120, search: true },
            { field: 'vexssopassword', title: '单点登录密码', width: 120, search: true, sortable: true },
            { field: 'accreditationtype', title: '绑定系统', width: 120, search: true, sortable: true },
            { field: 'binduser', title: '待绑定系统用户', width: 120, search: true, sortable: true },
            { field: 'bindpassword', title: '待绑定系统密码', width: 120, search: true, sortable: true },
            { field: 'result', title: '绑定结果', width: 300, search: true, sortable: true }
        ]],

        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true,
        exportExcel: false
    });

}
