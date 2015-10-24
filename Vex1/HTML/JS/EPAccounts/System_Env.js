var selected_Row;
var RowId;
var editIndex = undefined;
// 开发人员： 刘洪
//初始化

$(function () {
    InitGird();
    //公司
    $('#cmbCompany_ID').combobox({
        url: GetComboxWSRRURL('95d40017-0ad5-499f-a379-f06fe61aa755') + "&pagerows=20000&XML=" + GetGetJson([]),
        required: true,
        editable: true,
        width: 200,
        height: 34,
        valueField: 'id',
        textField: 'text'
    });
    //系统列表
    $('#cmbSystem_ID').combobox({
        url: GetComboxWSRRURL('d15b4b45-de9a-4683-b0e6-d6ee3bb1ca3d', "", "System_ID", "System_Name") + "&pagerows=20000&XML=" + GetGetJson([]),
        required: true,
        editable: false,
        width: 200,
        height: 34,
        valueField: 'id',
        textField: 'text'
    });
})

//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
            {
                //title: '环境列表', //表格标题
                url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'), //请求数据的页面
                queryParams: { "XML": GetGetJson([{ "entity": "entity"}]) },
                nowrap: true, //是否换行，True 就会把数据显示在一行里
                striped: true, //True 奇偶行使用不同背景色
                collapsible: false, //可折叠
                remoteSort: true, //定义是否从服务器给数据排序
                fit: true,
                singleSelect: true, //单行选择
                frozenColumns: [[//冻结的列，不会随横向滚动轴移动
	                {field: 'env_id', title: '环境编号', width: 60, search: true, sortable: true },
                    { field: 'env_sn', title: '环境简称', width: 100, search: true, sortable: true },
                    { field: 'env_name', title: '环境名称', width: 120, search: true, sortable: true },
                    { field: 'system_id', title: '系统编号', width: 2, hidden: true, search: true },
                    { field: 'system_name', title: '系统名称', width: 150, search: true, sortable: true }

				]],
                columns: [[
                    { field: 'company_name', title: '公司', width: 120, search: true, sortable: true },
                    { field: 'sso_login_url', title: '单点登录地址', width: 200, search: true },
                    { field: 'login_url', title: '登录主入口', width: 200, search: true },
                    { field: 'createtime', title: '创建时间', width: 140, search: false, sortable: true },
                    { field: 'updatetime', title: '修改时间', width: 140, search: false, sortable: true }
                ]],

                pagination: true, //是否开启分页
                pageNumber: 1, //默认索引页
                pageSize: 20, //默认一页数据条数
                rownumbers: true, //行号

                onClickRow: function (RowIndex, RowData) {
                    RowId = RowIndex;
                    selected_Row = RowData;
                },
                onDblClickRow: function (RowIndex, RowData) {
                    RowId = RowIndex;
                    selected_Row = RowData;

                    Edit_OnClick();
                },
                onLoadSuccess: function (data) {
                    selected_Row = undefined;
                },

                toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    Add_Row();
                }
            },
            {
                id: 'btn_Copy',
                text: '复制',
                iconCls: 'icon-add',
                handler: function () {
                    Copy_OnClick();
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    Edit_OnClick();
                }
            },
            {
                id: 'btn_Remove',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    Delete_Row();
                }
            },
            {
                id: 'btn_destroy',
                text: '销毁',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete_All();
                }
            }
        ]
            }
                );
}

function Edit_OnClick() {
    //var selected = $('#tab_list').datagrid('getSelected');

    if (!selected_Row) {
        alert("请先选中一行");
        return;
    }

    $('#Div_Edit').window({
        title: "编辑",
        width: 500,
        height: 500,
        modal: true
    });

    $('#txtEnv_ID_Show').val(selected_Row.env_id);
    $('#txtEnv_Sn').val(selected_Row.env_sn);
    $('#txtEnv_Name').val(selected_Row.env_name);
    $('#cmbSystem_ID').combobox('setValue', selected_Row.system_id);
    $('#cmbCompany_ID').combobox('setValue', selected_Row.company_id);

    $('#txtSSO_Login_URL').val(selected_Row.sso_login_url);
    $('#txtLogin_URL').val(selected_Row.login_url);

    $('#form_Edit').form('validate');
}

function Copy_OnClick() {
    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert("请先选中一行");
        return;
    }

    $('#Div_Edit').window({
        title: "复制新增",
        width: 500,
        height: 500,
        modal: true
    });

    $('#txtEnv_ID_Show').val('系统生成');
    $('#txtEnv_Sn').val('');
    $('#txtEnv_Name').val('');
    $('#cmbSystem_ID').combobox('setValue', selected_Row.system_id);
    $('#cmbCompany_ID').combobox('setValue', selected_Row.company_id);
    $('#txtSSO_Login_URL').val(selected_Row.sso_login_url);
    $('#txtLogin_URL').val(selected_Row.login_url);

    $('#form_Edit').form('validate');
}

function Add_Row() {

        $('#txtEnv_ID_Show').val('系统生成');
        $('#txtEnv_Sn').val(''); ;
        $('#txtEnv_Name').val('');
        $('#cmbSystem_ID').combobox('setValue', '');
        $('#cmbCompany_ID').combobox('setValue', '');
        $('#txtSSO_Login_URL').val('');
        $('#txtLogin_URL').val('');

        $('#Div_Edit').window({
            title: "新增",
            width: 500,
            height: 500,
            modal: true
        });
        //        $('#txtSupplier_Code').val('系统生成');

        $('#form_Edit').form('validate');
}
//结束编辑

//function endEditing() {
//    if (editIndex == undefined) { return true }
//    if ($('#tab_list').datagrid('validateRow', editIndex)) {
//        var ed = $('#tab_list').datagrid('getEditor', { index: editIndex, field: 'env_id' });
//        $('#tab_list').datagrid('endEdit', editIndex);
//        editIndex = undefined;
//        return true;
//    }
//    else {
//        return false;
//    }
//}


//提交按钮方法
function Edit_Submnit() {

    $('#form_Edit').form('submit', {
        onSubmit: function () {
            if ($('#form_Edit').form('validate') == false) {
                return $('#form_Edit').form('validate');
            }
            var data = $('#form_Edit').serializeArray();
            var dataIDShow = $('#txtEnv_ID_Show').val();

            $('#Div_Edit').window('close');

            if (dataIDShow == "系统生成") {
                data[data.length] = { "name": "txtEnv_id", "value": dataIDShow }
                data[data.length] = { "name": "txtCreatetime", "value": "" }
                data[data.length] = { "name": "txtUpdatetime", "value": "" }
                var XMLData = GetFormJson(data, 'INSERT');
            }
            else {
                data[data.length] = { "name": "txtEnv_id", "value": dataIDShow }
                data[data.length] = { "name": "txtUpdatetime", "value": "" }
                var XMLData = GetFormJson(data, 'UPDATE');
            }

            $.messager.progress({ title: '请稍后', msg: '处理中...' });

            $.ajax({
                url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'),
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
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
            return false;
        }
    });
}



//删除按钮方法

function Delete_Row() {
    if (!selected_Row) {
        alert("请先选中一行!");
        return;
    }
    var deleteMessage = '您确定要删除该行数据吗?';

    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtEnv_id", "value": selected_Row.env_id }
            data[data.length] = {"name":"txtEnv_Name","value":selected_Row.env_name}
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'),
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

function Delete_All() {
    if (!selected_Row) {
        alert("请先选中一行!");
        return;
    }

    var deleteMessage = '您确定要销毁该环境吗？！';

    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtEnv_id", "value": selected_Row.env_id }
            data[data.length] = { "name": "txtEnv_Name", "value": selected_Row.env_name }
            var XMLData = GetFormJson(data, 'ALLDELETE');

            $.ajax({
                url: GetWSRRURL('6d171a64-a0b1-4468-a0d7-af219c35b049'),
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