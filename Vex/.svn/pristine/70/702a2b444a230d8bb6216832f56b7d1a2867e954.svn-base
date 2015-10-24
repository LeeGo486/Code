
///JS名:ProductPlanMaintenance.js
///说明:商品企划维护
///创建人:俞佳伟
///创建日期:2015-07-16

var m_Username = '';
var m_zt = '';

$(function () {

    m_Username = window.m_UserID;//取登入姓名
    m_zt = $.cookie('m_zt');

    $('#import_plan').hide();

    $('#txtSeason').combobox();
    //产品线下拉数据加载
    $('#txtProductLine').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetBrandProductLine'),
        valueField: 'id',
        textField: 'text',
        async: false,
        editable: false,
        onSelect: function (productLine) {
            $('#import_plan').hide();
            var myResult = CheckUserPower(m_Username, productLine.id);
            //季节下拉数据加载
            $('#txtSeason').combobox({
                url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "cbtx40", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetFlexPLMSeason') + "&Where=CBSTKY='" + escape(productLine.id) + "'",
                valueField: 'id',
                textField: 'text',
                panelHeight: 'auto',
                editable: false,
                onSelect: function (season) {
                    if (myResult && season.id != '') {
                        $('#import_plan').show();

                        var data = [];
                        data[data.length] = { "name": "txtzt", "value": m_zt };
                        data[data.length] = { "name": "txtBrand", "value": productLine.id };
                        data[data.length] = { "name": "txtSeason", "value": season.id };
                        var btnImport = $('#import_plan');
                        g_AjxUploadFile(btnImport, 'ImportPlan', data);
                    } else {
                        $('#import_plan').hide();
                    }
                }
            });

        }
    });

});

//主页查询按钮事件
function btnSearch() {
    InitGridList('');
    var txtProductLine = $('#txtProductLine').combobox('getValue');
    var txtSeason = $('#txtSeason').combobox('getValue');
    if (txtProductLine == '' || txtProductLine == undefined) {
        $.messager.alert('提示', '产品线不能为空', 'warning');
        return;
    }
    if (txtSeason == '' || txtSeason == undefined) {
        $.messager.alert('提示', '季节不能为空', 'warning');
        return;
    }
    var url = GetTreeWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetProductPlanDataForTree')
        + "&Where=Brand='" + escape(txtProductLine) + "' AND Season='" + escape(txtSeason) + "' AND RIGHT(BoDuan,4) NOT IN ('1201','0601') ";

    $('#ProductPlanTree').tree({
        checkbox: false,
        url: url,
        onClick: function (node) {
            //$(this).tree('toggle', node.target);//单击的时候打开树  
            var urlForDataGrid = GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetProductPlan')
                + "&Where=Brand='" + escape($('#txtProductLine').combobox('getValue')) + "' AND Season='" + escape($('#txtSeason').combobox('getValue')) + "'";
            var father = $(this).tree('getParent', node.target);
            if (father != null) {
                if (father.id == "波段") {
                    urlForDataGrid += " AND BoDuan='" + node.id + "'";
                }
                else {

                    var grandfather = $(this).tree('getParent', father.target);
                    if (grandfather != null) {
                        if (grandfather.id == "波段") {
                            urlForDataGrid += " AND BoDuan='" + father.id + "' AND StyleSeries='" + escape(node.id) + "'";
                        }
                        else {
                            urlForDataGrid += " AND BoDuan='" + grandfather.id + "' AND StyleSeries='" + escape(father.id) + "' AND Category='" + escape(node.id) + "'";
                        }
                    }
                }
            }

            InitGridList(urlForDataGrid);
        },
        onContextMenu: function (e, node) { },
        onLoadSuccess: function (node, data) {
            if (data[0].children == undefined) {
                $.messager.alert('提示', '无数据', 'warning');
                return;
            }
            $('#ProductPlanTree').tree('collapseAll');
            if (data.Error != null) {
                $.messager.alert("提示", data.error, 'error');
            }
            //else {
            //    $('#ProductPlanTree').tree('collapseAll');
            //}
        },
        onLoadError: function (arguments) {
            alert(arguments);
        }
    });
    //InitGrid(url);
}

//主页数据加载
function InitGridList(url) {
    ClearGrid("#ProductPlanList");
    $('#ProductPlanList').datagrid({
        url: url,
        //fitColumns: true,
        singleSelect: true,
        onDblClickRow: onDblClickRow,
        rownumbers: true,
        fit: true,
        columns: [[
            { field: 'placeholderid', title: '占位符' },
            { field: 'displaysubcategory', title: 'skc要求' },
            { field: 'costmultiplyingpower', title: '成本倍率' },
            { field: 'targetcost', title: '目标成本' },
            { field: 'planedretailedprice', title: '计划吊牌价' },
            { field: 'planedfabriccost', title: '计划面料成本' },
            { field: 'usernamec', title: '责任设计师' }
        ]],
        onLoadSuccess: function (data) {
            if (data.length == 1 && data[0].placeholderid == "") {
                ClearGrid("#ProductPlanList");
            }
        }
    });
}

//双击按钮事件
function onDblClickRow(index, row) {
    $('#winEdit').window('open');
    $('#btnSave').click(btnSave);
    $('#btnCancel').click(btnCancel);
    var productLine = $('#txtProductLine').combobox('getValue');
    $('#txtUserID').combobox({
        url: GetComboxWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9', "", "username", "cbtx40") + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }, { "name": "txtOwnBrand", "value": "%" }], 'GetDesigner'),
        valueField: 'id',
        textField: 'text',
        editable: false,
        async: false
    });
    $('#txtBrand').val(row.brand);
    $('#txtSeasonEdit').val(row.season);
    $('#txtboduan').val(row.boduan);
    $('#txtseries').val(row.styleseries);
    $('#txtcategory').val(row.category);
    $('#txtPlaceHolderID').val(row.placeholderid);
    $('#txtDisplaySubCategory').val(row.displaysubcategory);
    $('#txtCostMultiplyingpower').numberbox('setValue', row.costmultiplyingpower);
    $('#txtTargetCost').numberbox('setValue', row.targetcost);
    $('#txtPlanedRetailedPrice').numberbox('setValue', row.planedretailedprice);
    $('#txtPlanedFabricCost').numberbox('setValue', row.planedfabriccost);
    $('#txtUserID').combobox('select', row.userid);
}

//编辑保存按钮事件
function btnSave() {
    $.messager.confirm('提示', '确认修改?', function (r) {
        if (r) {
            var data = [];
            data[data.length] = { "name": "txtzt", "value": m_zt };
            data[data.length] = { "name": "txtboduan", "value": $('#txtboduan').val() };
            data[data.length] = { "name": "txtseries", "value": $('#txtseries').val() };
            data[data.length] = { "name": "txtcategory", "value": $('#txtcategory').val() };
            data[data.length] = { "name": "txtPlaceHolderID", "value": $('#txtPlaceHolderID').val() };
            data[data.length] = { "name": "txtDisplaySubCategory", "value": $('#txtDisplaySubCategory').val() };
            data[data.length] = { "name": "txtCostMultiplyingpower", "value": $('#txtCostMultiplyingpower').numberbox('getValue') };
            data[data.length] = { "name": "txtTargetCost", "value": $('#txtTargetCost').numberbox('getValue') };
            data[data.length] = { "name": "txtPlanedRetailedPrice", "value": $('#txtPlanedRetailedPrice').numberbox('getValue') };
            data[data.length] = { "name": "txtPlanedFabricCost", "value": $('#txtPlanedFabricCost').numberbox('getValue') };
            data[data.length] = { "name": "txtUserID", "value": $('#txtUserID').combobox('getValue') };

            var xmlData = GetFormJson(data, 'UpdatePlan');
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('6e647c56-cd98-4eb9-ae95-0021cc435801'),
                type: 'post',
                async: false, //同步,
                data: { "XML": xmlData },
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
                            $.messager.progress('close');
                            $('#winEdit').window('close');
                            $('#ProductPlanList').datagrid('reload');
                            $.messager.alert("提示", result[0].rows[0].message, 'info');
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
    });
}

//移除计划方法
function DeletePlan() {
    var productLine = $('#txtProductLine').combobox('getValue');
    var season = $('#txtSeason').combobox('getValue');

    if (!CheckUserPower(m_Username, productLine)) {
        $.messager.alert('提示', '您没有移除计划的权限', 'warning');
        return false;
    }

    if (productLine == "" || season == "") {
        $.messager.alert("警告", "产品线、季节不能为空", "warning");
        return false;
    }
    var data = [];
    data[data.length] = { "name": "txtzt", "value": m_zt };
    data[data.length] = { "name": "txtBrand", "value": productLine };
    data[data.length] = { "name": "txtSeason", "value": season };
    var xmlData = GetFormJson(data, 'DeletePlan');
    $.messager.confirm("确认", "你确认要移除" + season + "季节的企划吗?", function (r) {
        if (r) {
            $.messager.progress({ title: '请稍后', msg: '处理中' });
            $.ajax({
                url: GetWSRRURL('6e647c56-cd98-4eb9-ae95-0021cc435801'),
                type: 'post',
                async: false, //同步,
                data: { "XML": xmlData },
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
                            $.messager.progress('close');
                            btnSearch();
                            $.messager.alert("提示", result[0].rows[0].message, 'info');
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
    });
}

//编辑取消按钮事件
function btnCancel() {
    $('#winEdit').window('close');
}

//excel批量导入
///btn : 按钮
///method ：后台调用方法
function g_AjxUploadFile(btn, method, data) {

    // 创建一个上传参数
    var uploadOption =
    {
        action: '/Handler_PLMAS.ashx?filePath=excel&ExcelImport=true',    // 提交目标
        data: { "WSID": "6e647c56-cd98-4eb9-ae95-0021cc435801", "XML": GetFormJson(data, method) },
        name: "myfile",            // 服务端接收的名称
        autoSubmit: false,        // 是否自动提交
        responseType: "json",
        async: false,
        // 选择文件之后…
        onChange: function (file, extension) {
            // 选择文件之后，比如校验文件后缀…
            if (!(extension && /^(xls|xlsx|XLS|XLSX)$/.test(extension))) {
                $.messager.alert('系统提示', '选择的格式不正确!', 'error');
                return false;
            }
            var season = $('#txtSeason').combobox('getValue');
            var productLine = $('#txtProductLine').combobox('getValue');
            $.messager.confirm('提示', '你确认要导入' + season + '季节的企划吗?', function (r) {
                if (r) {

                    //au.setData = ({ "WSID": "6e647c56-cd98-4eb9-ae95-0021cc435801", "XML": GetFormJson(data, method) });
                    au.submit();

                }
            });
        },
        // 开始上传文件
        onSubmit: function (file, extension) {
            // 可以来一个“正在上传”的提示
            $.messager.progress({ title: "提示", msg: "正在导入,请稍后..." });
        },
        // 出现错误
        error: function () {
            $.messager.progress('colse');
            $.messager.alert('提示', '导入出错', 'error');
        },
        // 上传完成之后
        onComplete: function (file, result) {
            // 文件上传之后，比如返回文件的URL，或者跳转到其它页面…
            $.messager.progress("close");
            try {
                if (result.Error) {
                    $.messager.alert("系统错误", result.Error, 'error');
                }
                else if (result.rows[0].result == "False") {
                    $.messager.alert("提示", result.rows[0].message, 'error');
                }
                else {
                    $.messager.alert("提示", file + " " + result.rows[0].message, 'info');
                    btnSearch();
                }
            } catch (ex) {
                $.messager.alert("提示", ex, 'error');
            }
        }
    }

    // 初始化图片上传框
    var au = new AjaxUpload(btn, uploadOption);

}

//导出
function excelExport() {

    var txtProductLine = $('#txtProductLine').combobox('getValue');
    var txtSeason = $('#txtSeason').combobox('getValue');
    if (txtProductLine == '' || txtProductLine == undefined) {
        $.messager.alert('提示', '产品线不能为空', 'warning');
        return;
    }
    if (txtSeason == '' || txtSeason == undefined) {
        $.messager.alert('提示', '季节不能为空', 'warning');
        return;
    }
    var strUrl = GetWSRRURL('d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9') + "&XML=" + GetFormJson([{ "name": "txtzt", "value": m_zt }], 'GetProductPlan')
                + "&Where=Brand='" + escape(txtProductLine) + "' AND Season='" + escape(txtSeason) + "'";

    EasyUI_DataGrid_ExcelExport(strUrl);
}

//导出Exel主函数
function EasyUI_DataGrid_ExcelExport(strUrl) {

    var dataParam = {};

    var title = "商品企划报表";

    var strXMLCol = "<Root><List>";

    strXMLCol += "<Rows><field>boduan</field><title>上市日期</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>brand</field><title>品牌</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>styleseries</field><title>系列</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>category</field><title>品类</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>placeholderid</field><title>占位符</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>displaysubcategory</field><title>SKC要求</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>usernamec</field><title>设计师</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>costmultiplyingpower</field><title>成本倍率</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>targetcost</field><title>目标成本</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>planedretailedprice</field><title>计划吊牌价</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";
    strXMLCol += "<Rows><field>planedfabriccost</field><title>计划面料成本</title><width></width><hidden>false</hidden><formatDataType></formatDataType></Rows>";


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

                    if (eval("[" + data + "]")[0].Error) {
                        $.messager.alert("导出Excel出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }
                    $.messager.progress('close');
                    var strFileName = eval("[" + data + "]")[0].FileName;

                    window.location.href = strFileName;
                },
                error: function (date) {
                    $.messager.alert('提示', '错误!', 'error');
                    $.messager.progress('close');
                }

            });
            return false;
        }
    });
}

//验证用户权限
function CheckUserPower(userid, brand) {

    var result = false;

    var data = [];
    data[data.length] = { "name": "txtzt", "value": m_zt };
    data[data.length] = { "name": "txtuserid", "value": userid };
    data[data.length] = { "name": "txtbrand", "value": brand };

    var xmlData = GetFormJson(data, 'CheckForUserPower');

    $.ajax({
        type: "POST",
        url: GetWSRRURL('6e647c56-cd98-4eb9-ae95-0021cc435801'),
        data: { "XML": xmlData },
        dataType: "json",
        async: false, //同步,
        success: function (data) {
            if (data.rows[0].result == 'True') {

                result = true;

                //$('#import_plan').show();
                //var btnImport = $('#import_plan');
                //g_AjxUploadFile(btnImport, 'ImportPlan');
            }
            else {
                result = false;
                //$('#import_plan').hide();
            }
        },
        error: function () {
            result = false;
            //$.messager.alert('提示', '出现错误', 'error');
            //$('#import_plan').hide();
        }
    });

    return result;
}