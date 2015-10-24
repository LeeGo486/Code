﻿///郭琦琦变更成功率报表
//20140725
var statisticalType = [{ "id": "品类", "text": "品类", "selected": true }, { "id": "版师", "text": "版师" }, { "id": "设计师", "text": "设计师" }];//统计类型
var statisticalRange = [{ "id": "自主研发", "text": "自主研发", "selected": true }, { "id": "所有款式", "text": "所有款式" }];//统计范围
var m_columns = null;
var m_DDHComboxData = null;
var m_GroupData = null;
var m_Username = window.m_UserID;//取登入姓名
var m_zt;
var url111;
$(function () {
    m_zt = $.cookie('m_zt');
    //品牌combobox
    $('#txtcmbBrand').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbstky", "cbstky") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function () {
            //brandChangegroup();
            ChangeDHHJJ();
        }
    });

    //获取登入人员默认UserPost
    var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'UserPost');
    htmlobj = $.ajax({
        url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });

    //m_Username = "zhanglihua";
    var result = $.parseJSON(htmlobj.responseText);
    if (result.rows[0]['userpost'] == "管理员" || m_Username == "zhanglihua") {
        //如果是管理员或者张利华默认给上所有品牌
        ComboboxAddRow({ "id": "EP", "text": "EP" }, 0, '#txtcmbBrand');
        ComboboxAddRow({ "id": "E.Prosper", "text": "E.Prosper" }, 1, '#txtcmbBrand');
        //获取下拉数据，默认选中第一个
        var data = $('#txtcmbBrand').combobox('getData');
        $('#txtcmbBrand').combobox('setValue', data[0].text);
    } else {
        //取该人的品牌USERINFO表OwnedBrand字段判断品牌
        var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
        htmlobj = $.ajax({
            url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
            data: { "XML": xmlData },
            type: 'post',
            async: false
        });
        var result = $.parseJSON(htmlobj.responseText);
        $("#txtcmbBrand").combobox('setValue', result.rows[0].message)//把品牌赋值给HTML品牌
    }

    //统计类型
    $('#txtstatisticalType').combobox({
        valueField: 'id',
        textField: 'text',
        data: statisticalType,
        panelHeight: 'auto',
        editable: false
    });

    //统计范围
    $('#txtstatisticalRange').combobox({
        data: statisticalRange,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    ////小组下拉
    //$('#txtxzgroup').combobox({
    //    url: GetComboxALLColumnWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "CBSTKY", "CBTX15") + "&XML=" + GetFormJson([], 'getgroupxz'),
    //    valueField: 'text',
    //    textField: 'text',
    //    panelHeight: 'auto',
    //    editable: false,
    //    required: false,
    //    async: false, //异步
    //    onLoadSuccess: function (data) {
    //        if (m_GroupData == null) {
    //            m_GroupData = data;
    //            brandChangegroup();//按照品牌控制季节下拉
    //        }
    //        var m_data2 = $('#txtxzgroup').combobox('getData');
    //        $('#txtxzgroup').combobox('setValue', m_data2[m_data2.length - 1].text);
    //    }
    //});

    //初始化订货会下拉数据
    $('#txtcmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: false, //异步
        onLoadSuccess: function (data) {
            if (m_DDHComboxData == null) {
                m_DDHComboxData = data;
                ChangeDHHJJ();//按照品牌控制季节下拉
            }
            m_data1 = $('#txtcmbdhhjj').combobox('getData');
            $('#txtcmbdhhjj').combobox('setValue', m_data1[m_data1.length - 1].text);
        }
    });
    $('#A1').hide();
});

function SearchClick() {
    InitGird();
}

function InitGird() {
    ClearGrid("#tab_list");

    //var xzgroup = $('#txtxzgroup').combobox('getText');
    var cmbdhhjj = $('#txtcmbdhhjj').combobox('getText');
    var statisticalType = $('#txtstatisticalType').combobox('getText');
    var statisticalRange = $('#txtstatisticalRange').combobox('getText');
    var cmbBrand = $('#txtcmbBrand').combobox('getText');

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt返回内容", "value": "成功" };
    data[data.length] = { "name": "txt条件", "value": "2 = 1" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txtENV", "value": "PROD" };
    data[data.length] = { "name": "txt统计范围", "value": statisticalRange };
    data[data.length] = { "name": "txt统计类型", "value": statisticalType };
    data[data.length] = { "name": "txt报表格式", "value": "A" };
    data[data.length] = { "name": "txt品牌", "value": cmbBrand };
    data[data.length] = { "name": "txt订货会季节", "value": cmbdhhjj };
    //data[data.length] = { "name": "txt小组", "value": xzgroup };
    XMLData = GetDBFrameAML(data);
    var urlCol = GetGridColumnsWSRRURL('454711be-8af1-44b7-a21d-935638172b09', "80", "false", "false") + XMLData

    var htmlobj = $.ajax({
        url: urlCol,
        async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;

    columns = eval(m_columns);


    var data1 = [];
    data1[data1.length] = { "name": "txt操作类型", "value": "GET" };
    data1[data1.length] = { "name": "txt返回内容", "value": "成功" };
    data1[data1.length] = { "name": "txt条件", "value": "1 = 1" };
    data1[data1.length] = { "name": "txtCONO", "value": "HFYG" };
    data1[data1.length] = { "name": "txtDIVI", "value": m_zt };
    data1[data1.length] = { "name": "txtENV", "value": "PROD" };
    data1[data1.length] = { "name": "txt统计范围", "value": statisticalRange };
    data1[data1.length] = { "name": "txt统计类型", "value": statisticalType };
    data1[data1.length] = { "name": "txt报表格式", "value": "A" };
    data1[data1.length] = { "name": "txt品牌", "value": cmbBrand };
    data1[data1.length] = { "name": "txt订货会季节", "value": cmbdhhjj };
    //data1[data1.length] = { "name": "txt小组", "value": xzgroup };
    XMLdata1 = GetDBFrameAML(data1);
    var url = GetWSRRURL('454711be-8af1-44b7-a21d-935638172b09') + XMLdata1
    url111 = url;


    htmlobj = $.ajax({
        url: url,
        type: 'post',
        async: false
    });

    var result = $.parseJSON(htmlobj.responseText);
    for (var i = 0; i < result.rows.length; i++) {
        for (var g = 0; g < columns[0].length; g++) {
            var hhh = columns[0][g].field
            if (result.rows[i][hhh] == '0' || result.rows[i][hhh] == '0.00') {
                result.rows[i][hhh] = "";
            }
        }
    }

    $('#tabList').datagrid(
         {
             data: result,
             nowrap: true, //是否换行，True 就会把数据显示在一行里
             striped: true, //True 奇偶行使用不同背景色
             collapsible: false, //可折叠
             //remoteSort: true, //定义是否从服务器给数据排序
             fit: true,
             columns: columns,
             rownumbers: true,//行号
             singleSelect: true,//单行选择
             onLoadSuccess: function (data) {
                 if (data.rows.length == 1) {
                     ClearGrid("#tabList");
                 }
                 //if (data.rows[0].补款数_含所有系列_ == "0") {
                 //    return "";
                 //}
                 $("#A1").show();
             },
             rowStyler: function (index, row) {
                 if (statisticalType == "品类") {
                     if (row.品类 == "小计") {
                         return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                     }
                     if (row.品类 == "合计") {
                         return 'background-color:#d44864;color:#000000;font-weight:bold;';
                     }
                 }
                 else if (statisticalType == "设计师") {
                     if (row.设计师 == "小计") {
                         return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                     }
                     if (row.设计师 == "合计") {
                         return 'background-color:#d44864;color:#000000;font-weight:bold;';
                     }
                 }
                 else if (statisticalType == "版师") {
                     if (row.版师 == "小计") {
                         return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                     }
                     if (row.版师 == "合计") {
                         return 'background-color:#d44864;color:#000000;font-weight:bold;';
                     }
                 }

             }
         });
    if (columns.length != "0") {
        for (var i = 1; i < columns[0].length; i++) {
            var col = $('#tabList').datagrid('getColumnOption', columns[0][i].field);
            //col.formater = Formater.Nums;
            col.align = "right";
            col.title = col.title.toUpperCase();
            //col.formater = function (value) { if (value == undefined || value == '0') { return ""; }; }
        }
    }
    $('#tabList').datagrid();
}

//控制订货会季节
function ChangeDHHJJ() {
    var strGroupType = $('#txtcmbBrand').combobox("getText");
    if (strGroupType.substr(0, 2) == "EP") {
        strGroupType = "EP"
    }
    else if (strGroupType.substr(0, 2) == "E.P") {
        strGroupType = "E.Prosper"
    }
    else if (strGroupType.substr(0, 2) == "Do") {
        strGroupType = "Do"
    }
    else if (strGroupType.substr(0, 2) == "Ki") {
        strGroupType = "Kids"
    }

    if (m_DDHComboxData == null) {
        return;
    }
    var data = m_DDHComboxData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(strGroupType) >= 0) {
            data1.push(data[i]);
        }
    }
    $('#txtcmbdhhjj').combobox({ url: "" });
    $('#txtcmbdhhjj').combobox("loadData", data1);
}


function brandChangegroup() {
    brand = $('#txtcmbBrand').combobox("getText");

    if (brand.substr(0, 2) == "EP") {
        brand = "EP"
    }
    else if (brand.substr(0, 2) == "E.P") {
        brand = "E.Prosper"
    }
    else if (brand.substr(0, 2) == "Do") {
        brand = "DoubleLove"
    }

    if (m_GroupData == null) {
        return;
    }
    var data = m_GroupData;
    var data1 = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].id.toString().indexOf(brand) >= 0) {
            data1.push(data[i]);
        }
    }
    $('#txtxzgroup').combobox({ url: "" });
    $('#txtxzgroup').combobox("loadData", data1);
}




function excelExport() {

    var listData = $('#tabList').datagrid('getRows')

    if (listData.length <= 1 || listData == undefined) {
        alert("请先加载数据");
        return;
    }

    EasyUI_DataGrid_ExcelExport1($('#tabList'), $('#tabList'))
}

//导出Exel主函数
function EasyUI_DataGrid_ExcelExport1(pgrid, pagination) {
    var btnExcel = null;
    pagination.find('a.l-btn').each(function () {
        if ($(this).find('span.icon-excel').length) {
            btnExcel = $(this);
            btnExcel.linkbutton('disable');
            btnExcel.linkbutton({ iconCls: "pagination-loading" });

        }
    });
    //if (btnExcel == null) {
    //    return;
    //}

    var dataOptions = pgrid.datagrid("options");


    var strUrl = url111;

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "打板成功率报表";

    var strXMLCol = "<Root><List>";

    if (dataColumnsFrozen != null && dataColumnsFrozen.length > 0) {
        for (var i = 0; i < dataColumnsFrozen[0].length; i++) {

            if (dataColumnsFrozen[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + dataColumnsFrozen[0][i].field + "</field>";

            if (dataColumnsFrozen[0][i].title) {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].title + "</title>";
            }
            else {
                strXMLCol += "<title>" + dataColumnsFrozen[0][i].field + "</title>";

            }
            if (dataColumnsFrozen[0][i].width) {
                strXMLCol += "<width>" + dataColumnsFrozen[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumnsFrozen[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumnsFrozen[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumnsFrozen[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }
            strXMLCol += "</Rows>";
        }
    }
    if (dataColumns != null && dataColumns.length > 0) {
        for (var i = 0; i < dataColumns[0].length; i++) {

            if (dataColumns[0][i].checkbox == true) {
                continue;
            }

            strXMLCol += "<Rows>";
            strXMLCol += "<field>" + (dataColumns[0][i].field) + "</field>";

            if (dataColumns[0][i].title) {
                strXMLCol += "<title>" + (dataColumns[0][i].title) + "</title>";
            }
            else {
                strXMLCol += "<title>" + (dataColumns[0][i].field) + "</title>";

            }

            if (dataColumns[0][i].width) {
                strXMLCol += "<width>" + dataColumns[0][i].width + "</width>";
            }
            else {
                strXMLCol += "<width></width>";

            }

            if (dataColumns[0][i].hidden) {
                strXMLCol += "<hidden>true</hidden>";
            }
            else {
                strXMLCol += "<hidden>false</hidden>";
            }

            if (dataColumns[0][i].formatDataType) {
                strXMLCol += "<formatDataType>" + dataColumns[0][i].formatDataType + "</formatDataType>";
            }
            else {
                strXMLCol += "<formatDataType></formatDataType>";
            }

            //if (dataColumns[0][i].align) {
            //    strXMLCol += "<align>" + dataColumns[0][i].align + "</align>";
            //}
            //else {
            //    strXMLCol += "<align>left</align>";
            //} 


            //if (dataColumns[0][i].halign) {
            //    strXMLCol += "<halign>" + dataColumns[0][i].halign + "</halign>";
            //}
            //else {
            //    strXMLCol += "<halign>center</halign>";
            //}
            strXMLCol += "</Rows>";
        }
    }

    strXMLCol += "</List></Root>";

    strXMLCol = strXMLCol.replace(/\(/g, "").replace(/\)/g, "");
    dataParam.ExcelExportColumns = strXMLCol;

    $.messager.confirm('提示框', "是否导出", function (e) {
        if (e) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });

            $.ajax({
                url: strUrl + "&pagerows=0&pageNumber=1&ExcelExport=true&title=" + escape(title) + "&rd=" + Math.random(),
                data: dataParam,
                type: 'POST',
                options: "JSON",
                success: function (data) {
                    if (btnExcel != null) {
                        btnExcel.linkbutton('enable');

                        btnExcel.linkbutton({ iconCls: "icon-excel" });
                    }
                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    $.messager.progress('close');
                    var strFileName = eval("[" + data + "]")[0].FileName;
                    //strFileName = strFileName.substring(0, 29) + FileName.substring(4);
                    window.location.href = strFileName;
                },
                error: function (date) {
                    alert("错误!");
                    $.messager.progress('close');
                }

            });
        }
    });
}