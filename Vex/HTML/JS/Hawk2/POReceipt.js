/* 
创建人：刘洪 
创建日期：2014-04-18

修改人：刘洪
修改日期：2014-06-11
修改内容：JS代码规范

修改人：刘洪
修改日期：2014-11-07
修改内容：增加仓库选择

*/
var m_RgUser,m_SetIndex=undefined;
//定义一个变量用于记录是否是合格品
var m_type = undefined;
//定义两个变量m_SelectRow,m_SelectDetail.用于存放选中行的数据（head or detail）。这两个全局变量同时只能有一个有值。
var m_SelectRow = null, m_SelectDetail = null;
//存放表头的索引
var m_IndexHead = undefined;m_IndexDetail = undefined;

//初始化各类数据
$(document).ready(function () {
    $('#cmbSupplierCode').combobox({
        url: GetComboxWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae', "") + "&XML=" + GetFormJson([], 'cmbGetSupplier'),
        type: 'post',
        mode: 'remote',
        valueField: 'id',
        textField: 'text',
        panelHeight: '300',
        onSelect: function (rec) {
            var data = [];
            data[data.length] = { "name": "txtwhere", "value": rec.id };
            $('#cmbPOCode').combobox({
                url: GetComboxALLColumnWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae') + "&XML=" + GetFormJson(data, 'cmbGetPo'),
                type: 'post',
                valueField: 'id',
                textField: 'text',
                panelHeight: '300',
                onSelect: function (rec) {
                    $('#txtRgUser').val(rec.PO1_RgUser);
                    $('#txtSPPOCode').val(rec.PO1_SPPOCode);
                    var data = [];
                    data[data.length] = { "name": "txtwhere", "value": rec.id };
                    $('#cmbAPCode').combobox({
                        url: GetComboxWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae', "", "AP1_APCode", "AP1_APCode") + "&XML=" + GetFormJson(data, 'cmbGetAP'),
                        type: 'post',
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: '300'
                    });
                }
            });
        }
    });

    //初始化按钮
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnCallWindow').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
    $('#btnCallWindowOther').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
    $('#btnAudit').linkbutton({ iconCls: 'icon-ok', plain: true, disabled: true });

    //获取用户名
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.UserName != "") {
        m_RgUser = result.UserName;
    };

    //初始化收货窗口
    $('#winPOReceiptEdit').window({
        title: '收货扫描',
        maximized: true,
    }).window('close');

    //初始化扫描款式窗口
    $('#txtBarcode').keydown(function (e) {
        if (e.keyCode == 13) {
            scanSKU();
        };
    });

    //初始化收货窗口的按钮(保存审核，保存，取消)
    $('#btnSubmitSaveAudit').linkbutton({ iconCls: 'icon-ok', plain: true });

    $('#btnSubmitSave')
        .linkbutton({ iconCls: 'icon-save', plain: true })
        .click(function (event) {
            saveDate(m_type);
            event.stopPropagation();
        });

    $('#btnCancel')
        .linkbutton({ iconCls: 'icon-undo', plain: true })
        .click(function (event) {
            ClearGrid("#wintab_list");
            $('#winPOReceiptEdit').window('close');
        });

    //初始化datagrid
    $('#tab_list').datagrid({
        title: '查询结果',
        singleSelect: true,
        fit: true,
        columns: [[
            { field: 'po1_suppliercode', title: '供应商编号', width: 100, rowspan: 2 },
            { field: 'po1_pocode', title: '采购单号', width: 60, rowspan: 2 },
            { field: 'ap1_apcode', title: '到货计划编号', rowspan: 2, width: 100 },
            { title: '采购单', colspan: 3 },
            { title: '到货计划', colspan: 3 },
            { field: 'rp1_audituser', title: '更新人', rowspan: 2, width: 100 },
            { field: 'rp1_auditdt', title: '更新时间', rowspan: 2, width: 150, formatter: Formater.Date }
        ], [
            { field: 'po1_pznumber', title: '采购总数', align: 'right', width: 100, formatter: Formater.Nums },
            { field: 'posum', title: '已入库数', width: 70, align: 'right', formatter: Formater.Nums },
            { field: 'pocay', title: '数量差异', width: 70, align: 'right', formatter: Formater.Nums },
            { field: 'ap1_aplannumber', title: '到货计划总数', width: 100, align: 'right', formatter: Formater.Nums },
            { field: 'apsum', title: '已入库数', width: 100, align: 'right', formatter: Formater.Nums },
            { field: 'apcay', title: '数量差异', width: 70, align: 'right', formatter: Formater.Nums }
        ]],
        onClickRow: function (rowIndex, rowData) {
            var type = "head";
            m_SelectRow = rowData;
            m_SelectDetail = undefined;
            checkRowState(type, rowData);
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20 //默认一页数据条数
    });
});

//查询按钮方法--用于根据过滤条件进行查询的方法.
function Search() {
    //全局变量 置空
    m_IndexHead = undefined;m_IndexDetail = undefined;
    m_SelectRow = undefined; m_SelectDetail = undefined;

    var SearchData = $('#getPOReceipt').serializeArray();
    if (SearchData[0]["value"] == "" && SearchData[1]["value"] == "" && SearchData[2]["value"] == "" && SearchData[3]["value"] == "" && SearchData[4]["value"] == "") {
        alert('请输入查询条件');
    }
    else {
        ClearGrid("#tab_list");
        XMLData = GetFormJson(SearchData, 'Search');
        $('#tab_list').datagrid({
            url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
            queryParams: { "XML": XMLData },
            title: '查询结果',
            width: '90%',
            singleSelect: true,
            fit: true,
            sortName: 'po1_lmdt',
            sortOrder: 'desc',
            columns: [[
            { field: 'po1_suppliercode', title: '供应商编号', width: 100, rowspan: 2 },
            { field: 'po1_pocode', title: '采购单号', width: 60, rowspan: 2 },
            { field: 'ap1_apcode', title: '到货计划编号', rowspan: 2, width: 100 },
            { title: '采购单', colspan: 3 },
            { title: '到货计划', colspan: 3 },
            { field: 'po1_lmuser', title: '更新人', rowspan: 2, width: 100 },
            { field: 'po1_lmdt', title: '更新时间', rowspan: 2, width: 150, formatter: Formater.Date }
            //{ field: 'po1_lmdt', title: '时间', rowspan: 2, width: 150, hidden: true }
            ], [
            { field: 'po1_pznumber', title: '采购总数', align: 'right', width: 100, formatter: Formater.Nums },
            { field: 'posum', title: '库存数量', width: 70, align: 'right', formatter: Formater.Nums },
            { field: 'podiff', title: '数量差异', width: 70, align: 'right', formatter: Formater.Nums },
            { field: 'ap1_aplannumber', title: '到货计划总数', width: 100, align: 'right', formatter: Formater.Nums },
            { field: 'apsum', title: '库存数量', width: 100, align: 'right', formatter: Formater.Nums },
            { field: 'apdiff', title: '数量差异', width: 70, align: 'right', formatter: Formater.Nums }
            ]],
            onClickRow: function (rowIndex, rowData) {
                var type = "head";
                m_SelectRow = rowData;
                m_SelectDetail = undefined;
                checkRowState(type, rowData);
            },
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            onDblClickRow: function (rowIndex, rowData) {
                $("#tab_list").datagrid('expandRow', rowIndex);
            },
            view: detailview,
            detailFormatter: function (index, row) {
                return '<div style="padding:2px"><table id = "tab_Detail" class="ddv"></table></div>';
            },
            onExpandRow: function (index, row) {
                var ddv = $(this).datagrid('getRowDetail', index).find('table.ddv');
                m_IndexHead = index;    //存放表头索引

                var data = [];
                data[data.length] = { "name": "txtPo", "value": row.po1_pocode };
                data[data.length] = { "name": "txtAP", "value": row.ap1_apcode };

                XMLData = GetFormJson(data, 'onExpandRow');
                ddv.datagrid({
                    url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
                    queryParams: { "XML": XMLData },
                    fitColumns: true,
                    singleSelect: true,
                    rownumbers: true,
                    loadMsg: '',
                    remoteSort: false,
                    sortName: 'rp1_rgdt',
                    sortOrder: 'desc',
                    height: 'auto',
                    columns: [[
                        {title: '收货单信息',colspan:8}
                        ],[
                        { field: 'po1_pocode', title: '采购单编号', width: 40 },
                        { field: 'rp1_ap1_apcode', title: '到货计划编号', width: 60 },
                        { field: 'rp1_receiptcode', title: '收货单号', width: 60 },
                        { field: 'rp1_lstate', title: '状态', width: 20 },
                        //{ field: 'rp1_hstate', title: '最高状态', width: 20 },
                        //{ field: 'rp2_pd1_productcode', title: '商品SKU', width: 60 },
                        { field: 'rptype', title: '类型', width: 30 },
                        { field: 'rp2_number', title: '数量', width: 45, align: 'right' },
                        { field: 'rp1_rguser', title: '创建人', width: 45 },
                        { field: 'rp1_rgdt', title: '创建时间', width: 45 }
                    ]],
                    onClickRow: function (rowIndex, rowData) {
                        var type = "Detail";
                        m_IndexDetail = rowIndex;
                        m_SelectDetail = rowData;
                        m_SelectRow = undefined;
                        checkRowState(type, rowData);
                    },
                    onDblClickRow: function (rowIndex, rowData) {
                        if (rowData.rptype == "合格品" && rowData.rp1_lstate == "15") {
                            POReceiptWindows("Eligible");
                        }
                        else
                            if (rowData.rptype == "不合格品" && rowData.rp1_lstate == "15") {
                                POReceiptWindows("Failure");
                            }
                            else
                                if (rowData.rp1_lstate == "90") {
                                    POReceiptWindows("check");
                            };
                    },
                    onResize: function () {
                        $('#tab_list').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        setTimeout(function () {
                            $('#tab_list').datagrid('fixDetailRowHeight', m_IndexHead);
                        }, 0);
                    }
                });
            },
            onLoadSuccess: function () {
                if (m_IndexHead != undefined) {
                    $("#tab_list").datagrid('expandRow', m_IndexHead);
                    $('#tab_list').datagrid('selectRow', m_IndexHead);
                    $("#tab_list").datagrid('loaded');
                };
            }
        });
    };
};

//收货弹出框--弹出收货窗口,并根据选中的行进行数据查询.
function POReceiptWindows(type) {
    m_type = type;
    $('#POReceiptEdit').form('clear');
    var data = [];

    var xml = "";
    
    if (m_type == "Eligible" ){
        xml = "<ROOT><OPTYPE>cmbWareHouse</OPTYPE><LIST><ROWS><LocationCode>E12001</LocationCode></ROWS></LIST></ROOT>";
    }
    else{
        xml = "<ROOT><OPTYPE>cmbWareHouse</OPTYPE><LIST><ROWS><LocationCode>E13001</LocationCode></ROWS></LIST></ROOT>";
    };
    
    //仓库
    $('#cmbWareHouse').combobox({
        required: true,
        url: GetComboxWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e', "", "WH1_WareHouseCode", "WH1_Name") + "&XML=" + GetGetJson([], 'GetWH'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    if (m_SelectRow == undefined && m_SelectDetail == undefined) {
        alert('请选择一行');
        return;
    }
    else {
        if (m_type == 'Eligible') {
            $('#cmbFailure').combobox({ required: false });
            $('#cmbFailure').combobox('disable');
            //仓库
            $("#cmbWareHouse").combobox({ required: true, disabled: false });;

            $('#btnSubmitSaveAudit').show();
            $('#btnSubmitSave').show();
            $('#txtBarcode').show();
        }
        else if (m_type == 'Failure') {
            $('#cmbFailure').combobox({ required: true, disabled: false });
            $("#cmbWareHouse").combobox({ required: true });
            //仓库
            $("#cmbWareHouse").combobox({ required: true, disabled: false });;

            $('#btnSubmitSaveAudit').show();
            $('#btnSubmitSave').show();
            $('#txtBarcode').show();
        }
        else {
            $('#cmbFailure').combobox({ required: false });
            $("#cmbWareHouse").combobox({ required: false });
            $('#cmbFailure').combobox('disable');

            $('#btnSubmitSaveAudit').hide();
            $('#btnSubmitSave').hide();
            $('#txtBarcode').hide();
        };

        ClearGrid("#wintab_list");

        if (m_SelectDetail != undefined) {
            $('#txtReceiptCode').val(m_SelectDetail.rp1_receiptcode);
            $('#txtAPcode').val(m_SelectDetail.rp1_ap1_apcode);
            $('#txtPOcode').val(m_SelectDetail.po1_pocode);
            $('#txtSupplier').val(m_SelectDetail.po1_suppliercode);
            $('#txtPOrguser').val(m_SelectDetail.po1_rguser);
            $("#cmbWareHouse").combobox('setValue', m_SelectDetail.rp1_whsp_warehousepos);
            $('#cmbWareHouse').combobox('disable');
            $('#txtuser').val(m_RgUser);
            data[data.length] = { "name": "txtrpcode", "value": m_SelectDetail.rp1_receiptcode };
            XMLData = GetFormJson(data, 'winGetDetailOld'); //有收货单号
        }
        else {
            $('#txtReceiptCode').val('系统生成');
            $('#txtAPcode').val(m_SelectRow.ap1_apcode);
            $('#txtPOcode').val(m_SelectRow.po1_pocode);
            $('#txtSupplier').val(m_SelectRow.po1_suppliercode);
            $('#txtPOrguser').val(m_SelectRow.po1_rguser);
            $('#txtuser').val(m_RgUser);
            $('#txtBarcode').val("").focus();
            data[data.length] = { "name": "txtapcode", "value": m_SelectRow.ap1_apcode };
            data[data.length] = { "name": "txtpocode", "value": m_SelectRow.po1_pocode };
            XMLData = GetFormJson(data, 'winGetDetailNew');//无收货单号
        };

        if (m_type == 'Eligible') {
            $('#wintab_list').datagrid({
                url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
                queryParams: { "XML": XMLData },
                title: '查询结果',
                singleSelect: true,
                sortName: 'liseq',
                sortOrder: 'asc',
                fit: false,
                columns: [[
                    { field: 'code', title: '编号', width: 90 },
                    { field: 'liseq', title: '项次', width: 30, align: 'right', formatter: Formater.Nums },
                    { field: 'lsseq', title: '子项次', width: 50, align: 'right', formatter: Formater.Nums },
                    { field: 'skucode', title: '商品SKU', width: 120 },
                    { field: 'plannumber', title: '计划到货数量', width: 90, align: 'right', formatter: Formater.Nums },
                    { field: 'plandate', title: '计划到货日期', width: 100, formatter: Formater.Date },
                    { field: 'number', title: '已收货数量', width: 80, align: 'right', formatter: Formater.Nums },
                    { field: 'diff', title: '数量差异', width: 80, align: 'right', formatter: Formater.Nums },
                    { field: 'rp2_number', title: '本次到货数量', width: 80, align: 'right', editor: { type: 'numberbox' }, formatter: Formater.Nums }
                ]],
                onDblClickCell: function (rowIndex, field, value) {
                    onDblClickCell(rowIndex, field);
                },
                onClickCell: function (rowIndex, fild, value) {
                    endEditing();
                },
                pagination: false, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 50 //默认一页数据条数
            });
        }
        else {
            if (type != "check") {
                //初始化不合格原因码
                $('#cmbFailure').combobox({
                    url: GetComboxWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae') + "&XML=" + GetFormJson([], 'cmbGetFailure'),
                    type: 'post',
                    editable: false,
                    valueField: 'id',
                    textField: 'text',
                    panelHeight: 'auto'
                });
            }
            //初始化datagrid
            $('#wintab_list').datagrid({
                url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
                queryParams: { "XML": XMLData },
                title: '查询结果',
                singleSelect: true,
                fit: false,
                showFooter: true,
                onLoadSuccess: function (data) {
                    if (m_SelectDetail != null) {
                        $('#cmbFailure').combobox('setValue', data.rows[0].rp2_unqualifiedcode);
                        $('#cmbFailure').combobox('setText', data.rows[0].rp2_unqualifieddesp);
                    };

                },
                columns: [[
                    { field: 'code', title: '编号', width: 90 },
                    { field: 'liseq', title: '项次', width: 30, align: 'right', formatter: Formater.Nums },
                    { field: 'lsseq', title: '子项次', width: 50, align: 'right', formatter: Formater.Nums },
                    { field: 'skucode', title: '商品SKU', width: 120 },
                    { field: 'plannumber', title: '计划到货数量', width: 90, align: 'right', formatter: Formater.Nums },
                    { field: 'plandate', title: '计划到货日期', width: 100, formatter: Formater.Date },
                    { field: 'number', title: '已收货数量', width: 80, align: 'right', formatter: Formater.Nums },
                    { field: 'diff', title: '数量差异', width: 80, align: 'right', formatter: Formater.Nums },
                    { field: 'rp2_number', title: '本次到货数量', width: 80, align: 'right', editor: { type: 'numberbox' }, formatter: Formater.Nums },
                    { field: 'rp2_unqualifieddesp', title: '不合格原因', width: 80 }
                ]],
                onDblClickCell: function (rowIndex, field, value) {
                    if (m_type != "check") {
                        onDblClickCell(rowIndex, field);
                    }
                },
                onClickCell: function (rowIndex, fild, value) {
                    endEditing();
                },
                pagination: false, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 50 //默认一页数据条数
            });
        };
        $('#winPOReceiptEdit').window('open');
        $("#txtBarcode").focus();
    };
};

//扫描保存--用于保存待保存入库的数据,只保存在界面上
function scanSKU() {
    var sku = $('#txtBarcode').val();    //取得扫描款号
    var skuData = $('#wintab_list').datagrid('getData');
    if (sku == "") {
        alert('请扫描款号！');
        return;
    }
    else {
        sku = sku.toLocaleUpperCase();
        for (i = 0; i < skuData.total; i++) {
            if (sku == skuData.rows[i].skucode) {
                var oldNum = skuData.rows[i].rp2_number;
                if (oldNum == undefined) {
                    oldNum = 0;
                };
                $('#wintab_list').datagrid('updateRow', {
                    index: i,
                    row:
                    {
                        rp2_number: +oldNum + 1
                    }
                });
                $('#txtBarcode').val("");
                $("#txtBarcode").focus();
                return;
            };
        };
        alert('该到货计划无此SKU，请检查');
        $('#txtBarcode').val("");
        $("#txtBarcode").focus();
    };
};

//保存按钮方法--用于保存扫描后的数据，数据需要进行加工(去掉不相关数据并检查)
function saveDate(m_type, m_audit) {
    var bool = $('#formPOReceiptEdit').form('validate');
    if (!bool) {
        return;
    };
    var saveDate = $('#wintab_list').datagrid('getData');

    if (saveDate.total == 0) {
        $.messager.alert('提示', '无任何数据', 'error');
        return;
    };
    var sumThis = 0;
    var arrayHead = [];
    var arrayDetail = [];
    var unqualifiedCode = "";
    var unqualifiedDesp = "";

    //保存时检查本次收货单元格是否完成编辑
    if (m_SetIndex != undefined) {
        $('#wintab_list').datagrid('endEdit', m_SetIndex);
        m_SetIndex = undefined;
    };

    var receiptCode = $('#txtReceiptCode').val();

    for (i = 0; i < saveDate.total; i++) {
        if (saveDate.rows[i].rp2_number) {
            break;
        }
        else {
            if (i == saveDate.total - 1) {
                alert('本次保存无收货数量，请检查');
                return;
            };
        };
    };

    if (receiptCode == "系统生成") {
        receiptCode = "";
    };

    if (m_type == "Eligible") //根据类型选择储位
    {
        arrayHead[arrayHead.length] = { "name": "txtRP1_State", "value": "2" };
        arrayHead[arrayHead.length] = { "name": "txtRP1_SA1_LocationCode", "value": "E12001" };
    }
    else {
        arrayHead[arrayHead.length] = { "name": "txtRP1_SA1_LocationCode", "value": "E13001" };
        arrayHead[arrayHead.length] = { "name": "txtRP1_State", "value": "3" };
        unqualifiedCode = $('#cmbFailure').combobox('getValue');
        unqualifiedDesp = $('#cmbFailure').combobox('getText');
    };

    var j = 0;
    for (i = 0; i < saveDate.total; i++) {
        if (saveDate.rows[i].rp2_number) {
            //计划数量
            planNum = saveDate.rows[i].plannumber;
            //Detail
            arrayDetail[j] = { RP2_ID: "" };
            arrayDetail[j].RP2_CONO = "HYFG";
            arrayDetail[j].RP2_DIVI = "LX";
            arrayDetail[j].RP2_ReceiptCode = receiptCode;
            arrayDetail[j].RP2_LINumber = saveDate.rows[i].liseq;
            arrayDetail[j].RP2_LSNumber = saveDate.rows[i].lsseq;
            arrayDetail[j].RP2_PD1_ProductCode = saveDate.rows[i].skucode;
            arrayDetail[j].RP2_Number = saveDate.rows[i].rp2_number.toString();
            arrayDetail[j].RP2_MaterielState = "2";
            arrayDetail[j].RP2_UnqualifiedCode = unqualifiedCode;
            arrayDetail[j].RP2_UnqualifiedDesp = unqualifiedDesp;
            arrayDetail[j].RP2_State = "15";
            arrayDetail[j].RP2_AuditUser = "";
            arrayDetail[j].RP2_AuditDt = "";
            arrayDetail[j].RP2_RgDt = "";
            arrayDetail[j].RP2_RgUser = "";
            arrayDetail[j].RP2_LmDt = "";
            arrayDetail[j].RP2_LmUser = "";
            j++;
        };
    };

    for (i = 0; i < arrayDetail.length; i++) {
        sumThis += +arrayDetail[i].RP2_Number;
    };

    var zNumber = +planNum - sumThis;
    var wareHPos = $("#cmbWareHouse").combobox('getValue');
    arrayHead[arrayHead.length] = { "name": "txtRP1_ID", "value": "" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_CONO", "value": "HYFG" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_DIVI", "value": "LX" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_ReceiptCode", "value": receiptCode };
    arrayHead[arrayHead.length] = { "name": "txtRP1_PO1_POCode", "value": $('#txtPOcode').val() };
    arrayHead[arrayHead.length] = { "name": "txtRP1_AP1_APCode", "value": $('#txtAPcode').val() };
    arrayHead[arrayHead.length] = { "name": "txtRP1_WHSP_WarehousePOS", "value": wareHPos };
    arrayHead[arrayHead.length] = { "name": "txtRP1_WH1_WareHouseCode", "value": "W03" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_HState", "value": "15" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_LState", "value": "15" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_RgDt", "value": "" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_RgUser", "value": "" };
    arrayHead[arrayHead.length] = { "name": "txtRP1_Znumber", "value": zNumber };
    arrayHead[arrayHead.length] = { "name": "txtRP1_Rnumber", "value": sumThis };

    XMLDetail = GetEditJsonbyType(arrayDetail, 'InsertDetail');
    arrayHead[arrayHead.length] = { "name": "txtDetail", "value": XMLDetail };
    XMLData = GetFormJson(arrayHead, 'Insert');

    $.ajax({
        url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
        type: 'post',
        async: false, //异步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $('#txtReceiptCode').val(result[0].rows[0].message);
                    $('#txtBarcode').val("");
                    $("#txtBarcode").focus();
                    $('#tab_list').datagrid('reload');

                    //如果收货单号和不合格原因都不为空时
                    if (result[0].rows[0].message != "" && result[0].rows[1].message != "") {
                        refurbishData(result[0].rows[0].message);
                    };

                    //如果误审核则弹出消息框
                    if (m_audit == undefined) {
                        if (result[0].rows[1].message == "") {
                            $.messager.alert("提示", "保存成功，收货单号为:" + result[0].rows[0].message, 'ok');
                        }
                        else {
                            $.messager.alert("提示", "保存成功，收货单号为:" + result[0].rows[0].message + "<br />"
                            + "本收货单不合格原因修改为:" + result[0].rows[1].message);

                        };
                    };
                };
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
};

//检查datagrid数据行的状态--检查数据头与子行的状态，以便于控制收货按钮是否激活
function checkRowState(type, rowData) {
    if (type == "head") {
        $('#btnCallWindow').linkbutton('enable');
        $('#btnCallWindowOther').linkbutton('enable');
        $('#btnAudit').linkbutton('disable');
    }
    else {
        if (rowData.rptype == "合格品" && rowData.rp1_lstate == "15")              //合格品--未审核RP1_LState
        {
            $('#btnCallWindow').linkbutton('enable');
            $('#btnCallWindowOther').linkbutton('disable');
            $('#btnAudit').linkbutton('enable');
        }
        else if (rowData.rptype == "不合格品" && rowData.rp1_lstate == "15")      //不合格品--未审核RP1_LState
        {
            $('#btnCallWindow').linkbutton('disable');
            $('#btnCallWindowOther').linkbutton('enable');
            $('#btnAudit').linkbutton('enable');
        }
        else if (rowData.rp1_lstate == "90" || rowData.rp1_lstate == "")       //已审核或者空
        {
            $('#btnCallWindow').linkbutton('disable');
            $('#btnCallWindowOther').linkbutton('disable');
            $('#btnAudit').linkbutton('disable');
        };
    };
};

//审核按钮的方法
function btnAudit(m_recode) {
    var RECode;
    if (m_recode == '') {
        RECode = m_SelectDetail.rp1_receiptcode;
    } else {
        RECode = m_recode
    }
    
    var data = [];

    data[data.length] = { "name": "txt模块", "value": "POReceiptExamine" };
    data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
    data[data.length] = { "name": "txtDIVI", "value": "LX" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt单据号", "value": RECode };
    data[data.length] = { "name": "txt单据类型", "value": "RP" };
    data[data.length] = { "name": "txt操作员", "value": m_RgUser };

    XMLData = GetDBFrameAML(data);
    $.ajax({
        url: GetWSRRURL('17599562-408c-4e81-be17-050c1f623318') + XMLData,
        type: 'post',
        async: false, //异步
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');
                    $.messager.alert("提示", result[0].rows[0].msg, 'error');
                }
                else {
                    $('#tab_list').datagrid('loading');
                    $('#tab_list').datagrid('reload');
                    var message = result[0].rows[0].msg;
                    $.messager.alert("提示", message.substring(2, 8), 'ok');
                    $('#winPOReceiptEdit').window().window('close');
                }
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", result[0].rows[0].msg, 'error');
            };
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
};

//保存并审核方法
function saveAndAudit() {

    saveDate(m_type, 'Audit');
    
    var recode = $('#txtReceiptCode').val();
    if (recode == '系统生成') {
        $.messager.alert('错误', '审核失败', 'error');
    }
    else {
        $.messager.progress('close');
        btnAudit(recode);
    }
}

//编辑本次收货单元格的方法（2个）
function endEditing() {
    if (m_SetIndex == undefined) { return true };
    if ($('#wintab_list').datagrid('validateRow', m_SetIndex)) {
        $('#wintab_list').datagrid('endEdit', m_SetIndex);
        m_SetIndex = undefined;
        return true;
    } else {
        return false;
    }
}

function onDblClickCell(index, field) {
    if (endEditing()) {
        $('#wintab_list').datagrid('selectRow', index)
        .datagrid('editCell', { index: index, field: field });
        m_SetIndex = index;
    }
}

//用于刷新不合格品的数据
function refurbishData(RPCode) {
    var data = [];
    data[data.length] = { "name": "txtrpcode", "value": RPCode };
    XMLData = GetFormJson(data, 'winGetDetailOld'); //有收货单号
    ClearGrid("#wintab_list");

    //初始化不合格原因
    $('#cmbFailure').combobox({
        url: GetComboxWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae') + "&XML=" + GetFormJson([], 'cmbGetFailure'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    //初始化datagrid
    $('#wintab_list').datagrid({
        url: GetWSRRURL('bd146ce3-1968-4750-a5e3-89ba6ba571ae'),
        queryParams: { "XML": XMLData },
        title: '查询结果',
        singleSelect: true,
        fit: true,
        onLoadSuccess: function (data) {
            $('#cmbFailure').combobox('setValue', data.rows[0].rp2_unqualifiedcode);
            $('#cmbFailure').combobox('setText', data.rows[0].rp2_unqualifieddesp);
            m_SelectDetail = undefined; m_SelectRow = undefined;
        },
        columns: [[
            { field: 'code', title: '编号', width: 90 },
            { field: 'liseq', title: '项次', width: 30, align: 'right', formatter: Formater.Nums },
            { field: 'lsseq', title: '子项次', width: 50, align: 'right', formatter: Formater.Nums },
            { field: 'skucode', title: '商品SKU', width: 120 },
            { field: 'plannumber', title: '计划到货数量', width: 90, align: 'right', formatter: Formater.Nums },
            { field: 'plandate', title: '计划到货日期', width: 100, formatter: Formater.Date },
            { field: 'sumnumber', title: '已入库数量', width: 80, align: 'right', formatter: Formater.Nums },
            { field: 'diff', title: '数量差异', width: 80, align: 'right', formatter: Formater.Nums },
            { field: 'rp2_number', title: '本次到货数量', width: 80, align: 'right', editor: { type: 'numberbox' }, formatter: Formater.Nums },
            { field: 'rp2_unqualifieddesp', title: '不合格原因', width: 80 }
        ]],
        onDblClickCell: function (rowIndex, field, value) {
            onDblClickCell(rowIndex, field);
        },
        onClickCell: function (rowIndex, fild, value) {
            endEditing();
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 50 //默认一页数据条数
    });

    $('#winPOReceiptEdit').window('open');
    $("#txtBarcode").focus();
};
