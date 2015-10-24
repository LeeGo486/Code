var m_loginName = '';

//初始化
$(function () {
    $.ajax({
        url: GetGetLoginURL(),
        options: "JSON",
        success: function (data) {

            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }

            m_loginName = eval("[" + data + "]")[0].UserName;
        }
    });

    //$('#cmbRouteProd').combobox({
    //    url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXPROD'),
    //    valueField: 'id',
    //    textField: 'text',
    //    required: true,
    //    panelHeight: 'auto',
    //    editable: false
    //});


    //$('#cmbRouteTest').combobox({
    //    url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXTEST'),
    //    required: true,
    //    panelHeight: 'auto',
    //    valueField: 'id',
    //    textField: 'text',
    //    editable: false
    //});
    InitGird();
});


//初始化表格
function InitGird() {
    $('#tab_list').datagrid(
        {
            title: '服务申请：1、系统提交申请后，与总监当面确认；2、打印申请单给研发；3、研发完成后，录入SP代码；4、与总监确认定稿；',
            queryParams: { "XML": GetGetJson([{}]) },
            url: GetWSRRURL('0a5a1659-97a8-4163-accb-22763e384700'),
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            striped: true, //True 奇偶行使用不同背景色
            collapsible: false, //可折叠
            remoteSort: true, //定义是否从服务器给数据排序
            fit: true,
            singleSelect: true, //单行选择

            columns: [[
                { field: 'function_name', title: '方法名称', width: 160, search: true, sortable: true },
                { field: 'ws_sp_server', title: 'SP部署', width: 160, search: true, sortable: true },
                { field: 'ws_spname', title: 'SP名称', width: 180, search: true, sortable: true },
                //{ field: 'ws_deployserver', title: '服务部署', width: 130, search: true, sortable: true },
                { field: 'state', title: '状态', width: 50, search: true, sortable: true },
                { field: 'appliay_user', title: '申请人', width: 60, search: true, sortable: true },
                { field: 'applay_time', title: '申请时间', width: 125, search: true, sortable: true },

                { field: 'input_format', title: '输入格式', width: 130, search: true, hidden: true },
                { field: 'return_format', title: '返回格式', width: 130, search: true, hidden: true }
            ]],
            frozenColumns: [[//冻结的列，不会随横向滚动轴移动
                { field: 'ck', title: '', width: 20, checkbox: true },
	            { field: 'ws_applay_id', title: '服务编号', width: 180, hidden: true },
	            {
	                field: 'service_path', title: '服务路径', width: 190, search: true, sortable: true,
	                formatter: function (value, row, index) {
	                    var content = '<div title="' + row.ws_content + '">' + value + '</div>';
	                    return content;
	                }
	            },
                {
                    field: 'ws_name', title: '服务名称', width: 100, search: true, sortable: true,
                    formatter: function (value, row, index) {
                        var content = '<div title="' + row.ws_content + '">' + value + '</div>';
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
            onDblClickRow: function () { Edit_OnClick(false); },
            onLoadSuccess:function(){
                //$("#btn_Design").hide();
                //$("#btn_Deploy").hide();
                //$("#btn_OnLine").hide();
                //$("#btn_ReSend").hide();
            },
            rowStyler: function (index, row) {
                if (row.state != "已生效") {
                    return 'background-color:#FFCCFF';
                }
            },

            toolbar: [
            {
                id: 'btn_Add',
                text: '添加申请',
                iconCls: 'icon-add',
                handler: function () {
                    Edit_OnClick(true);
                }
            }, {
                id: 'btn_Design',
                hidden: true,
                text: '已设计',
                iconCls: 'icon-design',
                handler: function () {
                    UpdateState("已设计");
                }
            }, {
                id: 'btn_Deploy',
                hidden: true,

                text: '下发',
                iconCls: 'icon-deploy',
                handler: function () {
                    SetDevRoute();

                }
            }, {
                id: 'btn_OnLine',
                text: '上线',
                hidden: true,
                iconCls: 'icon-online',
                handler: function () {
                    SetProdRoute();


                }
            }
            , {
                id: 'btn_ReSend',
                hidden: true,
                text: '重新提交',
                iconCls: 'icon-online',
                handler: function () {
                    UpdateState("重新提交");

                }
            }
            ]
        }
        );

}

function RowClick(rowIndex, rowData) {
    if (rowData.state == "已提交" || rowData.state == "重新提交") {
        $("#btn_Design").show();

        $("#btn_Deploy").hide();
        $("#btn_OnLine").hide();
        $("#btn_ReSend").hide();
    }
    else if (rowData.state == "已设计") {
        $("#btn_Design").hide();
        $("#btn_Deploy").show();
        $("#btn_OnLine").hide();
        $("#btn_ReSend").hide();

    }
    else if (rowData.state == "已下发") {
        $("#btn_Design").hide();
        $("#btn_Deploy").hide();
        $("#btn_OnLine").show();
        $("#btn_ReSend").hide();

    }
    else if (rowData.state == "已上线") {
        $("#btn_Design").hide();
        $("#btn_Deploy").hide();
        $("#btn_OnLine").hide();
        $("#btn_ReSend").show();
    }
}

function Edit_OnClick(isAdd) {
    var selected_Row = $('#tab_list').datagrid('getSelected');

    if (isAdd) {
        $('#divEditType').window({
            title: "添加",
            top: 20,
            modal: true
        });

        $('#txtWS_Applay_ID').val("");

        $('#txtAppliay_User').val('');
        $('#txtWS_Name').val('');
        $('#txtWS_Content').val('');
        $('#txtInput_Format').val('【参数1,示例值】\r\n【参数2,示例值】\r\n【子表名参数3,（单行）（多行）\r\n	行1【参数4，示例值】【参数5，示例值】\r\n	行2【参数4，示例值】【参数5，示例值】\r\n】');
        $('#txtReturn_Format').val('（单行） （多行）\r\n行1【参数1，示例值】【参数2，示例值】\r\n行2【参数1，示例值】【参数2，示例值】');
        $('#txtWS_DeployServer').val('');
        $('#txtWS_SPName').val('');
        $('#txtFunction_Name').val('');
        $('#txtLogic_Content').val('');
        $('#txtCode').val('');
        $('#txtWS_SP_Server').val('');
        $('#txtService_Path').val('');

        $('#btn_UpdateState').hide();
        $('#btn_Delete').hide();
        $('#btn_Submit').linkbutton('enable');
        $('#btn_Submit').linkbutton({ text: "提交" });

        //$("#trUserTime").css('display', 'none'); 

        $('#form_Edit').form('validate');
        $('#txtName').focus();
    }
    else {
        $('#divEditType').window({
            top: 20,
            title: "编辑",
            modal: true
        });


        var reg = new RegExp("ㄧ", "g");
        var strcontent = selected_Row.ws_content.replace(reg, "\n");
        var strinput_format = selected_Row.input_format.replace(reg, "\n");
        var strreturn_format = selected_Row.return_format.replace(reg, "\n");
        var strlogic_content = selected_Row.logic_content.replace(reg, "\n");
        var strcode = selected_Row.code.replace(reg, "\n");

        $('#txtWS_Applay_ID').val(selected_Row.ws_applay_id);

        $('#txtAppliay_User').val(selected_Row.appliay_user);
        $('#txtWS_Name').val(selected_Row.ws_name);
        $('#txtApplay_Time').val(selected_Row.applay_time);
        //$('#txtInput_Format').val(strinput_format);
        $('#txtWS_DeployServer').val(selected_Row.ws_deployserver);
        $('#txtWS_SPName').val(selected_Row.ws_spname);
        $('#txtFunction_Name').val(selected_Row.function_name);
        ////$('#txtCode').val(strcode);

        $('#txtInput_Format').val(unescape(strinput_format));
        $('#txtLogic_Content').val(unescape(strlogic_content));
        $('#txtCode').val(unescape(strcode));
        $('#txtReturn_Format').val(unescape(strreturn_format));
        $('#txtWS_Content').val(unescape(strcontent));

        $('#txtService_Path').val(selected_Row.service_path);
        $('#txtWS_SP_Server').val(selected_Row.ws_sp_server);

        //$("#trUserTime").css('display', 'block'); 


        if (selected_Row.checkfalg == "1") {

            $('#btn_UpdateState').show();

            $('#btn_Delete').show();

            if (selected_Row.state == "已生效") {
                $('#btn_UpdateState').linkbutton({ text: "反审核" });
            } else {
                $('#btn_UpdateState').linkbutton({ text: "审核通过" });

            }
        }
        else {
            $('#btn_UpdateState').hide();

            $('#btn_Delete').hide();

        }

        if (selected_Row.state != "已生效" && (m_loginName == selected_Row.appliay_user || selected_Row.checkfalg == "1")) {
            $('#btn_Submit').linkbutton('enable');
            $('#btn_Submit').linkbutton({ text: "修改" });
        }
        else {
            $('#btn_Submit').linkbutton('disable');
        }

        $('#form_Edit').form('validate');
        $('#txtWS_Name').focus();

    }


}

function Edit_Submit() {
    $('#form_Edit').form('submit', {
        onSubmit: function (e) {

            if ($('#form_Edit').form('validate') == false) {
                return false;
            }

            var data = $('#form_Edit').serializeArray();
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
                            $('#tab_list').datagrid("reload");
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

function Delete_Click() {

    var selected_Row = $('#tab_list').datagrid('getSelected');

    $.messager.confirm('提示框', "确认删除吗？删除后数据将无法恢复！", function (r) {
        if (r) {

            var data = eval("[]");
            data[data.length] = { "name": "txtWS_Applay_ID", "value": selected_Row.ws_applay_id }

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
                            $('#tab_list').datagrid("reload");
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

    var selected_Row = $('#tab_list').datagrid('getSelected');


    var data = eval("[]");
    data[data.length] = { "name": "txtWS_Applay_ID", "value": selected_Row.ws_applay_id }
    data[data.length] = { "name": "txtState", "value": pstrState }

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
                    $('#tab_list').datagrid("reload");
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

function Cancel_Click() {
    $('#divEditType').window('close');

}

function Print() {
    //$.messager.alert("提示", "时间不够，还没有做，会尽快补上！", 'error');

    $("#lblWS_Applay_ID").html($("#txtWS_Applay_ID").val());
    $("#lblAppliay_User").html($("#txtAppliay_User").val());
    $("#lblApplay_Time").html($("#txtApplay_Time").val());
    $("#lblWS_Name").html($("#txtWS_Name").val());
    $("#lblFunction_Name").html($("#txtFunction_Name").val());
    $("#lblWS_SPName").html($("#txtWS_SPName").val());
    $("#lblService_Path").html($("#txtService_Path").val());
    $("#lblWS_DeployServer").html($("#txtWS_DeployServer").val());
    $("#lblWS_SP_Server").html($("#txtWS_SP_Server").val());

    $("#lblWS_Content").html($("#txtWS_Content").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    $("#lblInput_Format").html($("#txtInput_Format").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    $("#lblReturn_Format").html($("#txtReturn_Format").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    $("#lblLogic_Content").html($("#txtLogic_Content").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));
    $("#lblCode").html($("#txtCode").val().replace(/</gm, "&lt;").replace(/\n/gm, '<p>').replace(/ /gm, '&nbsp'));

    $("#divPrint").printArea();

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


function RouteDevCancel_Click() {
    $('#divRouteDev').window('close');

}

function RouteDev_Submit() {
    $('#formRouteDev').form('submit', {
        onSubmit: function (e) {

            if ($('#formRouteDev').form('validate') == false) {
                return false;
            }

            var data = $('#formRouteDev').serializeArray();

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
                            $('#tab_list').datagrid("reload");
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
    var selected_Row = $('#tab_list').datagrid('getSelected');
    $('#divRouteDev').window({
        top: 20,
        title: "选择需要下发的开发路由",
        modal: true
    });
    $("#formRouteDev #txtWS_Applay_ID").val(selected_Row.ws_applay_id);
    $('#cmbRouteDev').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXTEST'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false
    });
}



function RouteDevCancel_Click() {
    $('#divRouteProd').window('close');

}

function RouteProd_Submit() {
    $('#formRouteProd').form('submit', {
        onSubmit: function (e) {

            if ($('#formRouteProd').form('validate') == false) {
                return false;
            }

            var data = $('#formRouteProd').serializeArray();

            var XMLData = GetFormJson(data, 'SetProdRoute');

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

                            $('#divRouteProd').window('close');
                            $('#tab_list').datagrid("reload");
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

function SetProdRoute() {
    var selected_Row = $('#tab_list').datagrid('getSelected');
    $('#divRouteProd').window({
        top: 20,
        title: "选择需要上线的正式路由",
        modal: true
    });
    $("#formRouteProd #txtWS_Applay_ID").val(selected_Row.ws_applay_id);
    $('#cmbRouteProd').combobox({
        url: GetComboxWSRRURL('8a2768bb-b5eb-4fc4-b6ac-83e3677191dd', "", "routeid", "name") + "&XML=" + GetFormJson([], 'GETCOMBOXPROD'),
        required: true,
        panelHeight: 'auto',
        valueField: 'id',
        textField: 'text',
        editable: false
    });
}