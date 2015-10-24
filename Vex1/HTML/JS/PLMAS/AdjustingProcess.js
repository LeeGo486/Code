﻿/// JS名：AdjustingProcess.js
/// 说明：调版流程操作界面
/// 创建人：郭琦琦 
/// 创建日期：2014-06-11
var m_DDHComboxData = null;//定义订货会季节下拉
var m_username = "";//定义登入名
var m_Nowdate;//定义当前时间
var index = null;//定义索引
var editIndex;//定义编辑索引
var data1;
var m_GetDesigner;
var m_zt;
$(function () {
    m_zt = $.cookie('m_zt');

    initBrand();

    initPlanSeason();

    //默认附上时间今天往前面推3个月，开始时间和结束时间
    m_username = window.m_UserID;//取登入姓名
    $("#txtBeginDate").datebox("setValue", (new Date()).DateAdd('m', -3).format("yyyy-MM-dd"));
    $("#txtEndDate").datebox("setValue", (new Date()).DateAdd('d', -1).format("yyyy-MM-dd"));

    getFirstFormatDate();
    //初始化品类下拉数据
    $('#txtpl').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', '', 'category', 'category') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GETCATEGORY'),
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: false,
        multiple: true
    });




});

//按照品牌控制季节下拉数据
function ChangeDHHJJ() {
    var brandType = $('#txtbrand').combobox("getValue");

    if (m_DDHComboxData == null) {
        return;
    }
    var data = m_DDHComboxData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(brandType) > 0) {
            data1.push(data[i]);
        }
    }
    $('#txtcmbdhhjj').combobox("loadData", data1);//重加载季节下拉数据
}

//初始化品牌
function initBrand() {
    //品牌
    $("#txtbrand").combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbstky", "cbstky") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false,//同步
        onSelect: function (record) {
            getSampleWorker(record.text);
            ChangeDHHJJ();
        }
    });

    //取该人的品牌USERINFO表OwnedBrand字段判断品牌
    var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText),
        ownedBrand = result.rows[0].message,
        ownedType = typeof ownedBrand;
    $("#txtbrand").combobox('setValue', ownedBrand);//把品牌赋值给HTML品牌

    if (ownedType != "undefined") {
            getSampleWorker(ownedBrand);
        };   
}

function initPlanSeason() {
    //初始化订货会下拉数据
    $('#txtcmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: true, //异步
        onLoadSuccess: function (data) {

            if (m_DDHComboxData == null) {
                m_DDHComboxData = data;
                ChangeDHHJJ();//按照品牌控制季节下拉
            }
            data1 = $('#txtcmbdhhjj').combobox('getData');
            var data1Length = data1.length;
            if (data1Length > 0) {
                $('#txtcmbdhhjj').combobox('setValue', data1[data1.length - 1].text);
            } else {
                $('#txtcmbdhhjj').combobox('setValue', "");
            }
            //initGird();
        }
    });
}

function getSampleWorker(brand) {
    var url = GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "UserNameC", "UserNameC") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtBrand", "value": brand }], 'GetPattern');
    var htmlobj = $.ajax({
        url: url,
        async: false
    });
    m_GetDesigner = $.parseJSON(htmlobj.responseText);

    //初始化品类下拉数据
    $('#txtpatterner').combobox({
        data: m_GetDesigner,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        multiple: true
    });
}

//查询
function SearchClick() {
    if ($("#txtcmbdhhjj").combobox('getValue') == "") {
        $.messager.alert("提示", "请先选择季节！", 'error');
        return;
    }
    //加载数据
    initGird();
}

function initGird() {

    //根据日期，按照要求YYYYMMDD
    var beginDate = $("#txtBeginDate").datebox("getValue");
    var endDate = $("#txtEndDate").datebox("getValue");
    var beginDateTemp = beginDate.substring(0, 4) + beginDate.substring(5, 7) + beginDate.substring(8, 11);
    var endDateTemp = endDate.substring(0, 4) + endDate.substring(5, 7) + endDate.substring(8, 11);

    var season = $("#txtcmbdhhjj").datebox("getValue");
    var patterner = ""//接口要求重组修改
    var pl = ""//接口要求重组修改
    var txtpatterner = $('#txtpatterner').combobox('getValues');
    var txtpl = $('#txtpl').combobox('getValues');

    if (txtpatterner != "") {
        patterner = "(";
        if (txtpatterner.length == 1) {
            patterner += "#" + txtpatterner[0] + "#";
        } else {
            for (var i = 0; i < txtpatterner.length - 1; i++) {
                patterner += "#" + txtpatterner[i] + "#,";
            }
            patterner += "#" + txtpatterner[i] + "#";
        }
        patterner += ")";
    }
    if (txtpl != "") {
        pl = "(";
        if (txtpl.length == 1) {
            pl += "#" + txtpl[0] + "#";
        } else {
            for (var i = 0; i < txtpl.length - 1; i++) {
                pl += "#" + txtpl[i] + "#,";
            }
            pl += "#" + txtpl[i] + "#";
        }
        pl += ")";
    }

    //return;
    //创建获取数据XML
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txt订货会季节", "value": season };
    data[data.length] = { "name": "txt起始时间", "value": beginDateTemp };
    data[data.length] = { "name": "txt结束时间", "value": endDateTemp };
    data[data.length] = { "name": "txt品类", "value": pl };
    data[data.length] = { "name": "txt版师", "value": patterner };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('b0e52283-e8b1-48cb-b36a-02e6479e05b1') + xmlData
    $('#tabList').datagrid(
        {
            //title: '调版', //表格标题
            url: url,
            async: false,
            //sortName: 'po1_pocode', //排序字段
            //idField: 'dyyyno', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            //sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            onClickRow: onClickRow,//单击事件
            onDblClickRow: onDblClickRow,
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].dyyyno == "") {
                    ClearGrid("#tabList");
                }

            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'dyyyno', title: '样衣号', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'dycrdt', title: '收稿日期', width: 100 },
                { field: 'dyovdt', title: '交版日期', width: 100 },
                { field: 'dyorderseason', title: '季节', width: 150, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'dyovpe', title: '版师', width: 100, editor: { type: 'validatebox', options: { required: true } } },
                { field: 'designer', title: '设计师', width: 100 },
                { field: 'category', title: '品类', width: 100 },
                { field: 'series', title: '系列', width: 100 },
                { field: 'measurementsid', title: '样板号', width: 100 },
                { field: 'dyrezn', title: 'dyrezn', width: 80, hidden: true },//新增用设计修改
                { field: 'dytktm', title: 'dytktm', width: 80, hidden: true },//新增用1
                { field: 'dydvdt', title: 'dydvdt', width: 80, hidden: true }, //新增用修改时间
                { field: 'dydvpe', title: 'dydvpe', width: 80, hidden: true }, //新增用修改人
                { field: 'DYSUBID', title: 'DYSUBID', width: 80, hidden: true } //新增用修改人
            ]],
            //工具条
            toolbar: "#tab_toolbar",
            toolbar: [
            {
                id: 'btn_Add',
                text: '新增',
                iconCls: 'icon-add',
                handler: function () {
                    addNewRow();
                }
            },
            '-',
            {
                id: 'btn_Save',
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {
                    onSubmit();
                }
            },
             '-',
            {
                id: 'btn_Delete',
                text: '删除',
                iconCls: 'icon-remove',
                handler: function () {
                    deleteClick();
                }
            }
            ]
        });

    var $dg = $('#tabList');
    //格式化列时间格式
    var col = $('#tabList').datagrid('getColumnOption', 'dycrdt');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        }
    }

    col = $('#tabList').datagrid('getColumnOption', 'dyovdt');
    col.editor = {
        type: 'datebox', options: {
            editable: false,
            required: true,
            formatter: function (date) { return date.format("yyyy-MM-dd") }
        }
    }

    col = $dg.datagrid('getColumnOption', 'dyorderseason');
    col.editor = {
        type: 'combobox', options: { data: data1, required: true, panelHeight: 'auto', editable: false, valueField: 'id', textField: 'text' }
    }

    col = $dg.datagrid('getColumnOption', 'dyovpe');
    col.editor = {
        type: 'combobox', options: {
            data: m_GetDesigner, required: true, panelHeight: 120, editable: false, valueField: 'id', textField: 'text'
        }
    }

}
//新增
function addNewRow() {
    if (endEditing()) {
        //默认带上季节,创建人,创建时间,类型
        $('#tabList').datagrid('appendRow', { dydvpe: "1", dyrezn: "设计修改", dydvdt: m_Nowdate, dytktm: "1" });
        editIndex = $('#tabList').datagrid('getRows').length - 1;//选择新增的一行
        $('#tabList').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
    }
}

//双击时间，如果这个行的dyrezn是设计修改的话，才可以修改，不然不能修改
function onDblClickRow(index, rowData) {
    if (rowData.dysubid == "" || rowData.dysubid == undefined) {
        BeginEdit(index, rowData);
    }
    else {
        alert('只能修改新增行');
        return;
    }
}

//开始编辑
function BeginEdit(index, rowData) {
    //如果编辑的行不等于行号的话，执行，开始编辑
    if (editIndex != index) {
        if (endEditing()) {
            editIndex = index;
            $('#tabList').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}


//判断改行是否可以结束编辑
function endEditing() {
    if (editIndex != undefined) {
        if ($('#tabList').datagrid('validateRow', editIndex)) {
            $('#tabList').datagrid('endEdit', editIndex);
            editIndex = undefined;
        }
        else {
            alert('有未完成结束编辑行');
            return;
        }
    }
    return true;
}

//单击事件
function onClickRow(rowIndex, RowData) {
    if (rowIndex != editIndex) {
        if (!endEditing()) {
            return;
        }
    }
}

//取当前时间YYYYMMDD
function getFirstFormatDate() {
    var nowDate = new Date();
    //nowDate = new Date(nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDay())
    m_Nowdate = nowDate.format("yyyy-MM-dd");
}

//保存
function onSubmit() {
    if (endEditing()) {

        if ($('#tabList').datagrid('getChanges').length == 0) {
            $.messager.alert("提示", "没有新增数据！", 'error');
            return;
        }
        var dataInsert = $('#tabList').datagrid('getChanges');
        var cmbdhhjjInsert = $('#txtcmbdhhjj').combobox("getValue");

        var data = [];
        var inserted = $("#tabList").datagrid('getChanges', "inserted");
        var data1 = GetExcelXML(inserted);
        data[data.length] = { "name": "txt操作类型", "value": "NEW" };
        data[data.length] = { "name": "txt实体", "value": "" };
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt订货会季节", "value": cmbdhhjjInsert };
        data[data.length] = { "name": "txt操作人", "value": m_username };
        data[data.length] = { "name": "txtXML", "value": data1, specialCharset: true };
        XMLData = GetDBFrameAMLPost(data);
        //return;
        $.ajax({
            url: GetWSRRURL('b0e52283-e8b1-48cb-b36a-02e6479e05b1'),
            data: XMLData,
            type: 'POST',
            async: true, //异步,
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
                        $('#tabList').datagrid("reload");
                        $.messager.alert("提示", result[0].rows[0].msg);
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
    }
};


//删除
function deleteClick() {
    var selectedRow = $('#tabList').datagrid('getSelected');
    if (!selectedRow) {
        $.messager.alert("提示", "请选择一行！", 'error');
        return;
    }
    var season = $("#txtcmbdhhjj").datebox("getValue");

    if (selectedRow.dysubid == "" && selectedRow.dysubid == undefined) {
        var deleteIndex = $('#tabList').datagrid('getRowIndex', selectedRow)
        $('#tabList').datagrid('deleteRow', deleteIndex)
        return;
    }
    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txt操作类型", "value": "DELETE" };
            data[data.length] = { "name": "txt实体", "value": "" };
            data[data.length] = { "name": "txt返回内容", "value": "必填" };
            data[data.length] = { "name": "txtDIVI", "value": m_zt };
            data[data.length] = { "name": "txtCONO", "value": "HFYG" };
            data[data.length] = { "name": "txt订货会季节", "value": season };
            data[data.length] = { "name": "txt操作人", "value": m_username };
            data[data.length] = { "name": "txtDYYYNO", "value": selectedRow.dyyyno };
            data[data.length] = { "name": "txtDYCRDT", "value": selectedRow.dycrdt };
            data[data.length] = { "name": "txtDYDVDT", "value": "" };
            data[data.length] = { "name": "txtDYOVPE", "value": selectedRow.dyovpe };
            data[data.length] = { "name": "txtDYOrderSeason", "value": selectedRow.dyorderseason };
            var xmlData = GetDBFrameAML(data);//组成调用APIxml
            var url = GetWSRRURL('b0e52283-e8b1-48cb-b36a-02e6479e05b1') + xmlData
            //return;
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: url,
                type: 'post',
                async: true, //异步,
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
                            $('#tabList').datagrid("reload");
                            $.messager.alert("提示", result[0].rows[0].msg);
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
    });
}

