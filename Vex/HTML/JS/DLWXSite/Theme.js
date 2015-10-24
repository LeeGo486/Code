﻿/*
    创建者：cookie
    创建时间：2015-05-11
    功能：主题管理
*/

var selectedTheme_Row;   //任务列表选中行

$(function () {
    InitThemeGird();
});

//初始化主题列表
function InitThemeGird() {
    $('#theme_tab_list').datagrid(
        {
            url: GetWSRRURL('00c2df17-e647-4ce3-ac92-3c249e219784'),
            queryParams: { "XML": GetGetJson([{}]) },
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择
            columns: [[
                { field: 'year', title: '年份', width: 50, search: true, sortable: true, align: 'right' },
                { field: 'themecode', title: '主题编号', width: 80, search: true, sortable: true },
	            { field: 'themename', title: '主题名称', width: 140, search: true, sortable: true },
	            { field: 'themeorder', title: '主题排序', width: 80, search: true, sortable: true },
	            { field: 'themestate', title: '主题状态', width: 80, search: true, sortable: true },
                { field: 'createtime', title: '创建时间', width: 140, sortable: true },
                { field: 'createuser', title: '创建人', width: 80, sortable: true },
                { field: 'createtime', title: '更新时间', width: 140, sortable: true },
                { field: 'createuser', title: '更新人', width: 80, sortable: true }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号

            onDblClickRow: function () { ThemeEdit_OnClick(false); },
            onClickRow: function () { ThemeDBlClickRowGrid(); },

            toolbar: [
            {
                id: 'btn_Add',
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    ThemeAdd_OnClick(false);
                }
            },
            {
                id: 'btn_Edit',
                text: '编辑',
                iconCls: 'icon-edit',
                handler: function () {
                    var rows = $('#theme_tab_list').datagrid('getSelections');
                    if (rows.length !== 1) {
                        $.messager.alert("提示", "请选择一行", 'error');
                        return;
                    }
                    ThemeEdit_OnClick(false);
                }
            },
            {
                id: 'btn_Delete',
                text: '删除',
                hidden: true,
                iconCls: 'icon-cancel',
                handler: function () {
                    //ThemeDelete_OnClick();
                }
            }
            ]
        });

    col = $('#theme_tab_list').datagrid('getColumnOption', 'themestate');
    if (col != null) {
        col.formatter = function (value) {

            return GetCommboboxText([{ "id": 1, "text": "正常" }, { "id": 2, "text": "停用" }], value);

        }
    }
}

//添加主题
function ThemeAdd_OnClick() {
    $('#divEditTheme').window({
        title: "添加",
        width: 450,
        top: 40,
        height: 220,
        modal: true
    }).window('open');
    $('#form_EditTheme #txtTID').val('');  //设置编号
    $('#form_EditTheme #txtYear').combobox('setValue', new Date().getFullYear());    //清空年份
    $('#form_EditTheme #txtCode').val("");    //清空编号
    $('#form_EditTheme #txtCodeShow').val("系统自动生成");    //显示编号的信息
    $('#form_EditTheme #txtName').val('');    //设置名称

    $('#form_EditTheme #txtthemestate').combobox('setValue', "1");    //默认1
    $('#form_EditTheme #txtthemeorder').numberbox('setValue', "");    //清空清空排序

    //验证Form
    $('#form_EditTheme').form('validate');
    //设置焦点
    $('#form_EditTheme #txtYear').focus();
}

//形象列表项目编辑提交
function ThemeEdit_Submit() {
    $('#form_EditTheme').form('submit', {
        onSubmit: function (e) {
            if ($('#form_EditTheme').form('validate') == false) {
                return false;
            }
           // console.log($('#txtYear').combobox('getValue'));
            //设置Request对象
            var data = [];
            data[data.length] = { "name": "txtTID", "value": $('#txtTID').val() };
            data[data.length] = { "name": "txtYear", "value": $('#txtYear').combobox('getValue') };
            data[data.length] = { "name": "txtThemeCode", "value": $('#form_EditTheme #txtCode').val() };
            data[data.length] = { "name": "txtThemeName", "value": $('#form_EditTheme #txtName').val() };
            data[data.length] = { "name": "txtthemestate", "value": $('#form_EditTheme #txtthemestate').combobox('getValue') };
            data[data.length] = { "name": "txtthemeorder", "value": $('#form_EditTheme #txtthemeorder').numberbox('getValue') };
            var XMLData = GetFormJson(data, 'EDIT');
            $.ajax({
                url: GetWSRRURL('00c2df17-e647-4ce3-ac92-3c249e219784'),
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
                            $('#divEditTheme').window('close');
                            $('#theme_tab_list').datagrid("reload");
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

//形象列表项目编辑
function ThemeEdit_OnClick(IsCopy) {
    if (!selectedTheme_Row) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }

    $('#divEditTheme').window({
        title: "编辑",
        width: 450,
        top: 40,
        height: 220,
        modal: true
    }).window('open');
    $('#form_EditTheme #txtYear').combobox('setValue', selectedTheme_Row.year);    //设置主题 
    $('#form_EditTheme #txtTID').val(selectedTheme_Row.tid);  //设置编号
    $('#form_EditTheme #txtCode').val(selectedTheme_Row.themecode);  //设置编号
    $('#form_EditTheme #txtCodeShow').val(selectedTheme_Row.themecode);  //显示编号
    $('#form_EditTheme #txtName').val(selectedTheme_Row.themename);  //设置名称
    $('#form_EditTheme #txtthemestate').combobox('setValue', selectedTheme_Row.themestate);  //设置状态
    $('#form_EditTheme #txtthemeorder').numberbox('setValue', selectedTheme_Row.themeorder);  //设置排序

    //验证Form
    $('#form_EditTheme').form('validate');
    //设置txtURL焦点
    $('#form_EditTheme #txtYear').focus();
}

//单击项目
function ThemeDBlClickRowGrid() {
    var selected = $('#theme_tab_list').datagrid('getSelected');

    if (selected) {
        selectedTheme_Row = selected;
    }
}

//主题列表项目删除
function ThemeDelete_OnClick() {
    if (!selectedTheme_Row) {
        $.messager.alert("提示", "请选择一行", 'error');
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtTID", "value": selectedTheme_Row.tid }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('00c2df17-e647-4ce3-ac92-3c249e219784'),
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
                            $('#theme_tab_list').datagrid("unselectAll");
                            selectedTheme_Row = undefined
                            $('#theme_tab_list').datagrid("reload");
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