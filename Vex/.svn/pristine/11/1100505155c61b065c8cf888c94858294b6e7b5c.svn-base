/// JS名：VODPCSR.js
/// 说明：版师制版分类汇总表变更
/// 创建人：郭琦琦 
/// 创建日期：2014-07-22

var m_columns = null;//动态列
var columns;//easyui 框架自己的动态列属性
var m_type = [{ "id": "1", "text": '新版类型' }, { "id": "2", "text": "新版品类" }, { "id": "3", "text": "新版系列" }, { "id": "4", "text": "新版品类(自主)" }
              , { "id": "5", "text": "调版品类" }, { "id": "6", "text": "调版系列" }]//统计类型6种
var m_Nowdate;//当前日期
var m_FirstDate;//本月第一天
var m_Username = window.m_UserID;//取登入姓名
var m_DDHComboxData = null;//定义订货会季节下拉
var m_data1;//订货会季节
var m_beginDate;//开始时间
var m_endDate;//结束时间
var m_season;//订货会季节
var m_zt;
$(function () {

    m_zt = $.cookie('m_zt');
    m_FirstDate = (new Date(new Date().getFullYear() + "/" + (new Date().getMonth() + 1) + "/" + "01"))//本月第一天
    var nowDate = (new Date()).DateAdd('d', -0).format("yyyy-MM-dd");//今天时间
    m_Nowdate = nowDate.substr(0, 4) + nowDate.substr(5, 2) + nowDate.substr(8, 2)//截取时间yyyymmdd   m_Nowdate今天时间

    $("#txtBeginDate").datebox("setValue", m_FirstDate.format("yyyy-MM-dd"));///这个月第一天时间
    $("#txtEndDate").datebox("setValue", m_FirstDate.DateAdd('m', +1).format("yyyy-MM-dd"));///下月时间第一天

    //查询方式
    $('#cmbSelectType').combobox({
        data: [{ "id": "date", text: "日期", selected: true }, { "id": "orderPlacing", text: "订货会季节" }],
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        onSelect: function (record) {
            slectTypeChange(record);
            ChangeDHHJJ();
        }
    });

    //统计对象
    $('#txtCountType').combobox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });


    //统计类型3种combobox
    $('#txttype').combobox({
        data: m_type,
        panelHeight: 'auto',
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        onLoadSuccess: function (data) {
            var data = $('#txttype').combobox('getData');
            $('#txttype').combobox('setValue', data[0].id);
        },
        onChange: function () {
            var counttype = $('#txttype').combobox('getValue');

            var data = [];
            $('#txtCountType').combobox("loadData", data);

            if (counttype == "1" || counttype == "2" || counttype == "3" || counttype == "4") {
                ComboboxAddRow({ "id": "版师", "text": "版师" }, 0, '#txtCountType');
            } else if (counttype == "5" || counttype == "6") {
                ComboboxAddRow({ "id": "版师", "text": "版师" }, 0, '#txtCountType');
                ComboboxAddRow({ "id": "设计师", "text": "设计师" }, 0, '#txtCountType');
            }
            var CountTypeData = $('#txtCountType').combobox('getData');
            $('#txtCountType').combobox('setValue', CountTypeData[CountTypeData.length - 1].text);
        }

    });

    //初始化订货会下拉数据
    $('#txtcmbdhhjj').combobox({
        url: GetComboxWSRRURL('bd4c0ca6-42c7-4e5c-a432-515b63f5cc16', "", "orderseason", "orderseason") + "&DIVI=" + m_zt,
        valueField: 'id',
        textField: 'text',
        panelHeight: '200',
        editable: false,
        required: true,
        async: true, //异步
        onLoadSuccess: function (data) {
            if (m_DDHComboxData == null) {
                m_DDHComboxData = data;
                ChangeDHHJJ();//按照品牌控制季节下拉
            }
            m_data1 = $('#txtcmbdhhjj').combobox('getData');
            $('#txtcmbdhhjj').combobox('setValue', m_data1[m_data1.length - 1].text);
        }
    });

    initBrand();

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

    if (result.rows[0]['userpost'] == "管理员" || m_Username == "zhanglihua" || m_Username == "tianling") {
        //如果是管理员或者张利华或者田玲默认给上所有品牌
        ComboboxAddRow({ "id": "EP", "text": "EP" }, 0, '#txtbrand');
        ComboboxAddRow({ "id": "E.Prosper", "text": "E.Prosper" }, 1, '#txtbrand');
        //ComboboxAddRow({ "id": "DoubleLove", "text": "DoubleLove" }, 2, '#txtbrand');
        //获取下拉数据，默认选中第一个
        var data = $('#txtbrand').combobox('getData');
        $('#txtbrand').combobox('setValue', data[0].text);
    } else {
        //取该人的品牌USERINFO表OwnedBrand字段判断品牌
        //var xmlData = GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetOwnedBrand');
        //htmlobj = $.ajax({
        //    url: GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9'),
        //    data: { "XML": xmlData },
        //    type: 'post',
        //    async: false
        //});
        //var result = $.parseJSON(htmlobj.responseText);
        //$("#txtbrand").combobox('setValue', result.rows[0]['ownedbrand'])//把品牌赋值给HTML品牌
    }
    $('#A1').hide();
});

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

//查询方式
function slectTypeChange(type) {
    $("#date")[0].style.display = "none";
    $("#orderPlacing")[0].style.display = "none";
    $("#" + type.id)[0].style.display = "inline-block";
}

//按照品牌控制季节下拉数据
function ChangeDHHJJ() {
    var brandType = $('#txtbrand').combobox("getText");
    if (brandType.substr(0, 2) == "EP") {
        brandType = "EP"
    }
    else if (brandType.substr(0, 2) == "E.P") {
        brandType = "E.Prosper"
    }
    else if (brandType.substr(0, 2) == "Do") {
        brandType = "Do"
    }
    else if (brandType.substr(0, 2) == "Ki") {
        brandType = "Kids"
    }
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
    $('#txtcmbdhhjj').combobox({ url: "" });
    $('#txtcmbdhhjj').combobox("loadData", data1);//重加载季节下拉数据
}

//点击查询
function SearchClick() {

    m_beginDate = "";
    m_endDate = "";
    m_season = "";
    var selectType = $('#cmbSelectType').combobox("getValue");

    //根据日期
    if (selectType == "date") {

        var beginDate = $('#txtBeginDate').combobox('getValue');//获取开始时间
        var endDate = $('#txtEndDate').combobox('getValue');//获取结束时间
        m_beginDate = beginDate.substr(0, 4) + beginDate.substr(5, 2) + beginDate.substr(8, 2)//截取时间yyyymmdd  beginDate
        m_endDate = endDate.substr(0, 4) + endDate.substr(5, 2) + endDate.substr(8, 2)//截取时间yyyymmdd   endDate

        if (beginDate == "") {
            $.messager.alert("提示", "开始时间不能为空！", 'error');
            return;
        }

        if (endDate == "") {
            $.messager.alert("提示", "结束时间不能为空！", 'error');
            return;
        }
        m_season = "";
    }
    else if (selectType == "orderPlacing") {//订货会
        m_season = $('#txtcmbdhhjj').combobox("getValue");

        if (m_season == "") {
            $.messager.alert("提示", "订货会季节不能为空！", 'error');
            return;
        }
        m_beginDate = "";
        m_endDate = "";
    }
    initGird();//加载数据
}

//加载数据
function initGird() {
    ClearGrid("#tabList");//清除表单数据
    var type = $('#txttype').combobox('getValue');//获取类型
    var brand = $('#txtbrand').combobox('getText');//获取品牌
    var countType = $('#txtCountType').combobox('getText');//获取统计对象
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": "GetListPatternMakingSummary" };
    data[data.length] = { "name": "txt返回内容", "value": "成功" };
    data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    data[data.length] = { "name": "txtDIVI", "value": m_zt };
    data[data.length] = { "name": "txt开始日期", "value": m_beginDate };
    data[data.length] = { "name": "txt结束日期", "value": m_endDate };
    data[data.length] = { "name": "txt日期", "value": m_Nowdate };
    data[data.length] = { "name": "txt查询类型", "value": type };
    data[data.length] = { "name": "txt标识", "value": "1" };
    data[data.length] = { "name": "txt数据标识", "value": "2" };
    data[data.length] = { "name": "txt订货会季节", "value": m_season };
    data[data.length] = { "name": "txt品牌", "value": brand };
    data[data.length] = { "name": "txt统计对象", "value": countType };

    XMLData = GetDBFrameAML(data);
    var urlCol = GetGridColumnsWSRRURL('06d54b26-796a-4fa6-bbba-1ddcb4e671fc', "80", "false", "false") + XMLData
    //ajax取动态列
    var htmlobj = $.ajax({
        url: urlCol,
        async: false
    });
    var Text = $.parseJSON(htmlobj.responseText);
    m_columns = Text.Col;
    m_columns = eval(m_columns);

    //var obj = new Object();
    //obj = { field: '合计', width: 80, search: false, sortable: false, editor: 'text', title: '合计' };
    //m_columns[0].push(obj)

    var data1 = [];
    data1[data1.length] = { "name": "txt操作类型", "value": "GET" };
    data1[data1.length] = { "name": "txt实体", "value": "GetListPatternMakingSummary" };
    data1[data1.length] = { "name": "txt返回内容", "value": "成功" };
    data1[data1.length] = { "name": "txtCONO", "value": "HFYG" };
    data1[data1.length] = { "name": "txtDIVI", "value": m_zt };
    data1[data1.length] = { "name": "txt开始日期", "value": m_beginDate };
    data1[data1.length] = { "name": "txt结束日期", "value": m_endDate };
    data1[data1.length] = { "name": "txt日期", "value": m_Nowdate };
    data1[data1.length] = { "name": "txt查询类型", "value": type };
    data1[data1.length] = { "name": "txt标识", "value": "2" };
    data1[data1.length] = { "name": "txt数据标识", "value": "2" };
    data1[data1.length] = { "name": "txt订货会季节", "value": m_season };
    data1[data1.length] = { "name": "txt品牌", "value": brand };
    data1[data1.length] = { "name": "txt统计对象", "value": countType };


    XMLdata1 = GetDBFrameAML(data1);
    var url = GetWSRRURL('06d54b26-796a-4fa6-bbba-1ddcb4e671fc') + XMLdata1
    $('#tabList').datagrid(
         {
             url: url,
             nowrap: true, //是否换行，True 就会把数据显示在一行里
             striped: true, //True 奇偶行使用不同背景色
             collapsible: false, //可折叠
             fit: true,
             columns: m_columns,
             rownumbers: true,//行号
             singleSelect: true,//单行选择
             //pagination: true, //是否开启分页
             //pageSize: 20, //默认一页数据条数
             rowStyler: function (index, row) {
                 if (row.muser == "小计") {
                     return 'background-color:#CCCCCC;color:#000000;font-weight:bold;';
                 }
                 if (row.muser == "合计") {
                     return 'background-color:#d44864;color:#000000;font-weight:bold;';
                 }
             },
             onLoadSuccess: function () {
                 $("#A1").show();
             }
         });
    //取动态列,格式化列属性
    var columns = m_columns;
    if (columns.length != "0") {
        var col = $('#tabList').datagrid('getColumnOption', columns[0][columns[0].length - 1].field);
        var col1 = $('#tabList').datagrid('getColumnOption', columns[0][0].field);
        var col2 = $('#tabList').datagrid('getColumnOption', columns[0][1].field);
        col1.width = 50;
        //col.align = "center";
        col.title = "AAAA合计";
        col1.title = "AAAA组别";
        col2.title = "AAAA姓名";
        col1.hidden = true;
        for (var i = 1; i < columns[0].length; i++) {
            var col = $('#tabList').datagrid('getColumnOption', columns[0][i].field);
            col.formater = Formater.Nums;
            col.align = "center";
            col.title = col.title.toUpperCase();
            col.title = col.title.substring(4);
        }
    }
    $('#tabList').datagrid();//reload
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

    var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "版师制版分类汇总表变更";

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
                }
            });
        }
    });
}