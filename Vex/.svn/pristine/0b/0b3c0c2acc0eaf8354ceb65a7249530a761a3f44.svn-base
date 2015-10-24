var lastTabs;
var selected_Row;
var selected_Param_Row;

//初始化
$(function () {
    InitGird();

    //WS的Param分类
    $('#txtParam_Type').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#txtParam_Must_Flag').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Must_Flag"),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWS_Type').combobox({
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Type',
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Type"),

        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWS_State').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_State"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_State',
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWS_Unicode').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Unicode"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Unicode',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#txtNeed_Login').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_NeedLogin"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#txtClass_ID').combobox({
        url: GetComboxWSRRURL('2aeb7e32-e6b2-437d-8b76-ca83b7547439'),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });
});


//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title: 'WS列表', //表格标题
            url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e'),
            queryParams: { "XML": GetGetJson([{ "entity": "entity" }]) },

            idField: 'ws_id', //标识字段,主键
            iconCls: '', //标题左边的图标
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            sortOrder: 'asc', //排序类型
            remoteSort: false, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            { field: 'ws_id', title: '编号', width: 150, search: true, sortable: true },
	            { field: 'ws_name', title: 'WS名', width: 100, search: true, sortable: true }

            ]],
            columns: [[
                { field: 'ws_type', title: '类型', width: 60, search: true, sortable: true },
                { field: 'ws_help', title: '说明', width: 160, sortable: true },
                { field: 'ws_state', title: '状态', width: 50, sortable: true },
                { field: 'ws_host_prod', title: '正式库服务器', width: 150, sortable: true },
                { field: 'ws_host_test', title: '测试库服务器', width: 150, sortable: true },
                { field: 'ws_url', title: '访问路径', width: 100, sortable: true },
                { field: 'ws_vision', title: '版本', width: 40, sortable: true },
                { field: 'ws_method', title: '调用的方法', width: 100, sortable: true },
                { field: 'ws_unicode', title: '编码方式', width: 60, sortable: true },
                { field: 'need_login', title: '必须登录', width: 60, sortable: true },
                { field: 'need_loginint', title: '必须登录', width: 60, hidden: true, sortable: true },
                { field: 'class_id', title: '分类编号', width: 60, hidden: true, sortable: true },
                { field: 'class_name_all', title: '分类', width: 150, search: true, sortable: true }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            onDblClickRow: function () { Edit_OnClick(false); },
            onClickRow: function () { DBlClickRowGrid(); },

            toolbar: [
            {
                id: 'btn_Add',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_OnClick(false);
                }
            },
            {
                id: 'btn_Copy',
                text: '复制',
                iconCls: 'icon-redo',
                handler: function () {
                    Edit_OnClick(true);
                }
            },
            {
                id: 'btn_deployToProd',
                text: '同步正测式库',
                iconCls: 'icon-redo',
                handler: function () {
                    DeployToProd_OnClick(true);
                }
            }
            ]
        }
        );

}

function DBlClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (selected) {
        selected_Row = selected;
        InitTab();
    }
}


function InitTab() {

    if (selected_Row) {

        try {

            var row = $('#divParamInfo').datagrid('getSelected');
            var rowIndex = $('#divParamInfo').datagrid('getRowIndex', row);
            $('#divParamInfo').datagrid('unselectRow', rowIndex);

        }
        catch (e) {
        }

        InitParamInfo();
    }
}


function ClearGrid(gridName) {

    try {
        $(gridName).datagrid('loadData', { total: 0, rows: [] });
    } catch (e) {
        return;
    }
}



//初始化参数信息
function InitParamInfo() {


    $('#divParamInfo').datagrid(
            {
                title: selected_Row.ws_name, //表格标题
                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
                queryParams: { "XML": GetGetJson([{ "ws_id": selected_Row.ws_id }]) },
                sortName: 'param_index', //排序字段
                sortable: true,
                idField: 'system_id', //标识字段,主键
                iconCls: '', //标题左边的图标
                width: '90%', //宽度
                height: $(document).height() - 20, //高度
                nowrap: false, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                sortOrder: 'asc', //排序类型
                remoteSort: false, //定义是否从服务器给数据排序
                fit: true,
                singleSelect: true, //单行选择
                columns: [[
                    { field: 'param_id', title: '编号', width: 30, hidden: true },
                    { field: 'param_index', title: '序号', width: 30 },
                    { field: 'param_content', title: '说明', width: 80 },
                    { field: 'param_name', title: '参数名', width: 80 },
                    { field: 'param_type', title: '参数类型', width: 50 },
                    { field: 'param_must_flag', title: '必须', width: 80 },
                    { field: 'Param_Must_Flagint', title: '必须', width: 80, hidden: true },
                    {
                        field: 'default_value', title: '默认值', width: 250, title: true
                        , formatter: function (value, row, index) {
                            var content = '<div title="' + value + '">' + value + '</div>';
                            return content;
                        }
                    }
                ]],

                onDblClickRow: function () { AddParam_OnClick(true); },
                onClickRow: function () { ClickParamRowGrid(); },
                toolbar: [
                {
                    id: 'btn_AddParam',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddParam_OnClick();
                    }
                },
                {
                    id: 'btn_EditParam',
                    text: '编辑',
                    iconCls: 'icon-edit',
                    handler: function () {
                        AddParam_OnClick(true);
                    }
                },
                {
                    id: 'btn_DeleteParam',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        DeleteParam_OnClick();
                    }
                },
                {
                    id: 'btn_AddParamPage',
                    text: '添加分页信息',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddParamPage_OnClick();
                    }
                }]

            }
            );

}

function ClickParamRowGrid() {
    //                var selected = $('#divParamInfo').datagrid('getSelected');
    //                selected_Param_Row = selected;
}

function GetParamPageXML() {
    var ws_id = selected_Row.ws_id;
    var maxRowIndex = 0;

    var data_Param = $("#divParamInfo").datagrid("getData");
    if (data_Param.rows.length > 0) {
        maxRowIndex = parseInt(data_Param.rows[data_Param.rows.length - 1].param_index);
    }


    var xml = "<Root><OPTYPE>EDIT</OPTYPE><List>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 1) + "</Param_Index><Param_Content>page</Param_Content><Param_Name>page</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value>1</Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 2) + "</Param_Index><Param_Content>pagerows</Param_Content><Param_Name>pagerows</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value>20</Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 3) + "</Param_Index><Param_Content>order</Param_Content><Param_Name>order</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 4) + "</Param_Index><Param_Content>sort</Param_Content><Param_Name>sort</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 5) + "</Param_Index><Param_Content>where</Param_Content><Param_Name>where</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 6) + "</Param_Index><Param_Content>searchFilter</Param_Content><Param_Name>searchFilter</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
        + "</List></Root>";
    return xml;
}

function AddParamPage_OnClick() {

    var XMLData = GetParamPageXML();

    $.ajax({
        url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
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
                    $('#divParamInfo').datagrid("unselectAll");
                    $('#divParamInfo').datagrid("reload");
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

function AddParam_OnClick(isEdit) {
    selected_Param_Row = $('#divParamInfo').datagrid('getSelected');

    if (isEdit && !selected_Param_Row) {
        alert("请选择要编辑的行！");
        return;
    }
    if (isEdit) {

        $('#divEditWSParam').window({
            title: "编辑",
            width: 600,
            height: 530,
            top: 20,
            modal: true
        });

        $('#txtParam_ID_Show').val(selected_Param_Row.param_id);
        $('#txtParam_ID').val(selected_Param_Row.param_id);
        $('#txtParam_Index').val(selected_Param_Row.param_index);
        $('#txtParam_Content').val(selected_Param_Row.param_content);
        $('#txtParam_Name').val(selected_Param_Row.param_name);
        $('#txtParam_Type').combobox('setValue', selected_Param_Row.param_type);
        $('#txtParam_Must_Flag').combobox('setValue', selected_Param_Row.param_must_flagint);
        $('#txtDefault_Value').val(selected_Param_Row.default_value);

    }
    else {
        $('#divEditWSParam').window({
            title: "添加",
            width: 600,
            top: 20,
            height: 530,
            modal: true
        });

        $('#txtParam_ID_Show').val('系统自动生成');
        $('#txtParam_ID').val('');
        $('#txtParam_Index').val('');
        $('#txtParam_Content').val('');
        $('#txtParam_Name').val('');
        $('#txtParam_Type').combobox('setValue', 'string');
        $('#txtParam_Must_Flag').combobox('setValue', '0');
        $('#txtDefault_Value').val('');

    }
    $('#form_ParamEdit').form('validate');
    $('#txtParam_Index').focus();
}




function DeployToProd_OnClick() {
    if (!selected_Row) {
        alert("请先选择需要被同步的行");
        return;
    }

    $('#txtWS_ID').val(selected_Row.ws_id);
    $('#form_Edit').form('submit', {
        onSubmit: function () {
            var data = $('#form_Edit').serializeArray();

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('c1983dc1-513f-4a42-bd7e-3de8be972fb5'),
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
                            $.messager.progress('close');
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
    });

}

function Edit_OnClick(IsCopy) {
    if (!selected_Row) {
        alert("请先选择需要被复制的行");
        return;
    }

    if (IsCopy) {
        $('#divEditWSRR').window({
            title: "复制",
            width: 600,
            height: 530,
            top: 20,

            modal: true
        });

        $('#txtWS_IDSrc').val(selected_Row.ws_id);
        $('#txtWS_ID').val("");
        $('#txtWS_ID_Show').val("系统自动生成");
    }
    else {
        $('#divEditWSRR').window({
            title: "编辑",
            width: 600,
            top: 20,
            height: 530,
            modal: true
        });

        $('#txtWS_ID').val(selected_Row.ws_id);
        $('#txtWS_ID_Show').val(selected_Row.ws_id);
    }

    $('#txtWS_Name').val(selected_Row.ws_name);
    $('#txtWS_Type').combobox('setValue', selected_Row.ws_type);
    $('#txtWS_Help').val(selected_Row.ws_help);
    $('#txtWS_Host_Prod').val(selected_Row.ws_host_prod);
    $('#txtWS_Host_Test').val(selected_Row.ws_host_test);
    $('#txtWS_URL').val(selected_Row.ws_url);
    $('#txtWS_State').combobox('setValue', selected_Row.ws_state);
    $('#txtWS_Vision').val(selected_Row.ws_vision);
    $('#txtWS_Method').val(selected_Row.ws_method);
    $('#txtWS_Vision').val(selected_Row.ws_vision);
    $('#txtClass_ID').combobox('setValue', selected_Row.class_id);
    $('#txtWS_Unicode').combobox('setValue', selected_Row.ws_unicode);
    $('#txtNeed_Login').combobox('setValue', selected_Row.need_loginint);

    $('#form_Edit').form('validate');
    $('#txtWS_Name').focus();

}

function Edit_Submit() {
    $('#form_Edit').form('submit', {
        //url: '?action=WSSubmit',
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                return false;
            }

            var data = $('#form_Edit').serializeArray();

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e'),
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

                            $('#divEditWSRR').window('close');
                            $('#tab_list').datagrid("reload");
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

function Edit_ParamSubmit() {

    $('#form_ParamEdit').form('submit', {
        onSubmit: function () {
            var data = $('#form_ParamEdit').serializeArray();
            data[data.length] = { "name": "txtWS_ID", "value": selected_Row.ws_id }
            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
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
                            //$.messager.progress('close');
                            $('#divEditWSParam').window('close');
                            $('#divParamInfo').datagrid("unselectAll");
                            $('#divParamInfo').datagrid("reload");
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

        }
    });
}

function DeleteParam_OnClick() {
    var selected = $('#divParamInfo').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtParam_ID", "value": selected.param_id }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
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
                            $('#divParamInfo').datagrid("unselectAll");
                            $('#divParamInfo').datagrid("reload");
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
