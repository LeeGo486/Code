var m_DatagridID = '#ryxxlb'; //列表ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

var m_DatagridID1 = '#deptgrid'; //部门选择列表ID
var m_LastIndex1 = -1;  //部门选择列表最后一次选中行下标 
var m_PageSize1 = 20;  //查询记录数
var m_dlgID = '#deptdlg'; //部门选择窗ID
var m_dlgOFlag = 0; //是否首次打开标志
var m_dlgID1 = '#cfgdlg'; //配置窗ID

//状态下拉选择
var m_protimesZT = [{ statets: '启用', statevs: '启用' }, { statets: '禁用', statevs: '禁用' }];
var m_depttree = []; //组织架构树

//用户信息
var m_UserInfo = parent.m_UserInfo;


var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' hr9_posshopcode '; //排序方式

var m_pers = [];
var m_employeestatus = [];

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
    
    //同一人负责自己所在公司
    //m_Filter1 = ' AND hr9_type = \'1\' AND  hr9_ehrorgid = \'' + dataUtil_undefinedOrNull(m_UserInfo.comID, '') + '\'';

    //同一人负责多个公司
    m_Filter1 = ' AND hr9_type = \'1\' AND  hr9_ehrorgid in (' + dataUtil_undefinedOrNull(m_UserInfo.comIDs, '') + '-2)';

    //alert(m_Filter1);
    //基础数据获取 
    var type1 = hr_getCodeType(1);// 员工状态  
    var types = '\'0\',' + '\'' + type1 + '\'';
    var row = { c_typecode: types };
    var codeitems = hr_getCodeItems(row);
    for (var i = 0; i < codeitems.length; i++) {
        var t1 = codeitems[i].c_typecode.toUpperCase();
        if (t1 == type1.toUpperCase()) {
            m_employeestatus.push(codeitems[i]);
        }
    }
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
    var cons = '';
    var dpmc = $('#c_unitname').val();
    var dqjl = $('#c_dqjl').val();
    if (dpmc != '') {
        cons = cons + ' AND ( hr9_posshopname LIKE \'%' + dpmc + '%\'';
        cons = cons + '  OR hr9_ehrunitname LIKE \'%' + dpmc + '%\' )';
    }
    if (dqjl != '') {
        cons = cons + ' AND ( hr9_dqjlempname LIKE \'%' + dqjl + '%\'';
        cons = cons + '  OR hr9_dqjlempcode LIKE \'%' + dqjl + '%\' )';
    } 

    cons = cons + m_Filter1;
    var res = hr_getSYSConfig1(cons, page, number, m_OrderBy);

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    }else if (res.total > 0) { 
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
   $('#c_unitname').val('');
   $('#c_dqjl').val('');
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
        height: 420,
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
            { field: 'hr9_ehrorgid', title: 'HROID', width: 70, hidden: true },
            { field: 'hr9_posshopcode', title: 'pos店铺编码', width: 100}, 
            { field: 'hr9_posshopname', title: 'pos店铺名称', width: 200 },
            { field: 'hr9_poscostcenter', title: 'pos成本中心', width: 100},
            { field: 'hr9_ehrunitid', title: 'ehr店铺ID', width: 100 },
            { field: 'hr9_ehrunitname', title: 'ehr店铺名称', width: 200 },
            { field: 'hr9_dqjlempname', title: '大区经理', width: 100 },
            { field: 'hr9_dqjlempcode', title: '员工号', width: 100 },
            { field: 'hr9_csjlempname', title: '城市经理', width: 100 },
            { field: 'hr9_csjlempcode', title: '员工号', width: 100 }

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
        buttons: []
    });

    //m_UserInfo.comID
}


/***********************************************************************
 *  查看人员信息
 *  DLY 
 */
function actAdd(type) {
    var curl = "";
    if (type == 'old3') {
        var row = $(m_DatagridID).datagrid('getSelected');
        if (!row) {
            return false;
        }
        var v0 = 'old3';
        var v1 = 'list'
        var v2 = row.c_oid;
        var curl = 'perInfo.html?' + 'v0=' + v0 + '&v1=' + v1 + '&v2=' + v2
                 + '&s=' + new Date().getTime();
        var filter = {
            type: "perQ", c_unitid: $('#c_unitid').val(),
            c_unitname: $('#c_unitname').val(),
            page: m_PageNumber,
            sid: row.c_oid
        };
        parent.actsonfilter('set', filter);
    }
    //保存当前页参数到父页面 end
    if (curl != '') {
        parent.turnPage('B', 'personsPage', curl);
    } else {
        alert('url不能为空！');
    }
}


/***********************************************************************
 *  打开部门选择窗体
 *  DLY 
 */
function openDeptdlg() {
    $(m_dlgID).dialog('open'); 
    $('#cxDept').val($('#posdeptname').val());
    if (m_dlgOFlag == 0) {
        $(m_DatagridID1).datagrid({
            //title:'部门信息表',  
            width: "auto",
            height: 320,
            nowrap: true,
            striped: true,
            collapsible: true,
            //sortName: 'sid',
            //sortOrder: 'asc',
            remoteSort: false,
            idField: 'c_unitid',
            columns: [[
                { field: 'c_orgid', title: '公司id', width: 70, hidden: true },
                { field: 'c_orgcode', title: '公司编码', width: 70, hidden: true },
                { field: 'c_orgname', title: '公司名称', width: 180 },
                { field: 'c_unitid', title: '部门ID', width: 70 },
                { field: 'c_unitcode', title: '部门编码', width: 70 },
                { field: 'c_unitname1', title: '部门名称', width: 200 },
                { field: 'c_unitname', title: '路径', width: 260 } 
            ]],
            pagination: false,
            rownumbers: true,
            singleSelect: true,
            onClickRow: function (rowIndex) {
            },
            onDblClickRow: function () {
                setDeptxx();
            }

        });

        m_dlgOFlag = 1;
    }
    $(m_DatagridID1).datagrid('clearSelections');
    //$('#cxDept').val('');
    //$(m_DatagridID).datagrid('loadData', []);
}


/***********************************************************************
 *  查询部门或清除条件
 *  DLY 
 */
function searchDepts(type) {
    if (type == 'Query') {
        var cxDept = $('#cxDept').val();
        //if ($('#cxDept').val() == '') {
        //    alert('请填写部门名称查询条件！');
        //    return false;
        //}
        var cons = '';
        var cons1 = '';
        if ($('#cxDept').val() != '') {
            cons = cons + ' AND A.C_NAME like \'%' + cxDept + '%\' ';
        }
        
        //人资只可配置公司的部门
        if (m_UserInfo.actor == 'C') {
            //人资只可查看本公司的部门
            //cons1 = cons1 + ' AND B.orgid = ' + m_UserInfo.selfInfo.c_orgid + ''; 
            cons1 = cons1 + ' AND B.orgid in (' + m_UserInfo.comIDs + '-2 )';
        } else {
            cons1 = ' AND 1>2  '

        }
        var row = { cons: cons, type: '3', rows: m_PageSize1, cons1: cons1 };
        var depts = hr_getUnitInfo(row);
        $(m_DatagridID1).datagrid('loadData', depts);
        $(m_DatagridID1).datagrid('clearSelections');
    } if (type == 'Clear') {
        $('#cxDept').val('');
    }
}


/***********************************************************************
 *  填充选中部门到页面
 *  DLY 
 */
function setDeptxx() {
    var row = $(m_DatagridID1).datagrid('getSelected');
    if (row) { 
        $('#hrdeptid').val(row.c_unitid);
        $('#hrdeptname').val(row.c_unitname1);
        $(m_dlgID).dialog('close'); 
    } else {
        alert('请选择部门记录！');
        return false;
    }
}
 

/***********************************************************************
 *  打开配置窗体
 *  DLY 
 */
function openCfgdlg(rowI, rowD) { 
    $('#posdeptname').val(rowD.hr9_posshopname);
    $('#hrdeptid').val(rowD.hr9_ehrunitid);
    $('#hrdeptname').val(rowD.hr9_ehrunitname);
    $('#hrdqjlxm').val(rowD.hr9_dqjlempname);
    $('#hrdqjlgh').val(rowD.hr9_dqjlempcode);
    $('#hrcsjlxm').val(rowD.hr9_csjlempname);
    $('#hrcsjlgh').val(rowD.hr9_csjlempcode);
    $(m_dlgID1).dialog('open');
}


/***********************************************************************
 *  提交配置
 *  DLY 
 */
function upCfgdlg() {
    //校验
    var hrdeptid = $('#hrdeptid').val();
    var hrdeptname = $('#hrdeptname').val();
    var hrdqjlxm = $('#hrdqjlxm').val();
    var hrdqjlgh = $('#hrdqjlgh').val();
    var hrcsjlxm = $('#hrcsjlxm').val();
    var hrcsjlgh = $('#hrcsjlgh').val();
    if (hrdeptid == '' || hrdeptname == '') {
        alert('hr部门不能为空！');
        return false;
    }
    if (hrdqjlxm == '') {
        alert('大区经理姓名不能为空！');
        return false;
    }
    if (hrdqjlgh == '') {
        alert('大区经理员工号不能为空！');
        return false;
    }
    var row = $(m_DatagridID).datagrid('getSelected');
    if (row) {
        if (hrdeptid == row.hr9_ehrunitid
            && hrdeptname == row.hr9_ehrunitname
            && hrdqjlxm == row.hr9_dqjlempname
            && hrdqjlgh == row.hr9_dqjlempcode
            && hrcsjlxm == row.hr9_csjlempname
            && hrcsjlgh == row.hr9_csjlempcode) { // 没有调整
            $(m_dlgID1).dialog('close');
        } else {
            $.messager.confirm('确认框', '确认提交吗？', function (r) {
                if (r) {
                    var row1 = {
                        id: row.hr9_id, unitid: hrdeptid,
                        unitname: hrdeptname, percode: hrdqjlgh,
                        pername: hrdqjlxm, actor: m_UserInfo.userName,
                        pername1: hrcsjlxm, percode1: hrcsjlgh
                    }
                    var res = hr_updSysCfg(row1);
                    if (res == 'T') {
                        $(m_dlgID1).dialog('close');
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
        $(m_dlgID1).dialog('close');
    }
    
    
}