
var m_divi = $.cookie("compName"); //登录环境

$(function () {

    //初始化查询条件：
    //.仓库名称
    $('#txtwh1_warehouse').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', '', 'WH1_WareHouseCode', 'WH1_Name') + "&pagerows=20000&XML=" + GetFormJson('', 'GetSA_Location') + "&Where=WH1_DIVI='" + m_divi + "' AND WH1_State='20'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        asncy: true
    });

    //.储位
    $('#txtsa1_location').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', '', 'SA1_LocationCode', 'SA1_Name') + "&pagerows=20000&XML=" + GetFormJson('', 'GetSA_Location') + "&Where=SA1_DIVI='" + m_divi + "' AND SA1_State='20'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        asncy: true
    });

    
    //.年份   
    $('#txtst1_years').combobox({
        url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([{ "name": "txtzt", "value": m_divi }], 'GET') + "&Where=CT1_Code='" + "YEAR" + "' AND CT1_State='20'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        asncy: true
    });


    //.季节
    if (m_divi.toUpperCase() == 'GL') {
        $('#txtst1_season').combobox({
            url: GetComboxWSRRURL('597aac46-2fc7-43e7-81a6-cddf9ba869b8', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([{ "name": "txtzt", "value": m_divi }], 'GET') + "&Where=CT1_Code='" + "SSON" + "' AND CT1_State='20'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'id',
            textField: 'text',
            asncy: true
        });
    }
    else {
        $('#txtst1_season').combobox('disable');
    }

    var url = GetWSRRURL('e0dbebb3-df55-486a-9316-9b1ca5f309be') + "&XML=" + GetFormJson('', 'GetFinanceReport') + "&Where=TS1_DIVI='" + m_divi + "'";
    InitGrid(url);
});

//加载财务报表数据
function InitGrid(url) {
    $('#tabFinance').datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        columns: [[
            { field: 'ts1_wh1_warehousecode', title: '仓库编号' },
            { field: 'ts1_sa1_locationcode', title: '储位编号' },
            { field: 'sa1_name', title: '储位' },
            { field: 'st1_suppliercode', title: '供应商编号' },
            { field: 'sp1_name', title: '供应商名称' },
            { field: 'br1_name', title: '品牌名称' },
            { field: 'ts1_po1_pocode', title: '采购单号' },
            { field: 'ts1_linumber', title: '项次号' },
            { field: 'ts1_lsnumber', title: '子项次号' },
            { field: 'ts1_pd1_productcode', title: 'SKU' },
            { field: 'po2_number', title: '采购数量' },
            { field: 'st1_unit', title: '单位' },
            { field: 'ts1_transcurrency', title: '币种' },
            { field: 'po2_ocurrencyprice', title: '采购单价' },
            { field: 'po2_ocurrencyamount', title: '采购金额' },
            { field: 'po1_paymenttypename', title: '付款方式' },
            { field: 'ts1_refcode', title: '交易单号' },
            { field: 'ts1_transtype', title: '交易类型' },
            { field: 'ts1_rgdt', title: '交易日期' },
            { field: 'ts1_transoprice', title: '交易单价' },
            { field: 'ts1_transnumber', title: '交易数量' }
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

//查询
function btnSearch() {
    var where = '';
    var txtwarehouse = $('#txtwh1_warehouse').combobox('getValue');  //仓库
    var txtlocation = $('#txtsa1_location').combobox('getValue');   //储位
    var txtsupplier = $('#txtst1_name').val();  //供应商
    var txtyear = $('#txtst1_years').combobox('getValue'); //年份
    var txtseason = $('#txtst1_season').combobox('getValue'); //季节
    var txtpocode = $('#txtpo_pocode').val(); //采购单号
    var txtSKU = $('#txtpd1_productcode').val(); //sku

    if (txtwarehouse != '') {
        where += " and ts1_wh1_warehousecode='" + txtwarehouse + "'";
    }
    if (txtlocation != '') {
        where += " and ts1_sa1_locationcode='" + txtlocation + "'";
    }
    if (txtsupplier != '') {
        where += " and sp1_name='" + txtsupplier + "'";
    }
    if (txtyear != '') {
        where += " and st1_years='" + txtyear + "'";
    }
    if (txtseason != '') {
        where += " and st1_season='" + txtyear + "'";
    }
    if (txtpocode != '') {
        where += " and ts1_po1_pocode='" + txtpocode + "'";
    }
    if (txtSKU != '') {
        where += " and ts1_pd1_productcode='" + txtSKU + "'";
    }
    var url = GetWSRRURL('e0dbebb3-df55-486a-9316-9b1ca5f309be') + "&XML=" + GetFormJson('', 'GetFinanceReport') + "&Where=TS1_DIVI='" + m_divi + "'"+where;
    InitGrid(url);
}


//查看供应商资金池
function searchSupplierPoolTrans() {
    var getRows = $('#tabFinance').datagrid('getSelected');
    if (getRows.st1_suppliercode != '') {
        $('#winSupplier').window('open');
        //初始化供应商资金池界面查询条件
        $('#txtsp3_suppliercode').val(getRows.st1_suppliercode);
        $('#txtsp3_suppliername').val(getRows.sp1_name);
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
        $('#txtsp3_surplusamount').val(result[0].sp2_poolamount);

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