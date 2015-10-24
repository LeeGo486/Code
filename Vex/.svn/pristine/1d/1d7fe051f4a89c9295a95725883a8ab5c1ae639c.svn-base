// 名称：Analyse1.js
// 说明：对MainHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-07-04
// 修改人：
// 修改日期：
// 修改内容：1e658718-4466-4cf9-99d9-f2f7e88b9aec


//任务ID

var url = document.location.search;
var firstDay;
var lastDay;
url = $.trim(url);
var m_JobID = url.substring(4);

$(document).ready(function () {
    //日期格式化
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + m + '-' + d;
    };

    //初始化控件
    $('#begin').datebox();
    $('#end').datebox();
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });

    //获取本月日期范围
    firstDay = "";
    lastDay = "";

    //初始化数据表
    var data = [];
    data[data.length] = { "name": "txtID", "value": m_JobID };
    data[data.length] = { "name": "txtBegin", "value": firstDay };
    data[data.length] = { "name": "txtEnd", "value": lastDay };
    initGird(data);
});

//初始化initGird
function initGird(data) {

    XMLData = GetFormJson(data,'AnalyseGet2');

    $('#Analyse2_List').datagrid({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        queryParams: { "XML": XMLData },
        width: '90%',
        singleSelect: true,
        fit: true,
        //sortName: 'submittime',
        //sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'companyname', title: '公司', width: 100 },
            { field: 'deptname', title: '店铺名称', width: 200, search: true },
            { field: 'planum', title: '计划人数', width: 100 },
            { field: 'ok', title: '预约人数', width: 100 },
            { field: 'success', title: '应邀人数', width: 80 },
            { field: 'ratio', title: '应邀占比', width: 80 }
        ]],
        onDblClickRow: function (rowIndex, rowData) {
            var jobID = rowData.tk1_id;
            var depotID = rowData.depotid;
            window.open("Analyse1.HTML?id=" + jobID + "&depotid=" + depotID, target = '_blank')
        },
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 50 //默认一页数据条数
    });
};

//查询方法
function btnSearch() {
    var data = $('#fSearch').serializeArray();
    //条件全空
    if (data[0].value == "" && data[1].value == "" ) {
        alert("请输入查询条件");
        return;
    };

    //日期区间不完整
    if ((data[0].value != "" && data[1].value == "") || (data[0].value == "" && data[1].value != "")) {
        alert("请将日期区间选择完整");
        return;
    };
    data[data.length] = { "name": "txtID", "value": m_JobID };
    initGird(data);
};

