var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_Goods_Shop_ZY";
var m_MerchantBodyID = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;

var m_ShopState = [{ "id": 1, "text": "自营" }];

//初始化
$(function () {

    var htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
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
            title: '数据维护_EP货品经营_自营', //表格标题
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
               { field: '公司中文简称', title: '公司', width: 40, search: true, sortable: true },
               { field: '加盟商名称', title: '加盟商名称', width: 70, search: true, sortable: true },
               { field: '品牌名称', title: '品牌', width: 35, search: true, sortable: true },
               { field: '所属大区', title: '所属大区', width: 65, search: true, sortable: true },
               { field: '店铺id', title: '店铺id', width: 60, search: true, sortable: true },
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
            //{
            //    id: 'checkbox',
            //    text: '选着',
            //    iconCls: 'icon-edit',
            //    handler: function () {
            //        Save();
            //    }
            //}
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
    $dg.datagrid("hideColumn", "冻结状态");
    

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


    //col = $dg.datagrid('getColumnOption', '开店时间');
    //col.editor = {
    //    type: 'datebox', options: {
    //        editable: false,
    //        required: true, formatter:
    //            function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); },

    //    }
    //}
    // col = $dg.datagrid('getColumnOption', '店铺id');
    //col.editor = {};
    // col = $dg.datagrid('getColumnOption', '公司中文简称');
    //col.editor = {};
    // col = $dg.datagrid('getColumnOption', '加盟商名称');
    //col.editor = {};
    // col = $dg.datagrid('getColumnOption', '品牌名称');
    //col.editor = {};
    // col = $dg.datagrid('getColumnOption', '所属大区');
    //col.editor = {};
    // col = $dg.datagrid('getColumnOption', '店铺名称');
    //col.editor = {};


    //col = $dg.datagrid('getColumnOption', '地域描述');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    
    //col = $dg.datagrid('getColumnOption', '店铺等级');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '货杆数');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '服饰品店铺等级');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '服饰品货杆数');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '高级系列店铺等级');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    //col = $dg.datagrid('getColumnOption', '高级系列货杆数');
    //col.editor = {
    //    type: 'validatebox', options: { required: true, textField: 'text' }
    //}
    
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
                    if(col == ""){
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