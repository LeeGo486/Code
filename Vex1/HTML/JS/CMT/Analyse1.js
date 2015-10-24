// 名称：Analyse1.js
// 说明：对MainHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-07-04
// 修改人：
// 修改日期：
// 修改内容：1e658718-4466-4cf9-99d9-f2f7e88b9aec


//任务ID

var url = document.location.search;

url = $.trim(url);
/^\?id=([^&]*)/.test(url);
var m_JobID = RegExp.$1;    //任务ID

/&depotid=(.*)/.test(url);
var m_DepotID = RegExp.$1;  //店铺编号

$(document).ready(function () {
    //初始化
    initGird();
});

////初始化initGird
function initGird() {
    var data = [];
    data[data.length] = { "name": "txtID", "value": m_JobID };
    //店铺编号
    data[data.length] = { "name": "txtDepotId", "value": m_DepotID };
    if (m_DepotID == "") {
        XMLData = GetFormJson(data, 'AnalyseGet1');
    } else {
        XMLData = GetFormJson(data, 'AnGet2ToAnGet1');
    }

    $('#Analyse1_List').datagrid({
        url: GetWSRRURL('1e658718-4466-4cf9-99d9-f2f7e88b9aec'),
        queryParams: { "XML": XMLData },
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'submittime',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'companyname', title: '公司', width: 100 },
            { field: 'deptname', title: '店铺名称', width: 200, search: true },
            { field: 'customername', title: '客户姓名', width: 100 },
            { field: 'customermanager', title: '客户经理', width: 100 },
            { field: 'mobilenum', title: '手机号码', width: 100 },
            { field: 'vipcard', title: 'VIP卡号', width: 80 },
            { field: 'birthday', title: '客户生日', width: 80 },
            { field: 'status', title: '是否沟通', width: 60 },
            { field: 'submittime', title: '沟通时间', width: 100 },
            { field: 'fruit', title: '预约结果', width: 60 },
            { field: 'invitationdate', title: '应邀时间', width: 80 },
            { field: 'reason', title: '拒绝原因', width: 80 },
            { field: 'recentconsumptiondate', title: '最近消费日期', width: 80 },
            { field: 'recentconsumptionamount', title: '最近消费金额', width: 80,algin:'right' }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 50 //默认一页数据条数
    });
};

