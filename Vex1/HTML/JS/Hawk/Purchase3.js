var mtypename = [{ "id": "A", "text": "服装童装配饰" }, { "id": "E", "text": "家具家饰" }];
var editIndex;
var SizeGroupData;
var DeliveryplanData;
var indexpohead;
var indexpoheaddetail;
$(function () {
    //var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'get') + "&WHERE=" + " Setdate between '" + m_Firstdate + "'" + " AND " + "'" + m_Enddate + "'";
    //InitGird(url);

    //$('#txtpo1_rgdt').datebox({
    //    valueField: 'id',
    //    textField: 'text',
    //    panelHeight: 'auto',
    //    editable: false,
    //    //formatter: function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }
    //    formatter: function (date) { return date.getFullYear(); }
    //});

    $('#formselect #txtbr1_name').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "BR1_BrandCode", "BR1_Name") + "&pagerows=20000&XML=" + GetFormJson([], 'GETBRAND'),
        panelHeight: 200,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });



    $('#formselect #txtpd1_season').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SSON" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    $('#formselect #txtpd1_years').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    $('#formselect #txtpo1_suppliercode').combogrid({
        panelWidth: 380,
        url: GetWSRRURL('d15d8c7d-4eb5-47c8-a2ba-fe3b95bb811b') + "&XML=" + GetFormJson([], 'SupplierInfo'),
        idField: 'sp1_suppliercode',
        textField: 'sp1_name',
        mode: 'remote',
        columns: [[
                { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
                { field: 'sp1_name', title: '供应商简称', width: 80 },
                { field: 'sp1_regioncode', title: '区域编码', width: 62 },
                { field: 'sp1_regionname', title: '区域名称', width: 62 },
                { field: 'sp1_supplytax', title: '供应商税率', width: 70 }
        ]]
    });

    $('#formselect #txtpo1_pc1_contractcode').combogrid({
        panelWidth: 100,
        url: GetWSRRURL('a03a74f3-ec50-42e8-a8f2-0ccd7712a5df') + "&XML=" + GetFormJson([], 'GETCONTRACTCOMBOGRID'),
        idField: 'pc1_contractcode',
        textField: 'pc1_contractcode',
        mode: 'remote',
        columns: [[
           { field: 'pc1_contractcode', title: '合同编号', width: 80 }
        ]]
    });

    $('#formAddEdit #txtpo1_potypecode').combobox({
        valueField: 'id',
        textField: 'text',
        data: mtypename,
        required: true,
        panelHeight: 'auto',
        editable: false,
        multiple: false,

        onSelect: function () {
            $('#formAddEdit #txtpo1_potypename').val($('#formAddEdit #txtpo1_potypecode').combobox('getText'));
        }
    });

    var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GET');
    InitGird_PO1_POHead(url);
})
function InitGird_PO1_POHead(url) {
    $('#PO1_POHeadList').datagrid(
        {
            title: '采购单', //表格标题
            url: url,
            sortName: 'po1_pocode', //排序字段
            idField: 'po1_pocode', //标识字段,主键
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
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            onSelect: onClickRow,
            rownumbers: true,
            columns: [[
                { field: 'ck', title: '选择', checkbox: true },
                //{ field: '序号', title: '序号', width: 50, search: true, sortable: true },
                { field: 'po1_pocode', title: '采购单编号', width: 65, search: true, sortable: true },
                { field: 'po1_potypecode', title: '供应商采购编号', width: 60, search: true, sortable: true },
                { field: 'po1_pc1_contractcode', title: '合同编号', width: 75, search: true, sortable: true },
                { field: 'po1_lstate', title: '最低状态', width: 30, search: true, sortable: true },
                { field: 'po1_hstate', title: '最高状态', width: 30, search: true, sortable: true },
                { field: 'po1_suppliercode', title: '供应商编号', width: 65, search: true, sortable: true },
                { field: 'sp1_name', title: '供应商名称', width: 95, search: true, sortable: true },
                { field: 'sp1_regionname', title: '供应商分类', width: 70, search: true, sortable: true },
                { field: 'po1_potypename', title: '采购类型', width: 60, search: true, sortable: true },
                { field: 'br1_name', title: '品牌名称', width: 60, search: true, sortable: true },
                { field: 'po1_plandeliverydate', title: '预计出货日期', width: 75, search: true, sortable: true },
                { field: 'po1_pznumber', title: '采购总数', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po1_currency', title: '币种', width: 35, search: true },
                { field: 'po1_ocurrencysums', title: '原币单价', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po1_dcurrencysums', title: '本币单价', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po1_exchangerate', title: '汇率', width: 40, search: true },
                { field: 'po1_increaseratio', title: '增值税', width: 45, search: true },
                { field: 'po1_tariffratio', title: '关税', width: 45, search: true },
                { field: 'po1_transportratio', title: '运费', width: 45, search: true },
                { field: 'pd1_supplytax', title: '供应商税率', width: 50, search: true },
                { field: 'po1_paymenttypename ', title: '付款方式', width: 60, search: true },
                { field: 'po1_paymentchannelname', title: '支付方式', width: 60, search: true },
                { field: 'po1_lmuser', title: '更新人', width: 50, search: true },
                { field: 'po1_lmdt', title: '更新时间', width: 80, search: true, sortable: true },
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    Type("Add");
                }
            },
            '-',
            {
                id: 'btn_Edit',
                text: '修改',
                iconCls: 'icon-edit',
                handler: function () {
                    Type("Edit");
                }
            },
            '-',
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    POHeadDelete()

                }
            },
            '-',
            {
                id: 'btn_End',
                text: '完结',
                iconCls: 'icon-up',
                handler: function () {
                    EndPoHead()
                }
            }
            ]
        });
}

function InitGird_PO1_POHeadSelect() {
    ClearGrid("#PO1_POHeadList");

    var mselectpo1_pocode = $('#formselect #txtpo1_pocode').val();
    var mselectpo1_suppliercode = $('#formselect #txtpo1_suppliercode').combogrid('getValue');
    var mselectpo1_pc1_contractcode = $('#formselect #txtpo1_pc1_contractcode').combogrid('getValue');
    var mselectbr1_name = $('#formselect  #txtbr1_name').combobox('getText');
    var mselectpd1_years = $('#formselect #txtpd1_years').combobox('getValue');
    var mselectpd1_season = $('#formselect #txtpd1_season').combobox('getText');

    var url = "1=1";
    if (mselectpo1_pocode != "") {
        url += " and po1_pocode='" + mselectpo1_pocode + "'";
    }
    if (mselectpo1_suppliercode != "") {
        url += " and po1_suppliercode='" + mselectpo1_suppliercode + "'";
    }
    if (mselectpo1_pc1_contractcode != "") {
        url += " and po1_pc1_contractcode='" + mselectpo1_pc1_contractcode + "'";
    }
    if (mselectbr1_name != "") {
        url += " and br1_name='" + mselectbr1_name + "'";
    }
    var data = [];
    data[data.length] = { "name": "txtpd1_years", "value": mselectpd1_years };
    data[data.length] = { "name": "txtpd1_season", "value": escape(mselectpd1_season) };

    url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson(data, 'GET') + "&WHERE=" + escape(url);

    InitGird_PO1_POHead(url);
}


function onClickRow(RowIndex, RowData) {

    if (RowData.po1_hstate == "75") {
        $('#btn_End').linkbutton('disable');
    }
    else {
        $('#btn_End').linkbutton('enable');
    }

    var mPO1POCode = RowData.po1_pocode
    var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETPODETIL') + "&WHERE=" + " PO2_POCode = '" + mPO1POCode + "'";
    InitGird_PO2_PODetail(url);
}

function InitGird_PO2_PODetail(url) {
    $('#PO2_PODetailList').datagrid(
        {
            url: url,
            sortName: 'po2_liseq', //排序字段
            idField: 'po2_liseq', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            rownumbers: true,
            selectOnCheck: false,
            checkOnSelect: true,
            onClickRow: Endshoworhide,
            columns: [[

                { field: 'ck', checkbox: true },
                { field: 'po2_liseq', title: '项次', width: 40, search: true },
                { field: 'po2_lsseq', title: '子项次', width: 40, search: true },
                { field: 'po2_state', title: '状态', width: 30, search: true },
                { field: 'st1_imagepath', title: '款图', width: 50, search: true, sortable: true },
                { field: 'po2_pd1_supperierstyle', title: '供应商款号', width: 70, search: true },
                { field: 'po2_pd1_supperiercolor', title: '供应商颜色/简', width: 60, search: true },
                { field: 'st3_st2_skccode', title: 'SKC', width: 100, search: true, sortable: true },
                { field: 'po2_pd1_supperiersize', title: '供应商尺码', editor: { type: 'validatebox', options: { required: true } }, width: 60, search: true },
                { field: 'st3_size', title: '尺码', width: 45, search: true },
                //{ field: 'po2_pd1_productcode', title: 'SKU', width: 100, editor: 'text', search: true, sortable: true },
                { field: 'po2_number', title: '采购数量', editor: { type: 'numberbox', options: { required: true } }, width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_unit', title: '单位', width: 35, search: true },
                { field: 'po2_purchasecurrency', title: '币种', width: 30, search: true },
                { field: 'po2_ocurrencyprice', title: '原币单价', width: 60, editor: { type: 'validatebox', options: { required: true } }, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_dcurrencyprice', title: '本币单价', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_ocurrencyamount', title: '原币金额', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_dcurrencyamount', title: '本币金额', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_plandeliverydate', title: '预计出货时间', width: 80, search: true },
                { field: 'po2_lmuser', title: '更新人', width: 50, search: true },
                { field: 'po2_lmdt', title: '更新时间', width: 60, search: true }
                //{ field: 'ck', checkbox: true },
                //{ field: 'po2_liseq', title: '项次', width: 50, search: true, sortable: true },
                //{ field: 'po2_lsseq', title: '子项次', width: 50, search: true, sortable: true },
                //{ field: 'po2_state', title: '状态', width: 50, search: true, sortable: true },
                ////{ field: 'po1_pc1_contractcode', title: '款图', width: 50, search: true, sortable: true },
                //{ field: 'po2_pd1_supperierstyle', title: '供应商款号', width: 120, search: true, sortable: true },
                //{ field: 'po2_pd1_supperiercolor', title: '供应商颜色/简', width: 90, search: true, sortable: true },
                //{ field: 'po2_pd1_supperiersize', title: '供应商尺码', width: 80, search: true, sortable: true },
                ////{ field: 'po2_pd1_productcode', title: 'SKU', width: 120, search: true, sortable: true },
                //{ field: 'po2_number', title: '采购数量', width: 100, search: true, sortable: true, align: 'right', formatter: Formater.Account },
                //{ field: 'po2_unit', title: '单位', width: 50, search: true, sortable: true },
                //{ field: 'po2_purchasecurrency', title: '币种', width: 80, search: true, sortable: true },
                //{ field: 'po2_ocurrencyprice', title: '原币单价', width: 60, search: true, sortable: true, align: 'right', formatter: Formater.Account },
                //{ field: 'po2_dcurrencyprice', title: '本币单价', width: 60, search: true, sortable: true, align: 'right', formatter: Formater.Account },
                //{ field: 'po2_ocurrencyamount', title: '原币金额', width: 60, search: true, sortable: true, align: 'right', formatter: Formater.Account },
                //{ field: 'po2_dcurrencyamount', title: '本币金额', width: 60, search: true, sortable: true, align: 'right', formatter: Formater.Account },
                //{ field: 'po2_plandeliverydate', title: '预计出货时间', width: 80, search: true, sortable: true },
                //{ field: 'po2_lmuser', title: '更新人', width: 50, search: true, sortable: true },
                //{ field: 'po2_lmdt', title: '更新时间', width: 50, search: true, sortable: true }
            ]],
            onLoadSuccess: function () {
                $('#PO2_PODetailList').datagrid("unselectAll");
            },
            toolbar: "#tab_toolbar",
            toolbar: [
            '-',
             {
                 id: 'btn_Examine',
                 text: '审核',
                 iconCls: 'icon-ok',
                 handler: function () {
                     Examinetype("yes")
                 }
             },
             '-',
             {
                 id: 'btn_Edit',
                 text: '弃审',
                 iconCls: 'icon-cancel',
                 handler: function () {
                     Examinetype("no")
                 }
             },
                '-',
                {
                    id: 'btn_poromve',
                    text: '完结',
                    iconCls: 'icon-ok',
                    handler: function () {
                        EndPoDetail("A")
                    }
                }
            ]
        });
}

function Endshoworhide() {
    var mPO2_PODetail = $('#PO2_PODetailList').datagrid('getSelected')
    if (mPO2_PODetail.po2_state == "75") {
        $('#btn_poromve').linkbutton('disable');
    }
    else {
        $('#btn_poromve').linkbutton('enable');
    }

}





function Examinetype(type) {
    var dataSelectPO2_PODetail = $('#PO2_PODetailList').datagrid('getChecked');
    if (dataSelectPO2_PODetail.length == 0) {
        alert('请选择采购明细');
        return;
    }
    else {
        if (type == "yes") {
            if (CheckStatus("审核")) {
                for (i = 0; i < dataSelectPO2_PODetail.length; i++) {
                    dataSelectPO2_PODetail[i].type = "35";
                }
                XMLData = GetEditJsonbyType(dataSelectPO2_PODetail, "EXAMINEPODETAIL");
                $.ajax({
                    url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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

                                $('#PO1_POHeadList').datagrid("reload");

                                //$('#PO1_POHeadList').datagrid("unselectAll");
                                $('#PO2_PODetailList').datagrid("reload");

                                //$('#PO2_PODetailList').datagrid("unselectAll");

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
            };
        } else {
            if (CheckStatus("反审核")) {
                for (i = 0; i < dataSelectPO2_PODetail.length; i++) {
                    dataSelectPO2_PODetail[i].type = "15";
                }
                XMLData = GetEditJsonbyType(dataSelectPO2_PODetail, "BACKEXAMINEPODETAIL");
                $.ajax({
                    url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                                //Reload_Select();
                                $('#PO1_POHeadList').datagrid("reload");
                                //$('#PO1_POHeadList').datagrid("unselectAll");
                                $('#PO2_PODetailList').datagrid("reload");
                                //$('#PO2_PODetailList').datagrid("unselectAll");
                                //Selectindex();
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
            };
        };
    };
};



function CheckStatus(type) {
    var dataSelectPO2_PODetail = $('#PO2_PODetailList').datagrid('getChecked');
    if (type == "审核") {
        for (i = 0; i < dataSelectPO2_PODetail.length; i++) {
            if (dataSelectPO2_PODetail[i].po2_state == "75" || dataSelectPO2_PODetail[i].po2_state == "35") {
                alert('你请检查数据状态');
                $('#PO2_PODetailList').datagrid("unselectAll");
                return false;
            } else {
                return true;
            };
        };
    } else {
        for (i = 0; i < dataSelectPO2_PODetail.length; i++) {
            if (dataSelectPO2_PODetail[i].po2_state != "35") {
                alert('请检查采购明细状态');
                $('#PO2_PODetailList').datagrid("unselectAll");
                return false;
            } else {
                return true;
            };
        };
    };
};



function EndPoDetail(type) {
    if (type == "A") {
        var dataSelectPO2_PODetail = $('#PO2_PODetailList').datagrid('getChecked');
        if (dataSelectPO2_PODetail.length == 0) {
            alert('请选择需要完结的行');
            return;
        }
    }
    else {
        var dataSelectPO2_PODetail = $('#PO2_PODetailList_A').datagrid('getChecked');
        if (dataSelectPO2_PODetail.length == 0) {
            alert('请选择需要完结的行');
            return;
        }
    }
    $.messager.confirm('提示框', '是否确认完结', function (r) {
        if (r) {
            for (i = 0; i < dataSelectPO2_PODetail.length; i++) {
                dataSelectPO2_PODetail[i].type = "75";
            }
            XMLData = GetEditJsonbyType(dataSelectPO2_PODetail, "ENDPODTETAIL");
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                            if (type == "A") {
                                $('#PO1_POHeadList').datagrid("reload");
                                $('#PO1_POHeadList').datagrid("unselectAll");
                                $('#PO2_PODetailList').datagrid("reload");
                                $('#PO2_PODetailList').datagrid("unselectAll");
                            } else {
                                $('#PO2_PODetailList_A').datagrid("reload");
                                $('#PO2_PODetailList_A').datagrid("unselectAll");
                                $('#PO2_PODetailList').datagrid("reload");
                            }
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









function CancelSelectParam() {
    $('#formselect #txtpo1_pocode').val("");
    $('#formselect #txtpo1_suppliercode').combogrid('setValue', "");
    $('#formselect #txtpo1_pc1_contractcode').combogrid('setValue', "");
    $('#formselect  #txtbr1_name').combobox('setValue', "");
    $('#formselect #txtpd1_years').combobox('setValue', "");
    $('#formselect #txtpd1_season').combobox('setValue', "");
}

function Type(type) {
    //ClearGrid("#AP1_APOHeadList");

    if (type == "Add") {
        $('#DivEdit').window({
            title: "采购单新增",
            top: 20,
            width: 1150,
            height: 600,
            maximized: true,
            modal: true
        });

        $('#formAddEdit #txtpo1_br1_brandcode').combobox({
            editable: false,
            required: true
        });
        $('#formAddEdit #txtpo1_pc1_contractcode').combogrid({
            editable: false
        });


        $('#formAddEdit #txtpo1_suppliercode').combogrid({
            panelWidth: 380,
            url: GetWSRRURL('d15d8c7d-4eb5-47c8-a2ba-fe3b95bb811b') + "&XML=" + GetFormJson([], 'SupplierInfo'),
            idField: 'sp1_suppliercode',
            textField: 'sp1_name',
            mode: 'remote',
            required: true,
            columns: [[
               { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
               { field: 'sp1_name', title: '供应商简称', width: 80 },
               { field: 'sp1_regioncode', title: '区域编码', width: 62 },
               { field: 'sp1_regionname', title: '区域名称', width: 62 },
               { field: 'sp1_supplytax', title: '供应商税率', width: 70 }
            ]],
            onClickRow: function (rowIndex, rowData) {
                var mRegionName = rowData['sp1_regionname'];
                var mSupplyTax = rowData['sp1_supplytax'];
                $('#formAddEdit #txtsp1_regionname').val(mRegionName);
                $('#formAddEdit #txtpo1_supplytax').val(mSupplyTax);
            },
            onChange: function () {
                var Selectbrandcode = $('#formAddEdit #txtpo1_suppliercode').combobox('getValue');
                init_select_brand(Selectbrandcode);
                init_select_contract(Selectbrandcode);
            }
        });
        function init_select_brand(Selectbrandcode) {
            var url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "BR1_BrandCode", "BR1_Name") + "&pagerows=20000&XML=" + GetFormJson([], 'GETBRAND')
                + "&Where=BR1_SupplierCode='" + Selectbrandcode + "'";
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_brand = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_br1_brandcode').combobox({
                data: m_select_brand,
                panelHeight: 'auto',
                required: true,
                editable: false,
                valueField: 'id',
                textField: 'text'
            });
        }

        function init_select_contract(Selectcontractcode) {
            var url = GetWSRRURL('a03a74f3-ec50-42e8-a8f2-0ccd7712a5df') + "&XML=" + GetFormJson([], 'GETCONTRACTCOMBOGRID')
                + "&Where=PC1_SP1_SupplierCode='" + Selectcontractcode + "'";
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_contract = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_pc1_contractcode').combogrid({
                panelWidth: 100,
                data: m_select_contract,
                idField: 'pc1_contractcode',
                textField: 'pc1_contractcode',
                mode: 'remote',
                //required: true,
                columns: [[
                   { field: 'pc1_contractcode', title: '合同编号', width: 80 }
                ]]
            });
        }

        $('#formAddEdit  #txtpo1_plandeliverydate').datebox({
            valueField: 'id',
            textField: 'text',
            required: true,
            panelHeight: 'auto',
            editable: false,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        });


        $('#formAddEdit #txtpo1_exchangerate').combobox({
            editable: false
        });

        $('#formAddEdit #txtpo1_currency').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "CUCD" + "'",
            panelHeight: 'auto',
            required: true,
            editable: false,
            valueField: 'id',
            textField: 'text',
            onChange: function () {
                var data = $('#formAddEdit #txtpo1_currency').combobox("getValue");
                initselectexchangerate(data);
            }
        });

        function initselectexchangerate(strselectexchangerate) {

            var dataParam = [];
            dataParam[dataParam.length] = { "name": "txtct1_code", "value": "CUCD" };
            dataParam[dataParam.length] = { "name": "txtct1_keyid ", "value": strselectexchangerate };
            url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&XML=" + GetFormJson(dataParam, 'GET2Level');
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_exchangerate = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_exchangerate').combobox({
                data: m_select_exchangerate,
                panelHeight: 'auto',
                editable: false,
                valueField: 'id',
                textField: 'text',
                onLoadSuccess: function () {
                    var data = $('#formAddEdit #txtpo1_exchangerate').combobox("getData");
                    if (data.length != 0) {
                        $('#formAddEdit #txtpo1_exchangerate').combobox('setValue', data[0].text);
                    }

                    //重新计算
                    var listData = $('#PO2_PODetailList_A').datagrid('getRows')
                    for (var i = 0; i < listData.length; i++) {
                        TotalNum(listData[i]);
                    }
                    TotalPrice();
                }
            });
        }

        $('#formAddEdit #txtpo1_paymenttypename').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "TEPY" + "'",
            panelHeight: 'auto',
            editable: false,
            required: true,
            valueField: 'text',
            textField: 'text'
        });

        $('#formAddEdit #txtpo1_paymentchannelname').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "PYTP" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            required: true,
            textField: 'text'
        });

        $('#formAddEdit #txtpo1_increaseratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "VTCD" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_increaseratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_increaseratio').combobox('setValue', data[5].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_transportratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "FRHT" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_transportratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_transportratio').combobox('setValue', data[0].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_tariffratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "TARI" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_tariffratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_tariffratio').combobox('setValue', data[0].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_pocode ').val("");
        $('#formAddEdit #txtpo1_potypecode ').combobox('setValue', "");
        $('#formAddEdit #txtpo1_hstate ').val("15");
        $('#formAddEdit #txtpo1_lstate ').val("15");
        $('#formAddEdit #txtpo1_suppliercode ').val("");
        $('#formAddEdit #txtsp1_regionname ').val("");
        $('#formAddEdit #txtpo1_plandeliverydate ').datebox('setValue', "");
        //$('#formAddEdit #txtpo1_br1_brandcode').combobox('setValue', "");
        $('#formAddEdit #txtpo1_pznumber').val("");
        $('#formAddEdit #txtpo1_sppocode').val("");
        $('#formAddEdit #txtpo1_ocurrencysums').val("");
        $('#formAddEdit #txtpo1_dcurrencysums').val("");
        $('#formAddEdit #txtpo1_currency ').combobox('setValue', "");
        $('#formAddEdit #txtpo1_exchangerate').val("");
        $('#formAddEdit #txtpd1_supplytax ').val("");
        $('#formAddEdit #txtpo1_paymenttypename').combobox('setValue', "");
        $('#formAddEdit #txtpo1_paymentchannelname ').combobox('setValue', "");
        $('#formAddEdit #txtpo1_increaseratio ').combobox('setValue', "");
        $('#formAddEdit #txtpo1_tariffratio').combobox('setValue', "");
        $('#formAddEdit #txtpo1_transportratio').combobox('setValue', "");
        $('#formAddEdit #txtpo1_exchangerate').combobox('setValue', "");

        InitGird_PO2_PODetail_B(false);
        $('#formAddEdit #txtpo1_potypecode').combobox('enable');
        $(".datagrid-toolbar #btn_End").hide();
        //$(".datagrid-toolbar #btn_OverAPO").hide();
    }
    else if (type == "Edit") {
        var EditPO2_PODetail = $('#PO1_POHeadList').datagrid('getSelected')

        if (!EditPO2_PODetail) {
            alert('请选择一行');
            return;
        }
        $('#DivEdit').window({
            title: "采购单修改",
            top: 20,
            width: 1150,
            height: 600,
            maximized: true,
            modal: true
        });

        $('#formAddEdit #txtpo1_br1_brandcode').combobox({
            editable: false,
            required: true
        });
        $('#formAddEdit #txtpo1_pc1_contractcode').combogrid({
            editable: false,
            required: false

        });

        $('#formAddEdit #txtpo1_suppliercode').combogrid({
            panelWidth: 380,
            url: GetWSRRURL('d15d8c7d-4eb5-47c8-a2ba-fe3b95bb811b') + "&XML=" + GetFormJson([], 'SupplierInfo'),
            idField: 'sp1_suppliercode',
            textField: 'sp1_name',
            mode: 'remote',
            required: true,
            columns: [[
               { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
               { field: 'sp1_name', title: '供应商简称', width: 80 },
               { field: 'sp1_regioncode', title: '区域编码', width: 62 },
               { field: 'sp1_regionname', title: '区域名称', width: 62 },
               { field: 'sp1_supplytax', title: '供应商税率', width: 70 }
            ]],
            onClickRow: function (rowIndex, rowData) {
                var mRegionName = rowData['sp1_regionname'];
                var mSupplyTax = rowData['sp1_supplytax'];
                $('#formAddEdit #txtsp1_regionname').val(mRegionName);
                $('#formAddEdit #txtpo1_supplytax').val(mSupplyTax);
            },
            onChange: function () {
                var Selectbrandcode = $('#formAddEdit #txtpo1_suppliercode').combobox('getValue');
                init_select_brand(Selectbrandcode);
                init_select_contract(Selectbrandcode);
            }
        });

        function init_select_brand(Selectbrandcode) {
            var url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "BR1_BrandCode", "BR1_Name") + "&pagerows=20000&XML=" + GetFormJson([], 'GETBRAND')
                + "&Where=BR1_SupplierCode='" + Selectbrandcode + "'";
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_brand = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_br1_brandcode').combobox({
                data: m_select_brand,
                panelHeight: 'auto',
                required: true,
                editable: false,
                valueField: 'id',
                textField: 'text'
            });
        }
        function init_select_contract(Selectcontractcode) {
            var url = GetWSRRURL('a03a74f3-ec50-42e8-a8f2-0ccd7712a5df') + "&XML=" + GetFormJson([], 'GETCONTRACTCOMBOGRID')
                + "&Where=PC1_SP1_SupplierCode='" + Selectcontractcode + "'";
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_contract = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_pc1_contractcode').combogrid({
                panelWidth: 100,
                data: m_select_contract,
                idField: 'pc1_contractcode',
                textField: 'pc1_contractcode',
                mode: 'remote',
                //required: true,
                columns: [[
                   { field: 'pc1_contractcode', title: '合同编号', width: 80 }
                ]]
            });
        }
        //$('#formAddEdit #txtpo1_pc1_contractcode').combogrid({
        //    panelWidth: 100,
        //    url: GetWSRRURL('a03a74f3-ec50-42e8-a8f2-0ccd7712a5df') + "&XML=" + GetFormJson([], 'GETCONTRACTCOMBOGRID'),
        //    idField: 'pc1_contractcode',
        //    textField: 'pc1_contractcode',
        //    mode: 'remote',
        //    //required: true,
        //    columns: [[
        //       { field: 'pc1_contractcode', title: '合同编号', width: 80 }
        //    ]]
        //});


        //$('#formAddEdit #txtpo1_br1_brandcode').combobox({
        //    url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "BR1_BrandCode", "BR1_Name") + "&pagerows=20000&XML=" + GetFormJson([], 'GETBRAND'),
        //    panelHeight: 'auto',
        //    required: true,
        //    editable: false,
        //    valueField: 'id',
        //    textField: 'text',
        //});

        $('#formAddEdit  #txtpo1_plandeliverydate').datebox({
            valueField: 'id',
            textField: 'text',
            required: true,
            panelHeight: 'auto',
            editable: false,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        });


        $('#formAddEdit #txtpo1_exchangerate').combobox({
            editable: false
        });

        $('#formAddEdit #txtpo1_currency').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "CUCD" + "'",
            panelHeight: 'auto',
            required: true,
            editable: false,
            valueField: 'id',
            textField: 'text',
            //onChange: function () {
            //    var data = $('#formAddEdit #txtpo1_currency').combobox("getValue");
            //    initselectexchangerate(data);
            //}

            onSelect: function () {
                var data = $('#formAddEdit #txtpo1_currency').combobox("getValue");
                initselectexchangerate(data);
            }
        });

        function initselectexchangerate(strselectexchangerate) {

            var dataParam = [];
            dataParam[dataParam.length] = { "name": "txtct1_code", "value": "CUCD" };
            dataParam[dataParam.length] = { "name": "txtct1_keyid ", "value": strselectexchangerate };
            url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&XML=" + GetFormJson(dataParam, 'GET2Level');
            htmlobj = $.ajax({
                url: url,
                async: false
            });
            m_select_exchangerate = $.parseJSON(htmlobj.responseText);

            $('#formAddEdit #txtpo1_exchangerate').combobox({
                data: m_select_exchangerate,
                panelHeight: 'auto',
                editable: false,
                valueField: 'id',
                textField: 'text',
                onLoadSuccess: function () {
                    var data = $('#formAddEdit #txtpo1_exchangerate').combobox("getData");
                    if (data.length != 0) {
                        $('#formAddEdit #txtpo1_exchangerate').combobox('setValue', data[0].text);
                    }

                    //重新计算
                    var listData = $('#PO2_PODetailList_A').datagrid('getRows')
                    for (var i = 0; i < listData.length; i++) {
                        TotalNum(listData[i]);
                    }
                    TotalPrice();
                }
            });
        }

        $('#formAddEdit #txtpo1_paymenttypename').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "TEPY" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text'
        });

        $('#formAddEdit #txtpo1_paymentchannelname').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "PYTP" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text'
        });

        $('#formAddEdit #txtpo1_increaseratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "VTCD" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_increaseratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_increaseratio').combobox('setValue', data[5].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_transportratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "FRHT" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_transportratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_transportratio').combobox('setValue', data[0].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_tariffratio').combobox({
            url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "TARI" + "'",
            panelHeight: 'auto',
            editable: false,
            valueField: 'text',
            textField: 'text',
            onLoadSuccess: function () {
                var data = $('#formAddEdit #txtpo1_tariffratio').combobox("getData");
                if (data.length != 0) {
                    $('#formAddEdit #txtpo1_tariffratio').combobox('setValue', data[0].text);
                }
            }
        });

        $('#formAddEdit #txtpo1_potypecode').combobox({});


        $('#formAddEdit #txtpo1_pocode ').val(EditPO2_PODetail.po1_pocode);
        $('#formAddEdit #txtpo1_potypecode').combobox('setValue', EditPO2_PODetail.po1_potypename);
        $('#formAddEdit #txtpo1_hstate ').val(EditPO2_PODetail.po1_hstate);
        $('#formAddEdit #txtpo1_lstate ').val(EditPO2_PODetail.po1_lstate);
        $('#formAddEdit #txtpo1_plandeliverydate ').datebox('setValue', EditPO2_PODetail.po1_plandeliverydate);
        $('#formAddEdit #txtpo1_pznumber').val(EditPO2_PODetail.po1_pznumber);
        $('#formAddEdit #txtpo1_sppocode').val(EditPO2_PODetail.po1_sppocode);
        $('#formAddEdit #txtpo1_ocurrencysums').val(EditPO2_PODetail.po1_ocurrencysums);
        $('#formAddEdit #txtpo1_dcurrencysums').val(EditPO2_PODetail.po1_dcurrencysums);
        $('#formAddEdit #txtpo1_paymenttypename').combobox('setValue', EditPO2_PODetail.po1_paymenttypename);
        $('#formAddEdit #txtpo1_paymentchannelname ').combobox('setValue', EditPO2_PODetail.po1_paymentchannelname);
        $('#formAddEdit #txtpo1_increaseratio ').combobox('setValue', EditPO2_PODetail.po1_increaseratio);
        $('#formAddEdit #txtpo1_tariffratio').combobox('setValue', EditPO2_PODetail.po1_tariffratio);
        $('#formAddEdit #txtpo1_transportratio').combobox('setValue', EditPO2_PODetail.po1_transportratio);
        $('#formAddEdit #txtpo1_suppliercode').combogrid('setValue', EditPO2_PODetail.po1_suppliercode);
        $('#formAddEdit #txtsp1_regionname ').val(EditPO2_PODetail.sp1_regionname);
        $('#formAddEdit #txtpd1_supplytax').val(EditPO2_PODetail.pd1_supplytax);
        $('#formAddEdit #txtpo1_br1_brandcode').combobox('setValue', EditPO2_PODetail.br1_name);
        $('#formAddEdit #txtpo1_pc1_contractcode').combogrid('setValue', EditPO2_PODetail.po1_pc1_contractcode);

        $('#formAddEdit #txtpo1_exchangerate').val(EditPO2_PODetail.po1_exchangerate);

        $('#formAddEdit #txtpo1_currency').combobox('setValue', EditPO2_PODetail.po1_currency);//结算币种

        $('#formAddEdit #txtpo1_exchangerate').combobox('setValue', EditPO2_PODetail.po1_exchangerate); //汇率


        InitGird_PO2_PODetail_B(true);

        $('#formAddEdit #txtpo1_potypecode').combobox('disable');
        $(".datagrid-toolbar #btn_End").show();
    }
    if (type == "Add") {
        var url1 = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETAPOList') + "&WHERE=" + "1!=1";
    }
    else if (type == "Edit") {
        var mAP1_PO1_PurchaseCode = $('#formAddEdit #txtpo1_pocode').val()
        var url1 = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETAPOList') + "&WHERE=" + " AP1_PO1_PurchaseCode = '" + mAP1_PO1_PurchaseCode + "'";
    }

    $('#AP1_APOHeadList').datagrid(
        {
            url: url1,
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            striped: true, //True 奇偶行使用不同背景色
            fit: true,
            pageSize: 20, //默认一页数据条数 
            rownumbers: true,
            singleSelect: true, //单行选择
            onClickCell: onClickCellAP1_APOHeadList,
            columns: [[
                { field: 'ap1_apcode', title: '到货计划编号', width: 100 },
                { field: 'ap2_linumber', title: '项次', width: 40 },
                { field: 'ap2_lsnumber', title: '子项次', width: 90 },
                { field: 'st3_st1_stylecode', title: '款号', width: 100 },
                { field: 'ct1_keyname', title: '颜色', width: 50 },
                { field: 'st3_size', title: '尺码', width: 80 },
                //{ field: 'ap2_aplannumber', title: '采购总数', width: 80 },
                { field: 'po2_number', title: '采购总数', width: 80 },
                { field: 'yrknum', title: '已入库数量', width: 100 },
                { field: 'yscnum', title: '已生成计划数量', width: 100 },
                { field: 'differences', title: '数量差异', width: 100 },
                { field: 'ap1_aplannumber', title: '本次计划到货数', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                //{ field: 'ap1_aplannumber', title: '本次计划到货数', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'ap1_aplandt', title: '本次计划到货时间', width: 100 },
                { field: 'ap1_rgdt', title: '更新人', width: 100 },
                { field: 'ap1_rguser', title: '更新时间', width: 100 },
                { field: 'ap1_po1_purchasecode', title: '采购单编号', width: 90 },
                { field: 'ap1_hstate', title: '最高状态', width: 90 },
                { field: 'ap1_lstate', title: '最低状态', width: 90 },
                { field: 'ap2_state', title: '状态', width: 90 },
                { field: 'st3_st2_skccode', title: 'skc', width: 90 }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_Add',
                text: '保存到货计划',
                iconCls: 'icon-add',
                handler: function () {
                    AddAPO();
                }
            },
            {
                id: 'btn_Delete_AP1_APOHead',
                text: '删除到货计划',
                iconCls: 'icon-remove',
                handler: function () {
                    DeleteAPO();
                }
            },
            {
                id: 'btn_OverAPO',
                text: '完结到货计划',
                iconCls: 'icon-ok',
                handler: function () {
                    EndAPO();
                }
            }
            ]
        });

    var $dg = $('#AP1_APOHeadList');


    $dg.datagrid("hideColumn", "st3_st2_skccode");
    $dg.datagrid("hideColumn", "ap2_state");
    $dg.datagrid("hideColumn", "ap1_lstate");
    $dg.datagrid("hideColumn", "ap1_hstate");
    $dg.datagrid("hideColumn", "ap1_po1_purchasecode");

    col = $('#AP1_APOHeadList').datagrid('getColumnOption', 'ap1_aplandt');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        }
    }

    $dg.datagrid();
    if (type == "Add") {
        $(".datagrid-toolbar  #btn_OverAPO").hide();
    }
    else if (type == "Edit") {
        $(".datagrid-toolbar  #btn_OverAPO").show();
    }
}
//主表删除
function POHeadDelete() {

    var dataSelectPO1_POHead = $('#PO1_POHeadList').datagrid('getSelected');
    if (!dataSelectPO1_POHead) {
        alert('请选择需要删除的一行');
        return;
    }

    var DatePO2_PODetailList = $('#PO2_PODetailList').datagrid('getData');
    if (DatePO2_PODetailList.rows.length != "0") {
        alert('已经生成采购子表无法删除')
        return;
    }
    $.messager.confirm('提示框', '是否确认删除', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtpo1_pocode", "value": dataSelectPO1_POHead.po1_pocode }

            var XMLData = GetFormJson(data, 'DELETEPOHEAD');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                            $('#PO1_POHeadList').datagrid("reload");
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
//采购主表完结
function EndPoHead() {
    var dataSelectPO1_POHead = $('#PO1_POHeadList').datagrid('getSelected');
    if (!dataSelectPO1_POHead) {
        alert('请选择需要完结的一行');
        return;
    }
    $.messager.confirm('提示框', '是否确认完结', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtpo1_pocode", "value": dataSelectPO1_POHead.po1_pocode }
            var XMLData = GetFormJson(data, 'ENDPOHEAD');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                            $('#PO1_POHeadList').datagrid("reload");
                            $('#PO2_PODetailList').datagrid("reload");
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


function onClickCellAP1_APOHeadList(index, field) {
    if (endEditingAP1_APOHeadList()) {
        $('#AP1_APOHeadList').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
        editIndex = index;
    }
}


function endEditingAP1_APOHeadList() {
    if (editIndex != undefined) {
        if ($('#AP1_APOHeadList').datagrid('validateRow', editIndex)) {
            $('#AP1_APOHeadList').datagrid('endEdit', editIndex);
            editIndex = undefined;
        }
        else {
            return false;
        }
    }
    return true;
}

function InitGird_PO2_PODetail_B(type) {
    if (type == false) {
        var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETPODETIL') + "&WHERE=" + "1!=1";
    }
    else if (type == true) {
        var mPO1POCode = $('#formAddEdit #txtpo1_pocode').val()
        var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETPODETIL') + "&WHERE=" + " PO2_POCode = '" + mPO1POCode + "'";
    }
    else if (type == "PoDetail") {
        var mPO1POCode = $('#formAddEdit #txtpo1_pocode').val();
        var url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETPODETIL') + "&WHERE=" + " PO2_POCode = '" + mPO1POCode + "'";
    }

    $('#PO2_PODetailList_A').datagrid(
        {
            url: url,
            sortName: 'st3_st2_skccode,st3_size', //排序字段
            idField: 'po2_liseq', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            onDblClickRow: onDblClickRow,
            onClickCell: function () { endEditing() },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            showFooter: true,
            rownumbers: true,
            selectOnCheck: false,
            checkOnSelect: true,
            columns: [[
                { field: 'ck', checkbox: true },
                { field: 'po2_liseq', title: '项次', width: 40, search: true },
                { field: 'po2_lsseq', title: '子项次', width: 40, search: true },
                { field: 'po2_state', title: '状态', width: 30, search: true },
                { field: 'st1_imagepath', title: '款图', width: 50, search: true, sortable: true },
                { field: 'po2_pd1_supperierstyle', title: '供应商款号', width: 70, search: true },
                { field: 'po2_pd1_supperiercolor', title: '供应商颜色/简', width: 60, search: true },
                { field: 'st3_st2_skccode', title: 'SKC', width: 100, search: true, sortable: true },
                { field: 'po2_pd1_supperiersize', title: '供应商尺码', editor: { type: 'validatebox', options: { required: true } }, width: 60, search: true },
                { field: 'st3_size', title: '尺码', width: 45, search: true },
                //{ field: 'po2_pd1_productcode', title: 'SKU', width: 100, editor: 'text', search: true, sortable: true },
                { field: 'po2_number', title: '采购数量', editor: { type: 'numberbox', options: { required: true } }, width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_unit', title: '单位', width: 35, search: true },
                { field: 'po2_purchasecurrency', title: '币种', width: 30, search: true },
                { field: 'po2_ocurrencyprice', title: '原币单价', width: 60, editor: { type: 'validatebox', options: { required: true } }, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_dcurrencyprice', title: '本币单价', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_ocurrencyamount', title: '原币金额', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_dcurrencyamount', title: '本币金额', width: 60, search: true, align: 'right', formatter: Formater.Account },
                { field: 'po2_plandeliverydate', title: '预计出货时间', width: 80, search: true },
                { field: 'po2_lmuser', title: '更新人', width: 50, search: true },
                { field: 'po2_lmdt', title: '更新时间', width: 60, search: true }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                hidden: false,
                handler: function () {
                    AddPODetailList()
                }
            },
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-remove',
                hidden: false,
                handler: function () {
                    DeletePO2_PODetail()
                }
            },
            {
                id: 'btn_Copy',
                text: '复制',
                iconCls: 'icon-pagecopy',
                hidden: false,
                handler: function () {
                    PODetailCopy()
                }
            },
            {
                id: 'btn_AddConteact',
                iconCls: 'icon-add',
                text: '新增到货计划',
                hidden: false,
                handler: function () {
                    AddDeliveryplan()
                }
            },
            {
                id: 'btn_End',
                text: '完结',
                hidden: false,
                iconCls: 'icon-up',
                handler: function () {
                    EndPoDetail("B")

                }
            }
            ]
        });
    col = $('#PO2_PODetailList_A').datagrid('getColumnOption', 'po2_plandeliverydate');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        }
    }
}


function BeginEdit(index, rowData) {

    var DateAP1_APOHeadList = $('#AP1_APOHeadList').datagrid('getData');

    for (var i = 0; i < DateAP1_APOHeadList.rows.length; i++) {
        if (DateAP1_APOHeadList.rows[i].ap2_linumber == rowData.po2_liseq) {
            $.messager.alert("提示", "已经生成到货计划，不能修改！", 'error');
            return false;
        }
    }
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;

            SelectSizeGroup(rowData.st2_sizegroup);

            var col = $('#PO2_PODetailList_A').datagrid('getColumnOption', 'st3_size');
            if (col.dataSizegroup == null) {
                SelectSizeGroup(rowData.st2_sizegroup);
                col.dataSizegroup = SizeGroupData;
            }
            col.editor = {
                type: 'combobox', options:
                { data: col.dataSizegroup, required: true, editable: false, valueField: 'id', textField: 'text' }
            };
            //col.formatter = function (value) {
            //    var date = GetCommboboxText(SizeGroupData, value);
            //    return date;
            //}

            $('#PO2_PODetailList_A').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);


            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}

function onDblClickRow(index, rowData) {
    BeginEdit(index, rowData);
}





function endEditing() {
    if (editIndex != undefined) {
        if ($('#PO2_PODetailList_A').datagrid('validateRow', editIndex)) {
            $('#PO2_PODetailList_A').datagrid('endEdit', editIndex);
            TotalNum($('#PO2_PODetailList_A').datagrid('getSelected'));

            editIndex = undefined;
            TotalPrice();
        }
        else {
            return false;
        }
    }
    return true;
}



function AddPODetailList() {

    if ($('#formAddEdit').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填写好，再新增明细！", 'error');
        return false;
    }
    $('#DivAddPODetail').window({
        title: "新增采购明细",
        top: 20,
        width: 800,
        height: 400,
        modal: true
    });

    $('#formAddPODetail #txtpd1_season').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SSON" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onLoadSuccess: function () {
            var data = $('#formAddPODetail #txtpd1_season').combobox("getData");
            if (data.length == 0 || data[0].id != "0") {
                ComboboxAddRow({ "id": "0", "text": "全部", "selected": true }, 0, '#formAddPODetail #txtpd1_season');
            }
        }
    });

    $('#formAddPODetail #txtpd1_years').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });



    $('#formAddPODetail #txtpo1_suppliercode').val($('#formAddEdit #txtpo1_suppliercode').combobox('getValue'));
    $('#formAddPODetail #txtsp1_name').val($('#formAddEdit #txtpo1_suppliercode').combobox('getText'));
    $('#formAddPODetail #txtpo1_br1_brandcode').val($('#formAddEdit #txtpo1_br1_brandcode').combobox('getValue'));
    $('#formAddPODetail #txtbr1_name').val($('#formAddEdit #txtpo1_br1_brandcode').combobox('getText'));

    var txtpo1_suppliercode = $('#formAddEdit #txtpo1_suppliercode').combobox('getValue');
    var txtBR1_Name = $('#formAddEdit #txtpo1_br1_brandcode').combobox('getText');


    var url = " 1=1";
    url += " and ST1_SupplierCode = '" + txtpo1_suppliercode + "'" + " AND  BR1_Name  = " + "'" + txtBR1_Name + "'";


    url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETSTYLE') + "&WHERE=" + escape(url);
    SelectStyleInfo(url);
}

function SelectStyleInfo(url) {
    $('#selectstylelist').datagrid(
           {
               url: url,
               sortName: 'st2_state', //排序字段
               //idField: 'st2_state', //标识字段,主键
               width: '90%', //宽度
               height: $(document).height() - 100, //高度
               nowrap: true, //是否换行，True 就会把数据显示在一行里
               remoteSort: true, //定义是否从服务器给数据排序
               collapsible: false, //可折叠
               sortable: true,
               striped: true, //True 奇偶行使用不同背景色
               singleSelect: true, //单行选择
               fit: true,
               pagination: true, //是否开启分页
               pageSize: 20, //默认一页数据条数 
               //onSelect: onClickRow,
               onDblClickRow: SelectStyleDblClickRow,
               showFooter: true,
               rownumbers: true,
               selectOnCheck: false,
               checkOnSelect: true,
               columns: [[
                   { field: 'ck', checkbox: true },
                   { field: 'rownumber', title: '序号', width: 40 },
                   { field: 'st2_state', title: '状态', width: 40 },
                   { field: 'st1_imagepath', title: '款图', width: 100 },
                   { field: 'st2_purchaseprice', title: '参考采购价', width: 100 },
                   { field: 'po1_ocurrencysums', title: '采购价', width: 100 },
                   { field: 'st1_supperierstyle', title: '供应商款号', width: 100 },
                   { field: 'st2_supperiercolor', title: '供应商颜色/简', width: 100 },
                   { field: 'st2_skccode', title: 'SKC', width: 100 }
               ]],
               onLoadSuccess: function () {
                   $('#selectstylelist').datagrid("unselectAll");
               },
               toolbar: "#selectstylelisttab_toolbar",
               toolbar: [
               {
                   id: 'btn_save',
                   text: '确定',
                   iconCls: 'icon-save',
                   //hidden: false,
                   handler: function () {
                       SelectStyleDblClickRow();
                   }
               }]
           })
}


function SelectStyleDblClickRow() {

    //var SelectStyle = $('#selectstylelist').datagrid('getSelected')
    var SelectStyle = $('#selectstylelist').datagrid('getChecked');

    $('#DivAddPODetail').window('close');

    for (k = 0; k < SelectStyle.length; k++) {

        var nMaxId = 0;
        var PO2_PODetailList_AData = $('#PO2_PODetailList_A').datagrid('getData');
        for (var i = 0; i < PO2_PODetailList_AData.rows.length; i++) {
            if (parseInt(PO2_PODetailList_AData.rows[i].po2_liseq) > nMaxId) {
                nMaxId = parseInt(PO2_PODetailList_AData.rows[i].po2_liseq);
            }
        }
        nMaxId++;

        var SelectStyleForpo2_unit = SelectStyle[k].st2_st1_stylecode;

        if (SelectStyleForpo2_unit != "") {
            XMLData = GetFormJson([], 'GETUNIT');
            htmlobj = $.ajax({
                url: GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0'),
                data: { "XML": XMLData, "WHERE": "ST1_StyleCode ='" + SelectStyleForpo2_unit + "'" },
                type: 'post',
                async: false
            });
            var result = $.parseJSON(htmlobj.responseText);
            if (result.rows[0]['st1_unit'] != "") {
                var Selectst1_unit = result.rows[0]['st1_unit']
            }
        }

        $('#PO2_PODetailList_A').datagrid('appendRow',
            {
                po2_liseq: nMaxId,
                //po2_state: SelectStyle.st2_state,
                po2_state: "15",
                po2_lsseq: "000",
                po2_ocurrencyprice: SelectStyle[k].st2_purchaseprice,
                po2_pd1_supperierstyle: SelectStyle[k].st1_supperierstyle,
                po2_pd1_supperiercolor: SelectStyle[k].st2_supperiercolor,
                st2_sizegroup: SelectStyle[k].st2_sizegroup,
                st3_st2_skccode: SelectStyle[k].st2_skccode,
                po2_pd1_supperiersize: "",
                po2_number: "000",
                po2_unit: Selectst1_unit,
                po2_plandeliverydate: $('#formAddEdit #txtpo1_plandeliverydate').datebox('getValue'),
                po2_purchasecurrency: "",
                po2_ocurrencyamount: "0",
                po2_dcurrencyamount: "0",
                po2_pocode: $('#formAddEdit #txtpo1_pocode').val(),
                po2_purchasecurrency: $('#formAddEdit #txtpo1_currency').combobox('getValue'),
                po2_dcurrencyprice: $('#formAddEdit #txtpo1_exchangerate').combobox('getValue') * SelectStyle[k].st2_purchaseprice
            });
    }
    TotalPrice();
}

function SelectStyeCancel() {
    $('#formAddPODetail #txtpd1_season').combobox('setValue', "");
    $('#formAddPODetail #txtpd1_years').combobox('setValue', "");
    $('#formAddPODetail #txtpd1_stylecode').val("");
    $('#formAddPODetail #txtpo2_pd1_supperierstyle').val("");
}

function SearchStyle() {

    var txtpo1_suppliercode = $('#formAddEdit #txtpo1_suppliercode').combobox('getValue');
    var txtpo1_br1_brandcode = $('#formAddEdit #txtpo1_br1_brandcode').combobox('getValue');

    var txtpd1_years = $('#formAddPODetail #txtpd1_years').combobox('getValue');
    var txtpd1_season = $('#formAddPODetail #txtpd1_season').combobox('getValue');
    var txtpd1_stylecode = $('#formAddPODetail #txtpd1_stylecode').val();
    var txtpo2_pd1_supperierstyle = $('#formAddPODetail #txtpo2_pd1_supperierstyle').val();

    var url = "1=1";
    if (txtpd1_years != "") {
        url += " and ST1_Years = '" + txtpd1_years + "'";
    } else {
        url = url;
    }
    if (txtpd1_season != "0") {
        url += " and ST1_Season = '" + txtpd1_season + "'";
    }
    else {
        url = url;
    }
    if (txtpd1_stylecode == "") {
        url = url;
    }
    else {
        url += " and ST2_ST1_StyleCode='" + txtpd1_stylecode + "'";
    }
    if (txtpo2_pd1_supperierstyle == "") {
        url = url;
    }
    else {
        url += " and ST1_SupperierStyle='" + txtpo2_pd1_supperierstyle + "'";
    }
    url += " and ST1_SupplierCode = '" + txtpo1_suppliercode + "'" + " AND  ST1_BR1_BrandCode = " + "'" + txtpo1_br1_brandcode + "'";
    url = GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850') + "&XML=" + GetFormJson("", 'GETSTYLE') + "&WHERE=" + escape(url);
    SelectStyleInfo(url);
}




function TotalNum(prowOpration) {

    var Num = prowOpration.po2_number; //数量
    var npo2_ocurrencyprice = prowOpration.po2_ocurrencyprice; //采购原币单价
    var npo1_exchangerate = $('#formAddEdit #txtpo1_exchangerate').combobox('getValue') //汇率
    var npo2_dcurrencyprice = npo2_ocurrencyprice * npo1_exchangerate; //采购本币单价
    var npo2_ocurrencyamount = npo2_ocurrencyprice * Num; //采购原币金额
    var npo2_dcurrencyamount = npo2_dcurrencyprice * Num; //采购本币金额
    var index = $('#PO2_PODetailList_A').datagrid('getRowIndex', prowOpration)

    if (Num == undefined) {
        return;
    }
    else {
        Num = Num * 1;
    }

    $('#PO2_PODetailList_A').datagrid('updateRow', {
        index: index,
        row:
        {
            po2_dcurrencyprice: npo2_dcurrencyprice,
            po2_ocurrencyamount: npo2_ocurrencyamount,
            po2_dcurrencyamount: npo2_dcurrencyamount,
            po2_purchasecurrency: $('#formAddEdit #txtpo1_currency').combobox('getValue')
        }
    });

}



//总数采购主表
function TotalPrice() {

    var PO2_PODetailList_AData = $('#PO2_PODetailList_A').datagrid('getData');


    var npo2_number = 0; var npo2_numberTotal = 0; //总金额

    var npo2_ocurrencyamount = 0; var npo2_ocurrencyamountTotal = 0;//原币单价

    var npo2_dcurrencyamount = 0; var npo2_dcurrencyamountTotal = 0;//本币单价


    for (var i = 0; i < PO2_PODetailList_AData.rows.length; i++) {
        npo2_number = parseFloat(PO2_PODetailList_AData.rows[i].po2_number)
        npo2_numberTotal = npo2_numberTotal + npo2_number;


        npo2_ocurrencyamount = parseFloat(PO2_PODetailList_AData.rows[i].po2_ocurrencyamount)
        npo2_ocurrencyamountTotal = npo2_ocurrencyamountTotal + npo2_ocurrencyamount;

        npo2_dcurrencyamount = parseFloat(PO2_PODetailList_AData.rows[i].po2_dcurrencyamount)
        npo2_dcurrencyamountTotal = npo2_dcurrencyamountTotal + npo2_dcurrencyamount;

    }

    $('#formAddEdit #txtpo1_pznumber').val(npo2_numberTotal);
    $('#formAddEdit #txtpo1_ocurrencysums').val(npo2_ocurrencyamountTotal);
    $('#formAddEdit #txtpo1_dcurrencysums').val(npo2_dcurrencyamountTotal);

}



function DeletePO2_PODetail() {
    var dataSelectPO2_PODetail = $('#PO2_PODetailList_A').datagrid('getSelected');
    if (!dataSelectPO2_PODetail) {
        alert('请选择一行');
        return;
    }
    if (dataSelectPO2_PODetail.po2_state == "75") {
        alert('此数据已经完结无法删除');
        return;
    }


    var index = $('#PO2_PODetailList_A').datagrid('getRowIndex', dataSelectPO2_PODetail)
    $('#PO2_PODetailList_A').datagrid('deleteRow', index)
    TotalPrice();
}


function PODetailCopy() {
    //var dataSelectPO2_PODetail = $('#PO2_PODetailList_A').datagrid('getSelected');
    //if (!dataSelectPO2_PODetail) {
    //    alert('请选择需要复制的行');
    //    return;
    //}

    var PO2_PODetailList_AData = $('#PO2_PODetailList_A').datagrid('getData');
    if (PO2_PODetailList_AData.rows.length == 0) {
        alert('请选择需要复制的行');
        return;
    }

    var PODetailcheckdata = $('#PO2_PODetailList_A').datagrid('getChecked');


    for (k = 0; k < PODetailcheckdata.length; k++) {

        var nMaxId = 0;
        for (var i = 0; i < PO2_PODetailList_AData.rows.length; i++) {
            if (parseInt(PO2_PODetailList_AData.rows[i].po2_liseq) > nMaxId) {
                nMaxId = parseInt(PO2_PODetailList_AData.rows[i].po2_liseq);
            }
        }
        nMaxId++;

        $('#PO2_PODetailList_A').datagrid('appendRow',
           {
               po2_liseq: nMaxId,
               po2_lsseq: PODetailcheckdata[k].po2_lsseq,
               po2_pocode: PODetailcheckdata[k].po2_pocode,
               po2_dcurrencyamount: "0",
               po2_dcurrencyprice: PODetailcheckdata[k].po2_dcurrencyprice,
               po2_number: "0",
               po2_ocurrencyamount: "0",
               po2_ocurrencyprice: PODetailcheckdata[k].po2_ocurrencyprice,
               po2_pd1_supperiercolor: PODetailcheckdata[k].po2_pd1_supperiercolor,
               po2_pd1_supperiersize: PODetailcheckdata[k].po2_pd1_supperiersize,
               po2_pd1_supperierstyle: PODetailcheckdata[k].po2_pd1_supperierstyle,
               po2_plandeliverydate: PODetailcheckdata[k].po2_plandeliverydate,
               po2_purchasecurrency: PODetailcheckdata[k].po2_purchasecurrency,
               po2_state: PODetailcheckdata[k].po2_state,
               po2_unit: PODetailcheckdata[k].po2_unit,
               st2_sizegroup: PODetailcheckdata[k].st2_sizegroup,
               st3_st2_skccode: PODetailcheckdata[k].st3_st2_skccode,
               st3_size: PODetailcheckdata[k].st3_size
           });
    }
    TotalPrice();

}


//新增到货计划
function AddDeliveryplan() {

    var dataSelectPO2_PODetail = $('#PO2_PODetailList_A').datagrid('getChecked');
    if (dataSelectPO2_PODetail.length == 0) {
        alert('请选择采购明细');
        return;
    }

    //return;
    for (var i = 0; i < dataSelectPO2_PODetail.length; i++) {
        if (dataSelectPO2_PODetail[i].po2_id == undefined) {
            $.messager.alert("提示", "先保存采购明细！", 'error');
            return false;
        }
    }



    $('#DivAddDeliveryplan').window({
        title: "选择计划到货时间",
        top: 20,
        width: 300,
        height: 160,
        modal: true
    });

    $('#DivAddDeliveryplan  #txtDeliveryplanData').datebox({
        valueField: 'id',
        textField: 'text',
        required: true,
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd") }
    });
    $('#DivAddDeliveryplan  #txtDeliveryplanData').datebox("setValue", "")
}

function FormAddDeliveryplanSubmit() {


    $('#DivAddDeliveryplan').window('close');

    if ($('#DivAddDeliveryplan').form('validate') == false) {
        $.messager.alert("提示", "请填写到货计划时间！", 'error');
        return false;
    }

    var txtDeliveryplanData = $('#DivAddDeliveryplan #txtDeliveryplanData').datebox('getValue');

    var PODetailcheckdata = $('#PO2_PODetailList_A').datagrid('getChecked');

    for (i = 0; i < PODetailcheckdata.length; i++) {

        $('#AP1_APOHeadList').datagrid('appendRow',
       {
           ap1_apcode: "系统自动生成",
           st3_st1_stylecode: PODetailcheckdata[i].st2_st1_stylecode,
           ct1_keyname: PODetailcheckdata[i].ct1_keyname,
           st3_size: PODetailcheckdata[i].st3_size,
           ap2_aplannumber: PODetailcheckdata[i].po2_number,
           yrknum: "0",
           yscnum: "0",
           ap1_aplannumber: PODetailcheckdata[i].po2_number,
           ap1_aplandt: txtDeliveryplanData,//计划到货日期
           differences: PODetailcheckdata[i].po2_number,
           ap1_po1_purchasecode: PODetailcheckdata[i].po2_pocode, //采购单编号
           ap2_lsnumber: "000",
           ap2_linumber: PODetailcheckdata[i].po2_liseq,
           ap1_hstate: "15",
           ap1_lstate: "15",
           ap2_state: "15",
           st3_st2_skccode: PODetailcheckdata[i].st3_st2_skccode
       });
    }
    AddAPO();
}


function FormAddEditSubmit() {
    $('#formAddEdit').form('submit', {
        onSubmit: function (e) {
            if ($('#formAddEdit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            //$('#DivAddPODetail').window('close');

            $.messager.confirm('提示框', '是否确认提交', function (r) {
                if (r) {

                    var updateJSON = "";
                    $dg = $("#PO2_PODetailList_A");
                    if (!endEditing()) {
                        $.messager.alert("提示", "请把必填项填完！", 'error');
                        return;
                    }

                    var PO2_PODetailList_AData = $('#PO2_PODetailList_A').datagrid('getData');
                    //return;
                    for (var i = 0; i < PO2_PODetailList_AData.rows.length; i++) {
                        if (PO2_PODetailList_AData.rows[i].st3_size == undefined) {
                            $.messager.alert("提示", "先输入尺码！", 'error');
                            return false;
                        }
                    }

                    if (PO2_PODetailList_AData.rows.length >= 1) {
                        if (datagridCheckValueRepeat(PO2_PODetailList_A, [{ "name": "st3_st2_skccode" },
                                                                                         { "name": "st3_size" },
                                                                                         { "name": "po2_plandeliverydate" }],
                                                                                         true, true, true)) {
                        }
                        else {
                            return false;
                        }
                    }

                    if ($dg.datagrid('getChanges').length != 0) {
                        var inserted = $dg.datagrid('getChanges', "inserted");
                        var updated = $dg.datagrid('getChanges', "updated");
                        var deleted = $dg.datagrid('getChanges', "deleted");
                        updateJSON = GetEditJson(inserted, updated, deleted);
                    }


                    if ($('#formAddEdit #txtpo1_potypecode').val() == "E") {
                        $('#formAddEdit #txtpo1_potypename').val("家具家饰")
                    }
                    else {
                        $('#formAddEdit #txtpo1_potypename').val("服装童装配饰")
                    }


                    if ( $('#formAddEdit #txtpo1_pocode').val() !="") {
                        var AjaxBrandCode = $('#formAddEdit #txtpo1_br1_brandcode').combobox('getText')
                        if (AjaxBrandCode != "") {
                            XMLData = GetFormJson([], 'GETBRANDCODE');
                            htmlobj = $.ajax({
                                url: GetWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0'),
                                data: { "XML": XMLData, "WHERE": "BR1_Name='" + AjaxBrandCode + "'" },
                                type: 'post',
                                async: false
                            });
                            var result = $.parseJSON(htmlobj.responseText);
                            if (result.rows[0]['br1_brandcode'] != "") {
                                $('#formAddEdit #txtpo1_br1_brandcode').combobox("setValue", result.rows[0]['br1_brandcode']);
                            }
                        }
                    }
                    var data = $('#formAddEdit').serializeArray();
                    //data[data.length] = { "name": "txtpo1_exchangerate", "value": $('#formAddEdit #txtpo1_exchangerate').combobox("getValue") }
                    data[data.length] = { "name": "txtpo1_pocode", "value": $('#formAddEdit #txtpo1_pocode').val() }
                    data[data.length] = { "name": "txtpo1_hstate", "value": $('#formAddEdit #txtpo1_hstate').val() }
                    data[data.length] = { "name": "txtpo1_lstate", "value": $('#formAddEdit #txtpo1_lstate').val() }
                    data[data.length] = { "name": "txtpo1_ocurrencysums", "value": $('#formAddEdit #txtpo1_ocurrencysums').val() }
                    data[data.length] = { "name": "txtpo1_dcurrencysums", "value": $('#formAddEdit #txtpo1_dcurrencysums').val() }
                    data[data.length] = { "name": "txtpo1_pznumber", "value": $('#formAddEdit #txtpo1_pznumber').val() }
                    data[data.length] = { "name": "txtpo1_supplytax", "value": $('#formAddEdit #txtpo1_supplytax').val() }
                    //data[data.length] = { "name": "txtpo1_potypename", "value": $('#formAddEdit #txtpo1_potypename').val() }

                    data[data.length] = { "name": "txtPoDetail", "value": updateJSON, "specialCharset": true }

                    var XMLData = GetFormJson(data, 'EDIT');
                    //return;
                    $.messager.progress({ title: '请稍后', msg: '处理中' });
                    $.ajax({
                        url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                                    $('#PO1_POHeadList').datagrid("reload");
                                    $("#PO2_PODetailList_A").datagrid('reload');
                                    $.messager.alert("提示", result[0].rows[0].message + "保存成功");
                                    $('#formAddEdit #txtpo1_pocode').val(result[0].rows[0].message);
                                    $('#formAddEdit #txtpo1_potypecode').combobox('disable');
                                    InitGird_PO2_PODetail_B("PoDetail")








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


function DeleteAPO() {
    var dataSelectAP1_APOList = $('#AP1_APOHeadList').datagrid('getSelected');
    if (!dataSelectAP1_APOList) {
        alert('请选择一行');
        return;
    }
    var index = $('#AP1_APOHeadList').datagrid('getRowIndex', dataSelectAP1_APOList)
    $('#AP1_APOHeadList').datagrid('deleteRow', index)
}



function AddAPO() {
    if (!endEditingAP1_APOHeadList()) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return;
    }
    $dg = $("#AP1_APOHeadList");


    if ($dg.datagrid('getChanges').length == 0) {
        return;
    }

    var inserted = $dg.datagrid('getChanges', "inserted");
    var updated = $dg.datagrid('getChanges', "updated");
    var deleted = $dg.datagrid('getChanges', "deleted");
    updateJSON = GetEditJson(inserted, updated, deleted);
    var data = [];
    data[data.length] = { "name": "txtapo", "value": updateJSON, "specialCharset": true }
    var XMLData = GetFormJson(data, 'APO');
    $.messager.progress({ title: '请稍后', msg: '处理中' });
    //return;
    $.ajax({
        url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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

                    $('#AP1_APOHeadList').datagrid("reload");
                    $('#AP1_APOHeadList').datagrid("unselectAll");

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






function Cancel(type) {
    if (type == "A1") {
        $('#DivEdit').window('close');
    }
    else if (type == "A2") {
        $('#DivAddCDeliveryplan').window('close');
    }
}


function SelectSizeGroup(st2_sizegroup) {
    var dataParam = [];
    dataParam[dataParam.length] = { "name": "txtct1_code", "value": "SDGP" };
    dataParam[dataParam.length] = { "name": "txtct1_keyid ", "value": st2_sizegroup };
    url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&XML=" + GetFormJson(dataParam, 'GET2Level');

    htmlobj = $.ajax({
        url: url,
        async: false
    });
    SizeGroupData = $.parseJSON(htmlobj.responseText);
}



function EndAPO() {
    var dataSelectAPO = $('#AP1_APOHeadList').datagrid('getSelected');
    if (!dataSelectAPO) {
        alert('请选择需要完结的一行');
        return;
    }
    $.messager.confirm('提示框', '是否确认完结', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtap2_id", "value": dataSelectAPO.ap2_id }
            var XMLData = GetFormJson(data, 'ENDAPODTETAIL');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('47a9a2ce-92d8-4bea-800b-fabf87dd7850'),
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
                            $('#AP1_APOHeadList').datagrid("reload");
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



