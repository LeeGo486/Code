var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_Depot_Businessdevelopment_ZY";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;
var onClickCellOldShopOptimization;
var m_SelectedRowIndex = null;

var m_ShopState = [{ "id": 1, "text": "自营" }];
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }]
var channeltype = [{ "id": 1, "text": "专卖" }, { "id": 2, "text": "百货" }, { "id": 3, "text": "生活馆" }, { "id": 4, "text": "Mall" }, { "id": 5, "text": "机场店" }, { "id": 6, "text": "网络店" }];
var Storelocation = [{ "id": 1, "text": "1类" }, { "id": 2, "text": "2类" }, { "id": 3, "text": "3类" }]
var Storeproperties = [{ "id": 1, "text": "Maison" }, { "id": 2, "text": "Lifestyle" }, { "id": 3, "text": "Standard store" }, { "id": 3, "text": "Shop in shop" }]
var BusinessState = [{ "id": 1, "text": "正常" }, { "id": 2, "text": "优化" }, { "id": 3, "text": "停" }];


$(function () {


    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName) }]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    $('#txtCom').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0001&PropertyName=" + escape("公司中文简称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird
    });

    $('#txtDepotBrand').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0008&PropertyName=" + escape("品牌名称"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird
    });
})
//初始化表格
function InitGird() {

    ClearGrid("#tab_list");


    m_DepotBrandid = $('#txtDepotBrand').combobox('getValue')
    m_com = $('#txtCom').combobox('getValue')

    if (m_DepotBrandid == "" || m_com == "") {
        return;
    }
    $('#tab_list').datagrid(
           {
               title: '老店优化', //表格标题
               url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=Body_ID_0001='" + m_com + "' AND Body_ID_0008='" + m_DepotBrandid + "'",
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
               //onClickCell: onClickCell,
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
                   text: '老店优化',
                   iconCls: 'icon-edit',
                   handler: function () {
                       onClickCellOldShopOptimization();
                   }
               },

               {
                   id: 'btn_Copy',
                   text: '撤店',
                   iconCls: 'icon-cut',
                   handler: function () {
                       onClickCellRevoke();
                   }
               }
               ,
               {
                   id: 'btn_getChanges',
                   text: 'getChanges',
                   iconCls: 'icon-search',
                   handler: function () {
                       getChanges();
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
    $dg.datagrid("hideColumn", "加盟商名称");
    $dg.datagrid("hideColumn", "body_id_l0011");
    $dg.datagrid("hideColumn", "body_id_0006");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id_0008");
    $dg.datagrid("hideColumn", "所属大区");
    $dg.datagrid("hideColumn", "公司中文简称");
    $dg.datagrid("hideColumn", "body_id_l0006");
    $dg.datagrid("hideColumn", "导购人数");
    $dg.datagrid("hideColumn", "body_id_l0014");


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


    col = $dg.datagrid('getColumnOption', '商务状态');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(BusinessState, value);

        }
    }

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
    col = $dg.datagrid('getColumnOption', '渠道类型');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(channeltype, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '店铺定位');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(Storelocation, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '店铺性质');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(Storeproperties, value);

        }
    }
    col = $dg.datagrid('getColumnOption', '店铺id');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '店铺型态');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '冻结状态');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '冻结状态');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '渠道类型');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '店铺定位');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '店铺性质');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '店铺名称');
    col.editor = {}
    //col = $dg.datagrid('getColumnOption', '合同面积');
    //col.editor = {}
    //col = $dg.datagrid('getColumnOption', '楼层');
    //col.editor = {}
    col = $dg.datagrid('getColumnOption', '省份');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '城市');
    col.editor = {}
    col = $dg.datagrid('getColumnOption', '区县');
    col.editor = {}
    //col = $dg.datagrid('getColumnOption', '地址');
    //col.editor = {}
    col = $dg.datagrid('getColumnOption', '城市定义');
    col.editor = {}

    $dg.datagrid();

}
//查看是否有变化的值
function getChanges() {
    var rows = $('#tab_list').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}
//老店优化操作-双击
function onClickCellOldShopOptimization() {

    var selected = $('#tab_list').datagrid('getSelected');

    if (!selected) {
        alert('请选择一行');
        return;
    }
    $('#divEditType').window({
        width: 800,
        height: 530,
        modal: true

    });

    if (selected.地址 == '') {
        $('#txtnewadd').val("");
    }
    else {
        $('#txtnewadd').val(selected.地址)
    }


    $('#txtnewfloor').numberbox('setValue', '');
    $('#txtnewarea').numberbox('setValue', '');

    $('#Text1').val("老店优化");



    $('#txtdepotid').val(selected.店铺名称);

    var lc = selected.楼层;
    if (lc == "") {
        $('#txtoldfloor').val("无楼层数据");
    }
    else {
        $('#txtoldfloor').val(selected.楼层);
    }


    lc = selected.合同面积;
    if (lc == "") {
        $('#txtoldarea').val("无面积数据");
    }
    else {
        $('#txtoldarea').val(selected.合同面积);
    }

    lc = selected.地址;
    if (lc == "") {
        $('#txtoldadd').val("无地址数据");
    }
    else {
        $('#txtoldadd').val(selected.地址);
    }

}
//老店优化操作-保存
function saveyh() {

    if ($('#form_Edit').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;

    }
    else if ($('#form_Edit').form('validate') == true) {
        //$.messager.alert("提示", "124345！", 'ok');
        $('#divEditType').window('close');

        var selected = $('#tab_list').datagrid('getSelected');
        var index = $('#tab_list').datagrid('getRowIndex', selected);

        ///赋值
        $('#tab_list').datagrid('selectRow', index).datagrid('beginEdit', index);

        var ed = $('#tab_list').datagrid('getEditor', { index: index, field: "地址" });
        $(ed.target).val($("#txtnewadd").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "合同面积" });
        $(ed.target).val($("#txtnewarea").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "楼层" });
        $(ed.target).val($("#txtnewfloor").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "商务状态" });
        $(ed.target).val("2");
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "拓展类型" });
        $(ed.target).val($("#Text1").val());

        $('#tab_list').datagrid('endEdit', index);

        YH_Submit()//触发保存事件
    }
    //Save113456789()
    //$('#tab_list').datagrid('refreshRow', index)//刷新行

}
//老店优化操作-提交
function Edit_Submit() {
    $.messager.alert("提示", "功能未开发！", 'error');
}
//老店优化操作-取消
function Cancel() {
    $('#divEditType').window('close')

}

//撤店操作-单击弹窗
function onClickCellRevoke() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    $('#Revoke').window({
        width: 800,
        height: 530,
        modal: true

    });
    $('#Expand_Revoke').val("撤店");
    $('#txtdepotid_Revoke').val(selected.店铺名称);
}

function Revoke_save() {

    if ($('#Revoke').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;
    }
    $('#Revoke').window('close');

    var selected = $('#tab_list').datagrid('getSelected');
    var index = $('#tab_list').datagrid('getRowIndex', selected);

    var tzcd = $('#Expand_Revoke').val();

    selected.商务状态 = "3";
    selected.拓展类型 = tzcd;
    $('#tab_list').datagrid('refreshRow', index);


    if ($('#form_Edit').form('validate') == false) {
        $.messager.alert("提示", "请把必填项填完！", 'error');
        return false;

    }
    else if ($('#form_Edit').form('validate') == true) {
        //$.messager.alert("提示", "124345！", 'ok');
        $('#divEditType').window('close');

        var selected = $('#tab_list').datagrid('getSelected');
        var index = $('#tab_list').datagrid('getRowIndex', selected);

        ///赋值
        $('#tab_list').datagrid('selectRow', index).datagrid('beginEdit', index);

        var ed = $('#tab_list').datagrid('getEditor', { index: index, field: "地址" });
        $(ed.target).val($("#txtnewadd").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "合同面积" });
        $(ed.target).val($("#txtnewarea").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "楼层" });
        $(ed.target).val($("#txtnewfloor").val());
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "商务状态" });
        $(ed.target).val("2");
        ed = $('#tab_list').datagrid('getEditor', { index: index, field: "拓展类型" });
        $(ed.target).val($("#Text1").val());

        $('#tab_list').datagrid('endEdit', index);

        saveyh_Save()//触发保存事件
    }














}
//撤店操作-单击弹窗
function Revoke_Submit() {
    $.messager.alert("提示", "功能未开发！", 'error');
}
//撤店操作-取消
function Revoke_Cancel() {
    $('#Revoke').window('close')

}
//开始编辑
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
//双击主界面触发老店优化编辑
function onDblClickRow(index, rowData) {
    //SetBodyIDEdit(false);
    //BeginEdit(index, rowData);
    onClickCellOldShopOptimization()
}
//结束编辑
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
//
function YH_Submit() {

    if (endEditing()) {

        $dg = $("#tab_list");
        var updated = $dg.datagrid('getChanges', "updated");

        var update1 = [];
        for (var i = 0; i < updated.length; i++) {
            var data = {};
            data.body_id = updated[i].body_id;
            data.商务状态 = updated[i].商务状态;
            data.合同面积 = updated[i].合同面积;
            data.地址 = updated[i].地址;
            data.楼层 = updated[i].楼层;
            data.拓展类型 = updated[i].拓展类型;
            update1[i] = data;
        }

        var updateJSON = GetEditJson(undefined, update1, undefined);

        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('1825ce56-1a05-46fa-9e00-f05f5eed9a2f'),
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
//撤店操作-撤店保存
function Revoke_Submit() {

    if (endEditing()) {

        $dg = $("#tab_list");
        var updated = $dg.datagrid('getChanges', "updated");

        var update1 = [];
        for (var i = 0; i < updated.length; i++) {
            var data = {};
            data.body_id = updated[i].body_id;
            data.商务状态 = updated[i].商务状态;
            data.合同面积 = updated[i].合同面积;
            data.地址 = updated[i].地址;
            data.楼层 = updated[i].楼层;
            data.拓展类型 = updated[i].拓展类型;
            update1[i] = data;
        }

        var updateJSON = GetEditJson(undefined, update1, undefined);

        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('1825ce56-1a05-46fa-9e00-f05f5eed9a2f'),
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



