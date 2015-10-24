/// JS名：Attendance.js
/// 说明：版师每月制版计分表
/// 创建人：郭琦琦 
/// 创建日期：2014-10-14
var m_month = [{ "id": 1, "text": "1月" }, { "id": 2, "text": "2月" }, { "id": 3, "text": "3月" }, { "id": 4, "text": "4月" }, { "id": 5, "text": "5月" }, { "id": 6, "text": "6月" },
            { "id": 7, "text": "7月" }, { "id": 8, "text": "8月" }, { "id": 9, "text": "9月" }, { "id": 10, "text": "10月" }, { "id": 11, "text": "11月" }, { "id": 12, "text": "12月" }];
var editIndex = undefined;//出勤维护
var editIndexxs = undefined;//系数维护
var m_Username;//登入名
var m_RowIndex = 10000;
var m_Nowyear = "";//当年
var m_Lastyeay = "";//去年
var m_Nextyeay = "";//明年
var m_LastTwoyeay = "";//2年
var m_Lastthryeay = "";//3年

$(function () {
    document.onkeydown = check;
    function check(e) {
        var code;
        if (!e) var e = window.event;
        if (e.keyCode) code = e.keyCode;
        else if (e.which) code = e.which;
        else return;

        if (code == 8) {
            if (
                (event.srcElement.type != "text" &&
                event.srcElement.type != "textarea" &&
                event.srcElement.type != "password") ||
                event.srcElement.readOnly == true) {
                event.keyCode = 0;
                event.returnValue = false;
                return false;
            };
            return true;
        };
    }


    m_zt = $.cookie('m_zt');//获取缓存帐套
    m_Username = window.m_UserID;//取登入姓名
    var nowDate = new Date();
    m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//去年
    m_Nextyeay = nowDate.DateAdd('y', +1).format("yyyy");//明年
    m_LastTwoyeay = nowDate.DateAdd('y', -2).format("yyyy");//2年
    m_Lastthryeay = nowDate.DateAdd('y', -3).format("yyyy");//3年

    //定义4个tab年份,品牌下拉
    definitionYearCombobox();
    definitionBrandCombobox();

    initBrand();

});

function initBrand() {
    var htmlobj = $.ajax({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40"),
        data: { "XML": GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand') },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);

    $("#txtsjbrand").combobox({
        data: result,
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false
    });
    $("#txtjxbrand").combobox({
        data: result,
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false
    });
    $("#txtxsbrand").combobox({
        data: result,
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false
    });
    $("#txtdaybrand").combobox({
        data: result,
        valueField: 'id',
        textField: 'text',
        width: '100',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false
    });

    var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    $("#txtsjbrand").combobox('setValue', result.rows[0].message)//把品牌赋值给HTML品牌
    $("#txtjxbrand").combobox('setValue', result.rows[0].message)//把品牌赋值给HTML品牌
    $("#txtxsbrand").combobox('setValue', result.rows[0].message)//把品牌赋值给HTML品牌
    $("#txtdaybrand").combobox('setValue', result.rows[0].message)//把品牌赋值给HTML品牌
}

//---------------------------------------------------------------实绩汇总
//实绩汇总点击查询
function sjsearchClick() {
    initsjGird();
}

//实绩加载汇总
function initsjGird() {
    ClearGrid("#sjList");//清除表单数据
    var year = $('#txtsjyear').combobox('getValue');//获取年份
    var brand = $('#txtsjbrand').combobox('getValue');//获取品牌
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetPatternerMonthlyOutput" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt品牌", "value": brand };
    data[data.length] = { "name": "txt年份", "value": year };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38') + xmlData
    $('#sjList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'month', //排序字段
            idField: 'patternername', //标识字段,主键
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
            //onClickRow: onClicksjRow,
            onDblClickRow: onClicksjRow,
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].patternername == "") {
                    ClearGrid("#sjList");
                }
            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            rowStyler: function (index, row) {
                if (row.patternername == "小计") {
                    return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                }
                if (row.patternernamez == "合计") {
                    return 'background-color:#d44864;color:#000000;font-weight:bold;';
                }
            },
            columns: [[
                { field: 'patternername', title: '姓名', width: 60, rowspan: 2, align: "center" },
                { title: '1月', colspan: 3 },
                { title: '2月', colspan: 3 },
                { title: '3月', colspan: 3 },
                { title: '4月', colspan: 3 },
                { title: '5月', colspan: 3 },
                { title: '6月', colspan: 3 },
                { title: '7月', colspan: 3 },
                { title: '8月', colspan: 3 },
                { title: '9月', colspan: 3 },
                { title: '10月', colspan: 3 },
                { title: '11月', colspan: 3 },
                { title: '12月', colspan: 3 },
                { field: '个人年合计np_num', title: '新板合计', width: 60, rowspan: 2, align: "center" },
                { field: '个人年合计ap_num', title: '调板合计', width: 60, rowspan: 2, align: "center" },
                { field: '个人年合计as_num', title: '大货合计', width: 60, rowspan: 2, align: "center" }
            ], [
            { field: '第1月np_num', title: '新板', width: 30 },
            { field: '第1月ap_num', title: '调板', width: 30 },
            { field: '第1月as_num', title: '大货', width: 30 },
            { field: '第2月np_num', title: '新板', width: 30 },
            { field: '第2月ap_num', title: '调板', width: 30 },
            { field: '第2月as_num', title: '大货', width: 30 },
            { field: '第3月np_num', title: '新板', width: 30 },
            { field: '第3月ap_num', title: '调板', width: 30 },
            { field: '第3月as_num', title: '大货', width: 30 },
            { field: '第4月np_num', title: '新板', width: 30 },
            { field: '第4月ap_num', title: '调板', width: 30 },
            { field: '第4月as_num', title: '大货', width: 30 },
            { field: '第5月np_num', title: '新板', width: 30 },
            { field: '第5月ap_num', title: '调板', width: 30 },
            { field: '第5月as_num', title: '大货', width: 30 },
            { field: '第6月np_num', title: '新板', width: 30 },
            { field: '第6月ap_num', title: '调板', width: 30 },
            { field: '第6月as_num', title: '大货', width: 30 },
            { field: '第7月np_num', title: '新板', width: 30 },
            { field: '第7月ap_num', title: '调板', width: 30 },
            { field: '第7月as_num', title: '大货', width: 30 },
            { field: '第8月np_num', title: '新板', width: 30 },
            { field: '第8月ap_num', title: '调板', width: 30 },
            { field: '第8月as_num', title: '大货', width: 30 },
            { field: '第9月np_num', title: '新板', width: 30 },
            { field: '第9月ap_num', title: '调板', width: 30 },
            { field: '第9月as_num', title: '大货', width: 30 },
            { field: '第10月np_num', title: '新板', width: 30 },
            { field: '第10月ap_num', title: '调板', width: 30 },
            { field: '第10月as_num', title: '大货', width: 30 },
            { field: '第11月np_num', title: '新板', width: 30 },
            { field: '第11月ap_num', title: '调板', width: 30 },
            { field: '第11月as_num', title: '大货', width: 30 },
            { field: '第12月np_num', title: '新板', width: 30 },
            { field: '第12月ap_num', title: '调板', width: 30 },
            { field: '第12月as_num', title: '大货', width: 30 }
            ]]
        });
}
//
//---------------------------------------------------------------绩效汇总
//
//绩效点击查询
function jxsearchClick() {
    initjxGird();
}

//绩效加载汇总
function initjxGird() {

    ClearGrid("#jxList");//清除表单数据
    var year = $('#txtjxyear').combobox('getValue');//获取年份
    var brand = $('#txtjxbrand').combobox('getValue');//获取品牌
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetPatternerPIAmount" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt品牌", "value": brand };
    data[data.length] = { "name": "txt年份", "value": year };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txt版师", "value": m_Username };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38') + xmlData
    $('#jxList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'month', //排序字段
            idField: 'patternname', //标识字段,主键
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
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].patternername == "") {
                    ClearGrid("#jxList");
                }
            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数
            rownumbers: true,//行号
            rowStyler: function (index, row) {
                if (row.patternername == "组平均") {
                    return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                }
                if (row.patternername == "平均") {
                    return 'background-color:#d44864;color:#000000;font-weight:bold;';
                }
            },
            columns: [[
                { field: 'patternername', title: '姓名', width: 60, align: "center" },
                { field: 'year', title: '年份', width: 60 },
                { field: 'jan', title: '1月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'feb', title: '2月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'mar', title: '3月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'apr', title: '4月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'may', title: '5月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'jun', title: '6月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'jul', title: '7月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'aug', title: '8月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'sep', title: '9月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'oct', title: '10月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'nov', title: '11月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'dec', title: '12月', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } },
                { field: 'amount', title: '总数', width: 60, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return Formater.Account(value); } } }
            ]]
        });
}
//
//---------------------------------------------------------------系数维护
//
//系数维护点击查询
function xssearchClick() {
    initxsGird();
}

function initxsGird() {
    //【操作类型,GET】【实体,GetUpdatePAC】【返回内容,必填】【CONO,HFYG】【DIVI,EP】【品牌,EP】【操作人,wangyan】【XML,】
    ClearGrid("#xsList");//清除表单数据
    //var year = $('#txtxsyear').combobox('getValue');//获取年份
    var brand = $('#txtxsbrand').combobox('getValue');//获取品牌
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdatePAC" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt品牌", "value": brand };
    //data[data.length] = { "name": "txt年份", "value": year };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38') + xmlData
    $('#xsList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'month', //排序字段
            idField: 'category', //标识字段,主键
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
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].category == "") {
                    ClearGrid("#xsList");
                }
            },
            onDblClickRow: onDblClickRow,
            onClickRow: onClickRow,
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'category', title: '类别', width: 80 },
                {
                    field: 'avemanday', title: '平均人/天', width: 80, formatter: Formater.Account, editor: { type: 'numberbox', options: { precision: '2', required: true } }
                },
                {
                    field: 'np_c', title: '新板系数', width: 80, formatter: Formater.Account, editor: { type: 'numberbox', options: { precision: '2', required: true } }
                },
                {
                    field: 'ap_c', title: '调板系数', width: 80, formatter: Formater.Account, editor: { type: 'numberbox', options: { precision: '2', required: true } }
                },
                {
                    field: 'as_c', title: '大货系数', width: 80, formatter: Formater.Account, editor: { type: 'numberbox', options: { precision: '2', required: true } }
                }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
          {
              id: 'btnAdd',
              text: '新增',
              iconCls: 'icon-add',
              hidden: false,
              handler: function () {
                  xsAdd();
              }
          }, {
              id: 'btnDelete',
              text: '删除',
              iconCls: 'icon-cancel',
              hidden: false,
              handler: function () {
                  xsDelete();
              }
          },
            {
                id: 'btnSave',
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {
                    savexs();
                }
            }]
        });
}

//新增
function xsAdd() {
    if (endEditingxs()) {

        var col = $('#xsList').datagrid('getColumnOption', 'category');
        col.editor = {
            type: 'validatebox', options: { required: true, textField: 'text' }
        }

        $('#xsList').datagrid('appendRow', {});
        editIndexxs = $('#xsList').datagrid('getRows').length - 1;
        $('#xsList').datagrid('selectRow', editIndexxs).datagrid('beginEdit', editIndexxs);


    }
}

//双击
function onDblClickRow(index, rowData) {
    if (rowData.id == "" || rowData.id == undefined) {

        var col = $('#xsList').datagrid('getColumnOption', 'category');
        col.editor = {
            type: 'validatebox', options: { required: true, textField: 'text' }
        }
        BeginEdit(index, rowData);
    }
    else {
        var col = $('#xsList').datagrid('getColumnOption', 'category');
        col.editor = {
        }
        BeginEdit(index, rowData);
    }
}

//开始编辑
function BeginEdit(index, rowData) {
    //如果编辑的行不等于行号的话，执行，开始编辑
    if (editIndexxs != index) {
        if (endEditingxs()) {
            editIndexxs = index;
            $('#xsList').datagrid('selectRow', editIndexxs).datagrid('beginEdit', editIndexxs);
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
function endEditingxs() {
    if (editIndexxs != undefined) {
        if ($('#xsList').datagrid('validateRow', editIndexxs)) {
            $('#xsList').datagrid('endEdit', editIndexxs);
            editIndexxs = undefined;
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
    //alert(rowIndex);
    if (rowIndex != editIndexxs) {
        if (!endEditingxs()) {
            return;
        }
    }
}

//删除事件
function xsDelete() {
    var selectedRow = $('#xsList').datagrid('getSelected');
    if (!selectedRow) {
        $.messager.alert("提示", "请选择一行！", 'error');
        return;
    }
    var deleteIndex = $('#xsList').datagrid('getRowIndex', selectedRow)
    $('#xsList').datagrid('deleteRow', deleteIndex)
}

//系数维护保存
function savexs() {

    if (endEditingxs()) {

        var brand = $('#txtxsbrand').combobox('getValue');//获取品牌
        $dg = $("#xsList");

        var allRows = $dg.datagrid('getRows'); //获取当前所有行的数据

        for (var i = 0; i < allRows.length; i++) {
            var a = allRows[i].category;

            for (var j = 0; j < allRows.length; j++) {
                var a1 = allRows[j].category;
                if (i != j && a != "" && a1 != "" && a == a1) {
                    alert("类型有重复!");
                    return;
                }
            }
        }

        for (var i = 0; i < allRows.length; i++) {
            delete allRows[i].id;
        }

        var dateUpdate = GetExcelXML(allRows);

        var data = [];
        data[data.length] = { "name": "txt操作类型", "value": "Update" };
        data[data.length] = { "name": "txt实体", "value": "GetUpdatePAC" };
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt品牌", "value": brand };
        //data[data.length] = { "name": "txt年份", "value": year };
        data[data.length] = { "name": "txt操作人", "value": m_Username };
        data[data.length] = { "name": "txtXML", "value": dateUpdate, specialCharset: true };

        var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38'),
            data: xmlData,
            type: 'POST',
            async: true,
            success: function (result) {
                try {
                    $.messager.progress("close");
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
                        $.messager.progress('close');
                        $('#xsList').datagrid("reload");
                        $.messager.alert("提示", result[0].rows[0].msg);
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function (result) {
                $.messager.progress('close');
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }

}
//
//---------------------------------------------------------------天数维护
//
//天数维护点击查询
function searchClick() {
    initdayGird();//加载数据
}

//天数维护加载数据
function initdayGird() {

    ClearGrid("#dayList");//清除表单数据
    var year = $('#txtdayyear').combobox('getValue');//获取年份
    var brand = $('#txtdaybrand').combobox('getValue');//获取年份
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetUpdateAttendanceDays" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt品牌", "value": brand };
    data[data.length] = { "name": "txt年份", "value": year };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38') + xmlData
    $('#dayList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'month', //排序字段
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
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].month == "") {
                    ClearGrid("#dayList");
                    $('#btnAdd').show();
                }
            },
            onClickCell: onClickCell,
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'month', title: '月份', width: 80 },
                { field: 'days', title: '正常出勤天数', width: 80, editor: { type: 'numberbox', options: { required: true } } }
            ]],
            toolbar: "#tab_toolbar",
            toolbar: [
          {
              id: 'btnAdd',
              text: '新增月份',
              iconCls: 'icon-add',
              hidden: true,
              handler: function () {
                  add();
              }
          },
            {
                id: 'btnSave',
                text: '保存',
                iconCls: 'icon-save',
                handler: function () {
                    save();
                }
            }]
        });
}

//天数维护单元格修改
function onClickCell(index, field) {
    if (endEditing()) {
        $('#dayList').datagrid('selectRow', index)
                .datagrid('editCell', { index: index, field: field });
        editIndex = index;
    }
}

//天数维护结束编辑
function endEditing() {
    if (editIndex == undefined) { return true }
    if ($('#dayList').datagrid('validateRow', editIndex)) {
        $('#dayList').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    }
}

//天数维护增加月份12月
function add() {

    var allRowsAdd = $("#dayList").datagrid('getRows'); //获取当前所有行的数据
    if (allRowsAdd.length > 0) {
        alert("已经添加了一年12个月,请勿再添加!");
        return;
    }
    for (b = 1; b < 13; b++) {
        $('#dayList').datagrid('appendRow',
            {
                rowindex: m_RowIndex++,
                month: b
            });
    }
}

//天数维护保存
function save() {

    if (endEditing()) {
        var year = $('#txtdayyear').combobox('getValue');//获取年份
        var brand = $('#txtdaybrand').combobox('getValue');//获取年份

        $dg = $("#dayList");

        var allRows = $dg.datagrid('getRows'); //获取当前所有行的数据

        for (var i = 0; i < allRows.length; i++) {
            if (allRows[i].days == "" || allRows[i].days == undefined) {
                alert("请把天数都维护好!天数不能为空");
                return;
            }
        };

        for (var i = 0; i < allRows.length; i++) {
            if (allRows[i].days * 1 > 31) {
                alert("单个月天数不能超过31天");
                return;
            }
        };

        var dateUpdate = GetExcelXML(allRows);

        var data = [];
        data[data.length] = { "name": "txt操作类型", "value": "Update" };
        data[data.length] = { "name": "txt实体", "value": "GetUpdateAttendanceDays" };
        data[data.length] = { "name": "txt返回内容", "value": "必填" };
        data[data.length] = { "name": "txtCONO", "value": "HFYG" };
        data[data.length] = { "name": "txtDIVI", "value": m_zt };
        data[data.length] = { "name": "txt品牌", "value": brand };
        data[data.length] = { "name": "txt年份", "value": year };
        data[data.length] = { "name": "txt操作人", "value": m_Username };
        data[data.length] = { "name": "txtXML", "value": dateUpdate, specialCharset: true };

        var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml
        $.messager.progress({ title: '请稍后', msg: '处理中' });
        $.ajax({
            url: GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38'),
            data: xmlData,
            type: 'POST',
            async: true,
            success: function (result) {
                try {
                    $.messager.progress("close");
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
                        $.messager.progress('close');
                        $('#dayList').datagrid("reload");
                        $.messager.alert("提示", result[0].rows[0].msg);
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function (result) {
                $.messager.progress('close');
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }

}

//定义TAB所有年份下拉值
function definitionYearCombobox() {

    $('#txtdayyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Lastthryeay, "text": m_Lastthryeay }, { "id": m_LastTwoyeay, "text": m_LastTwoyeay }, { "id": m_Lastyeay, "text": m_Lastyeay }
        , { "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Nextyeay, "text": m_Nextyeay }],
        panelHeight: 'auto',
        editable: false
    })

    $('#txtsjyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Lastthryeay, "text": m_Lastthryeay }, { "id": m_LastTwoyeay, "text": m_LastTwoyeay }, { "id": m_Lastyeay, "text": m_Lastyeay }
        , { "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Nextyeay, "text": m_Nextyeay }],
        panelHeight: 'auto',
        editable: false
    })

    $('#txtjxyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Lastthryeay, "text": m_Lastthryeay }, { "id": m_LastTwoyeay, "text": m_LastTwoyeay }, { "id": m_Lastyeay, "text": m_Lastyeay }
        , { "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Nextyeay, "text": m_Nextyeay }],
        panelHeight: 'auto',
        editable: false
    })

    $('#txtxsyear').combobox({
        valueField: 'id',
        textField: 'text',
        data: [{ "id": m_Lastthryeay, "text": m_Lastthryeay }, { "id": m_LastTwoyeay, "text": m_LastTwoyeay }, { "id": m_Lastyeay, "text": m_Lastyeay }
        , { "id": m_Nowyear, "text": m_Nowyear, "selected": true }, { "id": m_Nextyeay, "text": m_Nextyeay }],
        panelHeight: 'auto',
        editable: false
    })

}

//定义TAB所有品牌下拉值
function definitionBrandCombobox() {

    //天数维护品牌
    $('#txtdaybrand').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    })
    //实绩汇总
    $('#txtsjbrand').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    })
    //绩效汇总
    $('#txtjxbrand').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    })
    //系数维护
    $('#txtxsbrand').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    })
}

//
//---------------------------------------------------------------实绩点击弹窗-------
//
function onClicksjRow(rowIndex, RowData) {


    $('#divsj').window({
        title: "",
        top: 20,
        //width: 300,
        //height: 313,
        maximized: true
    }).window("open");

    var patternername = RowData.patternername;//版师名称
    initClicksjRowGird(patternername);
}

//【操作类型,get】【实体,GetOnePatternerMonthlyPIDetail】【返回内容,必填】【CONO,HFYG】【DIVI,EP】【品牌,EP】【年份,2014】【操作人,wangyan】【版师,郭松英】

//实绩点击加载数据
function initClicksjRowGird(patternername) {
    ClearGrid("#sjClickList");//清除表单数据
    var year = $('#txtsjyear').combobox('getValue');//获取年份
    var brand = $('#txtsjbrand').combobox('getValue');//获取品牌
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetOnePatternerMonthlyPIDetail" };
    data[data.length] = { "name": "txt返回内容", "value": "必填" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt品牌", "value": brand };
    data[data.length] = { "name": "txt年份", "value": year };
    data[data.length] = { "name": "txt操作人", "value": m_Username };
    data[data.length] = { "name": "txtXML", "value": "" };
    data[data.length] = { "name": "txt版师", "value": patternername };

    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('e60f71fc-b31f-42e7-a930-ec75745a5b38') + xmlData
    $('#sjClickList').datagrid(
        {
            //title: '样衣信息', //表格标题
            url: url,
            //async: false,
            //sortName: 'month', //排序字段
            idField: 'patternername', //标识字段,主键
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
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].patternername == "") {
                    ClearGrid("#sjClickList");
                }
            },
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号4
            columns: [[
                { field: 'patternername', title: '姓名', width: 60, rowspan: 3, align: "center" },
                { field: 'category', title: '品类', width: 60, rowspan: 3, align: "center" },
                { title: '1月', colspan: 6 },
                { title: '2月', colspan: 6 },
                { title: '3月', colspan: 6 },
                { title: '4月', colspan: 6 },
                { title: '5月', colspan: 6 },
                { title: '6月', colspan: 6 },
                { title: '7月', colspan: 6 },
                { title: '8月', colspan: 6 },
                { title: '9月', colspan: 6 },
                { title: '10月', colspan: 6 },
                { title: '11月', colspan: 6 },
                { title: '12月', colspan: 6 }
            ], [
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 },
                { title: '新版', colspan: 2 },
                { title: '调板', colspan: 2 },
                { title: '大货', colspan: 2 }

            ], [
            { field: '第01月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第01月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第01月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第01月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第01月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第01月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第02月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第02月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第02月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第02月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第02月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第02月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第03月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第03月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第03月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第03月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第03月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第03月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第04月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第04月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第04月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第04月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第04月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第04月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第05月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第05月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第05月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第05月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第05月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第05月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第06月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第06月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第06月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第06月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第06月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第06月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第07月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第07月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第07月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第07月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第07月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第07月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第08月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第08月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第08月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第08月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第08月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第08月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第09月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第09月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第09月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第09月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第09月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第09月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第10月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第10月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第10月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第10月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第10月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第10月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第11月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第11月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第11月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第11月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第11月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第11月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },

            { field: '第12月np_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第12月np_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第12月ap_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第12月ap_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第12月as_dnum', title: '数量', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } },
            { field: '第12月as_dper', title: '绩效', width: 30, formatter: function (value) { if (value == '' || value == '0') { return ""; } else { return value; } } }
            ]]
        });
}

//返回
function cancel() {
    $('#divsj').window('close');
}

//禁用退格方法
function check(e) {
    var code;
    if (!e) var e = window.event;
    if (e.keyCode) code = e.keyCode;
    else if (e.which) code = e.which;
    else return;

    if (code == 8) {
        if (
            (event.srcElement.type != "text" &&
            event.srcElement.type != "textarea" &&
            event.srcElement.type != "password") ||
            event.srcElement.readOnly == true) {
            event.keyCode = 0;
            event.returnValue = false;
        };
        return false;
        alert("ddd")
    };
}