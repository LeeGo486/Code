/// JS名：Shop_CustomerFeedback.js
/// 说明：3S反馈查询
/// 创建人：郭琦琦 
/// 创建日期：2014-09-01

var m_Firstdate = ""//当前时间

//初始化
$(function () {

    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });//初始化查询按钮
    //初始化时间
    $('#txtbegindate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });

    $('#txtenddate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });
    

    getFirstFormatDate();//取时间
    $('#txtbegindate').datebox("setValue", m_Firstdate);//默认今天时间
    $('#txtenddate').datebox("setValue", m_Firstdate);//默认今天时间
})

//取当天时间
function getFirstFormatDate() {
    var nowDate = new Date();
    m_Firstdate = nowDate.DateAdd('y', 0).format("yyyy-MM-dd");//当前时间+1年 减一天就是今年最后一天
}

//查询
function btnSearch() {
    var selectFirstDate = $('#txtbegindate').datebox("getValue");//取时间
    var selectEndDate = $('#txtenddate').datebox("getValue");//取时间

    ClearGrid("#customerFeedbacklist");

    //传参数到后台
    var data = [];
    data[data.length] = { "name": "txtbegindate", "value": selectFirstDate };
    data[data.length] = { "name": "txtenddate", "value": selectEndDate };
    //取3S反馈信息
    var urlGetShopCustomerFeedback = GetWSRRURL('6dce7c89-b2e6-4135-a3f1-e9b1476861cd') + "&XML=" + GetFormJson(data, 'GetShopCustomerFeedback');
    initGridGetShopCustomerFeedback(urlGetShopCustomerFeedback);
}

//取3S反馈信息
function initGridGetShopCustomerFeedback(url) {
    $('#customerFeedbacklist').datagrid(
        {
            title: '3S顾客反馈信息', //表格标题
            url: url,
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: false, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            pagination: true, //是否开启分页
            //pageList: [1,10000],
            pageSize: 20, //默认一页数据条数
            columns: [[
                { field: '大区', title: '大区', width: 80 },
                { field: '店铺', title: '店铺', width: 140 },
                { field: '客户经理', title: '客户经理', width: 60 },
                { field: '职业', title: '职业', width: 60 },
                { field: '年龄', title: '年龄', width: 40, align: 'right' },
                { field: '手机号', title: '手机号', width: 100 },
                { field: '过去12月份消费金额', title: '过去12月份消费金额', width: 120, align: 'right', formatter: Formater.Account },
                { field: '大类', title: '大类', width: 50 },
                { field: '小类', title: '小类', width: 80 },
                { field: '体型', title: '体型', width: 50 },
                { field: '身高', title: '身高', width: 100 },
                { field: '款号', title: '款号', width: 100 },
                { field: '系列', title: '系列', width: 50 },
                { field: '需求反馈', title: '需求反馈', width: 300 }
            ]]
        });
}