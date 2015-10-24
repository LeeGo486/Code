var depotid;
$(function () {
    //获取店铺ID
    htmlobj = $.ajax({
        url: GetWSRRURL('DepotID'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.DepotID != "") {
        depotid = result.DepotID;
    };
    InitGird();
});

function InitGird() {
    $('#tab_list').datagrid({
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        title: '查询结果',
        width: '90%',
        height: $(document).height() - 40,
        onDblClickRow: function () {
            Get_Rows();
        },
        onBeforeLoad: function (param) {
            var data = [];
            data[data.length] = { "name": "txt操作类型", "value": "GET" };
            data[data.length] = { "name": "txt实体", "value": "取主表信息" };
            data[data.length] = { "name": "txtCONO", "value": "EP" };
            data[data.length] = { "name": "txtDIVI", "value": "D01" };
            data[data.length] = { "name": "txt公司", "value": "" };
            data[data.length] = { "name": "txt店铺ID", "value": depotid };
            data[data.length] = { "name": "txt状态", "value": "0" };
            data[data.length] = { "name": "txt款号", "value": "" };
            data[data.length] = { "name": "txt每页行数", "value": param.rows };
            data[data.length] = { "name": "txt页数", "value": param.page };
            XMLData = GetDBFrameAML(data);
            $('#tab_list').datagrid('options').url = GetWSRRURL('906ae367-5e18-4ba2-9ac1-8de6834f3620') + XMLData;
            return true;
        },
        onLoadSuccess: function (data) {
            //var options = $('#tab_list').datagrid('getPager').data("pagination").options;
            if (data.rows == null || data.rows.length == 0) {
                data.total = 0;
            }
            else {
                data.total = data.rows[0].count_num;
            }
        },
        columns: [[
            { field: 'pra_depotname', title: '店铺名称', width: 150 },
            { field: 'pra_employeename', title: '联系人', width: 100 },
            { field: 'pra_phone', title: '联系电话', width: 150 },
            { field: 'pra_total', title: '总数', width: 50 },
            { field: 'pra_rgdt', title: '申请时间', width: 100 },
            { field: 'pra_updatetime', title: '处理时间', width: 100 },
            { field: 'pra_statusname', title: '状态', width: 80 },
            { field: 'pra_remark', hidden: true },
            { field: 'pra_picpath', hidden: true }
           ]],
        pagination: true //是否开启分页
        //        pageNumber: 1, //默认索引页
        //        pageSize: 20, //默认一页数据条数
        //        rownumbers: true//行号
    });
};

//查询按钮方法
function searchData() {
    var styleid, status, XMLData;
    var data = [];
    styleid = $('#txtprad_styleid').val();
    status = $('#status').combobox('getValue');
    $('#tab_list').datagrid({
        url: GetWSRRURL('906ae367-5e18-4ba2-9ac1-8de6834f3620') + XMLData,
        async: true,//异步
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        title: '查询结果',
//        sortOrder: 'desc',
//        sortName: 'pra_createtime',
        width: '90%',
        onBeforeLoad: function (param) {
            ClearGrid("#tab_list");
            var data = [];
            data[data.length] = { "name": "txt操作类型", "value": "GET" };
            data[data.length] = { "name": "txt实体", "value": "取主表信息" };
            data[data.length] = { "name": "txtCONO", "value": "EP" };
            data[data.length] = { "name": "txtDIVI", "value": "D01" };
            data[data.length] = { "name": "txt公司", "value": "" };
            data[data.length] = { "name": "txt店铺ID", "value": depotid };
            data[data.length] = { "name": "txt状态", "value": status };
            data[data.length] = { "name": "txt款号", "value": styleid };
            data[data.length] = { "name": "txt每页行数", "value": param.rows };
            data[data.length] = { "name": "txt页数", "value": param.page };
            XMLData = GetDBFrameAML(data);
            $('#tab_list').datagrid('options').url = GetWSRRURL('906ae367-5e18-4ba2-9ac1-8de6834f3620') + XMLData;
            return true;
        },
        onLoadSuccess: function (data) {
            //var options = $('#tab_list').datagrid('getPager').data("pagination").options;
            if (data.rows == null || data.rows.length == 0) {
                data.total = 0;
            }
            else {
                data.total = data.rows[0].count_num;
            }
        },
        columns: [[
            { field: 'pra_depotname', title: '店铺名称', width: 150 },
            { field: 'pra_employeename', title: '联系人', width: 100 },
            { field: 'pra_phone', title: '联系电话', width: 150 },
            { field: 'pra_total', title: '总数', width: 50 },
            { field: 'pra_createtime', title: '申请时间', width: 100 },
            { field: 'pra_updatetime', title: '处理时间', width: 100 },
            { field: 'pra_statusname', title: '状态', width: 80 },
            { field: 'pra_remark', hidden: true },
            { field: 'pra_picpath', hidden: true }
           ]],
        pagination: true //是否开启分页
    });
};
//查看明细的方法
function Get_Rows() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    var guid = selected_Row.pra_guid;
    var url;
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "取明细表信息" };
    data[data.length] = { "name": "txtCONO", "value": "EP" };
    data[data.length] = { "name": "txtDIVI", "value": "D01" };
    data[data.length] = { "name": "txt单据ID", "value": guid };
    XMLData = GetDBFrameAML(data);
    if (selected_Row) {
        $('#tab_Detail').datagrid({
            url: GetWSRRURL('906ae367-5e18-4ba2-9ac1-8de6834f3620') + XMLData,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            sortOrder: 'desc',
            sortName: 'prad_styleid',
            columns: [[
                    { field: 'prad_styleid', title: '款号', width: 200 },
                    { field: 'prad_total', title: '数量', width: 80 }
                ]]
        })
        $('#divDetail').window({
            title: '吊牌申请明细',
            top: 30
        });

        $('#divDetail').window("open");
        $('#txtpra_remark').val(selected_Row.pra_remark);
        if (selected_Row.pra_picpath == "") {
            url = "";
        } else {
            url = "" + selected_Row.pra_picpath;
        };
        $('#txtpicpath').val(url);
    } else {
        alert("请选择一行");
        return;
    };
}
//查看图片的方法
function lookPicPath() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    var url;
    if (selected_Row.pra_picpath == "") {
        url = "";
        return;
    } else {
        url = "" + selected_Row.pra_picpath;
        window.open(url, "newwindow", "");

    };
}