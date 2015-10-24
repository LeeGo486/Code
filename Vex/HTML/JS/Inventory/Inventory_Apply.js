var m_DepotID = "";
var m_DepotName = "";
var m_Firstdate = "";
var m_Enddate = "";
var m_method = [{ "id": 0, "text": "现金", "selected": true }, { "id": 1, "text": "ATM汇款" }, { "id": 2, "text": "网银汇款" }, { "id": 3, "text": "柜台" }];

$(function () {
    //文件上传相关-----------------
    var button = $('#btnUp'), interval;
    new AjaxUpload(button, {
        //action: 'upload-test.php',文件上传服务器端执行的地址
        action: '/Handler_Upload.ashx?filePath=HZY_Inventory',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|JPG|JPEG|PNG|GIF|gif|png)$/.test(ext))) {
                alert('图片格式不正确,请选择 jpg,gif,png 格式的文件!', '系统提示');
                return false;
            }
            // change button text, when user selects file
            button.val('文件上传中');
            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('上传成功');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {

                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#txtimg").val(result[0].rows[0].message);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });




    var button = $('#B_filepath'), interval;
    new AjaxUpload(button, {
        action: '/Handler_Upload.ashx?filePath=HZY_Inventory',
        name: 'myfile',
        onSubmit: function (file, ext) {
            if (!(ext && /^(jpg|jpeg|JPG|JPEG|PNG|GIF|gif|png|DOC|DOCX|XLSX|doc|docx|xlsx|xls|XLS|txt|TXT)$/.test(ext))) {
                alert('只能上传图片，文档格式!', '系统提示');
                return false;
            }
            // change button text, when user selects file
            button.val('文件上传中');
            // If you want to allow uploading only 1 file at time,
            // you can disable upload button
            this.disable();
            // Uploding -> Uploading. -> Uploading...
            interval = window.setInterval(function () {
                var text = button.val();
                if (text.length < 10) {
                    button.val(text + '.');
                } else {
                    button.val('文件上传中');
                }
            }, 200);
        },
        onComplete: function (file, response) {
            //file 本地文件名称，response 服务器端传回的信息
            button.val('上传成功');

            window.clearInterval(interval);

            // enable upload button
            this.enable();
            var k = response.replace("<pre>", "").replace("</pre>", "").replace("<PRE>", "").replace("</PRE>", "");

            try {
                var result = eval("[" + k + "]");
                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {

                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#txtfilepath").val(result[0].rows[0].message);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        }
    });













    //文件上传相关-----------------
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

    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson("", 'GETINVENTORY') + "&WHERE=" + " Setdate between '" + m_Firstdate + "'" + " AND " + "'" + m_Enddate + "'";
    InitGird(url);
})
function InitGird(url) {
    $('#tab_list').datagrid(
        {
            title: '店铺盘点差异列表', //表格标题
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
                { field: 'd_name', title: '店铺名称', width: 100, search: true, sortable: true },
                { field: 'zcnums', title: '盘亏数量', width: 55, sortable: true, align: 'right' },
                { field: 'zcsums', title: '盘亏金额', width: 80, sortable: true, align: 'right', formatter: Formater.Account },
                { field: 'return_sums', title: '申请赔偿金额', width: 80, sortable: true, align: 'right', formatter: Formater.Account },
                { field: 'setdate', title: '盘点时间', width: 70, sortable: true },
                { field: 'sure_date', title: '登帐时间', width: 70, sortable: true },
                { field: 'state', title: '当前状态', width: 110, search: true, sortable: true },
                { field: 'updatetime', title: '提交时间', width: 130, sortable: true }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_apply',
                text: '申请',
                iconCls: 'icon-add',
                handler: function () {
                    Type("Apply");
                }
            },
            '-',
            {
                id: 'btn_submit',
                text: '汇款',
                iconCls: 'icon-save',
                handler: function () {
                    Type("Remittance");
                }
            }
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
    if (type == "Apply") {
        $('#form_Apply').window({
            title: "盘亏赔偿申请",
            top: 20,
            width: 510,
            height: 280,
            modal: true
        });
        $('#txtcontent').val("");
        $('#txtdiscount').val("");
        $('#txtreturn_sums').numberbox('setValue', '');
        $('#txtsums').val(selected.zcsums);
        $('#txtnums').val(selected.zcnums);
        $("#txtcontent").focus();
        $("#txtfilepath").val("");
        $("#B_filepath").val("上传");


    }
    else if (type == "Remittance") {
        $('#form_remittance').window({
            title: "汇款",
            top: 20,
            width: 450,
            height: 280,
            modal: true
        });



        $('#txtremittance_time').datebox({
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            editable: false,
            formatter: function (date) {
                return date.format("yyyy-MM-dd")
            }
        });

        $('#txtinventory_diff_id').val(selected.inventory_diff_id);
        $('#txtinventoryid').val(selected.inventoryid);
        $('#txtsums_remittance').val(selected.zcsums);
        $('#txtnums_remittance').val(selected.zcnums);
        $('#txtreturn_sums_remittance').val(selected.return_sums);
        $('#txtdiscount_remittance').val(selected.discount);
        $("#txtserialnumber").val("");
        $("#txtamount_of_remittance").numberbox('setValue', "");

        $("#txtremittance_time").datebox('setValue', "");
        $("#txtbankoutlets").val("");
        $("#txtimg").val("");
        $("#btnUp").val("上传");


        var m_discount_result = selected.return_sums / selected.zcsums;
        var m_discount_result = m_discount_result.toFixed(2);
        document.getElementById('txtdiscount_remittance').value = m_discount_result;


        $('#txtmethod').combobox({
            valueField: 'text',
            textField: 'text',
            data: m_method,
            panelHeight: 'auto',
            editable: false,
            multiple: false,
            onChange: function () {
                var m_method = $('#txtmethod').combobox("getValue");
                if (m_method == "现金") {
                    $('#txtremittance_time').datebox({ required: true });
                    $('#txtbankoutlets').validatebox({ required: false });
                }
                else if (m_method == "ATM汇款") {
                    $('#txtbankoutlets').validatebox({ required: true });
                    $('#txtremittance_time').datebox({ required: true });
                }
                else if (m_method == "网银汇款") {
                    $('#txtbankoutlets').validatebox({ required: true });
                    $('#txtremittance_time').datebox({ required: true });
                }
                else if (m_method == "柜台") {
                    $('#txtbankoutlets').validatebox({ required: true });
                    $('#txtremittance_time').datebox({ required: true });
                }
            }
        });
    }
}

function InitGird_select() {
    var m_selectfirstdate = $('#txtbegindate').datebox("getValue");
    var m_selectebddate = $('#txtenddate').datebox("getValue");
    var url = GetWSRRURL('2245088e-1396-4479-b5ad-d57cf0434588') + "&XML=" + GetFormJson("", 'GETINVENTORY') + "&WHERE=" + " Setdate between '" + m_selectfirstdate + "'" + " AND " + "'" + m_selectebddate + "'";
    InitGird(url)
}

//店铺申请提交
function Apply_Submit() {
    $('#form_Apply').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Apply').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            var Applydiscount = document.getElementById('txtdiscount').value;
            //var m_Discount = Applydiscount * 100
            ////return;
            //if (Applydiscount <= 0.2) {
            $.messager.confirm('提示框', "您提交的申请赔偿折扣是 " + Applydiscount + " 是否提交", function (e) {
                if (e) {
                    $.messager.confirm('提示框', '是否确认提交', function (r) {
                        if (r) {
                            $('#form_Apply').window('close');

                            var selected = $('#tab_list').datagrid('getSelected');
                            var data = $('#form_Apply').serializeArray();


                            if (selected.state == "财务驳回") {
                                data[data.length] = { "name": "txtinventory_diff_id", "value": selected.inventory_diff_id }
                                data[data.length] = { "name": "txtinventoryid", "value": selected.inventoryid }
                                data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                                data[data.length] = { "name": "txtdepotname", "value": selected.d_name }
                                data[data.length] = { "name": "txtareaname", "value": selected.d_dq }
                                data[data.length] = { "name": "txtnums", "value": selected.zcnums }
                                data[data.length] = { "name": "txtsums", "value": selected.zcsums }
                                data[data.length] = { "name": "txtsure_date", "value": selected.sure_date }
                                data[data.length] = { "name": "txtsetdate", "value": selected.setdate }
                                data[data.length] = { "name": "txtstate", "value": "待财务汇款确认" }
                                data[data.length] = { "name": "txtfilepath", "value": selected.filepath }

                            }
                            else {
                                data[data.length] = { "name": "txtinventory_diff_id", "value": selected.inventory_diff_id }
                                data[data.length] = { "name": "txtinventoryid", "value": selected.inventoryid }
                                data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                                data[data.length] = { "name": "txtdepotname", "value": selected.d_name }
                                data[data.length] = { "name": "txtareaname", "value": selected.d_dq }
                                data[data.length] = { "name": "txtnums", "value": selected.zcnums }
                                data[data.length] = { "name": "txtsums", "value": selected.zcsums }
                                data[data.length] = { "name": "txtsure_date", "value": selected.sure_date }
                                data[data.length] = { "name": "txtsetdate", "value": selected.setdate }
                                data[data.length] = { "name": "txtstate", "value": "待分公司经理审批" }
                            }
                            var XMLData = GetFormJson(data, 'INSERT');
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
            })
            //}
        }
    });
}

//取消
function Cancel(type) {
    if (type == "A1") {
        $('#form_Apply').window('close');
    } else if (type == "A2") {
        $('#form_remittance').window('close');
        //} else if () {
        //$('#form_view').window('close');
    };
}


function onClickRow(RowIndex, RowData) {
    var type_state = RowData.state;
    if (type_state == "未申请" || type_state == "分公司经理驳回" || type_state == "总部销售驳回") {
        $('#btn_submit').linkbutton('disable');
        $('#btn_apply').linkbutton('enable');
    }
    else if (type_state == "待店铺汇款" || type_state == "财务驳回") {
        $('#btn_submit').linkbutton('enable');
        $('#btn_apply').linkbutton('disable');
    }
    else {
        $('#btn_submit').linkbutton('disable');
        $('#btn_apply').linkbutton('disable');
    }

    var selectinventoryid = RowData.inventoryid;

    if (selectinventoryid != "") {
        InitDetailInfo(selectinventoryid);
    }
    else {
        ClearGrid("#tab_list_detail");
    }

}

function Remittance_Submit() {
    $('#form_remittance').form('submit', {
        onSubmit: function (e) {
            if ($('#form_remittance').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            var selected = $('#tab_list').datagrid('getSelected');

            //var x = document.getElementById('txtamount_of_remittance').value);
            //var y = parseInt(selected.return_sums);

            //if (x < y) {
            //    $.messager.alert("提示", "你汇款的金额小于申请赔偿金额", 'error');
            //    return false;
            //}


            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {
                    $('#form_remittance').window('close');

                    var data = $('#form_remittance').serializeArray();
                    data[data.length] = { "name": "txtdepotid", "value": selected.depotid }
                    data[data.length] = { "name": "txtdepotname", "value": selected.d_name }
                    data[data.length] = { "name": "txtareaname", "value": selected.d_dq }
                    data[data.length] = { "name": "txtnums", "value": selected.zcnums }
                    data[data.length] = { "name": "txtsums", "value": selected.zcsums }
                    data[data.length] = { "name": "txtsure_date", "value": selected.sure_date }
                    data[data.length] = { "name": "txtsetdate", "value": selected.setdate }
                    data[data.length] = { "name": "txtreturn_sums", "value": selected.return_sums }
                    data[data.length] = { "name": "txtstate", "value": "待财务汇款确认" }

                    var XMLData = GetFormJson(data, 'INSERTREMITTANCE');
                    //return;
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