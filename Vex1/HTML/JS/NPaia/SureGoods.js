//创建者:LeeGo
//WSID: 756b264b-88eb-47a0-81fa-92e091ccb4b3
///修改人郭琦琦,前台增加备注字段显示 20150112

var GV = {};

GV.combobox = {
    state: [{ "id": "", "text": "全部", "select": true }, { "id": "90", "text": "完成" }, { "id": "99", "text": "取消" }, { "id": "20", "text": "待取" }]
};

$(document).ready(function () {

    //日期格式化yyyy-mm-dd
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        return y + '-' + m + '-' + d;
    };
    
    $("#state").combobox({
        editable: false,
        valueField: 'id',
        valueText: 'text',
        panelHeight: 100,
    }).combobox('loadData', GV.combobox.state);

    //按钮
    $("#search").linkbutton({ iconCls: 'icon-search', plain: true }).click(search);
    $("#okGoods").linkbutton({ iconCls: 'icon-ok', plain: true }).click(ok);
    $("#cancelGoods").linkbutton({ iconCls: 'icon-cancel', plain: true }).click(cancel);

    //日期
    $("#startDate").datebox();
    $("#endDate").datebox();

    //初始化dg
    initGird("");
});

//dg
function initGird(where) {
    $("#tab_list").datagrid({
        url: GetWSRRURL('756b264b-88eb-47a0-81fa-92e091ccb4b3'),
        queryParams: { "XML": GetFormJson([], 'GetCustomerOrder'), "WHERE": where },
        title: '订单列表',
        width: '90%',
        singleSelect: false,
        checkOnSelect: true,
        striped: true,
        fit: true,
        columns: [[
            { field: 'ck', checkbox: true },
            { field: 'id', title: 'headId', hidden: true },
            { field: 'detailid', title: 'DetailId', hidden: true },
            { field: 'weixinid', title: 'WeiXinID', hidden: true },
            { field: 'code', title: '订单编号', width: 100 },
            { field: 'dept_name', title: '取货店铺名称', width: 80 },
            { field: 'dept_disp_id_province', title: '省', width: 80 },
            { field: 'dept_disp_id_City', title: '市', width: 80 },
            { field: 'dept_phone', title: '店铺电话', width: 120 },
            { field: 'phone', title: '顾客手机号码', width: 120 },
            { field: 'deliverydate', title: '预计取货日期', width: 140 },
            { field: 'state', title: '状态', width: 50 },
            { field: 'desp', title: '备注', width: 100 },
            { field: 'seq', title: '项次', width: 30, align: 'right' },
            { field: 'subseq', title: '子项次', width: 50, align: 'right' },
            { field: 'styl_code', title: 'SKU', width: 100 },
            { field: 'number', title: '数量', width: 60, align: 'right',formatter:Formater.Nums},
            { field: 'Price', title: '吊牌价', width: 90, align: 'right', formatter: Formater.Account },
            { field: 'SettlementPrice', title: '结算单价', width: 90, align: 'right', formatter: Formater.Account },
            { field: 'subAmount', title: '金额', width: 90, align: 'right', formatter: Formater.Account },
            { field: 'lmuser', title: '更新人', width: 60 },
            { field: 'lmdt', title: '更新日期', width: 77, formatter: Formater.Date }
        ]],
        pagination: true, //是否开启分页
        tpageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        //onClickRow: function (rowIndex, rowData) { }
    });
}

//查询按钮方法
function search() {
    var data = $("#mainForm").serializeArray();

    var where = "1=1";

    if ((data[0].value != "" && data[1].value == "") || (data[0].value == "" && data[1].value != "")) {
        $.messager.alert("错误", "请将日期选择完整!", "error");
        return;
    };

    //取货日期
    if (data[0].value != "") {
        where += " AND left(A.[DeliveryDate],10) Between '" + data[0].value + "' AND '" + data[1].value + "'";
    };
    
    //取货店铺
    if (data[2].value != "") {
        where += " AND E.[DEPT_Name] LIKE '%" + data[2].value + "%'";
    };

    //状态
    if (data[3].value != "") {
        where += " AND B.[State] = '" + data[3].value + "'";
    }

    //查询
    initGird(where);
}

//完成订单
function ok() {
    sumbit("完成");
}

//取消
function cancel() {
    sumbit("取消");
}


//提交订单
function sumbit(type) {
    $.messager.confirm("提示", "你确定要" + type + "订单吗?", function (r) {
        if (r) {
            //勾选的数据
            var data = $("#tab_list").datagrid('getChecked');
            //检查
            if (data.length == 0) {
                $.messager.alert("提示","请勾选需要操作的行！","warning");
                return;
            };

            //提交的数据
            var XMLData = "<ROOT><OPTYPE>EditCustomerOrder</OPTYPE><LIST>";

            $.each(data, function (i, data) {
                if (data.state == "待取") {
                    XMLData += "<ROWS><HeadId>" + data.id + "</HeadId><DetailId>" + data.detailid + "</DetailId><Result>" + type + "</Result></ROWS>";
                };
            });

            XMLData += "</LIST></ROOT>";

            $.post(GetWSRRURL('756b264b-88eb-47a0-81fa-92e091ccb4b3'), { "XML": XMLData }, function (data) {
                data = eval("[" + data + "]");
                if (data[0].rows[0].result == "True") {
                    $.messager.alert("提示", "更新成功", "ok");
                } else {
                    $.messager.alert("提示", "更新失败", "error");
                };
                $("#tab_list").datagrid('reload');
            });
        };
    });
};