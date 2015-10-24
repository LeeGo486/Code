/* 
创建人：刘洪 
创建日期：2014-04-18

修改人：刘洪
修改日期：2014-06-11
修改内容：d26b9e47-9859-4491-9593-df50056bf9e5

*/

//命名空间
var GVARIABLE = {};

GVARIABLE.edit = {
    'editIndex': 'undefined',
    'rowData': 'null',
    'rowIndex': 'undefined',
    'num': 'undefined',//订购数量（旧）
    'UP': 'undefined' //单价
};

GVARIABLE.cmb = { 'data': '', 'data1': '' };

GVARIABLE.datagrid = {
    'lowStatus': undefined,
    'highStatus': undefined,
    'dgRowCount': undefined,
}
/***------------
    初始化类
-------------***/
$(document).ready(function () {
    //格式化日期样式:yyyy-mm-dd
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();

        if (m < 10) {
            m = '0' + m;
        };
        if (d < 10) {
            d = '0' + d;
        }
        return y + '-' + m + '-' + d;
    };
    //初始化按钮

    //一层
    $('#btnMNew').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#btnMmodify').linkbutton({ iconCls: 'icon-edit', plain: true });
    $('#btnShowDetail').linkbutton({ iconCls: 'icon-attach', plain: true });
    $('#btnmainSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnMainCancel').linkbutton({ iconCls: 'icon-undo', plain: true });

    //二层
    $('#btnSave').linkbutton({ iconCls: 'icon-save', plain: true });
    $('#btnCancel').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnCNew').linkbutton({ iconCls: 'icon-add', plain: true });
    $('#btnCDelete').linkbutton({ iconCls: 'icon-cancel', plain: true });

    //三层
    $('#btnSKUSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    $('#btnSKUClean').linkbutton({ iconCls: 'icon-undo', plain: true });
    $('#btnSKUSure').linkbutton({ iconCls: 'icon-ok', plain: true });
    $('#btnSKUCancel').linkbutton({ iconCls: 'icon-undo', plain: true });

    //初始化combobox
    $('#MCode').combobox();
    $('#CCode').combobox();

    //大小类
    $('#SKUGenBig').combobox();
    $('#SKUGenSmall').combobox();

    //供应商品牌联动
    $('#SKUBrand').combobox({ required: false });

    //年份
    $('#SKUYearStart').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });
    $('#SKUYearEnd').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "YEAR" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //季节
    $('#SKUSeason').combobox({
        url: GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "SSON" + "'",
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text'
    });

    //供应商
    $('#SKUSupplier').combogrid({
        panelWidth: 200,
        url: GetWSRRURL('d15d8c7d-4eb5-47c8-a2ba-fe3b95bb811b') + "&XML=" + GetFormJson([], 'SupplierInfo'),
        idField: 'sp1_suppliercode',
        textField: 'sp1_name',
        mode: 'remote',
        required: false,
        columns: [[
                { field: 'sp1_suppliercode', title: '供应商编号', width: 80 },
                { field: 'sp1_name', title: '供应商简称', width: 80 }
        ]],
        onLoadSuccess: function () {
            $('#SKUSupplier').combogrid('setValue', 'A0000');
            $('#SKUBrand').combobox('setValue', 'GL');
        },
        onChange: function () {
            var selectBrand = $('#SKUSupplier').combobox('getValue');
            init_Select_Brand(selectBrand);//取供应商编号联动品牌
        }
    });

    //加载品类combobox下拉
    $('#SKUGen').combobox({
        url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "CT1_OptionsValues", "CT1_Options") + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITCL" + "'",
        panelHeight: '120',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: false,
        onLoadSuccess: function (data) {
            $('#SKUGen').combobox('setValue', 'A');
            $('#SKUGenBig').combobox({
                url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGR" + "' and CT1_FatherID='58641a49-100c-47f5-9bda-10bafa223d41'",
                panelHeight: '120',
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: false,
                async: false,//同步,
                onSelect: function (data) {
                    //加载小类combobox下拉
                    var data = $.ajax({
                        url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGL" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                        type: 'post',
                        async: false//同步,
                    });
                    var data1 = $.parseJSON(data.responseText)
                    $('#SKUGenSmall').combobox({
                        data: data1,
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto',
                        editable: false
                    });

                    if (data1.length == 0 || data1[0].id == "") {
                        $('#SKUGenSmall').combobox({ required: false, readonly: true })
                        //$('#SKUGenSmall').combobox({ required: false })
                        //$('#SKUGenSmall').combobox('disable')
                    }
                    else {
                        $('#SKUGenSmall').combobox({ required: false, readonly: false })
                        //$('#SKUGenSmall').combobox({ required: false })
                        //$('#SKUGenSmall').combobox('enable')
                    }
                }
            });
        },
        onSelect: function (data) {
            //加载大类combobox下拉
            $('#SKUGenBig').combobox({
                url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGR" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                panelHeight: '120',
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: false,
                async: false,//同步,
                onSelect: function (data) {
                    //加载小类combobox下拉
                    var data = $.ajax({
                        url: GetComboxALLColumnWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0') + "&pagerows=20000&XML=" + GetFormJson([], 'GET') + "&Where=CT1_Code='" + "ITGL" + "' and CT1_FatherID='" + data.CT1_ID + "'",
                        type: 'post',
                        async: false//同步,
                    });
                    var data1 = $.parseJSON(data.responseText)
                    $('#SKUGenSmall').combobox({
                        data: data1,
                        valueField: 'id',
                        textField: 'text',
                        panelHeight: 'auto',
                        editable: false
                    });

                    if (data1.length == 0 || data1[0].id == "") {
                        $('#SKUGenSmall').combobox({ required: false,readonly:true })
                        //$('#SKUGenSmall').combobox({'readonly':true})
                    }
                    else {
                        $('#SKUGenSmall').combobox({ required: false, readonly: false })
                        //$('#SKUGenSmall').combobox({ required: false })
                        //$('#SKUGenSmall').combobox('enable')
                    }
                }
            });
        }
    });

    //初始化客户代号
    client();

    //主界面客户代号
    $('#MCCode').combobox({
        data: GVARIABLE.cmb.data1,
        valueField: 'id',
        textField: 'text',
        required: false,
        panelHeight: 'auto',
        editable: false,
        onSelect: function (data) {
            $('#MCName').val(data.Name);
        }
    });

    //初始化日期控件
    $('#MSDate').datebox();
    $('#MEDate').datebox();
    $('#newCDate').datebox({ required: true });

    //初始化窗口
    $('#createWin').window().window('close');
    $('#SKUWin').window().window('close');
    $('#detailWin').window().window('close');

    //初始化主界面数据
    mainGird(GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'), GetGetJson([], 'GetCOHead'));
});

//编辑单元格方法
function editCell() {
    $.extend($.fn.datagrid.methods, {
        editCell: function (jq, param) {
            return jq.each(function () {
                var opts = $(this).datagrid('options');
                var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
                for (var i = 0; i < fields.length; i++) {
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor1 = col.editor;
                    if (fields[i] != param.field) {
                        col.editor = null;
                    }
                }
                $(this).datagrid('beginEdit', param.index);
                for (var i = 0; i < fields.length; i++) {
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor = col.editor1;
                }
            });
        }
    });
};

//联动加载品牌数据
function init_Select_Brand(selectBrand) {
    var url = GetComboxWSRRURL('93837c9f-7fba-49a6-abc2-5fc950d26ff0', "", "BR1_BrandCode", "BR1_Name") + "&pagerows=20000&XML=" + GetFormJson([], 'GETBRAND')
        + "&Where=BR1_SupplierCode='" + selectBrand + "'";
    htmlobj = $.ajax({
        url: url,
        async: false
    });

    //通过加盟商数据，加载品牌下拉
    var select_Brand = $.parseJSON(htmlobj.responseText);
    $('#SKUBrand').combobox({
        data: select_Brand,
        panelHeight: 'auto',
        required: true,
        editable: false,
        valueField: 'id',
        textField: 'text'
    });
};

//加载SKU数据
function initGird(url, XMLData) {
    $('#SKUData').datagrid({
        title: 'SKU信息',
        url: url,
        queryParams: { "XML": XMLData },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        selectOnCheck: false, //关闭checkbox单个选择
        checkOnSelect: true, //开启checkbox多个选择
        fit: true,
        pagination: true, //是否开启分页
        pageSize: 10, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'st3_id', title: 'SKUID', width: 100, hidden: true },
            { field: 'st2_imagepath', title: '款图' },
            { field: 'st3_skucode', title: '款号', width: 150, search: true, sortable: true },
            { field: 'st1_unit', title: '单位', width: 100, search: true, sortable: true },
            { field: 'st2_saleprice', title: '吊牌价', width: 100, search: true, sortable: true, formatter: Formater.Account },
            { field: 'st1_currency', title: '币种', width: 100 }
        ]]
    });
    var $dg = $('#SKUData');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'st2_imagepath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    }
};

//加载主界面数据
function mainGird(url, XMLData) {
    $('#mainData').datagrid({
        title: '上货计划信息',
        url: url,
        queryParams: { "XML": XMLData },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        fit: true,
        sortName: 'code',
        sortOrder: 'desc',
        pagination: true, //是否开启分页
        pageSize: 10, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
            { field: 'coid', hidden: true },
            { field: 'code', title: '上货计划编号', width: 150 },
            { field: 'deliverydate', title: '货期', width: 100, align: 'right', formatter: Formater.Date },
            { field: 'sumnumber', title: '订单数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'posumnumber', title: '下单数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'resumnumber', title: '订单数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'minstate', title: '最低状态', formatter: Formater.Num, align: 'right' },
            { field: 'maxstate', title: '最高状态', formatter: Formater.Num, align: 'right' },
            { field: 'coamount', title: '订单金额', width: 100, align: 'right', formatter: Formater.Account },
            { field: 'currency', title: '币种', width: 80 },
            { field: 'rguser', title: '创建人', width: 80 },
            { field: 'rgdt', title: '创建时间', formatter: Formater.Date, width: 120, align: 'right' },
            { field: 'lmuser', title: '修改人', width: 80 },
            { field: 'lmdt', title: '修改时间', formatter: Formater.Date, width: 120, align: 'right' }
        ]]
    });
};

//客户代号数据加载
function client() {
    GVARIABLE.cmb.data = $.ajax({
        url: GetComboxALLColumnWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5') + "&pagerows=20000&XML=" + GetFormJson([], 'cmbGetCUS'),
        type: 'post',
        async: false//同步,
    });
    GVARIABLE.cmb.data1 = $.parseJSON(GVARIABLE.cmb.data.responseText);
};

//新建界面的客户代号
function cmbCCode() {
    $('#newCCode').combobox({
        data: GVARIABLE.cmb.data1,
        valueField: 'id',
        textField: 'text',
        required: true,
        panelHeight: 'auto',
        editable: false,
        onSelect: function (data) {
            $('#newCName').val(data.Name);
        }
    });
};



/***------------
    主界面类
------------***/
//新建按钮
function newPlanMain() {
    //初始化表头
    iniHead();

    //初始化按钮
    btnControl('系统生成');

    //初始化数据
    newPlanData('系统生成', null);
    ClearGrid('#createData');

    //出货日期
    $('#newCDate').datebox('setValue', '');

    //新建界面客户代号
    cmbCCode();

    //初始化编辑单元格
    editCell();

    //打开窗口
    $('#createWin').window({
        maximized: true,
        title: '操作上货计划'
    }).window('open');
};

//修改按钮
function btnModify() {
    var data = $('#mainData').datagrid('getSelected');

    if (data == null) {
        $.messager.alert('提示', '请选中一行', 'warning');
        return;
    };

    if (data.minstate != '15') {
        $.messager.alert('提示', '请选中状态为15的行', 'warning');
        return;
    };

    //初始化表头
    $('#newPlanNo').val(data.code);
    $('#newLowStatus').val(data.minstate);
    $('#newHighStatus').val(data.maxstate);
    $('#newPlanQuan').val(data.sumnumber);
    $('#newPlanAmount').val(data.coamount);
    $('#newCDate').datebox('setValue', data.deliverydate);
    $('#newID').val(data.coid);

    //客户代号
    cmbCCode();
    //客户代号赋值
    $('#newCCode').combobox('setText', data.cus1_code);
    $('#newCName').val(data.name);
    //最低高状态
    GVARIABLE.datagrid.lowStatus = data.minstate;
    GVARIABLE.datagrid.highStatus = data.maxstate;

    //初始化表体
    var data1 = [];
    data1[data1.length] = { 'name': 'newPlanNo', 'value': data.code };
    XMLData = GetFormJson(data1, 'GetCreateDate');
    ClearGrid('createData');
    newPlanData(data.code, XMLData);

    //打开窗口
    $('#createWin').window({
        maximized: true,
        title: '操作上货计划'
    }).window('open');
};

//下单明细按钮
function btnPlanDetail() {
    var data = $('#mainData').datagrid('getSelected');

    if (data == null) {
        $.messager.alert('提示', '请选中一行', 'warning');
        return;
    };

    var data1 = [];
    data1[data1.length] = { 'name': 'txtCOCode', 'value': data.code };
    XMLData = GetFormJson(data1, 'PlanDetail');

    $('#detailData').datagrid({
        url: GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'),
        queryParams: { "XML": XMLData },
        singleSelect: true,
        async: false, //同步,
        sortName: 'coseq',
        fit: true,
        columns: [[
            { title: '上货计划', colspan: 7 },
            { title: '采购单', colspan: 6 }
        ], [
            { field: 'coseq', title: '项次', width: 60 },
            { field: 'cosubseq', title: '子项次', width: 60 },
            { field: 'mara_code', title: 'SKU', width: 130 },
            { field: 'st2_imagepath', title: '款图', width: 100 },
            { field: 'conumber', title: '订购数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'coponumber', title: '下单数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'corenumber', title: '入库数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'po2_pocode', title: '采购单号', width: 100, formatter: Formater.Num },
            { field: 'poseq', title: '项次', width: 60, rowspan: 2 },
            { field: 'posubseq', title: '子项次', width: 60, rowspan: 2 },
            { field: 'currency', title: '币种', width: 60 },
            { field: 'ponumber', title: '采购数量', width: 80, align: 'right', formatter: Formater.Num },
            { field: 'porenumber', title: '入库数量', width: 80, align: 'right', formatter: Formater.Num }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20 //默认一页数据条数
    });

    var $dg = $('#detailData');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'st2_imagepath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    }

    //打开窗口
    $('#detailWin').window({
        maximized: true,
        title: 'SKU选择',
    }).window('open');
}

//查询按钮
function btnMainSearch() {
    var data = $('#mainSearch').serializeArray();
    if (data[0].value == "" && data[1].value == "" && data[2].value == "" && data[3].value == "") {
        ClearGrid('mainData');
        mainGird(GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'), GetGetJson([], 'GetCOHead'));
    } else {
        if (data[3].value != "") {
            data[data.length] = { "name": "CusCode", "value": $('#MCCode').combobox('getText') };
        } else {
            data[data.length] = { "name": "CusCode", "value": '' };
        }
        XMLData = GetFormJson(data, 'CoSearch');
        mainGird(GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'), XMLData);
    }

}


//取消按钮
function btnCancel() {
    $('#mainSearch input').val('');
}



/***------------
    二层界面类
------------****/


//初始化表头
function iniHead() {
    $('#newPlanNo').val('系统生成');
    $('#newLowStatus').val('90');
    $('#newHighStatus').val('90');
    $('#newPlanQuan').val('0');
    $('#newPlanAmount').val('0');
    $('#newCName').val('');
    GVARIABLE.datagrid.lowStatus = '90';
    GVARIABLE.datagrid.highStatus = '90';
};

//新建页面中按钮的控制
function btnControl(PlanNo) {
    if (PlanNo == '系统生成') {
        $('#btnSave').linkbutton({ iconCls: 'icon-save', plain: true, disabled: false });
        $('#btnCancel').linkbutton({ iconCls: 'icon-undo', plain: true, disabled: false });
        $('#btnCNew').linkbutton({ iconCls: 'icon-add', plain: true, disabled: true });
        $('#btnCDelete').linkbutton({ iconCls: 'icon-cancel', plain: true, disabled: true });
    } else {
        $('#btnSave').linkbutton({ iconCls: 'icon-save', plain: true, disabled: false });
        $('#btnCancel').linkbutton({ iconCls: 'icon-undo', plain: true, disabled: false });
        $('#btnCNew').linkbutton({ iconCls: 'icon-add', plain: true, disabled: false });
        $('#btnCDelete').linkbutton({ iconCls: 'icon-cancel', plain: true, disabled: false });
    };
};

//新建界面数据加载
function newPlanData(planNo, XMLData) {
    var url;
    if (planNo == '系统生成') {
        url = 'url';
    } else {
        url = GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5');
    };

    $('#createData').datagrid({
        title: 'SKU列表',
        url: url,
        queryParams: { "XML": XMLData },
        singleSelect: true,
        async: false, //同步,
        sortName: 'seq',
        fit: true,
        columns: [[
            { field: 'id', hidden: true },
            { field: 'seq', title: '项次', width: 60, rowspan: 2 },
            { field: 'subseq', title: '子项次', width: 60, rowspan: 2 },
            { field: 'mara_id', hidden: true },
            { field: 'mara_code', title: 'SKU', width: 130 },
            { field: 'st2_imagepath', title: '款图', width: 100 },
            { field: 'number', title: '订购数量', width: 100, editor: 'numberbox' },
            { field: 'unit', title: '单位', width: 60 },
            { field: 'price', title: '吊牌价', width: 100, align: 'right', formatter: Formater.Account },
            { field: 'state', title: '状态', width: 60, formatter: Formater.Num },
            { field: 'currency', title: '币种', width: 60 },
            { field: 'deliverydate', title: '出货日期', width: 100, formatter: Formater.Date },
            { field: 'rowtag', title: '数据情况', width: 100 }
            //{ field: 'l', title: 'SKUID', hidden: false, width: 100,hidden:true }
        ]],
        onLoadSuccess: function (data) {
            //存入初始表行数
            GVARIABLE.datagrid.dgRowCount = data.total;
            if (data.total > '0') {
                for (i = 0; i <= data.total - 1; i++) {
                    $('#createData').datagrid('updateRow', {
                        index: i,
                        row: {
                            rowtag: 'old',
                        }
                    });
                }
            }
        },
        onClickRow: function (rowIndex, rowData) {
            GVARIABLE.edit.rowData = rowData;
            GVARIABLE.edit.rowIndex = rowIndex;
            GVARIABLE.edit.num = rowData.number;
            GVARIABLE.edit.UP = rowData.price;
        },
        onClickCell: onClickCell,
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20 //默认一页数据条数
    });

    //款图代码
    var $dg = $('#createData');
    var col = undefined;
    col = $dg.datagrid('getColumnOption', 'st2_imagepath');
    if (col != null) {
        col.formatter = function (value) {
            var strs = new Array(); //定义一数组 
            strs = value.split(","); //字符分割 
            var date = "<a href='" + strs[0] + "' target='_blank'><img  src='" + strs[0] + "' style='height:60px'/></a>";
            this.formatDataType = "Pic";
            return date;
        }
    }
};

//新增按钮
function btnNewSKU() {
    //初始化查询条件
    btnClean();

    //清空SKUData
    //ClearGrid("#SKUData");

    //打开窗口
    $('#SKUWin').window({
        maximized: true,
        title: 'SKU选择',
    }).window('open');
};

//关闭按钮
function btnClose() {
    //清空数据
    ClearGrid('#createData');
    //初始化表头
    iniHead();
    //关闭窗口
    $('#createWin').window('close');
};

//删除按钮
function btnDelete() {

    var getData = GVARIABLE.edit.rowData;
    if (getData == 'null') {
        //rowData没数据保证rowIndex也没有数据
        GVARIABLE.edit.rowIndex = undefined;
        $.messager.alert('提示', '请选中一行状态为15的数据', 'warning');
    } else {
        $.messager.confirm('提示框', '确认删除该行吗？', function (r) {
            if (r) {
                if (getData.state == '15') {
                    $('#createData').datagrid('deleteRow', GVARIABLE.edit.rowIndex);

                    //删除后计算总金额与总数量
                    countNumAmount('删除');
                    updateStatus();

                    //初始化变量
                    GVARIABLE.edit.rowData = 'null';
                    GVARIABLE.edit.rowIndex = 'undefined';
                }
                else {
                    $.messager.alert('提示', '请选中一行状态为15的数据', 'warning');
                };
            };
        });
    };
};

//保存按钮
function newPlanSave() {
    if (!($('#newHead').form('validate'))) { return; };
    //结束编辑
    endEditing();

    //表头数据
    var headData = $('#newHead').serializeArray();
    //增加客户代码
    headData[headData.length] = { "name": "newCode", "value": $('#newCCode').combobox('getText') };

    var planNo = headData[0].value;
    if (planNo == '系统生成') {
        XMLData = GetFormJson(headData, 'SaveHead');
    } else {
        var detaili = $('#createData').datagrid('getChanges', "inserted");
        var detailu = $('#createData').datagrid('getChanges', "updated");
        var detaild = $('#createData').datagrid('getChanges', "deleted");

        var detail = detaili;
        for (var i = 0; i < detaili.length; i++) {
            detaili[i].rowtag = 'new';
        }
        for (var i = 0; i < detailu.length; i++) {
            detailu[i].rowtag = 'edit';
            detail[detail.length] = detailu[i];
        }
        for (var i = 0; i < detaild.length; i++) {
            detaild[i].rowtag = 'delete';
            detail[detail.length] = detaild[i];
        }
        detailXML = GetEditJsonbyType(detail, "SaveALL");
        headData[headData.length] = { "name": "xmlDetail", "value": detailXML };
        XMLData = GetFormJson(headData, 'SaveALL');
    };
    //提交
    $.ajax({
        url: GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'),
        type: 'post',
        async: false, //同步,
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
                    $.messager.alert("提示", result[0].rows[0].message, 'ok');
                    $('#newPlanNo').val(result[0].rows[1].message);
                    if ($('#newPlanNo').val() != '系统生成') {
                        //新建按钮开启
                        btnControl(result[0].rows[1].message);
                        //表头赋值
                        $('#newCCode').combobox('setText', result[0].rows[2].message);
                        $('#newCCode').combobox('disable');
                        $('#newID').val(result[0].rows[3].message);
                        //重刷表体
                        data = [];
                        data[data.length] = { 'name': 'newPlanNo', 'value': result[0].rows[1].message };
                        XMLData = GetFormJson(data, 'GetCreateDate');
                        var planno = result[0].rows[1].message;
                        ClearGrid('createData');
                        newPlanData(planno, XMLData);
                        //重刷主表
                        $('#mainData').datagrid('reload');
                        //更新状态
                        GVARIABLE.datagrid.lowStatus = $('#newLowStatus').val();
                        GVARIABLE.datagrid.highStatus = $('#newHighStatus').val();
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

//结束编辑单元格
function endEditing() {

    if (GVARIABLE.edit.editIndex == 'undefined') { return true };
    if ($('#createData').datagrid('validateRow', GVARIABLE.edit.editIndex)) {
        $('#createData').datagrid('endEdit', GVARIABLE.edit.editIndex);
        //计算金额与数量
        countNumAmount('修改');
        //修改标志位
        //if (GVARIABLE.edit.rowData.rowtag == 'old')
        //$('#createData').datagrid('updateRow', {
        //    index: GVARIABLE.edit.editIndex,
        //    row: { rowtag: 'edit' }
        //});
        GVARIABLE.edit.editIndex = undefined;
        return true;
    } else {
        return false;
    }
};

//开始编辑单元格
function onClickCell(index, field) {
    if (GVARIABLE.edit.rowData != null) {
        if (GVARIABLE.edit.rowData.state == '15') {
            if (endEditing()) {
                $('#createData').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
                GVARIABLE.edit.editIndex = index;
            };
        };
    };
};

//计算总数量与总金额
function countNumAmount(type) {
    if (type == '修改') {
        if (GVARIABLE.edit.editIndex == GVARIABLE.edit.rowIndex) {
            //选中行旧数据
            var numOld = GVARIABLE.edit.num;
            //修改后的数据
            var numNew = GVARIABLE.edit.rowData.number;
            //新旧数据之差
            var numChange = numNew - numOld;
            //已有总数据(旧)
            var numSumOld = $('#newPlanQuan').val();
            //已有总数据（新）
            var numSumNew = +numSumOld + numChange;

            //金额变化
            var amountSumChange = +numChange * GVARIABLE.edit.UP;
            //金额总数(旧)
            var amountSumOld = $('#newPlanAmount').val();
            //金额总数(新)
            var amountSumNew = +amountSumOld + amountSumChange;
            //赋值数量
            $('#newPlanQuan').val('');
            $('#newPlanQuan').val(numSumNew);
            //复制金额
            $('#newPlanAmount').val('');
            $('#newPlanAmount').val(amountSumNew);
            //赋值币种
            if ($('#newCurrency').val() == '') {
                $('#newCurrency').val(GVARIABLE.edit.rowData.currency);
            };
        };
    } else {
        //删除的数据
        var numChange = GVARIABLE.edit.num;
        //已有总数据(旧)
        var numSumOld = $('#newPlanQuan').val();
        //已有总数据（新）
        var numSumNew = +numSumOld - numChange;

        //金额变化
        var amountSumChange = +numChange * GVARIABLE.edit.UP;
        //金额总数(旧)
        var amountSumOld = $('#newPlanAmount').val();
        //金额总数(新)
        var amountSumNew = +amountSumOld - amountSumChange;

        //赋值数量
        $('#newPlanQuan').val('');
        $('#newPlanQuan').val(numSumNew);
        //复制金额
        $('#newPlanAmount').val('');
        $('#newPlanAmount').val(amountSumNew);
    }

};

//计算最低高状态
function updateStatus() {
    //现有行数
    var rowsCount = $('#createData').datagrid('getRows');

    if (GVARIABLE.datagrid.dgRowCount == 0) {
        if (rowsCount.length == GVARIABLE.datagrid.dgRowCount) {
            $('#newLowStatus').val('90');
            $('#newHighStatus').val('90');
        };
    } else {
        if (rowsCount.length == 0) {
            $('#newLowStatus').val('90');
            $('#newHighStatus').val('90');
        } else {
            //还原状态
            $('#newLowStatus').val(GVARIABLE.datagrid.lowStatus);
            $('#newHighStatus').val(GVARIABLE.datagrid.highStatus);
        };
    };
};






/***-------------
   三层界面类
-------------***/

//SKU关闭按钮
function btnCloseSKU() {
    //清空查询条件
    btnClean();
    //清空残留SKU数据
    ClearGrid("#SKUData");
    //关闭窗口
    $('#SKUWin').window('close');
};

//SKU查询按钮
function btnSearch() {
    var searchData = $('#SKUSearch').serializeArray();
    
    searchData[7].value = $('#SKUGenSmall').combobox('getText');

    if ((searchData[0].name != "" && searchData[1].name == "") || (searchData[0].name == "" && searchData[1].name != "")) {
        alert("请将年份选择完整");
        return false;
    };

    XMLData = GetFormJson(searchData, 'getSKUData');
    initGird(GetWSRRURL('d26b9e47-9859-4491-9593-df50056bf9e5'), XMLData);
}

//SKU清空按钮
function btnClean() {
    $('#SKUYearStart').combobox('setValue', '');
    $('#SKUYearEnd').combobox('setValue', '');
    $('#SKUBrand').combobox('setValue', '');
    $('#SKUGen').combobox('setValue', '');
    $('#SKUGenBig').combobox('setValue', '');
    $('#SKUGenSmall').combobox('setValue', '');
    $('#SKUSeason').combobox('setValue', '');
    $('#SKUSupplier').combogrid('setValue', 'A0000');
    $('#SKUBrand').combobox('setValue', 'GL');
    $('#SKUGen').combobox('setValue', 'A');
};

//----------------------------Begin--------------------------

//===SKU插入到创建界面===

// SKU确定按钮
function btnSKUSumbit() {
    var insertData = [];
    insertData = $('#SKUData').datagrid('getChecked');
    if (insertData.length == 0) {
        alert('请选择需要新增的SKU');
        return;
    } else {
        var status = checkSKUData(insertData)
        if (status[0] == true) {
            insData(insertData, GVARIABLE.datagrid.dgRowCount);
            btnCloseSKU();
            return;
        }
        else { alert('SKU重复或币种不同，请检查'); return; }
    };
};

//数据校验
function checkSKUData(data) {
    var createData = $('#createData').datagrid('getData');
    if (createData.total == '0') {
        return [true, createData.total];
    } else {
        for (i = 0; i <= createData.total - 1; i++) {
            for (j = 0; j <= data.length - 1 ; j++) {
                if ((data[j].st3_skucode == createData.rows[i].mara_code) || (createData.rows[i].currency != data[j].st1_currency)) {
                    return [false, ''];
                };
            };
        };
        return [true, createData.total];
    };
};

//插入数据
function insData(data, rows) {
    var insertRow = rows;
    for (i = 0; i <= data.length - 1; i++) {
        $('#createData').datagrid('insertRow', {
            index: insertRow,
            row: {
                seq: insertRow + 1,
                subseq: '0',
                mara_code: data[i].st3_skucode,
                st2_imagepath: data[i].st2_imagepath,
                number: '0',
                unit: data[i].st1_unit,
                price: data[i].st2_saleprice,
                state: '15',
                currency: data[i].st1_currency,
                deliverydate: $('#newCDate').datebox('getValue'),
                rowtag: 'new',
                mara_id: data[i].st3_id
            }
        });
        insertRow++;
    };
    //更新最低、高状态
    $('#newLowStatus').val('15');
    if ($('#newHighStatus').val() == '90') {
        $('#newHighStatus').val('15')
    };
};

//----------------------------End--------------------------