//WSID:d4f5bfc9-1167-4a19-bc32-960edd4e45d7

$().ready(function () {
    //初始化日期
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        if (m < 10) { m = "0" + m };

        var d = date.getDate();
        if (d < 10) { d = "0" + d };

        return y + '-' + m + '-' + d;
    };

    var XMLData = GetGetJson([], "GetOrder");
    initGrid(XMLData);
    initPart();
    initWin("close");
});

function initGrid(XMLData) {
    $("#tab_list").datagrid({
        url: GetWSRRURL('d4f5bfc9-1167-4a19-bc32-960edd4e45d7') + "&XML=" + XMLData,
        fit: true,
        striped: true,
        singleSelect: false, //单行选择
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
            { field: 'ck', checkbox: true },
           { field: 'employeeno', title: '员工编号', width: 100 },
           { field: 'employeename', title: '员工姓名', width: 100 },
           { field: 'unusedcredits', title: '可用总积分', width: 80 },
           { field: 'goodsno', title: '商品编号', width: 100 },
           { field: 'name', title: '商品名称', width: 100 },
           { field: 'retailprice', title: '商品现价', width: 80 },
           { field: 'goodsnum', title: '申请数量', width: 80 },
           { field: 'status', title: '订单状态', width: 80 },
           { field: 'lmdt', title: '申请时间', width: 100 }
        ]]
    });
}
function initWinGrid(XMLData) {
    $("#win_list").datagrid({
        url: GetWSRRURL('d4f5bfc9-1167-4a19-bc32-960edd4e45d7') + "&XML=" + XMLData,
        fit: true,
        striped: true,
        singleSelect: true, //单行选择
        pagination: true, //是否开启分页
        pageSize: 20, //默认一页数据条数 
        rownumbers: true,//行号
        columns: [[
           { field: 'employeeno', title: '员工编号', width: 100 },
           { field: 'employeename', title: '员工姓名', width: 100 },
           { field: 'goodsno', title: '商品编号', width: 100 },
           { field: 'name', title: '商品名称', width: 100 },
           { field: 'retailprice', title: '商品现价', width: 80 },
           { field: 'goodsnum', title: '申请数量', width: 80 },
           { field: 'status', title: '订单状态', width: 80 },
           { field: 'lmdt', title: '申请时间', width: 100 }
        ]]
    });
}
function initPart() {

    $("#sure").linkbutton({ iconCls: 'icon-ok', plain: true }).click(function () { sumbitOrder("AllowOrder"); });
    $("#overrule").linkbutton({ iconCls: 'icon-stop', plain: true }).click(function () { sumbitOrder("Overrule"); });
    $("#search").linkbutton({ iconCls: 'icon-search', plain: true }).click(searchOrder);
    $("#history").linkbutton({ iconCls: 'icon-search', plain: true }).click(function () { initWin("open"); });
    $("#winSearch").linkbutton({ iconCls: 'icon-search', plain: true }).click(searchHistory);
    $("#winClose").linkbutton({ iconCls: 'icon-undo', plain: true }).click(function () { initWin("close"); });

    $("#DateBegin").datebox();
    $("#DateEnd").datebox();
    $("#winDateBegin").datebox();
    $("#winDateEnd").datebox();

    $("#winStatus").combobox({
        valueField: 'label',
        textField: 'value',
        panelHeight: 80,
        data: [{ label: '已确认', value: '已确认' }, { label: '已驳回', value: '已驳回' }, { label: '', value: '全部' }]
    });
}
function initWin() {
    $("#win").window({
        title: "历史数据查询",
        collapsible: false,
        minimizable: false,
        maximizable: false,
        closable: false,
        resizable: false,
        modal: true,
        maximized: true
    });

    if (arguments[0] == "open") {

        XMLData = GetGetJson([], "GetHistory");
        initWinGrid(XMLData);
        $("#win").window("open");

    } else {
        $("#win").window("close");
        cleanFilter();
    }
}

function cleanFilter() {
    $("#formWin input[name!=txtStatus]").val("");
}

function searchOrder() {
    var data = $("#formSearch").serializeArray();

    var length = data[1].value.length + data[2].value.length;

    switch (length) {
        case 0:
            break;
        case 20:
            break;
        default:
            $.messager.alert("提示", "日期选择不完整", "warning");
            return;
    };

    var XMLData = GetFormJson(data, "SearchOrder");

    initGrid(XMLData);
}

function searchHistory() {
    var data = $("#formWin").serializeArray();

    var length = data[1].value.length + data[2].value.length;

    switch (length) {
        case 0:
            break;
        case 20:
            break;
        default:
            $.messager.alert("提示", "日期选择不完整", "warning");
            return;
    };

    var XMLData = GetFormJson(data, "SearchHistory");

    XMLData = escape(XMLData);
    XMLData = XMLData.replace(/%3C/g, "<").replace(/%3E/g, ">");

    initWinGrid(XMLData);

}

function sumbitOrder(type) {
    var data = $("#tab_list").datagrid("getChecked");
    var dataLength = data.length;

    //检验是否选择数据
    if (dataLength == 0) {
        $.messager.alert("提示", "请勾选要确认的行", "warning");
        return;
    };
    if (data[0]["employeeno"] == "") {
        $.messager.alert("提示", "无效数据行.", "warning");
        return;
    };

    if (type == "AllowOrder") {
        XMLData = GetEditJsonbyType(data, "AllowOrder");
    } else {
        XMLData = GetEditJsonbyType(data, "Overrule");
    };
    XMLData = escape(XMLData);
    XMLData = XMLData.replace(/%3C/g, "<").replace(/%3E/g, ">");
    //提交
    sumbit(XMLData);
}

function sumbit(XMLData) {
    $.messager.confirm('提示框', '是否确认提交', function (r) {
        if (r) {
            var url = GetWSRRURL('d4f5bfc9-1167-4a19-bc32-960edd4e45d7');
            $.post(url + "&XML=" + XMLData, function (result) {
                try {
                    var result = eval("[" + result + "]");
                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    }
                    else if (result[0].rows[0].result == "False") {
                        var errormessage = result[0].rows[1].message;

                        $.messager.progress('close');

                        alert(result[0].rows[0].message);
                    }
                    else {
                        $.messager.progress('close');
                        $.messager.alert("提示", result[0].rows[0].message, "ok");
                        //initWin("close");
                        $("#tab_list").datagrid("reload");
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                };
            });
        };
    });
}