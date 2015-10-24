var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_EP_OPENSHOP";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;

//var m_ShopState = [{ "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];
var m_ShopState = [{ "id": 1, "text": "自营" }];
var FrozenStus = [{ "id": 0, "text": "未冻结" }, { "id": 1, "text": "冻结" }]
//var FrozenStus = [{ "id": 0, "text": "未冻结" }];
//var Storelevel = [{ "id": 1, "text": "A" }, { "id": 2, "text": "B" }, { "id": 3, "text": "C" }, { "id": 4, "text": "D" }]
var channeltype = [{ "id": 1, "text": "专卖" }, { "id": 2, "text": "百货" }, { "id": 3, "text": "生活馆" }, { "id": 4, "text": "Mall" }, { "id": 5, "text": "机场店" }, { "id": 6, "text": "网络店" }];
var Storelocation = [{ "id": 1, "text": "1类" }, { "id": 2, "text": "2类" }, { "id": 3, "text": "3类" }]
var Storeproperties = [{ "id": 1, "text": "Maison" }, { "id": 2, "text": "Lifestyle" }, { "id": 3, "text": "Standard store" }, { "id": 3, "text": "Shop in shop" }]


//初始化
$(function () {

    var htmlobj = $.ajax({ url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape(m_ViewTableName)}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    ////txtCom
    //$('#txtCom').combobox({
    //    url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0001&PropertyName=" + escape("公司中文简称"),
    //    required: true,
    //    panelHeight: 'auto',
    //    editable: false,
    //    valueField: 'id',
    //    textField: 'text',
    //    onChange: InitGird
    //});

    ////txtDepotBrand
    //$('#txtDepotBrand').combobox({
    //    url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=0008&PropertyName=" + escape("品牌名称"),
    //    required: true,
    //    panelHeight: 'auto',
    //    editable: false,
    //    valueField: 'id',
    //    textField: 'text',
    //    onChange: InitGird
    //});

    //txtMer
    $('#txtMer').combobox({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=L0006&PropertyName=" + escape("公司中文简称") + "&Where=" + escape("加盟商形态区分='自营'"),
        required: true,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        onChange: InitGird
    });
    
 


    //InitGird();
})

//初始化表格
function InitGird() {

    ClearGrid("#tab_list");


//    m_DepotBrandid = $('#txtDepotBrand').combobox('getValue')
//    m_com = $('#txtCom').combobox('getValue')

//    if (m_DepotBrandid == "" || m_com == "") {
//        return;
//    }


        m_txtMer = $('#txtMer').combobox('getValue')
        if (m_txtMer == "") {
            return;
        }


    //加盟商
    //var htmlobj = $.ajax({
    //    url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0006&PropertyName=" + escape("加盟商简称") + "&Where=Body_ID_0001='" + m_com + "'",
    //    async: false
    //});
    //m_MerchantData = jQuery.parseJSON(htmlobj.responseText);


    //县级市
    htmlobj = $.ajax({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0011&PropertyName=" + escape("名称"),
        async: false
    });
    m_AreaData = jQuery.parseJSON(htmlobj.responseText);


    //销售大区
    htmlobj = $.ajax({
        url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0014&PropertyName=" + escape("名称") + "&Where=Body_ID_0008='" + m_DepotBrandid + "'",
        async: false
    });
    m_SaleAreaData = jQuery.parseJSON(htmlobj.responseText);



    $('#tab_list').datagrid(
        {
            title: '店铺信息', //表格标题
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&Where=Body_ID_0001='" + m_com + "' AND Body_ID_0008='" + m_DepotBrandid + "'",
            queryParams: { "XML": GetGetJson([{ "TableName": m_ViewTableName}]) },
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
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    AddNewRow();
                }
            },
            {
                id: 'btn_Copy',
                text: '保存',
                iconCls: 'icon-edit',
                handler: function () {
                    Save();
                }
            }]
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

    var col = $dg.datagrid('getColumnOption', '店铺id');
    col.editor = {};
    var col = $dg.datagrid('getColumnOption', '公司中文简称');
    col.editor = {};

    col = $dg.datagrid('getColumnOption', 'body_id_l0006');
    col.title = "加盟商";
    col.searchfield = "加盟商名称";
    //    col.editor = {};

    col.formatter = function (value) {
        var strText = GetCommboboxText(m_MerchantData, value);
        return strText;
    }

    //col.formatter = function (value) {
    //    var strText = GetCommboboxText(m_MerchantData, value);
    //    return '<input type="button"  value=".."  />' + strText;
    //    //        return '<input type="button"  value=".." onclick="SelectMerchant(this)" name=\'' + value + '\' />' + strText;
    //}

    col = $dg.datagrid('getColumnOption', 'body_id_l0011');
    col.title = "县级市";
    col.editor = {
        type: 'combobox', options:
        { data: m_AreaData, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    };
    col.formatter = function (value) {
        return GetCommboboxText(m_AreaData, value);
    }

    col = $dg.datagrid('getColumnOption', 'body_id_l0014');
    col.title = "所属大区";
    col.searchfield = "所属大区";
    col.editor = {
        type: 'combobox', options:
        { data: m_SaleAreaData, required: false, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    };
    col.formatter = function (value) {
        var date = GetCommboboxText(m_SaleAreaData, value);
        return date;
    }

    col = $dg.datagrid('getColumnOption', '合同开始时间');
    if (col != null) {
        col.formatter = function (value) {
            if (value && value != "") {
                return new Date().format("yyyy-MM-dd hh:mm:ss");
            }
        }
    }

    col = $dg.datagrid('getColumnOption', '合同结束时间');
    if (col != null) {
        col.formatter = function (value) {
            if (value && value != "") {
                return new Date().format("yyyy-MM-dd hh:mm:ss");
            }
        }
    }


    ///格式化，数据翻译
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

    //col = $dg.datagrid('getColumnOption', '店铺型态');
    //col.editor = {
    //    type: 'combobox', options: { data: m_ShopState, required: false, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    //}
    col = $dg.datagrid('getColumnOption', '店铺型态');
    col.editor = {}
    
    col = $dg.datagrid('getColumnOption', '冻结状态');
    col.editor = {
        type: 'combobox', options: { data: FrozenStus, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '渠道类型');
    col.editor = {
        type: 'combobox', options: { data: channeltype, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
        col = $dg.datagrid('getColumnOption', '店铺定位');
    col.editor = {
        type: 'combobox', options: { data: Storelocation, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
        col = $dg.datagrid('getColumnOption', '店铺性质');
    col.editor = {
        type: 'combobox', options: { data: Storeproperties, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }
        col = $dg.datagrid('getColumnOption', '店铺名称');
    col.editor = {
        type: 'validatebox', options: { required:true, textField: 'text'}
    }
    col = $dg.datagrid('getColumnOption', '合同面积');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '楼层');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '省份');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '城市');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '区县');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }
    col = $dg.datagrid('getColumnOption', '地址');
    col.editor = {
        type: 'validatebox', options: { required: true, textField: 'text' }
    }



    $dg.datagrid();

}


function onClickCell(rowIndex, field, value) {
    if (field == "body_id_l0006") {
        m_SelectedRowIndex = rowIndex;
        SelectMerchant(value)
    }
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
    SetBodyIDEdit(false);
    BeginEdit(index, rowData);
}

function SelectMerchant(body_id) {
    if (endEditing()) {
        //if (body_id != '20E489F4-42C2-4AE7-907F-7A055C862A4E')
        //    return;

        if (body_id != '11111111-1111-1111-1111-1111111111111')
       
            return;
        
        //$('#divSelectMerchant').window({
        //    width: 800,
        //    height: 530,
        //    modal: true
        //});
        //initSelectMerchant(body_id)
    }
}


function initSelectMerchant(body_id) {
    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape("V_L0006")}]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    var columns = Text.Col;

    $('#gdSelectMerchant').datagrid(
        {
            url: GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b') + "&where=body_id_0001='" + m_com + "'",
            queryParams: { "XML": GetGetJson([{ "TableName": "V_L0006"}]) },

            columns: eval(columns),
            width: '100%',
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数
            onDblClickRow: dgSelectMerchantDblClickRow
        }
        );

    var $dg = $('#gdSelectMerchant');
    $dg.datagrid("hideColumn", "timestamps");
    $dg.datagrid("hideColumn", "rowindex");
    $dg.datagrid("hideColumn", "body_id_0010");
    $dg.datagrid("hideColumn", "公司中文简称");
    $dg.datagrid("hideColumn", "body_id_0001");
    $dg.datagrid("hideColumn", "body_id");

    $dg.datagrid();
}

function dgSelectMerchantDblClickRow(index, merchantRowData) {

    $('#divSelectMerchant').window('close');

    var dg = $("#tab_list");
    SetBodyIDEdit(true);


    if (BeginEdit(m_SelectedRowIndex, null)) {

        var ed = null;
        var tryCount = 0;
        while (ed == null && tryCount < 100) {
            ed = dg.datagrid('getEditor', { index: m_SelectedRowIndex, field: 'body_id_l0006' });
            tryCount++;
        }

        ed.target.val(merchantRowData.body_id);
        endEditing();

    }
    else {
        SetBodyIDEdit(false);
        
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

function AddNewRow() {
    if (endEditing()) {
        SetBodyIDEdit(false);

        txtMer = $('#txtMer').combobox('getValue')

        //$('#tab_list').datagrid('appendRow', { body_id: '', body_id_l0006: '11111111-1111-1111-1111-1111111111111', 公司中文简称: m_com, 店铺型态: '1', 冻结状态: '0' });
        $('#tab_list').datagrid('appendRow', { body_id: '', body_id_l0006: txtMer, 店铺型态: '1', 冻结状态: '0' });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);

    }
}

function SetBodyIDEdit(edit) {
    var dg = $("#tab_list");
    col = dg.datagrid('getColumnOption', 'body_id_l0006');
    if (edit) {
        col.editor = {
            type: 'text'
        };
    }
    else {
        col.editor = {};
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
                if (row>=0) {

                    $dg.datagrid("selectRow", row);
                    $.messager.alert("提示", "请选择加盟商！", 'error');
                    return;

                }
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