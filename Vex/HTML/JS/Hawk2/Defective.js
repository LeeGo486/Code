// 名称：Defective.js
// 说明：对DefectiveHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-06-19
// 修改人：
// 修改日期：
// 修改内容：2244a2d9-56fe-4adc-95fb-12af7f472e5c

//检查编辑的全局变量
var m_editIndex = undefined; m_StyleCode = undefined;

//初始化页面
$(document).ready(function () {
    //渲染页面，窗口各个按钮(筛选，清空，申请，标签打印，查询,保存，取消，打印)
    $('#btnMainSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnMainCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnMainCreate').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#btnMainPrint').linkbutton({ iconCls: 'icon-print', plain: true });
    $('#btnWinSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnWinSave').linkbutton({ iconCls: 'icon-save', plain: true });
    $('#btnWinPrint').linkbutton({ iconCls: 'icon-print', plain: true });
    $('#btnWinCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnWinCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    //渲染两个窗口（申请窗口、打印窗口）
    $('#winCreate').window({
        title: '降级品申请',
        top: 10,
        width: 900,
        height: 550,
        modal: true
    }).window('close');
    $('#winPrint').window({
        title: '降级品打印',
        top: 10,
        width: 600,
        height: 400,
        modal: true
    }).window('close');


    //格式化日期样式:yyyy-mm-dd
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + m + '-' + d;
    };

    //渲染下拉框日期控件
    $('#txtSour').combobox({ panelHeight: 'auto', editable: false });
    $('#txtdatStatDay').datebox();
    $('#txtdatEndDay').datebox();

    //初始化DataGrid
    initGird(GetGetJson([]));
});

//初始化Dg
function initGird(XMLData) {
    $('#mainTab_List').datagrid({
        url: GetWSRRURL('2244a2d9-56fe-4adc-95fb-12af7f472e5c'),
        queryParams: { "XML": XMLData },
        title: '降级品列表',
        singleSelect: true,
        fit: true,
        sortName: 'dd1_rgdt',
        sortOrder: 'desc',
        columns: [[
            { field: 'dd1_st1_stylecode', title: '款号', width: 150, rowspan: 2 },
            { field: 'dd1_st2_color', title: '颜色', width: 50, rowspan: 2 },
            //{ title: '尺码', colspan: 10 },
            { field: 'sumqty', title: '合计', width: 50, rowspan: 2, formatter: Formater.Nums, align: 'right' },
            { field: 'dd1_sources', title: '来源', width: 100, rowspan: 2 },
            { field: 'dd1_demotereason', title: '降级原因', width: 200, rowspan: 2 },
            { field: 'dd1_rguser', title: '申请人', width: 100, rowspan: 2 },
            { field: 'dd1_rgdt', title: '申请时间', width: 100, rowspan: 2, formatter: Formater.Date }
        ]],
        onDblClickRow: function (rowIndex, rowData) {
            $("#mainTab_List").datagrid('expandRow', rowIndex);
        },
        view: detailview,
        detailFormatter: function (index, row) {
            return '<div style="padding:2px"><table id = "tab_Detail" class="ddv"></table></div>';
        },
        onExpandRow: function (index, row) {
            var ddv = $(this).datagrid('getRowDetail', index).find('table.ddv');
            var data = [];
            data[data.length] = { "name": "txtStyleCode", "value": row.dd1_st1_stylecode };
            data[data.length] = { "name": "txtColor", "value": row.dd1_st2_color };
            data[data.length] = { "name": "txtSources", "value": row.dd1_sources };
            data[data.length] = { "name": "txtRgDt", "value": row.dd1_rgdt };

            XMLData = GetFormJson(data, 'onExpandRow');
            ddv.datagrid({
                url: GetWSRRURL('2244a2d9-56fe-4adc-95fb-12af7f472e5c'),
                queryParams: { "XML": XMLData },
                fitColumns: true,
                singleSelect: true,
                rownumbers: true,
                loadMsg: '',
                remoteSort: false,
                sortName: 'dd1_st3_size',
                height: 'auto',
                columns: [[
                    { title: '编码情况', colspan: 4 }
                ], [
                    { field: 'dd1_st1_stylecode', title: '款号', width: 100 },
                    { field: 'dd1_st2_color', title: '颜色', width: 50 },
                    { field: 'dd1_st3_size', title: '尺码', width: 40 },
                    { field: 'dd1_demotebarcode', title: '吊牌条码', width: 100 }
                ]]
            });
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20 //默认一页数据条数
    });
};

//打开窗口，type：降级品申请（Create），打印（Print）
function OpenWindow(type) {
    if (type == "Create") {
        bgCreate();//窗口
        $('#winCreate').window('open');
        $('#txtWinStyle').val("").focus();
        ClearGrid("#winNew_List");
    }
    else {
        $('#winPrint').window('open');
    }
};

//初始化降级品申请页面的DataGrid
function bgCreate() {
    $('#winNew_List').datagrid({
        title: '查询结果',
        fit: true,
        columns: [[
            { field: 'dd1_id', hidden: true },
            { field: 'dd1_cono', hidden: true },
            { field: 'dd1_divi', hidden: true },
            { field: 'st2_st1_stylecode', title: '款号', width: 150 },
            { field: 'st2_color', title: '颜色', width: 50 },
            { field: 'all', title: '合计', width: 50 },
            { field: 'dd1_sources', title: '来源', width: 100 },
            { field: 'dd1_demotereason', title: '降级原因', width: 200, editor: 'text' },
            { field: 'dd1_rguser', hidden: true },
            { field: 'dd1_rgdt', hidden: true },
            { field: 'dd1_lmdt', hidden: true },
            { field: 'dd1_lmuser', hidden: true }
        ]]
    });
    var data = new dgCombVal(); //生成一个下拉框值的对象

    col = $('#winNew_List').datagrid('getColumnOption', 'dd1_sources');
    col.editor = {
        type: 'combobox', options: { data: data.name, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
};

//查询按钮的方法
function btnWinSearch(psytleCode) {
    var styCode = psytleCode;
    if (styCode == "") {
        styCode = $('#txtWinStyle').val();
    } else {
        styCode = m_StyleCode;
    };
    //检查是否输入款号
    if (styCode == "") {
        $('#txtWinStyle').focus();
        alert('请输入款号');
        return;
    };

    var data = [];
    data[data.length] = { "name": "txtStyleCode", "value": styCode };
    m_StyleCode = $('#txtWinStyle').val();
    XMLData = GetFormJson(data, 'GetSKC');

    $.post(GetWSRRURL('2244a2d9-56fe-4adc-95fb-12af7f472e5c') + "&XML=" + XMLData + "&MultiTable=true", function (data) {
        var result = eval('(' + data + ')');

        var size = result[0];
        var SKCData = result[1];

        var sizeNum = size.rows.length;

        var sizeCol = "";
        for (i = 0; i < sizeNum; i++) {
            if (i < sizeNum - 1)
                sizeCol += "{ field: 'size" + size.rows[i].ct1_keyid + "', title: '" + size.rows[i].ct1_keyname + "', width: 30, editor: 'numberbox' },";

            if (i == sizeNum - 1)
                sizeCol += "{ field: 'size" + size.rows[i].ct1_keyid + "', title: '" + size.rows[i].ct1_keyname + "', width: 30, editor: 'numberbox' }";

        };

        var columns1 = "[[{ field: 'st2_st1_stylecode', title: '款号', width: 150, rowspan: 2 },{ field: 'st2_color', title: '颜色', width: 50, rowspan: 2 },"

        columns1 += "{field:'st2_sizegroup',title:'尺码组', width: 100, rowspan: 2},"
        columns1 += "{ title: '尺码', colspan: "+sizeNum+" },{ field: 'sumqty', title: '合计', width: 50, rowspan: 2, formatter: Formater.Nums, align: 'right' },";
        columns1 += "{ field: 'dd1_sources', title: '来源', width: 100, rowspan: 2 },{ field: 'dd1_demotereason', title: '降级原因', width: 200, rowspan: 2, editor: 'text' }],";
        columns1 += "[" + sizeCol + "]]";

        columns1 = eval(columns1);

        $('#winNew_List').datagrid({
            title: '查询结果',
            async: false,
            fit: true,
            data: SKCData,
            columns: columns1,
            onClickCell: function (index, field) {
                //检查field是否是需要编辑的单元格
                if (field == 'st2_st1_stylecode' || field == 'st2_color' || field == 'all') {
                    endEditing();
                    return;
                }
                if (endEditing()) {
                    $('#winNew_List')
                            .datagrid('beginEdit', index)
                            .datagrid('selectRow', index)
                            .datagrid('editCell', { index: index, field: field });
                    m_editIndex = index;
                    if (field != 'dd1_sources' && field != 'dd1_demotereason') {
                        count(index, field);
                    };
                };
            },
            onClickRow: function (rowIndex, rowData) {
                count(rowData);
            }
        });
        var data = new dgCombVal(); //生成一个下拉框值的对象

        col = $('#winNew_List').datagrid('getColumnOption', 'dd1_sources');
        col.editor = {
            type: 'combobox', options: { data: data.name, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
        };
    });
}



//创建一个下拉框值的方法
function dgCombVal() {
    dgCombVal.prototype = {
        name: [{ "id": "供应商", "text": "供应商" }, { "id": "店铺", "text": "店铺" }]
    }
};

//结束编辑的方法
function endEditing() {
    if (m_editIndex == undefined) { return true };
    if ($('#winNew_List').datagrid('validateRow', m_editIndex)) {
        $('#winNew_List').datagrid('endEdit', m_editIndex);
        m_editIndex = undefined;
        return true;
    } else {
        return false;
    };
};

//计算合计的方法
function count(index, filed) {
    //var value = $('#winNew_List').datagrid().Rows[index].Cells[filed].value
};

//保存降级品申请
function btnWinSave() {
    if (endEditing()) {
        var updated = $('#winNew_List').datagrid('getChanges', "updated");
        XMLData = GetEditJsonbyType(updated, "SetDefective");
        $.messager.confirm('提示框', '确认提交吗？', function (r) {
            if (r) {
                $.ajax({
                    url: GetWSRRURL('2244a2d9-56fe-4adc-95fb-12af7f472e5c'),
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
                                    $.messager.alert("提示", result[0].rows[0].message);
                                    $('#txtWinStyle').val("").focus();
                                    ClearGrid("#winNew_List");
                                    ClearGrid("#mainTab_List");
                                    btnWinSearch(m_StyleCode);
                                    $('#mainTab_List').datagrid('reload');
                                }
                        }
                        catch (ex) {
                            $.messager.progress('close');
                            $.messager.alert("提示", ex, 'error');
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "降级品错误了！", 'error');
                    }
                });
            };
        });
    }
};

//清空查询条件
function btnClear() {
    $('#fSearch').form('clear');
};

//主界面查询按钮方法
function btnMainSearch() {
    var data = $('#fSearch').serializeArray();

    //检查输入条件
    if (data[0].value == "" && data[1].value == "" && data[2].value == "" && data[3].value == "" && data[4].value == "") {
        alert("请输入查询条件");
        return;
    };
    if ((data[3].value != "" && data[4].value == "") || (data[3].value == "" && data[4].value != "")) {
        alert("请检查日期是否正确");
        return;
    };

    XMLData = GetFormJson(data, 'GetSearch');
    initGird(XMLData);
};

//打印查询降级品款号方法
function entPrintSearch() {
    var data = $('#fPrintSearch').serializeArray();

    //检查是否输入款号
    if (data[1].value == "") {
        alert("请输入正品SKU");
        $('#txtPriStyCode').val("").focus();
        return;
    };
    XMLData = GetFormJson(data, 'GetPrintSearch');

    $.ajax({
        url: GetWSRRURL('2244a2d9-56fe-4adc-95fb-12af7f472e5c'),
        type: 'post',
        async: false, //异步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].rows[0].dd1_demotesku == "") {
                    $('#DemoteSKU').val(result[0].rows[0].dd1_demotesku);
                    $('#DemoteBarcode').val(result[0].rows[0].dd1_demotebarcode);
                    $('#txtPriStyCode').focus();
                    alert("输入的SKU无数据，请检查");

                }
                else {
                    $('#DemoteSKU').val(result[0].rows[0].dd1_demotesku);
                    $('#DemoteBarcode').val(result[0].rows[0].dd1_demotebarcode);
                    $('#tt').focus();
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

//文本框回车事件
function disableEnter(event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        entPrintSearch();
    };
};

//打印取消按钮的方法
function btnPrintSearch() {
    $('#fPrintSearch input').val("");
    $('#winPrint').window('close');
};

//打印按钮方法

function btnPrint() {

    var code = $('#DemoteBarcode').val();
    var codeSKU = $('#DemoteSKU').val();
    //-----------------Print Start----------------
    LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");

    LODOP.PRINT_INITA("0mm", "0mm", "50mm", "23mm", "");
    LODOP.SET_PRINT_PAGESIZE(1, 500, 450, "");
    LODOP.ADD_PRINT_BARCODE("3.7mm", "5.6mm", "30.4mm", "10.3mm", "Code93", code);
    LODOP.SET_PRINT_STYLEA(0, "ShowBarText", 0);
    LODOP.ADD_PRINT_TEXT(57, 13, 148, 26, codeSKU + "三等品");


    LODOP.PREVIEW();    //浏览模式
    //LODOP.PRINT_DESIGN();//设计模式
    //-----------------Print End--------------------
};