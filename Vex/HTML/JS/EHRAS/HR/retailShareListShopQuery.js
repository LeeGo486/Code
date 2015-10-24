//全局变量
var m_DatagridEmpID = '#shopemplb'; //店铺人员列表ID
var m_DatagridRetailID = '#retaillb'; //分单列表ID

var m_DivShopID = '#shoplayout'; //店铺
var m_DivEmpID = '#emplayout'; //个人

var m_LastIndex = -1;
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式

//基础数据
var m_YearSelect = [{ value: '2015', text: '2015' }, { value: '2016', text: '2016' }, { value: '2017', text: '2017' }];
var m_MonthSelect = [{ value: '1', text: '1' }, { value: '2', text: '2' }, { value: '3', text: '3' },
                { value: '4', text: '4' }, { value: '5', text: '5' }, { value: '6', text: '6' },
                { value: '7', text: '7' }, { value: '8', text: '8' }, { value: '9', text: '9' },
                { value: '10', text: '10' }, { value: '11', text: '11' }, { value: '12', text: '12' }];

var m_Year = '';
var m_Month = '';

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300, 50, 90];

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

    //设置当前下拉控件——月份
    setCombobox('#year', m_widths[4], m_widths[4], m_widths[4], true, false, 'value', 'text', m_YearSelect);
    setCombobox('#month', m_widths[7], m_widths[7], m_widths[1], true, false, 'value', 'text', m_MonthSelect);

    var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);//默认月份
    m_Year = curmonth.substring(0, 4);
    m_Month = curmonth.substring(5, 7) * 1;
    $('#year').combobox('setValue', m_Year);        //默认为当前年份和月份
    $('#month').combobox('setValue', m_Month * 1);

    $(m_DivShopID).panel({ title: '店铺：' + m_UserInfo.deptName });
    var row = [];
    row[row.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    row[row.length] = { "name": "txtyear", "value": m_Year };
    row[row.length] = { "name": "txtmonth", "value": m_Month * 1 };
    var url = GetWSRRURL(peoa_GetWSRRURL(1003)) + "&XML=" + GetFormJson(row, "GetReportHeadDetail");
    setDataGrid(url);
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
*  设置列表
*  SY
*/
function setDataGrid(url) {
    //信息列表——导购信息
    $(m_DatagridEmpID).datagrid({
        //title: '导购信息表', //表格标题
        url: url,
        sortName: 'drp_userid', //排序字段
        idField: 'id', //标识字段,主键
        //width: '100%',//宽度
        //height: '100%', //高度$(document).height() - 100
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        remoteSort: true, //定义是否从服务器给数据排序
        collapsible: false, //可折叠
        sortOrder: 'asc', //排序类型
        sortable: true,
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        fit: true,
        pagination: true, //是否开启分页
        pageSize: m_PageSize, //默认一页数据条数 
        rownumbers: true,//行号
        frozenColumns: [[
           //{ field: 'ck', checkbox: true },
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'userid', title: '员工编号', width: 80, hidden: true },
            { field: 'drp_userid', title: '导购编号', width: 80 },
            { field: 'drp_username', title: '导购姓名', width: 80 },
            { field: 'jobname', title: '职务', width: 80 },
            { field: 'name', title: '类型', width: 70 },
            { field: 'asamountsum', title: '分配实销金额', width: 80 },
            { field: 'psamountsum', title: '计薪金额', width: 80 }
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) {
            if (rowData.userid == '' || rowData.userid == undefined) {
                alert('员工编号未配置，请确认！');
            } else {
                $(m_DivEmpID).panel({ title: '人员：' + rowData.drp_username + ' 类型：' + rowData.name });
                var row = [];
                row[row.length] = { "name": "txtuserid", "value": rowData.userid };
                row[row.length] = { "name": "txtyear", "value": m_Year };
                row[row.length] = { "name": "txtmonth", "value": m_Month * 1 };
                var cons = '';
                actRetailLoadData(row, cons);
            }
        },
        onClickRow: function (rowIndex) {
        },
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && (data.rows[0].id == undefined || data.rows[0].id == '')) {
                ClearGrid(m_DatagridEmpID);
            }
            ClearGrid(m_DatagridRetailID);
            $(m_DivEmpID).panel({ title: '人员信息' });
        }
    });
    //信息列表—— 分单信息
    $(m_DatagridRetailID).datagrid({
        //title: '分单信息表', //表格标题
        //url: updateurl,
        sortName: 'retailid', //排序字段
        idField: 'id', //标识字段,主键
        //width: '100%', //宽度
        //height: '80%', //高度$(document).height() - 100
        nowrap: true, //是否换行，True 就会把数据显示在一行里
        remoteSort: true, //定义是否从服务器给数据排序
        collapsible: false, //可折叠
        sortOrder: 'asc', //排序类型
        sortable: true,
        striped: true, //True 奇偶行使用不同背景色
        singleSelect: true, //单行选择
        fit: true,
        pagination: true, //是否开启分页
        pageSize: m_PageSize, //默认一页数据条数 
        rownumbers: true,//行号
        frozenColumns: [[
           //{ field: 'ck', checkbox: true },
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'retailid', title: '零售单号', width: 180 },
            { field: 'aamount', title: '实销金额', width: 80 },
            { field: 'proportion', title: '分配占比', width: 80 },
            { field: 'asamount', title: '分配实销金额', width: 80 },
            { field: 'psamount', title: '计薪金额', width: 80 }
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) {
        },
        onLoadSuccess: function (data) {
            if (data.rows.length == 1 && (data.rows[0].id == undefined || data.rows[0].id == '')) {
                ClearGrid(m_DatagridRetailID);
            }
        }
    });
}


/***********************************************************************
 *  加载数据——报表子表（员工信息）
 *  SY 
 */
function actEmpLoadData(page, number) {
    $(m_DatagridEmpID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条
    m_Year = $('#year').combobox('getValue');
    m_Month = $('#month').combobox('getValue');
    if (m_Year == '' || m_Year == undefined) {
        alert('请输入年份！');
        return;
    }
    if (m_Month == '' || m_Month == undefined) {
        alert('请输入月份！');
        return;
    }

    var row = [];
    row[row.length] = { "name": "txtunitid", "value": m_UserInfo.deptID };
    row[row.length] = { "name": "txtyear", "value": m_Year };
    row[row.length] = { "name": "txtmonth", "value": m_Month * 1 };
    var res = hr_getReportHeadDetail(row, '');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        //alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridEmpID).datagrid('loadData', res.rows);
    }
    $(m_DatagridEmpID).datagrid("clearSelections");
}


/***********************************************************************
 *  加载数据——报表个人子表（分单信息）
 *  SY 
 */
function actRetailLoadData(row, cons) {
    $(m_DatagridRetailID).datagrid('loadData', []);

    var res = hr_getReportHeadDetailPerson(row, cons);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        //alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridRetailID).datagrid('loadData', res.rows);
    }
    $(m_DatagridRetailID).datagrid("clearSelections");
}


/***********************************************************************
 *  清除——公司和店铺
 *  SY
 */
function clearText() {
    $('#year').combobox('setValue', '');
    $('#month').combobox('setValue', '');
}
