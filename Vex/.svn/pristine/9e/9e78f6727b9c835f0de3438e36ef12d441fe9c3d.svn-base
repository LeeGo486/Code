///郭琦琦变更成功率报表
//20140725
//修改：俞佳伟
//修改时间:2015-08-26
var statisticalType = [{ "id": "品类", "text": "品类", "selected": true }, { "id": "版师", "text": "版师" }, { "id": "设计师", "text": "设计师" }, { "id": "产品线", "text": "产品线" }];//统计类型
var statisticalRange = [{ "id": "自主研发", "text": "自主研发", "selected": true }, { "id": "所有款式", "text": "所有款式" }];//统计范围
var m_columns = null;
var m_DDHComboxData = null;
var m_GroupData = null;
var m_Username = window.m_UserID;//取登入姓名
var m_zt;
var url111;
var m_productline = '';  //产品线
var m_season = '';       //季节
var m_statisticalType = '';  //统计类型
var m_brand = '';
var m_dhhjj = '';

$(function () {
    m_zt = $.cookie('m_zt');
    //部门combobox
    $('#txtproductline').combobox();
    $('#txtcmbBrand').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onSelect: function (brand) {
            $('#txtproductline').combobox({
                //url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandProductLine') + "&Where=CBTX40='" + brand.text + "'",
                url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx15", "cbtx15") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandLineDiff') + "&Where=CBTX40='" + brand.text + "'",
                editable: false,
                valueField: 'id',
                textField: 'text',
                required: true,
                multiple: true
            });
        }
    });

    //统计类型
    $('#txtstatisticalType').combobox({
        valueField: 'id',
        textField: 'text',
        data: statisticalType,
        panelHeight: 'auto',
        editable: false
    });

    //初始化季节下拉数据
    $('#txtseason').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetStyleSeason'),
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        //required: true,
        //multiple: true,
        async: false
    });
    $('#A1').hide();
});

function SearchClick() {
    InitGird();
}

function InitGird() {
    ClearGrid("#tab_list");

    //var xzgroup = $('#txtxzgroup').combobox('getText');
    m_season = $('#txtseason').combobox('getValue');
    m_statisticalType = $('#txtstatisticalType').combobox('getText');
    //var statisticalRange = $('#txtstatisticalRange').combobox('getText');
    m_brand = $('#txtcmbBrand').combobox('getText');
    m_productline = $('#txtproductline').combobox('getValues');

    if (m_brand == '') {
        $.messager.alert("提示", "请选择部门", "warning");
        return false;
    }
    if (m_productline == '') {
        $.messager.alert("提示", "请选择产品线", "warning");
        return false;
    }
    if (m_season == '') {
        $.messager.alert("提示", "请选择季节", "warning");
        return false;
    }
    
    m_dhhjj = '';
    for (var i = 0; i < m_productline.length; i++) {
        m_dhhjj += '#' + m_productline[i] + ' - ' + m_season + '#,';
    }
    m_dhhjj = m_dhhjj.substring(0, m_dhhjj.length - 1);
    //cmbBrand.join(' - ' + txtplmseason) + ' - ' + txtplmseason + '#';  //订货会季节

    m_productline = '#' + m_productline.join('#,#') + '#';

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt返回内容", "value": "成功" };
    data[data.length] = { "name": "txt条件", "value": "2 = 1" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txtENV", "value": "PROD" };
    data[data.length] = { "name": "txt统计范围", "value": "" };
    data[data.length] = { "name": "txt统计类型", "value": m_statisticalType };
    //data[data.length] = { "name": "txt报表格式", "value": "A" };
    data[data.length] = { "name": "txt品牌", "value": m_brand };
    data[data.length] = { "name": "txt产品线", "value": m_productline };
    data[data.length] = { "name": "txtPLM季节", "value": m_season };
    data[data.length] = { "name": "txt订货会季节", "value": m_dhhjj };
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
    data1[data1.length] = { "name": "txt统计范围", "value": "" };
    data1[data1.length] = { "name": "txt统计类型", "value": m_statisticalType };
    //data1[data1.length] = { "name": "txt报表格式", "value": "A" };
    data1[data1.length] = { "name": "txt品牌", "value": m_brand };
    data1[data1.length] = { "name": "txt产品线", "value": m_productline };
    data1[data1.length] = { "name": "txtPLM季节", "value": m_season };
    data1[data1.length] = { "name": "txt订货会季节", "value": m_dhhjj };
    XMLdata1 = GetDBFrameAML(data1);
    var url = GetWSRRURL('454711be-8af1-44b7-a21d-935638172b09') + XMLdata1
    url111 = url;


    htmlobj = $.ajax({
        url: url,
        type: 'post',
        async: false
    });

    var result = $.parseJSON(htmlobj.responseText);
    //for (var i = 0; i < result.rows.length; i++) {
    //    for (var g = 0; g < columns[0].length; g++) {
    //        var hhh = columns[0][g].field
    //        if (result.rows[i][hhh] == '0' || result.rows[i][hhh] == '0.00') {
    //            result.rows[i][hhh] = "";
    //        }
    //    }
    //}

    $('#tabList').datagrid({
        data: result,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        //remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        onDblClickRow: onDblClickRow,
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
            if (m_statisticalType == "品类") {

                if (row.品类 == "总计") {
                    return 'background-color:#d44864;color:#000000;font-weight:bold;';
                }
            }
            else if (m_statisticalType == "设计师") {

                if (row.设计师 == "总计") {
                    return 'background-color:#d44864;color:#000000;font-weight:bold;';
                }
            }
            else if (m_statisticalType == "版师") {

                if (row.版师 == "总计") {
                    return 'background-color:#d44864;color:#000000;font-weight:bold;';
                }
            }
            else if (m_statisticalType == "产品线") {

                if (row.产品线 == "总计") {
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

//双击查看明细事件
function onDblClickRow(index, row) {

    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt返回内容", "value": "成功" };
    data[data.length] = { "name": "txt条件", "value": "2 = 1" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txtENV", "value": "PROD" };
    data[data.length] = { "name": "txt统计类型", "value": m_statisticalType };
    //data[data.length] = { "name": "txt报表格式", "value": "A" };
    data[data.length] = { "name": "txt品牌", "value": m_brand };
    data[data.length] = { "name": "txt产品线", "value": m_productline };
    data[data.length] = { "name": "txtPLM季节", "value": m_season };
    data[data.length] = { "name": "txt订货会季节", "value": m_dhhjj };

    if (m_statisticalType == "版师") {
        data[data.length] = { "name": "txt统计范围", "value": row.版师 };

        $('#winDetail').window({
            title: "人员：" + row.版师
        }).window('open');
    }
    else if (m_statisticalType == "设计师") {
        data[data.length] = { "name": "txt统计范围", "value": row.设计师 };

        $('#winDetail').window({
            title: "人员：" + row.设计师
        }).window('open');
    }
    else {
        $.messager.alert("提示", "只允许版师和设计师查询明细", "warning");
        return false;
    }


    $('#tabDetail').datagrid({
        url: GetWSRRURL('454711be-8af1-44b7-a21d-935638172b09') + GetDBFrameAML(data),
        striped: true,
        rownumbers: true,
        columns: [[
            {
                field: "designimagesmall", title: "款图", width: 120, formatter: function (value, row, index) {
                    var data = "<img src='http://192.168.0.72/FlexPLMAPI/GetFlexImage.aspx?IMG=" + value + "' style='height:70px' border='0'/></a>";
                    return data;
                }
            },
            { field: "measurementsid", title: "选中样板号", width: 120 },
            { field: "num", title: "选中样衣数", width: 120 }
        ]],
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && data.rows[0].measurementsid == "") {
                ClearGrid("#tabDetail");
            }
        }
    });
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