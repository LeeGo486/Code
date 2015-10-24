//全局变量
var m_DatagridShareID = '#jlfplb'; //奖励分配列表ID
var m_DatagridUpdateID = '#dgjexglb'; //导购金额修改列表ID

//var m_PaginationShareID = '#sharepager';   //奖励分配分页ID
//var m_PaginationUpdateID = '#updatepager';   //导购金额修改分页ID

var m_dlgShareID = '#jlfpdlg';  //奖励分配明细对话框ID
var m_dlgUpdateID = '#dgjexgdlg';        //导购金额修改明细对话框ID
var m_dlgSelectID = '#shopempselect';   //导购选择
var m_DatagridShareSubID = '#jlfpmxlb';
var m_DatagridUpdateSubID = '#dgjexgmxlb';
var m_DatagridSelectID = '#shopemptable';   //导购选择

var m_LastIndex = -1;
var m_ShareLastIndex = -1;  //最后一次选中行下标 
var m_UpdateLastIndex = -1;  //最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

//用户信息
var m_UserInfo = parent.m_UserInfo;

//标记是否启用列的编辑
var m_Flag = true;      //true——可编辑，false——不可编辑

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_FilterAll = '';   //记录当前查询条件
var m_OrderBy = ''; //排序方式

//基础数据
var m_ShopAdminEmployee = []; //店长（班组销售）
var m_ShopEmployeeAll = []
//状态是否有效转换
var m_IsShare = [{ value: '0', text: '未分配' }, { value: '1', text: '已分配' }, { value: '', text: '全部' }];
var m_YearSelect = [{ value: '2015', text: '2015' }, { value: '2016', text: '2016' }, { value: '2017', text: '2017' }];
var m_MonthSelect = [{ value: '1', text: '1' }, { value: '2', text: '2' }, { value: '3', text: '3' },
                { value: '4', text: '4' }, { value: '5', text: '5' }, { value: '6', text: '6' },
                { value: '7', text: '7' }, { value: '8', text: '8' }, { value: '9', text: '9' },
                { value: '10', text: '10' }, { value: '11', text: '11' }, { value: '12', text: '12' }];
var m_IsUse = [{ value: '0', text: '否' }, { value: '1', text: '是' }];
var m_Year = '';
var m_Month = '';

var m_RetailID = '';    //销售单号
var m_RetailDate = '';    //销售时间
var m_RetailAamount = 0;   //实销金额
var m_RetailPamount = 0;   //计薪金额
var m_RetailSamount = 0;   //结算金额
var m_RetailXamount = 0;   //现价金额
var m_RetailYamount = 0;   //原价金额

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300, 50];


/***********************************************************************
 *  初始化
 *  SY 
 */
$(function () {
    // 滚动条居顶
    parent.sc();

    //用户认证
    if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
        top.location.href = 'error.html';
        return;
    }

    // 校验（每月一单）
    var curmonth = '2015-07';//dateUtil_getMonthByDay('', '-', '5').substring(0, 7);//新建月份
    m_Year = curmonth.substring(0, 4);
    //m_Month = curmonth.substring(5, 7)*1;
    m_Month = '7'; /***测试***/

    //设置当前下拉控件——月份
    setCombobox('#year', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_YearSelect);
    setCombobox('#month', m_widths[7], m_widths[7], m_widths[1], true, false, 'value', 'text', m_MonthSelect);

    //当修改月份时，则重新加载数据
    $('#month').combobox({
        onSelect: function (record) {
            m_Year = $('#year').combobox('getValue');
            m_Month = $('#month').combobox('getValue');
            actShareLoadData(m_PageNumber, m_PageSize);
            actUpdateLoadData(m_PageNumber, m_PageSize);
            var row = [];
            row[row.length] = { "name": "txtyear", "value": m_Year };
            row[row.length] = { "name": "txtmonth", "value": m_Month * 1 };
            row[row.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
            //判断是否能提交
            htmlobj = $.ajax({
                url: GetWSRRURL(peoa_GetWSRRURL(1003)) + "&MultiTable=true&XML=" + escape(GetFormJson(row, "CheckSubmit")),
                type: 'post',
                async: false
            });
            var res = $.parseJSON(htmlobj.responseText);
            if (res.Error) {
                alert(res.Error);
            } else {
                if (res[0].rows[0].typecount == '1' || res[1].rows[0].result.toLowerCase() == 'false') {
                    //表示已提交，即不可修改,或者不在提交时间内
                    m_Flag = false;
                    $('#btntj').hide();
                    $('#btnsaveshare').hide();
                    $('#btnshareemp').hide();
                    $('#btnshareavg').hide();
                    $('#btnsaveupdate').hide();
                    $('#btnupdateavg').hide();
                } else {
                    m_Flag = true;          //未提交，可修改
                    $('#btntj').show();
                    $('#btnsaveshare').show();
                    $('#btnshareemp').show();
                    $('#btnshareavg').show();
                    $('#btnsaveupdate').show();
                    $('#btnupdateavg').show();
                }
            }
        }
    });

    $('#year').combobox('setValue', m_Year);        //默认为当前年份和月份
    $('#month').combobox('setValue', m_Month * 1);

    //奖励分配
    //获取班组销售的店长
    var shopadminemp = [];
    shopadminemp[shopadminemp.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    m_ShopAdminEmployee = hr_getShopAdminEmployee(shopadminemp);

    //设置当前下拉控件
    setCombobox('#shopadminemp', m_widths[0], m_widths[0], m_widths[4], true, false, 'empcode', 'empname', m_ShopAdminEmployee);
    setCombobox('#sharestate', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_IsShare);

    //导购金额修改
    //获取导购
    var shopempall = [];
    shopempall[shopempall.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    m_ShopEmployeeAll = hr_getShopEmployeeAll(shopempall);

    setCombobox('#shopempall', m_widths[0], m_widths[0], m_widths[4], false, false, 'empcode', 'empname', m_ShopEmployeeAll);
    setCombobox('#avgsharestate', m_widths[4], m_widths[4], m_widths[4], false, false, 'value', 'text', m_IsShare);

    //日期控件
    setDatebox('#begindt');
    setDatebox('#enddt');

    //加载列表
    var saleretailshare = [{ "name": "txtunitid", "value": m_UserInfo.deptID },
                           { "name": "txtyear", "value": m_Year },
                           { "name": "txtmonth", "value": m_Month * 1 },
                           { "name": "txtshareflag", "value": 1 }];
    var shareurl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(saleretailshare, "GetSaleRetailInfo");
    var saleretailupdate = [{ "name": "txtunitid", "value": m_UserInfo.deptID },
                           { "name": "txtyear", "value": m_Year },
                           { "name": "txtmonth", "value": m_Month * 1 },
                           { "name": "txtshareflag", "value": 0 }];
    var updateurl = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(saleretailupdate, "GetSaleRetailInfo");
    setDataGrid(shareurl, updateurl);
});


/***********************************************************************
 *  设置下拉控件
 *  DLY 
 */
function setCombobox(field, width, pwidth, pheight, edit, multi, vfield, tfield, data) {
    $(field).combobox({
        width: width,
        panelWidth: pwidth,
        panelHeight: pheight,
        editable: edit,
        multiple: multi,
        valueField: vfield,
        textField: tfield,
        data: data
    });
}


/***********************************************************************
 *  设置日期控件
 *  DLY 
 */
function setDatebox(field) {
    $(field).datebox({
        width: 120,//m_widths[0],
        closeText: '关闭',
        editable: true,
        formatter: function (date) {
            return dateUtil_dateFomaterB(date, '-');
        },
        parser: function (s) {
            var t = Date.parse(s);
            if (!isNaN(t)) {
                return new Date(t);
            } else {
                return new Date();
            }
        },
        onChange: function (newValue, oldValue) {
            if (newValue != oldValue) {
            }
        }
    });
}


/***********************************************************************
 *  加载数据——奖励分配
 *  SY 
 */
function actShareLoadData(page, number) {
    $(m_DatagridShareID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条
    var cons = ' 1=1 ';
    var shopadminemp = $('#shopadminemp').combobox('getValue');
    var sharestate = $('#sharestate').combobox('getValue');
    if (shopadminemp != '') {
        cons += " AND UserIDGroup Like '%" + shopadminemp + "%'";
    }
    if (sharestate != '') {
        cons += ' AND IsShare=' + sharestate;
    }

    var saleretail = [];
    saleretail[saleretail.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    saleretail[saleretail.length] = { "name": "txtyear", "value": m_Year };
    saleretail[saleretail.length] = { "name": "txtmonth", "value": m_Month * 1 };
    saleretail[saleretail.length] = { "name": "txtshareflag", "value": 1 };    //1表示可分，班组销售为可分
    var res = hr_getSaleRetailInfo(saleretail, cons);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        //alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridShareID).datagrid('loadData', res.rows);
    }
    $(m_DatagridShareID).datagrid("clearSelections");
    m_ShareLastIndex = -1;
}


/***********************************************************************
*  设置列表
*  SY
*/
function setDataGrid(shareurl, updateurl) {
    //信息列表——奖励分配
    $(m_DatagridShareID).datagrid({
        //title: '奖励分配表', //表格标题
        url: shareurl,
        sortName: 'retailid', //排序字段
        idField: 'id', //标识字段,主键
        //width: $(document.body).width(), //宽度
        height: 350, //高度$(document.body).height()
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        remoteSort: true, //定义是否从服务器给数据排序
        collapsible: false, //可折叠
        sortOrder: 'asc', //排序类型
        sortable: true,
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        fit: false,
        pagination: true, //是否开启分页
        pageSize: m_PageSize, //默认一页数据条数 
        //pageList: [100],
        rownumbers: true,//行号
        columns: [[
           { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'retailid', title: '零售单号', width: 200 },
            { field: 'retaildate', title: '销售时间', width: 80, hidden: true },
            { field: 'shopid', title: '销售店铺', width: 80, hidden: true },
            { field: 'costcenter', title: '成本中心', width: 70, hidden: true },
            { field: 'is_avgshare', title: '是否平均分配', width: 70, hidden: true },
            { field: 'usernums', title: '导购数', width: 80, hidden: true },
            { field: 'useridgroup', title: '销售人员ID', width: 60, hidden: true },
            { field: 'usernamegroup', title: '销售人员', width: 130 },
            { field: 'nums', title: '数量', width: 70, hidden: true, },
            { field: 'yamount', title: '原价金额', width: 70, hidden: true, },
            { field: 'xamount', title: '现价金额', width: 80, hidden: true },
            { field: 'samount', title: '结算金额', width: 80 },
            { field: 'aamount', title: '实销金额', width: 80 },
            { field: 'customerpay', title: '顾客实付折扣', width: 80, hidden: true },
            { field: 'pamount', title: '计薪金额', width: 80, hidden: true },
            {
                field: 'isshare', title: '是否已分配', width: 65, align: 'center',
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'value', 'text');
                }
            },
            { field: 'rgdt', title: '创建日期', width: 75, hidden: true },
            { field: 'rguser', title: '创建人', width: 100, hidden: true },
            { field: 'lmdt', title: '修改日期', width: 80, hidden: true },
            { field: 'lmuser', title: '修改人', width: 100, hidden: true },
            { field: 'uptno', title: '修改次数', width: 50, hidden: true }
        ]],
        toolbar: '#sharetoolbar',
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) {
            m_ShareLastIndex = rowIndex;
        }
    });
    //信息列表——导购金额修改表
    $(m_DatagridUpdateID).datagrid({
        //title: '导购金额修改表', //表格标题
        url: updateurl,
        sortName: 'retailid', //排序字段
        idField: 'id', //标识字段,主键
        //width: $(document.body).width(), //宽度
        height: 350, //高度$(document).height() - 100
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        remoteSort: true, //定义是否从服务器给数据排序
        collapsible: false, //可折叠
        sortOrder: 'asc', //排序类型
        sortable: true,
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        fit: false,
        pagination: true, //是否开启分页
        pageSize: m_PageSize, //默认一页数据条数 
        rownumbers: true,//行号
        frozenColumns: [[
           //{ field: 'ck', checkbox: true },
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'retailid', title: '零售单号', width: 200 },
            { field: 'retaildate', title: '销售时间', width: 80, hidden: true },
            { field: 'shopid', title: '销售店铺', width: 80, hidden: true },
            { field: 'costcenter', title: '成本中心', width: 70, hidden: true },
            { field: 'is_avgshare', title: '是否平均分配', width: 70, hidden: true },
            { field: 'usernums', title: '导购数', width: 80, hidden: true },
            { field: 'useridgroup', title: '销售人员ID', width: 60, hidden: true },
            { field: 'usernamegroup', title: '销售人员', width: 130 },
            { field: 'nums', title: '数量', width: 70, hidden: true, },
            { field: 'yamount', title: '原价金额', width: 70, hidden: true, },
            { field: 'xamount', title: '现价金额', width: 80, hidden: true },
            { field: 'samount', title: '结算金额', width: 80 },
            { field: 'aamount', title: '实销金额', width: 80 },
            { field: 'customerpay', title: '顾客实付折扣', width: 80, hidden: true },
            { field: 'pamount', title: '计薪金额', width: 80, hidden: true },
            {
                field: 'isshare', title: '是否已分配', width: 65, align: 'center',
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'value', 'text');
                }
            },
            { field: 'rgdt', title: '创建日期', width: 75, hidden: true },
            { field: 'rguser', title: '创建人', width: 100, hidden: true },
            { field: 'lmdt', title: '修改日期', width: 80, hidden: true },
            { field: 'lmuser', title: '修改人', width: 100, hidden: true },
            { field: 'uptno', title: '修改次数', width: 50, hidden: true }
        ]],
        toolbar: '#updatetoolbar',
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
        },
        onClickRow: function (rowIndex) {
            m_UpdateLastIndex = rowIndex;
        }
    });
}


/***********************************************************************
 *  清除——奖励分配
 *  SY 
 */
function clearShareText() {
    $('#shopadminemp').combobox('setValue', '');
    $('#sharestate').combobox('setValue', '');
}


/***********************************************************************
 *  加载数据——导购金额修改
 *  SY 
 */
function actUpdateLoadData(page, number) {
    $(m_DatagridUpdateID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条
    var cons = ' 1=1 ';
    var retailid = $('#retailid').val();
    var shopempall = $('#shopempall').combobox('getValue');
    var begindt = $('#begindt').datebox('getValue');
    var enddt = $('#enddt').datebox('getValue');
    var avgsharestate = $('#avgsharestate').combobox('getValue');

    if (retailid != '') {
        cons += " AND RetailID='" + retailid + "'";
    }
    if (shopempall != '') {
        cons += " AND UserIDGroup Like '%" + shopempall + "%'";
    }
    if (begindt != '') {
        if (enddt == '') {
            enddt = dateUtil_dateFomaterB(new Date(), '-');
        }
        cons += " AND ( CONVERT(varchar(50),RetailDate,120) between '" + begindt + "' AND '" + enddt + "')";
    }

    if (avgsharestate != '') {
        cons += ' AND IsShare =' + avgsharestate;
    }

    var saleretail = [];
    saleretail[saleretail.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    saleretail[saleretail.length] = { "name": "txtyear", "value": m_Year };
    saleretail[saleretail.length] = { "name": "txtmonth", "value": m_Month * 1 };
    saleretail[saleretail.length] = { "name": "txtshareflag", "value": 0 };

    var res = hr_getSaleRetailInfo(saleretail, cons);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        //alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridUpdateID).datagrid('loadData', res.rows);
    }
    $(m_DatagridUpdateID).datagrid("clearSelections");
    m_UpdateLastIndex = -1;
}


/***********************************************************************
 *  清除——导购金额修改
 *  SY
 */
function clearUpdateText() {
    $('#retailid').val('');
    $('#shopempall').combobox('setValue', '');
    $('#begindt').datebox('setValue', '');
    $('#enddt').datebox('setValue', '');
    $('#avgsharestate').combobox('setValue', '');
}


/***********************************************************************
 *  明细分配以及导购选择
 *  SY 
 */
function opendlg(type) {
    //双击选中一条记录进行调整
    if (type == 'select') {         //导购选择
        //信息列表
        $(m_DatagridSelectID).datagrid({
            //title:'导购表',
            //width: $(document.body).width(),
            height: 200,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            sortName: 'empcode',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'id',
            frozenColumns: [[
               { field: 'ck', checkbox: true },
            ]],
            columns: [[
                { field: 'id', title: 'FID', width: 80, hidden: true },
                { field: 'empcode', title: '导购编号', width: 100 },
                { field: 'empname', title: '导购姓名', width: 100 },
                { field: 'jobname', title: '职位', width: 100 }
            ]],
            rownumbers: true,
            singleSelect: false,
            onDblClickRow: function (rowIndex, rowData) {
            },
            onClickRow: function (rowIndex) {
            }
        });

        //判断当前员工是否在当前销售时间内在该店上班
        var shopemp = [];
        for (var i = 0; i < m_ShopEmployeeAll.length; i++) {
            if (m_ShopEmployeeAll[i].begindt <= m_RetailDate && m_RetailDate <= m_ShopEmployeeAll[i].enddt) {
                shopemp.push(m_ShopEmployeeAll[i]);
            }
        }

        $(m_DatagridSelectID).datagrid('loadData', shopemp);
        $(m_DatagridSelectID).datagrid("clearSelections");

        $(m_dlgSelectID).dialog('open');

    } else if (type == 'share') {         //奖励金额分配
        if (m_ShareLastIndex == -1) {
            alert('请选中一个销售单进行分单！');
            return;
        }

        //获取当前选中销售单信息
        var rowData = $(m_DatagridShareID).datagrid('getSelected');
        m_RetailID = rowData.retailid;
        var date = new Date(rowData.retaildate);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        m_RetailDate = y + '/' + m + '/' + d + ' 00:00:00';
        m_RetailAamount = rowData.aamount * 1;   //实销金额
        m_RetailPamount = rowData.pamount * 1;   //计薪金额

        $('#retailidgroupspan').html(rowData.retailid);
        $('#usernamegroupspan').html(rowData.usernamegroup);
        $('#samountgroupspan').html(rowData.samount);
        $('#aamountgroupspan').html(rowData.aamount);
        $('#pamountgroupspan').html(rowData.pamount);

        var sharerow = [{ "name": "txtretailid", "value": m_RetailID }];
        var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(sharerow, "GetSaleRetailSubInfo");

        //信息列表
        $(m_DatagridShareSubID).datagrid({
            //title:'奖励分配明细表',
            url: url,
            sortName: 'userid', //排序字段
            idField: 'id', //标识字段,主键
            //width: $(document.body).width(), //宽度
            height: 230, //高度$(document.body).height()
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'asc', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            fit: false,
            frozenColumns: [[
               //{ field: 'ck', checkbox: true },
            ]],
            columns: [[
                { field: 'id', title: 'FID', width: 80, hidden: true },
                { field: 'retailid', title: '销售单号', width: 120, hidden: true },
                { field: 'retaildate', title: '销售时间', width: 120, hidden: true },
                { field: 'shopid', title: '店铺编号', width: 120, hidden: true },
                { field: 'workteamid', title: '班组编号', width: 120, hidden: true },
                { field: 'userid', title: '员工编号', width: 100 },
                { field: 'drp_userid', title: '导购编号', width: 100 },
                { field: 'drp_username', title: '导购姓名', width: 100 },
                {
                    field: 'proportion', title: '分配占比', width: 80,
                    formatter: function (val, row, index) {
                        if (val) {
                            return val * 100 + '%';
                        }
                    }
                },
                { field: 'asamount', title: '分配实销金额', width: 100 },
                { field: 'psamount', title: '分配计薪金额', width: 100 },
                { field: 'ssamount', title: '分配结算金额', width: 100, hidden: true },
                { field: 'xsamount', title: '分配现价金额', width: 100, hidden: true },
                { field: 'ysamount', title: '分配原价金额', width: 100, hidden: true },
                { field: 'shareuserid', title: '分单人', width: 120, hidden: true },
                { field: 'sharedate', title: '分单时间', width: 120, hidden: true },
                { field: 'rgdt', title: '创建时间', width: 120, hidden: true },
                { field: 'rguser', title: '创建人', width: 120, hidden: true },
                { field: 'lmdt', title: '修改时间', width: 120, hidden: true },
                { field: 'lmuser', title: '修改人', width: 120, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true,
            onDblClickRow: function (rowIndex, rowData) {
                if (m_LastIndex != -1) {
                    $(m_DatagridShareSubID).datagrid('endEdit', m_LastIndex);
                }
                $(m_DatagridShareSubID).datagrid('selectRow', rowIndex);
                $(m_DatagridShareSubID).datagrid('beginEdit', rowIndex);
                m_LastIndex = rowIndex;
            },
            onClickRow: function (rowIndex) {
                if (m_LastIndex != -1) {
                    $(m_DatagridShareSubID).datagrid('endEdit', m_LastIndex);
                }
                $(m_DatagridShareSubID).datagrid('selectRow', rowIndex);
                m_LastIndex = rowIndex;
            },
            onAfterEdit: function (rowIndex, rowData, changes) {
                rowData.asamount = (m_RetailAamount * rowData.proportion).toFixed(2);
                rowData.psamount = (m_RetailPamount * rowData.proportion).toFixed(2);
                $(m_DatagridShareSubID).datagrid('updateRow', {
                    index: rowIndex,
                    row: rowData
                });
            },
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && (data.rows[0].id == undefined || data.rows[0].id == '')) {
                    ClearGrid(m_DatagridShareSubID);
                } else {
                    var colproportion = $(m_DatagridShareSubID).datagrid('getColumnOption', 'proportion');
                    //var colasamount = $(m_DatagridShareSubID).datagrid('getColumnOption', 'asamount');
                    //var colpsamount = $(m_DatagridShareSubID).datagrid('getColumnOption', 'psamount');
                    if (data.rows.length > 1 && m_Flag == true) {
                        colproportion.editor = { type: 'numberbox', options: { precision: 2, max: 1, min: 0 } };
                        //colasamount.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };
                        //colpsamount.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };
                    } else {
                        colproportion.editor = {};
                        //colasamount.editor = {};
                        //colpsamount.editor = {};
                    }
                }
            }
        });

        m_LastIndex = -1;
        $(m_dlgShareID).dialog('open');

    } else if (type == 'update') {
        if (m_UpdateLastIndex == -1) {
            alert('请选中一个销售单进行修改！');
            return;
        }

        //获取当前选中销售单信息
        var rowData = $(m_DatagridUpdateID).datagrid('getSelected');
        m_RetailID = rowData.retailid;
        var date = new Date(rowData.retaildate);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        m_RetailDate = y + '/' + m + '/' + d + ' 00:00:00';
        m_RetailAamount = rowData.aamount * 1;   //实销金额
        m_RetailPamount = rowData.pamount * 1;   //计薪金额

        $('#retailidspan').html(rowData.retailid);
        $('#usernamespan').html(rowData.usernamegroup);
        $('#samountspan').html(rowData.samount);
        $('#aamountspan').html(rowData.aamount);
        $('#pamountspan').html(rowData.pamount);

        var updaterow = [{ "name": "txtretailid", "value": m_RetailID }];
        var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(updaterow, "GetSaleRetailSubInfo");

        //信息列表
        $(m_DatagridUpdateSubID).datagrid({
            //title:'导购金额修改明细表',
            //width: $(document.body).width(),
            height: 230,
            url: url,
            sortName: 'userid', //排序字段
            idField: 'id', //标识字段,主键
            //width: $(document.body).width(), //宽度
            nowrap: true, //是否换行，True 就会把数据显示在一行里
            remoteSort: false, //定义是否从服务器给数据排序
            collapsible: false, //可折叠
            sortOrder: 'asc', //排序类型
            sortable: true,
            striped: true, //True 奇偶行使用不同背景色
            fit: false,
            frozenColumns: [[
               //{ field: 'ck', checkbox: true },
            ]],
            columns: [[
                { field: 'id', title: 'FID', width: 80, hidden: true },
                { field: 'ri_id', title: '销售单ID', width: 120, hidden: true },
                { field: 'retailid', title: '销售单号', width: 120, hidden: true },
                { field: 'retaildate', title: '销售时间', width: 120, hidden: true },
                { field: 'shopid', title: '店铺编号', width: 120, hidden: true },
                { field: 'workteamid', title: '班组编号', width: 120, hidden: true },
                { field: 'userid', title: '员工编号', width: 100 },
                { field: 'drp_userid', title: '导购编号', width: 100 },
                { field: 'drp_username', title: '导购姓名', width: 100 },
                {
                    field: 'proportion', title: '分配占比', width: 80,
                    formatter: function (val, row, index) {
                        if (val) {
                            return val * 100 + '%';
                        }
                    }
                },
                { field: 'asamount', title: '分配实销金额', width: 80 },
                { field: 'psamount', title: '分配计薪金额', width: 80 },
                { field: 'ssamount', title: '分配结算金额', width: 100, hidden: true },
                { field: 'xsamount', title: '分配现价金额', width: 100, hidden: true },
                { field: 'ysamount', title: '分配原价金额', width: 100, hidden: true },
                { field: 'shareuserid', title: '分单人', width: 120, hidden: true },
                { field: 'sharedate', title: '分单时间', width: 120, hidden: true },
                { field: 'rgdt', title: '创建时间', width: 120, hidden: true },
                { field: 'rguser', title: '创建人', width: 120, hidden: true },
                { field: 'lmdt', title: '修改时间', width: 120, hidden: true },
                { field: 'lmuser', title: '修改人', width: 120, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true,
            onDblClickRow: function (rowIndex, rowData) {
                if (m_LastIndex != -1) {
                    $(m_DatagridUpdateSubID).datagrid('endEdit', m_LastIndex);
                }
                $(m_DatagridUpdateSubID).datagrid('selectRow', rowIndex);
                $(m_DatagridUpdateSubID).datagrid('beginEdit', rowIndex);
                m_LastIndex = rowIndex;
            },
            onClickRow: function (rowIndex) {
                if (m_LastIndex != -1) {
                    $(m_DatagridUpdateSubID).datagrid('endEdit', m_LastIndex);
                }
                $(m_DatagridUpdateSubID).datagrid('selectRow', rowIndex);
                m_LastIndex = rowIndex;
            },
            onAfterEdit: function (rowIndex, rowData, changes) {
                rowData.asamount = (m_RetailAamount * rowData.proportion).toFixed(2);
                rowData.psamount = (m_RetailPamount * rowData.proportion).toFixed(2);
                $(m_DatagridUpdateSubID).datagrid('updateRow', {
                    index: rowIndex,
                    row: rowData
                });
            },
            onLoadSuccess: function (data) {
                if (data.rows.length == 1 && (data.rows[0].id == undefined || data.rows[0].id == '')) {
                    ClearGrid(m_DatagridUpdateSubID);
                } else {
                    var colproportion = $(m_DatagridUpdateSubID).datagrid('getColumnOption', 'proportion');
                    //var colasamount = $(m_DatagridUpdateSubID).datagrid('getColumnOption', 'asamount');
                    //var colpsamount = $(m_DatagridUpdateSubID).datagrid('getColumnOption', 'psamount');
                    if (data.rows.length > 1 && m_Flag == true) {
                        colproportion.editor = { type: 'numberbox', options: { precision: 2, max: 1, min: 0 } };
                        //colasamount.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };
                        //colpsamount.editor = { type: 'numberbox', options: { precision: 2, min: 0 } };
                    } else {
                        colproportion.editor = {};
                        //colasamount.editor = {};
                        //colpsamount.editor = {};
                    }
                }
            }
        });

        m_LastIndex = -1;
        $(m_dlgUpdateID).dialog('open');
    }
}


/***********************************************************************
 *  选择导购人员
 *  SY 
 */
function getShopEmp() {
    //获取当前选中导购人员信息
    var shopempdata = $(m_DatagridSelectID).datagrid('getSelections');
    if (shopempdata.length <= 0) {
        alert('请选择分单的导购人员！');
        return;
    }

    //获取当前选中销售单信息
    var retaildata = $(m_DatagridShareID).datagrid('getSelected');

    var sharelistrow = [];
    for (var i = 0; i < shopempdata.length; i++) {
        var sharerow = {};
        sharerow.id = dataUtil_NewGuid();
        sharerow.retailid = retaildata.retailid;
        sharerow.retaildate = retaildata.retaildate;
        sharerow.shopid = retaildata.shopid;
        sharerow.workteamid = shopempdata[i].workteamcode;
        sharerow.userid = shopempdata[i].empcode;
        sharerow.drp_userid = '';   //导购编号
        sharerow.drp_username = shopempdata[i].empname;
        sharelistrow.push(sharerow);
    }
    //默认为均分
    var sharelist = initAvgShareList(sharelistrow);

    $(m_DatagridShareSubID).datagrid('loadData', sharelist);

    $(m_dlgSelectID).dialog('close');
}


/***********************************************************************
 *  初始化分单明细信息（均分）
 *  SY 
 */
function initAvgShareList(shopempdata) {
    var count = shopempdata.length
    var sumavgproportion = 0;
    var sumasamount = 0;
    var sumpsamount = 0;
    var avgproportion = (1 / count).toFixed(2);
    for (var i = 0; i < shopempdata.length - 1; i++) {
        shopempdata[i].proportion = avgproportion;
        shopempdata[i].asamount = (m_RetailAamount * avgproportion).toFixed(2);
        shopempdata[i].psamount = (m_RetailPamount * avgproportion).toFixed(2);
        shopempdata[i].ssamount = (m_RetailSamount * avgproportion).toFixed(2);
        shopempdata[i].xsamount = (m_RetailXamount * avgproportion).toFixed(2);
        shopempdata[i].ysamount = (m_RetailYamount * avgproportion).toFixed(2);
        sumavgproportion += avgproportion * 1;
        sumasamount += shopempdata[i].asamount * 1;
        sumpsamount += shopempdata[i].psamount * 1;
    }
    shopempdata[shopempdata.length - 1].proportion = (1 - sumavgproportion * 1).toFixed(2);
    shopempdata[shopempdata.length - 1].asamount = (m_RetailAamount - sumasamount).toFixed(2);
    shopempdata[shopempdata.length - 1].psamount = (m_RetailPamount - sumpsamount).toFixed(2);
    shopempdata[shopempdata.length - 1].ssamount = (m_RetailSamount - sumasamount).toFixed(2);
    shopempdata[shopempdata.length - 1].xsamount = (m_RetailXamount - sumpsamount).toFixed(2);
    shopempdata[shopempdata.length - 1].ysamount = (m_RetailYamount - sumpsamount).toFixed(2);
    return shopempdata;
}


/***********************************************************************
 *  平均分配零售单
 *  SY 
 */
function AvgShareList(type) {
    var datarows = [];
    var sharelist = [];
    if (type == 'share') {
        datarows = $(m_DatagridShareSubID).datagrid('getRows');
        if (datarows.length <= 0) {
            alert('当前不存在可分数据，请确认');
            return;
        }
        sharelist = initAvgShareList(datarows);
        $(m_DatagridShareSubID).datagrid('loadData', sharelist);
    } else if (type == 'update') {
        datarows = $(m_DatagridUpdateSubID).datagrid('getRows');
        if (datarows.length <= 0) {
            alert('当前不存在可分数据，请确认');
            return;
        }
        sharelist = initAvgShareList(datarows);
        $(m_DatagridUpdateSubID).datagrid('loadData', sharelist);
    }
}


/***********************************************************************
 *  保存当前分单结果
 *  SY
 */
function actSave(type) {
    if (type == 'share') {
        var datarows = $(m_DatagridShareSubID).datagrid('getRows');
        var sumproportion = 0;
        for (var i = 0; i < datarows.length; i++) {
            if (datarows[i].proportion == 0
                || datarows[i].proportion == undefined
                || datarows[i].proportion == '') {
                alert('分配占比出错，请确认！');
                return;
            }
            sumproportion += datarows[i].proportion * 1;
            datarows[i].shareuserid = m_UserInfo.userName;
            datarows[i].sharedate = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].rgdt = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].rguser = m_UserInfo.userName;
            datarows[i].lmdt = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].lmuser = m_UserInfo.userName;
        }
        if (sumproportion * 1 != 1) {
            alert('分配出错，请确认！');
            return;
        }
        var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + escape(GetGetJson(datarows, "SaveSaleRetailSingle"));
        var htmlobj = $.ajax({
            url: url,
            type: 'post',
            async: false
        });
        try {
            var res = $.parseJSON(htmlobj.responseText);
            if (res.Error) {
                $.messager.alert("系统错误", res.Error, 'error');
            }
            else if (res.rows[0].result.toLowerCase() == "false") {
                $.messager.alert("提示", res.rows[0].message, 'error');
            } else if (res.rows[0].result.toLowerCase() == "true") {
                alert('保存成功！');
                $(m_dlgShareID).dialog('close');
                actShareLoadData(m_PageNumber, m_PageSize);
            }
            else {
                alert('保存有误，请确认！');
            }
        } catch (ex) {
            $.messager.alert("提示", ex, 'error');
        }
    } else if (type == 'update') {
        var datarows = $(m_DatagridUpdateSubID).datagrid('getRows');
        var sumproportion = 0;
        for (var i = 0; i < datarows.length; i++) {
            if (datarows[i].proportion == 0
                || datarows[i].proportion == undefined
                || datarows[i].proportion == '') {
                alert('分配占比出错，请确认！');
                return;
            }
            sumproportion += datarows[i].proportion * 1;
            datarows[i].shareuserid = m_UserInfo.userName;
            datarows[i].sharedate = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].rgdt = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].rguser = m_UserInfo.userName;
            datarows[i].lmdt = dateUtil_dateFomaterA(new Date(), '-');
            datarows[i].lmuser = m_UserInfo.userName;
        }
        if (sumproportion * 1 != 1) {
            alert('分配出错，请确认！');
            return;
        }
        var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + escape(GetGetJson(datarows, "SaveSaleRetailSingle"));
        var htmlobj = $.ajax({
            url: url,
            type: 'post',
            async: false
        });
        try {
            var res = $.parseJSON(htmlobj.responseText);
            if (res.Error) {
                $.messager.alert("系统错误", res.Error, 'error');
            }
            else if (res.rows[0].result.toLowerCase() == "false") {
                $.messager.alert("提示", res.rows[0].message, 'error');
            } else if (res.rows[0].result.toLowerCase() == "true") {
                alert('保存成功！');
                $(m_dlgUpdateID).dialog('close');
                actUpdateLoadData(m_PageNumber, m_PageSize);
            }
            else {
                alert('保存有误，请确认！');
            }
        } catch (ex) {
            $.messager.alert("提示", ex, 'error');
        }
    }
}


/***********************************************************************
 *  提交——每月提交提交后无法更改
 *  SY
 */
function actApprove() {
    var row = [];
    row[row.length] = { "name": "txtyear", "value": m_Year };
    row[row.length] = { "name": "txtmonth", "value": m_Month * 1 };
    row[row.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    row[row.length] = { "name": "txtactor", "value": m_UserInfo.userName };
    var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + escape(GetFormJson(row, "SaleRetailSubmit"));

    //审批操作——提交
    $.messager.confirm('确认框', '确认提交该月分单申请吗？', function (r) {
        if (r) {
            $.ajax({
                url: url,
                type: 'post',
                async: true, //异步,
                success: function (result) {
                    try {
                        var result = eval("[" + result + "]");
                        if (result[0].Error) {
                            $.messager.alert("系统错误", result[0].Error, 'error');
                        }
                        else if (result[0].rows[0].result.toLowerCase() == "false") {
                            $.messager.alert("提示", result[0].rows[0].message, 'error');
                        } else if (result[0].rows[0].result.toLowerCase() == "true") {
                            $.messager.alert("提示", result[0].rows[0].message);
                            $('#btntj').hide();
                            $('#btnsaveshare').hide();
                            $('#btnshareemp').hide();
                            $('#btnshareavg').hide();
                            $('#btnsaveupdate').hide();
                            $('#btnupdateavg').hide();
                        }
                        else {
                            alert('提交有误，请确认！');
                        }
                    } catch (ex) {
                        $.messager.alert("提示", ex, 'error');
                    }
                },
                error: function () {
                    $.messager.alert("提示", "提交错误了！", 'error');
                }
            });
        }
    });
}