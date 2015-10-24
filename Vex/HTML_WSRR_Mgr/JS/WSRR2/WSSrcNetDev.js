var lastTabs;
var selected_Row;
var selected_Param_Row;

var mRouteName = "";

var m_RouteCode = 'NetDev'
//初始化
$(function () {

    var htmlobj = $.ajax({
        url: GetWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd') + "&where=RouteCode='" + m_RouteCode + "'",
        data: "XML=" + GetGetJson([]), async: false
    });
    var Text = jQuery.parseJSON(htmlobj.responseText);
    mRouteName = (Text.rows[0].name);


    InitGird();

    //WS的Param分类
    $('#txtParamType').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    //WS的Param分类
    $('#txtParamType').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Type"),
        required: true,
        panelHeight: 'auto',
        editable: false
    });

    $('#txtParamMustFlag').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Param_Must_Flag"),
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWSType').combobox({
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Type',
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Type"),

        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWSState').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_State"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_State',
        required: true,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false
    });

    $('#txtWSUnicode').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_Unicode"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_Unicode',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#txtNeedLogin').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "WS_NeedLogin"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#txtIsVex').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "VexService"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });

    $('#txtIsDemo').combobox({
        url: GetComboxWSRRURL('b7a9b801-a6bf-4d0c-97e3-7b5ed74f54df', "IsDemo"),
        //    url: '../Common/Combox.aspx?ComboxType=WSRR_WS_NeedLogin',
        required: true,
        valueField: 'id',
        panelHeight: 'auto',
        textField: 'text',
        editable: false
    });
});


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
            onClickRow: function () { DBlClickRowGrid(); },


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
                id: 'btn_Copy',
                text: '复制',
                iconCls: 'icon-pagecopy',
                handler: function () {
                    Edit_OnClick(true);
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
            //,
            //{
            //    id: 'btn_deployToProd',
            //    text: '同步正测式库',
            //    iconCls: 'icon-redo',
            //    handler: function () {
            //        DeployToProd_OnClick(true);
            //    }
            //}
            ]
        }
        );

}

function DBlClickRowGrid() {
    var selected = $('#tab_list').datagrid('getSelected');

    if (selected) {
        selected_Row = selected;
        InitTab();
    }
}


function InitTab() {

    if (selected_Row) {

        try {

            var row = $('#divParamInfo').datagrid('getSelected');
            var rowIndex = $('#divParamInfo').datagrid('getRowIndex', row);
            $('#divParamInfo').datagrid('unselectRow', rowIndex);

        }
        catch (e) {
        }

        InitParamInfo();
    }
}


//初始化参数信息
function InitParamInfo() {


    $('#divParamInfo').datagrid(
            {
                title: selected_Row.ws_name, //表格标题
                url: GetWSRRURL('4fadf424-336c-4904-ab31-f9f55dc4e034') + "&WSRRRouteCode=" + m_RouteCode,
                queryParams: { "XML": GetGetJson([{ "WSSrcID": selected_Row.wssrcid }]) },
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

                onDblClickRow: function () { AddParam_OnClick(true); },
                //onClickRow: function () { ClickParamRowGrid(); },
                toolbar: [
                {
                    id: 'btn_AddParam',
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddParam_OnClick();
                    }
                },
                {
                    id: 'btn_EditParam',
                    text: '编辑',
                    iconCls: 'icon-edit',
                    handler: function () {
                        AddParam_OnClick(true);
                    }
                },
                {
                    id: 'btn_DeleteParam',
                    text: '删除',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        DeleteParam_OnClick();
                    }
                },
                {
                    id: 'btn_AddParamPage',
                    text: '添加分页信息',
                    iconCls: 'icon-add',
                    handler: function () {
                        AddParamPage_OnClick();
                    }
                }]

            }
            );

}

function GetParamPageXML() {
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

function AddParam_OnClick(isEdit) {
    selected_Param_Row = $('#divParamInfo').datagrid('getSelected');


    if (isEdit && !selected_Param_Row) {
        $.messager.alert("系统错误", "请选择要编辑的行！", 'error');
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

        var data = $("#divParamInfo").datagrid("getData");
        var nValueTemp = 1;
        if (data.rows.length > 0) {
            nValueTemp = parseInt(data.rows[data.rows.length - 1].paramindex) + 1
        }
        $('#form_ParamEdit #txtParamIndex').numberbox('setValue', nValueTemp);

    }
    $('#form_ParamEdit').form('validate');
    $('#form_ParamEdit #txtParamIndex').focus();
}


function Edit_OnClick(IsCopy) {
    if (!selected_Row) {
        $.messager.alert("提示", "请先选择需要被编辑的行", 'error');
        return;
    }

    if (IsCopy) {
        $('#divEditWSRR').window({
            title: "复制",
            width: 700,
            height: 530,
            top: 20,

            modal: true
        });

        $('#form_Edit #txtWSSrcID').val("");
        $('#form_Edit #txtWSID').val("");
        $('#form_Edit #txtWSIDShow').val("系统自动生成");
        $('#form_Edit #txtWSSrcIDCopy').val(selected_Row.wssrcid);

        $('#form_Edit #txtServicePath').attr('disabled', '');
        $('#form_Edit #txtWSName').attr('disabled', '');
    }
    else {
        $('#divEditWSRR').window({
            title: "编辑",
            width: 640,
            top: 20,
            height: 530,
            modal: true
        });
        $('#form_Edit #txtWSSrcID').val(selected_Row.wssrcid);
        $('#form_Edit #txtWSID').val(selected_Row.wsid);
        $('#form_Edit #txtWSIDShow').val(selected_Row.wsid);


        $('#form_Edit #txtServicePath').attr('disabled', 'disabled');
        $('#form_Edit #txtWSName').attr('disabled', 'disabled');
    }


    var reg = new RegExp("ㄧ", "g");
    var strcallsample = selected_Row.callsample.replace(reg, "\n");
    $('#form_Edit #txtCallSample').val(unescape(strcallsample));

    $('#form_Edit #txtServicePath').val(selected_Row.servicepath);
    $('#form_Edit #txtWSName').val(selected_Row.wsname);

    $('#form_Edit #txtWSType').combobox('setValue', selected_Row.wstype);
    $('#form_Edit #txtWSHelp').val(selected_Row.wshelp);
    $('#form_Edit #txtWSHost').val(selected_Row.wshost);
    //$('#form_Edit #txtWSHostTest').val(selected_Row.wshosttest);
    $('#form_Edit #txtWSURL').val(selected_Row.wsurl);
    $('#form_Edit #txtWSState').combobox('setValue', selected_Row.wsstate);
    $('#form_Edit #txtWSVision').val(selected_Row.wsvision);
    $('#form_Edit #txtWSMethod').val(selected_Row.wsmethod);
    $('#form_Edit #txtWSVision').val(selected_Row.wsvision);
    $('#form_Edit #txtWSUnicode').combobox('setValue', selected_Row.wsunicode);
    $('#form_Edit #txtNeedLogin').combobox('setValue', selected_Row.needloginint);
    $('#form_Edit #txtIsVex').combobox('setValue', selected_Row.isvex);
    $('#form_Edit #txtIsDemo').combobox('setValue', selected_Row.isdemo);

    $('#form_Edit #txtUpdateTime').val(selected_Row.updatetime);

    $('#form_Edit #chkStartService').attr("checked", 'true');;
    $('#form_Edit').form('validate');
    $('#form_Edit #txtWSName').focus();

}

function Edit_Submit() {
    $('#form_Edit').form('submit', {
        //url: '?action=WSSubmit',
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                return false;
            }

            var temp = $('#form_Edit #txtServicePath').attr('disabled');

            $('#form_Edit #txtServicePath').attr('disabled', '');
            $('#form_Edit #txtWSName').attr('disabled', '');

            var data = $('#form_Edit').serializeArray();

            $('#form_Edit #txtServicePath').attr('disabled', temp);
            $('#form_Edit #txtWSName').attr('disabled', temp);

            var XMLData = GetFormJson(data, 'EDIT');
            //alert(XMLData);
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

    $('#form_ParamEdit').form('submit', {
        onSubmit: function () {
            var data = $('#form_ParamEdit').serializeArray();
            data[data.length] = { "name": "txtWSSrcID", "value": selected_Row.wssrcid }
            var XMLData = GetFormJson(data, 'EDIT');

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
    });
}

function DeleteParam_OnClick() {
    var selected = $('#divParamInfo').datagrid('getSelected');
    if (!selected) {
        $.messager.alert("提示", "请选择一行", 'error');

        return;
    }
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
                            $('#divParamInfo').datagrid("unselectAll");
                            $('#divParamInfo').datagrid("reload");
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

function Delete_OnClick() {
    if (!selected_Row) {
        $.messager.alert("提示", "请选择一行", 'error');

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
