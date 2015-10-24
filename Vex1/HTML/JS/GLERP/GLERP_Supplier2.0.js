//var lastTabs;
var selected_Row;
var RowId;
var editIndex = undefined;


//初始化
$(function () {

    InitGird();

    //validatebox验证框初始化，只能输入数字与“-”
    $.extend($.fn.validatebox.defaults.rules, {
        positive_int: {
            validator: function (value, param) {
                if (value) {
                    return /^[0-9\-]*$/.test(value);
                }
            },
            message: '不符规则,请输入数字或"-".'
        }
    });

//    $('#sea_Seachbox').searchbox({
//        width: 200,
//        searcher: function (value, name) {
//            alert(value + "," + name)
//        },
//        menu: '#mm',
//        prompt: 'Please Input Value'
//    });
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title: '供应商列表', //表格标题
            url: GetWSRRURL('fa0a7e7e-1bcc-4572-ad93-794784c3b276'),
            queryParams: { "XML": GetGetJson([{ "entity": "entity"}]) },

            //            idField: 'ws_id', //标识字段,主键
            iconCls: '', //标题左边的图标
            width: '90%', //宽度
            //            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            //            collapsible: false, //可折叠
            sortOrder: 'desc', //排序类型
            //            remoteSort: false, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            {field: 'su0_suppliercode', title: '供应商编号', width: 70, search: true, sortable: true },
                { field: 'su0_suppliername', title: '供应商名称', width: 150, search: true, sortable: true, editor: { type: 'text'} },
                { field: 'dc0_dictname1', title: '类型', width: 60, search: true, sortable: true },
                { field: 'su0_status', title: '状态', width: 80, search: true, sortable: true }

			]],
            columns: [[
                { field: 'su0_cono', title: '公司', width: 60, hidden: true, search: false },
                { field: 'su0_divi', title: '事业体', width: 60, hidden: true, search: false },
                { field: 'su0_suppliertype', title: '供应商类型ID', width: 60, search: false, hidden: true },
                { field: 'su0_address', title: '供应商地址', width: 160, sortable: true, search: true, editor: { type: 'text'} },
                { field: 'su0_contact', title: '联系人', width: 100, sortable: true, search: true, editor: { type: 'text'} },
                { field: 'su0_phone', title: '联系电话', width: 120, sortable: true, editor: { type: 'text'} },
                { field: 'su0_bank', title: '开户银行', width: 150, sortable: true, editor: { type: 'text'} },
                { field: 'su0_bankaccount', title: '银行账号', width: 120, sortable: true, editor: { type: 'numberbox'} },
                { field: 'su0_bankaddress', title: '银行地址', width: 180, sortable: true, editor: { type: 'text'} },
                { field: 'su0_bankswift', title: '银行SWIFT号', width: 120, sortable: true, editor: { type: 'text'} },
                { field: 'su0_rguser', title: '创建人', width: 60, sortable: true, search: true },
                { field: 'su0_rgdt', title: '创建时间', width: 120, sortable: true },
                { field: 'su0_lmuser', title: '最后修改人', width: 80, search: true, sortable: true },
                { field: 'su0_lmdt', title: '最后修改时间', width: 120, search: true, sortable: true }
            ]],

            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            onDblClickRow: function (RowIndex) {
                RowId = RowIndex;
                Edit_OnClick();
            },
            onClickRow: function (RowIndex, RowData) {
                if (endEditing()) {
                    RowId = RowIndex;
                    selected_Row = RowData;
                }
            },

            toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    Add_Row();
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_OnClick()
                }
            },
            {
                id: 'btn_Save',
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {

                }
            },
            {
                id: 'btn_Remove',
                text: '停用',
                iconCls: 'icon-remove',
                handler: function () {

                }
            },
            {
                id: 'btn_Reject',
                text: '撤销',
                iconCls: 'icon-undo',
                handler: function () {
                    reject();
                }
            }
        ]
        }
        );
    //供应商名称
    var col = $('#tab_list').datagrid('getColumnOption', 'su0_suppliername');
    col.editor = {
        type: 'validatebox', options: { required: true }
    }
    //供应商类型
    var col1 = $('#tab_list').datagrid('getColumnOption', 'dc0_dictname1');
    col1.editor = {
        type: 'combobox', options: {
            panelHeight: 'auto',
            required: true,
            editable: false,
            valueField: 'text',
            textField: 'text',
            data: [
            { "id": "国内", "text": "国内", "selected": true },
            { "id": "国外", "text": "国外" }
            ]
        }
    }
    //供应商联系电话
    var col2 = $('#tab_list').datagrid('getColumnOption', 'su0_phone');
    col2.editor = {
        type: 'validatebox', options: {
            validType: "positive_int"
        }
    }
}


function Edit_OnClick() {

    if (editIndex != undefined) {
        alert("新增行未结束.");
        return;
    }

    if (!selected_Row) {
        alert("请先选中一行.");
        return;
    }

    //判断是否是正在编辑的行
    if (RowId == editIndex) {
        return;
    }
    else if (endEditing()) {
        editIndex = RowId;
        $('#tab_list').datagrid('beginEdit', editIndex);
    }

    //    $('#txtSupplier_Code').val(selected_Row.su0_suppliercode);
    //    $('#txtSupplier_Name').val(selected_Row.su0_suppliername);

    //    $('#txtSupplier_Address').val(selected_Row.su0_address);
    //    $('#txtSupplier_Contact').val(selected_Row.su0_contact); ;
    //    $('#txtSupplier_Phone').val(selected_Row.su0_phone);
    //    $('#txtSupplier_Bank').val(selected_Row.su0_bank);
    //    $('#txtSupplier_BankNo').val(selected_Row.su0_bankaccount);
    //    $('#txtSupplier_Bankadd').val(selected_Row.su0_bankaddress);
    //    $('#txtBank_Swift').val(selected_Row.su0_bankswift);
    //    //    $('#combSupplier_Type').val(selected_Row.dc0_dictname1);
    //    $('#comSupplier_Type').combobox('setValue', selected_Row.dc0_dictname1);

    $('#form_Edit').form('validate');
    $('#txtSupplier_Address').focus();
}
//添加新行
function Add_Row() {
    if (endEditing()) {
        $(tab_list).datagrid('appendRow', {
            su0_suppliercode: '系统生成'


        });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex)
        $('#tab_list').datagrid('beginEdit', editIndex);

    };

}
//结束编辑

function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#tab_list').datagrid('validateRow', editIndex)) {
        var ed = $('#tab_list').datagrid('getEditor', { index: editIndex, field: 'su0_suppliername' });
        $('#tab_list').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    }
    else {
        return false;
    }
}
//取消编辑
function reject() {
    $('#tab_list').datagrid('rejectChanges');
    editIndex = undefined;
}
    