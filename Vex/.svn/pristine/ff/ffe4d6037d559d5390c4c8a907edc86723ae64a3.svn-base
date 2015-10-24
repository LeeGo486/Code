var selected_Row;

//初始化
$(function () {
    InitGird();
    $('#cmbRouteType').combobox({
        //url: GetComboxWSRRURL('28fe6da4-452d-4d23-ae90-7b3226f2ecf1', "Route_Type"),
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "Route_Type"),
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

});


//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            //title: 'WS列表', //表格标题
            url: GetWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd'),
            queryParams: { "XML": GetGetJson([]) },
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	            { field: 'routeid', title: '编号', width: 150, hidden:true },
	            { field: 'name', title: '路由名称', width: 200, search: true, sortable: true }

            ]],
            columns: [[
                { field: 'serverpath', title: '服务地址', width: 160, search: true, sortable: true },
                { field: 'dbservercfg', title: '数据库配置值', width: 160, search: true, sortable: true },
                { field: 'routetype', title: '路由类型', width: 60, sortable: true },
                { field: 'mark', title: '备注', width: 260, sortable: true },
                { field: 'createtime', title: '创建时间', width: 80, sortable: true, formatter: Formater.Date },
                { field: 'createuser', title: '创建人', width: 50, sortable: true },
                { field: 'updatetime', title: '更新时间', width: 80, sortable: true, formatter: Formater.Date },
                { field: 'updateuser', title: '更新人', width: 50, sortable: true }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            onDblClickRow: function () { Edit_OnClick(true); },
            onClickRow: function (rowIndex, rowData) { ClickRowGrid(rowIndex, rowData); },

            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    Edit_OnClick(false);
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
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

function ClickRowGrid(rowIndex, rowData) {
    selected_Row = rowData;
}


////初始化参数信息
//function InitParamInfo() {


//    $('#divParamInfo').datagrid(
//            {
//                title: selected_Row.ws_name, //表格标题
//                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
//                queryParams: { "XML": GetGetJson([{ "ws_id": selected_Row.ws_id }]) },
//                sortName: 'param_index', //排序字段
//                sortable: true,
//                idField: 'system_id', //标识字段,主键
//                iconCls: '', //标题左边的图标
//                width: '90%', //宽度
//                height: $(document).height() - 20, //高度
//                nowrap: false, //是否换行，True 就会把数据显示在一行里
//                striped: true, //True 奇偶行使用不同背景色
//                collapsible: false, //可折叠
//                sortOrder: 'asc', //排序类型
//                remoteSort: false, //定义是否从服务器给数据排序
//                fit: true,
//                singleSelect: true, //单行选择
//                columns: [[
//                    { field: 'param_id', title: '编号', width: 30, hidden: true },
//                    { field: 'param_index', title: '序号', width: 30 },
//                    { field: 'param_content', title: '说明', width: 80 },
//                    { field: 'param_name', title: '参数名', width: 80 },
//                    { field: 'param_type', title: '参数类型', width: 50 },
//                    { field: 'param_must_flag', title: '必须', width: 80 },
//                    { field: 'Param_Must_Flagint', title: '必须', width: 80, hidden: true },
//                    {
//                        field: 'default_value', title: '默认值', width: 250, title: true
//                        , formatter: function (value, row, index) {
//                            var content = '<div title="' + value + '">' + value + '</div>';
//                            return content;
//                        }
//                    }
//                ]],

//                onDblClickRow: function () { AddParam_OnClick(true); },
//                onClickRow: function () { ClickParamRowGrid(); },
//                toolbar: [
//                {
//                    id: 'btn_AddParam',
//                    text: '添加',
//                    iconCls: 'icon-add',
//                    handler: function () {
//                        AddParam_OnClick();
//                    }
//                },
//                {
//                    id: 'btn_EditParam',
//                    text: '编辑',
//                    iconCls: 'icon-edit',
//                    handler: function () {
//                        AddParam_OnClick(true);
//                    }
//                },
//                {
//                    id: 'btn_DeleteParam',
//                    text: '删除',
//                    iconCls: 'icon-remove',
//                    handler: function () {
//                        DeleteParam_OnClick();
//                    }
//                },
//                {
//                    id: 'btn_AddParamPage',
//                    text: '添加分页信息',
//                    iconCls: 'icon-add',
//                    handler: function () {
//                        AddParamPage_OnClick();
//                    }
//                }]

//            }
//            );

//}

//function ClickParamRowGrid() {
//    //                var selected = $('#divParamInfo').datagrid('getSelected');
//    //                selected_Param_Row = selected;
//}

//function GetParamPageXML() {
//    var ws_id = selected_Row.ws_id;
//    var maxRowIndex = 0;

//    var data_Param = $("#divParamInfo").datagrid("getData");
//    if (data_Param.rows.length > 0) {
//        maxRowIndex = parseInt(data_Param.rows[data_Param.rows.length - 1].param_index);
//    }


//    var xml = "<Root><OPTYPE>EDIT</OPTYPE><List>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 1) + "</Param_Index><Param_Content>page</Param_Content><Param_Name>page</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value>1</Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 2) + "</Param_Index><Param_Content>pagerows</Param_Content><Param_Name>pagerows</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value>20</Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 3) + "</Param_Index><Param_Content>order</Param_Content><Param_Name>order</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 4) + "</Param_Index><Param_Content>sort</Param_Content><Param_Name>sort</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 5) + "</Param_Index><Param_Content>where</Param_Content><Param_Name>where</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "<Rows><Param_ID></Param_ID><Param_Index>" + (maxRowIndex + 6) + "</Param_Index><Param_Content>searchFilter</Param_Content><Param_Name>searchFilter</Param_Name><Param_Type>string</Param_Type><Param_Must_Flag>2</Param_Must_Flag><Default_Value></Default_Value><WS_ID>" + ws_id + "</WS_ID></Rows>"
//        + "</List></Root>";
//    return xml;
//}

//function AddParamPage_OnClick() {

//    var XMLData = GetParamPageXML();

//    $.ajax({
//        url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
//        type: 'post',
//        async: true, //异步,
//        data: { "XML": XMLData },
//        success: function (result) {
//            try {
//                var result = eval("[" + result + "]");

//                if (result[0].Error) {
//                    $.messager.progress('close');

//                    $.messager.alert("系统错误", result[0].Error, 'error');
//                }
//                else if (result[0].rows[0].result == "False") {

//                    $.messager.progress('close');

//                    $.messager.alert("提示", result[0].rows[0].message, 'error');
//                }
//                else {
//                    $('#divParamInfo').datagrid("unselectAll");
//                    $('#divParamInfo').datagrid("reload");
//                }
//            } catch (ex) {
//                $.messager.progress('close');

//                $.messager.alert("提示", ex, 'error');
//            }
//        },
//        error: function () {
//            $.messager.alert("提示", "提交错误了！", 'error');
//        }
//    });
//}

//function AddParam_OnClick(isEdit) {
//    selected_Param_Row = $('#divParamInfo').datagrid('getSelected');

//    if (isEdit && !selected_Param_Row) {
//        alert("请选择要编辑的行！");
//        return;
//    }
//    if (isEdit) {

//        $('#divEditWSParam').window({
//            title: "编辑",
//            width: 600,
//            height: 530,
//            top: 20,
//            modal: true
//        });

//        $('#txtParam_ID_Show').val(selected_Param_Row.param_id);
//        $('#txtParam_ID').val(selected_Param_Row.param_id);
//        $('#txtParam_Index').val(selected_Param_Row.param_index);
//        $('#txtParam_Content').val(selected_Param_Row.param_content);
//        $('#txtParam_Name').val(selected_Param_Row.param_name);
//        $('#txtParam_Type').combobox('setValue', selected_Param_Row.param_type);
//        $('#txtParam_Must_Flag').combobox('setValue', selected_Param_Row.param_must_flagint);
//        $('#txtDefault_Value').val(selected_Param_Row.default_value);

//    }
//    else {
//        $('#divEditWSParam').window({
//            title: "添加",
//            width: 600,
//            top: 20,
//            height: 530,
//            modal: true
//        });

//        $('#txtParam_ID_Show').val('系统自动生成');
//        $('#txtParam_ID').val('');
//        $('#txtParam_Index').val('');
//        $('#txtParam_Content').val('');
//        $('#txtParam_Name').val('');
//        $('#txtParam_Type').combobox('setValue', 'string');
//        $('#txtParam_Must_Flag').combobox('setValue', '0');
//        $('#txtDefault_Value').val('');

//    }
//    $('#form_ParamEdit').form('validate');
//    $('#txtParam_Index').focus();
//}




//function DeployToProd_OnClick() {
//    if (!selected_Row) {
//        alert("请先选择需要被同步的行");
//        return;
//    }

//    $('#txtWS_ID').val(selected_Row.ws_id);
//    $('#form_Edit').form('submit', {
//        onSubmit: function () {
//            var data = $('#form_Edit').serializeArray();

//            var XMLData = GetFormJson(data, 'EDIT');

//            $.ajax({
//                url: GetWSRRURL('c1983dc1-513f-4a42-bd7e-3de8be972fb5'),
//                type: 'post',
//                async: true, //异步,
//                data: { "XML": XMLData },
//                success: function (result) {
//                    try {
//                        var result = eval("[" + result + "]");

//                        if (result[0].Error) {
//                            $.messager.progress('close');

//                            $.messager.alert("系统错误", result[0].Error, 'error');
//                        }
//                        else if (result[0].rows[0].result == "False") {

//                            $.messager.progress('close');

//                            $.messager.alert("提示", result[0].rows[0].message, 'error');
//                        }
//                        else {
//                            $.messager.progress('close');
//                            $.messager.alert("提示", result[0].rows[0].message);
//                        }
//                    } catch (ex) {
//                        $.messager.progress('close');

//                        $.messager.alert("提示", ex, 'error');
//                    }
//                },
//                error: function () {
//                    $.messager.alert("提示", "提交错误了！", 'error');
//                }
//            });

//        }
//    });

//}

function Edit_OnClick(pbEdit) {
    if (!selected_Row && pbEdit) {
        alert("请先选择需要被编辑的行");
        return;
    }

    if (pbEdit) {
        $('#divEdit').window({
            title: "编辑",
            top: 20,
            modal: true
        });

        $('#txtRouteID_Show').val(selected_Row.routeid);
        $('#txtRouteID').val(selected_Row.routeid);

        $('#txtName').val(selected_Row.name);
        $('#cmbRouteType').combobox('setValue', selected_Row.routetype);
        $('#txtServerPath').val(selected_Row.serverpath);
        $('#txtMark').val(selected_Row.mark);
        $('#txtUpdateTime').val(selected_Row.updatetime);
    }
    else {
        $('#divEdit').window({
            title: "添加",
            top: 20,
            modal: true
        });

        $('#txtRouteID_Show').val("系统自动生成");
        $('#txtRouteID').val("");

        $('#txtName').val("");
        $('#cmbRouteType').combobox('setValue', "开发");
        $('#txtServerPath').val("");
        $('#txtMark').val("");

    }

    //$('#form_Edit').form('validate');
    $('#txtName').focus();

}

function EditCancel() {
    $('#divEdit').window('close');

}
function EditSubmit() {
    $('#form_Edit').form('submit', { 
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                return false;
            }

            var data = $('#form_Edit').serializeArray();

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd'),
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

                            $('#divEdit').window('close');
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

//function Edit_ParamSubmit() {

//    $('#form_ParamEdit').form('submit', {
//        onSubmit: function () {
//            var data = $('#form_ParamEdit').serializeArray();
//            data[data.length] = { "name": "txtWS_ID", "value": selected_Row.ws_id }
//            var XMLData = GetFormJson(data, 'EDIT');

//            $.ajax({
//                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
//                type: 'post',
//                async: true, //异步,
//                data: { "XML": XMLData },
//                success: function (result) {
//                    try {
//                        var result = eval("[" + result + "]");
//                        if (result[0].Error) {
//                            $.messager.progress('close');

//                            $.messager.alert("系统错误", result[0].Error, 'error');
//                        }
//                        else if (result[0].rows[0].result == "False") {

//                            $.messager.progress('close');

//                            $.messager.alert("提示", result[0].rows[0].message, 'error');
//                        }
//                        else {
//                            //$.messager.progress('close');
//                            $('#divEditWSParam').window('close');
//                            $('#divParamInfo').datagrid("unselectAll");
//                            $('#divParamInfo').datagrid("reload");
//                            //$.messager.alert("提示", result[0].rows[0].message);
//                        }
//                    } catch (ex) {
//                        $.messager.progress('close');

//                        $.messager.alert("提示", ex, 'error');
//                    }
//                },
//                error: function () {
//                    $.messager.alert("提示", "提交错误了！", 'error');
//                }
//            });

//        }
//    });
//}

//function DeleteParam_OnClick() {
//    var selected = $('#divParamInfo').datagrid('getSelected');
//    if (!selected) {
//        alert('请选择一行');
//        return;
//    }
//    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
//        if (r) {
//            var data = eval("[]");
//            data[data.length] = { "name": "txtParam_ID", "value": selected.param_id }
//            var XMLData = GetFormJson(data, 'DELETE');

//            $.ajax({
//                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034'),
//                type: 'post',
//                async: true, //异步,
//                data: { "XML": XMLData },
//                success: function (result) {
//                    try {
//                        var result = eval("[" + result + "]");
//                        if (result[0].Error) {
//                            $.messager.progress('close');

//                            $.messager.alert("系统错误", result[0].Error, 'error');
//                        }
//                        else if (result[0].rows[0].result == "False") {
//                            $.messager.alert("提示", result[0].rows[0].message, 'error');
//                        }
//                        else {
//                            $('#divParamInfo').datagrid("unselectAll");
//                            $('#divParamInfo').datagrid("reload");
//                            //$.messager.alert("提示", result[0].rows[0].message);
//                        }
//                    } catch (ex) {
//                        $.messager.alert("提示", ex, 'error');
//                    }
//                },
//                error: function () {
//                    $.messager.alert("提示", "提交错误了！", 'error');
//                }
//            });
//        }
//    })
//};
