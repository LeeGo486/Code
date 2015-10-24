var lastTabs;
var selected_Param_Row;
var mRouteName = "";
var m_ImportRouteCode = "";
var m_ImportStep = 0;
var m_ImportWSListRow = "";
var m_ImportTabInit = new Array(4);

var m_RouteCode = 'prod'
var m_ImportForm = false;
var m_ImportFormUpdate = false;
var m_ImportFormUpdateIndex = 0;

var m_ImportVexWS = false;
//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd') + "&where=RouteCode='" + m_RouteCode + "'",
        data: "XML=" + GetGetJson([]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    mRouteName = (Text.rows[0].name);
    InitGird();
    InitCommobox();

});

function InitCommobox() {

    //WS的Param分类
    $('#form_ParamEdit #txtParamType').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#form_ParamEdit #txtParamMustFlag').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Must_Flag"),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEdit #txtWSType').combobox({
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Type',
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Type"),

        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEdit #txtWSState').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_State"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_State',
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEdit #txtWSUnicode').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Unicode"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Unicode',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#formEdit #txtNeedLogin').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_NeedLogin"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });
}


function InitCommoboxImport() {
    $('#cmbRouteDev').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routecode", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXTEST'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false,
        onLoadSuccess: function () { //加载完成后,设置选中第一项
            var val = $(this).combobox("getData");
            for (var item in val[0]) {
                if (item == "id") {
                    $(this).combobox("select", val[0][item]);
                }
            }
        }
    });
    $('#formEditImport #cmbRouteDev').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routecode", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXTEST'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false,
        onLoadSuccess: function () { //加载完成后,设置选中第一项
            var val = $(this).combobox("getData");
            for (var item in val[0]) {
                if (item == "id") {
                    $(this).combobox("select", val[0][item]);
                }
            }
        }
    });


    //WS的Param分类
    $('#formEditImport #txtParamType').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#formEditImport #txtParamMustFlag').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Must_Flag"),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEditImport #txtWSType').combobox({
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Type',
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Type"),

        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEditImport #txtWSState').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_State"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_State',
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#formEditImport #txtWSUnicode').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Unicode"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Unicode',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#formEditImport #txtNeedLogin').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_NeedLogin"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });
}

//初始化表格
function InitGird() {

    $('#tab_list').datagrid(
    {
        //title: 'WS资源列表--' + mRouteName, //表格标题
        
        url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e') + "&WSRRRouteCode=" + m_RouteCode,
        queryParams: { "XML": GetGetJson([{}]) },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        frozenColumns: [[//冻结的列，不会随横向滚动轴移动
            { field: 'wsid', title: 'WSID', width: 150, search: true, sortable: true }

        ]],
        columns: [[
            
            { field: 'servicepath', title: '服务路径', width: 150, search: true, sortable: true },
            { field: 'wsname', title: 'WS名', width: 180, search: true, sortable: true },
            { field: 'wstype', title: '类型', width: 80, search: true, sortable: true },
            { field: 'wshelp', title: '说明', width: 160, search: true, sortable: true },
            { field: 'wsstate', title: '状态', width: 50, search: true, sortable: true },
            { field: 'wshost', title: 'WS服务器地址', width: 150, sortable: true },
            { field: 'wsurl', title: '访问路径', width: 100, sortable: true },
            { field: 'wsvision', title: '版本', width: 40, sortable: true },
            { field: 'wsmethod', title: '调用的方法', width: 100, sortable: true },
            { field: 'wsunicode', title: '编码方式', width: 60, sortable: true },
            { field: 'needlogin', title: '必须登录', width: 60, sortable: true },
            { field: 'needloginint', title: '必须登录', width: 60, hidden: true, sortable: true }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true, //行号

        onDblClickRow: function () { Edit_OnClick(false); },
        onClickRow: function () { ClickRowGrid(); },

        toolbar: [
        {
            id: 'btn_Add',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                Edit_OnClick(false);
            }
        },
        {
            id: 'btn_Delete',
            text: '删除',
            iconCls: 'icon-cancel',
            handler: function () {
                Delete_OnClick();
            }
        }
        ,
        {
            id: 'btn_Import',
            text: '引入',
            iconCls: 'icon-redo',
            handler: function () {
                m_ImportVexWS = false;
                Import_OnClick();
            }
        },
        {
            id: 'btn_ImportVex',
            text: '引入Vex接口',
            iconCls: 'icon-redo',
            handler: function () {
                m_ImportVexWS = true;

                Import_OnClick();
            }
        }
        ]
    }
    );

}

function ClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    InitParamInfo("#divParamInfo", selected);

}

//初始化参数信息
function InitParamInfo(tableID, selectRow) {

    var strRouteCode = m_RouteCode;
    if (tableID != "#divParamInfo") {
        strRouteCode = m_ImportRouteCode;
    }

    $(tableID).datagrid(
    {
        title: selectRow.ws_name, //表格标题
        url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034') + "&WSRRRouteCode=" + strRouteCode,
        queryParams: { "XML": GetGetJson([{ "WSSrcID": selectRow.wssrcid }]) },
        iconCls: '', //标题左边的图标
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
            { field: 'paramid', title: '编号', width: 30, hidden: true },
            { field: 'paramindex', title: '序号', width: 30 },
            { field: 'paramcontent', title: '说明', width: 80 },
            { field: 'paramname', title: '参数名', width: 80 },
            { field: 'paramtype', title: '参数类型', width: 50 },
            { field: 'parammustflag', title: '必须', width: 80 },
            { field: 'parammustflagint', title: '必须', width: 80, hidden: true },
            {
                field: 'defaultvalue', title: '默认值', width: 250, title: true
                , formatter: function (value, row, index) {
                    var content = '<div title="' + value + '">' + value + '</div>';
                    return content;
                }
            }
        ]],
        onClickRow: function (rowIndex, rowData) {
            m_ImportFormUpdateIndex = rowIndex;
        },
        onDblClickRow: function (rowIndex, rowData) {
            m_ImportFormUpdateIndex = rowIndex;
            AddParam_OnClick(true, tableID);
        },
        toolbar: [
        {
            id: 'btn_AddParam',
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                AddParam_OnClick(false, tableID);
            }
        },
        {
            id: 'btn_EditParam',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                AddParam_OnClick(true, tableID);
            }
        },
        {
            id: 'btn_DeleteParam',
            text: '删除',
            iconCls: 'icon-cancel',
            handler: function () {
                DeleteParam_OnClick(tableID);
            }
        },
        {
            id: 'btn_AddParamPage',
            text: '添加分页信息',
            hidden: true,
            iconCls: 'icon-add',
            handler: function () {
                AddParamPage_OnClick();
            }
        }]

    }
    );

    if (tableID == "#divParamInfo") {
        $("#btn_AddParamPage").show();
    }

}

function GetParamPageXML() {

    var selected_Row = $("#tab_list").datagrid("getSelected");
    var wssrcid = selected_Row.wssrcid;
    var maxRowIndex = 0;

    var data_Param = $("#divParamInfo").datagrid("getData");
    if (data_Param.rows.length > 0) {
        maxRowIndex = parseInt(data_Param.rows[data_Param.rows.length - 1].paramindex);
    }


    var xml = "<Root><OPTYPE>EDIT</OPTYPE><List>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 1) + "</ParamIndex><ParamContent>page</ParamContent><ParamName>page</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue>1</DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 2) + "</ParamIndex><ParamContent>pagerows</ParamContent><ParamName>pagerows</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue>20</DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 3) + "</ParamIndex><ParamContent>order</ParamContent><ParamName>order</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue></DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 4) + "</ParamIndex><ParamContent>sort</ParamContent><ParamName>sort</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue></DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 5) + "</ParamIndex><ParamContent>where</ParamContent><ParamName>where</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue></DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "<Rows><ParamID></ParamID><ParamIndex>" + (maxRowIndex + 6) + "</ParamIndex><ParamContent>searchFilter</ParamContent><ParamName>searchFilter</ParamName><ParamType>string</ParamType><ParamMustFlag>2</ParamMustFlag><DefaultValue></DefaultValue><WSSrcID>" + wssrcid + "</WSSrcID></Rows>"
        + "</List></Root>";
    return xml;
}

function AddParamPage_OnClick() {

    var XMLData = GetParamPageXML();

    $.ajax({
        url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034') + "&WSRRRouteCode=" + m_RouteCode,
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
                    $('#divParamInfo').datagrid("unselectAll");
                    $('#divParamInfo').datagrid("reload");
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

function AddParam_OnClick(isEdit, tableID) {
    m_ImportFormUpdate = isEdit;
    if (tableID != "#divParamInfo") {
        m_ImportForm = true;
    }
    else {
        m_ImportForm = false;
    }

    selected_Param_Row = $(tableID).datagrid('getSelected');

    if (isEdit && !selected_Param_Row) {
        alert("请选择要编辑的行！");
        return;
    }
    if (isEdit) {

        $('#divEditWSParam').window({
            title: "编辑",
            width: 500,
            height: 530,
            top: 20,
            modal: true
        });

        $('#form_ParamEdit #txtParamIDShow').val(selected_Param_Row.paramid);

        $('#form_ParamEdit #txtParamIndex').numberbox("setValue", selected_Param_Row.paramindex);

        $('#form_ParamEdit #txtParamID').val(selected_Param_Row.paramid);
        $('#form_ParamEdit #txtParamContent').val(selected_Param_Row.paramcontent);
        $('#form_ParamEdit #txtParamName').val(selected_Param_Row.paramname);
        $('#form_ParamEdit #txtParamType').combobox('setValue', selected_Param_Row.paramtype);
        $('#form_ParamEdit #txtParamMustFlag').combobox('setValue', selected_Param_Row.parammustflagint);
        $('#form_ParamEdit #txtDefaultValue').val(selected_Param_Row.defaultvalue);
        $('#form_ParamEdit #txtUpdateTime').val(selected_Param_Row.updatetime);

    }
    else {
        $('#divEditWSParam').window({
            title: "添加",
            width: 500,
            top: 20,
            height: 530,
            modal: true
        });

        $('#form_ParamEdit #txtParamIDShow').val('系统自动生成');
        $('#form_ParamEdit #txtParamID').val('');

        $('#form_ParamEdit #txtParamContent').val('');
        $('#form_ParamEdit #txtParamName').val('');
        $('#form_ParamEdit #txtParamType').combobox('setValue', 'string');
        $('#form_ParamEdit #txtParamMustFlag').combobox('setValue', '0');
        $('#form_ParamEdit #txtDefaultValue').val('');

        var data = $(tableID).datagrid("getData");
        var nValueTemp = 1;
        if (data.rows.length > 0) {
            nValueTemp = parseInt(data.rows[data.rows.length - 1].paramindex) + 1
        }
        $('#form_ParamEdit #txtParamIndex').numberbox('setValue', nValueTemp);

    }
    $('#form_ParamEdit').form('validate');
    $('#form_ParamEdit #txtParamIndex').focus();
}

function InportWSEdit() {

    var selected_Row;
    selected_Row = m_ImportWSListRow;

    $('#formEditImport #txtWSSrcID').val("");
    $('#formEditImport #txtWSID').val("");
    $('#formEditImport #txtWSIDShow').val("系统自动生成");

    $('#formEditImport #txtServicePath').attr('disabled', 'disabled');
    $('#formEditImport #txtWSName').attr('disabled', 'disabled');


    $('#formEditImport #txtServicePath').val(selected_Row.servicepath);
    $('#formEditImport #txtWSName').val(selected_Row.wsname);

    $('#formEditImport #txtWSType').combobox('setValue', selected_Row.wstype);
    $('#formEditImport #txtWSHelp').val(selected_Row.wshelp);
    $('#formEditImport #txtWSHost').val(selected_Row.wshost);
    $('#formEditImport #txtWSURL').val(selected_Row.wsurl);
    $('#formEditImport #txtWSState').combobox('setValue', selected_Row.wsstate);
    $('#formEditImport #txtWSVision').val(selected_Row.wsvision);
    $('#formEditImport #txtWSMethod').val(selected_Row.wsmethod);
    $('#formEditImport #txtWSVision').val(selected_Row.wsvision);
    $('#formEditImport #txtWSUnicode').combobox('setValue', selected_Row.wsunicode);
    $('#formEditImport #txtNeedLogin').combobox('setValue', selected_Row.needloginint);
    $('#formEditImport #txtUpdateTime').val(selected_Row.updatetime);
    $('#formEditImport #chkStartService').attr("checked", 'true');;

    $('#formEditImport').form('validate');
    $('#formEditImport #txtWSName').focus();

}

function Edit_OnClick() {
    var selected_Row;

    selected_Row = $('#tab_list').datagrid('getSelected');

    if (selected_Row == undefined) {
        $.messager.alert("提示", "请选择需要编辑的行！", 'error');
        return;
    }

    $('#divEditWSRR').window({
        title: "编辑",
        width: 630,
        top: 20,
        height: 530,
        modal: true
    });

    var reg = new RegExp("ㄧ", "g");
    var strcallsample = selected_Row.callsample.replace(reg, "\n");

    $('#formEdit #txtCallSample').val(unescape(strcallsample));

    $('#divEditWSRR').window("open");
    $('#formEdit #txtWSSrcID').val(selected_Row.wssrcid);
    $('#formEdit #txtWSID').val(selected_Row.wsid);
    $('#formEdit #txtWSIDShow').val(selected_Row.wsid);
    $('#formEdit #txtServicePath').attr('disabled', 'disabled');
    $('#formEdit #txtWSName').attr('disabled', 'disabled');
    $('#formEdit #txtServicePath').val(selected_Row.servicepath);

    $('#formEdit #txtWSName').val(selected_Row.wsname);

    $('#formEdit #txtWSType').combobox('setValue', selected_Row.wstype);
    $('#formEdit #txtWSHelp').val(selected_Row.wshelp);
    $('#formEdit #txtWSHost').val(selected_Row.wshost);
    $('#formEdit #txtWSURL').val(selected_Row.wsurl);
    $('#formEdit #txtWSState').combobox('setValue', selected_Row.wsstate);
    $('#formEdit #txtWSVision').val(selected_Row.wsvision);
    $('#formEdit #txtWSMethod').val(selected_Row.wsmethod);
    $('#formEdit #txtWSVision').val(selected_Row.wsvision);
    $('#formEdit #txtWSUnicode').combobox('setValue', selected_Row.wsunicode);
    $('#formEdit #txtNeedLogin').combobox('setValue', selected_Row.needloginint);
    $('#formEdit #txtUpdateTime').val(selected_Row.updatetime);
      
    $('#formEdit #chkStartService').attr("checked", 'true');;
    $('#formEdit').form('validate');
    $('#formEdit #txtWSName').focus();

}

function InitImportTab() {
    if (m_ImportVexWS) {

        $('#tabImortRoute').tabs('getTab', 2).panel('options').tab.hide();
        $('#tabImortRoute').tabs('getTab', 3).panel('options').tab.hide();
        $('#tabImortRoute').tabs('getTab', 4).panel('options').tab.show();
    }
    else {
        $('#tabImortRoute').tabs('getTab', 2).panel('options').tab.show();
        $('#tabImortRoute').tabs('getTab', 3).panel('options').tab.show();
        $('#tabImortRoute').tabs('getTab', 4).panel('options').tab.hide();
    }
}

function Import_OnClick() {
    InitCommoboxImport();

    InitImportTab();

    m_ImportStep = -1;
    $('#divRouteImport').window({
        top: 20,
        modal: true,
        height: $(window).height() - 50,
        width: $(window).width() - 300
    });

    m_ImportTabInit[0] = "";
    m_ImportTabInit[1] = "";
    m_ImportTabInit[2] = "";
    m_ImportTabInit[3] = "";

    ImportStepNext();
}

function InitWSSrc() {

    var strGetType = "GETIMPORT";
    if (m_ImportVexWS == true) {
        strGetType = "GETIMPORTVEX";
    }

    $('#tabImportWSList').datagrid(
    {
        title: '选择待引用的资源', //表格标题

        url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e') + "&WSRRRouteCode=" + m_ImportRouteCode,
        queryParams: { "XML": GetGetJson([{}], strGetType) },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: !m_ImportVexWS,
        selectOnCheck: true,
        checkOnSelect: true,
        frozenColumns: [[//冻结的列，不会随横向滚动轴移动
            { field: 'ck', title: '', checkbox: true },
            { field: 'wsid', title: 'WSID', width: 150, search: true, sortable: true },
            { field: 'servicepath', title: '服务路径', width: 150, search: true, sortable: true },
            { field: 'wsname', title: 'WS名', width: 180, search: true, sortable: true }

        ]],
        columns: [[
            { field: 'wstype', title: '类型', width: 80, search: true, sortable: true },
            { field: 'wshelp', title: '说明', width: 160, search: true, sortable: true },
            { field: 'wsstate', title: '状态', width: 50, search: true, sortable: true },
            { field: 'wshost', title: 'WS服务器地址', width: 150, sortable: true },
            { field: 'wsurl', title: '访问路径', width: 100, sortable: true },
            { field: 'wsvision', title: '版本', width: 40, sortable: true },
            { field: 'wsmethod', title: '调用的方法', width: 100, sortable: true },
            { field: 'wsunicode', title: '编码方式', width: 60, sortable: true },
            { field: 'needlogin', title: '必须登录', width: 60, sortable: true },
            { field: 'needloginint', title: '必须登录', width: 60, hidden: true, sortable: true }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true

    }
    );

}

function SelectTab(pbInitData) {
    if (pbInitData) {
        if (m_ImportStep == 0) {
        }
        else if (m_ImportStep == 1 && m_ImportTabInit[m_ImportStep] != "1") {
            InitWSSrc();
            m_ImportTabInit[m_ImportStep] = "1";
        }
        else if (m_ImportStep == 2 && m_ImportTabInit[m_ImportStep] != "1") {
            InportWSEdit();
        }
        else if (m_ImportStep == 3 && m_ImportTabInit[m_ImportStep] != "1") {
            InitParamInfo("#tabImportParam", m_ImportWSListRow);
            m_ImportTabInit[m_ImportStep] = "1";
        }

    }

    if (m_ImportStep == 0) {
        $('#btnImportStepPrevious').linkbutton('disable');
    }
    else {
        $("#btnImportStepPrevious").linkbutton('enable');
    }

    if ((m_ImportStep == 3 && m_ImportVexWS == false) || (m_ImportStep == 4 && m_ImportVexWS == true)) {
        $("#btnImportStepNext").hide();

        $("#btnImportSubmit").show();
    }
    else {
        $("#btnImportStepNext").show();

        $("#btnImportSubmit").hide();
    }

    $('#tabImortRoute').tabs('select', m_ImportStep);

    for (var i = 0; i < 5 ; i++) {
        if (i == m_ImportStep) {
            $('#tabImortRoute').tabs('enableTab', i);
        }
        else {
            $('#tabImortRoute').tabs('disableTab', i);
        }
    }
}

function ImportStepPrevious() {

    if (m_ImportStep == 4 && m_ImportVexWS) {
        m_ImportStep = m_ImportStep - 3;
    }
    else {
        m_ImportStep = m_ImportStep - 1;
    }

    SelectTab(false)
}

function ImportStepNext() {

    if (m_ImportStep == 0) {
        var strRouteDev = $("#cmbRouteDev").combobox("getValue");
        if (strRouteDev != m_ImportRouteCode) {
            m_ImportTabInit[1] = "";
            m_ImportTabInit[2] = "";
            m_ImportTabInit[3] = "";
            m_ImportRouteCode = strRouteDev;
        }
    }
    else if (m_ImportStep == 1) {
        var dataRow = $('#tabImportWSList').datagrid('getSelected');

        if (!dataRow) {
            alert("请选择一行");
            return;
        }

        if (dataRow != m_ImportWSListRow) {
            m_ImportTabInit[2] = "";
            m_ImportTabInit[3] = "";
            m_ImportWSListRow = dataRow;
        }
    }
    else if (m_ImportStep == 2) {
        if ($('#formEditImport').form('validate') == false) {
            return false;
        }
    }

    if (m_ImportStep == 1 && m_ImportVexWS) {
        m_ImportStep = m_ImportStep + 3;
    }
    else {
        m_ImportStep = m_ImportStep + 1;
    }
    SelectTab(true)
}


function ImportSubmit() {

    var strXMLData = "";

    if (m_ImportVexWS) {
        var strWSListData = $('#tabImportWSList').datagrid('getSelections');
        var strWSList = "";
        for (var i = 0; i < strWSListData.length; i++) {
            strWSList += strWSListData[i].wssrcid + ",";
        }
        
        var data = $('#formEditVexServer').serializeArray();

        data[data.length] = { "name": "txtWSSrcIDList", "value": strWSList };
        data[data.length] = { "name": "txtImportRouteCode", "value": m_ImportRouteCode };
        strXMLData = GetFormJson(data, 'ImportRouteVex');

    }
    else {
        var dataParam = $('#tabImportParam').datagrid('getData');
        var strXMLPrarm = GetEditJson(dataParam.rows);

        var temp = $('#formEditImport #txtServicePath').attr('disabled');

        $('#formEditImport #txtServicePath').attr('disabled', '');
        $('#formEditImport #txtWSName').attr('disabled', '');

        var data = $('#formEditImport').serializeArray();

        $('#formEditImport #txtServicePath').attr('disabled', temp);
        $('#formEditImport #txtWSName').attr('disabled', temp);

        data[data.length] = { "name": "txtParamDetail", "value": strXMLPrarm, "specialCharset": true };

        strXMLData = GetFormJson(data, 'ImportRoute');
    }

    $.ajax({
        url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e') + "&WSRRRouteCode=" + m_RouteCode,
        type: 'post',
        async: true, //异步,
        data: { "XML": strXMLData },
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

                    $('#divRouteImport').window('close');
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
}

function Edit_Submit() {
    $('#formEdit').form('submit', {
        //url: '?action=WSSubmit',
        onSubmit: function (e) {

            if ($('#formEdit').form('validate') == false) {
                return false;
            }

            var temp = $('#formEdit #txtServicePath').attr('disabled');

            $('#formEdit #txtServicePath').attr('disabled', '');
            $('#formEdit #txtWSName').attr('disabled', '');

            var data = $('#formEdit').serializeArray();

            $('#formEdit #txtServicePath').attr('disabled', temp);
            $('#formEdit #txtWSName').attr('disabled', temp);

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e') + "&WSRRRouteCode=" + m_RouteCode,
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

                            $('#divEditWSRR').window('close');
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

function Edit_ParamSubmit() {
    var XMLData = null;
    var data = null;

    if ($('#form_ParamEdit').form('validate') == false) {
        return false;
    }

    if (m_ImportForm == true) {
        data = $('#form_ParamEdit').serializeArray();

        //往DataGrid插入一行数据
        var oldData = $('#tabImportParam').datagrid('getData');

        var newRow = jQuery.extend(true, {}, oldData.rows[0]);

        for (var i = 0; i < data.length; i++) {
            var strTemp = data[i].name.toLowerCase().substr(3);
            strTemp = "newRow." + strTemp + "='" + data[i].value + "'";
            eval(strTemp);
        }
        if (m_ImportFormUpdate == false) {
            $('#tabImportParam').datagrid('insertRow', {
                index: oldData.length,
                row: newRow
            });

            //$('#tabImportParam').datagrid("reload")
        }
        else {
            $('#tabImportParam').datagrid('updateRow', {
                index: m_ImportFormUpdateIndex,
                row: newRow
            });
        }

        $('#divEditWSParam').window('close');

    }
    else {

        selected_Row = $("#tab_list").datagrid('getSelected');

        data = $('#form_ParamEdit').serializeArray();
        data[data.length] = { "name": "txtWSSrcID", "value": selected_Row.wssrcid }
        XMLData = GetFormJson(data, 'EDIT');

        $.ajax({
            url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034') + "&WSRRRouteCode=" + m_RouteCode,
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
                        //$.messager.progress('close');
                        $('#divEditWSParam').window('close');
                        $('#divParamInfo').datagrid("unselectAll");
                        $('#divParamInfo').datagrid("reload");
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
    }
}

function DeleteParam_OnClick(tableID) {
    var selected = $(tableID).datagrid('getSelected');
    if (!selected) {
        alert('请选择一行');
        return;
    }

    if (tableID == "#tabImportParam") {
        $('#tabImportParam').datagrid('deleteRow', m_ImportFormUpdateIndex);
    }
    else {
        $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
            if (r) {
                var data = eval("[]");
                data[data.length] = { "name": "txtParamID", "value": selected.paramid }
                data[data.length] = { "name": "txtUpdateTime", "value": selected.updatetime }
                var XMLData = GetFormJson(data, 'DELETE');

                $.ajax({
                    url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034') + "&WSRRRouteCode=" + m_RouteCode,
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
                                $(tableID).datagrid("unselectAll");
                                $(tableID).datagrid("reload");
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
    }
};

function Delete_OnClick() {
    var selected_Row = $("#tab_list").datagrid("getSelected");
    if (!selected_Row) {
        alert("请先选择一行");
        return;
    }
    $.messager.confirm('提示框', '你确定要删除吗?', function (r) {
        if (r) {
            var data = eval("[]");
            data[data.length] = { "name": "txtWSSrcID", "value": selected_Row.wssrcid }
            data[data.length] = { "name": "txtUpdateTime", "value": selected_Row.updatetime }
            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('d9636819-942d-43bb-a671-9957ff46043e') + "&WSRRRouteCode=" + m_RouteCode,
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
                            $('#tab_list').datagrid("unselectAll");
                            selected_Row = undefined
                            $('#tab_list').datagrid("reload");
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

$.extend($.fn.validatebox.defaults.rules, {
    WSPath: {
        validator: function (value, param) {
            if (value.length > param[0]) {
                return false;
            }

            var reg = new RegExp("(/\\S{1,}){4}");
            return reg.test(value)
        },
        message: '必须英文，比如/系统大类/模块/产品名称/公司名称，比如/ERP/PO/M3/EP;'
    }
});
