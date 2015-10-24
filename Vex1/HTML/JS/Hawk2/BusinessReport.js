
var m_divi = $.cookie("compName"); //登录环境

//初始化
$(function () {

    //初始化储位

    //初始化年份

    //初始化季节

    //加载业务报表数据
    var url = searchBusinessData();//GetWSRRURL('e0dbebb3-df55-486a-9316-9b1ca5f309be') + "&XML=" + GetFormJson('', 'GetBusinessReport') + "&Where=PO1_DIVI='" + m_divi + "'";
    InitGrid(url);
});

//加载业务数据
function InitGrid(url) {
    $('#tabBusiness').datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        columns: [[
            //{ field: 'rp1_sa1_locationcode', title: '储位编号' },
            //{ field: 'suppliercode', title: '供应商编号' },
            //{ field: 'suppliername', title: '供应商名称' },
            //{ field: 'brandname', title: '品牌名称' },
            //{ field: 'pocode', title: '采购单号' },
            //{ field: 'pznumber', title: '采购数量' },
            //{ field: 'currency', title: '币种' },
            //{ field: 'ocurrencysums', title: '采购金额' },
            //{ field: 'paymenttypename', title: '付款方式' },
            //{ field: 'rpnumber', title: '入库数量' },
            //{ field: 'rptotalamount', title: '入库金额' },
            //{ field: 'rtpznumber', title: '退货数量' },
            //{ field: 'rtocurrencysums', title: '退货金额' },
            //{ field: 'sp3_transamount', title: '实际结转金额' }
            { field: 'pocode', title: '采购单号', width: 60 },
            { field: 'brandname', title: '品牌', width: 80 },
            { field: 'contractcode', title: '合同编号', width: 70 },
            { field: 'sppocode', title: '供应商采购单号', width: 60 },
            { field: 'pznumber', title: '订购件数', width: 60 },
            { field: 'ocurrencysums', title: '采购金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'currency', title: '币种', width: 40 },
            { field: 'paymenttypename', title: '付款方式', width: 80 },
            { field: 'rpnumber', title: '入库件数', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'rptotalamount', title: '入库金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'prtotalamount', title: '累计申请金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'pbpaymentdeductionamount', title: '累计抵扣金额', width: 60, align: 'right', formatter: Formater.Account },
            //{ field: 'prtotalamount_new', title: '当前申请金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'sp3_transamount', title: '实际结转金额' },
            { field: 'prstate', title: '付款状态', width: 60 },
            { field: 'pbpaymenttotalamount', title: '已付金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'unpaymenttotalamount', title: '未付金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'unrptotalamount', title: '未入库金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'carryovertotalamount', title: '结转金额', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'paystate', title: '采购单付款状态', width: 60 },
            { field: 'rtpznumber', title: '退货件数', width: 60, align: 'right', formatter: Formater.Account },
            { field: 'rtocurrencysums', title: '退货金额', width: 60, align: 'right', formatter: Formater.Account }
        ]],
        toolbar: [
            {
                text: '查看供应商资金池',
                iconCls: 'icon-search',
                handler: function () {
                    searchSupplierPoolTrans();
                }
            }
        ]
    });
}

//加载供应商资金往来明细
function InitGrid_Supplier(url) {
    $('#tabSupplierList').datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        columns: [[
            { field: 'sp3_rgdt', title: '交易日期' },
            { field: 'sp3_reftype', title: '交易类型' },
            { field: 'sp3_currency', title: '币种' },
            //{ field: '', title: '期初金额' },
            { field: 'sp3_transamount', title: '交易金额' },
            { field: 'sp3_surplusamount', title: '期末金额' },
            { field: 'sp3_seq', title: '交易单据号' }
        ]]
    });
}


//查看供应商资金池
function searchSupplierPoolTrans() {
    var getRows = $('#tabBusiness').datagrid('getSelected');
    if (getRows.suppliercode != '') {
        $('#winSupplier').window('open');
        //初始化供应商资金池界面查询条件
        $('#txtsp3_suppliercode').val(getRows.suppliercode);
        $('#txtsp3_suppliername').val(getRows.suppliername);
        //查询供应商资金余额
        var data = [];
        data[data.length] = { "name": "txtDIVI", "value": m_divi };
        data[data.length] = { "name": "txtSupplierCode", "value": getRows.suppliercode };
        var url = GetWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8') + "&XML=" + GetFormJson(data, 'GetSupplierPool');
        var htmlobj = $.ajax({
            url: url,
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        $('#txtsp3_surplusamount').val(result.rows[0].sp2_poolamount);

        //初始化币种
        $('#txtcurrency').combobox({
            url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") +
                "&pagerows=20000&XML=" + GetFormJson([{ "name": "txtzt", "value": m_divi }], 'GET') + "&Where=CT1_Code='" + "CUCD" + "' AND CT1_State='20'",
            panelHeight: '120',
            valueField: 'id',
            textField: 'text'
        });

        //初始化供应商交易记录表
        var url = GetWSRRURL('e0dbebb3-df55-486a-9316-9b1ca5f309be') + "&XML=" + GetFormJson('', 'GetSupplierPoolTrans') +
            "&Where=SP3_DIVI='" + m_divi + "' AND SP3_SP1_SupplierCode='" + getRows.po1_suppliercode + "'";
        InitGrid_Supplier(url);
    }
    else {
        alert('请选择行');
    }
}

//查询业务报表数据
function searchBusinessData() {
    var txtsp1_supplier = $('#txtsp1_supplier').val();
    var txtct1_year = $('#txtct1_year').combobox('getValue');
    var txtct1_season = $('#txtct1_season').combobox('getValue');
    var txtpo1_pocode = $('#txtpo1_pocode').val();

    var data = [];
    data[data.length] = { "name": "txt模块", "value": "POPaymentTrackReport" };
    data[data.length] = { "name": "txt操作类型", "value": "GETBusiness" };
    data[data.length] = { "name": "txtDIVI", "value": m_divi };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt采购编号", "value": "" };
    data[data.length] = { "name": "txt合同编号", "value": "" };
    data[data.length] = { "name": "txt供应商采购合同", "value": "" };
    data[data.length] = { "name": "txt供应商编号", "value": "" };
    data[data.length] = { "name": "txt供应商名称", "value": txtsp1_supplier };
    data[data.length] = { "name": "txt是否分页", "value": "0" };
    data[data.length] = { "name": "txt每页数量", "value": "20" };
    data[data.length] = { "name": "txt返回页码", "value": "2" };
    data[data.length] = { "name": "txt排序字段", "value": "" };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('d4fe08ef-9fc8-46f8-96cb-1ac4ef260b05') + xmlData;
    return url;
}