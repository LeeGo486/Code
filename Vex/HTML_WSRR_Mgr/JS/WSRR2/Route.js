
//初始化
$(function () {
    InitGird();
    $('#cmbRouteType').combobox({
        //url: GetComboxWSRRURL('28fe6da4-452d-4d23-ae90-7b3226f2ecf1', "Route_Type"),
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "Route_Type"),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        height: 28,
        width:80,
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
	            { field: 'routeid', title: '编号', width: 150, hidden: true },
	            { field: 'name', title: '路由名称', width: 100, search: true, sortable: true }

            ]],
            columns: [[
                { field: 'serverpath', title: '服务地址', width: 200, search: true, sortable: true },
                { field: 'routecode', title: '路由代码', width: 60, search: true, sortable: true },
                { field: 'routetype', title: '路由类型', width: 60, sortable: true },
                { field: 'mark', title: '备注', width: 260, sortable: true },
                { field: 'createtime', title: '创建时间', width: 80, sortable: true, formatter: Formater.Date },
                { field: 'createuser', title: '创建人', width: 50, sortable: true },
                { field: 'updatetime', title: '更新时间', width: 80, sortable: true, formatter: Formater.Date },
                { field: 'updateuser', title: '更新人', sortable: true }
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
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: function () {
                    Delete_OnClick(true);
                }
            }
            ]
        }
        );
        //var pager = $('#tab_list').datagrid().datagrid('getPager');
        //pager.pagination({
        //    buttons: [{
        //        iconCls: 'icon-search',
        //        handler: function () {
        //            ExcelExport($('#tab_list').datagrid())
        //        }
        //    }]
        //});

}

function ExcelExport(pdg) {
    var dataOptions = pdg.datagrid("options");

    var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;

    var strXMLCol = "<Root><List>";
    for (var i = 0; i < dataColumns[0].length; i++) {
        strXMLCol += "<Rows>";
        strXMLCol += "<field>" + dataColumns[0][i].field + "</field>";
        strXMLCol += "<title>" + dataColumns[0][i].title + "</title>";
        strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";

        if (dataColumns[0][i].hidden) {
            strXMLCol += "<hidden>true</hidden>";
        }
        else {
            strXMLCol += "<hidden>false</hidden>";
        }
        strXMLCol += "</Rows>";
    }

    for (var i = 0; i < dataColumnsFrozen[0].length; i++) {
        strXMLCol += "<Rows>";
        strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";
        strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
        strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";

        if (dataColumnsFrozen[0][i].hidden) {
            strXMLCol += "<hidden>true</hidden>";
        }
        else {
            strXMLCol += "<hidden>false</hidden>";
        }
        strXMLCol += "</Rows>";
    }
    var strXMLCol = "</List></Root>";

    $.ajax({
        url: strUrl + "&ExcelExport=true&ExcelExportColumns=" + strXMLCol,
        data: dataParam,
        options: "JSON",
        success: function (data) {
            alert(data);
        }
    });

}

function ClickRowGrid(rowIndex, rowData) {
    //selected_Row = rowData;
}


function Edit_OnClick(pbEdit) {
    var selected_Row = $('#tab_list').datagrid('getSelected');

    if (!selected_Row && pbEdit) {
        $.messager.alert("提示", "请先选择需要被编辑的行", 'error');
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
        $('#txtRouteCode').val(selected_Row.routecode);
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
        $('#txtRouteCode').val("");
        $('#txtServerPath').val("");
        $('#txtMark').val("");

    }

    $('#form_Edit').form('validate');
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

function Delete_OnClick() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    if (!selected_Row) {
        alert("请先选择需要被删除的行");
        return;
    }

    var deleteMessage = '您确定要删除该行数据吗?';

    $.messager.confirm('提示框', deleteMessage, function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtRouteID", "value": selected_Row.routeid }
            data[data.length] = { "name": "txtUpdateTime", "value": selected_Row.updatetime }
            var XMLData = GetFormJson(data, 'DELETE');

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
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            //成功
                            //$.messager.alert("提示", result[0].rows[0].message);
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