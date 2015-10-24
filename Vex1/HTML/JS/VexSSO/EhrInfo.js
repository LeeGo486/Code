/// JS名：BindLog.js
/// 说明：VexSSO绑定日志查询
/// 创建人：马卫清 
/// 创建日期：2014-08-30

function Edit_Submit() {
    var name = $("#txtName").val();
    var idcarid = $("#txtIDCard").val();

    if (name == "" && idcarid == "") {
        alert("请输入查询条件");
        return;
    }

    InitGird(name, idcarid);
}

//初始化表格
function InitGird(name, idcarid) {
    var data = [];
    data[data.length] = { "name": "txtName", "value": name };
    data[data.length] = { "name": "txtCardid", "value": idcarid };

    var xmlData = GetFormJson(data, 'GetEhrInfo');
    $('#tab_list').datagrid(
    {
        title: 'Ehr用户信息查询', //表格标题
        url: GetWSRRURL('711bb78a-4190-4568-809b-45c94dc54fb3'), //请求数据的页面
        queryParams: { "XML": xmlData },
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
            { field: 'c_name', title: '姓名', width: 120 },
            { field: 'c_idcard', title: '身份证号', width: 180 }
        ]],

        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true,
        exportExcel: false
    });

}
