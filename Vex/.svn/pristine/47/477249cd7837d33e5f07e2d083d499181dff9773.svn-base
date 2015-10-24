// 名称：PercentageDistributionReport.js
// 说明：导购提成报表
// 创建人：马卫清
// 创建日期：2014-07-28
// 修改人：
// 修改日期：
// 修改内容：

var m_DepotID = "";
var m_EmployeeManger = new Object();

//初始化
$(function () {
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
                        if (this.position == "店长") {
                            m_EmployeeManger = this;
                            return false;
                        }
                    });

                    if (m_EmployeeManger.names == undefined) {
                        $("#lblMessage").html("提示信息：本店铺还没有设置店长，请先设置店长，再到这里进行操作！");
                        $("#btnSearch").hide();
                        $("#lblEmployeeManger").html("末设置");

                    }
                    else {
                        $("#lblEmployeeManger").html(m_EmployeeManger.names);
                    }
                }
            });
        }
    });

});

//查询
function SearchClick() {

    //按扭不让点
    $("#btnSearch").linkbutton('disable');

    ClearGrid("#tabDetail");

    var data = [];

    data[data.length] = { "name": "txt工号", "value": "" };
    data[data.length] = { "name": "txt零售开始日期", "value": $("#txtBeginDate").datebox("getValue") };
    data[data.length] = { "name": "txt零售截止日期", "value": $("#txtEndDate").datebox("getValue") };

    data[data.length] = { "name": "txt模块", "value": "SupervisionPercentage" };
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
            { field: 'employeeid', title: '导购工号', width: 180 },
            { field: 'names', title: '导购姓名', width: 120 },
            { field: 'fcalcsums', title: '提成金额合计', width: 120, align: 'right', formatter: Formater.Account }
        ]],
        rownumbers: true,
        onLoadSuccess: function (data) {
            $("#btnSearch").linkbutton('enable');
        },
        onDblClickRow: function (rowIndex, rowData) {
            showDetail();
        },
        toolbar: [
           {
               id: 'btnPercentageDistribution',
               text: '提成详情',
               iconCls: 'icon-add',
               handler: function () {
                   showDetail();
               }
           }]
    });

}


function showDetail() {

    var row = $('#tabList').datagrid('getSelected');
    if (row == undefined) {
        $.messager.alert("提示", "请先选择导购！", 'error');
        return;
    }

    //$("#divDetail").title();

    //按扭不让点
    $("#btnPercentageDistribution").linkbutton('disable');

    var data = [];

    data[data.length] = { "name": "txt工号", "value": row.employeeid };
    data[data.length] = { "name": "txt零售开始日期", "value": $("#txtBeginDate").datebox("getValue") };
    data[data.length] = { "name": "txt零售截止日期", "value": $("#txtEndDate").datebox("getValue") };

    data[data.length] = { "name": "txt模块", "value": "SupervisionPercentage" };
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txtDIVI", "value": "D01" };
    data[data.length] = { "name": "txtCONO", "value": "HYFG" };
    data[data.length] = { "name": "txt店铺编号", "value": m_DepotID };

    var xmlData = GetDBFrameAMLPost(data);//组成调用APIxml 

    $('#tabDetail').datagrid(
    {
        title:"明细信息:" + row.employeeid + "_" + row.names,
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
            {
                field: 'retailid', title: '销售单号', width: 150
            },
            { field: 'znums', title: '销售数量', width: 120, align: 'right', formatter: Formater.Nums },
            {
                field: 'zssums', title: '结算金额', width: 120, align: 'right',
                formatter: Formater.Account,
                editor: {
                    type: 'numberbox', options: {
                        precision: 2
                    }
                }
            },
            {
                field: 'fcalcsums', title: '实销金额', width: 120, align: 'right',
                formatter: Formater.Account,
                editor: {
                    type: 'numberbox', options: {
                        precision: 2
                    }
                }
            }


        ]],

        onLoadSuccess: function (data) {
            $("#btnPercentageDistribution").linkbutton('enable');
        }
    });

}
