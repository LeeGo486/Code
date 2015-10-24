var m_DatagridID = '#ryxxlb'; //列表ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

var m_dlgID = '#cfgdlg'; //配置窗ID

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' hr9_ehrorgid '; //排序方式

/***********************************************************************
 *  初始化
 *  DLY 
 */
$(function () {
    // 滚动条居顶
    parent.sc();

    //用户认证
    if (m_UserInfo == undefined || m_UserInfo.userName == undefined) {
        top.location.href = 'error.html';
        return;
    }

    //同一人负责多个公司
    m_Filter = ' AND hr9_type = \'0\'';


    //基础数据获取 
    //var type1 = hr_getCodeType(1);// 员工状态  
    //var types = '\'0\',' + '\'' + type1 + '\'';
    //var row = { c_typecode: types };
    //var codeitems = hr_getCodeItems(row);
    //for (var i = 0; i < codeitems.length; i++) {
    //    var t1 = codeitems[i].c_typecode.toUpperCase();
    //    if (t1 == type1.toUpperCase()) {
    //        m_employeestatus.push(codeitems[i]);
    //    }
    //}


    // 初始化查询
    setDataGrid();
    clearText();
    actLoadData(1, m_PageSize);

});


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
    var orgname = $('#orgname').val();
    var rzemp = $('#rzemp').val();
    if (orgname != '') {
        cons = cons + ' AND ( hr9_com LIKE \'%' + orgname + '%\')';
    }
    if (rzemp != '') {
        cons = cons + ' AND ( hr9_rzempname LIKE \'%' + rzemp + '%\')';
    }

    var res = hr_getSYSConfig1(cons, page, number, m_OrderBy);

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
    $('#orgname').val('');
    $('#rzemp').val('');
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'权限配置表',
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
        idField: 'hr9_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'hr9_id', title: 'FID', width: 80, hidden: true },
            { field: 'hr9_ehrorgid', title: '公司编号', width: 95 },
            { field: 'hr9_com', title: '公司名称', width: 100 },
            { field: 'hr9_rzempname', title: '总部人资', width: 80 },
            { field: 'hr9_rzempcode', title: '员工号', width: 80 },
            { field: 'hr9_remark', title: '描述', width: 300 }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
           openCfgdlg(rowIndex, rowData);
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
        buttons: [{}]
    });
}


/***********************************************************************
 *  打开配置窗体
 *  DLY 
 */
function openCfgdlg(rowI, rowD) {
    $('#comname').val(rowD.hr9_com);
    $('#comid').val(rowD.hr9_ehrorgid);
    $('#rzempname').val(rowD.hr9_rzempname);
    $('#rzempcode').val(rowD.hr9_rzempcode);
    $(m_dlgID).dialog('open');
}


/***********************************************************************
 *  提交配置
 *  DLY 
 */
function upCfgdlg() {
    //校验
    var comname = $('#comname').val();
    var comid = $('#comid').val();
    var rzempname = $('#rzempname').val();
    var rzempcode = $('#rzempcode').val();
    if (rzempname == '' || rzempcode == '') {
        alert('人资信息不能为空！');
        return false;
    }
    var row = $(m_DatagridID).datagrid('getSelected');
    if (row) {
        if (comname == row.hr9_com
            && comid == row.hr9_ehrorgid
            && rzempname == row.hr9_rzempname
            && rzempcode == row.hr9_rzempcode) { // 没有调整
            $(m_dlgID).dialog('close');
        } else {
            $.messager.confirm('确认框', '确认提交吗？', function (r) {
                if (r) {
                    var rowRZ = {
                        orgid:comid,
                        percode:$('#rzempcode').val(),
                        pername:$('#rzempname').val(),
                        actor:m_UserInfo.userName
                    }
                    var res = hr_updRZSysCfg(rowRZ);
                    if (res == 'T') {
                        $(m_dlgID).dialog('close');
                        alert('提交成功！');
                        actLoadData(m_PageNumber, m_PageSize);
                    } else {
                        alert('提交失败！');
                    }
                }
            });
        }
    } else {
        alert('未找到选择行，请重新选择行！');
        $(m_dlgID).dialog('close');
    }


}