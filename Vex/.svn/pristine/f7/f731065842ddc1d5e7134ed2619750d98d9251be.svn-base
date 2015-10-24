var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_马卫清";
var m_MerchantBodyID = null;
var m_MerchantData = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;

var m_Province = null;
var m_Prefecture = null;
var m_City = null;

var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;

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
    //加盟商
    var htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_MerchantData = $.parseJSON(htmlobj.responseText);

    ////县级市
    //htmlobj = $.ajax({
    //    url: GetComboxWSRRURL('4d173b24-6efd-419e-8efa-ce9e5138ad36') + "&MDMClass=l0011&PropertyName=" + escape("名称"),
    //    async: false
    //});
    //m_AreaData = $.parseJSON(htmlobj.responseText);

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
            title: '店铺信息', //表格标题
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
            },
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete();
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

    //var col = $dg.datagrid('getColumnOption', '店铺id');
    //col.editor = {};

    var col = undefined;

    col = $dg.datagrid('getColumnOption', 'body_id_l0006');
    col.title = "加盟商";
    col.searchfield = "加盟商名称";
    col.formatter = function (value, rowData) {
        var strText = GetCommboboxText(m_MerchantData, value);
        return '<input type="button"  value=".."  />' + strText;
    }

    col = $dg.datagrid('getColumnOption', '省份');
    col.formatter = function (value, rowData) {
        return '<input type="button"  value=".."  />' + value;
    }

    col = $dg.datagrid('getColumnOption', '城市');
    col.formatter = function (value, rowData) {
        return '<input type="button"  value=".."  />' + value;
    }

    col = $dg.datagrid('getColumnOption', '区县');
    col.formatter = function (value, rowData) {
        return '<input type="button"  value=".."  />' + value;
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


function onClickCell(rowIndex, field, value) {
    if (rowIndex != editIndex) {
        if (!endEditing()) {
            return;
        }
    }

    if (field == "body_id_l0006") {
        m_SelectedRowIndex = rowIndex;
        SelectMerchant(value)
    }
    else if (field == "省份" || field == "城市" || field == "区县" || field == "城市定义") {
        m_SelectedRowIndex = rowIndex;
        SelectArea()
    }

}

function SelectArea() {
    if (endEditing()) {

        $('#divArea').window({
            width: 350,
            height: 230,
            modal: true
        });
        initArea()
    }
}
function initPrefecture(strProvince, strPrefecture) {
    $('#txtPrefecture').combobox({});

    var url = GetComboxALLColumnWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("地级市") + "&Province=" + escape(strProvince);

    htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_Prefecture = $.parseJSON(htmlobj.responseText);

    if (strPrefecture == "") {
        strPrefecture = "无";
    }

    SetDefaultSelected(m_Prefecture, strPrefecture);

    //txtPrefecture
    $('#txtPrefecture').combobox({
        data: m_Prefecture,
        panelHeight: 300,
        editable: false,
        valueField: 'text',
        textField: 'text',
        onChange: function (newValue, oldValue) {
            if (oldValue) {
                intiCity(strProvince, newValue, "无");
            }
        }
    });
}

function intiCity(strProvince, strPrefecture, strCity) {
    //txtPrefecture
    $('#txtCity').combobox({});

    var url = GetComboxALLColumnWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("县级市") + "&Province=" + escape(strProvince) + "&Prefecture=" + escape(strPrefecture);
    htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_City = $.parseJSON(htmlobj.responseText);

    if (strCity == "") {
        strCity = "无";
    }
    SetDefaultSelected(m_City, strCity);

    $('#txtCity').combobox({
        data: m_City,
        panelHeight: 300,
        editable: false,
        valueField: 'text',
        textField: 'text'
    });
}

function SetDefaultSelected(data, value) {
    for (var i = 0; i < data.length; i++) {
        if (data[i].text == value) {
            data[i].selected = true;
            break;
        }
    }
}

function initArea() {
    var rowData = $('#tab_list').datagrid('getData').rows[m_SelectedRowIndex];
    var strProvince = rowData.省份;
    var strPrefecture = rowData.城市;
    var strCity = rowData.区县;

    $('#txtProvince').combobox({ data: [] });
    $('#txtPrefecture').combobox({ data: [] });
    $('#txtCity').combobox({ data: [] });
    m_Province = [];
    m_Prefecture = [];
    m_City = [];

    var url = GetComboxWSRRURL('a88077d9-9bb9-4f3f-9567-e7f913b3c667') + "&AreaType=" + escape("省份");

    htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_Province = $.parseJSON(htmlobj.responseText);

    SetDefaultSelected(m_Province, strProvince);


    //txtProvince
    $('#txtProvince').combobox({
        data: m_Province,
        panelHeight: 300,
        editable: false,
        valueField: 'text',
        textField: 'text',
        onChange: function (newValue, oldValue) {
            if (oldValue) {
                initPrefecture(newValue, "无");
            }
        }
    });


    if (strProvince != "") {
        initPrefecture(strProvince, strPrefecture);

        if (strPrefecture && strPrefecture != "") {
            intiCity(strProvince, strPrefecture, strCity);
        }
    }
}

function onclick_SelectArea_Cancel() {
    $('#divArea').window('close');
}

function onclick_SelectArea_Comfirm() {
    $('#divArea').window('close');

    var strProvince = $('#txtProvince').combobox('getValue');
    var strPrefecture = $('#txtPrefecture').combobox('getValue');
    var strCity = $('#txtCity').combobox('getValue');

    if (strProvince == "无") {
        strProvince = "";
    }

    if (strPrefecture == "无") {
        strPrefecture = "";
    }

    if (strCity == "无") {
        strCity = "";
    }

    var dg = $("#tab_list");

    SetBodyIDEdit(true);

    if (BeginEdit(m_SelectedRowIndex, null)) {

        var ed = null;
        var tryCount = 0;
        while (ed == null && tryCount < 100) {
            ed = dg.datagrid('getEditor', { index: m_SelectedRowIndex, field: '省份' });
            tryCount++;
        }

        ed.target.val(strProvince);

        tryCount = 0;
        ed = null;
        while (ed == null && tryCount < 100) {
            ed = dg.datagrid('getEditor', { index: m_SelectedRowIndex, field: '城市' });
            tryCount++;
        }

        ed.target.val(strPrefecture);


        ed = null;
        tryCount = 0;
        while (ed == null && tryCount < 100) {
            ed = dg.datagrid('getEditor', { index: m_SelectedRowIndex, field: '区县' });
            tryCount++;
        }

        ed.target.val(strCity);


        ed = null;
        tryCount = 0;
        while (ed == null && tryCount < 100) {
            ed = dg.datagrid('getEditor', { index: m_SelectedRowIndex, field: '城市定义' });
            tryCount++;
        }

        var strLeavel = "";
        if (strCity != "") {
            for (var i = 0; i < m_City.length; i++) {
                if (m_City[i].text == strCity) {
                    strLeavel = m_City[i].城市等级;
                    break;
                }
            }
        }
        if (strLeavel == "") {
            for (var i = 0; i < m_Prefecture.length; i++) {
                if (m_Prefecture[i].text == strPrefecture) {
                    strLeavel = m_Prefecture[i].城市等级;
                    break;
                }

            }
        }

        ed.target.val(strLeavel);

        endEditing();

    }
    else {
        SetBodyIDEdit(false);

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

        $('#divSelectMerchant').window({
            width: 800,
            height: 530,
            modal: true
        });
        initSelectMerchant(body_id)
    }

}

function initSelectMerchant(body_id) {
    var htmlobj = $.ajax({
        url: GetGridColumnsWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b'),
        data: "XML=" + GetGetJson([{ "TableName": escape("V_L0006") }]), async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    var columns = Text.Col;
    var url = GetWSRRURL('1a2ec2ce-f85d-4b68-a63e-60cdf22b7c2b');
    if (m_com != "0") {
        url += "&where=body_id_0001='" + m_com + "'"
    }

    $('#gdSelectMerchant').datagrid(
        {
            url: url,
            queryParams: { "XML": GetGetJson([{ "TableName": "V_L0006" }]) },

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

            if ($('#tab_list').datagrid('getSelected') == null) {
                $('#tab_list').datagrid('selectRow', editIndex);
            }

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
        $('#tab_list').datagrid('appendRow', { body_id: '', body_id_l0006: '11111111-1111-1111-1111-1111111111111', 省份: "无", 城市: "无", 区县: "无", 城市定义: "" });
        editIndex = $('#tab_list').datagrid('getRows').length - 1;
        $('#tab_list').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

function SetBodyIDEdit(edit) {
    var dg = $("#tab_list");
    if (edit) {
        col = dg.datagrid('getColumnOption', 'body_id_l0006');
        col.editor = {
            type: 'text'
        };

        col = dg.datagrid('getColumnOption', '省份');
        col.editor = {
            type: 'text'
        };

        col = dg.datagrid('getColumnOption', '城市');
        col.editor = {
            type: 'text'
        };

        col = dg.datagrid('getColumnOption', '区县');
        col.editor = {
            type: 'text'
        };

        col = dg.datagrid('getColumnOption', '城市定义');
        col.editor = {
            type: 'text'
        };
    }
    else {
        col = dg.datagrid('getColumnOption', 'body_id_l0006');
        col.editor = {};

        col = dg.datagrid('getColumnOption', '省份');
        col.editor = {};

        col = dg.datagrid('getColumnOption', '城市');
        col.editor = {};

        col = dg.datagrid('getColumnOption', '区县');
        col.editor = {};

        col = dg.datagrid('getColumnOption', '城市定义');
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