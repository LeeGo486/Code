﻿//var m_compName = $.cookie("compName");
var m_compName = $.cookie("compName");
var editIndex = undefined;

$().ready(function () {
    //初始化部件
    initParts("main");

    var height = $(document).height();
    $("#main").css("height", height);

    //初始化主DG
    var url = GetWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e') + "&XML=" + GetFormJson([], 'Get');
    mainGrid(url);

    //初始化窗口
    initWindow("close");
})

function initParts(area, buttonType) {

    var url = GetComboxWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e') + "&XML=" + GetFormJson([], 'GetWH');
    
    if (area == "main") {
        $("#mainForm input[type=text]").val("");

        $("#mainWarehouse").combobox({
            url: url,
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            width: "120"
        });

        $("#mainsearch").click(function () { search("mainSearch"); });
        $("#mainundo").click(function () { $("#mainForm input[type=text]").val(""); });
        
        $("#new").linkbutton({ iconCls: 'icon-add', plain: true }).click(function () { openWin("new") });
        $("#edit").linkbutton({ iconCls: 'icon-edit', plain: true }).click(function () { openWin("edit") });
        $("#check").linkbutton({ iconCls: 'icon-cancel', plain: true }).click(check);
    };
    if (area == "win") {
        $("#winForm input[type=text]").val("");

        $("#winWarehouse").combobox({
            url: url,
            type: 'post',
            editable: false,
            valueField: 'id',
            textField: 'text',
            panelHeight: 'auto',
            width: "120"
        });

        $("#winsearch").click(function () { search(buttonType); });
        $("#winWarehouse").combobox("enable", true);
        $("#winundo").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { $("#style").val(""); $("#sku").val(""); });

        $("#save").linkbutton({ iconCls: 'icon-save', plain: true }).click(function () { saveGoods(buttonType) });
        $("#close").linkbutton({ iconCls: 'icon-undo', plain: true }).click(closeWin);
    };
}
function mainGrid(url) {
    $("#main_list").datagrid({
        url: url,
        striped: true,
        singleSelect: true,
        height: $(document).height() * 0.78,
        fit: false,
        pagination: true,
        sortOrder: 'desc',
        sortName: 'sr1_lmdt',
        pageSize: 20,
        rownumbers: true,
        columns: [[
            { field: 'sr1_shopretreatbillcode', title: '退仓单号-ERP', width: 100 },
            { field: 'sr1_warehousebillcode', title: '总仓退仓单号-POS', width: 120 },
            { field: 'sr1_warehousecode', title: '仓库编号', width: 100 },
            { field: 'sr1_warehousename', title: '仓库名称', width: 100 },
            { field: 'sp1_name', title: '供应商名称', width: 100 },
            { field: 'sr2_st1_stylecode', title: '款号', width: 100 },
            { field: 'sr2_productcode', title: 'SKU', width: 100 },
            { field: 'sr2_po1_currency', title: '币种', width: 100 },
            { field: 'sr2_purchaseprice', title: '采购价', width: 100 },
            { field: 'sr2_saleprice', title: '吊牌价', width: 100 },   
            { field: 'sr2_znumber', title: '退货数量', width: 100 },
            { field: 'sr1_state', title: '状态', width: 100 },
            { field: 'sr1_lmuser', title: '退货人', width: 100 },
            { field: 'sr1_lmdt', title: '退货日期', width: 100 }
        ]]
        //onLoadSuccess: function (data) {
        //    //分页控件
        //    var page = $("#main_list").datagrid("getPager");
        //    page.pagination({
        //        displayMsg: "合计:采购价:"+data.rows[0].pptotal+",吊牌价:"+data.rows[0].sptotal+",退货数量:"+data.rows[0].numtotal+""
        //    });
        //}
    });
}
function initWindow(status) {
    $("#window").window({
        title: "退货维护",
        minimizable: false,
        maximizable: false,
        closable: false,
        draggable: false,
        collapsible: false,
        fit: true
    });

    if (status == "close") $("#window").window("close");
    if (status == "open") $("#window").window("open");
}
function search(areaSearch) {
    var url;
    var xmldata;
    var formData = getFormArray(areaSearch);
    if (areaSearch == "mainSearch") {
        if (formData[0].value == "") {
            alert("请选择仓库");
            return;
        };

        xmldata = GetFormJson(formData, 'mainSearch');
        xmldata = escape(xmldata);
        xmldata = xmldata.replace(/\%3C/g, "<").replace(/\%3E/g, ">");

        url = GetWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e') + "&XML=" + xmldata + "&Where=SR1_DIVI='" + m_compName + "'";
        mainGrid(url);
    }
    else if (areaSearch == "winGPSearch") {
        if (formData[0].value == "") {
            alert("请选择仓库");
            return;
        };

        var data = [];
        data[data.length]={"name":"txt操作类型","value":"GET"};
        data[data.length]={"name":"txt实体","value":"库存信息"};
        data[data.length]={"name":"txtCONO","value":"HYFG"};
        data[data.length]={"name":"txtDIVI","value":m_compName};
        data[data.length]={"name":"txt每页行数","value":"100000"};
        data[data.length]={"name":"txt页数","value":"1"};
        data[data.length]={"name":"txt店铺编号","value":formData[0].value};
        data[data.length] = { "name": "txt供应商名称", "value": formData[1].value };
        data[data.length] = { "name": "txt款号", "value": formData[2].value };
        data[data.length] = { "name": "txtSKU", "value": formData[3].value };

        url = GetWSRRURL('fa12a8ec-c644-46b9-8dc3-9e7ce2283ac4') + "&XML=" + GetDBFrameAML(data);
        winGrid(url,areaSearch);
    }
    else if (areaSearch == "winHawkSearch") {
        if (formData[0].value == "") {
            alert("请选择仓库");
            return;
        };

        var mainData = $("#main_list").datagrid("getSelected");
        formData[formData.length] = { "name": "txtBillCode", "value": mainData.sr1_shopretreatbillcode };

        xmldata = GetFormJson(formData, 'winHawkSearch');
        
        xmldata = escape(xmldata);
        xmldata = xmldata.replace(/\%3C/g, "<").replace(/\%3E/g, ">");

        url = GetWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e') + "&XML=" + xmldata;
        winGrid(url, areaSearch);
    };
}
//打开窗口
function openWin(handleType) {

    if (handleType == "new") { initParts("win", "winGPSearch"); winGrid("", "winGPSearch"); };

    if (handleType == "edit") {
        var selectedRow = $("#main_list").datagrid("getSelected");
        if (selectedRow == null) {
            alert("请选中一行数据");
            return;
        } else {
            if (selectedRow.sr1_state == "90") {
                alert("该行数据已审核，无法修改!");
                return;
            };


            var data = [];
            data[data.length] = { "name": "txtSR2_ShopRetreatBillCode", "value": selectedRow.sr1_shopretreatbillcode }
            data[data.length] = { "name": "txtwarehouse", "value": selectedRow.sr1_warehousecode };
            data[data.length] = { "name": "txtsuppCode", "value": selectedRow.sp1_name };
            var XMLData = GetFormJson(data, 'GetWinDg');
            XMLData = escape(XMLData);
            var url = GetWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e') + "&XML=" + XMLData;

            initParts("win", "winHawkSearch");

            $("#winWarehouse").combobox('setValue', selectedRow.sr1_warehousecode).combobox("disable", true);

            $("#suppName").val(selectedRow.sp1_name).attr("readonly", "readonly");

            winGrid(url, "winHawkSearch");
            $("#winWarehouse").find("option[value='" + selectedRow.sr1_warehousecode + "']").attr("selected", true);
            
        };
    }

    initWindow("open");
}
//关闭窗口
function closeWin() {
    $("#winForm input[type=text]").val("");

    ClearGrid("#win_list");

    //去掉赋值
    $("#winsearch").unbind("click");

    $("#save").linkbutton({ iconCls: 'icon-save', plain: true }).unbind("click");


    $("#window").window("close");
}
//获取表单数据
function getFormArray(areaForm) {
    var formData = null;
    if (areaForm == "mainSearch") {
        formData = $("#mainForm").serializeArray();
    }
    else {
        formData = $("#winForm").serializeArray();
    };
    return formData;
}
//winDataGrid
function winGrid(url, areaSearch) {
    var col = getWinDgCol(areaSearch);

    $("#win_list").datagrid({
        url: url,
        columns: col,
        fit: true,
        striped: true,
        singleSelect: false,
        selectOnCheck: true,
        pagination: true,
        pageSize: 20,
        rownumbers: true,
        onClickRow: function (rowIndex, rowData) {
            if (editIndex != rowIndex) {
                if (endEditing()) {
                    $('#win_list').datagrid('selectRow', rowIndex)
                                  .datagrid('beginEdit', rowIndex);
                    editIndex = rowIndex;
                } else {
                    $('#win_list').datagrid('selectRow', editIndex);
                };
            };
        }
    });
}
function getWinDgCol(areaSearch) {
    var col = "[[{ field: 'ck', checkbox: true },"
    col += "{ field: 'sr1_warehousecode', title: '仓库编号', width: 100 },";
    col += "{ field: 'sr1_warehousename', title: '仓库名称', width: 100 },{ field: 'sp1_name', title: '供应商名称', width: 100 },";
    col += "{ field: 'br1_name', title: '品牌名称', width: 100 },{ field: 'sr2_st1_stylecode', title: '款号', width: 80 },";
    col += "{ field: 'sr2_productcode', title: 'SKU', width: 100 },{ field: 'sr2_po1_currency', title: '币种', width: 60 },";
    col += "{ field: 'sr2_purchaseprice', title: '采购价', width: 100 },{ field: 'sr2_saleprice', title: '吊牌价', width: 100 },";
    if (areaSearch == "winGPSearch") {
        col += "{ field: 'k_num', title: '可退数量', width: 60 },";
        col += "{ field: 'sr2_znumber', title: '本次退货数量', width: 80, editor: { type: 'numberbox', options: { required: true } } },";
        col += "{ field: 'sr2_remarks', title: '备注', width: 200, editor:'text' }";
    }
    else if (areaSearch == "winHawkSearch") {
        col += "{ field: 'sr2_znumber', title: '退货数量', width: 80, editor: { type: 'numberbox', options: { required: true } } },"
        col += "{ field: 'sr2_remarks', title: '备注', width: 200, editor:'text' }";
    };
    col += "]]";

    col = eval(col);
    return col;
}
//验证编辑
function endEditing() {
    if (editIndex == undefined) return true;
    if ($('#win_list').datagrid('validateRow', editIndex)) {
        $('#win_list').datagrid('endEdit', editIndex);
        editIndex = undefined;
        return true;
    } else {
        return false;
    };
}
//保存
function saveGoods(saveType) {
    if (endEditing()) {
        var data = $("#win_list").datagrid("getChecked");

        if (data.length == 0) {
            alert("无提交数据,请检查");
            return;
        };

        var url = GetWSRRURL('3cd07f76-4d49-4493-ac1c-d3ca20c1631e');
        if (saveType == "winGPSearch") {
            var xmldata = GetEditJsonbyType(data, 'saveNew');
            xmldata = escape(xmldata);
            xmldata = xmldata.replace(/\%3C/g, "<").replace(/\%3E/g, ">");
            url = url + "&XML=" + xmldata + "&Where=" + m_compName;
        }
        else if (saveType == "winHawkSearch") {
            var maindata = $("#main_list").datagrid("getSelected");//getSR1_Id

            data[data.length] = { "sr1_id": maindata.sr1_id };

            var xmldata = GetEditJsonbyType(data, 'saveEdit');
            //xmldata = escape(xmldata);
        };
        
        $.messager.confirm('提示框', '确认提交？', function (r) {
            if (r) {
                $.messager.progress({ title: '请稍后', msg: '处理中' });
                $.ajax({
                    url: url,
                    data: { "XML": xmldata },
                    type: 'POST',
                    success: function (data) {
                        try {
                            var result = eval("[" + data + "]");

                            if (result[0].Error) {
                                $.messager.progress('close');

                                $.messager.alert("系统错误", result[0].Error, 'error');
                            }
                            else
                                if (result[0].rows[0].result == "False") {
                                    $.messager.progress('close');

                                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                                }
                                else {
                                    
                                    var data = [];
                                    if (saveType == "winGPSearch") {
                                        data[data.length] = { "name": "txt操作类型", "value": "NEW" };
                                        data[data.length] = { "name": "txt实体", "value": "保存退仓单" };
                                    } else {
                                        data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
                                        data[data.length] = { "name": "txt实体", "value": "修改审核" };
                                    }
                                    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
                                    data[data.length] = { "name": "txtDIVI", "value": m_compName };
                                    data[data.length] = { "name": "txt退仓单号", "value": result[0].rows[0].message };
                                    if (saveType == 'winHawkSearch') {
                                        var sltData1 = $("#main_list").datagrid("getSelected");
                                        data[data.length] = { "name": "txtPOS退仓单号", "value": sltData1.sr1_warehousebillcode };

                                        sltData1 = null;
                                    };
                                    var XMLDATA = GetDBFrameAML(data);
                                    $.post(GetWSRRURL('fa12a8ec-c644-46b9-8dc3-9e7ce2283ac4') + "&XML=" + XMLDATA, function (data) {
                                        var result = eval("[" + data + "]");
                                        $.messager.progress('close');
                                        $.messager.alert("提示", "操作成功","OK");
                                        $("#main_list").datagrid("reload");
                                        closeWin();
                                    });
                                };
                        }
                        catch (ex) {
                            $.messager.progress('close');
                            $.messager.alert("提示", ex, 'error');
                        };
                    },
                    error: function (date) {
                        alert("错误!");
                        $.messager.progress('close');
                    }
                });
            };
        });
    };
}
//弃审
function check() {
    var sltData = $("#main_list").datagrid("getSelected");
    if (sltData == null) {
        $.messager.alert("提示", "请选中一行", "warning");
        return;
    };
    if (sltData.sr1_state != "90") {
        $.messager.alert("提示", "状态错误，无法弃审", "warning");
        return;
    };
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
    data[data.length] = { "name": "txt实体", "value": "弃审" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txtDIVI", "value": m_compName };
    data[data.length] = { "name": "txt退仓单号", "value": sltData.sr1_shopretreatbillcode };
    data[data.length] = { "name": "txtPOS退仓单号", "value": sltData.sr1_warehousebillcode };
    var XMLDATA = GetDBFrameAML(data);
    data = null; sltData = null;
    $.messager.confirm('提示框', '确认提交？', function (r) {
        if (r) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.post(GetWSRRURL('fa12a8ec-c644-46b9-8dc3-9e7ce2283ac4') + "&XML=" + XMLDATA, function (data) {
                try {
                    var result = eval("[" + data + "]");
                    $.messager.progress('close');
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    }
                    else
                        if (result[0].rows[0].result == "False") {
                            $.messager.progress('close');

                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        }
                        else {
                            $.messager.alert("提示", "操作成功", "OK");
                            $("#main_list").datagrid("reload");
                        };
                }
                catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            });
        };
    });
}