
//初始化

$(function () {
    InitGird();
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
            {
                title: '施工单位档案', //表格标题
                url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'), //请求数据的页面
                queryParams: { "XML": GetGetJson([]) },
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                remoteSort: true, //定义是否从服务器给数据排序
                fit: true,
                singleSelect: true, //单行选择
                frozenColumns: [[//冻结的列，不会随横向滚动轴移动
                    {field: 'orgid', title: '编号', width: 50, search: true, sortable: true },
	                { field: 'name', title: '施工单位', width: 180, search: true, sortable: true },
                    { field: 'assitenid', title: '助记码', width: 70, search: true, sortable: true },
                    { field: 'linkman', title: '联系人', width: 120, search: true, sortable: true },
                    { field: 'tel', title: '联系方式', width: 140, search: true },
                    { field: 'chk_surename', title: '审核', width: 50, search: true, sortable: true }

				]],
                columns: [[
                    { field: 'crname', title: '创建人', width: 120, search: true },
                    { field: 'createtime', title: '创建时间', width: 140, search: false, sortable: true },
                    { field: 'comment', title: '备注', width: 200, search: true, sortable: true }
                ]],

                pagination: true, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 20, //默认一页数据条数
                rownumbers: true, //行号

                onClickRow: function (RowIndex, RowData) {
                    var RowId = RowIndex;
                    var selected_Row = RowData;
                    if (selected_Row.chk_sure == "1") {
                        $('#btn_Checkno').linkbutton('enable');
                        $('#btn_Edit').linkbutton('disable');
                        $('#btn_Remove').linkbutton('disable');
                        $('#btn_Checkyes').linkbutton('disable');
                    } else {
                        $('#btn_Checkno').linkbutton('disable');
                        $('#btn_Edit').linkbutton('enable');
                        $('#btn_Remove').linkbutton('enable');
                        $('#btn_Checkyes').linkbutton('enable');
                    }
                },
                onDblClickRow: function () {
                    Edit_Rows();
                },
                onLoadSuccess: function (data) {
                    $('#btn_Checkno').linkbutton('enable');
                    $('#btn_Edit').linkbutton('enable');
                    $('#btn_Remove').linkbutton('enable');
                    $('#btn_Checkyes').linkbutton('enable');
                },

                toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    Add_Rows();
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_Rows();
                }
            },
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete_Row()
                }
            },
            '-',
            {
                id: 'btn_Checkyes',
                text: '审核',
                iconCls: 'icon-ok',
                handler: function () {
                    Check_Row(true);
                }
            },
            {
                id: 'btn_Checkno',
                text: '反审核',
                iconCls: 'icon-no',
                handler: function () {
                    Check_Row(false);
                }
            }

        ]
            }
                );
}

//新增按钮方法
function Add_Rows() {
    $('#divCreatOrg').window({
        title: '档案新增',
        top: 30
    });

    $('#divCreatOrg').window("open");

    $('divCreatOrg,#txtname').val('');
    $('divCreatOrg,#txtassitenid').val('');
    $('divCreatOrg,#txtlinkman').val('');
    $('divCreatOrg,#txttel').val('');
    $('divCreatOrg,#txtvericode').val('');
    $('divCreatOrg,#txtcomment').val('');

    $('divCreatOrg,#txtname').focus();
    $('#formCreate').form('validate');
}

//编辑按钮方法
function Edit_Rows() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    if (selected_Row) {
        if (selected_Row.chk_sure == "0") {
            $('#divEditOrg').window({
                title: '档案编辑',
                top: 30
            });

            $('#divEditOrg').window("open");


            $('divEditOrg,#txtname').val(selected_Row.name);
            $('divEditOrg,#txtorgid').val(selected_Row.orgid);
            $('divEditOrg,#txtcrname').val(selected_Row.crname);
            $('divEditOrg,#txtcreatetime').val(selected_Row.createtime);
            $('divEditOrg,#txtassitenid').val(selected_Row.assitenid);
            $('divEditOrg,#txtlinkman').val(selected_Row.linkman);
            $('divEditOrg,#txttel').val(selected_Row.tel);
            $('divEditOrg,#txtcomment').val(selected_Row.comment);
            $('divEditOrg,#txtvericode').val(selected_Row.vericode);

            $('divEditOrg,#txtassitenid').focus();
        } else {
            return;
        }
    } else {
        alert("请选择一行");
        return;
    };
}

//取消按钮方法
function Edit_Cancel(type) {
    if (type) {
        $('#divCreatOrg').window('close');
    } else {
        $('#divEditOrg').window('close');
    };
}

//保存按钮方法
//type是bool类型，true代表新建保存，false代表编辑保存。
function Create_Submnit(type) {
    if (type) {
        $('#formCreate').form('submit', {
            onSubmit: function () {
                if ($('#formCreate').form('validate') == false) {
                    return $('#formCreate').form('validate');
                }
                var data = $('#formCreate').serializeArray();
                //$('#divCreatOrg').window('close');

                data[data.length] = { "name": "intchk_sure", "value": "0" };
                data[data.length] = { "name": "txtcrname", "value": "" };
                data[data.length] = { "name": "txtcreatetime", "value": "" };

                var XMLData = GetFormJson(data, 'INSERT');
                $.messager.progress({ title: '请稍后', msg: '处理中...' });

                $.ajax({
                    url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'),
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
                                $('#divCreatOrg').window('close');
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.progress('close');

                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#tab_list').datagrid("reload");
                    },
                    error: function () {
                        $.messager.alert("提示", "提交错误了！", 'error');
                    }
                });
                return false;
            }
        });
    } else {
        var selected_Row = $('#tab_list').datagrid('getSelected');
        $('#formEdit').form('submit', {
            onSubmit: function () {
                if ($('#formEdit').form('validate') == false) {
                    return $('#formEdit').form('validate');
                }
                var data = $('#formEdit').serializeArray();

                data[data.length] = { "name": "intchk_sure", "value": selected_Row.chk_sure };
                data[data.length] = { "name": "txtorgid", "value": selected_Row.orgid };
                data[data.length] = { "name": "txtupdatetime", "value": "" };
                //一个tag,告诉后台UPDATE类型。
                data[data.length] = { "name": "txtupdatetag", "value": "data" };

                var XMLData = GetFormJson(data, 'UPDATE');
                $.messager.progress({ title: '请稍后', msg: '处理中...' });

                $.ajax({
                    url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'),
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
                                $('#divEditOrg').window('close');
                                $.messager.alert("提示", result[0].rows[0].message);
                            }
                        } catch (ex) {
                            $.messager.progress('close');

                            $.messager.alert("提示", ex, 'error');
                        }
                        $('#tab_list').datagrid("reload");
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
//审核/反审核按钮方法
// type为bool型，主要功能是 确定是什么按钮 true（审核）/false（反审核）
function Check_Row(type) {
    if (type) {
        var selected_Row = $('#tab_list').datagrid('getSelected');
        if (selected_Row) {
            var data = [];
            data[data.length] = { "name": "txtorgid", "value": selected_Row.orgid };
            data[data.length] = { "name": "txtchk_sure", "value": selected_Row.chk_sure };
            data[data.length] = { "name": "txtupdatetag", "value": "sure" };

            var XMLData = GetFormJson(data, 'UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中...' });

            $.ajax({
                url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'),
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
                    $.messager.progress('close');
                    $('#tab_list').datagrid("reload");
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });

        } else {
            alert("请选择一行");
            return;
        }

    } else {
        var selected_Row = $('#tab_list').datagrid('getSelected');
        if (selected_Row) {
            var data = [];
            data[data.length] = { "name": "txtorgid", "value": selected_Row.orgid };
            data[data.length] = { "name": "txtchk_sure", "value": selected_Row.chk_sure };
            data[data.length] = { "name": "txtupdatetag", "value": "nsure" };

            var XMLData = GetFormJson(data, 'UPDATE');
            $.messager.progress({ title: '请稍后', msg: '处理中...' });

            $.ajax({
                url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'),
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
                    $.messager.progress('close');
                    $('#tab_list').datagrid("reload");
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        } else {
            alert("请选择一行");
            return;
        }
    }
}

//删除按钮的方法。
function Delete_Row() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    if (selected_Row) {
        if (selected_Row.chk_sure == "1") {
            alert("已审核，无法删除");
            return;
        }

        $.messager.confirm('提示框', '你确定要删除该档案吗?', function (r) {
            if (r) {
            var data = [];
            data[data.length] = { "name": "txtorgid", "value": selected_Row.orgid };

            var XMLData = GetFormJson(data, 'DELETE');
            $.messager.progress({ title: '请稍后', msg: '处理中...' });

            $.ajax({
                url: GetWSRRURL('7d0ffd5e-ba2f-45f6-9f77-4500e5ac6474'),
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
                    $.messager.progress('close');
                    $('#tab_list').datagrid("reload");
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
                })
            }
        })
    } else {
        alert("请选择一行");
        return;
    };
}