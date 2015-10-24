var m_columns = null;
var editIndex;
var m_ViewTableName = "V_L0013_FOR_EP_JM";
var m_MerchantBodyID = null;
var m_AreaBodyID = null;
var m_AreaData = null;
var m_SaleAreaBodyID = null;
var m_SaleAreaData = null;
var m_txtMer = null;
var m_DepotBrandid = null;
var m_com = null;

var m_SelectedRowIndex = null;

var m_ShopState = [{ "id": 0, "text": "总仓" }, { "id": 1, "text": "自营" }, { "id": 2, "text": "加盟" }];

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
            title: '数据维护_营销部_加盟', //表格标题
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
               { field: '品牌名称', title: '品牌', align: 'center', width: 70, search: true, sortable: true },
               { field: '所属大区', title: '所属大区', width: 65, search: true, sortable: true },
               { field: '店铺id', title: '店铺id', width: 60, search: true, sortable: true },
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
    $dg.datagrid("hideColumn", "冻结状态");

    var col = undefined;
    col = $dg.datagrid('getColumnOption', '省份');
    col.editor = {
        type: 'selectButton', options: { handler: function (e) { SelectArea() } }
    }

    col = $dg.datagrid('getColumnOption', '城市');
    col.editor = {
        type: 'selectButton', options: { handler: function (e) { SelectArea() } }
    }

    col = $dg.datagrid('getColumnOption', '区县');
    col.editor = {
        type: 'selectButton', options: { handler: function (e) { SelectArea() } }
    }
    col = $dg.datagrid('getColumnOption', '城市定义');
    col.editor = {
        type: 'selectButton', options: { handler: function (e) { SelectArea() } }
    }

    col = $dg.datagrid('getColumnOption', '店铺型态');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText(m_ShopState, value);

        }
    }

    col = $dg.datagrid('getColumnOption', '店铺型态');
    col.editor = {},


    //col = $dg.datagrid('getColumnOption', '开店时间');
    //col.editor = {
    //    type: 'datebox', options: {
    //        editable: false,
    //        required: true, formatter: formatD

    //    }
    //}

    //function formatD(date) {

    //    if (date && date != "") {
    //        return new Date().format("yyyy-MM-dd ");
    //    }
    //    else {
    //        return new Date(date).format("yyyy-MM-dd ");
    //    }

    //}
    

    col = $dg.datagrid('getColumnOption', '开店时间');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true, formatter:
                function (date) { return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate(); }

        }
    }
        
     


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

    col = $dg.datagrid('getColumnOption', '成本中心');
    col.editor = {
    }

    $dg.datagrid();

}

function SelectArea() {
    $('#divArea').window({
        width: 350,
        height: 230,
        modal: true
    });
    initArea()

}
function initPrefecture(strProvince, strPrefecture, strCity) {
    $('#txtPrefecture').combobox({ data: [] });
    $('#txtCity').combobox({ data: [] });


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
            //if (oldValue) {

            //    intiCity(strProvince, newValue, "无");
            //}

            if (strCity == "") {
                intiCity(strProvince, newValue, "无");
            }
            else {
                intiCity(strProvince, newValue, strCity);
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


    var selected = $('#tab_list').datagrid('selectRow', editIndex).datagrid('getSelected');//新加
    var index = $('#tab_list').datagrid('getRowIndex', selected);


    var rowData = $('#tab_list').datagrid('getData').rows[index];
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
            //if (oldValue) {
            //    if (strPrefecture == "") {
            //        initPrefecture(newValue, "无");
            //    }
            //    else {
            //        initPrefecture(newValue, strPrefecture);
            //    }
            //}
            if (strPrefecture == "") {
                initPrefecture(newValue, "无", "");
            }
            else {
                initPrefecture(newValue, strPrefecture, strCity);
            }
        }
    });
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

    var selected = $('#tab_list').datagrid('getSelected');
    var index = $('#tab_list').datagrid('getRowIndex', selected);
    var ed = dg.datagrid('getEditor', { index: index, field: '省份' });

    //return;
    $.fn.datagrid.defaults.editors.selectButton.setValue(ed.target, strProvince)


    ed = dg.datagrid('getEditor', { index: index, field: '城市' });

    $.fn.datagrid.defaults.editors.selectButton.setValue(ed.target, strPrefecture)

    ed = dg.datagrid('getEditor', { index: index, field: '区县' });

    $.fn.datagrid.defaults.editors.selectButton.setValue(ed.target, strCity)


    ed = dg.datagrid('getEditor', { index: index, field: '城市定义' });

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



    $.fn.datagrid.defaults.editors.selectButton.setValue(ed.target, strLeavel)

    //SetBodyIDEdit(true);

    //if (BeginEdit(index, null)) {

    //    var ed = null;
    //    var tryCount = 0;
    //    while (ed == null && tryCount < 100) {
    //        ed = dg.datagrid('getEditor', { index: index, field: '省份' });
    //        tryCount++;
    //    }

    //    ed.target.val(strProvince);

    //    tryCount = 0;
    //    ed = null;
    //    while (ed == null && tryCount < 100) {
    //        ed = dg.datagrid('getEditor', { index: index, field: '城市' });
    //        tryCount++;
    //    }

    //    ed.target.val(strPrefecture);


    //    ed = null;
    //    tryCount = 0;
    //    while (ed == null && tryCount < 100) {
    //        ed = dg.datagrid('getEditor', { index: index, field: '区县' });
    //        tryCount++;
    //    }

    //    ed.target.val(strCity);


    //    ed = null;
    //    tryCount = 0;
    //    while (ed == null && tryCount < 100) {
    //        ed = dg.datagrid('getEditor', { index: index, field: '城市定义' });
    //        tryCount++;
    //    }

    //    var strLeavel = "";
    //    if (strCity != "") {
    //        for (var i = 0; i < m_City.length; i++) {
    //            if (m_City[i].text == strCity) {
    //                strLeavel = m_City[i].城市等级;
    //                break;
    //            }
    //        }
    //    }
    //    if (strLeavel == "" && m_Prefecture == "") {
    //        for (var i = 0; i < m_Prefecture.length; i++) {
    //            if (m_Prefecture[i].text == strPrefecture) {
    //                strLeavel = m_Prefecture[i].城市等级;
    //                break;
    //            }
    //        }
    //    }

    //    ed.target.val(strLeavel);

    //    endEditing();

    //}
    //else {
    //    SetBodyIDEdit(false);

    //}


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