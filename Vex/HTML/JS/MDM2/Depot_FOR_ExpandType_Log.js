var m_columns = null;
var editIndex;
var m_ViewTableName = "CM_Depot_Opration_History";
var m_MerchantBodyID = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;
var m_ShopState = [{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }];
var channeltype = [{ "id": 1, "text": "专卖" }, { "id": 2, "text": "百货" }, { "id": 3, "text": "生活馆" }, { "id": 4, "text": "Mall" }, { "id": 5, "text": "机场店" }, { "id": 6, "text": "网络店" }];
var ishistorytype = [{ "id": 0, "text": "是" }, { "id": 1, "text": "否" }];
var BusinessState = [{ "id": 1, "text": "正常" }, { "id": 2, "text": "优化" }, { "id": 3, "text": "停" }];

//初始化
$(function () {

    $('#txtexpandtype').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": "老店优化", "text": "老店优化", "selected": true }, { "id": "撤店", "text": "撤店" }, { "id": "老店重装", "text": "老店重装" }, { "id": "全部", "text": "全部" }],
        panelHeight: 'auto',
        editable: false,
        onChange: InitGird,
        onLoadSuccess: InitGird

    });

})

//初始化表格
function InitGird() {
    ClearGrid("#tab_list");

    var expandtype = $('#txtexpandtype').combobox('getValue');

    //if (expandtype == "") {
    //    expandtype = "全部";
    //}
    var strURL = GetWSRRURL('1825ce56-1a05-46fa-9e00-f05f5eed9a2f');
    if (expandtype != "全部") {
        strURL += "&Where=" + escape("tzlx") + " ='" + escape(expandtype) + "'";
    }

    $('#tab_list').datagrid(
        {
            title: '商务拓展日志', //表格标题
            url: strURL,
            queryParams: { "XML": GetGetJson([{}]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            frozen: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            columns: [[
              { field: 'AutoID', title: 'AutoID', width: 60, search: true, sortable: true },
              { field: 'body_id', title: 'body_id', width: 60, search: true, sortable: true },
              { field: 'j_dq', title: '所属大区', width: 65, search: true, sortable: true, align: 'center' },
              { field: 'j_form', title: '店铺形态', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'j_freeze', title: '冻结状态', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'b_channel', title: '渠道类型', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'b_designing', title: 'b_designing', width: 100, search: true, sortable: true, align: 'center' },
              { field: 'g_sf', title: '省份', width: 45, search: true, sortable: true, align: 'center' },
              { field: 'g_cs', title: '城市', width: 45, search: true, sortable: true, align: 'center' },
              { field: 'g_qx', title: '区县', width: 45, search: true, sortable: true, align: 'center' },
              { field: 'g_cz', title: '城市定义 ', width: 60, search: true, sortable: true, align: 'center' },
              { field: 'b_htarea', title: '合同面积', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'p_lc', title: '楼层', width: 35, search: true, sortable: true, align: 'center' },
              { field: 'b_state', title: '商务状态', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'tzlx', title: '拓展类型', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'oprationuser', title: '执行人', width: 60, search: true, sortable: true, align: 'center' },
              { field: 'oprationtime', title: '执行时间', width: 120, search: true, sortable: true, align: 'center' },
              { field: 'ishistory', title: '最新', width: 30, search: true, sortable: true, align: 'center' },
              { field: 'g_address', title: '地址', width: 333, search: true, sortable: true, align: 'left' }
            ]],
            frozenColumns: [[
              { field: 'j_depotid', title: '店铺编号', width: 55, search: true, sortable: true, align: 'center' },
              { field: 'j_name', title: '店铺名称', width: 100, search: true, sortable: true, align: 'center' }
            ]]

        }
        );


    var $dg = $('#tab_list');

    col = $dg.datagrid('getColumnOption', 'AutoID');
    col.field = "test";
    $dg.datagrid("hideColumn", "test");

    col = $dg.datagrid('getColumnOption', 'body_id');
    col.field = "test1";
    $dg.datagrid("hideColumn", "test1");

    col = $dg.datagrid('getColumnOption', 'b_designing');
    col.field = "test2";
    $dg.datagrid("hideColumn", "test2");








    col = $dg.datagrid('getColumnOption', 'j_form');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(m_ShopState, value);

        }
    }
    col = $dg.datagrid('getColumnOption', 'j_freeze');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(FrozenStus, value);

        }
    }
    col = $dg.datagrid('getColumnOption', 'b_channel');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(channeltype, value);

        }
    }

    col = $dg.datagrid('getColumnOption', 'ishistory');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(ishistorytype, value);

        }
    }


    col = $dg.datagrid('getColumnOption', 'b_state');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(BusinessState, value);

        }
    } 


    $dg.datagrid();

}

