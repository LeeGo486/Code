var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_STOREHOUSE";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_DepotBrandid = null;
var m_com = null;
var m_SelectedRowIndex = null;

var channeltype = [{ "id": 1, "text": "专卖" }, { "id": 2, "text": "百货" }, { "id": 3, "text": "生活馆" }, { "id": 4, "text": "Mall" }, { "id": 5, "text": "机场店" },
                  { "id": 6, "text": "网络店" }, { "id": 22, "text": "(仓)贝爱成品仓" }, { "id": 14, "text": "(仓)雅斓成品仓" }, { "id": 15, "text": "(仓)恩派雅成品仓" },
                  { "id": 16, "text": "(仓)卓莱雅成品仓" }, { "id": 17, "text": "(仓)纳卉成品仓" }, { "id": 18, "text": "(仓)EP奥莱成品仓" }, { "id": 19, "text": "(仓)EP自营成品仓" },
                  { "id": 20, "text": "(仓)EP加盟成品仓" }, { "id": 23, "text": "(仓)调价成品仓" }];

//初始化
$(function () {
    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    InitGird();
})

//初始化表格
function InitGird() {

    ClearGrid("#tab_list");

    $('#tab_list').datagrid(
        {
            title: '仓库仓店修改', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=1=1 ",
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
            onBeforeLoad: function () { return endEditing() },
            frozenColumns: [[
               { field: '公司中文简称', title: '公司', width: 50, search: true, sortable: true },
               { field: '加盟商名称', title: '加盟商名称', width: 100, search: true, sortable: true },
               { field: '店铺品牌', title: '品牌', width: 50, search: true, sortable: true },
               { field: '所属大区', title: '所属大区', width: 80, search: true, sortable: true },
               { field: '店铺id', title: '店铺id', width: 80, search: true, sortable: true },
               { field: '店铺名称', title: '店铺名称', width: 120, search: true, sortable: true }
            ]],
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
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid("hideColumn", "body_id_l0011");
    $dg.datagrid("hideColumn", "body_id_l0006");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id_0008");
    $dg.datagrid("hideColumn", "body_id_l0014");



    col = $dg.datagrid('getColumnOption', '公司中文简称');
    col.field = "test";
    $dg.datagrid("hideColumn", "test");
    col = $dg.datagrid('getColumnOption', '加盟商名称');
    col.field = "test1";
    $dg.datagrid("hideColumn", "test1");
    col = $dg.datagrid('getColumnOption', '店铺品牌');
    col.field = "test2";
    $dg.datagrid("hideColumn", "test2");
    col = $dg.datagrid('getColumnOption', '所属大区');
    col.field = "test3";
    $dg.datagrid("hideColumn", "test3");
    col = $dg.datagrid('getColumnOption', '店铺id');
    col.field = "test4";
    $dg.datagrid("hideColumn", "test4");
    col = $dg.datagrid('getColumnOption', '店铺名称');
    col.field = "test5";
    $dg.datagrid("hideColumn", "test5");


    var col = undefined;

    col = $dg.datagrid('getColumnOption', '渠道类型');
    if (col != null) {
        col.formatter = function (value) {
            return GetCommboboxText(channeltype, value);
        }
    }

    col = $dg.datagrid('getColumnOption', '渠道类型');
    col.editor = {
        type: 'combobox', options: { data: channeltype, required: false, panelHeight: '120', editable: false, valueField: 'id', textField: 'text' }
    }
    $dg.datagrid();
}

function BeginEdit(index, rowData) {
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;
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
    //SetBodyIDEdit(false);
    BeginEdit(index, rowData);
}

function onClickCell(rowIndex, field, value) {
    if (rowIndex != editIndex) {
        if (!endEditing()) {
            return;
        }
    }
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


function Save() {

    if (endEditing()) {
            $dg = $("#tab_list");

            if ($dg.datagrid('getChanges').length) {

                var inserted = undefined;
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