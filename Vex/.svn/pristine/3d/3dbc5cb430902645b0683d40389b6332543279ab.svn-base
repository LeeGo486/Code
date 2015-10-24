
//文件名:Payment_New.js
//创建人:俞佳伟
//

var m_divi = $.cookie("compName"); //登录环境
var m_index = 0;
var m_url = '';
var m_dataGrid = {};


//初始化
$(function () {
    Init_Payment_List('');
});

//加载付款管理表数据
function Init_Payment_List(url) {
    $('#tabPayment').datagrid({
        url: url,
        //data: data,
        rownumbers: true,
        fit: true,
        striped: true,
        nowrap: true,
        singleSelect: true,
        //showFooter: true,
        loadMsg: '数据努力加载中...',
        columns: [[
            { field: 'suppliercode', title: '供应商编号' },
            { field: 'suppliername', title: '供应商名称' },
            { field: 'brandname', title: '品牌名称' },
            { field: 'pocode', title: '采购单号' },
            { field: 'po1_pznumber', title: '采购数量' },
            { field: 'po1_ocurrencysums', title: '采购金额' },
            { field: 'po1_paymenttypename', title: '付款方式' },
            { field: 'po1_currency', title: '币种' },
            { field: 'unpaymenttotalamount', title: '未付金额' },
            { field: 'paymenttotalamount', title: '已付金额' },
            { field: 'paymentdeductionamount', title: '累计资金池抵扣金额' },
            //{ field: 'paymoneysum', title: '累计已申请支付金额', width: 80 },
            //{ field: 'poolmoneysum', title: '累计已申请资金池抵扣金额', width: 80 },
            //{ field: 'depositmoneysum', title: '累计已申请定金抵扣金额', width: 80 },
            { field: 'pr1_requestamount', title: '本次申请金额' },
            { field: 'carryovertotalamount', title: '结转金额' }, //已付-入库
            { field: 'po1_rguser', title: '采购人' },
            { field: 'rpnumber', title: '入库数量' },
            { field: 'rpamount', title: '入库金额' },
            { field: 'rtnumber', title: '退货数量' },
            { field: 'rtamount', title: '退货金额' },
            { field: 'pr1_state', title: '付款状态' }
        ]],
        toolbar: [
            {
                id: 'Payment_add',
                text: '申请付款',
                iconCls: 'icon-add',
                handler: function () {
                    NewAddPayment();
                }
            },
            '-',
            {
                id: 'Payment_edit',
                text: '申请维护',
                iconCls: 'icon-edit',
                handler: function () {
                    EditPayment();
                }
            },
            '-',
            {
                id: 'Payment_pay',
                text: '财务付款',
                iconCls: 'icon-ok',
                handler: function () {
                    Pay();
                }
            },
            '-',
            {
                id: 'Payment_end',
                text: '付款完结',
                iconCls: 'icon-redo',
                handler: function () {
                    EndPay();
                }
            },
            '-',
            {
                id: 'export',
                text: '导出',
                iconCls: 'icon-print',
                handler: function () {
                    excelExport();
                }
            }
        ],
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && data.rows[0].pocode == "") {
                ClearGrid("#tabPayment");
                $.messager.alert("提示", "无相关数据!");

            }
            //else {
            //    var unPay = 0;  //未付金额
            //    var paid = 0;   //已付金额
            //    var carryovertotalamount = 0; //为入库金额
            //    var rpnumber = 0; //入库数量
            //    var rpamount = 0; //入库金额
            //    var rtnumber = 0; //退货数量
            //    var rtamount = 0; //退货金额
            //    for (var i = 0; i < data.rows.length; i++) {
            //        unPay = isNull(data.rows[i].unpaymenttotalamount) * 1 + unPay;
            //        paid = isNull(data.rows[i].paymenttotalamount) * 1 + paid;
            //        carryovertotalamount = isNull(data.rows[i].carryovertotalamount) * 1 + carryovertotalamount;
            //        rpnumber = isNull(data.rows[i].rpnumber) * 1 + rpnumber;
            //        rpamount = isNull(data.rows[i].rpamount) * 1 + rpamount;
            //        rtnumber = isNull(data.rows[i].rtnumber) * 1 + rtnumber;
            //        rtamount = isNull(data.rows[i].rtamount) * 1 + rtamount;
            //    }
            //    var footer = [{
            //        "suppliercode": "<font color='red' size='2'>合计</font>",
            //        "unpaymenttotalamount": "<font color='red' size='2'>" + unPay.toFixed(2) + "</font>",
            //        "paymenttotalamount": "<font color='red' size='2'>" + paid.toFixed(2) + "</font>",
            //        "carryovertotalamount": "<font color='red' size='2'>" + carryovertotalamount.toFixed(2) + "</font>",
            //        "rpnumber": "<font color='red' size='2'>" + rpnumber.toFixed(2) + "</font>",
            //        "rpamount": "<font color='red' size='2'>" + rpamount.toFixed(2) + "</font>",
            //        "rtnumber": "<font color='red' size='2'>" + rtnumber.toFixed(2) + "</font>",
            //        "rtamount": "<font color='red' size='2'>" + rtamount.toFixed(2) + "</font>"
            //    }];
            //    $('#tabPayment').datagrid('reloadFooter', footer);
            //}
            //var footer = [{ "po2_ocurrencyprice": "<font color='red' size='2'>合计</font>" }];
            ////重加载数据

        }
    });
}

//查询按钮事件 
function btnSearch() {
    var strPOcode = $('#txtPOCode_Payment').val();
    var strSupplier = $('#txtSupplier').val();
    if (strPOcode == '' && strSupplier == '') {
        return false;
    }
    var data = [];
    data[data.length] = { "name": "txt模块", "value": "POPaymentTrackReport" };
    data[data.length] = { "name": "txt操作类型", "value": "GETPAYMENT" };
    data[data.length] = { "name": "txtDIVI", "value": m_divi };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt采购编号", "value": strPOcode };
    data[data.length] = { "name": "txt到货计划编号", "value": '' };
    data[data.length] = { "name": "txt供应商编号", "value": strSupplier };
    data[data.length] = { "name": "txtSKU", "value": '' };
    data[data.length] = { "name": "txt入库日期起", "value": '' };
    data[data.length] = { "name": "txt入库日期止", "value": '' };
    data[data.length] = { "name": "txt是否分页", "value": "1" };
    data[data.length] = { "name": "txt每页数量", "value": "20" };
    data[data.length] = { "name": "txt返回页码", "value": "1" };
    data[data.length] = { "name": "txt排序字段", "value": "POCode" };
    var xmlData = GetDBFrameAML(data);

    var url = GetWSRRURL('d4fe08ef-9fc8-46f8-96cb-1ac4ef260b05') + xmlData;
    m_url = url;

    Init_Payment_List(url);
}

//新增申请付款
function NewAddPayment() {
    var getRow = $('#tabPayment').datagrid('getSelected');
    if (getRow == null) {
        $.messager.alert('提示', '请选择数据', 'warning');
        return;
    }
    else if (getRow.pr1_state == '已申请') {
        $.messager.alert('提示', '状态为已申请,需先付款才能再申请', 'warning');
        return;
    }
    else if (getRow.po1_paystate == '已完结') {
        $.messager.alert('提示', '该采购单已经完结,不能再次申请付款', 'warning');
        return;
    }
    else {
        $('#EditWin').window('open');
        $('#txtPocode').val(getRow.pocode);
        $('#txtSuppliercode').val(getRow.suppliername);
        $('#txtCurrency').val(getRow.po1_currency);
        $('#txtApplyMoney').numberbox('clear');
        $('#txtUsePoolMoney').numberbox('clear');
        $('#txtPayMoney').numberbox('clear');
        GetSupplierPool(getRow);
        $('#btnSave').bind('click', function () {
            //alert('新增');
            SaveApply();
        });
    }
}

//申请维护
function EditPayment() {
    var editRow = $('#tabPayment').datagrid('getSelected');
    if (editRow.pr1_state == '已申请') {
        $('#EditWin').window('open');
        $('#txtPayRequest').val(editRow.pr1_requestcode);
        $('#txtPocode').val(editRow.pocode);
        $('#txtSuppliercode').val(editRow.suppliername);
        $('#txtCurrency').val(editRow.po1_currency);
        $('#txtApplyMoney').numberbox('setValue', editRow.pr1_requestamount);
        $('#txtUsePoolMoney').numberbox('setValue', editRow.pr1_poolamount);
        $('#txtPayMoney').numberbox('setValue', editRow.pr1_payamount);

        $('#EditForm').form('validate');
        GetSupplierPool(editRow);
        $('#btnSave').bind('click', function () {
            //alert('维护');
            SaveEdit();
        });
    } else {
        $.messager.alert('提示', '未申请,不能编辑', 'warning');
        return false;
    }
}

//获取供应商资金池金额 && 控制使用资金池金额
function GetSupplierPool(row) {
    var data = [];
    data[data.length] = { "name": "txtDIVI", "value": row.divi };
    data[data.length] = { "name": "txtSupplierCode", "value": row.suppliercode };
    data[data.length] = { "name": "txtCurrency", "value": row.po1_currency };
    var xmlData = GetFormJson(data, 'GetSupplierPool');
    var url = GetWSRRURL('7ea4d40d-02fa-43cf-ae3c-8231943f8124');
    var htmlobj = $.ajax({
        url: url,
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.rows.length > 0 && result.rows[0].sp2_currency != '' && result.rows[0].sp2_poolamount != '') {
        //$('#txtCurrency').val(result.rows[0].sp2_currency);
        $('#txtPoolMoney').val(result.rows[0].sp2_poolamount);
        //$('#txtUsePoolMoney').numberbox('enable');
    }
    else {
        //$('#txtCurrency').val('');
        $('#txtPoolMoney').val('0');
        //$('#txtUsePoolMoney').numberbox('disable');
    }

    //
    $('#EditWin').mouseover(function () {
        var applyMoney = $('#txtApplyMoney').numberbox('getValue');
        var usePoolMoney = $('#txtUsePoolMoney').numberbox('getValue');
        var poolMoney = $('#txtPoolMoney').val();
        if (applyMoney != '' && usePoolMoney != '') {
            //资金池使用金额小于等于资金池金额 && 资金池使用金额小于等于申请金额
            if (applyMoney - usePoolMoney >= 0) {
                if (poolMoney - usePoolMoney >= 0) {
                    $('#txtPayMoney').numberbox('setValue', applyMoney - usePoolMoney);
                    $('#txtmsg').html('');
                }
                else {
                    $('#txtmsg').html('资金池使用金额不能超过资金金额');
                }
            }
            else {
                $('#txtmsg').html('资金池使用金额不能超过本次申请金额');
            }
        }
    });
}

//保存付款申请
function SaveApply() {
    //保存时,判断填写的数据是否正确
    var saveRow = $('#tabPayment').datagrid('getSelected');
    var applyMoney = $('#txtApplyMoney').numberbox('getValue');
    var usePoolMoney = $('#txtUsePoolMoney').numberbox('getValue');
    var poolMoney = $('#txtPoolMoney').val();
    if (applyMoney == '' || usePoolMoney == '') {
        $.messager.alert('提示', '必填项数据不能为空', 'error');
        return false;
    }
    if (applyMoney - usePoolMoney < 0) {
        $.messager.alert('提示', '资金池使用金额不能超过本次申请金额', 'error');
        return false;
    }
    if (poolMoney - usePoolMoney < 0) {
        $.messager.alert('提示', '资金池使用金额不能超过资金金额', 'error');
        return false;
    }

    var data = [];
    data[data.length] = { "name": "txtpocode", "value": saveRow.pocode };
    data[data.length] = { "name": "txtPurchaseMoney", "value": saveRow.po1_ocurrencysums };
    data[data.length] = { "name": "txtPR1_PO1_SPPOCode", "value": saveRow.sppocode };
    data[data.length] = { "name": "txtPR1_RequestAmount", "value": applyMoney };
    data[data.length] = { "name": "txtPR1_PoolAmount", "value": usePoolMoney };
    data[data.length] = { "name": "txtPR1_PO1_Currency", "value": saveRow.po1_currency };
    var XMLData = GetFormJson(data, "ApplyForPayment");
    $.messager.confirm('提示框', '确认要申请?', function (r) {
        if (r) {
            Save(XMLData, '#EditWin');
        }
    });
    return false;
}

//保存申请维护
function SaveEdit() {
    var editRow = $('#tabPayment').datagrid('getSelected');
    var txtPayRequest = $('#txtPayRequest').val();
    var applyMoney = $('#txtApplyMoney').numberbox('getValue');
    var usePoolMoney = $('#txtUsePoolMoney').numberbox('getValue');
    var poolMoney = $('#txtPoolMoney').val();
    if (txtPayRequest == '' || txtPayRequest == undefined) {
        $.messager.alert('提示', '付款申请单号不能为空', 'warning');
        return false;
    }
    if (applyMoney == '' || usePoolMoney == '') {
        $.messager.alert('提示', '必填项数据不能为空', 'error');
        return false;
    }
    if (applyMoney - usePoolMoney < 0) {
        $.messager.alert('提示', '资金池使用金额不能超过本次申请金额', 'error');
        return false;
    }
    if (poolMoney - usePoolMoney < 0) {
        $.messager.alert('提示', '资金池使用金额不能超过资金金额', 'error');
        return false;
    }
    var data = [];
    data[data.length] = { "name": "txtPR1_RequestCode", "value": txtPayRequest };
    data[data.length] = { "name": "txtPR1_RequestAmount", "value": applyMoney };
    data[data.length] = { "name": "txtPR1_PoolAmount", "value": usePoolMoney };
    data[data.length] = { "name": "txtpocode", "value": editRow.pocode };
    data[data.length] = { "name": "txtPurchaseMoney", "value": editRow.po1_ocurrencysums }
    //data[data.length] = { "name": "txtPR1_PO1_Currency", "value": "" };
    var XMLData = GetFormJson(data, "EditPaymentApply");
    $.messager.confirm('提示框', '确认要修改?', function (r) {
        if (r) {
            Save(XMLData, '#EditWin');
        }
    });
    return false;
}

//保存方法
function Save(XMLData, window) {
    $.ajax({
        url: GetWSRRURL('32d7ff9a-370e-4710-811f-b79e560e88ab'),
        type: 'post',
        async: false, //同步,
        data: { "XML": XMLData },
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
                    $('#tabPayment').datagrid("reload");
                    $.messager.alert("提示", result[0].rows[0].message, "info");
                    if (window != '') {
                        $(window).window('close');
                    }
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.progress('close');
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

//付款单付款
function Pay() {
    var payRow = $('#tabPayment').datagrid('getSelected');
    if (payRow.pocode == '') {
        $.messager.alert('提示', '请选择申请单', 'warning');
    }
    else if (payRow.pr1_state != '已申请') {
        $.messager.alert('提示', '未申请,不能付款', 'warning');
    }
    else {
        var data = [];
        data[data.length] = { "name": "txtPB1_CONO", "value": payRow.cono };
        data[data.length] = { "name": "txtDIVI", "value": payRow.divi };
        data[data.length] = { "name": "txtPO1_Code", "value": payRow.pocode };
        data[data.length] = { "name": "txtPO1_SupplierCode", "value": payRow.suppliercode };
        data[data.length] = { "name": "txtPO1_Currency", "value": payRow.po1_currency };
        data[data.length] = { "name": "txtPB1_PR1_RequestCode", "value": payRow.pr1_requestcode };
        data[data.length] = { "name": "txtPB1_PaymentAmount", "value": payRow.pr1_payamount };
        data[data.length] = { "name": "txtPB1_PaymentTotalAmount", "value": payRow.pr1_requestamount };
        data[data.length] = { "name": "txtPB1_PaymentDeductionAmount", "value": payRow.pr1_poolamount };
        //data[data.length] = { "name": "txtPB1_PaymentDepositAmount", "value": payRow.pr1_depositmoney };

        var XMLData = GetFormJson(data, "Pay");
        $.messager.confirm('提示框', '确认要付款?', function (r) {
            if (r) {
                Save(XMLData, '');
            }
        });
    }
}

//付款完结
function EndPay() {
    var endPayRow = $('#tabPayment').datagrid('getSelected');
    if (endPayRow.pocode == '' || endPayRow.pocode == undefined) {
        $.messager.alert('提示', '请选中需要完结的付款单', 'warning');
    }
    else if (endPayRow.pr1_state != '已付款') {
        $.messager.alert('提示', '未付款,不能付款完结', 'warning');
    }
    else {
        $('#msg').window('open');
        $('#txtSupplierName').html(endPayRow.suppliername);
        $('#txtsupCurrency').html(endPayRow.po1_currency);
        $('#txtjzmoney').html(endPayRow.carryovertotalamount);
        $('#txtToPoolMoney').numberbox('setValue', endPayRow.carryovertotalamount);
    }

    //保存付款完结
    $('#btnSure').bind('click', function () {
        var jzMoney = $('#txtjzmoney').html();
        var toPollMoney = $('#txtToPoolMoney').numberbox('getValue');
        if (isNull(jzMoney) < isNull(toPollMoney)) {
            $.messager.alert('提示', '转入资金池的金额不能超过可结转金额', 'warning');
        } else {
            var data = [];
            data[data.length] = { "name": "txtDIVI", "value": endPayRow.divi };
            data[data.length] = { "name": "txtSupplierCode", "value": endPayRow.suppliercode };
            data[data.length] = { "name": "txtpocode", "value": endPayRow.pocode };
            data[data.length] = { "name": "txtToPoolMoney", "value": toPollMoney };
            data[data.length] = { "name": "txtCurrency", "value": endPayRow.po1_currency };
            //data[data.length] = { "name": "txt", "value": "" };
            //data[data.length] = { "name": "txt", "value": "" };
            //data[data.length] = { "name": "txt", "value": "" };
            var XMLData = GetFormJson(data, "SaveEndPay");
            $.messager.confirm('提示框', '确认要完结?', function (r) {
                if (r) {
                    Save(XMLData, '#msg');
                }
            });
        }

    });

    $('#btnCancel').bind('click', function () {
        $('#msg').window('close');
    });
}

//ISNULL
function isNull(number) {
    if (!isNaN(number)) {
        return number;
    }
    else {
        return 0;
    }
}

//导出
function excelExport() {

    var listData = $('#tabPayment').datagrid('getRows');

    if (listData.length <= 1 || listData == undefined) {
        $.messager.alert('提示', '请先加载数据', 'warning');
        return;
    }

    EasyUI_DataGrid_ExcelExport1($('#tabPayment'), $('#tabPayment'));
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

    var dataOptions = pgrid.datagrid("options");


    var strUrl = m_url;

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "付款报表";

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
