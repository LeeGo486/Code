///JS:MultipleSample.js
///创建者：俞佳伟
///创建时间：2015-09-09


var m_zt = '';
var m_username = '';
var m_group = '';
var m_states = '';

$(function () {

    m_username = $.cookie('m_UserNameC'); //取登入姓名
    m_zt = $.cookie('m_zt');

    $('#txtproductline').combobox();
    $('#txtstate').combobox();
    $('#txtdivision').combobox();

    //小组样衣工
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "SAMPLEMAKER_LIST" };
    data[data.length] = { "name": "txt实体", "value": "GETEFFECT" };
    data[data.length] = { "name": "txt品牌", "value": "EP" };
    var xmlData = GetDBFrameAML(data);
    var group2 = $.ajax({
        url: GetWSRRURL('9e30352a-4456-4287-9034-86a09926d8d5') + xmlData,
        type: 'post',
        async: false
    });
    m_group = $.parseJSON(group2.responseText);

    $('#txtsamplegroup').combobox({
        panelHeight: 120,
        valueField: "cbstky",
        textField: "cbstky",
        data: m_group.rows
    });

    //初始化品类下拉数据
    $('#txtcategory').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', '', 'category', 'category') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GETCATEGORY'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 200,
        editable: false,
        required: true,
        multiple: true, //多选
        async: true //异步
    });

    //初始化季节下拉数据
    $('#txtseason').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetStyleSeason'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
        //async: false
    });

    //初始化部门 只有EP 20150909
    $("#txtbrand").combobox({
        //url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrand'),
        data: [{ "id": "EP", "text": "EP", selected: true }],
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        required: true,
        async: false//同步

    });

    //初始化产品线
    $('#txtproductline').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx15", "cbtx15") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandLineDiff') + "&Where=CBTX40='EP'",
        editable: false,
        valueField: 'id',
        textField: 'text',
        required: true,
        multiple: true
    });

    //初始化确认样状态
    var stateData = [];
    stateData[stateData.length] = { "name": "txt操作类型", "value": "CONFIRMSAMPLE_STAT_LIST" };
    stateData[stateData.length] = { "name": "txt实体", "value": "GETEFFECT" };
    stateData[stateData.length] = { "name": "txt品牌", "value": "EP" };
    var xmlData = GetDBFrameAML(stateData);
    var result = $.ajax({
        url: GetWSRRURL('9e30352a-4456-4287-9034-86a09926d8d5') + xmlData,
        type: 'post',
        async: false
    });
    m_states = $.parseJSON(result.responseText);
    $('#txtstate').combobox({
        data: m_states.rows,
        panelHeight: 200,
        valueField: 'cbstid',
        textField: 'cbtx40',
        multiple: true  //多选
    });
    getSampleWorker('EP'); //初始化版师

});

//初始化版师下拉数据ownedcode
function getSampleWorker(brand) {
    $('#txtdivision').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', '', 'usernamec', 'usernamec') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtBrand", "value": brand }], 'GetPattern'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 200,
        editable: false,
        required: true,
        multiple: true, //多选
        async: true //异步
    });
}

function LoadDataClick() {
    var txtbrand = $('#txtbrand').combobox('getValue');  //部门
    var txtproductlines = $('#txtproductline').combobox('getValues'); //产品线
    var txtseason = $('#txtseason').combobox('getValue');  //PLM季节
    var txtseason1 = (txtseason.replaceAll('-', '')).replaceAll(' ', '');  //PLM季节去掉‘-’ ‘ ’
    var txtOrderSeason = '';         //订货会季节
    if (txtseason1 == "2015秋冬") {
        if (txtproductlines.length > 2) {
            $.messager.alert("提示", "季节为2015秋冬时,产品线必须为EP或者E.Prosper", "warning");
            return false;
        }
        else if (txtproductlines.length == 2) {
            if ((txtproductlines[0] == "EP" || txtproductlines[0] == "E.Prosper") && (txtproductlines[1] == "EP" || txtproductlines[1] == "E.Prosper")) {
                txtOrderSeason = "#EPH2015秋冬#,#EP2015秋冬#";
            }
            else {
                $.messager.alert("提示", "季节为2015秋冬时,产品线必须为EP或者E.Prosper", "warning");
                return false;
            }
        }
        else if (txtproductlines.length == 1) {
            if (txtproductlines[0] == "EP") {
                txtOrderSeason = "#EPH2015秋冬#";
            }
            else if (txtproductlines[0] == "E.Prosper") {
                txtOrderSeason = "#EP2015秋冬#";
            }
            else {
                $.messager.alert("提示", "季节为2015秋冬时,产品线必须为EP或者E.Prosper", "warning");
                return false;
            }
        }

    }
    else {
        for (var i = 0; i < txtproductlines.length; i++) {
            txtOrderSeason += '#' + txtproductlines[i] + txtseason1 + '#,';
        }
        txtOrderSeason = txtOrderSeason.substring(0, txtOrderSeason.length - 1);
    }

    var category = $('#txtcategory').combobox('setText', $('#txtcategory').combobox("getText")).combobox('getValues'); //品类
    var cat = '';
    if (category.length > 0) {
        cat = '#' + category[0] + '#';
        for (var i = 1; i < category.length; i++) {
            cat = cat + ',#' + category[i] + '#';
        }
        //cat = '(' + cat + ')';
    }
    var divisions = $('#txtdivision').combobox('setText', $('#txtdivision').combobox('getText')).combobox('getValues'); //获取版师
    var designer = '';
    if (divisions.length > 0) {
        designer = '#' + divisions[0] + '#';
        for (var i = 1; i < divisions.length; i++) {
            designer = designer + ',#' + divisions[i] + '#';
        }
        //designer = '(' + designer + ')';
    }
    //var beginDate = $('#beginDate').datebox('getText'); //获取上货开始时间
    //var endDate = $('#endDate').datebox('getText');   //获取上货结束事件
    var stateArrs = $('#txtstate').combobox('getValues');      //获取状态
    var txtdyyyno1 = $('#txtdyyyno1').val();
    var state = '';  //转换格式为#...#
    if (stateArrs.length > 0) {
        state = '#' + stateArrs[0] + '#';
        for (var j = 1; j < stateArrs.length; j++) {
            state = state + ',#' + stateArrs[j] + '#';
        }
        // state = '(' + state + ')';
    }

    //判断是否选择查询条件
    if (txtbrand == '' || txtbrand == undefined) {
        $.messager.alert('提示', '请选择部门', 'warning');
        return;
    }
    if (txtproductlines == '' || txtproductlines == undefined) {
        $.messager.alert('提示', '请选择产品线', 'warning');
        return;
    }
    if (txtseason == '' || txtseason == undefined) {
        $.messager.alert('提示', '请选择季节', 'warning');
        return;
    }


    var data = [];
    data[data.length] = { "name": "txtMethod", "value": "GetMultipleSampleHead" };
    data[data.length] = { "name": "txt季节", "value": txtOrderSeason, specialCharset: true }; // $('#txtcmbdhhjj').combobox("getValue")
    //data[data.length] = { "name": "txt用户", "value": m_username, specialCharset: true };
    //data[data.length] = { "name": "txt品牌", "value": txtbrand, specialCharset: true };
    data[data.length] = { "name": "txt品类", "value": cat, specialCharset: true };
    data[data.length] = { "name": "txt版师", "value": designer, specialCharset: true }; //版师
    //data[data.length] = { "name": "txt上货日期1", "value": beginDate.replace(/-/g, '') };
    //data[data.length] = { "name": "txt上货日期2", "value": endDate.replace(/-/g, '') };
    data[data.length] = { "name": "txt样衣状态", "value": state, specialCharset: true };
    //data[data.length] = { "name": "txtCONO", "value": "HFYG" };
    //data[data.length] = { "name": "txtDIVI", "value": m_zt };
    //data[data.length] = { "name": "txt季节", "value": txtseason };
    data[data.length] = { "name": "txt产品线", "value": '#' + txtproductlines.join('#,#') + '#' };
    data[data.length] = { "name": "txt样板号", "value": txtdyyyno1 };
    initGird(data);
}

function initGird(data) {
    ClearGrid('#tabList');
    var xmlData = GetDBFrameAML(data);
    m_url = GetWSRRURL('9e30352a-4456-4287-9034-86a09926d8d5') + xmlData;
    $('#tabList').datagrid({
        url: m_url,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: false, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        rownumbers: true, //行号
        singleSelect: true, //单行选择 
        onDblClickRow: onDblClickRow, //
        columns: [[
            { field: 'fshangdate', title: '上货波段' },
            { field: 'faccbrand', title: '产品线' },
            { field: 'fseries', title: '系列' },
            { field: 'fstyleaddcolor', title: '大货款号' },
            { field: 'dyyyno', title: '样板号' },
            { field: 'dyapdt', title: '调板进度' },
            { field: 'dyysel', title: '入选情况' },
            { field: 'dydept', title: '样衣组别' },
            { field: 'dystat', title: '样衣状态' },
            { field: 'dyfadt', title: '面辅料到货时间' },
            { field: 'dypddt', title: '计划发出生产时间' },
            { field: 'dyaddt', title: '实际发出生产时间' },
            { field: 'dyprdt', title: '计划收回时间' },
            { field: 'dyardt', title: '实际收回时间' },
            { field: 'dycysl', title: '确认样发放时间' },
            { field: 'dyremk2', title: '备注' }
        ]],
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && data.rows[0].productname == "") {
                ClearGrid("#tabList");
                $.messager.alert("提示", "无相关数据!");
            }

        }
        //rowStyler: function (index, row) {
        //if (row.cancel == 1) {  //取消显示灰色
        //    return 'background-color:#808080;color:#000000;';
        //}
        //else if (row.duplicate == 1) { //同款显示黑色
        //    return 'background-color:#000000;color:#FFFFFF;';
        //}
        //else if (row.sended == 1) {  //已发显示黄色
        //    return 'background-color: #FFFF00;color:#000000;';
        //}
        //else if (row.delivered == 1) {  //已调
        //    return 'background-color:#BEFEC2;color:#000000;';
        //}
        //else {   //默认为白色
        //    return 'background-color:#FFFFFF;color:#000000;';
        //}
        //}
    });
}

//双击事件
function onDblClickRow(index, row) {
    var zt = $("#txtbrand").combobox('getValue');

    var dyprno = row.dyprno;
    if (dyprno == '' && dyprno == undefined) {
        $.messager.alert("提示", "无法取到款号", "warning");
        return;
    }
    var data = [];
    data[data.length] = { "name": "txtMethod", "value": "GetMultipleSample" };
    data[data.length] = { "name": "txtDYPRNO", "value": dyprno };

    var xmlData = GetDBFrameAML(data);

    $('#winDetailForEP').window({
        title: "样衣明细",
        iconCls: 'icon-search',
        fit: true,
        onResize: function () {
            $(this).window('center');
        }
    }).window('open');

    $('#tabDetailForEP').datagrid({
        url: GetWSRRURL('9e30352a-4456-4287-9034-86a09926d8d5') + xmlData,
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        rownumbers: true, //行号
        singleSelect: true, //单行选择 
        onDblClickRow: showEditWinForEP,
        columns: [[
            { field: 'fshangdate', title: '上货波段' },
            { field: 'faccbrand', title: '产品线' },
            { field: 'fseries', title: '系列' },
            { field: 'dyfsac', title: '大货款号' },
            { field: 'dyyyno', title: '样衣号' },
            { field: 'dyapdt', title: '调板进度' },
            { field: 'dyysel', title: '入选情况' },
            { field: 'dystat', title: '样衣状态' },
            { field: 'dydept', title: '样衣组别' },
            { field: 'dyfadt', title: '面辅料到货时间' },
            //{ field: 'dyaadt', title: '辅料到货时间' },
            { field: 'dypddt', title: '预计发大货时间' },
            { field: 'dyaddt', title: '实际发大货时间' },
            { field: 'dyprdt', title: '计划收回时间' },
            { field: 'dyardt', title: '实际收回时间' },
            { field: 'dycydt', title: '确认样发放时间' },
            { field: 'dyremk2', title: '备注' }
        ]]
    });
}

//EP编辑界面
function showEditWinForEP(index, row) {
    $('#editEPForm').form('clear');
    if (row.dyyyno == '' || row.dyyyno == undefined) {
        $.messager.alert("提示", "获取大货款式失败", "warning");
        return;
    }
    $('#editEPWin').window({
        title: '样衣编辑',
        iconCls: 'icon-edit'
    }).window('open');
    $('#editEPForm #txtdyysel').combobox({
        data: [{ "id": "入选2", "text": "入选2" }, { "id": "入选3", "text": "入选3" }, { "id": "入选4", "text": "入选4" }, { "id": "入选5", "text": "入选5" }],
        panelHeight: 120,
        valueField: "id",
        textField: "text"
    });

    $('#editEPForm #txtdydept').combobox({
        data: [{ "id": "大货技术部", "text": "大货技术部" }, { "id": "样衣组", "text": "样衣组" }, { "id": "外发", "text": "外发" }],
        panelHeight: 120,
        valueField: "id",
        textField: "text"
    });

    //初始化样衣状态
    $('#editEPForm #txtdystat').combobox({
        data: m_states.rows,
        panelHeight: 200,
        valueField: 'cbtx40',
        textField: 'cbtx40'
    });

    var txtdyyyno = row.dyyyno.substring((row.dyyyno.indexOf('-') - 7), 7);
    //初始化大货款号
    $('#editEPForm #txtfstyleaddcolor1').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "fstyleaddcolor", "fstyleaddcolor") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtFStyleAddColor", "value": txtdyyyno }], 'GetFStyleAddColor'),
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        async: true
    });

    $('#editEPForm #txtfshangdate').datebox('setValue', row.fshangdate);
    $('#editEPForm #txtfaccbrand').val(row.faccbrand);
    $('#editEPForm #txtfseries').val(row.fseries);
    $('#editEPForm #txtfstyleaddcolor1').combobox('setValue', row.dyfsac);
    $('#editEPForm #txtdyyyno').val(row.dyyyno);
    $('#editEPForm #txtdyapdt').datebox('setValue', row.dyapdt);
    $('#editEPForm #txtdyysel').combobox('setValue', row.dyysel); //入选情况
    $('#editEPForm #txtdystat').combobox('setValue', row.dystat); //样衣状态
    $('#editEPForm #txtdydept').combobox('setValue', row.dydept); //样衣组别
    $('#editEPForm #txtdyfadt').datebox('setValue', row.dyfadt);  //面辅料到货时间
    //$('#editEPForm #txtdyaadt').datebox('setValue', row.dyaadt);
    $('#editEPForm #txtdypddt').datebox('setValue', row.dypddt);
    $('#editEPForm #txtdyaddt').datebox('setValue', row.dyaddt);
    $('#editEPForm #txtdyprdt').datebox('setValue', row.dyprdt);
    $('#editEPForm #txtdyardt').datebox('setValue', row.dyardt);
    $('#editEPForm #txtdycydt').datebox('setValue', row.dycydt);
    $('#editEPForm #txtdyremk2').val(row.dyremk2);
}

//保存事件
function saveDataForEP() {
    var txtdyyyno = $('#editEPForm #txtdyyyno').val();
    if (txtdyyyno == '' || txtdyyyno == undefined) {
        $.messager.alert("提示", "样衣号不能为空", "warning");
        return;
    }
    var txtdyapdt = $('#editEPForm #txtdyapdt').datebox('getText');
    var txtdyysel = $('#editEPForm #txtdyysel').combobox('getText');
    var txtdydept = $('#editEPForm #txtdydept').combobox('getText');
    var txtdystat = $('#editEPForm #txtdystat').combobox('getText');
    var txtdyfadt = $('#editEPForm #txtdyfadt').datebox('getText');
    // var txtdyaadt = $('#editEPForm #txtdyaadt').datebox('getText');
    var txtdypddt = $('#editEPForm #txtdypddt').datebox('getText');
    var txtdyaddt = $('#editEPForm #txtdyaddt').datebox('getText');
    var txtdyprdt = $('#editEPForm #txtdyprdt').datebox('getText');
    var txtdyardt = $('#editEPForm #txtdyardt').datebox('getText');
    var txtdycydt = $('#editEPForm #txtdycydt').datebox('getText');
    var txtdyremk2 = $('#editEPForm #txtdyremk2').val();
    var txtfstyleaddcolor = $('#editEPForm #txtfstyleaddcolor1').combobox('getValue');

    var data = [];
    data[data.length] = { "name": "txtMethod", "value": "UpdateSampleData" };
    data[data.length] = { "name": "txt样衣号", "value": txtdyyyno };
    data[data.length] = { "name": "txt大货款号", "value": txtfstyleaddcolor };
    data[data.length] = { "name": "txt调板进度", "value": txtdyapdt };
    data[data.length] = { "name": "txt样衣状态", "value": txtdystat };
    data[data.length] = { "name": "txt样衣组别", "value": txtdydept };
    //data[data.length] = { "name": "txt面料情况", "value": txtdyfadt };
    data[data.length] = { "name": "txt入选情况", "value": txtdyysel };
    data[data.length] = { "name": "txt辅料情况", "value": txtdyfadt };
    data[data.length] = { "name": "txt预计发大货时间", "value": txtdypddt };
    data[data.length] = { "name": "txt实际发大货时间", "value": txtdyaddt };
    data[data.length] = { "name": "txt计划收回时间", "value": txtdyprdt };
    data[data.length] = { "name": "txt实际收回时间", "value": txtdyardt };
    data[data.length] = { "name": "txt确认样发放时间", "value": txtdycydt };
    data[data.length] = { "name": "txt备注", "value": txtdyremk2 };

    $.ajax({
        url: GetWSRRURL('9e30352a-4456-4287-9034-86a09926d8d5'),
        type: 'post',
        data: GetDBFrameAMLPost(data),
        async: false, //异步,
        success: function (result) {
            try {
                var result = eval("[" + result + "]");
                if (result[0].Error) {
                    $.messager.alert("提示", "修改错误了！", 'error');
                }
                else if (result[0].rows[0].msg.toUpperCase() == "False".toUpperCase()) {
                    $.messager.alert("提示", "修改错误了！", 'error');
                }
                else {
                    $('#editEPWin').window('close');
                    $('#tabDetailForEP').datagrid("reload");
                    $.messager.alert("提示", "成功!");
                }
            }
            catch (ex) {
                $.messager.alert("提示", "错误:" + ex, "warning");
            }
        },
        error: function (er) {
            $.messager.alert("警告", "失败!");
        }
    });

}

//取消事件
function btnCancelForEP() {
    $('#editEPForm').form('clear');
    $('#editEPWin').window('close');
}

//导出
function excelExport() {

    var listData = $('#tabList').datagrid('getRows')

    if (listData.length <= 1 || listData == undefined) {
        alert("请先加载数据");
        return;
    }

    EasyUI_DataGrid_ExcelExport1($('#tabList'), $('#tabList'));
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


    var strUrl = m_url;

    //var strUrl = dataOptions.url;
    var dataColumns = dataOptions.columns;
    var dataColumnsFrozen = dataOptions.frozenColumns;
    var dataParam = dataOptions.queryParams;
    var pageSize = dataOptions.pageSize;
    var pageNumber = dataOptions.pageNumber;
    //var title = dataOptions.title;
    var title = "多件样衣跟踪表";

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