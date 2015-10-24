﻿
var m_divi = $.cookie("compName"); //登录环境
var m_index = 0;
var m_url = '';
var m_dataGrid = {};

//初始化
$(function () {
    Init_Payment_List('');
    $.messager.defaults = { ok: "是", cancel: "否" };
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
        showFooter: true,
        loadMsg: '数据努力加载中...',
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'suppliercode', title: '供应商编号' },
            { field: 'suppliername', title: '供应商名称' },
            { field: 'brandname', title: '品牌名称' },
            { field: 'pocode', title: '采购单号' },
            { field: 'po2_liseq', title: '项次号' },
            { field: 'po2_lsseq', title: '子项次号' },
            { field: 'po2_pd1_supperierstyle', title: '供应商款号' },
            { field: 'po2_pd1_supperiercolor', title: '供应商颜色' },
            { field: 'po2_pd1_supperiersize', title: '供应商尺码' },
            { field: 'po2_pd1_productcode', title: 'SKU' },
            { field: 'po2_number', title: '采购数量' },
            { field: 'po2_unit', title: '单位' },
            { field: 'po2_ocurrencyprice', title: '采购单价' },
            { field: 'po2_ocurrencyamount', title: '采购金额' },
            { field: 'apcode', title: '到货计划单号' },
            { field: 'aplannumber', title: '到货计划数量' },
            { field: 'aplanamount', title: '到货计划金额' },
            { field: 'po1_paymenttypename', title: '付款方式' },
            { field: 'po2_purchasecurrency', title: '币种' },
            { field: 'unpaymenttotalamount', title: '未付金额' },
            { field: 'paymenttotalamount', title: '已付金额' },
            { field: 'paymoneysum', title: '累计已申请支付金额', width: 80 },
            { field: 'poolmoneysum', title: '累计已申请资金池抵扣金额', width: 80 },
            { field: 'depositmoneysum', title: '累计已申请定金抵扣金额', width: 80 },
            { field: 'depositbalance', title: '定金余额' },
            { field: 'carryovertotalamount', title: '未入库金额' }, //已付-入库
            { field: 'po2_rguser', title: '采购人' },
            { field: 'rpnumber', title: '入库数量' },
            { field: 'rpamount', title: '入库金额' },
            { field: 'rtnumber', title: '退货数量' },
            { field: 'rtamount', title: '退货金额' },
            { field: 'pr2_state', title: '付款状态' }
        ]],
        toolbar: [
            {
                id: 'Payment_add',
                text: '申请付款',
                iconCls: 'icon-add',
                handler: function () {
                    AddPayment();
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
                    SavePayment();
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

            } else {
                var unPay = 0;  //未付金额
                var paid = 0;   //已付金额
                var carryovertotalamount = 0; //为入库金额
                var rpnumber = 0; //入库数量
                var rpamount = 0; //入库金额
                var rtnumber = 0; //退货数量
                var rtamount = 0; //退货金额
                for (var i = 0; i < data.rows.length; i++) {
                    unPay = isNull(data.rows[i].unpaymenttotalamount) * 1 + unPay;
                    paid = isNull(data.rows[i].paymenttotalamount) * 1 + paid;
                    carryovertotalamount = isNull(data.rows[i].carryovertotalamount) * 1 + carryovertotalamount;
                    rpnumber = isNull(data.rows[i].rpnumber) * 1 + rpnumber;
                    rpamount = isNull(data.rows[i].rpamount) * 1 + rpamount;
                    rtnumber = isNull(data.rows[i].rtnumber) * 1 + rtnumber;
                    rtamount = isNull(data.rows[i].rtamount) * 1 + rtamount;
                }
                var footer = [{
                    "suppliercode": "<font color='red' size='2'>合计</font>",
                    "unpaymenttotalamount": "<font color='red' size='2'>" + unPay.toFixed(2) + "</font>",
                    "paymenttotalamount": "<font color='red' size='2'>" + paid.toFixed(2) + "</font>",
                    "carryovertotalamount": "<font color='red' size='2'>" + carryovertotalamount.toFixed(2) + "</font>",
                    "rpnumber": "<font color='red' size='2'>" + rpnumber.toFixed(2) + "</font>",
                    "rpamount": "<font color='red' size='2'>" + rpamount.toFixed(2) + "</font>",
                    "rtnumber": "<font color='red' size='2'>" + rtnumber.toFixed(2) + "</font>",
                    "rtamount": "<font color='red' size='2'>" + rtamount.toFixed(2) + "</font>"
                }];
                $('#tabPayment').datagrid('reloadFooter', footer);
            }
            //var footer = [{ "po2_ocurrencyprice": "<font color='red' size='2'>合计</font>" }];
            ////重加载数据

        }
    });
}

//查询按钮事件 
function btnSearch() {
    var strPOcode = $('#txtPOCode_Payment').val();
    var strAPcode = $('#txtAPCode').val();
    if (strPOcode == '' && strAPcode == '') {
        return false;
    }
    var data = [];
    data[data.length] = { "name": "txt模块", "value": "POPaymentTrackReport" };
    data[data.length] = { "name": "txt操作类型", "value": "GETPAYMENT" };
    data[data.length] = { "name": "txtDIVI", "value": m_divi };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt采购编号", "value": strPOcode };
    data[data.length] = { "name": "txt到货计划编号", "value": strAPcode };
    data[data.length] = { "name": "txt供应商编号", "value": '' };
    data[data.length] = { "name": "txtSKU", "value": '' };
    data[data.length] = { "name": "txt入库日期起", "value": '' };
    data[data.length] = { "name": "txt入库日期止", "value": '' };
    data[data.length] = { "name": "txt是否分页", "value": "1" };
    data[data.length] = { "name": "txt每页数量", "value": "20" };
    data[data.length] = { "name": "txt返回页码", "value": "1" };
    data[data.length] = { "name": "txt排序字段", "value": "POCode" };
    var xmlData = GetDBFrameAML(data);
    //var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
    var url = GetWSRRURL('d4fe08ef-9fc8-46f8-96cb-1ac4ef260b05') + xmlData;
    m_url = url;
    //$.ajax({
    //    url: GetWSRRURL('d4fe08ef-9fc8-46f8-96cb-1ac4ef260b05'),
    //    type: 'post',
    //    dataType: "json",
    //    data: xmlData,
    //    async: false,
    //    onError: function (data) { $.message.alert("提示","加载出错,请联系管理员","error") },
    //    success: function (data) {
    //        if (data.rows.length > 0) {
    //            m_dataGrid.total = data.rows.length;
    //            m_dataGrid.rows = data.rows;
    //            var unPay = 0;  //未付金额
    //            var paid = 0;   //已付金额
    //            var carryovertotalamount = 0; //为入库金额
    //            var rpnumber = 0; //入库数量
    //            var rpamount = 0; //入库金额
    //            var rtnumber = 0; //退货数量
    //            var rtamount = 0; //退货金额
    //            for (var i = 0; i < data.rows.length; i++) {
    //                unPay = isNull(data.rows[i].unpaymenttotalamount) * 1 + unPay;
    //                paid = isNull(data.rows[i].paymenttotalamount) * 1 + paid;
    //                carryovertotalamount = isNull(data.rows[i].carryovertotalamount) * 1 + carryovertotalamount;
    //                rpnumber = isNull(data.rows[i].rpnumber) * 1 + rpnumber;
    //                rpamount = isNull(data.rows[i].rpamount) * 1 + rpamount;
    //                rtnumber = isNull(data.rows[i].rtnumber) * 1 + rtnumber;
    //                rtamount = isNull(data.rows[i].rtamount) * 1 + rtamount;
    //            }
    //            m_dataGrid.footer = [{
    //                "suppliercode": "<font color='red' size='2'>合计</font>",
    //                "unpaymenttotalamount": unPay.toFixed(2),
    //                "paymenttotalamount": paid.toFixed(2),
    //                "carryovertotalamount": carryovertotalamount.toFixed(2),
    //                "rpnumber": rpnumber.toFixed(2),
    //                "rpamount": rpamount.toFixed(2),
    //                "rtnumber": rtnumber.toFixed(2),
    //                "rtamount": rtamount.toFixed(2)
    //            }];
    //        }
    //        Init_Payment_List(m_dataGrid);
    //    }
    //});
    Init_Payment_List(url);
}

//新增申请付款
function AddPayment() {
    var getRows = $('#tabPayment').datagrid('getChecked');
    if (getRows.length > 0) {
        var apcode = getRows[0].apcode;
        var pocode = getRows[0].pocode;
        for (var i = 0; i < getRows.length; i++) {
            var requestNum = 0;//申请付款数量(到货计划数量或者采购数量)
            //获取付款申请单号,如果不为空,则表示有付款单还未付款,不允许做付款申请
            var requestCode = getRows[i].pr2_requestcode;
            if (requestCode != '' && getRows[i].pr2_state == '已申请') {
                $.messager.alert('提示', getRows[i].po2_pd1_productcode + '还未付款,不允许再做付款申请!', 'warning');
                return false;
            }
            else if (getRows[i].pr2_state == '已完结') {
                $.messager.alert('提示', getRows[i].po2_pd1_productcode + '已完结,不允许再做付款申请!', 'warning');
                return false;
            }
            else {
                if (apcode != '') { //1.做了到货计划的,判断是否属于同一个到货计划             
                    if (apcode != getRows[i].apcode) {
                        $.messager.alert('提示', '不属于同一个到货计划', 'warning');
                        return false;
                    }
                    requestNum = getRows[i].aplannumber * 1;
                }
                else { //没有做到货计划的,判断是否属于同一个采购单
                    if (pocode != getRows[i].pocode) {
                        $.messager.alert('提示', '不属于同一个采购单', 'warning');
                        return false;
                    }
                    requestNum = getRows[i].po2_number * 1;
                }
            }
            //默认的定金抵扣金额=申请支付数量*定金分摊单价
            var depositmoney = requestNum * getRows[i].depositprice * 1.0000;
            if (depositmoney > getRows[i].depositbalance * 1) {
                getRows[i].pr2_depositmoney = getRows[i].depositbalance * 1;
            } else {
                getRows[i].pr2_depositmoney = depositmoney;
            }
            if (apcode != '') {
                getRows[i].pr2_shareamount = getRows[i].aplanamount;
            } else {
                getRows[i].pr2_shareamount = getRows[i].po2_ocurrencyamount;
            }
        }

        $('#EditWin').window('open');
        $('#NeedToPayDataTable').datagrid({
            data: getRows,
            rownumbers: true,
            fit: true,
            striped: true,
            onClickRow: clickRowToEdit,
            columns: [[
                { field: 'po2_liseq', title: '项次号' },
                { field: 'po2_lsseq', title: '子项次号' },
                { field: 'po2_state', title: '采购状态' },
                { field: 'po2_pd1_productcode', title: 'SKU' },
                { field: 'po2_pd1_supperierstyle', title: '供应商款号' },
                { field: 'po2_pd1_supperiercolor', title: '供应商颜色' },
                { field: 'po2_pd1_supperiersize', title: '供应商尺码' },
                { field: 'po2_number', title: '采购数量' },
                { field: 'apcode', title: '到货计划单号' },
                { field: 'aplannumber', title: '到货计划数量' },
                { field: 'po2_unit', title: '单位' },
                { field: 'po2_purchasecurrency', title: '币种' },
                { field: 'po2_ocurrencyprice', title: '采购单价' },
                { field: 'po2_ocurrencyamount', title: '采购金额' },
                { field: 'aplanamount', title: '到货计划金额' },
                { field: 'pr2_depositmoney', title: '定金抵扣金额', editor: { type: 'numberbox', options: { min: 0, precision: 6} } },
                { field: 'depositbalance', title: '定金余额' },
                { field: 'pr2_shareamount', title: '本次申请金额', editor: { type: 'numberbox', options: { min: 0, precision: 2 } } }
            ]]
        });
        payMentWindow(getRows, 'NewAdd');
        //文本框赋值
        $('#txtPayRequest').val('');
        $('#txtPocode').val(getRows[0].pocode);
        $('#txtAPcode').val(getRows[0].apcode);
        $('#txtSuppliercode').val(getRows[0].suppliername);
    }
    else {
        $.messager.alert('提示', '请先选中需要付款的数据', 'warning');
    }
}

//维护付款申请
function EditPayment() {
    var myRows = [];
    var getRows = $('#tabPayment').datagrid('getChecked');
    if (getRows.length > 0) {
        var requestcode = getRows[0].pr2_requestcode;
        if (requestcode == '') {
            $.messager.alert('提示', '还未做付款申请');
            return false;
        }
        for (var i = 0; i < getRows.length; i++) {
            if (getRows[i].pr2_state != '已申请') {
                $.messager.alert('警告', '不能修改', 'warning');
                return false;
            }
            if (requestcode != getRows[i].pr2_requestcode) {
                $.messager.alert('警告', '不属于同一个付款申请单', 'warning');
                return false;
            }

        }

        //获取此付款申请单下的所有子项
        var allRows = $('#tabPayment').datagrid('getRows');
        var usedPoolMoney = 0;
        for (var j = 0; j < allRows.length; j++) {
            if (allRows[j].pr2_requestcode == requestcode) {
                allRows[j].depositbalance = allRows[j]["pr2_depositmoney"] * 1 + allRows[j].depositbalance * 1;
                usedPoolMoney = usedPoolMoney + allRows[j]["pr2_poolmoney"] * 1;
                myRows[myRows.length] = allRows[j];
            }
        }

        //打开维护界面
        $('#EditWin').window('open');
        $('#NeedToPayDataTable').datagrid({
            data: myRows,
            rownumbers: true,
            fit: true,
            striped: true,
            onDblClickRow: clickRowToEdit,
            columns: [[
                { field: 'po2_liseq', title: '项次号' },
                { field: 'po2_lsseq', title: '子项次号' },
                { field: 'po2_state', title: '采购状态' },
                { field: 'po2_pd1_productcode', title: 'SKU' },
                { field: 'po2_pd1_supperierstyle', title: '供应商款号' },
                { field: 'po2_pd1_supperiercolor', title: '供应商颜色' },
                { field: 'po2_pd1_supperiersize', title: '供应商尺码' },
                { field: 'po2_number', title: '采购数量' },
                { field: 'aplannumber', title: '到货计划数量' },
                { field: 'po2_unit', title: '单位' },
                { field: 'po2_purchasecurrency', title: '币种' },
                { field: 'po2_ocurrencyprice', title: '采购单价' },
                { field: 'po2_ocurrencyamount', title: '采购金额' },
                { field: 'aplanamount', title: '到货计划金额' },
                { field: 'pr2_depositmoney', title: '定金抵扣金额', editor: { type: 'numberbox', options: { min: 0, precision: 6 } } },
                { field: 'depositbalance', title: '定金余额' },
                { field: 'pr2_shareamount', title: '本次申请金额', editor: { type: 'numberbox', options: { min: 0, precision: 2 } } }
            ]]
        });
        payMentWindow(myRows, 'Edit');
        //文本框赋值
        $('#txtPayRequest').val(myRows[0].pr2_requestcode);
        $('#txtPocode').val(myRows[0].pocode);
        $('#txtAPcode').val(myRows[0].apcode);
        $('#txtSuppliercode').val(myRows[0].suppliername);
        $('#txtUsePoolMoney').numberbox('setValue', usedPoolMoney);
    }
}

//点击行,进入编辑模式
function clickRowToEdit(index, row) {
    if (m_index != index) {
        $('#NeedToPayDataTable').datagrid('endEdit', m_index);
        m_index = index;
    }
    $('#NeedToPayDataTable').datagrid('beginEdit', m_index);
}

//保存按钮
function Save() {
    $('#NeedToPayDataTable').datagrid('endEdit', m_index);
    var saveRow = $('#NeedToPayDataTable').datagrid('getRows');
    var payMoney = 0;
    var requestMoney = 0;
    var sumRequestMoney = 0;
    if ($('#txtUsePoolMoney').numberbox('getValue') * 1 > $('#txtPoolMoney').html() * 1) {
        $.messager.alert('提示', '本次使用资金池金额不能大于资金池金额');
        return false;
    }
    for (var i = 0; i < saveRow.length; i++) {

        //条件判断
        if (saveRow[i].pr2_shareamount == '' || saveRow[i].pr2_shareamount * 1 < 0) {  //本次申请金额不能小于0或者为空
            $.messager.alert(saveRow[i].po2_pd1_productcode + ':本次申请金额不能为空或者小于0');
            return false;
        }
        if (saveRow[i].pr2_shareamount * 1 > saveRow[i].unpaymenttotalamount * 1) {   //本次申请金额不能大于未付金额
            $.messager.alert(saveRow[i].po2_pd1_productcode + ':本次申请金额不能超过未付金额!');
            return false;
        }
        if (saveRow[i].pr2_depositmoney * 1 > saveRow[i].depositbalance * 1) { //本次定金抵扣金额不能大于定金余额
            $.messager.alert(saveRow[i].po2_pd1_productcode + ':本次定金抵扣金额不能超过定金余额');
            return false;
        }
        if (saveRow[i].po2_pd1_productcode * 1 > saveRow[i].po2_pd1_productcode * 1) { //本次定金抵扣金额不能超过本次申请支付金额
            $.messager.alert(saveRow[i].po2_pd1_productcode + ':本次定金抵扣金额不能超过本次申请支付金额');
            return false;
        }

        //申请金额汇总
        sumRequestMoney = sumRequestMoney + saveRow[i].pr2_shareamount * 1;  //本次付款申请总额

    }
    $.messager.confirm('提示框', '本次申请总额为' + sumRequestMoney + ',是否确认申请', function (r) {
        if (r) {
            var lastRow = saveRow.length;
            saveRow[lastRow] = { 'poolAmount': $('#txtUsePoolMoney').numberbox('getValue') * 1, 'requestAmount': sumRequestMoney };//添加资金池使用总额,本次申请支付总额
            var XMLData = GetGetJson(saveRow, 'AddEditPayRequest');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            //return;
            $.ajax({
                url: GetWSRRURL('32d7ff9a-370e-4710-811f-b79e560e88ab'),
                type: 'post',
                async: true, //异步,
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
                            $.messager.alert("提示", result[0].rows[0].message);
                            $('#EditWin').window('close');

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
    });
}

//财务付款
function SavePayment() {
    var getRows = $('#tabPayment').datagrid('getChecked');

    if (getRows.length > 0) {
        for (var i = 0; i < getRows.length; i++) {
            //判断是否已做付款申请
            if (getRows[i].pr2_requestcode == '') {
                $.messager.alert('提示', '还未做付款申请,不允许付款', 'warning');
                return false;
            }
            if (getRows[i].pr2_state == '已付款') {
                $.messager.alert('提示', '已付款,不允许再次付款', 'warning');
                return false;
            }
        }
        //判断是否已付款

        //var xml = GetGetJson(getRows, "IsPaid");
        //var htmlobj = $.ajax({
        //    url: GetWSRRURL('32d7ff9a-370e-4710-811f-b79e560e88ab'),
        //    type: 'post',
        //    async: false, //同步,
        //    data: { "XML": xml }
        //});
        //var result = $.parseJSON(htmlobj.responseText);
        //if (result.rows[0].result.toUpperCase() == 'TRUE') {
        //    alert('不能重复付款');
        //    return false;
        //}

        var XMLData = GetEditJsonbyType(getRows, 'Insert_PBDetail');
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('32d7ff9a-370e-4710-811f-b79e560e88ab'),
            type: 'post',
            async: true, //异步,
            data: { "XML": XMLData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");
                    if (result[0].Error) {
                        $.messager.progress('close');
                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result.toUpperCase() == "FALSE") {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $.messager.progress('close');
                        $('#tabPayment').datagrid('reload');
                        alert('付款成功');
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
}

//付款完结
function EndPay() {
    var getRows = $('#tabPayment').datagrid('getChecked');
    var DoType = 0;  //DoType:1.表示将结转金额更新供应商资金池和供应商交易历史表 0.表示只修改付款申请单状态为付款已完结    
    if (getRows.length >= 1) {
        var jzMoney = 0;
        var myRows = [getRows[0]];
        jzMoney = accAdd(jzMoney, getRows[0].depositbalance);
        for (var i = 0; i < getRows.length; i++) {
            var index = myRows.length;
            if (getRows[i].pr2_state == '已完结') {
                $.messager.alert('操作提示', '已完结,不允许再次完结', 'warning');
                return false;
            }
            else if (getRows[i].pr2_state == '已申请') {
                $.messager.alert('操作提示', '还未付款,不允许完结', 'warning');
                return false;
            }
            else if (getRows[i].pr2_state == '') {
                $.messager.alert('操作提示', '还申请付款,不允许完结', 'warning');
                return false;
            }
            else {
                jzMoney = accAdd(jzMoney, getRows[i].carryovertotalamount);
                for (var j = 0; j < index; j++) {

                    if (getRows[i].pocode == myRows[j].pocode && getRows[i].po2_pd1_productcode == myRows[j].po2_pd1_productcode && getRows[i].po2_liseq == myRows[j].po2_liseq && getRows[i].po2_lsseq == myRows[j].po2_lsseq) {
                        break; //如果存在相同采购单、到货计划、款号 则跳出
                    }
                    if (j == index - 1) {
                        myRows[myRows.length] = getRows[i];
                        //jzMoney = jzMoney * 1 + getRows[i].carryovertotalamount * 1 + getRows[i].depositbalance * 1;
                        jzMoney = accAdd(jzMoney, getRows[i].depositbalance);
                    }
                }
            }
        }
        //最后一行数据用于插入供应商资金池交易历史表        
        $('#msg').window('open');
        $('#txtSupplierName').html(getRows[0].suppliername);
        $('#txtsupCurrency').html(getRows[0].po2_purchasecurrency);
        $('#txtjzmoney').val(jzMoney);
        $('#txtToPoolMoney').numberbox('setValue', jzMoney);
        $('#btnSure').bind('click', function () {
            if ($('#txtToPoolMoney').numberbox('getValue') * 1 > jzMoney * 1) {
                $.messager.alert('警告', '转入资金池金额不能大于可结转金额!', 'warning');
            }
            else {
                $('#msg').window('close');
                SavePayEnd(getRows);
            }
        });
        $('#btnCancel').bind('click', function () {
            $('#msg').window('close');
        });
    }
    else {
        $.messager.alert('提示', '请选择一行需要完结的采购单', 'warning');
        return false;
    }
}


//付款窗口 获取供应商资金池和事件触发
function payMentWindow(rows, doType) {
    //获取供应商资金池
    $('#txtUsePoolMoney').numberbox('setValue', 0);
    var data = [];
    data[data.length] = { "name": "txtDIVI", "value": rows[0].divi };
    data[data.length] = { "name": "txtSupplierCode", "value": rows[0].suppliercode };
    data[data.length] = { "name": "txtpo1_currency", "value": rows[0].po2_purchasecurrency };
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
        $('#txtCurrency').html(result.rows[0].sp2_currency);
        $('#txtPoolMoney').html(result.rows[0].sp2_poolamount);
        $('#txtUsePoolMoney').numberbox('enable');
    }
    else {
        $('#txtCurrency').html('');
        $('#txtPoolMoney').html('0');
        $('#txtUsePoolMoney').numberbox('disable');
    }
    $('#EditWin').mouseover(function () {
        $('#NeedToPayDataTable').datagrid('endEdit', m_index);
        var getRows1 = $('#NeedToPayDataTable').datagrid('getRows');
        var sumMoney = 0;
        if (getRows1.length < 1) {
            return false;
        }
        else {
            for (var i = 0; i < getRows1.length; i++) {

                if (getRows1[i].depositbalance * 1 < getRows1[i]["pr2_depositmoney"] * 1) {
                    getRows1[i]["pr2_depositmoney"] = getRows1[i].depositbalance * 1;   //当定金抵扣金额超过定金余额时,将定金抵扣金额置为定金余额
                    var rowIndex = $('#NeedToPayDataTable').datagrid('getRowIndex', getRows1[i]); // 获取行号
                    $('#NeedToPayDataTable').datagrid('refreshRow', rowIndex);
                    $.messager.alert('警告', '定金抵扣金额不能超过定金余额,已默认改成定金余额' + getRows1[i].depositbalance, 'warning');
                    return false;
                }
                sumMoney = sumMoney + getRows1[i].pr2_shareamount * 1 - getRows1[i]["pr2_depositmoney"] * 1;
            }
            sumMoney = sumMoney - $('#txtUsePoolMoney').numberbox('getValue') * 1;
            if (sumMoney < 0) {
                $.messager.alert('提示', '支付金额不能小于0', 'warning');
                return;
            }
        }
        $('#txtPay').numberbox('setValue', sumMoney);
    });
}


//取消按钮事件
function btnCancel() {
    $('#txtPOCode_Payment').val('');
    $('#txtAPCode').val('');
}

//付款完结 保存方法
function SavePayEnd(getRows) {
    getRows[getRows.length] = {
        "cono": getRows[0].cono,
        "divi": getRows[0].divi,
        "suppliercode": getRows[0].suppliercode,
        "pocode": getRows[0].pocode,
        "po2_purchasecurrency": getRows[0].po2_purchasecurrency,
        "divi": getRows[0].divi,
        "jzMoney": $('#txtToPoolMoney').numberbox('getValue')
    };
    var XMLData = GetGetJson(getRows, 'EndPay');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('32d7ff9a-370e-4710-811f-b79e560e88ab'),
        type: 'post',
        async: false, //异步,
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
                    $.messager.alert("提示", result[0].rows[0].message);
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

//精确加法计算方法
function accAdd(arg1, arg2) {
    var r1, r2, m;
    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
    m = Math.pow(10, Math.max(r1, r2))
    return (arg1 * m + arg2 * m) / m;
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