//俞佳伟
//2015-05-11

var m_index = 0;
var m_url = '';

//初始化基础数据
$(function () {

    //加载供应商下拉数据
    $('#txtSupplier').combobox({
        url: GetComboxWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51', "", "SP1_SupplierCode", "SP1_Name") + "&pagerows=20000&XML=" + GetFormJson('', 'GetSupplier'),
        valueField: 'id',
        textField: 'text'
    });

    //加载仓库下拉数据
    $('#txtWarehouse').combobox({
        url: GetComboxWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124', "", "WH1_WareHouseCode", "WH1_Name") + "&XML=" + GetGetJson([], 'GetWH'),
        valueField: 'id',
        textField: 'text',
        required: true
    });
    var url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetShopRetreat');
    InitGrid_SR1_ShopRetreatHead(url);
});

//店铺退货主表加载
function InitGrid_SR1_ShopRetreatHead(url) {
    $('#sellBackList').datagrid({
        url: url,
        striped: true,
        sortName: 'sr1_rgdt',
        sortOrder: 'desc',
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        onDblClickRow: GetSRDetail,
        fit: true,
        singleSelect: true,
        columns: [[
            { field: 'sr1_shopretreatbillcode', title: '退仓单号' },
            { field: 'statename', title: '退仓单状态' },
            { field: 'sr1_warehousebillcode', title: '总仓退仓单号-POS' },
            { field: 'sr1_warehousename', title: '退货仓库' },
            { field: 'sp1_name', title: '供应商名称' },
            { field: 'br1_name', title: '品牌名称' },
            { field: 'sr1_po1_pocode', title: '采购单号' },
            { field: 'sr1_numbertotal', title: '退货数量' },
            { field: 'sr1_money', title: '退货金额' },
            { field: 'po1_currency', title: '币种' },
            { field: 'sr1_rguser', title: '退货人' },
            { field: 'sr1_rgdt', title: '退货时间' }
        ]],
        toolbar: [
            {
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    winAddEdit('add');
                }
            },
            '-',
            {
                text: '审核',
                iconCls: 'icon-ok',
                handler: function () {
                    checkOK();
                }
            },
            '-',
            {
                text: '弃审',
                iconCls: 'icon-cancel',
                handler: function () {
                    checkNO();
                }
            },
            '-',
            {
                text: '维护',
                iconCls: 'icon-edit',
                handler: function () {
                    winAddEdit('edit');
                }
            }
        ]

    });
}

//查询店铺退货主表信息(主页)
function btnSearchShopRetreatHead() {
    var url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetShopRetreat') + "&Where=";
    var SellbackCode = $('#txtSellbackCode').val();
    var Supplier = $('#txtSupplier').combobox('getValue');
    var POCode = $('#txtPOCode').val();
    var beginDate = $('#txtBeginDate').datebox('getText');
    var endDate = $('#txtEndDate').datebox('getText');
    var where = '1=1 ';
    if (SellbackCode != '') {
        where += " AND SR1_ShopRetreatBillCode='" + SellbackCode + "'";
    }
    if (Supplier != '') {
        where += " AND SR1_SP1_SupplierCode='" + Supplier + "'";
    }
    if (POCode != '') {
        where += " AND SR1_PO1_POCode='" + POCode + "'";
    }
    if (beginDate == '') {
        beginDate = '1990-01-01';
        //where += " AND Convert(varchar(10),SR1_RgDt,120) >='" + beginDate + "'";
    }
    if (endDate == '') {
        endDate = '2222-02-02';
    }
    where += " AND Convert(varchar(10),SR1_RgDt,120) BETWEEN '" + beginDate + "' AND '" + endDate + "'";
    url += escape(where);

    InitGrid_SR1_ShopRetreatHead(url);
}

//新增 维护 弹出窗口
function winAddEdit(type) {
    if (type == 'add') {
        $('#winEdit').window('open');
        $('#txtPOCode_edit').val('');
        $('#txtPOCode_edit').removeAttr('disabled', false);
        $('#txtAPOCode').val('');
        $('#txtAPOCode').removeAttr('disabled', false);
        $('#txtWarehouse').combobox('clear');
        //var url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetAddList') + "&Where=1=1000";
        InitGrid_List('');
    }
    else {
        var getRow = $('#sellBackList').datagrid('getSelected');
        if (getRow.length < 1) {
            alert('请选择需要维护的数据行');
        }
        if (getRow.sr1_state == '35') {
            $.messager.alert('提示', '请先弃审!', 'warning');
            return false;
        }
        $('#winEdit').window('open');
        var shopretreatbillcode = getRow.sr1_shopretreatbillcode;
        var url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetEditList') + "&Where=SR1_ShopRetreatBillCode='" + shopretreatbillcode + "' ";
        InitGrid_List(url);
        //赋值 采购单号、到货计划编号、
        $('#txtPOCode_edit').val(getRow.sr1_po1_pocode);
        $('#txtPOCode_edit').attr('disabled', true);
        $('#txtAPOCode').val('');
        $('#txtAPOCode').attr('disabled', true);
        $('#txtWarehouse').combobox('setValue', getRow.sr1_warehousecode);
    }
}

//加载新增、维护界面表数据
function InitGrid_List(url) {
    ClearGrid('#tabDataList');
    $('#tabDataList').datagrid({
        url: url,
        striped: true,
        //pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        onSelect: onSelect,
        singleSelect: true,
        onDblClickRow: onDblClickRow,
        columns: [[
            { field: 'po1_pocode', title: '采购单号' },
            { field: 'po2_pd1_supperierstyle', title: '供应商款号' },
            { field: 'po2_pd1_supperiercolor', title: '供应商颜色' },
            { field: 'po2_pd1_supperiersize', title: '供应商尺码' },
            { field: 'po2_pd1_productcode', title: 'SKU' },
            { field: 'po2_number', title: '采购数量' },
            { field: 'ap2_apcode', title: '到货计划编号' },
            { field: 'ap2_aplannumber', title: '到货计划数量' },
            { field: 'poreceipt', title: '入库类型' },
            { field: 'nums', title: '入库总数' },
            { field: 'oprice', title: '入库单价', formatter: Formater.Account },
            { field: 'rtnumber', title: '已退货数量' },
            { field: 'rtnum', title: '本次退货数量', editor: 'numberbox', options: { min: 0, precision: 2 } },
            { field: 'rtoamount', title: '本次退货金额', formatter: Formater.Account },
            { field: 'sr2_remarks', title: '备注', editor: 'text', width: 100 }
        ]],
        toolbar: [
            {
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {
                    btnSave();
                }
            }
        ],
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && data.rows[0].po1_pocode == '') {
                ClearGrid('#tabDataList');
            }
        }
    });
}

//新增、维护界面查询按钮事件
function btnSearch() {

    var APOCode = $('#txtAPOCode').val();
    var Warehouse = $('#txtWarehouse').combobox('getValue');
    var WarehouseName = $('#txtWarehouse').combobox('getText');
    var POCode = $('#txtPOCode_edit').val();
    if (APOCode + POCode == '') {
        alert('采购单号、到货计划必须至少填一个');
        return false;
    }
    if (Warehouse == '') {
        alert('请选择退货仓库');
        return false;
    }

    var url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetAddList') + "&Where=";

    var where = '1=1 ';
    if (APOCode != '') {
        where += " AND AP2_APCode='" + APOCode + "'";
    }
    //if (Warehouse != '') {
    //    where += " AND SR1_WareHouseCode='" + Warehouse + "'";
    //}
    if (POCode != '') {
        where += " AND PO1_POCode='" + POCode + "'";
    }
    url += where;
    InitGrid_List(url);
}

//双击查看明细 
function GetSRDetail(index, row) {
    $('#winDetail').window('open');
    var shopretreatbillcode = row.sr1_shopretreatbillcode;
    m_url = GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51') + "&XML=" + GetFormJson('', 'GetEditList') + "&Where=SR1_ShopRetreatBillCode='" + shopretreatbillcode + "' ";

    $('#tabDetail').datagrid({
        url: m_url,
        striped: true,
        //pagination: true, //是否开启分页
        //pageSize: 20, //默认一页数据条数 
        rownumbers: true,
        fit: true,
        singleSelect: true,
        columns: [[
            { field: 'po1_pocode', title: '采购单号' },
            { field: 'po2_pd1_supperierstyle', title: '供应商款号' },
            { field: 'po2_pd1_supperiercolor', title: '供应商颜色' },
            { field: 'po2_pd1_supperiersize', title: '供应商尺码' },
            { field: 'po2_pd1_productcode', title: 'SKU' },
            { field: 'po2_number', title: '采购数量' },
            { field: 'ap2_apcode', title: '到货计划编号' },
            { field: 'ap2_aplannumber', title: '到货计划数量' },
            { field: 'poreceipt', title: '入库类型' },
            { field: 'nums', title: '入库总数' },
            { field: 'oprice', title: '入库单价', formatter: Formater.Account },
            { field: 'rtnumber', title: '已退货数量' },
            { field: 'rtnum', title: '本次退货数量', editor: 'numberbox', options: { min: 0, precision: 2 } },
            { field: 'rtoamount', title: '本次退货金额', formatter: Formater.Account },
            { field: 'sr2_remarks', title: '备注', editor: 'text', width: 100 }
        ]],
        toolbar: [
            {
                text: '导出',
                iconCls: 'icon-print',
                handler: function () {
                    excelExport();
                }
            }
        ]
    });
}

//单击List表
function onSelect(index, row) {
    if (index != m_index) {
        $('#tabDataList').datagrid('endEdit', m_index);
        AutoCalculate();
    }
    m_index = index;
}

//双击事件
function onDblClickRow(index, row) {
    if (index != m_index) {
        $('#tabDataList').datagrid('endEdit', m_index);
        m_index = index;
    }
    $('#tabDataList').datagrid('beginEdit', m_index);
}

//自动计算退货金额
function AutoCalculate() {
    var row = $('#tabDataList').datagrid('getRows');
    for (var i = 0; i < row.length; i++) {
        var price = row[i].oprice;
        var numbers = isNull(row[i].rtnum); //本次退货总数
        var nums = row[i].nums; //入库总数
        if (numbers != '') {
            if (numbers * 1 <= nums * 1) {
                var rtamount = price * numbers;
                $('#tabDataList').datagrid('updateRow', {
                    index: i,
                    row: {
                        rtoamount: rtamount
                    }
                });
            }
            else {
                $('#tabDataList').datagrid('updateRow', {
                    index: i,
                    row: {
                        rtnum: 0
                    }
                });
                $.messager.alert('警告', '第' + (i + 1) + '行：退货数超过入库总数,<br />系统自动改为0!', 'warning');

            }
        }
    }
}

//保存按钮事件
function btnSave() {
    $('#tabDataList').datagrid('endEdit', m_index);
    var Warehouse = $('#txtWarehouse').combobox('getValue');
    var WarehouseName = $('#txtWarehouse').combobox('getText');
    var rows = [];
    var uptRows = $('#tabDataList').datagrid('getChanges', 'updated');
    if (uptRows.length < 1) {
        alert('没有需要更新的数据');
        return false;
    }
    for (var i = 0; i < uptRows.length; i++) {  //添加仓库编号、名称
        if (uptRows[i].rtnum != 0 && uptRows[i].rtnum != '') {
            uptRows[i].sr1_warehousecode = Warehouse;
            uptRows[i].sr1_warehousename = WarehouseName;
            rows[rows.length] = uptRows[i];
        }
    }
    var xmlData = GetGetJson(uptRows, 'Edit');
    $.messager.progress({ title: '请稍后,不保存退货数量为0', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('3ab6728f-7324-4eec-8c07-6ac675672e51'),
        type: 'post',
        async: false, //异步,
        data: { "XML": xmlData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $.messager.progress('close');                   
                    $('#winEdit').window('close');
                    $.messager.alert("提示", result[0].rows[0].message);
                    $('#sellBackList').datagrid('reload');
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');

            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

//isnull
function isNull(num) {
    if (num == '' || num == undefined) {
        return 0;
    }
    else {
        return num;
    }
}

//审核
function checkOK() {
    var getRow = $('#sellBackList').datagrid('getSelected');
    if (getRow == null) {
        $.messager.alert('提示', '请选中需要审核的数据!', 'warning');
        return false;
    }
    else {
        $.messager.confirm('提示', '是否确认申请', function (r) {
            if (r) {
                var strCONO = getRow.sr1_cono;
                var strDIVI = getRow.sr1_divi;
                var strCode = getRow.sr1_shopretreatbillcode; //退仓单号
                var strBackCode = getRow.sr1_warehousebillcode; //pos退仓单号
                var data = [];
                if (strBackCode == '') {  //审核
                    data = [];
                    data[data.length] = { "name": "txt操作类型", "value": "NEW" };
                    data[data.length] = { "name": "txt实体", "value": "保存退仓单" };
                    data[data.length] = { "name": "txtCONO", "value": strCONO };
                    data[data.length] = { "name": "txtDIVI", "value": strDIVI };
                    data[data.length] = { "name": "txt退仓单号", "value": strCode };
                }

                if (strBackCode != '') { //修改审核
                    data = [];
                    data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
                    data[data.length] = { "name": "txt实体", "value": "修改审核" };
                    data[data.length] = { "name": "txtCONO", "value": strCONO };
                    data[data.length] = { "name": "txtDIVI", "value": strDIVI };
                    data[data.length] = { "name": "txt退仓单号", "value": strCode };
                    data[data.length] = { "name": "txtPOS退仓单号", "value": strBackCode };

                }

                save(data);
            }
        });
    }

}

//弃审
function checkNO() {
    var getRow = $('#sellBackList').datagrid('getSelected');
    if (getRow == null) {
        $.messager.alert('提示', '请选中需要审核的数据!', 'warning');
        return false;
    } else {
        $.messager.confirm('提示', '是否确认弃审?', function (r) {
            if (r) {
                var strCONO = getRow.sr1_cono;
                var strDIVI = getRow.sr1_divi;
                var strCode = getRow.sr1_shopretreatbillcode; //退仓单号
                var strBackCode = getRow.sr1_warehousebillcode; //pos退仓单号
                var data = [];
                data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
                data[data.length] = { "name": "txt实体", "value": "弃审" };
                data[data.length] = { "name": "txtCONO", "value": strCONO };
                data[data.length] = { "name": "txtDIVI", "value": strDIVI };
                data[data.length] = { "name": "txt退仓单号", "value": strCode };
                data[data.length] = { "name": "txtPOS退仓单号", "value": strBackCode };

                save(data);
            }
        });

    }
}

//审核、弃审
function save(data) {
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    //调用后台API
    var XMLData = GetDBFrameAML(data);
    $.ajax({
        url: GetWSRRURL('ca692418-7587-4465-b367-3cb53d679be6') + XMLData,
        type: 'post',
        async: false, //同步
        success: function (result) {
            try {

                var result = eval("[" + result + "]");

                if (result[0].rows[0].column1 == '1') {
                    $.messager.progress('close');
                    $('#sellBackList').datagrid("reload");
                    $.messager.alert("提示", '成功!');

                }
                else {
                    $.messager.progress('close');
                    $.messager.alert("提示", '失败!', 'error');
                }

            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert('提示', '出现异常', 'error');
        }
    });
}

//取消按钮事件
function Cancel() {
    $('#txtPOCode_edit').val('');
    $('#txtAPOCode').val('');
    $('#txtWarehouse').combobox('clear');
}


//导出
function excelExport() {

    var listData = $('#tabDetail').datagrid('getRows');

    if (listData.length <= 1 || listData == undefined) {
        $.messager.alert('提示', '请先加载数据', 'warning');
        return;
    }

    EasyUI_DataGrid_ExcelExport1($('#tabDetail'), $('#tabDetail'));
}

//导出Exel主函数
function EasyUI_DataGrid_ExcelExport1(pgrid, pagination) {
    var btnExcel = null;
    pagination.find('a.l-btn').each(function () {
        if ($(this).find('span.icon-excel').length) {
            btnExcel = $(this);
            btnExcel.linkbutton('disable');
            btnExcel.linkbutton({ iconCls: "pagination-loading" });

        }
    });
    //if (btnExcel == null) {
    //    return;
    //}

    var dataOptions = pgrid.datagrid("options");


    var strUrl = m_url;

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "代销退厂明细报表";

    var strXMLCol = "<Root><List>";

    if (dataColumnsFrozen != null && dataColumnsFrozen.length > 0) {
        for (var i = 0; i < dataColumnsFrozen[0].length; i++) {

            if (dataColumnsFrozen[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";

            if (dataColumnsFrozen[0][i].title) {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
            }
            else {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].field + "</title>";

            }
            if (dataColumnsFrozen[0][i].width) {
                strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumnsFrozen[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumnsFrozen[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumnsFrozen[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }
    if (dataColumns != null && dataColumns.length > 0) {
        for (var i = 0; i < dataColumns[0].length; i++) {

            if (dataColumns[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + (dataColumns[0][i].field) + "</field>";

            if (dataColumns[0][i].title) {
                strXMLCol += "<title>" + (dataColumns[0][i].title) + "</title>";
            }
            else {
                strXMLCol += "<title>" + (dataColumns[0][i].field) + "</title>";

            }

            if (dataColumns[0][i].width) {
                strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumns[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumns[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumns[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }

    strXMLCol += "</List></Root>";

    strXMLCol = strXMLCol.replace(/\(/g, "").replace(/\)/g, "");
    dataParam.ExcelExportColumns = strXMLCol;

    $.messager.confirm('提示框', "是否导出", function (e) {
        if (e) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title=" + escape(title) + "&rd=" + Math.random(),
                data: dataParam,
                type: 'POST',
                options: "JSON",
                success: function (data) {
                    if (btnExcel != null) {
                        btnExcel.linkbutton('enable');

                        btnExcel.linkbutton({ iconCls: "icon-excel" });
                    }
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    $.messager.progress('close');
                    var strFileName = eval("[" + data + "]")[0].FileName;
                    //strFileName = strFileName.substring(0, 29) + FileName.substring(4);
                    window.location.href = strFileName;
                },
                error: function (date) {
                    $.messager.alert('提示', '错误!', 'error');
                    $.messager.progress('close');
                }

            });
            return false;
        }
    });
}