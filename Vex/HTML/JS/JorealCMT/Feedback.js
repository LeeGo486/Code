﻿// 名称：Feedback.js
// 说明：对FeedbackHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2015-05-12
// 修改人：
// 修改日期：
// 修改内容：bd09e2d8-cbf8-4e9b-9c23-f5bfeb4acd7f

//用户ID
var m_UserId = undefined;
//客户ID
var m_CustomerCode;
//预约类型
var m_Type;
//反馈情况
var m_FBFruit;
//店铺编号
var m_DepotName;

$(document).ready(function () {
    //日期格式化
    $.fn.datebox.defaults.formatter = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + m + '-' + d;
    };
    //查询按钮
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    ////开始结束时间
    $('#txtStartTime').datebox({ editable: false });
    $('#txtEndTime').datebox({ editable: false });

    XMLData = GetGetJson([], 'GetTask');
    initGird(XMLData);
});

//初始化Datagrid
function initGird(XMLData) {

    $('#contact_list').datagrid({
        url: GetWSRRURL('bd09e2d8-cbf8-4e9b-9c23-f5bfeb4acd7f'),
        queryParams: { "XML": XMLData },
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'reservationdate',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'name', title: '活动名称', width: 75 },
            { field: 'reservationdate', title: '预约时间', width: 75 },
            { field: 'type', title: '预约类型', width: 60 },
            { field: 'customermanager', title: '客户经理', width: 70 },
            { field: 'customer', title: '客户姓名', width: 60, sortable: true },
            { field: 'mobilenum', title: '手机号码', width: 80, search: true },
            { field: 'birthday', title: '生日', width: 70 },
            { field: 'seekdate', title: '发展时间', width: 70 },
            { field: 'recentconsumptiondate', title: '最近消费日期', width: 70 },
            { field: '', title: '预约结果', width: 80 },
            { field: '', title: '应邀时间', width: 80 },
            { field: '', title: '是否有价值', width: 80 },
            { field: '', title: '维护反馈', width: 80 },
            { field: '', title: '拒绝原因', width: 80 },
            { field: '', title: '再次预约时间', width: 80 }
        ]],
        pagination: true, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 15, //默认一页数据条数
        onClickRow: function (rowIndex, rowData) {
            //客户id
            m_CustomerCode = rowData.code;
            //活动类型
            m_Type = rowData.type
            //客户资料
            customer(rowData);
        }
    });
};

//客户资料
function customer(rowData) {
    //客户姓名
    $('#Name').val(rowData.customer);
    //出生年月
    $('#Birthday').val(rowData.birthday);
    //客户年龄
    $('#Age').val(rowData.age);
    //手机号码
    $('#MobileNum').val(rowData.mobilenum);
    //客户等级
    $('#Level').val(rowData.level);
    //发展日期
    $('#BuildDate').val(rowData.seekdate);
    //客户经理
    $('#CustomerManager').val(rowData.customermanager);
    //忠诚度特征
    $('#LoyaltyType').val(rowData.loyaltytype);
    //VIP卡号
    $('#VIPCard').val(rowData.vipcard);
    //POS积分
    $('#Point').val(rowData.points);
    //最近消费金额
    $('#RecentConsumptionAmount').val(rowData.recentconsumptionamount);
    //最近消费日期
    $('#RecentConsumptionDate').val(rowData.recentconsumptiondate);
    //今年消费金额
    $('#ThisYearConsumptionAmount').val(rowData.thisyearconsumptionamount);
    //去年消费金额
    $('#LastYearConsumpitonAmount').val(rowData.lastyearconsumpitonamount);
    //12个月以内消费金额
    $('#TwelveMonthsConsumptionAmount').val(rowData.twelvemonthsconsumptionamount);
    //12个月内消费次数
    $('#TwelveMonthsConsumptionNum').val(rowData.twelvemonthsconsumptionnum);
    //总消费金额
    $('#TotalAmount').val(rowData.totalamount);
    //总消费次数
    $('#TotalNum').val(rowData.totalnum);

};


//查询按钮
function btnSearch() {
    var data = $('#fSearch').serializeArray();
    if ((data[0].value == "" && data[1].value != "") && (data[0].value != "" && data[1].value == "")) {
        alert("日期请选择完整");
        return;
    };
    XMLData = GetFormJson(data, 'Search');
    initGird(XMLData);
};