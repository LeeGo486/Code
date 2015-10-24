
$(function () {

    InitGird();
})
function InitGird(url) {
    $('#tab_list').datagrid(
        {
            title: '店铺审批人员以及对应小翅膀', //表格标题
            url: GetWSRRURL('008a066f-a353-4774-8ef5-3b26befde658'),
            queryParams: { "XML": GetGetJson([{}]) },
            sortName: 'store_prefix', //排序字段
            idField: 'store_prefix', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: '', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            onDblClickRow: function () { Type("EDIT"); },
            columns: [[
                { field: 'inventort_authority_id', title: '序号', width: 100, search: true, sortable: true },
                { field: 'store_prefix', title: '店铺前缀', width: 100, search: true, sortable: true },
                { field: 'areaname', title: '店铺大区', width: 100, search: true, sortable: true },
                { field: 'branch_pos', title: '分公司审批POS', width: 120, search: true, sortable: true },
                { field: 'branch_am', title: '分公司审批AM', width: 120, search: true, sortable: true },
                { field: 'general_pos', title: '总部销售审批POS', width: 120, sortable: true },
                { field: 'general_am', title: '总部销售审批AM', width: 120, sortable: true },
                { field: 'financial_pos', title: '财务确认POS', width: 120, sortable: true },
                { field: 'financial_am', title: '财务确认AM', width: 120, sortable: true },
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    Type("ADD");
                }
            },
            '-',
            {
                id: 'btn_edit',
                text: '修改',
                iconCls: 'icon-save',
                handler: function () {
                    Type("EDIT");
                }
            },
            '-',
            {
                id: 'btn_delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete();
                }
            }
            ]
        });
}


function Type(type) {

    $('#txtareaname').combobox({ required: true, editable: false, });
    $('#txtstore_prefix').combobox({
        url: GetComboxWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0', "", "店铺前缀", "店铺前缀") + "&XML=" + GetFormJson([], 'GETSTORE_PREFIX'),
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onChange: function () {
            var m_store_prefix = $('#txtstore_prefix').combobox("getValue");

            if (m_store_prefix == "") {
                return;
            }
            else {
                init_areaid(m_store_prefix);
            }
        }
    });
    function init_areaid(m_store_prefix) {
        var url = GetComboxWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0') + "&XML=" + GetFormJson([], 'GETDQ')
                + "&WHERE=SUBSTRING(depotid, 1, 1)=" + "'" + m_store_prefix + "'",
        htmlobj = $.ajax({
            url: url,
            async: false
        });
        m_areaid = $.parseJSON(htmlobj.responseText);

        $('#txtareaname').combobox({
            data: m_areaid,
            editable: false,
            valueField: 'id',
            textField: 'id'
        });
    }
    if (type == "ADD") {
        $('#form_Edit').window({
            title: "添加",
            top: 100,
            width: 500,
            height: 280,
            modal: true
        });
        $('#txtinventort_authority_id').val("");
        $('#txtstore_prefix').combobox('setValue', "");
        $('#txtareaname').combobox('setValue', "");
        $('#txtbranch_pos').val("");
        $('#txtbranch_am').val("");
        $('#txtgeneral_pos').val("");
        $('#txtgeneral_am').val("");
        $('#txtfinancial_pos').val("");
        $('#txtfinancial_am').val("");
    }
    else if (type == "EDIT") {
        var selected = $('#tab_list').datagrid('getSelected');
        if (!selected) {
            alert("请选择一条数据");
            return;
        };
        $('#form_Edit').window({
            title: "修改",
            top: 100,
            width: 500,
            height: 280,
            modal: true
        });
        $('#txtinventort_authority_id').val(selected.inventort_authority_id);
        $('#txtstore_prefix').combobox('setValue', selected.store_prefix);
        $('#txtareaname').combobox('setValue', selected.areaname);
        $('#txtbranch_pos').val(selected.branch_pos);
        $('#txtbranch_am').val(selected.branch_am);
        $('#txtgeneral_pos').val(selected.general_pos);
        $('#txtgeneral_am').val(selected.general_am);
        $('#txtfinancial_pos').val(selected.financial_pos);
        $('#txtfinancial_am').val(selected.financial_am);
        $('#form_Edit').form('validate');
    }
}
////取消
function Cancel(type) {
    if (type == "A1") {
        $('#form_Edit').window('close');
    }
    //else if (type == "A2") {
    //    $('#form_Edit').window('close');

    //}
}
//增加提交
function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Edit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            $('#form_Edit').window('close');
            var data = $('#form_Edit').serializeArray();
            var XMLData = GetFormJson(data, 'EDIT');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('008a066f-a353-4774-8ef5-3b26befde658'),
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
            return false;
        }
    });
}



function Delete() {

    var selected = $('#tab_list').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtinventort_authority_id", "value": selected.inventort_authority_id }
            var XMLData = GetFormJson(data, 'DELETE');
            $.ajax({
                url: GetWSRRURL('008a066f-a353-4774-8ef5-3b26befde658'),
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