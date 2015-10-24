var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_Special_EDIT";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_DepotBrandid = null;
var m_com = null;
var m_SelectedRowIndex = null;

var m_ShopState = [{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }, { "id": 0, "text": "总仓" }];
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }];
var BusinessState = [{ "id": 1, "text": "正常" }, { "id": 2, "text": "优化" }, { "id": 3, "text": "停" }];



//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    //txtCom
    $('#txtCom').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0001&PropertyName=" + escape("公司中文简称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird,
        onLoadSuccess: function () {
            var data = $('#txtCom').combobox("getData");

            if (data.length == 0 || data[0].id != "0") {
                ComboboxAddRow({ "id": "0", "text": "全部" }, 0, '#txtCom');
            }

        }
    });



    //txtDepotBrand
    $('#txtDepotBrand').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0008&PropertyName=" + escape("品牌名称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird,
        onLoadSuccess: function () {
            var data = $('#txtDepotBrand').combobox("getData");

            if (data.length == 0 || data[0].id != "0") {
                ComboboxAddRow({ "id": "0", "text": "全部" }, 0, '#txtDepotBrand');
            }

        }
    });

    //InitGird();
})

//初始化表格
function InitGird() {

    ClearGrid("#tab_list");

    var url = "";

    m_DepotBrandid = $('#txtDepotBrand').combobox('getValue')
    m_com = $('#txtCom').combobox('getValue')

    if (m_DepotBrandid == "" || m_com == "") {
        return;
    }

    url = GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0006&PropertyName=" + escape("加盟商简称");
    if (m_com != "0") {
        url += "&Where=Body_ID_0001='" + m_com + "'";
    }
   
    url = GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0014&PropertyName=" + escape("名称");
    if (m_DepotBrandid != "0") {
        url += "&Where=Body_ID_0008='" + m_DepotBrandid + "'";
    }

    //销售大区
    htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_SaleAreaData = $.parseJSON(htmlobj.responseText);

    url = GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=1=1 ";
    if (m_com != "0") {
        url += " AND Body_ID_0001='" + m_com + "' ";
    }

    if (m_DepotBrandid != "0") {
        url += " AND Body_ID_0008='" + m_DepotBrandid + "'";
    }

    $('#tab_list').datagrid(
        {
            title: '特殊修改', //表格标题
            url: url,
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName }]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数

            toolbar: "#tab_toolbar",
            onDblClickRow: onDblClickRow,
            onClickCell: onClickCell,
            onBeforeLoad: function () { return endEditing() },
            toolbar: [
            
            {
                id: 'btn_Copy',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            }
            ]
        }
        );


    var $dg = $('#tab_list');


    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid("hideColumn", "body_id_l0011");
    $dg.datagrid("hideColumn", "body_id_l0006");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id_0008");
    $dg.datagrid("hideColumn", "所属大区");
    $dg.datagrid("hideColumn", "店铺品牌");
    

    var col = undefined;


    col = $dg.datagrid('getColumnOption', '店铺型态');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(m_ShopState, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '冻结状态');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(FrozenStus, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '商务状态');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(BusinessState, value);

        }
    }

    col = $dg.datagrid('getColumnOption', '冻结状态');
    col.editor = {
        type: 'combobox', options: { data: FrozenStus, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '店铺型态');
    col.editor = {
        type: 'combobox', options: { data: m_ShopState, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '商务状态');
    col.editor = {
        type: 'combobox', options: { data: BusinessState, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }




    col = $dg.datagrid('getColumnOption', 'body_id_l0014');
    col.title = "所属大区";
    col.searchfield = "所属大区";
    col.editor = {
        type: 'combobox', options:
        { data: m_SaleAreaData, required: true, editable: false, valueField: 'id', textField: 'text' }
    };
    col.formatter = function (value) {

        var date = GetCommboboxText(m_SaleAreaData, value);
        return date;
    }

    $dg.datagrid();

}


function onClickCell(index, field) {
    if (endEditing()) {
        $('#tab_list').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
        editIndex = index;
    }
}

 
function BeginEdit(index, rowData) {
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;
            m_RowData = rowData;
            //新增的行
            if (rowData.body_id == '' || rowData.body_id == '11111111-1111-1111-1111-1111111111111') {
                SetBodyIDEdit(true);
            }
            else {
                SetBodyIDEdit(false);
            }
            $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);

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
        if ($('#tab_list').datagrid('validateRow', editIndex)) {
            $('#tab_list').datagrid('endEdit', editIndex);
            editIndex = undefined;
        }
        else {
            return false;
        }
    }

    return true;
}

 

function SetBodyIDEdit(canEdit) {
    var dg = $("#tab_list");
    col = dg.datagrid('getColumnOption', 'body_id_l0006');
    if (canEdit) {
        if (col.editor1 != null) {
            col.editor = col.editor1;
        }
    }
    else {
        col.editor1 = col.editor;
        col.editor = null;
    }
}

function CheckBodyIDL0006() {
    var data = $("#tab_list").datagrid("getData");

    for (var i = 0; i < data.rows.length; i++) {
        if (data.rows[i].body_id_l0006 == '11111111-1111-1111-1111-1111111111111') {
            return i;
        }
    }

    return -1;
}

function Save() {

    if (endEditing()) {

        var check = true;
        if (check) {
            $dg = $("#tab_list");

            if ($dg.datagrid('getChanges').length) {
                var row = CheckBodyIDL0006()
                if (row >= 0) {

                    $dg.datagrid("selectRow", row);
                    $.messager.alert("提示", "请选择加盟商！", 'error');
                    return;

                }

                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = undefined;
                var updated = $dg.datagrid('getChanges', "updated");

                var updateJSON = GetEditJson(inserted, updated, deleted);

                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('d8d6c242-1d70-495f-98a8-03844f27db53') + "&AutoCode=0",
                    type: 'post',
                    async: true, //异步,
                    data: { "XML": updateJSON },
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
            }

        }
    }
}

function Delete() {
    if (!endEditing()) {
        return;
    }
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    if (selected.body_id_l0006 == '11111111-1111-1111-1111-1111111111111') {
        var rowIndex = $('#tab_list').datagrid('getRowIndex', selected);
        $('#tab_list').datagrid('deleteRow', rowIndex);
        return;
    }

    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    var updated = $('#tab_list').datagrid('getChanges', "updated");
    if (updated.length > 0) {
        deleteMessage = '删除提交后，之前做的修改将全部被撤消，并且数据无法恢复，你确定要删除吗?';
    }

    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtBody_id", "value": selected.body_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('d8d6c242-1d70-495f-98a8-03844f27db53'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");

                        if (result[0].Error) {
                            $.messager.progress('close');

                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result == "False") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $('#tab_list').datagrid("unselectAll");
                            InitGird();
                            $.messager.alert("提示", result[0].rows[0].message);
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    })


}