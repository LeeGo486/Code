/// JS名：Notic.js
/// 说明：贝爱VIP特权
/// 创建人：郭琦琦 
/// 创建日期：2015-07-05
var m_user;
//初始化
$(function () {
    InitGird();
})


//初始化表格
function InitGird(url) {
    $('#tabList').datagrid(
        {
            url: GetWSRRURL('02b1fd16-c844-4ea7-b082-cf8a5dbf6f35b') + "&XML=" + GetFormJson("", 'GetVIPPrivilege'),
            sortName: 'id', //排序字段
            idField: 'id', //标识字段,主键
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
            rownumbers: true,
            columns: [[
                { field: 'id', title: 'id', width: 100, search: true, sortable: true, hidden: true },
                { field: 'vipstate', title: 'VIP等级', width: 150, search: true, sortable: true },
                { field: 'content', title: '内容', width: 250, search: true, sortable: true },
                { field: 'lv', title: '级别', width: 250, search: true, sortable: true },
                { field: 'updatename', title: '修改人', width: 80, search: true, sortable: true },
                { field: 'updatedate', title: '修改时间', width: 80, search: true, sortable: true, formatter: Formater.Date },
                { field: 'createname', title: '创建人', width: 80, search: true, sortable: true },
                { field: 'creatrdate', title: '创建时间', width: 80, search: true, sortable: true, formatter: Formater.Date }
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
    if (type == "ADD") {
        $('#form_Edit').window({
            title: "添加",
            top: 50,
            width: 900,
            height: 500,
            modal: true
        }).window('open');

        $('#form_Edit').form('clear')
        $('#form_Edit').form('validate');
    }
    else if (type == "EDIT") {
        var selected = $('#tabList').datagrid('getSelected');
        if (!selected) {
            alert("请选择一条数据");
            return;
        };
        $('#form_Edit').window({
            title: "修改",
            top: 50,
            width: 900,
            height: 500,
            modal: true
        });

        $('#txtid').val(selected.id);
        $('#txtvipstate').val(selected.vipstate);
        $('#txtcontent').val(selected.content);
        $('#txtlv').val(selected.lv);
        $('#form_Edit').form('validate');
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
            data[data.length] = { "name": "txtid", "value": $('#txtid').val() };
            data[data.length] = { "name": "txtvipstate", "value": $('#txtvipstate').val() };
            data[data.length] = { "name": "txtcontent", "value": $('#txtcontent').val() };
            data[data.length] = { "name": "txtlv", "value": $('#txtlv').val() };


            var XMLData = GetFormJson(data, 'UpdateVIPPrivilege');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('02b1fd16-c844-4ea7-b082-cf8a5dbf6f35b'),
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
                            $('#tabList').datagrid("unselectAll");
                            $('#tabList').datagrid("reload");

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

    var selected = $('#tabList').datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }
    var deleteMessage = '删除提交后数据无法恢复，你确定要删除吗?';
    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtid", "value": selected.id }
            var XMLData = GetFormJson(data, 'DeleteVIPPrivilege');
            $.ajax({
                url: GetWSRRURL('02b1fd16-c844-4ea7-b082-cf8a5dbf6f35b'),
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
                            $('#tabList').datagrid("unselectAll");
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