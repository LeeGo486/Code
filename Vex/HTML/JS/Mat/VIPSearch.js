/// JS名：VipSearch.js
/// 说明：VIP查询
/// 创建人：郭琦琦 
/// 创建日期：2014-06-26

var m_Enddate = "";//今年最后一天
var m_Firstdate = ""//今年第一天

//初始化
$(function () {

    $('#btnSearch').linkbutton({ iconCls: 'icon-search', plain: true });//初始化查询按钮
    //初始化开始时间
    $('#txtbegindate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });

    //初始化结束时间
    $('#txtenddate').datebox({
        valueField: 'id',
        textField: 'text',
        panelHeight: 'auto',
        editable: false,
        formatter: function (date) { return date.format("yyyy-MM-dd"); }
    });

    getFirstFormatDate();//取时间
    $('#txtbegindate').datebox("setValue", m_Firstdate);//默认今年时间
    $('#txtenddate').datebox("setValue", m_Enddate);//默认今年时间
})

//取本年第一天和本年最后一天时间
function getFirstFormatDate() {
    var nowDate = new Date();
    nowDate = new Date(nowDate.getFullYear() + "/" + "01" + "/" + "01");
    m_Firstdate = nowDate.DateAdd('y', 0).format("yyyy-MM-dd");//当前时间+1年 减一天就是今年最后一天
    //m_Enddate = nowDate.DateAdd('y', +1).format("yyyy-MM-dd");//当前时间-1年 加一天就是今年第一天
    m_Enddate = "2018-12-31";
}

//查询
function btnSearch() {
    var selectFirstDate = $('#txtbegindate').datebox("getValue");//取时间
    var selectEndDate = $('#txtenddate').datebox("getValue");//取时间
    var selectVipCode = $('#txtvipcode').val();//取VipCode

    //如果卡号不存在不给查询
    if (selectVipCode == "" || selectVipCode == undefined) {
        alert('请输入VIP卡号');
        return;
    }

    //清除3个表数据
    ClearGrid("#viplist");
    ClearGrid("#detaillist");
    ClearGrid("#vipcentumlist");

    //传参数到后台
    var data = [];
    data[data.length] = { "name": "txtbegindate", "value": selectFirstDate };
    data[data.length] = { "name": "txtenddate", "value": selectEndDate };
    data[data.length] = { "name": "txtvipcode", "value": selectVipCode };

    //取顾客信息
    var urlGetVIPUSER = GetWSRRURL('330cb5f0-8f41-474a-8a09-84a5128dc00e') + "&XML=" + GetFormJson(data, 'GetVIPUSER');
    initGridGetVIPUSER(urlGetVIPUSER);

    //取顾客交易历史
    var urlGetDRETAIL = GetWSRRURL('330cb5f0-8f41-474a-8a09-84a5128dc00e') + "&XML=" + GetFormJson(data, 'GetDRETAIL');
    initGridGetDRETAIL(urlGetDRETAIL);

    //取积分变化
    var urlGetVIPJFCHANG = GetWSRRURL('330cb5f0-8f41-474a-8a09-84a5128dc00e') + "&XML=" + GetFormJson(data, 'GetVIPJFCHANG');
    initGridGetVIPJFCHANG(urlGetVIPJFCHANG);

    ////AJAX调取积分数据,前台汇总,计算
    //$.ajax({
    //    url: urlGetDRETAIL,
    //    options: "JSON",
    //    type: "POST",
    //    success: function (data1) {
    //        if (eval("[" + data1 + "]")[0].Error) {
    //            $.messager.alert("出错了", eval("[" + data1 + "]")[0].Error, 'error');
    //            return;
    //        }
    //        //把取过来的值,进行转化为JOSN,
    //        data1 = eval("(" + data1 + ")");
    //        var sumNumber = "";//定义一个数量求和
    //        var sumMoney = "";//结算金额求和
    //        var sumJF = "";//积分求和
    //        var sumSXJF = "";//实销金额求和

    //        //循环数量和结算金额累加
    //        for (var i = 0; i < data1.total; i++) {
    //            sumNumber = sumNumber * 1 + data1.rows[i]["数量"] * 1;
    //            sumMoney = sumMoney * 1 + data1.rows[i]["结算金额"] * 1;
    //            sumJF = sumJF * 1 + data1.rows[i]["积分"] * 1;
    //            sumSXJF = sumSXJF * 1 + data1.rows[i]["实销金额"] * 1;
    //        }
    //        //C重组JOSN.添加FOOTER
    //        var footer = [{ "款号": "<font color='red' size='2'>合计</font>", "数量": sumNumber, "结算金额": sumMoney, "积分": sumJF, "实销金额": sumSXJF }];
    //        data1.footer = footer;
    //        //加载历史的表头
    //        initGridGetDRETAIL(urlGetDRETAIL);
    //        //重加载数据
    //        $('#detaillist').datagrid('loadData', data1)
    //    }
    //});

    ////AJAX调取积分变化,前台汇总,计算
    //$.ajax({
    //    url: urlGetVIPJFCHANG,
    //    options: "JSON",
    //    type: "POST",
    //    success: function (data2) {
    //        if (eval("[" + data2 + "]")[0].Error) {
    //            $.messager.alert("出错了", eval("[" + data2 + "]")[0].Error, 'error');
    //            return;
    //        }
    //        //把取过来的值,进行转化为JOSN,
    //        data2 = eval("(" + data2 + ")");
    //        var sumJFChange = "";//定义一个积分调整

    //        //循环数量和结算金额累加
    //        for (var i = 0; i < data2.total; i++) {
    //            sumJFChange = sumJFChange * 1 + data2.rows[i]["调整积分"] * 1;
    //        }
    //        //C重组JOSN.添加FOOTER
    //        var footer = [{ "调整日期": "<font color='red' size='2'>合计</font>", "调整积分": sumJFChange }];
    //        data2.footer = footer;
    //        //加载历史的表头
    //        initGridGetVIPJFCHANG(urlGetVIPJFCHANG);
    //        //重加载数据
    //        $('#vipcentumlist').datagrid('loadData', data2)
    //    }
    //});
}

//查询客户资料
function initGridGetVIPUSER(url) {
    $('#viplist').datagrid(
        {
            title: '客户资料', //表格标题
            url: url,
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            //remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            columns: [[
                { field: '姓名', title: '姓名', width: 60 },
                { field: '性别', title: '性别', width: 60 },
                { field: '出生日期', title: '出生日期', width: 80, align: 'right', formatter: Formater.Date },
                { field: 'vip状态', title: 'vip状态', width: 60 },
                { field: '总积分', title: '总积分', width: 60, align: 'right', formatter: Formater.Account },
                { field: '总储值', title: '总储值', width: 80, align: 'right', formatter: Formater.Account },
                { field: '固定电话', title: '固定电话', width: 100, align: 'right' },
                { field: '移动电话', title: '移动电话', width: 100, align: 'right' },
                { field: '职业', title: '职业', width: 100 },
                { field: '籍贯', title: '籍贯', width: 60 },
                { field: '所在区域', title: '所在区域', width: 100 },
                { field: '通讯地址', title: '通讯地址', width: 100 },
                { field: '拓展人', title: '拓展人', width: 100 }
            ]]
        });
}

//消费明细
function initGridGetDRETAIL(url) {
    $('#detaillist').datagrid(
        {
            title: '消费明细', //表格标题
            url: url,
            //sortNames: 'setdate', //排序字段
            //idField: 'billid', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            rownumbers: true,
            showFooter: true,
            columns: [[
                { field: '零售单号', title: '零售单号', width: 160 },
                { field: 'vip卡号', title: 'vip卡号', width: 70 },
                { field: '店铺编号', title: '店铺编号', width: 70 },
                { field: '店铺名称', title: '店铺名称', width: 90 },
                { field: '销售日期', title: '销售日期', width: 80, align: 'right', formatter: Formater.Date },
                { field: '款号', title: '款号', width: 100 },
                { field: '现价', title: '现价', width: 70, align: 'right', formatter: Formater.Account },
                { field: '折扣', title: '折扣', width: 40, align: 'right', formatter: Formater.Account },
                { field: '数量', title: '数量', width: 35, align: 'right', align: 'right', formatter: Formater.Num },
                { field: '结算价', title: '结算价', width: 70, align: 'right', formatter: Formater.Account },
                { field: '结算金额', title: '结算金额', width: 70, align: 'right', formatter: Formater.Account },
                { field: '实销金额', title: '实销金额', width: 70, align: 'right', formatter: Formater.Account },
                { field: '积分', title: '积分', width: 70, align: 'right', formatter: Formater.Num },
                { field: '实销折扣', title: '实销折扣', width: 70, align: 'right', formatter: Formater.Account }
            ]],
            onLoadSuccess: function () {
                var data = $('#detaillist').datagrid("getData");
                //data = eval("(" + data + ")");
                var sumNumber = "";//定义一个数量求和
                var sumMoney = "";//结算金额求和
                var sumJF = "";//积分求和
                var sumSXJF = "";//实销金额求和

                //循环数量和结算金额累加
                for (var i = 0; i < data.rows.length; i++) {
                    sumNumber = sumNumber * 1 + data.rows[i]["数量"] * 1;
                    sumMoney = sumMoney * 1 + data.rows[i]["结算金额"] * 1;
                    sumJF = sumJF * 1 + data.rows[i]["积分"] * 1;
                    sumSXJF = sumSXJF * 1 + data.rows[i]["实销金额"] * 1;
                }
                //C重组JOSN.添加FOOTER
                var footer = [{ "款号": "<font color='red' size='2'>合计</font>", "数量": sumNumber, "结算金额": sumMoney, "积分": sumJF, "实销金额": sumSXJF }];
                //data.footer = footer;
                //重加载数据
                $('#detaillist').datagrid('reloadFooter', footer)
            }
        });
}

//积分变动记录
function initGridGetVIPJFCHANG(url) {
    $('#vipcentumlist').datagrid(
        {
            title: '积分变动记录', //表格标题
            url: url,
            //sortNames: '调整日期', //排序字段
            //idField: 'billid', //标识字段,主键
            width: '90%', //宽度
            height: $(document).height() - 20, //高度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: true, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            //sortOrder: 'DESC', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            singleSelect: true, //单行选择
            fit: true,
            //pagination: true, //是否开启分页
            //pageSize: 20, //默认一页数据条数 
            showFooter: true,
            columns: [[
                { field: '调整日期', title: '调整日期', width: 80, align: 'right' },
                { field: '调整积分', title: '调整积分', width: 70, align: 'right', formatter: Formater.Account },
                { field: '调整储值', title: '调整储值', width: 70, align: 'right', formatter: Formater.Account },
                { field: '说明', title: '说明', width: 200 }
            ]],
            onLoadSuccess: function () {
                var data2 = $('#vipcentumlist').datagrid("getData");
                //data2 = eval("(" + data2 + ")");
                var sumJFChange = "";//定义一个积分调整

                //循环数量和结算金额累加
                for (var i = 0; i < data2.rows.length; i++) {
                    sumJFChange = sumJFChange * 1 + data2.rows[i]["调整积分"] * 1;
                }
                //C重组JOSN.添加FOOTER
                var footer = [{ "调整日期": "<font color='red' size='2'>合计</font>", "调整积分": sumJFChange }];
                //data2.footer = footer;
                //重加载数据
                $('#vipcentumlist').datagrid('reloadFooter', footer);
            }
        });
}