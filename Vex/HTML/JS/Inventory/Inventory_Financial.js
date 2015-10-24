﻿var m_DepotID = "";
var m_DepotName = "";
var m_Firstdate = "";
var m_Enddate = "";
var m_method = [{ "id": 0, "text": "现金", "selected": true }, { "id": 1, "text": "转账" }];

$(function () {

    $("#txtreturn_sums").change(function () {
        var m_return_sum_for_discount = document.getElementById('txtreturn_sums').value
        var m_discount = document.getElementById('txtsums').value

        if (m_return_sum_for_discount == "") {
            document.getElementById('txtdiscount').value = "";
            return;
        }
        else {
            var m_discount_result = m_return_sum_for_discount / m_discount;
            var m_discount_result = m_discount_result.toFixed(2);
            document.getElementById('txtdiscount').value = m_discount_result;
        }
    });

    getFirstFormatDate();
    $('#txtbegindate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });
    $('#txtenddate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });
    $('#txtbegindate').datebox("setValue", m_Firstdate);
    $('#txtenddate').datebox("setValue", m_Enddate);

    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson("", 'GETSPINFO') + "&WHERE=" + " Setdate between '" + m_Firstdate + "'" + " AND " + "'" + m_Enddate + "'";
    InitGird(url);
})
function InitGird(url) {
    $('#tab_list').datagrid(
        {
            title: '财务确认列表', //表格标题
            url: url,
            //sortName: 'billid', //排序字段
            //idField: 'billid', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            //pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            onSelect: onClickRow,
            columns: [[
                { field: 'inventoryid', title: '盘点单据号', width: 160, search: true, sortable: true },
                { field: 'depotid', title: '店铺编号', width: 60, search: true, sortable: true },
                { field: 'depotname', title: '店铺名称', width: 100, search: true, sortable: true },
                { field: 'nums', title: '盘亏数量', width: 55, sortable: true, align: 'right' },
                { field: 'sums', title: '盘亏金额', width: 80, sortable: true, align: 'right', formatter: Formater.Account },
                { field: 'return_sums', title: '申请赔偿金额', width: 80, sortable: true, align: 'right', formatter: Formater.Account },
                { field: 'setdate', title: '盘点时间', width: 70, sortable: true },
                { field: 'sure_date', title: '登帐时间', width: 70, sortable: true },
                { field: 'state', title: '当前状态', width: 110, search: true, sortable: true },
                { field: 'createtime', title: '提交时间', width: 130, sortable: true }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            '-',
            {
                id: 'btn_submit',
                text: '汇款确认',
                iconCls: 'icon-save',
                handler: function () {
                    Type("Confirmation");
                }
            }
            //,
            //'-',
            //{
            //    id: 'btn_download',
            //    text: '附件下载',
            //    iconCls: 'icon-attach',
            //    handler: function () {
            //        Download();
            //    }
            //}
            ]
        });
}
function getFirstFormatDate() {
    var nowDate = new Date();
    nowDate = new Date(nowDate.getFullYear() + "/" + (nowDate.getMonth() + 1) + "/" + "01")
    m_Firstdate = nowDate.format("yyyy-MM-dd");
    m_Enddate = nowDate.DateAdd('m', 1).DateAdd('d', -1).format("yyyy-MM-dd");
}
function Type(type) {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert("请选择一条盘点单据");
        return;
    };

    if (type == "Confirmation") {
        $('#form_FinancialSp').window({
            title: "汇款",
            top: 20,
            width: 500,
            height: 280,
            modal: true
        });


        $('#txtreceived_time').datebox({
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            required: true,
            formatter: function (date) { return date.format("yyyy-MM-dd"); }
        });

        $('#txtinventory_diff_id').val(selected.inventory_diff_id);
        $('#txtinventoryid').val(selected.inventoryid);

        $('#txtsums').val(selected.sums);
        $('#txtnums').val(selected.nums);
        $('#txtreturn_sums').val(selected.return_sums);

        $("#txtmethod").val(selected.method);
        $("#txtserialnumber").val(selected.serialnumber);
        $("#txtamount_of_remittance").val(selected.amount_of_remittance);
        $('#txtcontent').val("");
        $('#txtamountreceived').numberbox('setValue', '');
        $("#txtreceived_time").datebox('setValue', "");


        $("#txtremittance_time").val(selected.remittance_time);
        $("#txtbankoutlets").val(selected.bankoutlets);

        var m_discount_result = selected.return_sums / selected.sums;
        var m_discount_result = m_discount_result.toFixed(2);
        document.getElementById('txtdiscount').value = m_discount_result;

        document.getElementById('Checkbox_Yes').checked = false
        document.getElementById('Checkbox_No').checked = false
    }
}

function Checkbox_select(type) {
    if (type == true) {
        document.getElementById('Checkbox_Yes').checked
        document.getElementById('Checkbox_No').checked = false
        $('#txtcontent').validatebox({ required: false });
    }
    else if (type == false) {
        document.getElementById('Checkbox_No').checked
        document.getElementById('Checkbox_Yes').checked = false
        $('#txtcontent').validatebox({ required: true });
    }
}

function InitGird_select() {
    var m_selectfirstdate = $('#txtbegindate').datebox("getValue");
    var m_selectebddate = $('#txtenddate').datebox("getValue");
    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson("", 'GETSPINFO') + "&WHERE=" + " Setdate between '" + m_selectfirstdate + "'" + " AND " + "'" + m_selectebddate + "'";
    InitGird(url)
}

//店铺申请提交
function Financial_Submit() {
    $('#form_FinancialSp').form('submit', {
        onSubmit: function (e) {
            if ($('#form_FinancialSp').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            if (!document.getElementById('Checkbox_Yes').checked && !document.getElementById('Checkbox_No').checked) {
                $.messager.alert("提示", "审批意见必须填写！", 'error');
                return false;
            }

            var y = $('#txtreceived_time').datebox('getValue');
            var x = document.getElementById('txtremittance_time').value;

            if (x > y) {
                $.messager.alert("提示", "实收时间必须要大于等于汇款时间", 'error');
                return false;
            }
            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {
                    $('#form_FinancialSp').window('close');

                    var selected = $('#tab_list').datagrid('getSelected');
                    var data = $('#form_FinancialSp').serializeArray();

                    if (document.getElementById('Checkbox_Yes').checked) {
                        data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                        data[data.length] = { "name": "txtdepotname", "value": selected.depotname }
                        data[data.length] = { "name": "txtareaname", "value": selected.areaname }
                        data[data.length] = { "name": "txtnums", "value": selected.nums }
                        data[data.length] = { "name": "txtsums", "value": selected.sums }
                        data[data.length] = { "name": "txtsure_date", "value": selected.sure_date }
                        data[data.length] = { "name": "txtsetdate", "value": selected.setdate }
                        data[data.length] = { "name": "txtreturn_sums", "value": selected.return_sums }
                        data[data.length] = { "name": "txtserialnumber", "value": selected.serialnumber }
                        data[data.length] = { "name": "txtamount_of_remittance", "value": selected.amount_of_remittance }
                        data[data.length] = { "name": "txtmethod", "value": selected.method }
                        data[data.length] = { "name": "txtfilepath", "value": selected.filepath }
                        data[data.length] = { "name": "txtstate", "value": "完成" }

                        data[data.length] = { "name": "txtimg", "value": selected.img }
                        data[data.length] = { "name": "txtbankoutlets", "value": selected.bankoutlets }
                        data[data.length] = { "name": "txtremittance_time", "value": selected.remittance_time }
                    }
                    else if (document.getElementById('Checkbox_No').checked) {
                        data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                        data[data.length] = { "name": "txtdepotname", "value": selected.depotname }
                        data[data.length] = { "name": "txtareaname", "value": selected.areaname }
                        data[data.length] = { "name": "txtnums", "value": selected.nums }
                        data[data.length] = { "name": "txtsums", "value": selected.sums }
                        data[data.length] = { "name": "txtsure_date", "value": selected.sure_date }
                        data[data.length] = { "name": "txtreturn_sums", "value": selected.return_sums }
                        data[data.length] = { "name": "txtsetdate", "value": selected.setdate }
                        data[data.length] = { "name": "txtamount_of_remittance", "value": selected.amount_of_remittance }
                        data[data.length] = { "name": "txtmethod", "value": selected.method }
                        data[data.length] = { "name": "txtserialnumber", "value": selected.serialnumber }
                        data[data.length] = { "name": "txtstate", "value": "财务驳回" }
                        data[data.length] = { "name": "txtimg", "value": selected.img }
                        data[data.length] = { "name": "txtbankoutlets", "value": selected.bankoutlets }
                        data[data.length] = { "name": "txtremittance_time", "value": selected.remittance_time }
                        data[data.length] = { "name": "txtfilepath", "value": selected.filepath }

                    }

                    var XMLData = GetFormJson(data, 'INSERTFINANCIAL');
                    //return;
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588'),
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
                                    $('#tab_list').datagrid("unselectAll");
                                    $('#tab_list').datagrid("reload");

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
    });
}

//取消
function Cancel(type) {
    if (type == "A1") {
        $('#form_FinancialSp').window('close');
    }
}

function onClickRow(RowIndex, RowData) {
    var type_state = RowData.state;
    if (type_state == "待财务汇款确认") {
        $('#btn_submit').linkbutton('enable');
    }
    else {
        $('#btn_submit').linkbutton('disable');
    }

    var selectinventoryid = RowData.inventoryid;

    if (selectinventoryid != "") {
        InitDetailInfo(selectinventoryid);
    }
    else {
        ClearGrid("#tab_list_detail");
    }
}


function InitDetailInfo(selectinventoryid) {

    ClearGrid("#tab_list_detail");
    $('#tab_list_detail').datagrid(
       {
           url: GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588'),
           queryParams: { "XML": GetFormJson("", 'GETINFODETAIL'), "WHERE": "inventoryid=" + "'" + selectinventoryid + "'" },
           sortName: 'createtime', //排序字段
           sortable: true,
           iconCls: '', //标题左边的图标
           nowrap: true, //是否换行，True 就会把数据显示在一行里
           striped: true, //True 奇偶行使用不同背景色
           collapsible: false, //可折叠
           sortOrder: 'asc', //排序类型
           remoteSort: false, //定义是否从服务器给数据排序
           fit: true,
           pagination: true, //是否开启分页
           pageSize: 20, //默认一页数据条数
           singleSelect: true, //单行选择
           frozenColumns: [[//冻结的列，不会随横向滚动轴移动
           ]],
           columns: [[
              { field: 'state', title: '当前状态', width: 100 },
              { field: 'createtime', title: '创建时间', width: 120 },
              { field: 'createuser', title: '创建人', width: 120 },
              { field: 'content', title: '说明', width: 150 },
              { field: 'nums', title: '盘亏数量', width: 80, align: 'right', formatter: Formater.Nums },
              { field: 'sums', title: '盘亏金额', width: 80, align: 'right', formatter: Formater.Account },
              { field: 'return_sums', title: '赔偿金额', width: 80, formatter: Formater.Account, align: 'right' },
              { field: 'amount_of_remittance', title: '汇款金额', width: 60, align: 'right', formatter: Formater.Account },
              { field: 'remittance_time', title: '汇款时间', width: 100, align: 'right' },
              { field: 'method', title: '汇款方式', width: 60 },
              { field: 'amountreceived', title: '实收金额', width: 60, align: 'right', formatter: Formater.Account },
              { field: 'received_time', title: '实收日期', width: 100 }
           ]]
       }
 );
}


function lookPicPath() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    var url;
    if (selected_Row.img == "") {
        url = "";
        $.messager.alert("提示", "无上传图片！", 'error');
        return false;
    } else {
        url = "" + selected_Row.img;
        window.open(url, "newwindow", "");

    };
}


function Download() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert("请选择一条盘点单据");
        return;
    };

    var m_filepath = selected.filepath;
    window.open(m_filepath, "newwindow", "");
}