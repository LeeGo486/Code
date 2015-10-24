var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_Data_Shop_DL";
var m_MerchantBodyID = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }];

var m_ShopState = [{ "id": 0, "text": "总仓"},{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];
var channeltype = [{ "id": 1, "text": "专卖" }, { "id": 2, "text": "百货" }, { "id": 3, "text": "生活馆" }, { "id": 4, "text": "Mall" }, { "id": 5, "text": "机场店" }, { "id": 6, "text": "网络店" }
                   , { "id": 7, "text": "Department store" }, { "id": 8, "text": "Flag-ship store" }, { "id": 9, "text": "Standard shop" }, { "id": 10, "text": "Maison" }, { "id": 11, "text": "Shop in shop" }
                   , { "id": 12, "text": "特卖" }, { "id": 13, "text": "奥莱" }, { "id": 21, "text": "一般百货" }];

//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    $('#txtfrozenstate').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": 0, "text": "未冻结", "selected": true }, { "id": 1, "text": "冻结" }, { "id": 3, "text": "所有" }],
        panelHeight: 'auto',
        editable: false,
        onChange: InitGird,
        onLoadSuccess: InitGird
        //onBeforeLoad: InitGird

    });

})

//初始化表格
function InitGird() {
    ClearGrid("#tab_list");

    var strFrozenstate = $('#txtfrozenstate').combobox('getValue');

    if (strFrozenstate == "") {
        strFrozenstate = "0";
    }
    var strURL = GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b');
    if (strFrozenstate != "3") {
        strURL += "&Where=" + escape("冻结状态") + " ='" + strFrozenstate + "'";
    }

    $('#tab_list').datagrid(
        {
            title: '数据维护_店务管理_贝爱', //表格标题
            url: strURL,
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName }]) },
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            //fit: true,
            fit: true,
            frozen: true,
            columns: eval(m_columns),
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            toolbar: "#tab_toolbar",
            onDblClickRow: onDblClickRow,
            onBeforeLoad: function () { return endEditing() },
            frozenColumns: [[
               { field: '公司中文简称', title: '公司', align: 'center', width: 40, search: true, sortable: true },
               { field: '加盟商名称', title: '加盟商名称', align: 'center', width: 130, search: true, sortable: true },
               { field: '品牌名称', title: '品牌', align: 'center', width: 80, search: true, sortable: true },
               { field: '所属大区', title: '所属大区', width: 65, search: true, sortable: true },
               { field: '店铺id', title: '店铺id', width: 70, search: true, sortable: true },
               { field: '店铺名称', title: '店铺名称', align: 'center', width: 120, search: true, sortable: true }
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
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id");
    $dg.datagrid("hideColumn", "body_id_l0011");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id_0008");
    $dg.datagrid("hideColumn", "body_id_l0006");
    $dg.datagrid("hideColumn", "body_id_l0014");
    //$dg.datagrid("hideColumn", "冻结状态");




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
    col = $dg.datagrid('getColumnOption', '冻结状态');
    col.editor = {
        type: 'combobox', options: { data: FrozenStus, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }

    col = $dg.datagrid('getColumnOption', '店铺型态');
    col.editor = {},

    col = $dg.datagrid('getColumnOption', '公司中文简称'); 
    col.field = "test";
    $dg.datagrid("hideColumn", "test");
    col = $dg.datagrid('getColumnOption', '加盟商名称');
    col.field = "test1";
    $dg.datagrid("hideColumn", "test1");
    col = $dg.datagrid('getColumnOption', '品牌名称');
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

    
    col = $dg.datagrid('getColumnOption', '店铺名称');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '成本中心');
    col.editor = {
    }
    //col = $dg.datagrid('getColumnOption', '店长姓名');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '店长手机');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '督导姓名');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '督导手机');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '货品人员');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', 'crm专员');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '经营品牌');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '营销渠道');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '概念店铺');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '地址');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}

    col = $dg.datagrid('getColumnOption', '渠道类型');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(channeltype, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '渠道类型');
    col.editor = {
        type: 'combobox', options: { data: channeltype, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }

    col = $dg.datagrid('getColumnOption', '开店时间');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true, formatter:
                function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }

        }
    }
    col = $dg.datagrid('getColumnOption', '关店时间');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: false, formatter:
                function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }

        }
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

        var check = true;
        if (check) {
            $dg = $("#tab_list");

            if ($dg.datagrid('getChanges').length) {
                //    var row = CheckBodyIDL0006()
                //    if (row>=0) {
                col = $dg.datagrid('getColumnOption', 'BodyIDL0006');
                if (col == "") {
                    //$dg.datagrid("selectRow", row);
                    $.messager.alert("提示", "请联系信息管理部！", 'error');
                    return;
                }
                //}
                var inserted = $dg.datagrid('getChanges', "inserted");
                var deleted = $dg.datagrid('getChanges', "deleted");
                var updated = $dg.datagrid('getChanges', "updated");

                var updateJSON = GetEditJson(inserted, updated, deleted);

                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: GetWSRRURL('d8d6c242-1d70-495f-98a8-03844f27db53'),
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