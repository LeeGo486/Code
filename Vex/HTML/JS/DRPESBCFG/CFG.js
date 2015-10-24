var lastTabs;
var selected_Row;
var selected_JobList_Row;
var selected_Ref_Row;

//初始化
$(function () {
    InitGird();

    $('#txtEnabled').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "DRP_CFG_Enable"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#txtType').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "DRP_CFG_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#txtJob_Type').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "DRP_CFG_Job_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });
});


//初始化表格
function InitGird() {
    //alert($(document).height());
    $('#tab_list').datagrid(
        {
            title: '所有配置信息',
            url: GetWSRRURL('3ee77c00-4e21-4851-9a8d-5061541cb750'),
            queryParams: { "XML": GetGetJson([{ "entity": "entity" }]) },
            border: false,
            width: '98%',

            singleSelect: true,
            fit: true,
            fitColumns: true,
            striped: true,

            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	           { field: 'requesttype_id', title: 'typeID', width: 40, search: true },
	            { field: 'name', title: '名称', width: 160, search: true }
            ]],
            columns: [[
                { field: 'content', title: '说明', width: 260, search: true, nowarp: true },
                { field: 'table_name', title: '表名', width: 260, search: true },
                { field: 'sql', title: 'SQL', width: 250, search: true, hidden: true },
                { field: 'enabled', title: '生效', width: 50, search: true },
                { field: 'type', title: '类型', width: 40, search: true }
            ]],
            pagination: false,

            onDblClickRow: function () { Edit_OnClick(false); },
            onClickRow: function () { onClickRowGrid(); },
            onLoadSuccess: function () {
                selected_Row = $('#tab_list').datagrid('getSelected');
                InitJobList();
            },
            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_OnClick(true);
                }
            }
            ]
        }
        );

}

function onClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (selected) {
        selected_Row = selected;
        InitJobList();
        ClearGrid("#divRefInfo");
    }
}


function InitRef() {
    selected_Ref_Row = undefined;
    if (selected_JobList_Row) {
        InitRefInfo();
    }
    else {
        ClearGrid('#divRefInfo');
    }
}
function InitJobList() {

    selected_JobList_Row = undefined;

    if (selected_Row) {
        InitJobListInfo();
    }
    else {
        ClearGrid('#divJobListInfo');
    }
    InitRef();
}


function ClearGrid(gridName) {

    try {
        $(gridName).datagrid('loadData', { total: 0, rows: [] });
    } catch (e) {
        return;
    }
}



//初始化参数信息
function InitJobListInfo() {
    selected_JobList_Row = undefined;
    $('#divJobListInfo').datagrid(
            {
                url: GetWSRRURL('c33ea975-913b-4056-a88e-8564ea57b311'),
                queryParams: { "XML": GetGetJson([{ "RequestType_ID": selected_Row.requesttype_id }]) },
                border: false,
                singleSelect: true,
                striped: true,
                width: '98%',
                fit: true,
                fitColumns: true,
                columns: [[
                    { field: 'requesttype_job_id', title: 'JobID', width: 30 },
                    { field: 'requesttype_id', title: 'TypeID', width: 30, hidden: true },
                    { field: 'seq_id', title: '序号', width: 30 },
                    { field: 'dst_app', title: '目标App', width: 120 },
                    { field: 'dst_table_name', title: '目标表', width: 120 },
                    { field: 'dst_decision_column', title: '目标决定列', width: 120 },
                    { field: 'dst_decision_table_name', title: '目标决定表', width: 120 },
                    { field: 'job_type', title: '类型', width: 30 }
                ]],

                onDblClickRow: function () { AddJobList_OnClick(true); },
                onClickRow: function () { ClickJobListRowGrid(); },
                onLoadSuccess: function () {
                    selected_JobList_Row = $('#divJobListInfo').datagrid('getSelected');
                    InitRef();
                },
                toolbar: [
                {
                    id: 'btn_AddJobList',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddJobList_OnClick();
                    }
                },
                {
                    id: 'btn_DeleteJobList',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        DeleteJobList_OnClick();
                    }
                },
                {
                    id: 'btn_CopyJobList',
                    text: '复制',
                    handler: function () {
                        AddJobList_OnClick(false, true);
                    }
                }
                ]

            }
            );

}



//初始化参数信息
function InitRefInfo() {


    $('#divRefInfo').datagrid(
            {
                url: GetWSRRURL('f30526c9-0c0d-4cfa-9511-a1a6eb20553c'),
                queryParams: { "XML": GetGetJson([{ "RequestType_JobList_ID": selected_JobList_Row.requesttype_job_id }]) },
                sortName: 'param_index', //排序字段
                nowrap: true,
                fit: true,
                striped: true,
                width: '98%',
                singleSelect: true, //单行选择
                columns: [[
                    { field: 'requesttype_joblist_ref_id', title: 'RefID', width: 30 },
                    { field: 'column_type', title: '类型', width: 100 },
                    { field: 'column_name', title: '列名', width: 100 },
                    { field: 'column_value', title: 'SQL值', width: 350 }
                ]],

                onDblClickRow: function () { AddRef_OnClick(true); },
                onLoadSuccess: function () {
                    selected_Ref_Row = $('#divRefInfo').datagrid('getSelected');
                },
                toolbar: [
                {
                    id: 'btn_AddRef',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddRef_OnClick();
                    }
                },
                {
                    id: 'btn_DeleteRef',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        DeleteRef_OnClick();
                    }
                }
                ,
                {
                    id: 'btn_RefreshPriceRef',
                    text: '刷单价',
                    handler: function () {
                        RefreshPriceRef_OnClick();
                    }
                }
                ,
                {
                    id: 'btn_Value1',
                    text: 'Value1',
                    handler: function () {
                        Value1_OnClick();
                    }
                },
                {
                    id: 'btn_SetDepotID',
                    text: 'SetDepotID取配置',
                    handler: function () {
                        SetDepotIDCFG_OnClick();
                    }
                },
                {
                    id: 'btn_SetDepotID',
                    text: 'SetDepotID取原表',
                    handler: function () {
                        SetDepotIDSRC_OnClick();
                    }
                },
                {
                    id: 'btn_Value3',
                    text: '触发后白单',
                    handler: function () {
                        Value3_OnClick();
                    }
                },
                {
                    id: 'btn_Value4',
                    text: '参照取值',
                    handler: function () {
                        Value4_OnClick();
                    }
                }
                ]

            }
            );

}

function Value4_OnClick() {
    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('Value4');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("SET @value = '1'");

    Edit_RefSubmit();


}


function Value3_OnClick() {
    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('Value3');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("SET @value = 'not_sure'");

    Edit_RefSubmit();


}

function SetDepotIDSRC_OnClick() {

    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('SetDepotID');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("SELECT  @value = Set_depotid \r\n FROM     " + selected_Row.table_name + " \r\n WHERE   RequestID = @requestID");
    $('#divEditRef').window({
        modal: true,
        top: 10
    });

}

function SetDepotIDCFG_OnClick() {

    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('SetDepotID');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("DECLARE @Set_DepotID NVARCHAR(40) ,\r\n    @Get_DepotID NVARCHAR(40)\r\nSELECT  @Set_DepotID = Set_depotid ,\r\n        @Get_DepotID = Get_depotid\r\nFROM    " + selected_Row.table_name + "\r\nWHERE   RequestID = @requestID\r\nEXEC dbo.SP_Mwq_Business_Code_Mapping @BillType = '代销发货生产入库',\r\n    @Src_App = @Src_App, @Src_Set_DepotID = @Set_DepotID,\r\n    @Src_Get_DepotID = @Get_DepotID, @Dst_App = @Dst_App,\r\n    @Dst_Depot_Type = 'Set', @Dst_DepotID = @value OUTPUT");

    $('#divEditRef').window({
        modal: true,
        top:10
    });
}

function Value1_OnClick() {

    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('Value1');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("SET @value = 'set_sure'");

    $('#divEditRef').window({
        title: "编辑",
        top:10,
        width: 600,
        height: 450,
        modal: true
    });

}


function RefreshPriceRef_OnClick() {

    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    $('#txtRequestType_JobList_Ref_ID').val('');
    $('#txtColumn_Type').val('RefreshPrice');
    $('#txtColumn_Name').val('');
    $('#txtColumn_Value').val("SET @value = '1'");

    Edit_RefSubmit();
}


function ClickJobListRowGrid() {
    var selected = $('#divJobListInfo').datagrid('getSelected');

    if (selected && selected.requesttype_job_id) {
        selected_JobList_Row = selected;

        InitRefInfo();
    }
    else {
        ClearGrid("divRefInfo");
    }
}



function AddRef_OnClick(isEdit) {
    if (!selected_JobList_Row || !selected_JobList_Row.requesttype_job_id
    || selected_JobList_Row.requesttype_job_id == "") {
        alert("请先选择要JobList的行！");
        return;
    }

    selected_Ref_Row = $('#divRefInfo').datagrid('getSelected');

    if (isEdit && !selected_Ref_Row) {
        alert("请选择要编辑的行！");
        return;
    }
    if (isEdit) {

        $('#divEditRef').window({
            top:10,
            modal: true
        });

        var reg = new RegExp("回车", "g");

        var str = selected_Ref_Row.column_value.replace(reg, "\n");

        $('#txtRequestType_JobList_Ref_ID_Show').val(selected_Ref_Row.requesttype_joblist_ref_id);
        $('#txtRequestType_JobList_Ref_ID').val(selected_Ref_Row.requesttype_joblist_ref_id);
        $('#txtColumn_Type').val(selected_Ref_Row.column_type);
        $('#txtColumn_Name').val(selected_Ref_Row.column_name);
        $('#txtColumn_Value').val(str);
    }
    else {
        $('#divEditRef').window({
            title: "添加",
            top:10,
            width: 600,
            height: 450,
            modal: true
        });

        $('#txtRequestType_JobList_Ref_ID_Show').val('系统自动生成');
        $('#txtRequestType_JobList_Ref_ID').val('');
        $('#txtColumn_Type').val('');
        $('#txtColumn_Name').val('');
        $('#txtColumn_Value').val('');

    }
    $('#form_RefEdit').form('validate');
    $('#txtColumn_Type').focus();
}

function AddJobList_OnClick(isEdit, isCopy) {
    selected_JobList_Row = $('#divJobListInfo').datagrid('getSelected');

    if (isEdit && !selected_JobList_Row) {
        alert("请选择要编辑的行！");
        return;
    }

    if (isCopy && !selected_JobList_Row) {
        alert("请选择要复制的行！");
        return;
    }

    if (isEdit || isCopy) {

        $('#divEditJobList').window({
            title: "编辑",
            top: 10,
            width: 600,
            height: 450,
            modal: true
        });

        if (isEdit) {
            $('#txtRequestType_job_ID_Show').val(selected_JobList_Row.requesttype_job_id);
            $('#txtRequestType_job_ID').val(selected_JobList_Row.requesttype_job_id);
            $('#txtSeq_ID').numberbox('setValue', selected_JobList_Row.seq_id);

        }
        else {
            $('#txtRequestType_job_ID_Show').val('系统自动生成');
            $('#txtRequestType_job_ID').val('');
            $('#txtSeq_ID').numberbox('setValue', parseInt(selected_JobList_Row.seq_id) + 1);

        }
        $('#txtRequestType_ID').val(selected_JobList_Row.requestType_id);
        $('#txtDST_App').val(selected_JobList_Row.dst_app);
        $('#txtDST_Table_Name').val(selected_JobList_Row.dst_table_name);
        $('#txtDST_Decision_Column').val(selected_JobList_Row.dst_decision_column);
        $('#txtDST_Decision_Table_Name').val(selected_JobList_Row.dst_decision_table_name);
        $('#txtJob_Type').combobox('setValue', selected_JobList_Row.job_type);


    }
    else {
        $('#divEditJobList').window({
            title: "添加",
            top:10,
            width: 600,
            height: 450,
            modal: true
        });

        $('#txtRequestType_job_ID_Show').val('系统自动生成');
        $('#txtRequestType_job_ID').val('');
        $('#txtSeq_ID').numberbox('clear');
        $('#txtDST_App').val('');
        $('#txtDST_Table_Name').val('');
        $('#txtDST_Decision_Column').val('');
        $('#txtDST_Decision_Table_Name').val('');
        $('#txtJob_Type').combobox('setValue', '0');


    }
    $('#form_JobListEdit').form('validate');
    $('#txtSeq_ID').focus();
}


function Edit_OnClick(isAdd) {
    var selected = $('#tab_list').datagrid('getSelected');

    if (isAdd == false && !selected) {

        alert("请先选择需要被复制的行");
        return;
    }
    if (isAdd) {
        $('#divEditType').window({
            title: "添加",
            top:10,
            width: 600,
            height: $(document.body).height() - 40,
            modal: true
        });

        $('#txtRequestType_ID_SHOW').val("系统自动生成");
        $('#txtRequestType_ID').val("");

        $('#txtName').val('');
        $('#txtContent').val('');
        $('#txtTable_Name').val('');
        $('#txtSQL').val('');
        //$('#txtEnabled').val('True');
        $('#txtEnabled').combobox('setValue', 'True');
        $('#txtType').combobox('setValue', '0');
        $('#txtType').val('0');

        $('#form_Edit').form('validate');
        $('#txtName').focus();
    }
    else {
        $('#divEditType').window({
            title: "编辑",
            top: 10,
            width: 600,
            height: $(document.body).height() - 40,
            modal: true
        });


        var reg = new RegExp("回车", "g");

        var str = selected_Row.sql.replace(reg, "\n");
        var strcontent = selected_Row.content.replace(reg, "\n");

        $('#txtRequestType_ID_SHOW').val(selected_Row.requesttype_id);
        $('#txtRequestType_ID').val(selected_Row.requesttype_id);

        $('#txtName').val(selected_Row.name);
        $('#txtContent').val(strcontent)
        $('#txtTable_Name').val(selected_Row.table_name);
        $('#txtSQL').val(str);
        //        $('#txtEnabled').val(selected_Row.enabled);
        $('#txtEnabled').combobox('setValue', selected_Row.enabled);
        $('#txtType').combobox('setValue', selected_Row.type);
        $('#form_Edit').form('validate');
        $('#txtWS_Name').focus();
    }


}

function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                return false;
            }

            var data = $('#form_Edit').serializeArray();

            var XMLData = GetFormJson(data, 'EDIT');



            $.ajax({
                url: GetWSRRURL('3ee77c00-4e21-4851-9a8d-5061541cb750'),
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

                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {

                            $('#divEditType').window('close');
                            $('#tab_list').datagrid("reload");
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

            return false;
        }
    });
}

function Edit_JobListSubmit() {

    $('#form_JobListEdit').form('submit', {
        onSubmit: function () {
            var data = $('#form_JobListEdit').serializeArray();
            data[data.length] = { "name": "txtRequestType_ID", "value": selected_Row.requesttype_id }

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('c33ea975-913b-4056-a88e-8564ea57b311'),
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

                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {

                            $('#divEditJobList').window('close');

                            $('#divJobListInfo').datagrid("reload");
                            //$.messager.alert("提示", result[0].rows[0].message);

                            selected_JobList_Row = undefined;
                            InitRef();
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

            return false;
        }
    });
}

function Edit_RefCancel() {
    $('#divEditRef').window("close");
}

function Edit_JobListCancel() {
    $('#divEditJobList').window("close");

}
function Edit_Cancel() {
    $('#divEditType').window("close");
}

function Edit_RefSubmit() {

    $('#form_RefEdit').form('submit', {
        onSubmit: function () {
            var data = $('#form_RefEdit').serializeArray();
            data[data.length] = { "name": "txtRequestType_JobList_ID", "value": selected_JobList_Row.requesttype_job_id }

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('f30526c9-0c0d-4cfa-9511-a1a6eb20553c'),
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

                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            try {
                                $('#divEditRef').window('close');
                            }
                            catch (ex) {
                            }
                            $('#divRefInfo').datagrid("reload");
                            //$.messager.alert("提示", result[0].rows[0].message);
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

            return false;
        }
    });
}

function DeleteJobList_OnClick() {
    var selected = $('#divJobListInfo').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtRequestType_job_ID", "value": selected.requesttype_job_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('c33ea975-913b-4056-a88e-8564ea57b311'),
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
                            $('#divJobListInfo').datagrid("unselectAll");
                            $('#divJobListInfo').datagrid("reload");
                            selected_JobList_Row = undefined;
                            //$.messager.alert("提示", result[0].rows[0].message);


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
};


function DeleteRef_OnClick() {
    var selected = $('#divRefInfo').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtRequestType_JobList_Ref_ID", "value": selected.requesttype_joblist_ref_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('f30526c9-0c0d-4cfa-9511-a1a6eb20553c'),
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
                            $('#divRefInfo').datagrid("unselectAll");
                            $('#divRefInfo').datagrid("reload");
                            //$.messager.alert("提示", result[0].rows[0].message);


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
};