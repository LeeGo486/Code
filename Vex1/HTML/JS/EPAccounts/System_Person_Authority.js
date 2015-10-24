/// JS名：System_Person_Authority.js
/// 说明：人员权限分配管理
/// 创建人：郭琦琦 
/// 创建日期：2014-06-20
$(function () {
    initGird();
})
//初始化表格
function initGird() {
    ClearGrid("#tab_list");
    $('#tab_list').datagrid(
        {
            title: '人员对应分配权限', //表格标题
            url: GetWSRRURL('07978308-6591-4ba4-ba69-fc5d5c6a7c3f') + "&XML=" + GetFormJson([], 'GET'),
            sortName: 'id', //排序字段
            idField: 'id', //标识字段,主键
            //sortOrder: 'asc', //排序类型
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数   
            columns: [[
                { field: 'id', title: 'ID', width: 200, search: true, sortable: true },
                { field: 'person', title: '人员', width: 200, search: true, sortable: true, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'env', title: '环境', width: 200, search: true, sortable: true, editor: { type: 'validatebox', options: { required: true } } }
            ]],
            toolbar: [
           {
               id: 'btn_Add',
               text: '添加',
               iconCls: 'icon-add',
               handler: function () {
                   edit("新增");
               }
           },
           {
               id: 'btn_Delete',
               text: '删除',
               iconCls: 'icon-remove',
               handler: function () {
                   deleteRow();
               }
           }
           ,
           {
               id: 'btn_Edit',
               text: '修改',
               iconCls: 'icon-edit',
               handler: function () {
                   edit("修改");
               }
           }]
        }
        );
}
//新增人员权限分配控制
function edit(type) {
    if (type == "新增") {
        $('#DivPerson').window({
            title: "新增",
            top: 100,
            width: 300,
            height: 200,
            modal: true
        });
        $('#txtid').val("系统自动生成");//ID  
        $('#txtperson').val("");//人
        $('#txtevn').val("");//环境
    }
    else if (type == "修改") {
        var selectRow = $('#tab_list').datagrid('getSelected')//是否选择行
        if (!selectRow) {
            alert('请选择一行');
            return;
        }
        $('#DivPerson').window({
            title: "修改",
            top: 100,
            width: 300,
            height: 200,
            modal: true
        });
        $('#txtid').val(selectRow.id);//ID  
        $('#txtperson').val(selectRow.person);//人
        $('#txtenv').val(selectRow.env);//环境
    }
}
//保存操作
function save() {
    var selectRow = $('#tab_list').datagrid('getSelected')//选择行
    $('#formPerson').form('submit', {
        onSubmit: function (e) {
            if ($('#formPerson').form('validate') == false) {
                $.messager.alert("提示", "请把必填项填完！", 'error');
                return false;
            }
            var data = $('#formPerson').serializeArray();
            data[data.length] = { "name": "txtid", "value": $('#txtid').val() }
            var XMLData = GetFormJson(data, 'EDIT');
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('07978308-6591-4ba4-ba69-fc5d5c6a7c3f'),
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
                            $.messager.progress('close');
                            $('#DivPerson').window('close');
                            $('#tab_list').datagrid("unselectAll");
                            $('#tab_list').datagrid("reload");
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

//删除行
function deleteRow() {
    var selected_Row = $('#tab_list').datagrid('getSelected')
    if (!selected_Row) {
        alert("请先选中一行!");
        return;
    }
    var data = [];
    data[data.length] = { "name": "txtid", "value": selected_Row.id }
    var XMLData = GetFormJson(data, 'delete');
    $.ajax({
        url: GetWSRRURL('07978308-6591-4ba4-ba69-fc5d5c6a7c3f'),
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
//取消
function cancel() {
    $('#DivPerson').window('close');
}