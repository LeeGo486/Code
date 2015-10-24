/* 全局变量*/
var m_DatagridID = '#cqlb';//出勤列表
var m_LastIndex = undefined;  //项目列表最后一次编辑行下标  


//获取用户名
var m_UserInfo = parent.m_UserInfo;
var loginurl = hr_getServUrl(1);

var m_Filter = '';  //主的条件,
var m_Filter1 = ''; //查询条件,
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 
var m_OrderBy = ' HR11_ID '; //排序方式

//类型选择
var m_Types = [{ text: "待办任务" }, { text: "非待办任务" }];   //0-小时，1-天
//宽度设置
var m_widths = [153, 150, 120, 100, 70, 200, 300];

/***********************************************************************
 *  初始化
 *  DLY 
 */
$(function () {
    //用户认证
    parent.sc();

    //用户认证
    if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
        top.location.href = 'error.html';
        return;
    }

    //设置相关控件
    setDatebox('#month');

    //判断当前用户是否需要新增申请的按钮
    $('#btnAdd').hide();
    if (m_UserInfo.actor = 'A') {
        $('#btnAdd').show();
        m_Filter = ' AND HR11_ShopID = \'' + m_UserInfo.deptID + '\' ';
    }
    setDataGrid();
    actLoadData(1, m_PageSize);
});


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
            var atmonth = dateUtil_dateFomaterB(date, '-');
            return atmonth.substring(0, 7);
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
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'出勤列表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 420,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'hr11_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            //{ field: 'ck', checkbox: true },
            { field: 'hr11_id', title: 'ID', width: 100, hidden: true },
            { field: 'hr11_shopid', title: '店铺ID', width: 100 },
            { field: 'hr11_shopname', title: '店铺名称', width: 200 },
            { field: 'hr11_atmonth', title: '月份', width: 100 },
            { field: 'hr11_state', title: '状态', width: 70 },
            { field: 'hr11_rguser', title: '创建人', width: 100 },
            { field: 'hr11_rgdt', title: '创建时间', width: 150 },
            { field: 'hr11_lmuser', title: '修改人', width: 100 },
            { field: 'hr11_lmdt', title: '修改日期', width: 150 },
            { field: 'hr11_uptno', title: '修改次数', width: 100 }
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            var row = $(m_DatagridID).datagrid('getSelected');
            var curl = '';
                // 跳转到明细页 
                var v0 = "old";
                //当前选中的考勤记录
                var v1 = row.hr11_id;
                curl = 'checkAttendanceAdd.html?' + 'v0=' + v0 + '&v1=' + v1
                    +'&s=' + dateUtil_dateFomaterA(new Date(), '-');
           parent.turnPage('B', '', curl);
            
        },
        onClickRow: function (rowIndex) {
        }
    });

    $('#cxpager').pagination({
        total: 0,
        pageNumber: 1,
        pageSize: m_PageSize,//每页显示的记录条数  
        //pageList: [20, 50, 100, 200],//可以设置每页记录条数的列表  
        showPageList: false, //不显示每页记录数列表
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        exportExcel: false,
        onBeforeRefresh: function () {
        },
        onSelectPage: function (pageNumber, pageSize) {
            actLoadData(pageNumber, pageSize);
        },
        buttons: [{
        }]
    });
}


/***********************************************************************
 *  新增申请
 *  
 */
function actAdd() {
    var curl = "";

    //判断当前月份是否已经新增申请
    //若是，则跳转界面新建申请；否则，提示不能再次新增考勤记录
    //校验（考勤每月申请一次） 
    //新建时获取当前月份
    var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
    var cons = ' AND  HR11_ATMonth= \'' + curmonth + '\'' + m_Filter;
    var res = hr_getAttendanceInfo(cons, 1, 10, 'HR11_ATMonth DESC');
    if (res == '') {
        // 跳转到明细页 
        var v0 = "new";
        var v1 = dataUtil_NewGuid();    //主表ID
        var v2 = dataUtil_NewGuid();    //待办ID
        var curl = 'checkAttendanceAdd.html?' + 'v0=' + v0 + '&v1=' + v1
            + '&v2=' + v2 + '&s=' + dateUtil_dateFomaterA(new Date(), '-');
    } else if (res.hr11_id != undefined && res.hr11_id != '') {
        alert('已存在' + curmonth + '月申请，不可新建申请！');
        return;
    } else {
        alert('每月一单,校验失败，请截全屏图发给系统管理员！');
        return;
    }

    if (curl != '') {
        parent.turnPage('B', 'checkAttendance', curl);
    } else {
        alert('url不能为空！');
    }
}


/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条件
    var cons = m_Filter;
    var shopname = $('#shopname').val();
    var month = $('#month').datebox('getValue');
    var createuser = $('#createuser').val();
    if (shopname != '') {
        cons = cons + ' AND ( HR11_ShopName LIKE \'%' + shopname + '%\'';
        cons = cons + '  OR HR11_ShopID LIKE \'%' + shopname + '%\' )';
    }
    if (month != '') {
        cons = cons + ' AND ( HR11_ATMonth LIKE \'%' + month + '%\')';
    }
    if (createuser != '') {
        cons = cons + ' AND ( HR11_RgUser LIKE \'%' + createuser + '%\')';
    }
    var res = hr_getAttendanceInfo(cons, page, number, 'HR11_ATMonth DESC');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    } else if (res.total > 0) {
        $(m_DatagridID).datagrid('loadData', res.rows);
        totalCount = res.total;
    }
    $(m_DatagridID).datagrid("clearSelections");
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });
}


/***********************************************************************
 *  清除
 *  DLY 
 */
function clearText() {
    $('#shopname').val('');
    $('#month').datebox('setValue', '');
    $('#createuser').val('');
}


/***********************************************************************
 * 退出
 *  DLY 
 */
function layout() {
    $.cookie('userName', null);
    $.cookie('empID', null);
    $.cookie('empCode', null);
    m_UserInfo = {};
    top.location.href = loginurl;
}

