// 名称：Feedback.js
// 说明：对FeedbackHTML进行各种前台控制
// 创建人：刘洪
// 创建日期：2014-07-10
// 修改人：
// 修改日期：
// 修改内容：0521749f-0483-4f86-9f0b-9c402140ffd3

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
    //获取用户ID
    htmlobj = $.ajax({
        url: GetWSRRURL('LoginName'),
        options: "JSON",
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    if (result.UserName != "") {
        m_UserId = result.UserName;
    };

    //获取店铺编号
    XMLData = GetFormJson([], 'Verification');
    htmlobj = $.ajax({
        url: GetWSRRURL('e6d23a54-38a6-474e-ad06-82c78fadd5e0'),
        data: { "XML": XMLData, "WHERE": "userid='" + m_UserId + "'" },
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);
    m_DepotName = result.rows[0].depotid; //从GP的表中获取店铺名,这样最为准确
    //预约结果
    $('#comFruit').combobox({ required: true, panelHeight: 'auto', editable: false });
    //应邀日期
    $('#datInvitationDate').datebox({ editable: false });
    //拒绝原因
    $('#comReason').combobox({ panelHeight: 'auto', editable: false });
    //再次预约时间
    $('#datReservationDateAgain').datebox({ editable: false });
    //提交按钮
    $('#btnSubmit').linkbutton({ iconCls: 'icon-save', plain: true });
    //查询按钮
    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });
    //开始结束时间
    $('#txtStartTime').datebox();
    $('#txtEndTime').datebox();

    //隐藏
    $('#InvitationDate').hide();
    $('#Reason').hide();
    $('#ReservationDateAgain').hide();
    $('#Submit').hide();
    $('#ValueInformation').hide();
    $('#Feedback').hide();
    $('#button').hide();

    //初始化Dg
    var data = [];
    data[data.length] = { "name": "txtDepotid", "value": m_DepotName };
    XMLData = GetFormJson(data, 'Get');
    initGird(XMLData);
});

//初始化Datagrid
function initGird(XMLData) {

    $('#contact_list').datagrid({
        url: GetWSRRURL('0521749f-0483-4f86-9f0b-9c402140ffd3'),
        queryParams: { "XML": XMLData },
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'reservationdate',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'name', title: '活动名称', width: 75},
            { field: 'reservationdate', title: '预约时间', width: 75 },
            { field: 'type', title: '预约类型', width: 60 },
            { field: 'customermanager', title: '客户经理', width: 70 },
            { field: 'customer', title: '客户姓名', width: 60, sortable:true },
            { field: 'mobilenum', title: '手机号码', width: 80, search: true },
            { field: 'birthday', title: '生日', width: 70 },
            { field: 'seekdate', title: '发展时间', width: 70 },
            { field: 'recentconsumptiondate', title: '最近消费日期', width: 70 },
            { field: '', title: '预约结果', width: 80 },
            { field: '', title: '应邀时间', width: 80 },
            { field: '',title: '是否有价值', width: 80 },
            { field: '',title: '维护反馈', width: 80 },
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
            //预约下拉
            fruitCombobox(m_Type);
            //隐藏
            $('#InvitationDate').hide();
            $('#Reason').hide();
            $('#ReservationDateAgain').hide();
            $('#Submit').hide();
            $('#ValueInformation').hide();
            $('#Feedback').hide();
            $('#button').hide();
            //历史记录
            history(rowData);
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

//预约结果下拉框
function fruitCombobox(type) {
    var data = [];
    if (type == "销售预约") {
        data[data.length] = { "name": "txtType", "value": "销售反馈" };
    } else if (type == "活动预约") {
        data[data.length] = { "name": "txtType", "value": "销售反馈" };
    } else if (type == "客户关怀") {
        data[data.length] = { "name": "txtType", "value": "关怀反馈" };
    } else if (type == "生日预约") {
        data[data.length] = { "name": "txtType", "value": "销售反馈" };
};

    XMLData = GetFormJson(data, 'GetFruit');
    XMLData = escape(XMLData);

    //预约结果下拉
    $('#comFruit').combobox({
        url: GetComboxALLColumnWSRRURL('0521749f-0483-4f86-9f0b-9c402140ffd3', "", "ID", "Name") + "&XML=" + XMLData,
        required: true,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        onSelect: function (record) {
            m_FBFruit = record.text;
            //拒绝原因
            refuse(m_FBFruit);
            //反馈展示
            FeedbackMode(m_FBFruit);
        }
    });
};

//下拉后展现方式
function FeedbackMode(type) {
    if (m_Type == "客户关怀") {
        if (type == "接收关怀") {
            $('#ValueInformation').show(); $('#Feedback').show(); $('#button').show();

            $('#Reason').hide(); $('#ReservationDateAgain').hide(); $('#InvitationDate').hide();

            $('#ValueInformation').val();

            $('#datInvitationDate').datebox({ required: false, editable: false });
        } else if (type == "拒绝") {
            $('#ValueInformation').show(); $('#Feedback').show();

            $('#button').show(); $('#Reason').show();

            $('#ReservationDateAgain').hide(); $('#InvitationDate').hide();

            $('#ValueInformation').val();

            $('#datInvitationDate').datebox({ required: false, editable: false });

        } else if (type == "空号/号码已更换") {
            $('#ValueInformation').hide(); $('#Feedback').hide();
            $('#Reason').hide(); $('#ReservationDateAgain').hide(); $('#InvitationDate').hide(); $('#Reason').hide();

            $('#button').show();

        }else {
            $('#ReservationDateAgain').show(); $('#button').show();

            $('#ValueInformation').hide(); $('#Feedback').hide(); $('#Reason').hide(); $('#InvitationDate').hide();

            $('#ValueInformation').val();

            $('#datInvitationDate').datebox({ required: false, editable: false });
        }
    } else {
        if (type == "应邀") {
            //显示
            $('#InvitationDate').show(); $('#button').show();
            //隐藏
            $('#ValueInformation').hide(); $('#Feedback').hide(); $('#Reason').hide(); $('#ReservationDateAgain').hide();

            $('#datInvitationDate').datebox({ required: true, editable: false });
        } else if (type == "无应答") {
            //显示
            $('#ReservationDateAgain').show(); $('#button').show();
            //隐藏
            $('#ValueInformation').hide(); $('#Feedback').hide(); $('#Reason').hide(); $('#InvitationDate').hide();

            $('#datInvitationDate').datebox({ required: false, editable: false });
        } else if (type == "空号/号码已更换") {
            $('#ValueInformation').hide(); $('#Feedback').hide();
            $('#Reason').hide(); $('#ReservationDateAgain').hide(); $('#InvitationDate').hide(); $('#Reason').hide();

            $('#button').show();
        }
        else {
            //显示
            $('#ReservationDateAgain').show(); $('#button').show(); $('#Reason').show();
            //隐藏
            $('#ValueInformation').hide(); $('#Feedback').hide(); $('#InvitationDate').hide();

            $('#datInvitationDate').datebox({ required: false, editable: false });
        };
    };
};

//拒绝原因
function refuse(type) {
    var data = [];
    if (type == "拒绝") {
        data[data.length] = { "name": "txtType", "value": "拒绝原因" };
    } else if (type == "不确定") {
        data[data.length] = { "name": "txtType", "value": "拒绝原因" };
    } else {
        return;
    };

    XMLData = GetFormJson(data, 'Refuse');
    XMLData = escape(XMLData);

    //拒绝原因下拉
    $('#comReason').combobox({
        url: GetComboxALLColumnWSRRURL('0521749f-0483-4f86-9f0b-9c402140ffd3', "", "ID", "Name") + "&XML=" + XMLData,
        required: true,
        type: 'post',
        editable: false,
        valueField: 'id',
        textField: 'text',
        panelHeight: '80',
        onSelect: function (record) {
            if (record.text == "其他" && m_Type == "销售预约") {
                $('#Feedback').show();
            } else if (record.text != "其他" && m_Type == "销售预约") {
                $('#Feedback').hide();
            }
        }
    });

    //这里的类型有拒绝原因与不确定原因,后台只有拒绝原因 但是前台要考虑进去，这里还要 escape一下
};

//提交按钮
function btnSubmit() {
    if ($('#fFeedback').form('validate')) {
        var mainData = $('#contact_list').datagrid('getSelected');
        var data = $('#fFeedback').serializeArray();

        data[data.length] = { "name": "txtPreDate", "value":  mainData.predate};
        data[data.length] = { "name": "txtPostDate", "value": mainData.postdate };
        data[data.length] = { "name": "txtTask", "value": mainData.type };
        data[data.length] = { "name": "txtFruitName", "value": m_FBFruit };
        data[data.length] = { "name": "txtID", "value": mainData.id };


        XMLData = GetFormJson(data, 'Submit');
        $.ajax({
            url: GetWSRRURL('0521749f-0483-4f86-9f0b-9c402140ffd3'),
            type: 'post',
            async: false, //异步,
            data: { "XML": XMLData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        $('#contact_list').datagrid('reload');
                        $('#history_list').datagrid('reload');
                        //空号调用WSID
                        if (m_FBFruit == "空号/号码已更换") {

                            if (typeof (m_CustomerCode) != undefined) {
                                var data = [];
                                data[data.length] = { "name": "txt操作类型", "value": "UPDATE" };
                                data[data.length] = { "name": "txtCONO", "value": "HYFG" };
                                data[data.length] = { "name": "txtDIVI", "value": "D01" };
                                data[data.length] = { "name": "txt客户ID", "value": m_CustomerCode };

                                var XMLData = GetDBFrameAML(data);
                                //调API更新CRM，无需返回结果
                                $.ajax({
                                    url: GetWSRRURL('14c597ee-0d40-450c-a4d7-3ac075e753d2') + XMLData,
                                    type: 'post',
                                    async: true //异步
                                });
                            };
                        };

                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    };

};

//查看历史
function history(rowData) {
    data = [];
    data[data.length] = { "name": "txtDeportId", "value": m_DepotName };
    data[data.length] = { "name": "txtCUS1_ID", "value": rowData.cus1_id };

    XMLDataH = GetFormJson(data, 'History');

    $('#history_list').datagrid({
        url: GetWSRRURL('0521749f-0483-4f86-9f0b-9c402140ffd3'),
        queryParams: { "XML": XMLDataH },
        width: '90%',
        singleSelect: true,
        fit: true,
        sortName: 'submittime',
        sortOrder: 'desc',
        striped: true,
        columns: [[
            { field: 'submittime', title: '维护时间', width: 80, formatter: Formater.Date },
            { field: 'lmuser', title: '维护人', width: 65 },
            { field: 'jobname', title: '任务类型', width: 65 },
            { field: 'maintenancecontent', title: '维护内容', width: 500 }
        ]],
        pagination: false, //是否开启分页
        pageNumber: 1, //默认索引页
        pageSize: 5 //默认一页数据条数

    });
};

//查询按钮
function btnSearch() {
    var data = $('#fSearch').serializeArray();
    if (data[0].value == "" && data[1].value == "" && data[2].value == "" && data[3].value == "") {
        var data = [];
        data[data.length] = { "name": "txtDepotid", "value": m_DepotName };
        XMLData = GetFormJson(data, 'Get');
        initGird(XMLData);
        return;
    };
    if ((data[0].value == "" && data[1].value != "") && (data[0].value != "" && data[1].value == "")) {
        alert("日期请选择完整");
        return;
    };
    data[data.length] = { "name": "txtDepotid", "value": m_DepotName };
    XMLData = GetFormJson(data, 'GetSearch');
    initGird(XMLData);
};