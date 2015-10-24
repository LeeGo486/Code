// 名称：Analyse4.js
// 创建人：郭琦琦
// 创建日期：2014-07-04
// 修改人：
// 修改日期：
// 修改内容：

var dq;//大区
var deptname; //店铺名称
var authorization_name; //实体
var jsid; //角色ID
var newtype;//新客户类型
var isorno;//是否完成
var time1;//发展日期1
var time2;//发展日期2

$(function () {
    dq = getQueryString("dq");
    deptname = getQueryString("deptname");
    authorization_name = getQueryString("authorization_name");
    jsid = getQueryString("jsid");
    newtype = getQueryString("newtype");
    isorno = getQueryString("isorno");
    time1 = getQueryString("time1");
    time2 = getQueryString("time2");
    initGird();
});

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}


function initGird() {
    var data = [];
    data[data.length] = { "name": "txt操作类型", "value": "GET" };
    data[data.length] = { "name": "txt实体", "value": authorization_name };
    data[data.length] = { "name": "txt类型", "value": "明细" };
    data[data.length] = { "name": "txt角色ID", "value": jsid };
    data[data.length] = { "name": "txt分公司", "value": dq };
    data[data.length] = { "name": "txt店铺名称", "value": deptname };
    data[data.length] = { "name": "txt新客户类型", "value": newtype };
    data[data.length] = { "name": "txt是否完成", "value": isorno };
    data[data.length] = { "name": "txt发展日期1", "value": time1 };
    data[data.length] = { "name": "txt发展日期2", "value": time2 };
    data[data.length] = { "name": "txt每页行数", "value": "20" };
    data[data.length] = { "name": "txt页数", "value": "1" };

    var xmlData = GetDBFrameAML(data);//组成调用APIxml
    var url = GetWSRRURL('32ac2b8e-528a-419e-b1cc-89371f2e884a') + xmlData
    $('#Analyse4_List').datagrid(
        {
            url: url,
            async: false,
            //sortName: 'po1_pocode', //排序字段
            //idField: 'dyyyno', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 100, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            //sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,//自适应
            pagination: true, //是否开启分页
            pageSize: 20, //默认一页数据条数 
            rownumbers: true,//行号
            columns: [[
                { field: 'companyname', title: '分公司', width: 100 },
                { field: 'deptname', title: '店铺名称', width: 150 },
                { field: 'customermanager', title: '客户经理', width: 100 },
                { field: 'name', title: '姓名', width: 100 },
                { field: 'vipcard', title: 'VIP卡号', width: 100 },
                { field: 'birthday', title: '出生日期', width: 100, formatter: Formater.Date },
                { field: 'seekdate', title: '发展日期', width: 100, formatter: Formater.Date },
                { field: 'recentconsumptiondate', title: '反馈日期', width: 100, formatter: Formater.Date },
                { field: 'result', title: '3天售后回访', width: 140 },
                //{ field: 'dicp_id_result', title: '反馈结果', width: 100 },
                //{ field: 'feedback', title: '有价值信息', width: 100 }
            ]],
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && data.rows[0].companyname == "") {
                    ClearGrid("#Analyse4_List");
                };
                if (data.rows == null || data.rows.length == 0) {
                    data.total = 0;
                }
                else {
                    data.total = data.rows[0].count_num;
                }
            }
        });
}