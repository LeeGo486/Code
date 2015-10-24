var sessionID = undefined;
$(function () {

    $("#txtInputXML").select();
    //$.cookie('WSRRTestTool', null, { path: "/", expires: 365 * 10 });

    if ($.cookie('WSRRTestTool')) {
        sessionID = $.cookie('WSRRTestTool');
    }
    else {
        var url = "/SdkHandler.ashx?type=getnewid&r=" + Math.random();

        $.ajax({
            url: url,
            type: 'post',
            async: false,
            success: function (result) {
                sessionID = result;
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }

    $.cookie('WSRRTestTool', sessionID, { path: "/", expires: 365 * 10 });
    initGrid();
    initGirdDefault();
})
//格式化xml
function formatXML(str) {
    //去除输入框中xmll两端的空格。 
    str = str.replace(/^\s+|\s+$/g, "");
    var source = new ActiveXObject("Msxml2.DOMDocument");
    //装载数据 
    source.async = false;
    source.loadXML(str);
    // 装载样式单 
    var stylesheet = new ActiveXObject("Msxml2.DOMDocument");
    stylesheet.async = false;
    stylesheet.resolveExternals = false;
    
    stylesheet.load("/styles/format.xsl");

    // 创建结果对象 
    var result = new ActiveXObject("Msxml2.DOMDocument");
    result.async = false;

    // 把解析结果放到结果对象中方法1 
    source.transformNodeToObject(stylesheet, result);
    //alert(result.xml);
    if (result.xml == '' || result.xml == null) {
        return str;
    }
    var finalStr = result.xml;
    return finalStr;
}


function initGirdDefault() {
    var xmlData = GetFormJson([], 'GetWSRRDemo');
    $('#tabDemo').datagrid(
    {

        url: GetWSRRURL('41e9dd89-8323-48cb-b03f-770846db4d0b'),
        queryParams: { "XML": xmlData },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        columns: [[
            { field: 'wsname', title: 'WS名称', width: 200, search: true, formatter: Formater.time },
            //{ field: 'xmlinput', title: '服务地址', width: 200, search: true, sortable: true },
            //{ field: 'result', title: '路由代码', width: 60, search: true, sortable: true },
            //{ field: 'end_time', title: '路由类型', width: 60, sortable: true },
            //{ field: 'ms', title: '效率(MS)', width: 80, sortable: true },
            { field: 'ws_id', title: 'WSID', width: 260, sortable: true }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true, //行号

        onClickRow: function (rowIndex, rowData) { clickRowGrid(rowIndex, rowData); }
    }
    );
}

function initGrid() {
    $('#tabHis').datagrid(
    {

        url: GetWSRRURL('41e9dd89-8323-48cb-b03f-770846db4d0b'),
        queryParams: { "XML": GetGetJson([{ "ClientID": sessionID }]) },
        nowrap: false, //是否换行，True 就会把数据显示在一行里
        striped: true, //True 奇偶行使用不同背景色
        remoteSort: true, //定义是否从服务器给数据排序
        fit: true,
        singleSelect: true, //单行选择
        sortName: "log_time",
        sortOrder: "desc",
        columns: [[
            { field: 'dev', title: '执行环境', width: 100, search: true, formatter: Formater.time },
            { field: 'log_time', title: '执行时间', width: 150, search: true, formatter: Formater.time },
            //{ field: 'xmlinput', title: '服务地址', width: 200, search: true, sortable: true },
            //{ field: 'result', title: '路由代码', width: 60, search: true, sortable: true },
            //{ field: 'end_time', title: '路由类型', width: 60, sortable: true },
            { field: 'ms', title: '效率(MS)', width: 80, sortable: true },
            { field: 'ws_id', title: 'WSID', width: 260, sortable: true }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 20, //默认一页数据条数
        rownumbers: true, //行号
        onLoadSuccess: function (data) {
            if (data.total == 0) {
                $("#mainTabs").tabs("select", 1)
            }
        },
        onClickRow: function (rowIndex, rowData) { clickRowGrid(rowIndex, rowData); }
    }
    );

}
function clickRowGrid(rowIndex, rowData) {
    $("#txtInputXML").val(formatXML(rowData.xmlinput));
    $("#txtResult").val(formatXML(rowData.result));
}
function executeWSRR() {
    $.messager.progress({ title: '正在执行', msg: '执行中' });

    var url = "/SdkHandler.ashx?type=callbyxml&clientid=" + sessionID + "&r=" + Math.random();
    var data = new Object();
    data.dev = "dev";

    var xml = $("#txtInputXML").val();

    data.xml = xml;

    if (xml == undefined || xml.trim() == "" || xml.trim() == "请输入XML") {
        $.messager.alert("提示", "InputXML不能为空！", 'error');
        $("#txtInputXML").focus();
        $("#txtInputXML").select();
        return;
    }

    $.ajax({
        url: url,
        type: 'post',
        async: true, //异步,
        data: data,
        success: function (result) {
            $.messager.progress('close');

            try {
                $("#txtResult").val(result);
                initGrid();
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.progress('close');

            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });

}

function format() {
    $("#txtInputXML").val(formatXML($("#txtInputXML").val()));
}