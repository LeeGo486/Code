
//创建人:俞佳伟
//创建时间:2015-06-15

var m_Warehouse = '';

$(function () {
    //查询仓库数据
    $.ajax({
        url: GetComboxWSRRURL('ab830f30-75d8-44f8-a272-f96a5bb5001a') + "&XML=" + GetFormJson([], 'GetWH'),
        type: 'post',
        async: false,
        success: function (data) {
            m_Warehouse = $.parseJSON(data);

        }
    });

    //初始化仓库
    $("#txtWarehouse").combobox({
        data: m_Warehouse,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 120,
        width: "120"
    });

    var url = GetWSRRURL('869939a3-1f2e-4756-b993-a72cb230a046') + "&XML=" + GetFormJson([], 'GetShopRetreatData');
    InitGrid(url);
});

//主页列表数据加载
function InitGrid(url) {
    $('#tabShopRetreatHead').datagrid({
        url: url,
        title: '返品退货',
        fit: true,
        striped: true,
        rownumbers: true,
        singleSelect: true,
        //onDblClickRow: onDblClickRow,
        columns: [[
            { field: 'sr1_shopretreatbillcode', title: '退仓单号' },
            { field: 'sr1_warehousebillcode', title: '总仓退仓单号' },
            { field: 'sr1_state', title: '状态' },
            { field: 'sr1_sp1_suppliercode', title: '供应商编码' },
            { field: 'sr1_po1_pocode', title: '采购单号' },
            { field: 'sr1_br1_brandcode', title: '品牌编码' },
            { field: 'sr1_purchasepricetotal', title: '采购总额' },
            { field: 'sr1_salepricetotal', title: '吊牌总额' },
            { field: 'sr1_number', title: '退货总数' },
            { field: 'sr1_money', title: '退货总额' },
            { field: 'sr1_rgdt', title: '建立日期' },
            { field: 'sr1_rguser', title: '建立人' }
        ]],
        toolbar: [
            {
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    newSR();
                }
            },
            '-',
            {
                text: '修改',
                iconCls: 'icon-edit',
                handler: function () {

                }
            },
            '-',
            {
                text: '弃审',
                iconCls: 'icon-redo',
                handler: function () {

                }
            }
        ]
    });

}

//数据列表明细
function InitList(table,url) {
    $('#' + table).datagrid({
        url: url,


    });
}

//新增
function newSR() {
    $('#winAddEdit').window({
        title: '新增返品',
        maximized: true
    }).window('open');

    $('#sltWarehouse').combobox({
        data: m_Warehouse,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 120,
        width: "120"
    });
}

//修改

//弃审

//明细查看

