 var m_DatagridID = '#ryxxlb'; //列表ID
 var m_LastIndex = -1;  //人员列表最后一次选中行下标 
 var m_PageNumber = 1;  //当前页码
 var m_PageSize = 10;  //每页显示行数
 
 //状态下拉选择
 var m_protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
 var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = parent.m_UserInfo;

 var m_taskTypes = hr_getBaseItems(3);

 
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
     $('#shopNameSpan').html(m_UserInfo.deptName);  
     $('#pTopLabel3').text(dataUtil_undefinedOrNull(dataUtil_getUrlParam("l3"), '')); 
     //按钮控制
     var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("type"), '');
     if (type != '') {
         $('#btn' + type).show(); // 'btn' + type 为页面按钮ID
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
    if (filter.type != undefined && filter.type == 'pers') { //恢复到跳转前参数 
        searchByCons1(filter);
    } else {
        searchByCons();
    } 
 }); 
 
 
 /***********************************************************************
  *  加载数据
  *  DLY 
  */ 
 function   actLoadData(page,number)   {   
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
 } 
 

/***********************************************************************
 *  获取条件查询
 *  DLY 
 */ 
function searchByCons() { 
    var row = { type: '2', c_employeestatus: '', c_orgunitid: m_UserInfo.deptID };
    m_pers = hr_getShopPers(row);  
	actLoadData(1, m_PageSize);
}

/***********************************************************************
 *  获取条件查询
 *  DLY 
 */
function searchByCons1(filter) { 
    var row = { type: '2', c_employeestatus: '', c_orgunitid: m_UserInfo.deptID };
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
 *  添加右击菜单内容
 *  DLY 
 */ 
function onRowContextMenu(e, rowIndex, rowData){
    e.preventDefault();  
    $('#mm').menu('show', {
        left:e.pageX,
        top:e.pageY
    });  
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
        idField: 'ee1_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'c_id', title: 'FID', width: 80, hidden: true },
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
 *  更新人员.人员调转.人员离职
 *  DLY 
 */
function actTurn(type) {
    var curl = "";
    var ctask = "";
    var row = $(m_DatagridID).datagrid('getSelected');
    if (type == 'add') {
        if (!row) {
            alert('请先选择需更新信息的人员！');
            return false;
        } 
        if (row.c_employeestatus != '1' && row.c_employeestatus != '2' && row.c_employeestatus != '6') {
            alert('该人员状态不可更新信息！');
            return false;
        }
        var v0 = 'old';
        var v1 = 'list'
        var v2 = row.c_oid;
        ctask = m_taskTypes[2].value
        curl = 'perInfo.html?' + 'v0=' + v0 + '&v1=' + v1 + '&v2=' + v2
                 + '&s=' + new Date().getTime(); 
    } else if (type == 'turn') { 
        if (!row) {
            alert('请先选择需调转的人员！');
            return false;
        }
        if (row.c_employeestatus == '3' || row.c_employeestatus == '8') {
            alert('该人员状态不可调转！');
            return false;
        }
        var v0 = 'old';
        var v1 = 'list'
        var v2 = row.c_oid;
        ctask = m_taskTypes[3].value
        curl = 'perTurn.html?' + 'v0=' + v0 + '&v1=' + v1 + '&v2=' + v2
                    + '&s=' + new Date().getTime();
    } else if (type == 'dimiss') { 
        if (!row) {
            alert('请先选择离职的人员！');
            return false;
        }
        if (row.c_employeestatus == '3') {
            alert('该人员已离职！');
            return false;
        } 
        var v0 = 'old';
        var v1 = 'list'
        var v2 = row.c_oid;
        ctask = m_taskTypes[4].value
        curl = 'perDimiss.html?' + 'v0=' + v0 + '&v1=' + v1 + '&v2=' + v2
                    + '&s=' + new Date().getTime(); 
    }

    if (curl != '') { 
        curl = curl + '&l1=店铺管理&l2=人员&l3=' + ctask;
        //保存当前页参数到父页面 end
        var filter = {
            type: "pers",
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

 
 