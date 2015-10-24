/// JS名：Paymeng.js
/// 说明：付款单
/// 创建人：郭琦琦 
/// 创建日期：2014-06-06

var m_index = -1;//全局行号为保存之后默认选择之前的行

$(function () {

    initGird();

    //光标移走自动计算付款申请单总金额
    $("#formAddPayment").find("input").blur(function () {
        var pr1_RequestAmount = $('#formAddPayment').find("#txtpr1_requestamount").numberbox("getValue")//取申请金额
        var pr1_PoolAmount = $('#formAddPayment').find("#txtpr1_poolamount").numberbox("getValue")//取使用资金池
        //如果申请金额和使用资金池金额都为空，返回
        if (pr1_RequestAmount == "" && pr1_PoolAmount == "") {
            return;
        }
        else {
            //申请金额加上使用资金池金额，付给总金额
            var total = pr1_RequestAmount * 1 + pr1_PoolAmount * 1;
            var total = (total * 1).toFixed(2);//取2位小数
            $('#formAddPayment').find("#txtpr1_totalamount").val(total)
        }
    });

    //光标移走自动计算付款单总金额
    $("#formEditPB1_PaymentBill").find("input").blur(function () {
        var pb1_PaymentAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentamount").numberbox("getValue")//取本次支付金额
        var pb1_PaymentDeductionAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").numberbox("getValue")//取本次支付金额——资金池金额
        var amountpaid = $('#formEditPB1_PaymentBill').find("#txtamountpaid").val()//取已支付金额
        var po1_OcurrencySums = $('#formEditPB1_PaymentBill').find("#txtpo1_ocurrencysums").val()//取申请金额

        //如果付款金额和抵扣资金池金额都为空，返回
        if (pb1_PaymentAmount == "" && pb1_PaymentDeductionAmount == "") {
            return;
        }
        else {
            //付款金额加上抵扣金额，付给付款总金额
            var total = pb1_PaymentAmount * 1 + pb1_PaymentDeductionAmount * 1;
            var total = (total * 1).toFixed(2);//取2位小数
            $('#formEditPB1_PaymentBill').find("#txtpb1_paymenttotalamount").val(total)
            //如果付款总金额等于申请总金额，自动勾上完结按钮
            if (amountpaid * 1 + total * 1 == po1_OcurrencySums * 1) {
                $('#Checkbox').attr("checked", "true");
            }
            else {
                $('#Checkbox').removeAttr("checked");
            }
        }
    });
})
//前台筛选
function seacher() {
    initGird();
}

//取消筛选参数
function seacherCancel() {
    $('#formselect').find("#txtpo1_pocode").val("");
    $('#formselect').find("#txtpo1_contractcode").val("");
    $('#formselect').find("#txtpo1_sppocode").val("");
    $('#formselect').find("#txtsp1_suppliercode").val("");
    $('#formselect').find("#txtsp1_name").val("");
}

//加载数据
function initGird() {
    //创建获取数据XML
    var data1 = [];
    data1[data1.length] = { "name": "txt模块", "value": "POPaymentTrackReport" };
    data1[data1.length] = { "name": "txtDIVI", "value": "LX" };
    data1[data1.length] = { "name": "txtCONO", "value": "HYFG" };
    data1[data1.length] = { "name": "txt采购编号", "value": $('#formselect').find("#txtpo1_pocode").val() };
    data1[data1.length] = { "name": "txt合同编号", "value": $('#formselect').find("#txtpo1_contractcode").val() };
    data1[data1.length] = { "name": "txt供应商采购合同", "value": $('#formselect').find("#txtpo1_sppocode").val() };
    data1[data1.length] = { "name": "txt供应商编号", "value": $('#formselect').find("#txtsp1_suppliercode").val() };
    data1[data1.length] = { "name": "txt供应商名称", "value": $('#formselect').find("#txtsp1_name").val() };
    data1[data1.length] = { "name": "txt是否分页", "value": "1" };
    data1[data1.length] = { "name": "txt每页数量", "value": "20" };
    data1[data1.length] = { "name": "txt返回页码", "value": "1" };
    data1[data1.length] = { "name": "txt排序字段", "value": "PO1_POCode" };
    var xmlData1 = GetDBFrameAML(data1);//组成调用APIxml
    var url = GetWSRRURL('d4fe08ef-9fc8-46f8-96cb-1ac4ef260b05') + xmlData1
    $('#Pr1_PaymentrequisitList').datagrid(
        {
            title: '付款单', //表格标题
            url: url,
            //sortName: 'po1_pocode', //排序字段
            //idField: 'pr1_id', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            //sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            onSelect: onClickRow,//单击事件
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
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
                { field: 'prtotalamount_new', title: '当前申请金额', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'prstate', title: '付款状态', width: 60 },
                { field: 'pbpaymenttotalamount', title: '已付金额', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'unpaymenttotalamount', title: '未付金额', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'unrptotalamount', title: '未入库金额', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'carryovertotalamount', title: '结转金额', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'paystate', title: '采购单付款状态', width: 60 },
                { field: 'rtpznumber', title: '退货件数', width: 60, align: 'right', formatter: Formater.Account },
                { field: 'rtocurrencysums', title: '退货金额', width: 60, align: 'right', formatter: Formater.Account }
            ]],
            //工具条
            toolbar: "#tab_toolbar",
            //onLoadSuccess: function () {
            //    //如果行号为空不进行任何操作，如果不为空，按照行号选中
            //    if (m_index == -1) {

            //    }
            //    else if (m_index != -1) {
            //        $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index)
            //    }
            //},
            onLoadSuccess: function (data) {
                if (data.rows == null || data.rows.length == 0) {
                    data.total = 0;
                }
                else {
                    data.total = data.rows[0].count_num;
                }


                // 如果行号为空不进行任何操作，如果不为空，按照行号选中
                if (m_index == -1) {
                }
                else if (m_index != -1) {
                    $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index)
                }
                if (data.rows.length == 1 && data.rows[0].pocode == "") {
                    ClearGrid("#Pr1_PaymentrequisitList");
                }
            },
            toolbar: [
            {
                id: 'btn_Add',
                text: '申请付款',
                iconCls: 'icon-add',
                handler: function () {
                    addPR1_PaymentRequisit();
                }
            },
            '-',
            {
                id: 'btn_Edit',
                text: '付款维护',
                iconCls: 'icon-edit',
                handler: function () {
                    addPB1_PaymentBill();
                }
            },
            '-',
            {
                id: 'btn_Save',
                text: 'PO付款完结',
                iconCls: 'icon-save',
                handler: function () {
                    endPohead();
                }
            }
            ]
        });
}

//控制按钮显示以否
function onClickRow(RowIndex, RowData) {
    var type_state = RowData.prstate;
    var type_postate = RowData.paystate;

    //如果选中行，状态为申请中，则付款申请按钮灰色。反正亮起
    if (type_postate == "已完结") {
        $('#btn_Edit').linkbutton('disable');
        $('#btn_Save').linkbutton('disable');
        $('#btn_Add').linkbutton('disable');
    }
    else if (type_postate == "未完结" || type_postate == "") {

        $('#btn_Edit').linkbutton('enable');
        $('#btn_Save').linkbutton('enable');
        $('#btn_Add').linkbutton('enable');

        if (type_state != "申请中") {
            $('#btn_Edit').linkbutton('disable');
        }
        else {
            $('#btn_Edit').linkbutton('enable');
        }
    }
}
//新增付款申请单
function addPR1_PaymentRequisit() {
    var selectRowForPayment = $('#Pr1_PaymentrequisitList').datagrid('getSelected');//获取选择行
    m_index = $('#Pr1_PaymentrequisitList').datagrid('getRowIndex', selectRowForPayment);//获取选择行的行号付给全局变量
    //如果没有选中，则提示，返回。
    if (!selectRowForPayment) {
        alert('请选择一条数据');
        return;
    }
    var sp2_SP1_Suppliercode = selectRowForPayment.suppliercode;//供应商编号
    //打开，付款申请界面
    $('#DivAddPayment').window({
        title: "付款申请界面",
        top: 30,
        width: 330,
        height: 450,
        modal: true
    });
    //给付款申请单界面控件附默认值
    $('#formAddPayment').find("#txtpr1_totalamount").val("");
    $('#formAddPayment').find("#txtpr1_state").val("申请中");
    $('#formAddPayment').find("#txtpo1_currency").val(selectRowForPayment.currency);//获取币种
    //$('#formAddPayment').find("#txtpo1_ocurrencysums").val(selectRowForPayment.po1_ocurrencysums);
    $('#formAddPayment').find("#txtpr1_requestamount").numberbox('setValue', '').focus();//定位光标//申請金額
    $('#formAddPayment').find("#txtpr1_poolamount").numberbox('setValue', '');//资金池金额
    $('#formAddPayment').form('validate');
    initGirdSP2_SupplierPool("#SP2_SupplierPoolListForPayment", sp2_SP1_Suppliercode);//按照供应商编号加载资金池
    savePR1_PaymentRequisit("insert");//点击申请，直接插入数据库
}
//保存付款申请单
//type (如果传过来是insert是插入（弹窗直接保存） ，如果是update 就是更新数据)
function savePR1_PaymentRequisit(type) {

    var selectRowForPayment = $('#Pr1_PaymentrequisitList').datagrid('getSelected');//获取选择行
    if (type == "insert") {
        var txtpr1_requestamount = $('#formAddPayment').find("#txtpr1_requestamount").val();//取申请金额
        var pr1_TotalAmount = $('#formAddPayment').find("#txtpr1_totalamount").val();//取采购单总金额
        var txtpr1_poolamount = $('#formAddPayment').find("#txtpr1_poolamount").val();//取资金池金额
        var data = [];
        var data = $('#formAddPayment').serializeArray();
        data[data.length] = { "name": "txtpr1_cono", "value": "HYFG" };
        data[data.length] = { "name": "txtpr1_divi", "value": "LX" };
        data[data.length] = { "name": "txtpr1_po1_pocode", "value": selectRowForPayment.pocode };//采购单号
        data[data.length] = { "name": "txtpr1_po1_sppocode", "value": selectRowForPayment.sppocode };//供应商采购单编号
        data[data.length] = { "name": "txtpr1_totalamount", "value": pr1_TotalAmount };//总金额
        data[data.length] = { "name": "txtpr1_po1_currency", "value": selectRowForPayment.currency };//币种
        data[data.length] = { "name": "txtpr1_requestcode", "value": selectRowForPayment.prrequestcode_new };//取返回的付款申请单号
        data[data.length] = { "name": "txtpr1_comment", "value": "" };//备注
        //data[data.length] = { "name": "txtpr1_rgdt", "value": "" };//创建时间
        data[data.length] = { "name": "txtpr1_rguser", "value": "" };//创建人
        //data[data.length] = { "name": "txtpr1_lmdt", "value": "" };//更新时间
        data[data.length] = { "name": "txtpr1_lmuser", "value": "" };//更新人
        data[data.length] = { "name": "txtpr1_id", "value": "" };//主键GUID
        var xmlData = GetFormJson(data, 'InsertPR1_PaymentRequisit');
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
            type: 'post',
            async: true, //异步,
            data: { "XML": xmlData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].Error.substring(6));
                        $('#DivAddPayment').window('close');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $.messager.progress('close');
                        $('#Pr1_PaymentrequisitList').datagrid("reload");//重加载
                        $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index);//按照之前的行号选中改行
                        $('#formAddPayment  #txtpr1_requestcode').val(result[0].rows[0].result);//把返回的编号付给界面相应控件
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
        return false;
    }
        //跟新付款申请单
    else if (type == "update") {
        if ($('#formAddPayment').form('validate') == false) {
            $.messager.alert("提示", "请把必填项填完！", 'error');
            return false;
        }
        var pr1_Po1_Currency = $('#formAddPayment').find("#txtpo1_currency").val();//取申请单币种
        var pr1_PoolAmount = $('#formAddPayment').find("#txtpr1_poolamount").val();//取使用资金池金额
        var dtSP2_SupplierPoolListForPayment = $('#SP2_SupplierPoolListForPayment').datagrid('getData');//获取资金池数据
        //获取资金池金额之后做判断，如果为0 就不判断，如果不为0，判断，该供应商是否有该币种金额，如果有，判断是否超过该金额
        if (pr1_PoolAmount != 0) {
            var flag = 0;//默认flag为0
            if (dtSP2_SupplierPoolListForPayment.rows.length != "0") {
                for (var i = 0; i < dtSP2_SupplierPoolListForPayment.rows.length; i++) {
                    if (dtSP2_SupplierPoolListForPayment.rows[i].sp2_currency == pr1_Po1_Currency) {
                        flag = 1;
                        //如果申请抵扣资金池大于该供应商资金池金额提示
                        if (pr1_PoolAmount * 1 > dtSP2_SupplierPoolListForPayment.rows[i].sp2_poolamount * 1) {
                            $.messager.alert("提示", "超过该供应商资金池金额！", 'error');
                            return false;
                        }
                        else {
                            break;
                        }
                    }
                    else {
                        flag = 0;
                    }
                }
            } else {
                $.messager.alert("提示", '该供应商无资金池金额', 'error');
                return false;
            }
        }
        if (flag == 0) {
            $.messager.alert("提示", '该供应商无此币种金额', 'error');
            return;
        }
        $.messager.confirm('提示框', '是否确认保存', function (r) {
            if (r) {
                $('#DivAddPayment').window('close');

                var pr1_PoolAmount = $('#formAddPayment').find("#txtpr1_poolamount").numberbox("getValue")//取使用资金池
                var pr1_RequestCode = $('#formAddPayment').find("#txtpr1_requestcode").val();
                var data = [];
                var data = $('#formAddPayment').serializeArray();
                var pr1_TotalAmount = $('#formAddPayment').find("#txtpr1_totalamount").val();//取采购单总金额
                data[data.length] = { "name": "txtpr1_totalamount", "value": pr1_TotalAmount }//总金额
                data[data.length] = { "name": "txtpr1_requestcode", "value": pr1_RequestCode }//取付款申请单号
                var xmlData = GetFormJson(data, 'UpdatePR1_PaymentRequisit');
                //return;
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
                    type: 'post',
                    async: true, //异步,
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
                                $('#Pr1_PaymentrequisitList').datagrid("reload");
                                $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index);
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
                return false;
            }
        })
    }
}

//付款维护formEditPB1_PaymentBill
function addPB1_PaymentBill() {
    var selectRowForPaymentBill = $('#Pr1_PaymentrequisitList').datagrid('getSelected');

    m_index = $('#Pr1_PaymentrequisitList').datagrid('getRowIndex', selectRowForPaymentBill)
    if (!selectRowForPaymentBill) {
        alert('请选择一条数据');
        return;
    }
    var sp2_SP1_Suppliercode = selectRowForPaymentBill.suppliercode;//供应商编号
    $('#DivEditPB1_PaymentBill').window({
        title: "付款维护界面:",
        top: 30,
        width: 530,
        height: 450,
        modal: true
    });

    $('#formEditPB1_PaymentBill').find("#txtpr1_requestcode").val(selectRowForPaymentBill.prrequestcode_new);//付款单号
    $('#formEditPB1_PaymentBill').find("#txtpr1_state").val(selectRowForPaymentBill.prstate);//付款申请单付款方式
    $('#formEditPB1_PaymentBill').find("#txtpo1_ocurrencysums").val(selectRowForPaymentBill.prtotalamount_new);//当前申请总金额总金额
    $('#formEditPB1_PaymentBill').find("#txtpr1_requestamount").val(selectRowForPaymentBill.prrequestamount_new);//付款申请单申请金额
    $('#formEditPB1_PaymentBill').find("#txtpr1_poolamount").val(selectRowForPaymentBill.prpoolamount_new);// 申请扣资金池金额
    $('#formEditPB1_PaymentBill').find("#txtamountpaid").val(selectRowForPaymentBill.prpbpaymenttotalamount)//已付金额已经支付金额
    $('#formEditPB1_PaymentBill').find("#txttotalpaypoolamount").val(selectRowForPaymentBill.prpbpaymentdeductionamount)//本累计抵扣金额
    $('#formEditPB1_PaymentBill').find("#txtamountpaid_OLD").val(selectRowForPaymentBill.prpbpaymentamount);//已付金额已经支付金额
    $('#formEditPB1_PaymentBill').find("#txtpb1_paymentamount").numberbox('setValue', '').focus();//定位光标//本次支付金额
    $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").numberbox('setValue', '');//资金池金额
    $('#formEditPB1_PaymentBill').form('validate')
    //$('#formEditPB1_PaymentBill').find("#txtamountpaid_OLD").val(selectRowForPaymentBill.pbpaymenttotalamount * 1 - selectRowForPaymentBill.pbpaymentdeductionamount * 1);//已付金额已经支付金额
    $('#formEditPB1_PaymentBill').find("#txtpb1_paymenttotalamount").val("");//本次付款金额总和
    initGirdSP2_SupplierPool("#SP2_SupplierPoolListForPB1_PaymentBill", sp2_SP1_Suppliercode); //加载资金池
    var pr1_RequestAmoun = $('#formEditPB1_PaymentBill').find("#txtpr1_requestamount").val();//取付款申请金额
    var pr1_PoolAmount = $('#formEditPB1_PaymentBill').find("#txtpr1_poolamount").val();//取付款单资金池金额
    var po1_OcurrencySums = pr1_RequestAmoun * 1 + pr1_PoolAmount * 1
    $('#formEditPB1_PaymentBill').find("#txtpo1_ocurrencysums").val(po1_OcurrencySums);
    $('#Checkbox').removeAttr("checked");
    savePB1_PaymentBill("insert");//点击申请，直接插入数据库
}

//保存付款单
//type (如果传过来是insert是插入（弹窗直接保存） ，如果是update 就是更新数据)
function savePB1_PaymentBill(type) {

    var selectRowForPaymentBill = $('#Pr1_PaymentrequisitList').datagrid('getSelected');
    if (type == "insert") {
        var pb1_PaymentAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentamount").val();////本次付款金额
        var pb1_PaymentTotalAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymenttotalamount").val();//本次付款总金额
        var pb1_PaymentDeductionAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").val();//本次抵扣金额
        var data = [];
        var data = $('#formEditPB1_PaymentBill').serializeArray();
        data[data.length] = { "name": "txtpb1_cono", "value": "HYFG" }
        data[data.length] = { "name": "txtpb1_divi", "value": "LX" }
        //data[data.length] = { "name": "txtpb1_paymentamount", "value": pb1_PaymentAmount }//本次付款金额
        data[data.length] = { "name": "txtpb1_paymenttotalamount", "value": pb1_PaymentTotalAmount }//本次付款总金额
        //data[data.length] = { "name": "txtpb1_paymentdeductionamount", "value": pb1_PaymentDeductionAmount }//本次抵扣金额（使用资金池金额）
        data[data.length] = { "name": "txtpb1_paybillcode", "value": selectRowForPaymentBill.pbpaybillcode_new }//取返回的付款单号
        data[data.length] = { "name": "txtpb1_pr1_requestcode", "value": selectRowForPaymentBill.prrequestcode_new }//取付款申请单号
        data[data.length] = { "name": "txtpb1_state", "value": 85 }//付款单状态
        data[data.length] = { "name": "txtpb1_comment", "value": "" }//备注
        data[data.length] = { "name": "txtpb1_rguser", "value": "" }//创建人
        data[data.length] = { "name": "txtpb1_lmuser", "value": "" }//更新人
        data[data.length] = { "name": "txtpb1_id", "value": "" }//主键GUID
        var xmlData = GetFormJson(data, 'InsertPB1_PaymentBill');
        //return;
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
            type: 'post',
            async: false, //异步,
            data: { "XML": xmlData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');
                        $('#DivEditPB1_PaymentBill').window('close');
                        $.messager.alert("提示", result[0].Error.substring(6));
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $.messager.progress('close');
                        $('#Pr1_PaymentrequisitList').datagrid("reload");
                        $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index);
                        $('#formEditPB1_PaymentBill  #txtpb1_paybillcode').val(result[0].rows[0].result);
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
        return false;
    }
        //跟新付款申请单
    else if (type == "update") {
        if ($('#formEditPB1_PaymentBill').form('validate') == false) {
            $.messager.alert("提示", "请把必填项填完！", 'error');
            return false;
        }
        var pb1_PayBillCode = $('#formEditPB1_PaymentBill').find("#txtpb1_paybillcode").val();//取付款单号
        var pb1_PaymentTotalAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymenttotalamount").val();//取付款单本次付款总金额
        var po1_OcurrencySums = $('#formEditPB1_PaymentBill').find("#txtpo1_ocurrencysums").val();//取申请付款单总金额
        var pb1_PaymentDeductionAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").val();//取支付资金池金额
        var strPRPBPaymentAmount = $('#formEditPB1_PaymentBill').find("#txtamountpaid").val();//取支付资金池金额
        //如果付款总金额大于申请总金额提示
        if ((pb1_PaymentTotalAmount * 1 + strPRPBPaymentAmount * 1 - po1_OcurrencySums * 1) > 0) {
            $.messager.alert("提示", "支付金额加已支付金额不能大于申请金额！", 'error');
            return;
        }
        var dtSP2_SupplierPoolListForPB1_PaymentBill = $('#SP2_SupplierPoolListForPB1_PaymentBill').datagrid('getData');
        //获取资金池金额之后做判断，如果为0 就不判断，如果不为0，判断，该供应商是否有该币种金额，如果有，判断是否超过该金额
        if (pb1_PaymentDeductionAmount != 0) {
            var flag = 0;
            if (dtSP2_SupplierPoolListForPB1_PaymentBill.rows.length != "0") {
                for (var i = 0; i < dtSP2_SupplierPoolListForPB1_PaymentBill.rows.length; i++) {
                    if (dtSP2_SupplierPoolListForPB1_PaymentBill.rows[i].sp2_currency == selectRowForPaymentBill.currency) {
                        flag = 1;
                        if (pb1_PaymentDeductionAmount * 1 > dtSP2_SupplierPoolListForPB1_PaymentBill.rows[i].sp2_poolamount * 1) {
                            $.messager.alert("提示", "超过该供应商资金池金额！", 'error');
                            return false;
                        }
                        else {
                            break;
                        }
                    }
                    else {
                        flag = 0;
                    }
                }
            } else {
                $.messager.alert("提示", '该供应商无资金池金额', 'error');
                return false;
            }
        }
        if (flag == 0) {
            $.messager.alert("提示", '该供应商无此币种金额', 'error');
            return;
        }
        $.messager.confirm('提示框', '是否确认保存', function (r) {
            if (r) {
                $('#DivEditPB1_PaymentBill').window('close');
                var pr1_RequestCode = $('#formEditPB1_PaymentBill').find("#txtpr1_requestcode").val();//取付款申请单号
                var pb1_PaymentDeductionAmount = $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").val();//取付款单抵扣金额
                var data = [];
                var data = $('#formEditPB1_PaymentBill').serializeArray();
                data[data.length] = { "name": "txtpb1_paybillcode", "value": pb1_PayBillCode }//取付款单号
                data[data.length] = { "name": "txtpb1_paymenttotalamount", "value": pb1_PaymentTotalAmount }//取付款单本次付款总金额
                data[data.length] = { "name": "txtpb1_state", "value": "85" }//,默认付款保存85状态
                data[data.length] = { "name": "txtpr1_requestcode", "value": pr1_RequestCode }//取付款申请单为保存付款单的时候更新付款申请单
                data[data.length] = { "name": "txtsp2_sp1_suppliercode", "value": selectRowForPaymentBill.suppliercode }//获取供应商编号
                data[data.length] = { "name": "txtsp2_currency", "value": selectRowForPaymentBill.currency }//获取采购单币种
                //如果选择完结按钮勾上了，就赋值85
                if (document.getElementById('Checkbox').checked) {
                    data[data.length] = { "name": "txtpr1_state", "value": "85" }//,付款申请单状态85，如果手动勾上完结，付款单状态变为85完结状态
                }
                else {
                    data[data.length] = { "name": "txtpr1_state", "value": "80" }
                }
                var xmlData = GetFormJson(data, 'UpdatePB1_PaymentBill');
                //return;
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
                    type: 'post',
                    async: true, //异步,
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
                                $('#Pr1_PaymentrequisitList').datagrid("reload");
                                $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index);
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
                return false;
            }
        })
    }
}

//付款单界面删除付款申请单
function deletePR1_PaymentRequisitOnPB1_PaymentBill() {
    $.messager.confirm('提示框', '是否确认删除', function (r) {
        if (r) {
            var pr1_RequestCode = $('#formEditPB1_PaymentBill').find("#txtpr1_requestcode").val();//取付款申请单号
            var pb1_PayBillCode = $('#formEditPB1_PaymentBill').find("#txtpb1_paybillcode").val();//取付款申请单号

            //判断申请单是否已经有付款单
            if (pr1_RequestCode != "") {
                xmlData = GetFormJson([], 'CheckPR1_PaymentRequisit');
                htmlobj = $.ajax({
                    url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
                    data: { "XML": xmlData, "WHERE": "PB1_PR1_RequestCode='" + pr1_RequestCode + "'" },
                    type: 'post',
                    async: false
                });
                var result = $.parseJSON(htmlobj.responseText);
                if (result.rows[0]['count'] != "0") {
                    $.messager.alert("提示", '已有付款的付款申请单不可进行删除', 'error');
                    return;
                }
            }
            $('#DivEditPB1_PaymentBill').window('close');
            var data = [];
            data[data.length] = { "name": "txtpb1_paybillcode", "value": pb1_PayBillCode }//付款申请单号
            data[data.length] = { "name": "txtpr1_requestcode", "value": pr1_RequestCode }//付款申请单号
            data[data.length] = { "name": "txtpr1_state", "value": "99" }//赋值99

            var xmlData = GetFormJson(data, 'DeletePR1_PaymentRequisit');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
                type: 'post',
                async: true, //异步,
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
                            $('#Pr1_PaymentrequisitList').datagrid("reload");
                            $('#Pr1_PaymentrequisitList').datagrid('selectRow', m_index);
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
            return false;
        }
    })
}

//加载资金池(参数0 formname ，参数1 供应商编号)
function initGirdSP2_SupplierPool(name, psp2_sp1_suppliercode) {
    $(name).datagrid(
        {
            title: '资金池', //表格标题
            url: GetWSRRURL('e2ae5182-359b-45fa-b268-f6ee6e5c3c88') + "&XML=" + GetFormJson("", 'GET') + "&WHERE=" + " SP2_SP1_SupplierCode = '" + psp2_sp1_suppliercode + "'",
            //sortName: 'po1_pocode', //排序字段
            //idField: 'po1_pocode', //标识字段,主键
            //width: '90%', //宽度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            fit: true,
            sortOrder: 'DESC', //排序类型
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            columns: [[
                { field: 'sp2_currency', title: '币种', width: 100 },
                { field: 'sp2_poolamount', title: '可用金额', width: 100 },
            ]],
            onLoadSuccess: function () {
                if (name == "#SP2_SupplierPoolListForPayment") {
                    var dtSP2_SupplierPoolListForPayment = $('#SP2_SupplierPoolListForPayment').datagrid('getData');//获取资金池数据
                    var pr1_Po1_Currency = $('#formAddPayment').find("#txtpo1_currency").val();//取申请单币种

                    var flag = 0;//默认flag为0
                    if (dtSP2_SupplierPoolListForPayment.rows.length == 0) {
                        $('#formAddPayment').find('#txtpr1_poolamount').numberbox({ required: false });
                        $('#formAddPayment').form('validate');
                        $('#formAddPayment').find("#txtpr1_poolamount").val("0");
                        $('#formAddPayment').form('validate');
                        $('#formAddPayment').find("#txtpr1_poolamount").attr("disabled", "disabled");
                    } else {
                        for (var i = 0; i < dtSP2_SupplierPoolListForPayment.rows.length; i++) {
                            if (dtSP2_SupplierPoolListForPayment.rows[i].sp2_currency == pr1_Po1_Currency) {
                                flag = 1;
                                break;
                            }
                            else {
                                flag = 0;
                            }
                        }
                        if (flag == 0) {
                            $('#formAddPayment').find('#txtpr1_poolamount').numberbox({ required: false });
                            $('#formAddPayment').form('validate');
                            $('#formAddPayment').find("#txtpr1_poolamount").val("0");
                            $('#formAddPayment').form('validate');
                            $('#formAddPayment').find("#txtpr1_poolamount").attr("disabled", "disabled");
                        }
                        else {
                            $('#formAddPayment').find("#txtpr1_poolamount").attr("disabled", "");
                            $('#formAddPayment').find('#txtpr1_poolamount').numberbox({ required: true });
                        }
                    }
                }
                else if (name == "#SP2_SupplierPoolListForPB1_PaymentBill") {
                    if ($('#formEditPB1_PaymentBill').find("#txtpr1_poolamount").val() == "0.00" || $('#formEditPB1_PaymentBill').find("#txtpr1_poolamount").val() == undefined || $('#formEditPB1_PaymentBill').find("#txtpr1_poolamount").val() == "") {

                        $('#formEditPB1_PaymentBill').find('#txtpb1_paymentdeductionamount').numberbox({ required: false });
                        $('#formEditPB1_PaymentBill').find("#txtpb1_paymentdeductionamount").val("0");
                        $('#formEditPB1_PaymentBill').form('validate');
                        $('#formEditPB1_PaymentBill').find('#txtpb1_paymentdeductionamount').attr("disabled", "disabled");
                    }
                    else {
                        $('#formEditPB1_PaymentBill').find('#txtpb1_paymentdeductionamount').attr("disabled", "");
                        $('#formEditPB1_PaymentBill').find('#txtpb1_paymentdeductionamount').numberbox({ required: true });

                    }
                }
            },
        });
}
//关闭窗口集合
function Cancel(type) {
    if (type == '付款申请单') {
        $('#DivAddPayment').window('close');
    }
    else if (type == '付款单') {
        $('#DivEditPB1_PaymentBill').window('close');
    }
    else if (type == '完结') {
        $('#divEnd').window('close');
    }
}

function endPohead() {
    var selectRowForPoHead = $('#Pr1_PaymentrequisitList').datagrid('getSelected');
    m_index = $('#Pr1_PaymentrequisitList').datagrid('getRowIndex', selectRowForPoHead)
    if (!selectRowForPoHead) {
        alert('请选择一条数据');
        return;
    }

    if (selectRowForPoHead.unrptotalamount == 0) {
        saveEndHead();
    }
    else if (selectRowForPoHead.unrptotalamount > 0) {
        //未入库金额大于0，则出框提示，“您好，供应商xxx的xx币资金池，将转入（默认未入库金额，可手动修改，不可大于未入库金额）为预付款。确认/取消；
        $('#divEnd').window({
            title: "完结:",
            top: 50,
            width: 500,
            height: 120,
            modal: true
        });
        var strHTML = '您好，供应商' + selectRowForPoHead.suppliercodename + '的' + selectRowForPoHead.currency + '币资金池，将转入<input id="txtunrptotalamount" name="txtunrptotalamount" style="width: 90px"  />为预付款。';
        $("#tdMessage").html(strHTML);
        //var strsuppliercodename = $('#form_End').find("#txtsuppliercodename").val();//取供应商编号
        //var strCurrency = $('#form_End').find("#txtcurrency").val(selectRowForPoHead.currency);//取供应商编号
        $('#form_End').find("#txtunrptotalamount").val(selectRowForPoHead.unrptotalamount);//取未入库金额
    }
    else if (selectRowForPoHead.unrptotalamount < 0) {
        $('#divEnd').window({
            title: "完结:",
            top: 50,
            width: 500,
            height: 120,
            modal: true
        })
        //当未入库金额小于0时，您好，供应商XXX的XX币资金池，将抵扣（未入库金额），请确认。确认/取消PS：资金池不允许为负。
        var strHTML = '您好，供应商' + selectRowForPoHead.suppliercodename + '的' + selectRowForPoHead.currency + '币资金池，将抵扣 <input id="txtunrptotalamount" name="txtunrptotalamount" style="width: 90px" disabled="disabled"/>  请确认!';
        $("#tdMessage").html(strHTML);
        $('#form_End').find("#txtunrptotalamount").val(selectRowForPoHead.unrptotalamount);//取未入库金额
    }
}

function saveEndHead() {

    var selectRowForPoHead = $('#Pr1_PaymentrequisitList').datagrid('getSelected');
    var data = [];
    data[data.length] = { "name": "txtpr1_po1_pocode", "value": selectRowForPoHead.pocode }
    if (selectRowForPoHead.unrptotalamount == 0) {
        data[data.length] = { "name": "txtstate", "value": "1" }//1供后台识别
    }
    else {
        //未入库金额加上改供应商资金池金额是否未-，如果为负，提示，如果不为负执行
        xmlData = GetFormJson([], 'GET');
        htmlobj = $.ajax({
            url: GetWSRRURL('e2ae5182-359b-45fa-b268-f6ee6e5c3c88'),
            data: { "XML": xmlData, "WHERE": "SP2_Currency='" + selectRowForPoHead.currency + "'  and SP2_SP1_SupplierCode = '" + selectRowForPoHead.suppliercode + "'" },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        if (result.rows != 0) {
            if (result.rows[0]['sp2_poolamount'] * 1 + selectRowForPoHead.unrptotalamount * 1 < 0) {
                $.messager.alert("提示", '资金池金额不够', 'error');
                return;
            }
            if ($('#form_End').find("#txtunrptotalamount").val() > selectRowForPoHead.unrptotalamount) {
                $.messager.alert("提示", '超过未入库金额', 'error');
                return;
            }
        }
        data[data.length] = { "name": "txtstate", "value": "2" }
        data[data.length] = { "name": "txtunrptotalamount", "value": $('#form_End').find("#txtunrptotalamount").val() }//未入库金额
        data[data.length] = { "name": "txtsp2_sp1_suppliercode", "value": selectRowForPoHead.suppliercode }//获取供应商编号
        data[data.length] = { "name": "txtsp2_currency", "value": selectRowForPoHead.currency }//获取采购单币种
    }
    var xmlData = GetFormJson(data, 'EndPohead');
    //return;
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    $.ajax({
        url: GetWSRRURL('fd67be33-4a8b-4ea2-96fa-a7b2fcf60969'),
        type: 'post',
        async: true, //异步,
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
                    if (selectRowForPoHead.unrptotalamount != 0) {
                        $('#divEnd').window('close');
                    }
                    $.messager.progress('close');
                    $('#Pr1_PaymentrequisitList').datagrid("reload");
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
    return false;
}

