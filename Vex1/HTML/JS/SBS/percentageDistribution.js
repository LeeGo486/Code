// 名称：PercentageDistributionReport.js
// 说明：导购提成分配
// 创建人：马卫清
// 创建日期：2014-07-28
// 修改人：
// 修改日期：
// 修改内容：

var m_DepotID = "";
var m_Employee = undefined;
var m_EmployeeManger = new Object();

var m_EditIndex;
var m_EditFiled;
var m_SaleAccout = 0;
var m_DepotID;
//初始化
$(function () {

    m_DepotID = window.m_UserID.substring(0, 8);
    var nowDate = new Date();


    var nowDate1 = new Date(nowDate.getFullYear() + "/" + (nowDate.getMonth() + 1) + "/" + "01")


    $("#txtBeginDate").datebox("setValue", nowDate1.DateAdd('m', 0).format("yyyy-MM-dd"));
    $("#txtEndDate").datebox("setValue", nowDate.format("yyyy-MM-dd"));

    //获取DepotID
    $.ajax({
        url: GetWSRRURL('DepotID'),
        options: "JSON",
        async: false, //同步
        success: function (data) {
            //alert(data);
            if (eval("[" + data + "]")[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }
            m_DepotID = eval("[" + data + "]")[0].DepotID;

            //获取导购信息
            var data = [];
            data[data.length] = { "name": "txt模块", "value": "EmployeeALL" };
            data[data.length] = { "name": "txt操作类型", "value": "GET" };
            data[data.length] = { "name": "txtDIVI", "value": "D01" };
            data[data.length] = { "name": "txtCONO", "value": "HYFG" };
            data[data.length] = { "name": "txt店铺编号", "value": m_DepotID };
            var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml 

            $.ajax({
                url: GetWSRRURL('735cf034-e6e7-4c09-ba67-3bea7ac4cd1a'),
                options: "JSON",
                data: xmlData,
                type: "post",
                async: false, //同步
                success: function (data) {

                    var objData = eval("[" + data + "]");
                    if (objData[0].Error) {
                        $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                        return;
                    }

                    m_Employee = objData[0].rows;



                    $.each(m_Employee, function () {
                        //if (this.position == "店长" || this.position == "店助") {
                            m_EmployeeManger = this;
                            return false;
                        //}
                    });

                    //if (m_EmployeeManger.names == undefined) {
                    //    $("#lblMessage").html("提示信息：本店铺还没有设置店长，请先设置店长，再到这里进行操作！");
                    //    $("#btnSearch").hide();
                    //    $("#lblEmployeeManger").html("末设置");
                    //}
                    //else {
                        //$("#lblEmployeeManger").html(m_EmployeeManger.names);
                    //}
                }
            });

        }
    });

});

//数据查询
function SearchClick() {
    if (m_DepotID == "") {
        $.messager.alert("出错了", "数据初始化出错。请重新登录！", 'error');
        return;
    }

    //按扭不让点
    $("#btnSearch").linkbutton('disable');

    var data = [];
    data[data.length] = { "name": "txt零售单号", "value": $("#txtSaleID").val() };
    data[data.length] = { "name": "txt零售开始日期", "value": $("#txtBeginDate").datebox("getValue") };
    data[data.length] = { "name": "txt零售截止日期", "value": $("#txtEndDate").datebox("getValue") };

    if ($("#chkAllSale").attr("checked") == "checked") {
        data[data.length] = { "name": "txt是否全数据", "value": "Y" };
    }
    else {
        data[data.length] = { "name": "txt是否全数据", "value": "N" };
    }
    data[data.length] = { "name": "txt模块", "value": "ShopSale" };
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txtDIVI", "value": "D01" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt店铺编号", "value": m_DepotID };
    var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml 

    $('#tabList').datagrid(
    {
        url: GetWSRRURL('735cf034-e6e7-4c09-ba67-3bea7ac4cd1a'),
        async: true, //异步,
        queryParams: xmlData,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择 
        columns: [[
            { field: 'retailid', title: '销售单号', width: 180 },
            { field: 'znums', title: '销售数量', width: 120, align: 'right', formatter: Formater.Nums },
            { field: 'zssums', title: '结算金额', width: 120, align: 'right', formatter: Formater.Account },
        { field: 'fcalcsums', title: '实销金额', width: 120, align: 'right', formatter: Formater.Account }
        ]],
        rownumbers: true,
        rowStyler: function (index, row) {
            if (row.setsign == "0") {
                return 'color:#f00;';
            }
        },
        onLoadSuccess: function (data) {
            $("#btnSearch").linkbutton('enable');
        },
        onDblClickRow: function (rowIndex, rowData) {
            percentageDistribution();
        },
        toolbar: [
           {
               id: 'btnPercentageDistribution',
               text: '提成分配',
               iconCls: 'icon-add',
               handler: function () {
                   percentageDistribution();
               }
           }]
    });
}

//分配提成
function percentageDistribution() {
    var row = $('#tabList').datagrid('getSelected');
    if (row == undefined) {
        $.messager.alert("提示", "请先选择需要分配的销售单！", 'error');
        return;
    }

    var month = row.retailid;
    month = month.substr(12, 2);
    var data = [];
    data[data.length] = { "name": "txtdepotid", "value": m_DepotID };
    data[data.length] = { "name": "txtmonth", "value": month };

    var xmlData = GetFormJson(data, 'checkDepot');
    htmlobj = $.ajax({
        url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
        data: { "XML": xmlData },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    var count = result.rows[0]['count']//获取是否有权限

    if (count < 1) {
        alert("不能操作");
        return;
    }

    $("#divPercentageDistribution").window({
        title: "分配",
        top: 20,
        modal: true,
        closed: false
    });

    $.messager.progress({ title: '请稍后', msg: '处理中' });

    $("#lblSaleID").html(row.retailid);
    $("#lblzssums").html(Formater.Account(row.zssums));
    $("#lblfcalcsums").html(Formater.Account(row.fcalcsums));

    m_SaleAccout = row.fcalcsums;

    initPercentageDistributionData(row);
}

//初始化分配提成的表格数据
function initPercentageDistributionData(rowData) {
    var percentageData = undefined;

    var data = [];
    data[data.length] = { "name": "txtRetailID", "value": rowData.retailid }
    var xmlData = GetFormJson(data, 'GetPercentageDistribution');

    $.ajax({
        url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
        data: { "XML": xmlData },
        type: 'post',
        async: true,
        success: function (responseData) {
            var objData = eval("[" + responseData + "]");
            if (objData[0].Error) {
                $.messager.alert("出错了", eval("[" + data + "]")[0].Error, 'error');
                return;
            }

            percentageData = objData[0];


            //取订单原始数据
            data = [];

            data[data.length] = { "name": "txt模块", "value": "Employee" };
            data[data.length] = { "name": "txt操作类型", "value": "GET" };
            data[data.length] = { "name": "txtDIVI", "value": "D01" };
            data[data.length] = { "name": "txtCONO", "value": "HYFG" };

            data[data.length] = { "name": "txt零售单号", "value": rowData.retailid };
            var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml 

            $.ajax({
                url: GetWSRRURL('735cf034-e6e7-4c09-ba67-3bea7ac4cd1a'),
                data: xmlData,
                type: 'post',
                async: true,
                success: function (responseData) {
                    $.messager.progress('close');

                    var objData = eval("[" + responseData + "]");

                    //如果从来没有被分配过，需要配置初始值
                    if (percentageData.rows[0].id == "") {
                        percentageData = objData[0];
                        $.each(percentageData.rows, function () {
                            //如果不是店长，那么记录就不能够删除
                            if (this.employeeid != m_EmployeeManger.employeeid) {
                                this.canDelete = false;
                            }
                            this.percentageemployeeid = this.employeeid;
                            this.percentagenames = this.names;
                            this.depotid = m_DepotID;
                        });
                    }
                    else {
                        //确定可以删除的导购
                        $.each(percentageData.rows, function () {
                            var obj = this;
                            this.depotid = m_DepotID;

                            $.each(objData[0].rows, function () {
                                //如果这个导购不是店长，并且存在于零售单的导购列表中，就不能删除
                                if (this.employeeid == obj.employeeid && obj.employeeid != m_EmployeeManger.employeeid) {
                                    obj.canDelete = false;
                                }
                            });
                        });
                    }

                    initPercentage(percentageData);
                }
            });
        }
    });


}

//加载分配Grid
function initPercentage(percentageData) {
    $('#tabPercentage').datagrid({
        data: percentageData,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        singleSelect: true, //单行选择 
        width: 660,
        height: 260,
        onClickCell: onClickCell,
        columns: [[
            { field: 'employeeid', title: '导购工号', width: 120, align: 'left' },
            { field: 'names', title: '导购姓名', width: 120, align: 'left' },
            { field: 'percentagenames', title: '分配导购', width: 120, align: 'left' },
            { field: 'retailid', title: '销售单号', width: 150, hidden: true },
            { field: 'percentageemployeeid', title: '分配导购ID', hidden: true },
            {
                field: 'zssumspre', title: '百分比（%）', width: 120, align: 'right',
                formatter: Formater.Account,
                editor: {
                    type: 'numberbox', options: {
                        precision: 2
                    }
                }
            },
            {
                field: 'zssums', title: '金额提成', width: 120, align: 'right',
                formatter: Formater.Account,
                editor: {
                    type: 'numberbox', options: {
                        precision: 2
                    }
                }
            }
        ]],
        onLoadSuccess: function () {
            $.each(percentageData.rows, function () {
                if (this.employeeid == m_EmployeeManger.employeeid) {
                    $("#btnSelectEmployee").show();
                    return false;
                }
            });
            computePercentage();
        },

        onClickRow: function (rowIndex, rowData) {
            if (rowData.canDelete == false) {
                $("#btnDeletEmployee").linkbutton('disable');
            }
            else {
                $("#btnDeletEmployee").linkbutton('enable');
            }
        },
        rownumbers: true,
        toolbar: [
          {
              id: 'btnSelectEmployee',
              text: '添加导购',
              iconCls: 'icon-add',
              hidden: true,
              handler: function () {
                  selectEmployee();
              }
          },
         {
             id: 'btnDeletEmployee',
             text: '删除导购',
             iconCls: 'icon-remove',
             handler: function () {
                 deleteEmployee();
             }
         }]
    });
}

//分配的导购选择
function selectEmployee() {
    $("#divSelectEmployee").window({
        title: "添加导购",
        top: 20,
        modal: true,
        closed: false
    });


    //去除已经选择过的数据
    var employeeSelect = [];
    var oldPercentage = $('#tabPercentage').datagrid("getData");
    $.each(m_Employee, function () {
        var names = this.names;
        var flag = false;
        $.each(oldPercentage.rows, function () {
            if (this.names == names) {
                flag = true;
                return false;
            }
        });

        if (flag == false) {
            employeeSelect[employeeSelect.length] = this;
        }
    });


    $('#tabSelectEmployee').datagrid(
    {
        data: employeeSelect,
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        collapsible: false, //可折叠
        remoteSort: true, //定义是否从服务器给数据排序
        singleSelect: false, //单行选择 
        checkOnSelect: true,
        width: 400,
        height: 200,
        selectOnCheck: true,
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'employeeid', title: '导购工号', width: 120, align: 'left' },
            { field: 'names', title: '导购姓名', width: 120, align: 'left' }
        ]],
        rownumbers: true
    });
}

//分配导购选择确认
function selectEmployeeSubmit() {
    var selectData = $('#tabSelectEmployee').datagrid("getSelections");

    var rowData = $('#tabPercentage').datagrid('getRows');
    $.each(selectData, function () {

        var flag = false;
        var employeeid = this.employeeid;

        //去掉已存在的数据
        $.each(rowData, function () {
            if (employeeid == this.percentageemployeeid) {
                flag = true;
                return false;
            }
        });

        if (flag == false) {
            $('#tabPercentage').datagrid('appendRow', {
                retailid: $("#lblSaleID").html(),
                employeeid: m_EmployeeManger.employeeid,
                names: m_EmployeeManger.names,
                percentageemployeeid: this.employeeid,
                percentagenames: this.names,
                depotid: m_DepotID,
                zssums: 0,
                zssumspre: 0
            });
        }
    })

    WindowClose('#divSelectEmployee')
}

//删除导购
function deleteEmployee() {
    if (endEditing()) {
        var selectData = $('#tabPercentage').datagrid("getSelected");
        if (selectData == undefined) {
            $.messager.alert("提示", "请先选择需要删除的导购！", 'error');
            return;
        }

        $('#tabPercentage').datagrid("deleteRow", $('#tabPercentage').datagrid("getRowIndex", selectData));
        computePercentage();
    }
}

//点击分配单元格
function onClickCell(index, field) {
    if (endEditing()) {
        if (field == "zssumspre"
            || field == "zssums") {
            $('#tabPercentage').datagrid('selectRow', index)
                    .datagrid('editCell', { index: index, field: field });
            $("#divPercentageDistribution input").focus();
            m_EditIndex = index;
            m_EditFiled = field;
        }
    }
}

//结束编辑
function endEditing() {
    if (m_EditIndex == undefined) { return true }
    if ($('#tabPercentage').datagrid('validateRow', m_EditIndex)) {
        $('#tabPercentage').datagrid('endEdit', m_EditIndex);
        var rowData = $('#tabPercentage').datagrid('getRows')[m_EditIndex];

        //金额
        if (m_EditFiled == "zssums") {
            //计算百分比
            if (m_SaleAccout == 0) {
                rowData.zssumspre = 0;
            }
            else {
                rowData.zssumspre = rowData.zssums / m_SaleAccout * 100;
            }
        }
        else {
            //计算金额
            if (m_SaleAccout == 0) {
                rowData.zssums = 0;
            }
            else {
                rowData.zssums = rowData.zssumspre * m_SaleAccout / 100;
            }
        }
        $('#tabPercentage').datagrid('updateRow', {
            index: m_EditIndex,
            row: rowData
        });

        computePercentage();

        m_EditIndex = undefined;
        return true;
    } else {
        return false;
    }
}

//确认分配
function percentageSubmit() {
    //debugger;
    if (endEditing()) {
        var rowData = $('#tabPercentage').datagrid('getRows');

        if ($("#lblPercentagesums").html() != $("#lblfcalcsums").html()) {
            $.messager.alert("提示", "提成总金额必须等于实销金额！", 'error');
            return;
        }

        if ($("#lblPercentagesums").html() == "0") {
            $.messager.alert("提示", "提成总金额为0，不需要分配！", 'error');
            return;
        }

        var xmlData = GetEditJsonbyType(rowData, 'Percentage');

        $.ajax({
            url: GetWSRRURL('a1ae647c-d956-4c44-b598-b6f4c1b30fcc'),
            data: { "XML": xmlData },
            type: 'post',
            async: false, //同步
            success: function (responseData) {
                var objData = eval("[" + responseData + "]");
                if (objData[0].Error) {
                    $.messager.alert("出错了", objData[0].Error, 'error');
                    return;
                }
                else {
                    $.messager.alert("提示", objData[0].rows[0].message);
                    WindowClose('#divPercentageDistribution');
                    return;
                }
            }
        });
    }
}

//计算提成总额
function computePercentage() {

    var rowData = $('#tabPercentage').datagrid('getRows');
    var account = 0;
    $.each(rowData, function () {
        if (!isNaN(parseFloat(this.zssums))) {
            account = account + parseFloat(this.zssums);
        }
    });

    $("#lblPercentagesums").html(Formater.Account(account));
    if (account == m_SaleAccout) {
        $("#lblPercentagesums").attr("style", "color:#000")
    }
    else {
        $("#lblPercentagesums").attr("style", "color:red")
    }
}