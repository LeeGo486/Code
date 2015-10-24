var htmlobj = "";
var m_UserId = "";
var XMLData = "";
var m_DepotId = "";
//初始化
$(function () {
    //获取用户ID
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.UserName != "") {
        m_UserId = result.UserName;
    };

    //获取店铺ID
    XMLData = GetFormJson([], 'Verification');
    htmlobj = $.ajax({
        url: GetWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0'),
        data: { "XML": XMLData, "WHERE": "userid='" + m_UserId + "'" },
        type: 'post',
        async: false
    });

    var result = $.parseJSON(htmlobj.responseText);
    if (result.rows[0]) {
        m_DepotId = result.rows[0].depotid;
    }
});
function StockSearch() {
    var styleNumber=document.getElementById("styleNumber").value;
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "库存" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txtDIVI", "value": "D01" };
    data[data.length] = { "name": "txt款式编号", "value": styleNumber }; //E13IO9812aZ4
    data[data.length] = { "name": "txt店铺编号", "value": m_DepotId }; //"A0012027"
    var xmlData = GetDBFrameAML(data);
    $('#tab_list').datagrid({
        url: GetWSRRURL("c8926145-e9bd-4589-b302-0b4039ddb42d")+xmlData,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        rownumbers: true, //行号
        singleSelect: true, //单行选择 
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        columns:[[
            { field: 'd_name', title: '仓库名称', width: 100 },
            { field: 'p_num', title: '库存', width: 100 },
            { field: 'fcalcsums', title: '近半月销售表', width: 100 },
            { field: 'd_dq', title: '所属大区', width: 100 },
            { field: 'addressname', title: '地址', width: 100 },
            { field: 'r_name', title: '管理人员', width: 100 },
            { field: 'tel', title: '电话', width: 100 }
        ]],
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && data.rows[0].message != "") {
                ClearGrid('#tab_list');
                $.messager.alert("提示", "无相关数据!");
            }
        }
    });
}

