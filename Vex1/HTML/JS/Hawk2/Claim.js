// 名称：Claim.js
// 说明：对ClaimHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-05-22
// 修改人：
// 修改日期：
// 修改内容： 4c49d3e9-60de-403e-885d-f04661e3ebcf 

var m_data = [],
       m_user = undefined,
       company = $.cookie("compName");

//存储主表中，主行与展开行的数据。两个变量同一时刻只能其中一个有值。
var m_headRow = undefined, m_detailRow = undefined;

//判断索赔类型
var m_type = "";

//获取换货datagrid选中行的索引号
var m_Index = undefined;

//初始化各类数据与按钮
$(document).ready(function () {
    //渲染页面各个按钮(查询，取消，退货，换货，折扣,窗口的增加，保存，取消)
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnReturn').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
    $('#btnReplace').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
    $('#btnDiscount').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
    $('#btnAdd').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#btnSave').linkbutton({ iconCls: 'icon-save', plain: true });
    $('#btnClose').linkbutton({ iconCls: 'icon-undo', plain: true });

$("#txtReturnWH").combobox({
        required: true,
        url: GetComboxWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e', "", "WH1_WareHouseCode", "WH1_Name") + "&XML=" + GetGetJson([], 'GetWH'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    $("#txtPutWH").combobox({
        required: false,
        url: GetComboxWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e', "", "WH1_WareHouseCode", "WH1_Name") + "&XML=" + GetGetJson([], 'GetWH'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });

    //退货时候使用
    $('#winWHok').linkbutton({ iconCls: 'icon-save', plain: true }).click(winWHok);

    $("#winWHCombobox").combobox({
        required: true,
        url: GetComboxWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e', "", "WH1_WareHouseCode", "WH1_Name") + "&XML=" + GetGetJson([], 'GetWH'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto'
    });
    //获取主界面DataGrid的数据
    initGird(GetGetJson([]));

    //初始化处理窗口
    $('#winContractEdit').window({
        width: 1000,
        height: 500,
        title: '索赔处理',
    	shadown: true,
        top: 10
    }).window('close');

    //初始化处理窗口
    $('#winWH').window({
        title:'仓库选择',
        width: 200,
        height: 150,
        collapsible: false,
        minimizable: false,
        maximizable:false,
        draggable: false,
        shadown: true,
        title: '索赔处理',
        top: 10
    }).window('close');
    //获取用户名
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    m_user = result.UserName;
});

//获取主界面DataGrid的数据
function initGird(XMLDate) {
    $('#tab_list').datagrid({
        url: GetWSRRURL('4c49d3e9-60de-403e-885d-f04661e3ebcf'),
        queryParams: { "XML": XMLDate },
        title: '索赔单列表',
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'cd1_rgdt',
        sortOrder: 'desc',
        columns: [[
            { field: 'cd1_id', hidden: true },
            { field: 'cd1_claimcode', title: '索赔单编号', width: 100 },
            { field: 'cd1_state', title: '索赔单状态', width: 65 },
            { field: 'cd1_claimtype', title:'处理结果', width:100 },
            { field: 'rp2_unqualifieddesp', title: '不合格原因', width: 100 },
            { field: 'cd1_po1_pocode', title: '采购单编号', width: 70 },
            { field: 'po1_suppliercode', title: '供应商编号', width: 70 },
            { field: 'sp1_name', title: '供应商名称', width: 70 },
            { field: 'cd1_rp1_receiptcode', title: '收货单号', width: 150 },
            { field: 'cd1_rguser', title: '创建人', width: 80 },
            { field: 'cd1_rgdt', title: '创建日期', width: 100, formatter: Formater.Date },
            { field: 'cd1_lmuser', title: '索赔处理人', width: 70 },
            { field: 'cd1_lmdt', title: '索赔处理日期', width: 100 }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex, rowData) {
            m_headRow = rowData;
            m_detailRow = undefined;
            btnControl();//判断按钮是否激活的方法
        },
        view: detailview,
        detailFormatter: function (index, row) {
            return '<div style="padding:2px"><table id = "tab_Detail" class="ddv"></table></div>';
        },
        onExpandRow: function (index, row) {
            var ddv = $(this).datagrid('getRowDetail', index).find('table.ddv');
            var data = [];
            data[data.length] = { "name": "txtClaimCode", "value": row.cd1_claimcode };
            XMLData = GetFormJson(data, 'onExpandRow');
            ddv.datagrid({
                url: GetWSRRURL('4c49d3e9-60de-403e-885d-f04661e3ebcf'),
                queryParams: { "XML": XMLData },
                fitColumns: true,
                singleSelect: true,
                rownumbers: true,
                loadMsg: '',
                height: 'auto',
                columns: [[
                    { title: '索赔信息', colspan: 7 }
                    ],[
                    { field: 'sk1_wh1_warehousecode', title: '仓库', width: 40 },
                    { field: 'sk1_sa1_locationcode', title: '储位', width: 60 },
                    { field: 'cd2_pd1_productcode', title: 'SKU', width: 100 },
                    { field: 'cd2_number', title: '索赔数量', width: 50, align: 'right' },
                    { field: 'cd2_po2_unit', title: '单位', width: 45 },
                    //{ field: 'st1_supperierstyle', title: '供应商款号', width: 100 },
                    { field: 'cd2_state', title: '状态', width: 40 },
                    { field: 'cd1_claimtype', title: '处理结果', width: 60,}    
                ]],
                onClickRow: function (rowIndex, rowData) {
                    m_detailRow = rowData;
                    m_headRow = undefined;
                    btnControl();//判断按钮是否激活的方法
                },
                onResize: function () {
                    $('#tab_list').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#tab_list').datagrid('fixDetailRowHeight', index);
                    }, 0);
                }
            });
        }
    });
};

//主界面取消按钮的方法
function btnCancel() {
    $('#getCondition input').val('');
};

//主界面查询按钮的方法
function btnSearch() {
    var data = $('#getCondition').serializeArray();
    XMLData = GetFormJson(data, 'GetSearch');
    initGird(XMLData);
};

//主界面弹窗按钮的控制方法（退货\换货\折价）
function btnControl() {
    if (m_headRow != undefined) {
        var status = m_headRow.cd1_state;
        if (status == "15") {
            $('#btnReturn').linkbutton('enable');
            $('#btnReplace').linkbutton('enable');
            $('#btnDiscount').linkbutton('enable');
        }
        else {
            $('#btnReturn').linkbutton('disable');
            $('#btnReplace').linkbutton('disable');
            $('#btnDiscount').linkbutton('disable');
        };
    }
    else {
        $('#btnReturn').linkbutton('disable');
        $('#btnReplace').linkbutton('disable');
        $('#btnDiscount').linkbutton('disable');
    };
};

//退货按钮的提发方法
function btnReturn() {
    if (m_headRow == undefined) {
        alert("请选中所要操作的行。");
    }
    else {
            $("#winWH").window('open');
    };
};
function winWHok() {
    var wh = $("#winWHCombobox").combobox('getValues');

    if (wh == "") {
        $.messager.alert("提示", "请选择仓库。", "warning");
        return;
    };
        var data = [];
	data[data.length] = { "name": "txtRT1_RetreatWareHouse", value: wh };
        data[data.length] = { "name": "txtClaimCode", value: m_headRow.cd1_claimcode };
        data[data.length] = { "name": "txtPOCode", value: m_headRow.cd1_po1_pocode };
        data[data.length] = { "name": "txtHandleType", value: "退货" };
        var XMLData = GetFormJson(data, "Handle");
	
	
	sumbitReturn(XMLData);
}
function sumbitReturn(XMLData) {
    $.ajax({
        url: GetWSRRURL('4c49d3e9-60de-403e-885d-f04661e3ebcf'),
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
                else
                    if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $("#winWH").window("close");
                        $.messager.alert("提示", result[0].rows[0].message);
                        ClearGrid("#tab_list");
                        initGird(GetGetJson([]));
                    }
            }
            catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "退货错误了！", 'error');
        }
    });
};

//折价、换货按钮呼出窗口的方法
function btnDisRep(type) {
    m_type = type;
    //获取前台数据
    var CliamCode = m_headRow.cd1_claimcode;
    var data = [];
    data[data.length] = { "name": "txtCliamCode", "value": CliamCode };
    XMLDate = GetFormJson(data, "GetWinData");
    if (m_type == "折价") {
        //初始化datagrid
        ClearGrid("#wintab_list");
        $('#wintab_list').datagrid({
            url: GetWSRRURL('4c49d3e9-60de-403e-885d-f04661e3ebcf'),
            queryParams: { "XML": XMLDate },
            title: '索赔商品信息',
            width: '90%',
            singleSelect: true,
            fit: true,
            columns: [[
                { field: 'cd2_po2_liseq', title: '项次', width: 35 },
                { field: 'cd2_po2_lsseq', title: '子项次', width: 45 },
                { field: 'cd2_pd1_productcode', title: '商品SKU', width: 100 },
                { field: 'cd2_number', title: '索赔数量', width: 65, align: 'right', formatter: Formater.Nums },
                { field: 'cd2_po2_unit', title: '单位', width: 40 },
                { field: 'cd2_po2_ocurrencyprice', title: '原币单价', width: 70, align: 'right', formatter: Formater.Account },
                { field: 'cd2_po2_ocurrencyrebateprice', title: '折后原币单价', width: 90, align: 'right', formatter: Formater.Account },
                { field: 'cd2_po2_ocurrencyamount', title: '原币金额', width: 70, align: 'right', formatter: Formater.Account },
                { field: 'cd2_po2_ocurrencyrebateamount', title: '折后原币金额', width: 90, align: 'right', formatter: Formater.Account },
                { field: 'cd1_po1_currency', title: '币种', width: 40 },
                { field: 'st1_largeclass', title: '大类', width: 50 },
                { field: 'st1_smallclass', title: '小类', width: 60 }
            ]],
            pagination: false, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20 //默认一页数据条数
        });
        //收货仓库
        $("#txtPutWH").combobox("setValues","").combobox({
            required: true,
            disabled:false
        });
        $("#txtReturnWH").combobox("setValues", "");
        //赋值
        $('#txtWinPO').val(m_headRow.cd1_po1_pocode);
        $('#txtWinClaimCode').val(m_headRow.cd1_claimcode);
        $('#txtWinRP').val(m_headRow.cd1_rp1_receiptcode);
        $('#txtMode').val('折价处理');
        $('#txtReplace').val('-');
        $('#txtDiscount').val('-');
        $('#txtPrice').val('');
        //窗口出现
        $('#winContractEdit').window('open');
        //焦点设置与锁单元格
        document.getElementById("txtReplace").disabled = true;
        document.getElementById("txtDiscount").disabled = true;
        document.getElementById("txtPrice").disabled = false;
        $('#txtPrice').focus();
    }
    else {
        //初始化datagrid
        ClearGrid("#wintab_list");
        $('#wintab_list').datagrid({
            url: GetWSRRURL('4c49d3e9-60de-403e-885d-f04661e3ebcf'),
            queryParams: { "XML": XMLDate },
            title: '索赔商品信息',
            width: '90%',
            singleSelect: true,
            fit: true,
            columns: [[
                { field: 'cd2_po2_liseq', title: '项次', width: 35 },
                { field: 'cd2_po2_lsseq', title: '子项次', width: 45 },
                { field: 'cd2_pd1_productcode', title: '商品SKU', width: 100 },
                { field: 'cd2_number', title: '索赔数量', width: 65, align: 'right', formatter: Formater.Nums },
                { field: 'cd2_po2_unit', title: '单位', width: 40 },
                { field: 'cd2_po2_ocurrencyprice', title: '原币单价', width: 70, align: 'right', formatter: Formater.Account },
                { field: 'sk1_pd1_productcode', title: '换货SKU', width: 100 },
                { field: 'sk1_usablenumber', title: '换货数量', width: 90, align: 'right', formatter: Formater.Nums },
                { field: 'cd2_po2_ocurrencyprice', title: '换货后单价', width: 70, align: 'right', formatter: Formater.Account },
                { field: 'st1_largeclass', title: '大类', width: 50 },
                { field: 'st1_smallclass', title: '小类', width: 60 }
            ]],
            onClickRow: function (rowIndex, rowData) { m_Index = rowIndex;},
            toolbar: [{
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () { btnRemove();}
            }],
            onLoadSuccess: function (data) {
                m_data = data;
                m_data.rows[0].sk1_pd1_productcode = "";
                m_data.rows[0].sk1_usablenumber = "";
            },
            pagination: false, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20 //默认一页数据条数
        });

        //收货仓库
        $("#txtPutWH").combobox({
            required: false,
            disabled: true
        });
        $("#txtReturnWH").combobox("setValues", "");
        //赋值
        $('#txtWinPO').val(m_headRow.cd1_po1_pocode);
        $('#txtWinClaimCode').val(m_headRow.cd1_claimcode);
        $('#txtWinRP').val(m_headRow.cd1_rp1_receiptcode);
        $('#txtMode').val('换货处理');
        $('#txtPrice').val('-');
        $('#txtReplace').val('');
        $('#txtDiscount').val('');
        //窗口出现
        $('#winContractEdit').window('open');
        //焦点设置与锁单元格
        document.getElementById("txtReplace").disabled = false;
        document.getElementById("txtDiscount").disabled = false;
        document.getElementById("txtPrice").disabled = true;
        $('#txtReplace').focus();
	m_type = "";
    };
};

//窗口增加按钮的方法
function btnAdd() {
    var mode = $('#txtMode').val(); //处理方式
    var data = $('#wintab_list').datagrid('getData');
    if (mode == '折价处理') {
        var price = $('#txtPrice').val();//折后单价
        if (price == "") {
            alert('请输入折后单价');
            $('#txtPrice').focus();
        }
        else {
            var claimNum = data.rows[0].cd2_number;//索赔数量
            var offMoney = +claimNum * price //折后原币金额
            $('#wintab_list').datagrid('updateRow', {
                index: 0,
                row:
                {
                    cd2_po2_ocurrencyrebateprice: price,
                    cd2_po2_ocurrencyrebateamount: offMoney
                }
            });
        };
    }
    else {
        var sku = $('#txtReplace').val(); //换货SKU
        var num = $('#txtDiscount').val();//换货数量
        if (sku != "" && num != "") {
            if (parseInt(num) <= parseInt(data.rows[0].cd2_number)) {
                if (data.rows.length - 1 == 0 && data.rows[0].sk1_pd1_productcode == "") {
                    $('#wintab_list').datagrid('updateRow', {
                        index: 0,
                        row:
                        {
                            sk1_pd1_productcode: sku,
                            sk1_usablenumber: num
                        }
                    });
                    $('#txtReplace').val('');
                    $('#txtDiscount').val('');
                    $('#txtReplace').focus;
                }
                else {
                    $('#wintab_list').datagrid('appendRow', {
                        cd2_po2_liseq: data.rows[0].cd2_po2_liseq,
                        cd2_po2_lsseq: data.rows[0].cd2_po2_lsseq,
                        cd2_pd1_productcode: data.rows[0].cd2_pd1_productcode,
                        cd2_number: data.rows[0].cd2_number,
                        cd2_po2_unit: data.rows[0].cd2_po2_unit,
                        cd2_po2_ocurrencyprice: data.rows[0].cd2_po2_ocurrencyprice,
                        sk1_pd1_productcode: sku,
                        sk1_usablenumber: num,
                        cd2_po2_ocurrencyprice: data.rows[0].cd2_po2_ocurrencyprice,
                        st1_largeclass: data.rows[0].st1_largeclass,
                        st1_smallclass: data.rows[0].st1_smallclass
                    })
                    $('#txtReplace').val('');
                    $('#txtDiscount').val('');
                    $('#txtReplace').focus;
                };
            }
            else {
                alert('您输入的换货数量已超过索赔数量，请检查');
                $('#txtDiscount').focus();
            }
        }
        else {
            alert('请检查款号与数量是否填写');
            $('#txtReplace').focus();
        };
    };
};

//窗口保存按钮的方法,type代表传过来的是换货，还是让步接收
function btnSave() {
    var getData = $('#wintab_list').datagrid('getData');
    var price = getData.rows[0].cd2_po2_ocurrencyprice;                //原币单价
    
    var salePrice = getData.rows[0].cd2_po2_ocurrencyrebateprice;        //折后原币单价
    var claimCode = $('#txtWinClaimCode').val();                         //索赔单号
    var data = [];
    if (m_type == "折价") {
        if (salePrice == "") {                                              //检查是否折价为0
            alert('请输入折后原币单价');
            $('txtPrice').focus();
            return;
        };
        var whReturn = $("#txtReturnWH").combobox("getValues");
        var whPut = $("#txtPutWH").combobox("getValues");
        data[data.length] = { "name": "txt退货仓库", "value": whReturn };
        data[data.length] = { "name": "txt收货仓库", "value": whPut };
        data[data.length] = { "name": "txt模块", "value": "ConcessionReceive" };
        data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
        data[data.length] = { "name": "txtDIVI", "value": company};
        data[data.length] = { "name": "txtCONO", "value": "HYFG" };
        data[data.length] = { "name": "txt合格库位", "value": "W03" };
        data[data.length] = { "name": "txt合格储位", "value": "E12001" };
        data[data.length] = { "name": "txt索赔单号", "value": claimCode };
        data[data.length] = { "name": "txt原采购单价", "value": price };
        data[data.length] = { "name": "txt折后采购单价", "value": salePrice };
        data[data.length] = { "name": "txt操作员", "value": m_user };

    }
    else {
        //生成子表
        var dataDetail = [];
        for (i = 0; i < getData.rows.length; i++) {
            dataDetail[i] = { 'SKU': getData.rows[i].sk1_pd1_productcode };
            dataDetail[i].NUM = getData.rows[0].sk1_usablenumber;
        }
        var data1 = GetExcelXML(dataDetail);
        var whReturn = $("#txtReturnWH").combobox("getValues");
        data[data.length] = { "name": "txt退货仓库", "value": whReturn };
        //生成主表
        data[data.length] = { "name": "txt模块", "value": "Alternative" };
        data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
        data[data.length] = { "name": "txtDIVI", "value": company };
        data[data.length] = { "name": "txtCONO", "value": "HYFG" };
        data[data.length] = { "name": "txt索赔单号", "value": claimCode };
        data[data.length] = { "name": "txt原采购单价", "value": price };
        data[data.length] = { "name": "txt折后采购单价", "value": salePrice };
        data[data.length] = { "name": "txt操作员", "value": m_user };
        data[data.length] = { "name": "txt款式列表", "value": data1 };
        data[data.length] = { "name": "txt合格库位", "value": "W03" };
        data[data.length] = { "name": "txt合格储位", "value": "E12001" };
    };

    //调用后台API
    XMLData = GetDBFrameAML(data);
    $.ajax({
        url: GetWSRRURL('c8b84f5d-4170-4af0-9bb1-97279257af65') + XMLData,
        type: 'post',
        async: false, //异步
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                var message = result[0].rows[0].msg;
                var messageArr = message.split(":");
                if (result[0].Error) {
                    $.messager.progress('close');
                    $.messager.alert("系统错误", result[0].Error, 'error');
                }
                else if (messageArr[0] == 9) {
                    $.messager.progress('close');
                    $.messager.alert("提示", messageArr[1], 'error');
                }
                else {
                    initGird(GetGetJson([]));
                    $('#winContractEdit').window('close');
                    m_type = "";
                    
                    $.messager.alert("提示", messageArr[1], 'ok');
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

//窗口取消按钮的方法
function btnClose() {
    $('#getCondition input').val('');
    ClearGrid("#wintab_list");
    $('#winContractEdit').window('close');
};

//弹出窗DataGrid删除按钮的方法
function btnRemove() {
    if (m_Index == undefined) {
        alert('请选中需要删除的行');
        return;
    }
    else
        if (m_Index == 0) {
            $('#wintab_list').datagrid('updateRow', {
                index: 0,
                row:
                {
                    sk1_pd1_productcode: "",
                    sk1_usablenumber: ""
                }
            });
        }
    else {
            $('#wintab_list').datagrid('deleteRow', m_Index);
            m_Index = undefined;
    };
};
