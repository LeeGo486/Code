 var m_DatagridID = '#ryxxlb'; //列表ID
 var m_LastIndex = -1;  //人员列表最后一次选中行下标 
 var m_PageNumber = 1;  //当前页码
 var m_PageSize = 10;  //每页显示行数 

 var m_DatagridID1 = '#deptgrid'; //部门选择列表ID
 var m_LastIndex1 = -1;  //部门选择列表最后一次选中行下标 
 var m_PageSize1 = 20;  //查询记录数
 var m_dlgID = '#deptdlg'; //部门选择窗ID
 var m_dlgOFlag = 0; //是否首次打开标志
 
 //状态下拉选择
 var m_protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
 var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = parent.m_UserInfo;  
 
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

     //当店长查询时，直接显示当前店员的所有信息
     if (m_UserInfo.actor == 'A') {
         $('#c_unitname').val(m_UserInfo.deptName);
         $('#c_unitid').val(m_UserInfo.deptID);
         $('#deptdisplay').hide();
     }
	

    //基础数据获取 
    var type1 = hr_getCodeType(1);// 员工状态  
    var types = '\'0\','+ '\''+type1+'\''; 
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
     var filter = parent.actsonfilter('get');
     if (filter.type != undefined && filter.type == 'perQ') { //恢复到跳转前参数 
         searchByCons1(filter);
     } else { 
         searchByCons(); 
     }
 }); 
 
 
 /***********************************************************************
  *  加载数据
  *  DLY 
  */ 
 function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var rows = [];
    for (var i = 0; i < m_pers.length; i++) {
        if (i >= (page - 1) * number && i < page * number) {  
            rows.push(m_pers[i]);
        }
    }
    totalCount = m_pers.length;
    $(m_DatagridID).datagrid('loadData', rows);
    $(m_DatagridID).datagrid('clearSelections');
     
 	$('#cxpager').pagination({
 		total:totalCount,
 		pageNumber:page
 	});   
	m_PageNumber = page;
	m_PageSize = number;

     //重置父页面的子页面参数
	parent.actsonfilter('new');
 } 
 

 /***********************************************************************
  *  获取条件查询
  *  DLY 
  */
 function searchByCons() {
     var c_orgunitid = $('#c_unitid').val();
     var row = { type: '2', c_employeestatus: '', c_orgunitid: c_orgunitid };
     m_pers = hr_getShopPers(row);
     actLoadData(1, m_PageSize); 
 }

/***********************************************************************
 *  获取条件查询
 *  DLY 
 */ 
 function searchByCons1(filter) {  
     $('#c_unitid').val(filter.c_unitid);
     $('#c_unitname').val(filter.c_unitname);
     var c_orgunitid = $('#c_unitid').val();
     var row = { type: '2', c_employeestatus: '', c_orgunitid: c_orgunitid };
     m_pers = hr_getShopPers(row);  
     actLoadData(filter.page, m_PageSize);
     var rows = $(m_DatagridID).datagrid('getRows');
     for (var i = 0; i < rows.length; i++) {
         if (filter.sid.toUpperCase() == rows[i].c_oid.toUpperCase()) {
             $(m_DatagridID).datagrid('selectRow', i);
         }
     }
} 
   
   
/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {  

    //信息列表
    $(m_DatagridID).datagrid({
        //title:'人员信息表',
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
        idField: 'c_oid',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'c_oid', title: 'FID', width: 80, hidden: true },
            { field: 'c_code', title: '编号', width: 70, sortable: true },
            { field: 'c_name', title: '姓名', width: 70, sortable: true },
            { field: 'c_employeestatus', title: '状态', width: 70
                , formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_employeestatus, val, 'c_code', 'c_name');
                }
            },
            { field: 'c_jobname', title: '岗位', width: 100 },
            { field: 'c_hiredate', title: '入司日期', width: 80 }

        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function () {
            actAdd('old3');
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
        var curl = 'perInfo.html?' + 'v0=' + v0 + '&v1=' + v1 + '&v2=' + v2 + '&l3=查询' 
                 + '&s=' + new Date().getTime(); 
    }  
    if (curl != '') { 
        //保存当前页参数到父页面 end
        var filter = {
            type: "perQ", c_unitid: $('#c_unitid').val(),
            c_unitname: $('#c_unitname').val(),
            page: m_PageNumber,
            sid: row.c_oid,
            url_local: window.location.href
        };
        parent.actsonfilter('set', filter);
        //页面跳转
        parent.menus_turnPage('B', 'personsPage', curl);
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
    if (m_dlgOFlag == 0) {
        $(m_DatagridID1).datagrid({
            //title:'部门信息表',  
            width: "auto",
            height: 300,
            nowrap: true,
            striped: true,
            collapsible: true,
            //sortName: 'sid',
            //sortOrder: 'asc',
            remoteSort: false,
            idField: 'c_unitid',
            columns: [[
                { field: 'c_orgid', title: '公司id', width: 70, hidden: true },
                { field: 'c_orgcode', title: '公司编码', width: 70 },
                { field: 'c_orgname', title: '公司名称', width: 180 },
                { field: 'c_unitid', title: '部门ID', width: 70},
                { field: 'c_unitcode', title: '部门编码', width: 70 },
                { field: 'c_unitname', title: '部门名称', width: 260 }
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
        
        
        if (m_UserInfo.actor == 'C') {
            //人资只可查看本公司的部门
            //cons1 = cons1 + ' AND B.orgid = ' + m_UserInfo.selfInfo.c_orgid + '';
            //人资只可配置公司的部门
            cons1 = cons1 + ' AND B.orgid in (' + m_UserInfo.comIDs + '-2 )';
        } else { //大区经理或城市经理只可查看涉及部门
            cons = cons + ' AND ( A.C_OID_ORGUNIT in (' + m_UserInfo.shopids + ') '
                 +  ' OR A.C_OID_ORGUNIT in (' + m_UserInfo.shopids1 + ') )';
        }
        //alert(cons);
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
        $('#c_unitname').val(row.c_unitname);
        $('#c_unitid').val(row.c_unitid); 
        $(m_dlgID).dialog('close');
        searchByCons();
    } else {
        alert('请选择部门记录！');
        return false;
    } 
}