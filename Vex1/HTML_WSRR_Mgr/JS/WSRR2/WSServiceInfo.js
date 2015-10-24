var m_loginName = '';
var m_keyword = "";

var reg = new RegExp("ㄧ", "g");
var reg1 = new RegExp("<font color=#FF0000>", "g");
var reg2 = new RegExp("</font>", "g");

//初始化
$(function () {
    $.ajax({
        url: GetLoginNameURL(),
        options: "JSON",
        success: function (data) {

            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }

            m_loginName = eval("[" + data + "]")[0].UserName;
        }
    });


    InitGird();
});


function SearchClick() {
    m_keyword = $("#txtKeyWord").val();
    InitGird();
}

//初始化表格
function InitGird() {
    $('#tablist').datagrid(
        {
            //title: '服务管理',
            //  title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
            queryParams: { "XML": GetGetJson([{ "SearchText": m_keyword }]), "HeihgRightKeyWord": m_keyword },
            url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择

            columns: [[
                { field: 'wsspserver', title: 'SP部署', width: 160, search: true, sortable: true },
                { field: 'wsspname', title: 'SP名称', width: 180, search: true, sortable: true },
                //{ field: 'wsdeployserver', title: '服务部署', width: 130, search: true, sortable: true },
                { field: 'state', title: '状态', width: 50, search: true, sortable: true },
                { field: 'appliayuser', title: '申请人', width: 60, search: true, sortable: true },
                { field: 'applaytime', title: '申请时间', width: 125, search: true, sortable: true },

                { field: 'inputformat', title: '输入格式', width: 130, search: true, hidden: true },
                { field: 'returnformat', title: '返回格式', width: 130, search: true, hidden: true }
            ]],
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
                { field: 'ck', title: '', width: 20, checkbox: true },
	            { field: 'wsapplayid', title: '服务编号', width: 180, hidden: true },
	            {
	                field: 'servicepath', title: '服务路径', width: 190, search: true, sortable: true,
	                searchfield: 't1.ServicePath',
	                formatter: function (value, row, index) {
	                    var content = '<div title="' + row.wscontent + '">' + value + '</div>';
	                    return content;
	                }
	            },
                {
                    field: 'wsname', title: '服务名称', width: 100, search: true, sortable: true,
                    searchfield: 't1.wsname',
                    formatter: function (value, row, index) {
                        var content = '<div title="' + row.wscontent + '">' + value + '</div>';
                        return content;
                    }
                }
            ]],
            pagination: true, //是否开启分页
            pageNumber: 1, //默认索引页
            pageSize: 20, //默认一页数据条数
            rownumbers: true, //行号
            onClickRow: function (rowIndex, rowData) {
                RowClick(rowIndex, rowData);
            },
            onDblClickRow: function () { EditOnClick(false); },
            onLoadSuccess: function () {
                ClearGrid("#tabRouteInfo");
                ClearGrid("#tabFunction");
                HideAllButton();
            },
            rowStyler: function (index, row) {
                if (row.state != "已生效") {
                    return 'background-color:#FFCCFF';
                }
            },

            toolbar: [
            {
                id: 'btnAdd',
                text: '添加服务',
                iconCls: 'icon-add',
                handler: function () {
                    EditOnClick(true);
                }
            }, {
                id: 'btnDesign',
                hidden: true,
                text: '已设计',
                iconCls: 'icon-design',
                handler: function () {
                    UpdateState("已设计");
                }
            }, {
                id: 'btnDeploy',
                hidden: true,
                text: '下发',
                iconCls: 'icon-deploy',
                hidden: true,

                handler: function () {
                    SetDevRoute();

                }
            }
            , {
                id: 'btnTested',
                text: '已测试',
                hidden: true,
                iconCls: 'icon-online',
                handler: function () {
                    UpdateState("已测试");
                }
            }
            , {
                id: 'btnReSend',
                hidden: true,
                text: '重新提交',
                iconCls: 'icon-online',
                handler: function () {
                    UpdateState("重新提交");

                }
            }, {
                id: 'btnServiceStop',
                text: '禁用',
                hidden: true,
                iconCls: 'icon-stop',
                handler: function () {
                    UpdateState("已禁用");
                }
            }

            ]
        }
        );

}

function HideAllButton() {
    $("#btnDesign").hide();
    $("#btnTested").hide();
    $("#btnDeploy").hide();
    $("#btnServiceStop").hide();
    //$("#btnOnLine").hide();
    $("#btnReSend").hide();
}

function RowClick(rowIndex, prowData) {
    var strState = prowData.state.replace(reg1, "").replace(reg2, "");

    if (prowData.appliayuser != m_loginName) {
        HideAllButton();
    }
    else {

        if (strState != "已禁用") {
            $("#btnServiceStop").show();
        }
        else {
            $("#btnServiceStop").hide();
        }

        if (strState == "已提交" || strState == "重新提交") {
            $("#btnDesign").show();

            $("#btnTested").hide();
            $("#btnDeploy").hide();
            //$("#btnOnLine").hide();
            $("#btnReSend").hide();
        }
        else if (strState == "已设计") {
            $("#btnDesign").hide();
            $("#btnDeploy").show();
            //$("#btnOnLine").hide();
            $("#btnReSend").hide();
            $("#btnTested").hide();


        }
        else if (strState == "已下发") {
            $("#btnDesign").hide();
            $("#btnDeploy").hide();
            //$("#btnOnLine").hide();
            $("#btnReSend").hide();
            $("#btnTested").show();


        }
        else if (strState == "已测试" || strState == "已上线" || strState == "已禁用") {
            $("#btnDesign").hide();
            $("#btnDeploy").hide();
            //$("#btnOnLine").show();
            $("#btnReSend").show();
            $("#btnTested").hide();

        }
        //else if (rowData.state == "已上线") {
        //    $("#btnDesign").hide();
        //    $("#btnDeploy").hide();
        //    $("#btnOnLine").hide();
        //    $("#btnReSend").show();
        //    $("#btnTested").hide();

        //}
    }

    //加载右边的信息
    InitRoute(prowData);
    InitFunction(prowData);
}

function InitRoute(prowData) {

    $('#tabRouteInfo').datagrid(
    {
        //  title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
        queryParams: { "XML": GetGetJson([{ "WSID": prowData.wsid.replace(reg1, "").replace(reg2, "") }], "GetRouteInfo") },
        url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        onClickRow: function (rowIndex, rowData) { RouteRowClick(rowData) },

        columns: [[
            { field: 'routename', title: '路由名称', width: 160 },
            { field: 'routetype', title: '路由类型', width: 180 },
            { field: 'state', title: '状态', width: 50 }
        ]],
        toolbar: [
        {
            id: 'btnRouteOK',
            text: '启用',
            hidden: true,
            iconCls: 'icon-ok',
            handler: function () {
                EditRouteState(true);
            }
        },
        {
            id: 'btnRouteStop',
            text: '禁用',
            hidden: true,
            iconCls: 'icon-stop',
            handler: function () {
                EditRouteState(false);

            }
        }],
        pagination: false
    }
    );
}
function EditRouteState(pbStart) {
    var selectedRow = $('#tabRouteInfo').datagrid('getSelected');

    var data = [];
    data[data.length] = { "name": "txtLinkID", "value": selectedRow.linkid }
    data[data.length] = { "name": "txtUpdateTime", "value": selectedRow.updatetime }
    if (pbStart == true) {
        data[data.length] = { "name": "txtState", "value": "已启用" }
    }
    else {
        data[data.length] = { "name": "txtState", "value": "已禁用" }
    }

    var XMLData = GetFormJson(data, 'UpdateLinkState');
    //return;
    $.ajax({
        url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
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

                    $('#tabRouteInfo').datagrid("reload");
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
function RouteRowClick(prowData) {
    if (prowData.state == "已禁用") {
        $("#btnRouteOK").show();
        $("#btnRouteStop").hide();
    }
    else {
        $("#btnRouteOK").hide();
        $("#btnRouteStop").show();
    }
}

function InitFunction(prowData) {

    $('#tabFunction').datagrid(
    {
        title: prowData.wsname.replace(reg1, "").replace(reg2, ""), //表格标题
        url: GetWSRRURL('3832376e-eccd-4d04-997c-776a9333e941'),
        queryParams: { "XML": GetGetJson([{ "WSID": prowData.wsid.replace(reg1, "").replace(reg2, "") }]) },
        iconCls: '', //标题左边的图标
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
            { field: 'functionname', title: '方法名称', width: 200 },
            { field: 'functioncontent', title: '说明', width: 200 }
        ]],
        onDblClickRow: function () { EditFuncton(false); },
        toolbar: [
        {
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                EditFuncton(true);
            }
        },
        {
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                EditFuncton(false);
            }
        },
        {
            text: '删除',
            iconCls: 'icon-cancel',
            handler: function () {
                DeleteFunction();
            }
        }]

    }
    );
}

function EditFuncton(isAdd) {
    var selectedRow = $('#tabFunction').datagrid('getSelected');

    if (isAdd) {
        $('#divEditFunction').window({
            title: "方法添加",
            top: 20,
            modal: true,
            close:false
        });
        $('#divEditFunction').window("open");
        var form = $('#formEditFunction');
        form.find("#txtWSSeaviceFunctionID").val('');

        form.find("#txtFunctionName").val('');
        form.find('#txtFunctionContent').val('');

        form.find('#txtInputFormat').val('【参数1,示例值】\r\n【参数2,示例值】\r\n【子表名参数3,（单行）（多行）\r\n	行1【参数4，示例值】【参数5，示例值】\r\n	行2【参数4，示例值】【参数5，示例值】\r\n】');
        form.find('#txtReturnFormat').val('（单行） （多行）\r\n行1【参数1，示例值】【参数2，示例值】\r\n行2【参数1，示例值】【参数2，示例值】');

        form.find('#txtLogicContent').val('');

        $('#formEditFunction').form('validate');
        $('#tabFunction').find('#txtFunctionName').focus();
    }
    else {

        if (selectedRow == null) {
            $.messager.alert("提示", "必须选择一行。", 'error');
            return;
        }
        $('#divEditFunction').window({
            top: 20,
            title: "方法编辑",
            modal: true,
            close: false
        });
        $('#divEditFunction').window("open");

        var reg = new RegExp("ㄧ", "g");
        var strinputformat = selectedRow.inputformat.replace(reg, "\n");
        var strreturnformat = selectedRow.returnformat.replace(reg, "\n");
        var strlogiccontent = selectedRow.logiccontent.replace(reg, "\n");
        var strfunctioncontent = selectedRow.functioncontent.replace(reg, "\n");

        $('#formEditFunction').find("#txtUpdateTime").val(selectedRow.updatetime);
        $('#formEditFunction').find('#txtWSSeaviceFunctionID').val(selectedRow.wsseavicefunctionid);

        $('#formEditFunction').find('#txtFunctionName').val(selectedRow.functionname);
        $('#formEditFunction').find('#txtFunctionContent').val(unescape(strfunctioncontent));

        $('#formEditFunction').find('#txtInputFormat').val(unescape(strinputformat));
        $('#formEditFunction').find('#txtLogicContent').val(unescape(strlogiccontent));
        $('#formEditFunction').find('#txtReturnFormat').val(unescape(strreturnformat));

        $('#formEditFunction').form('validate');
        $('#formEditFunction').find('#txtFunctionName').focus();

    }
}

function EditFunctionSubmit() {
    $('#formEditFunction').form('submit', {
        onSubmit: function (e) {

            if ($('#formEditFunction').form('validate') == false) {
                return false;
            }

            var selectedRow = $('#tablist').datagrid('getSelected');

            var data = $('#formEditFunction').serializeArray();
            data[data.length] = { "name": "txtWSID", "value": selectedRow.wsid }

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('3832376e-eccd-4d04-997c-776a9333e941'),
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

                            $('#divEditFunction').window('close');
                            $('#tabFunction').datagrid("reload");
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

function DeleteFunction() {

    var selectedRow = $('#tabFunction').datagrid('getSelected');

    if (selectedRow == null) {

        $.messager.alert("提示", "必须选择一行。", 'error');

        return;
    }


    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {

            var data = eval("[]");
            data[data.length] = { "name": "txtWSSeaviceFunctionID", "value": selectedRow.wsseavicefunctionid }
            data[data.length] = { "name": "txtUpdateTime", "value": selectedRow.updatetime }

            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('3832376e-eccd-4d04-997c-776a9333e941'),
                type: 'post',
                async: true,
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
                            $('#tabFunction').datagrid("reload");
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

function EditOnClick(isAdd) {
    var selectedRow = $('#tablist').datagrid('getSelected');

    if (isAdd) {
        $('#divEditType').window({
            title: "服务添加",
            top: 20,
            modal: true,
            close: false
        });
        $('#divEditType').window("open");
        $('#txtWSID').val("");

        $('#txtAppliayUser').val('');
        $('#txtWSName').val('');
        $('#txtWSContent').val('');
        //$('#txtInputFormat').val('【参数1,示例值】\r\n【参数2,示例值】\r\n【子表名参数3,（单行）（多行）\r\n	行1【参数4，示例值】【参数5，示例值】\r\n	行2【参数4，示例值】【参数5，示例值】\r\n】');
        //$('#txtReturnFormat').val('（单行） （多行）\r\n行1【参数1，示例值】【参数2，示例值】\r\n行2【参数1，示例值】【参数2，示例值】');
        $('#txtWSDeployServer').val('');
        $('#txtWSSPName').val('');
        //$('#txtFunctionName').val('');
        //$('#txtLogicContent').val('');
        $('#txtCode').val('');
        $('#txtWSSPServer').val('');
        $('#txtServicePath').val('');

        $('#btnUpdateState').hide();
        $('#btnDelete').hide();
        $('#btnSubmit').linkbutton('enable');
        $('#btnSubmit').linkbutton({ text: "提交" });

        //$("#trUserTime").css('display', 'none'); 

        $('#formEdit').form('validate');
        $('#txtName').focus();
    }
    else {
        $('#divEditType').window({
            top: 20,
            title: "服务编辑",
            modal: true,
            close: false
        });
        $('#divEditType').window("open");

        var strcontent = selectedRow.wscontent.replace(reg, "\n").replace(reg1, "").replace(reg2, "");
        var strcode = selectedRow.code.replace(reg, "\n").replace(reg1, "").replace(reg2, "");


        $('#formEdit').find("#txtWSID").val(selectedRow.wsid.replace(reg1, "").replace(reg2, ""));
        $('#formEdit').find("#txtUpdateTime").val(selectedRow.updatetime.replace(reg1, "").replace(reg2, ""));

        $('#txtAppliayUser').val(selectedRow.appliayuser.replace(reg1, "").replace(reg2, ""));
        $('#txtWSName').val(selectedRow.wsname.replace(reg1, "").replace(reg2, ""));
        $('#txtApplayTime').val(selectedRow.applaytime.replace(reg1, "").replace(reg2, ""));
        $('#txtWSDeployServer').val(selectedRow.wsdeployserver.replace(reg1, "").replace(reg2, ""));
        $('#txtWSSPName').val(selectedRow.wsspname.replace(reg1, "").replace(reg2, ""));

        $('#txtCode').val(unescape(strcode));
        $('#txtWSContent').val(unescape(strcontent));

        $('#txtServicePath').val(selectedRow.servicepath.replace(reg1, "").replace(reg2, ""));
        $('#txtWSSPServer').val(selectedRow.wsspserver.replace(reg1, "").replace(reg2, ""));


        if (selectedRow.checkfalg == "1") {

            $('#btnUpdateState').show();

            $('#btnDelete').show();

            if (selectedRow.state == "已生效") {
                $('#btnUpdateState').linkbutton({ text: "反审核" });
            } else {
                $('#btnUpdateState').linkbutton({ text: "审核通过" });

            }
        }
        else {
            $('#btnUpdateState').hide();

            $('#btnDelete').hide();

        }

        if (selectedRow.state != "已生效" && selectedRow.appliayuser == m_loginName) {
            $('#btnSubmit').linkbutton('enable');
            $('#btnSubmit').linkbutton({ text: "修改" });
        }
        else {
            $('#btnSubmit').linkbutton('disable');
        }

        $('#formEdit').form('validate');
        $('#txtWSName').focus();

    }


}

function EditSubmit() {
    $('#formEdit').form('submit', {
        onSubmit: function (e) {

            if ($('#formEdit').form('validate') == false) {
                return false;
            }

            var data = $('#formEdit').serializeArray();
            data[data.length] = { "name": "txtState", "value": "已提交" }

            var XMLData = GetFormJson(data, 'EDIT');

            $.ajax({
                url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
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

                            $('#divEditType').window('close');
                            $('#tablist').datagrid("reload");
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



function DeleteClick() {

    var selectedRow = $('#tablist').datagrid('getSelected');

    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {

            var data = eval("[]");
            data[data.length] = { "name": "txtWSApplayID", "value": selectedRow.wsapplayid }

            var XMLData = GetFormJson(data, 'DELETE');

            $.ajax({
                url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
                type: 'post',
                async: true,
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

                            $('#divEditType').window('close');
                            $('#tablist').datagrid("reload");
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

function UpdateState(pstrState) {

    var selectedRow = $('#tablist').datagrid('getSelected');
    if (!selectedRow) {
        $.messager.alert("提示", "必须选择一行。", 'error');
        return;
    }

    var data = eval("[]");
    data[data.length] = { "name": "txtWSID", "value": selectedRow.wsid }
    data[data.length] = { "name": "txtState", "value": pstrState }
    data[data.length] = { "name": "txtUpdateTime", "value": selectedRow.updatetime }

    var XMLData = GetFormJson(data, 'UpdateState');

    $.ajax({
        url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
        type: 'post',
        async: true,
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

                    //$('#divEditType').window('close');
                    $('#tablist').datagrid("reload");
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

function CancelClick() {
    $('#divEditType').window('close');

}

function Print() {
    $.messager.alert("提示", "目前该功能还未完成！", 'error');
    return;
    //$("#lblWSApplayID").html($("#txtWSApplayID").val());
    //$("#lblAppliayUser").html($("#txtAppliayUser").val());
    //$("#lblApplayTime").html($("#txtApplayTime").val());
    //$("#lblWSName").html($("#txtWSName").val());
    //$("#lblFunctionName").html($("#txtFunctionName").val());
    //$("#lblWSSPName").html($("#txtWSSPName").val());
    //$("#lblServicePath").html($("#txtServicePath").val());
    //$("#lblWSDeployServer").html($("#txtWSDeployServer").val());
    //$("#lblWSSPServer").html($("#txtWSSPServer").val());

    //$("#lblWSContent").html($("#txtWSContent").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    //$("#lblInputFormat").html($("#txtInputFormat").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    //$("#lblReturnFormat").html($("#txtReturnFormat").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    //$("#lblLogicContent").html($("#txtLogicContent").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    //$("#lblCode").html($("#txtCode").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));

    //$("#divPrint").printArea();

}

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


function RouteDevCancelClick() {
    $('#divRouteDev').window('close');

}

function RouteDevSubmit() {
    $('#formRouteDev').form('submit', {
        onSubmit: function (e) {

            if ($('#formRouteDev').form('validate') == false) {
                return false;
            }

            var selectedRow = $('#tablist').datagrid('getSelected');
            var data = $('#formRouteDev').serializeArray();

            data[data.length] = { "name": "txtWSID", "value": selectedRow.wsid }
            data[data.length] = { "name": "txtUpdateTime", "value": selectedRow.updatetime }

            var XMLData = GetFormJson(data, 'SetDevRoute');

            $.ajax({
                url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
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

                            $('#divRouteDev').window('close');
                            $('#tablist').datagrid("reload");
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

function SetDevRoute() {
    var selectedRow = $('#tablist').datagrid('getSelected');
    $('#divRouteDev').window({
        top: 20,
        title: "选择需要下发的开发路由",
        modal: true
    });
    $('#divRouteDev').window("open");

    $("#formRouteDev").find("#txtWSApplayID").val(selectedRow.wsapplayid);
    $('#cmbRouteDev').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXTEST'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false
    });
}



function RouteDevCancelClick() {
    $('#divRouteProd').window('close');

}

//function RouteProdSubmit() {
//    $('#formRouteProd').form('submit', {
//        onSubmit: function (e) {

//            if ($('#formRouteProd').form('validate') == false) {
//                return false;
//            }

//            var data = $('#formRouteProd').serializeArray();

//            var XMLData = GetFormJson(data, 'SetProdRoute');

//            $.ajax({
//                url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
//                type: 'post',
//                async: true, //异步,
//                data: { "XML": XMLData },
//                success: function (result) {
//                    try {
//                        var result = eval("[" + result + "]");
//                        if (result[0].Error) {
//                            $.messager.progress('close');

//                            $.messager.alert("系统错误", result[0].Error, 'error');
//                        }
//                        else if (result[0].rows[0].result == "False") {

//                            $.messager.progress('close');

//                            $.messager.alert("提示", result[0].rows[0].message, 'error');
//                        }
//                        else {

//                            $('#divRouteProd').window('close');
//                            $('#tablist').datagrid("reload");
//                        }
//                    } catch (ex) {
//                        $.messager.progress('close');

//                        $.messager.alert("提示", ex, 'error');
//                    }
//                },
//                error: function () {
//                    $.messager.alert("提示", "提交错误了！", 'error');
//                }
//            });

//            return false;
//        }
//    });
//}

function SetProdRoute() {
    var selectedRow = $('#tablist').datagrid('getSelected');
    $('#divRouteProd').window({
        top: 20,
        title: "选择需要上线的正式路由",
        modal: true
    });

    $('#divRouteProd').window("open");
    $("#formRouteProd").find("#txtWSApplayID").val(selectedRow.wsapplayid);
    $('#cmbRouteProd').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXPROD'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false
    });
}