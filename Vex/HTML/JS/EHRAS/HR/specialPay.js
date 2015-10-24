/* 全局变量*/
var m_DatagridID = '#tsxzlb';//特殊薪资列表
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
var m_Types = [];   //0-小时，1-天
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
    if (m_UserInfo.actor = 'A') {
        m_Filter = ' AND HR13_ShopID = \'' + m_UserInfo.deptID + '\' ';
    }
    else {
        m_Filter = ' AND 1=2 ';
    }


    setDataGrid();
    
    //获取跳转前的参数
    var filter = parent.actsonfilter('get');
    if (filter.type == 'specPay') { //恢复到跳转前参数
        setCons(filter);
    }
    else {
        clearText();
        actLoadData(1, m_PageSize);
    }
});


/***********************************************************************
 *  根据跳转前的参数设置页面
 *  DLY
 */
function setCons(filter) {
    $('#shopname').val(filter.shopname);
    $('#month').datebox('setValue',filter.month);
    $('#createuser').val(filter.createuser);
    m_Filter = filter.fil;
    m_Filter1 = filter.fil1;
    actLoadData(filter.page, m_PageSize);
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        if (filter.sid.toUpperCase() == rows[i].hr13_id.toUpperCase()) {
            $(m_DatagridID).datagrid('selectRow', i);
        }
    }
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
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'特殊薪资列表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 400,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'c_code',
        //sortOrder: 'asc',
        remoteSort: false,
        idField: 'hr13_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            //{ field: 'ck', checkbox: true },
            { field: 'hr13_id', title: 'ID', width: 100, hidden: true },
            { field: 'hr13_shopid', title: '店铺ID', width: 65 },
            { field: 'hr13_shopname', title: '店铺名称', width: 250 },
            { field: 'hr13_atmonth', title: '月份', width: 60 },
            { field: 'hr13_money', title: '金额', width: 70 },
            { field: 'hr13_state', title: '状态', width: 60 },
            { field: 'hr13_rguser', title: '创建人', width: 65 },
            {
                field: 'hr13_rgdt', title: '创建时间', width: 125,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'hr13_lmuser', title: '修改人', width: 65 },
            {
                field: 'hr13_lmdt', title: '修改日期', width: 125,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'hr13_uptno', title: '修改次数', width: 55, align: 'center' }
        ]],
        rownumbers: true,
        singleSelect: true,
        onDblClickRow: function (rowIndex) {
            var row = $(m_DatagridID).datagrid('getSelected');

            //设置当前特殊薪资跳转明细前的参数
            var filter = {
                type:'specPay',
                shopname: $('#shopname').val(),
                month: $('#month').datebox('getValue'),
                createuser: $('#createuser').val(),
                page: m_PageNumber,
                rowindex: rowIndex,
                sid: row.hr13_id,
                fil: m_Filter,
                fil1: m_Filter1,
                url_local: window.location.href
            };
            parent.actsonfilter('set', filter);

            var curl = '';
            // 跳转到明细页 
            var v0 = "old";
            var v1 = "list";
            //当前选中的特殊薪资记录 
            var v2 = row.hr13_id;
            curl = 'specialPayRecord.html?' + 'v0=' + v0 + '&v1=' + v1
                + '&v2='+v2+'&l3=特殊薪资查询'+'&s=' + dateUtil_dateFomaterA(new Date(), '-');
            parent.menus_turnPage('B', '', curl);

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
        cons = cons + ' AND ( HR13_ShopName LIKE \'%' + shopname + '%\'';
        cons = cons + '  OR HR13_ShopID LIKE \'%' + shopname + '%\' )';
    }
    if (month != '') {
        cons = cons + ' AND ( HR13_ATMonth LIKE \'%' + month + '%\')';
    }
    if (createuser != '') {
        cons = cons + ' AND ( HR13_RgUser LIKE \'%' + createuser + '%\')';
    }

    var res = hr_getSpecialPay(cons, page, number, 'HR13_ATMonth DESC');

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

    //重置父页面的子页面参数
    parent.actsonfilter('new');
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

