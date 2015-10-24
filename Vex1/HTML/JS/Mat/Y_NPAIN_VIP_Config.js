
$(function () {
    InitGird();
})
//EDITNPAINVIPCONFIG
//GETNPAINVIPCONFIG
function InitGird(url) {
    $('#tab_list').datagrid(
        {
            title: 'Y_NPAIN_VIP_Config', //表格标题
            url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871') + "&XML=" + GetFormJson("", 'GETNPAINVIPCONFIG'),
            sortName: 'merchantid', //排序字段
            idField: 'merchantid', //标识字段,主键
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
                { field: 'merchantid', title: '加盟商编号', width: 100, search: true, sortable: true },
                { field: 'level1_type', title: '等级1', width: 100, search: true, sortable: true },
                { field: 'level1_rate', title: '等级1比例', width: 100, search: true, sortable: true },
                { field: 'level2_type', title: '等级2', width: 120, search: true, sortable: true },
                { field: 'level2_rate', title: '等级2比例', width: 120, search: true, sortable: true },
                { field: 'level3_type', title: '等级3', width: 120, sortable: true },
                { field: 'level3_rate', title: '等级3比例', width: 120, sortable: true },
                { field: 'tikect_type', title: '积分兑换券类型', width: 120, sortable: true },
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
            }
            ]
        });
}


function Type(type) {
    if (type == "ADD") {
        $('#form_Edit').window({
            title: "添加",
            top: 100,
            width: 500,
            height: 280,
            modal: true
        });
        $('#txtmerchantid').val("");
        $('#txtlevel1_type').val("");
        $('#txtlevel1_rate').numberbox('setValue', "");
        $('#txtlevel2_type').val("");
        $('#txtlevel2_rate').numberbox('setValue', "");
        $('#txtlevel3_type').val("");
        $('#txtlevel3_rate').numberbox('setValue', "");
        $('#txttikect_type').val("");

        $("#txtmerchantid").attr("disabled", false);

        $('#form_Edit').form('validate');
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
        $('#txtmerchantid').val(selected.merchantid);
        $('#txtlevel1_type').val(selected.level1_type);
        $('#txtlevel1_rate').numberbox('setValue', selected.level1_rate);
        $('#txtlevel2_type').val(selected.level2_type);
        $('#txtlevel2_rate').numberbox('setValue', selected.level2_rate);
        $('#txtlevel3_type').val(selected.level3_type);
        $('#txtlevel3_rate').numberbox('setValue', selected.level3_rate);
        $('#txttikect_type').val(selected.tikect_type);
        $('#form_Edit').form('validate');
        $('#txtmerchantid').attr("disabled", "disabled");
    }
}
////取消
function Cancel() {
        $('#form_Edit').window('close');
}

//增加提交
function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {
            if ($('#form_Edit').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            
            var data = [];
            data[data.length] = { "name": "txtmerchantid", "value": $('#txtmerchantid').val() };
            data[data.length] = { "name": "txtlevel1_type", "value": $('#txtlevel1_type').val() };
            data[data.length] = { "name": "txtlevel1_rate", "value": $('#txtlevel1_rate').numberbox('getValue') };
            data[data.length] = { "name": "txtlevel2_type", "value": $('#txtlevel2_type').val() };
            data[data.length] = { "name": "txtlevel2_rate", "value": $('#txtlevel2_rate').numberbox('getValue') };
            data[data.length] = { "name": "txtlevel3_type", "value": $('#txtlevel3_type').val() };
            data[data.length] = { "name": "txtlevel3_rate", "value": $('#txtlevel3_rate').numberbox('getValue') };
            data[data.length] = { "name": "txttikect_type", "value": $('#txttikect_type').val() };

            var XMLData = GetFormJson(data, 'EDITNPAINVIPCONFIG');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('5b588a14-c810-4b67-826b-da92a3ce5871'),
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
                            $('#form_Edit').window('close');
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