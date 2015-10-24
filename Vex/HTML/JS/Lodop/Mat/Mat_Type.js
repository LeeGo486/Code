var RowId;
// 开发者: 刘洪
//初始化
$(function () {
    InitGird();
})

//初始化种类数据
function InitGird() {
    $('#tab_list').datagrid(
            {
                url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'), //请求数据的页面
                queryParams: { "XML": GetGetJson([]), "WHERE": "parentid=0" },
                title: "设备种类",
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                remoteSort: true, //定义是否从服务器给数据排序
                fit: true,
                singleSelect: true, //单行选择
                frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	                {field: 'typeid', title: '种类编号', width: 60, search: true, sortable: true },
                    { field: 'typename', title: '种类名称', width: 120, search: true, sortable: true },
                    { field: 'chk_surename', title: '审核状态', width: 60, search: true, sortable: true }

				]],
                columns: [[
                    { field: 'chk_date', title: '审核日期', width: 150, search: true },
                    { field: 'chk_name', title: '审核人', width: 100, search: true, sortable: true },
                    { field: 'createtime', title: '创建时间', width: 120, search: true, sortable: true },
                    { field: 'crname', title: '创建人', width: 100, search: true },
                //                    { field: 'updatetime', title: '更新时间', width: 120, search: true },
                    {field: 'comment', title: '备注', width: 300, search: false, sortable: true }
                ]],

                pagination: true, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 20, //默认一页数据条数
                rownumbers: true, //行号

                onClickRow: function (RowIndex, RowData) {

                    if (RowId == RowIndex) {
                        return;
                    }
                    else {
                        RowId = RowIndex;
                        var selected_Row = RowData;
                        //控制按钮功能
                        if (selected_Row.chk_sure == "1") {
                            $('#btn_Reject').linkbutton('enable');
                            $('#btn_Check').linkbutton('disable');
                            $('#btn_Remove').linkbutton('disable');
                        } else {
                            $('#btn_Reject').linkbutton('disable');
                            $('#btn_Check').linkbutton('enable');
                            $('#btn_Remove').linkbutton('enable');
                        }
                        //刷新品类
                        InitParamInfo(selected_Row);
                    };
                },
                onLoadSuccess: function (data) {
                    RowId = undefined;
                    selected_Row = undefined;
                    ClearGrid("#divParamInfo");
                },

                toolbar: [
            {
                id: 'btn_AddCenter',
                text: '种类新增',
                iconCls: 'icon-add',
                handler: function () {
                    Add_Windows("bigClass");
                }
            },
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Del_Row(true);
                }
            },
            '-',
            {
                id: 'btn_Check',
                text: '审核',
                iconCls: 'icon-ok',
                handler: function () {
                    Edit_Row("yes");
                }
            },
            {
                id: 'btn_Reject',
                text: '反审核',
                iconCls: 'icon-no',
                handler: function () {
                    Edit_Row("no");
                }
            }
        ]
            }
                );
}

//初始化品类数据
function InitParamInfo(selected_Row) {
    ClearGrid("#divParamInfo");
    $('#divParamInfo').datagrid(
            {
                url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
                queryParams: { "XML": GetGetJson([]), "WHERE": "parentid=" + selected_Row.typeid },
                sortName: 'typeid', //排序字段
                sortable: true,
                iconCls: '', //标题左边的图标
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                sortOrder: 'desc', //排序类型
                remoteSort: false, //定义是否从服务器给数据排序
                fit: true,
                singleSelect: true, //单行选择
                frozenColumns: [[//冻结的列，不会随横向滚动轴移动
                    {field: 'typeid', title: '品类编号', width: 60 },
                    { field: 'typename', title: '品类名称', width: 100 },
                    { field: 'chk_surename', title: '审核状态', width: 40 }
				]],
                columns: [[
                    { field: 'chk_date', title: '审核时间', width: 72 },
                    { field: 'chk_name', title: '审核人', width: 50 },
                    { field: 'createtime', title: '创建时间', width: 72 },
                    { field: 'crname', title: '创建人', width: 50 },
                    { field: 'comment', title: '备注', editor: 'text', width: 80 }
                ]],

                onDblClickRow: function (rowIndex, rowData) {
                    var rowid = rowIndex;
                    var select_Row = rowData;
                    if (select_Row.chk_sure == "0") {
                        Edit_EastRow();
                    } else {
                        return;
                    }

                },
                toolbar: [
                {
                    id: 'btn_AddEast',
                    text: '品类新增',
                    iconCls: 'icon-add',
                    disabled:true,
                    handler: function () {
                        Add_Windows("smallClass");

                    }
                },
                {
                    id: 'btn_EditParam',
                    text: '编辑',
                    disabled: true,

                    iconCls: 'icon-edit',
                    handler: function () {
                        Edit_EastRow();
                    }
                },
                {
                    id: 'btn_DeleteParam',
                    text: '删除',
                    iconCls: 'icon-remove',
                    handler: function () {
                        Del_Row(false);
                    }
                }]
            }
      );
            if (selected_Row.chk_sure == "1") {
                $('#btn_AddEast').linkbutton('disable');
                $('#btn_EditParam').linkbutton('disable');
                $('#btn_DeleteParam').linkbutton('disable');
            } else {
                $('#btn_AddEast').linkbutton('enable');
                $('#btn_EditParam').linkbutton('enable');
                $('#btn_DeleteParam').linkbutton('enable');                 
            };

}



//新增按钮方法
function Add_Windows(type) {
    if (type == "bigClass") {
        $('#AddCenter').window({
            title: "种类新增",
            top: 30
        });
        $('#AddCenter').window("open");
        $('#Bigtypename').val('');
        $('#Bigcomment').val('');
        $("#Bigtypename").focus(); // 设置焦点
        //验证数据
        $('#form_Edit').form('validate');
    }
    else {
        var selectedBig = $('#tab_list').datagrid('getSelected');
        if (!selectedBig) {
            alert("请选择一个种类");
            return;
        };
        if (selectedBig.chk_sure == 1) {
            alert("种类已审核，无法新增品类！");
            return;
        };
        $('#AddEast').window({
            title: "品类新增",
            top: 30
        });
        $('#AddEast').window("open");
        $('#txtSmaType_Name_Show').val(selectedBig.typename)
        $('#Bigparentid').val(selectedBig.typeid);
        $('#Smatypename').val('');
        $('#Smatypename').focus(); // 设置焦点
        $('#Smacomment').val('');
        //验证数据
        $('#form_Edit').form('validate');

    }

}

//East编辑操作的函数

function Edit_EastRow() {
    var selectedSmall = $('#divParamInfo').datagrid('getSelected');
    var selectedBig = $('#tab_list').datagrid('getSelected');

    //检查
    var selectedBig = $('#tab_list').datagrid('getSelected');
        if (!selectedBig) {
            alert("请选择一个种类");
            return;
        };
    if (selectedBig.chk_sure == 1) {
        alert("该品类已审核，无法编辑！");
        return;
    }
    if (!selectedSmall) {
        alert("请先选中一个品类");
        return;
    }

    $('#EditEast').window({
        title: "编辑品类",
        top: 30
    });
    $('#EditEast').window("open");
    $('#eettypename').val(selectedBig.typename);
    $('#eetparentid').val(selectedBig.typeid);
    $('#eestypename').val(selectedSmall.typename);
    $("#eestypename").focus();
    $('#eetcomment').val(selectedSmall.comment);

    $('#form_Edit').form('validate');
}

//保存按钮方法
function Edit_Submnit(TorF) {
    if (TorF) {
        // 如果TorF是true,则执行种类新增的保存.如果是false则是品类新增的保存.

        $('#formCenterAdd').form('submit', {
            onSubmit: function () {
                if ($('#formCenterAdd').form('validate') == false) {
                    return $('#formCenterAdd').form('validate');
                }
                var data = $('#formCenterAdd').serializeArray();
                $('#AddCenter').window('close');

                data[data.length] = { "name": "intparentid", "value": "0" };
                data[data.length] = { "name": "intchk_sure", "value": "0" };
                data[data.length] = { "name": "txtchk_name", "value": "" };
                data[data.length] = { "name": "datcreatetime", "value": "" };
                data[data.length] = { "name": "txtcrname", "value": "" };
                var XMLData = GetFormJson(data, 'INSERT');

                $.messager.progress({ title: '请稍后', msg: '处理中...' });

                $.ajax({
                    url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
                    type: 'post',
                    async: true, //异步,
                    data: { "XML": XMLData },
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
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.progress('close');

                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#tab_list').datagrid("reload");
                        $('#divParamInfo').datagrid("reload");
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
                return false;
            }
        });

    } else {
        $('#formEastadd').form('submit', {
            onSubmit: function () {
                if ($('#formEastadd').form('validate') == false) {
                    return $('#formEastadd').form('validate');
                }
                var data = $('#formEastadd').serializeArray();
                $('#AddEast').window('close');

                data[data.length] = { "name": "intchk_sure", "value": "0" };
                data[data.length] = { "name": "txtchk_name", "value": "" };
                data[data.length] = { "name": "datcreatetime", "value": "" };
                data[data.length] = { "name": "txtcrname", "value": "" };
                var XMLData = GetFormJson(data, 'INSERT');

                $.messager.progress({ title: '请稍后', msg: '处理中...' });

                $.ajax({
                    url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
                    type: 'post',
                    async: true, //异步,
                    data: { "XML": XMLData },
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
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.progress('close');

                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#divParamInfo').datagrid("reload");
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
                return false;
            }
        });
    };
}


//删除按钮方法
function Del_Row(TofF) {
    if (TofF) {

        var selected = $('#tab_list').datagrid('getSelected');
        //检查
        if (!selected) {
            alert("请选择一个种类");
            return;
        };

        var deleteMessage = '您确定要删除该行数据吗?';

        $.messager.confirm('提示框', deleteMessage, function (r) {
            if (r) {
                var data = [];
                data[data.length] = { "name": "txttype", "value": "BigDel" };
                data[data.length] = { "name": "inttypeid", "value": selected.typeid };
                data[data.length] = { "name": "intchk_sure", "value": selected.chk_sure };
                var XMLData = GetFormJson(data, 'DELETE');

                $.ajax({
                    url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
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
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#tab_list').datagrid("reload");
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
        })
    }
    else {
        var selected = $('#divParamInfo').datagrid('getSelected');
        //检查
        if (!selected) {
            alert("请选择一个品类");
            return;
        };

        var deleteMessage = '您确定要删除该行数据吗?';

        $.messager.confirm('提示框', deleteMessage, function (r) {
            if (r) {
                var data = [];
                data[data.length] = { "name": "txttype", "value": "SmallDel" };
                data[data.length] = { "name": "inttypeid", "value": selected.typeid };
                data[data.length] = { "name": "intchk_sure", "value": selected.chk_sure };
                var XMLData = GetFormJson(data, 'DELETE');

                $.ajax({
                    url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
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
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#divParamInfo').datagrid("reload");
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
            }
        })
    };
}


//专用于审核按钮后的East按钮状态更新
function SetToolbarDisable() {

        $('#btn_AddEast').linkbutton('disable');
        $('#btn_EditParam').linkbutton('disable');
        $('#btn_DeleteParam').linkbutton('disable');
    }

//审核按钮方法
//type类型解释：yes(代表审核)，no（代表反审核）
function Edit_Row(type) {
    if (type == "yes") {

        var selected = $('#tab_list').datagrid('getSelected');
        if (!selected) {
            alert("请选择一个种类");
            return;
        };

        var data = [];
        data[data.length] = { "name": "updtype", "value": "yes" };
        data[data.length] = { "name": "inttypeid", "value": selected.typeid };
        data[data.length] = { "name": "intchk_sure", "value": selected.chk_sure };
        data[data.length] = { "name": "intchk_name", "value": "" };
        data[data.length] = { "name": "datchk_date", "value": "" };
        var XMLData = GetFormJson(data, 'UPDATE');

        $.ajax({
            url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
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
                        $.messager.alert("提示", result[0].rows[0].message);
                        
                        $('#tab_list').datagrid("reload");
                        ClearGrid("#divParamInfo");
                        SetToolbarDisable();

                    }
                } catch (ex) {
                    $.messager.alert("提示", ex, 'error');
                }
                //                $('#tab_list').datagrid("reload");

                //                $('#divParamInfo').datagrid("reload");
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }
    else if (type == "no") {

        var selected = $('#tab_list').datagrid('getSelected');
        if (!selected) {
            alert("请选择一个种类");
            return;
        };

        var data = [];
        data[data.length] = { "name": "updtype", "value": "no" };
        data[data.length] = { "name": "inttypeid", "value": selected.typeid };
        data[data.length] = { "name": "intchk_sure", "value": selected.chk_sure };
        data[data.length] = { "name": "intchk_name", "value": "" };
        data[data.length] = { "name": "datchk_date", "value": "" };
        var XMLData = GetFormJson(data, 'UPDATE');

        $.ajax({
            url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
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
                        $.messager.alert("提示", result[0].rows[0].message);
                        $('#tab_list').datagrid("reload");
                        ClearGrid("#divParamInfo");
                        SetToolbarDisable();
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
}

//更新品类的方法
function Update_Row() {
    var selected = $('#divParamInfo').datagrid('getSelected');
    $('#formEastEdit').form('submit', {
        onSubmit: function () {
            if ($('#formEastEdit').form('validate') == false) {
                return $('#formEastEdit').form('validate');
            }
            var data = $('#formEastEdit').serializeArray();
            $('#EditEast').window('close');

            data[data.length] = { "name": "txttype", "value": "data" }; //用于后台标识，指明为更新品类数据。
            data[data.length] = { "name": "inttypeid", "value": selected.typeid };
            data[data.length] = { "name": "intchk_sure", "value": "0" };
            data[data.length] = { "name": "datupdatetime", "value": "" };
            data[data.length] = { "name": "datchk_date", "value": "" };
            data[data.length] = { "name": "txtchk_name", "value": "" };
            var XMLData = GetFormJson(data, 'UPDATE');

            $.messager.progress({ title: '请稍后', msg: '处理中...' });

            $.ajax({
                url: GetWSRRURL('0c604bc9-457b-4fdc-9dda-2e2711665061'),
                type: 'post',
                async: true, //异步,
                data: { "XML": XMLData },
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
                            $.messager.alert("提示", result[0].rows[0].message);
                            $('#divParamInfo').datagrid("reload");
                        }
                    } catch (ex) {
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

// 取消按钮方法
//type：A4（种类新增窗口取消）A3（品类新增窗口取消）A2（品类编辑窗口取消）
function Edit_Cancel(type) {
    if (type == "A4") {
        $('#AddCenter').window('close');
    } else if (type == "A3") {
        $('#AddEast').window('close');
    } else {
        $('#EditEast').window('close');
    };
}
