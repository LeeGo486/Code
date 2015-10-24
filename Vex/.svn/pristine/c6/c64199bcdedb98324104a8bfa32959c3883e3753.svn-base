/* 全局变量*/
var m_DatagridID = '#jbsqlb'; //加班申请列表
var m_LastIndex = -1;         //人员列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数

//获取用户名
var m_UserInfo = parent.m_UserInfo;


var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' hr1_shopcode ,  hr1_otmonth desc'; //排序方式
 
//var m_preM = dateUtil_getPreMonth('', '-').substring(0, 7); //上个月份
var m_preM = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);//新建月份 

/***********************************************************************
  *  初始化
  *  DLY 
  */
$(function () {
    //用户认证
    if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
        top.location.href = 'error.html';
        return;
    }

    //信息列表
    $(m_DatagridID).datagrid({
        //title:'加班申请列表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 420,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'hr1_otmonth',
        //sortOrder: 'desc',
        remoteSort: false,
        idField: 'hr1_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'hr1_id', title: 'FID', width: 80, hidden: true },
            { field: 'hr1_shopcode', title: '店铺编码', width: 70, sortable: true },
            { field: 'hr1_shopname', title: '店铺名称', width: 300, sortable: true},
            { field: 'hr1_otmonth', title: '申请月份', width: 100, sortable: true},
            { field: 'hr1_state', title: '状态', width: 80, sortable: true}, 
            { field: 'hr1_rguser', title: '创建人', width: 70 },
            { field: 'hr1_rgdt', title: '创建时间', width: 125 },
            { field: 'hr1_lmdt', title: '修改时间', width: 105, hidden: true },
            { field: 'hr1_lmuser', title: '修改人', width: 70, hidden: true },
            { field: 'hr1_uptno', title: '修改次数', width: 70, hidden: true }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
            //查看均不可修改
            var v0 = 'Q2';
            var v1 = 'list';
            var curl = 'overtimesRecode.html?' + 'v0=' + v0 + '&v1=' + v1
                     + '&v2=' + rowData.hr1_id 
                     + '&s='+ new Date().getTime();
            parent.turnPage('B','',curl);
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
        }
        
    });


    if (m_UserInfo.actor = 'A') {
        $('#cxpager').pagination({
            buttons: [{
                text: '新建申请',
                iconCls: 'icon-add',
                handler: function () {
                    // 校验（每月一单） 
                    //var curmonth = dateUtil_dateFomaterA(new Date(), '-');
                    var curmonth = m_preM; 
                    var cons = ' AND  HR1_OTMonth= \'' + curmonth + '\''
                             + ' AND hr1_shopcode = \'' + m_UserInfo.deptCode + '\' ';
                    var res = hr_getOTApply(cons);
                    if (res == '1') {
                        // 跳转到明细页 
                        var v0 = 'N';
                        var v1 = 'list';
                        var curl = 'overtimesRecode.html?' + 'v0=' + v0 + '&v1=' + v1
                                 + '&v2=' + dataUtil_NewGuid();
                        + '&s=' + new Date().getTime();
                        parent.turnPage('B', '', curl);
                    } else if (res.hr1_id != undefined && res.hr1_id != '') {
                        alert('已存在' + curmonth + '月申请，不可新建申请！');
                        return;
                    } else {
                        alert('每月一单,校验失败，请截全屏图发给系统管理员！');
                        return;
                    }
                }
            }]
        });
        m_Filter = ' AND hr1_shopid = \'' + m_UserInfo.deptID + '\' ';
    } else {
        $('#cxpager').pagination({
            buttons: []
        });
        m_Filter = ' AND 1>2 ';
    }
    actLoadData(1, m_PageSize);

});



/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
            + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetHs&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (dataUtil_undefinedOrNull(data.total, 0) == 0) {
                    $(m_DatagridID).datagrid('loadData', []);
                    totalCount = 0;
                } else {
                    totalCount = dataUtil_undefinedOrNull(data.total, 0);
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    $(m_DatagridID).datagrid('clearSelections');
                }
            }
        }
    })

    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });

    m_PageNumber = page;
    m_PageSize = number;
}
