var m_DatagridID = '#fazlb'; //主列表ID
var m_PaginationID = '#cxpager';   //分页ID
var m_LastIndex = -1;  //主列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 
 
var m_DatagridID1 = '#faclb'; //从列表ID
var m_LastIndex1 = -1;  //从列表最后一次选中行下标 

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = 'CompanyID, PlanID'; //排序方式
var m_OrderBy1 = 'CompanyID, PlanID, SalesAmount1'; //排序方式

//基础数据 
var m_Companys = [];    //公司 
var m_SalesType = [];   //销售类型
var m_IsUse = [];       //状态
var m_Job = [];         //岗位

var m_OpenFlag = 'init';     //打开明细窗标志 init-初始化， add-新增， edit-编辑

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
   
    //获取公司
    var cons1 = ' AND HR9_TYPE = 0';
    m_Companys = hr_getSYSConfig(cons1, 1, 1000, 'HR9_Com');  
    hr_setCombobox('#cxCompany', 150, 150, 135, false, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);

    //获取基础数据   
    var cons2 = ' AND Status = 1';
    cons2 = cons2 + ' AND TypeCode IN (\'Code_Status\', \'Code_SalesType\', \'Code_Job\')';
    var res = hr_getDBCode(cons2, '1', '1000', 'TypeCode, Seq', 'GetSYSCodeItem'); 
    for (var i = 0; i < res.rows.length; i++) {
        if (res.rows[i].typecode == 'Code_Status') {
            m_IsUse.push(res.rows[i]);
        } else if (res.rows[i].typecode == 'Code_SalesType') {
            m_SalesType.push(res.rows[i]);
        } else if (res.rows[i].typecode == 'Code_Job') {
            m_Job.push(res.rows[i]);
        }
    } 

    //设置表格
    setDataGrid(m_DatagridID); 
    //根据权限显示按钮
    setPagination(m_UserInfo.actor);
    //初始化条件
    clearText();
    //加载数据
    actLoadData(m_PageNumber, m_PageSize); 
});
   

/***********************************************************************
 *  清除
 *  DLY 
 */
function clearText() {
    $('#cxCompany').combobox('setValue','');
    $('#cxPlan').val('');
}


/***********************************************************************
*  设置主列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'销售提成方案',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 400,
        nowrap: true,
        striped: true,
        collapsible: true, 
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[ 
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'shopid', title: '店铺', width: 80, hidden: true },
            { field: 'shoptype', title: '店铺类型', width: 80, hidden: true },
            { field: 'companyid', title: '公司', width: 120
                 , formatter: function (val, row, index) {
                     return dataUtil_getCodename(m_Companys, val, 'hr9_ehrorgid', 'hr9_com');
                 }
            },
            { field: 'planid', title: '奖励方案ID', width: 100},
            { field: 'postid', title: '岗位', width: 100 },
            { field: 'salesid', title: '销售类型', width: 100
                , formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_SalesType, val, 'code', 'name');
                }
            },
            { field: 'clerknum', title: '店员数', width: 50, align:"right" },
            { field: 'remark', title: '奖励方案描述', width: 330 },
            { field: 'isuse', title: '状态', width: 40
              , formatter: function (val, row, index) {
                  return dataUtil_getCodename(m_IsUse, val, 'code', 'name');
              }
            }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
            openCfgDlg('edit');
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        },
        onRowContextMenu: function (e, rowIndex, rowData) { 
        }
    });
}


/***********************************************************************
*  设置分页
*  SY 
*/
function setPagination(actor) { 
    //设置分页控件
    $(m_PaginationID).pagination({
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
            id: 'btnadd',
            text: ' 新增 ',
            iconCls: 'icon-plus-green',
            handler: function () {
                openCfgDlg('add');
            }
        }, {
            id: 'btnedit',
            text: ' 编辑 ',
            iconCls: 'icon-edit-green',
            handler: function () {
                openCfgDlg('edit');
            }
        }]
    }); 
}


/***********************************************************************
*  设置从列表
*  DLY 
*/
function setDataGrid1() {
    //信息列表
    $(m_DatagridID1).datagrid({
        //title:'销售提成方案明细',  
        width: 355,
        height: 200,
        nowrap: true,
        striped: true,
        collapsible: true,
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'shopid', title: '店铺', width: 80, hidden: true },
            { field: 'shoptype', title: '店铺类型', width: 80, hidden: true },
            { field: 'companyid', title: '公司', width: 120, hidden: true},
            { field: 'planid', title: '方案ID', width: 100, hidden: true},
            { field: 'postid', title: '岗位', width: 100, hidden: true },
            { field: 'salesid', title: '销售类型', width: 100, hidden: true},
            { field: 'clerknum', title: '店员数', width: 50, hidden: true},
            { field: 'remark', title: '方案描述', width: 330, hidden: true },
            { field: 'isuse', title: '状态', width: 40, hidden: true },
            { field: 'salesamount1', title: '销售额起', width: 100, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min:0 }}},
            { field: 'salesamount2', title: '销售额止', width: 100, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 }}},
            { field: 'bonusamount', title: '突破奖金', width: 100, align: "right"
				, editor: { type: 'numberbox', options: { precision: 2, min: 0 }}}
        ]],
        rownumbers: true,
        singleSelect: true, 
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) { 
            $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
            $(m_DatagridID1).datagrid('selectRow', rowIndex);  
            $(m_DatagridID1).datagrid('beginEdit', rowIndex); 
            m_LastIndex1 = rowIndex;
        } 
    });
}


/***********************************************************************
 *  加载方案主数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条 
    var cons = '';
    var cxCompany = $('#cxCompany').combobox('getValue');
    var cxPlan = $('#cxPlan').val();

    if (cxCompany != '') {
        cons = cons + ' AND CompanyID LIKE \'%' + cxCompany + '%\' ';
    }
    if (cxPlan != '') {
        cons = cons + ' AND ( PlanID LIKE \'%' + cxPlan + '%\'';
        cons = cons + ' OR Remark LIKE \'%' + cxPlan + '%\' ) ';
    }
    
    var SPCons = '【操作类型,GET】【实体, 查询方案】【CONO,】【DIVI,】'
               + '【《W》页码,' + page + '】'
	           + '【《W》记录数,' + number + '】'
	           + '【《W》条件,' + cons + '】'
	           + '【《W》排序,' + m_OrderBy + '】'
	           + '【返回内容, 主表列表】'
    SPCons = '<SPCons>' + SPCons + '</SPCons>'
    var rows = hr_actSP_SalesBreachPlan(SPCons, m_UserInfo.userName); 
    //alert(jsonUtil_jsonToStr(rows));
    if (rows == '') {
        alert('查询失败！');
    } else if (rows.length > 0 && rows[0].nid != '') {
        $(m_DatagridID).datagrid('loadData', rows);
        totalCount = rows[0].total;
    }
    $(m_DatagridID).datagrid("clearSelections");
    $('#cxpager').pagination({
        total: totalCount,
        pageNumber: page
    });
}


/***********************************************************************
 *  加载方案明细数据
 *  DLY 
 */
function actLoadData1(type) {
    var rows = []
    if (type == 'edit') { 
        var row = $(m_DatagridID).datagrid('getSelected'); 
        // 拼接查询条 
        var cons = ' AND PlanID = \'' + row.planid + '\'';
        var res = hr_getSalesBreachPlan(cons, '1', '100', m_OrderBy1);
        if (res == '') {
            alert('查询方案明细失败！');
        } else { 
            rows = res.rows;

        }
    }
    $(m_DatagridID1).datagrid('loadData', rows); 
    $(m_DatagridID1).datagrid("clearSelections"); 
}


/***********************************************************************
 *  打开明细窗
 *  DLY 
 */
function openCfgDlg(type) {
    if (type == 'edit') {
        var row = $(m_DatagridID).datagrid('getSelected');
        if (!row) {
            alert('请先选择编辑记录');
            return false;
        }
    }
    if (m_OpenFlag == 'init') {
        initCfgDlg('init');
        setDataGrid1();
    }
    actLoadData1(type);
    initCfgDlg(type);
    $('#cfgdlg').dialog('open'); 
    m_OpenFlag = type; 
}


/***********************************************************************
 *  初始化明细窗控件
 *  DLY 
 */
function initCfgDlg(type) {
    if (type == 'init') {
        hr_setCombobox('#companyid', 153, 153, 135, false, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);
        hr_setCombobox('#salesid', 150, 150, 85, false, false, 'code', 'name', m_SalesType);
        hr_setCombobox('#postid', 108, 108, 135, false, false, 'name', 'name', m_Job);
        hr_setCombobox('#isuse', 150, 150, 65, false, false, 'code', 'name', m_IsUse);
    } else if (type == 'add') {
        $('#companyid').combobox('setValue', '');
        $('#salesid').combobox('setValue', '');
        $('#postid').combobox('setValue', '');
        $('#isuse').combobox('setValue', '1');
        $('#planid').val('');
        $('#remark').val('');
        $('#clerknum').numberbox('setValue', '0');
        $('#planid').attr('disabled',false);
    } else if (type == 'edit') {
        var row = $(m_DatagridID).datagrid('getSelected');
        $('#companyid').combobox('setValue', row.companyid);
        $('#salesid').combobox('setValue', row.salesid);
        $('#postid').combobox('setValue', row.postid);
        $('#isuse').combobox('setValue', row.isuse);
        $('#planid').val(row.planid);
        $('#remark').val(row.remark);
        $('#clerknum').numberbox('setValue', row.clerknum); 
        $('#planid').attr('disabled', true);
    }
}
 

/***********************************************************************
 *  添加明细
 *  DLY 
 */
function actAdd() {
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
    var row1 = {};
    row1.id = dataUtil_NewGuid();
    $(m_DatagridID1).datagrid('appendRow', row1);
    m_LastIndex1 = $(m_DatagridID1).datagrid('getRows').length-1
    $(m_DatagridID1).datagrid('selectRow', m_LastIndex1);
    $(m_DatagridID1).datagrid('beginEdit', m_LastIndex1);
}


/***********************************************************************
 *  删除
 *  DLY 
 */
function actDelete() {
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
    var row1 = $(m_DatagridID1).datagrid('getSelected');
    var rindex = $(m_DatagridID1).datagrid('getRowIndex', row1);
    $(m_DatagridID1).datagrid('deleteRow', rindex);	//通过行号移除该行 
}


/***********************************************************************
 *  提交配置
 *  DLY 
 */
function upCfgdlg() {
    var flag = false; 
    if ($('#planid').val() == '') {
        alert('方案ID不能为空！');
        return flag;
    }
    if ($('#remark').val() == '') {
        alert('方案描述不能为空！');
        return flag;
    }
    if ($('#companyid').combobox('getValue') == '') {
        alert('公司不能为空！');
        return flag;
    }
    if ($('#salesid').combobox('getValue') == '') {
        alert('销售类型不能为空！');
        return flag;
    }
    if ($('#postid').combobox('getValue') == '') {
        alert('岗位不能为空！');
        return flag;
    }
    if ($('#clerknum').numberbox('getValue') == '') {
        alert('店员数不能为空！');
        return flag;
    }
    if ($('#isuse').combobox('getValue') == '') {
        alert('状态不能为空！');
        return flag;
    }
    $(m_DatagridID1).datagrid('endEdit', m_LastIndex1);
    var rows = $(m_DatagridID1).datagrid('getRows');
    var dataRows = []; 
    var j = 1
    for (var i = 0; i < rows.length; i++) {
        j = i * 1 + 1;
        if (rows[i].salestarget1 == '') { 
            alert('第' + j + '行销售额起不能为空！');
            return flag;
        }
        if (rows[i].salesamount2 == '') {
            alert('第' + j + '行销售额止不能为空！');
            return flag;
        }
        if (rows[i].bonusamount == '') {
            alert('第' + j + '行突破奖金不能为空！');
            return flag;
        }
        var row1 = {};
        row1.id = rows[i].id;
        row1.salesamount1 = rows[i].salesamount1;
        row1.salesamount2 = rows[i].salesamount2;
        row1.bonusamount = rows[i].bonusamount;

        row1.rguser = m_UserInfo.userName;
        row1.rgdt = dateUtil_dateFomaterA(new Date(), '-');

        row1.planid = $('#planid').val();
        row1.remark = $('#remark').val();
        row1.clerknum = $('#clerknum').numberbox('getValue');
        row1.companyid = $('#companyid').combobox('getValue');
        row1.salesid = $('#salesid').combobox('getValue');
        row1.postid = $('#postid').combobox('getValue');
        row1.isuse = $('#isuse').combobox('getValue'); 

        dataRows.push(row1);
    } 
    var cXML1 = GetEditJson([], [], []);
    if (m_OpenFlag == 'add') { 
        if (dataRows.length == 0) {
            alert('请填写明细！');
            return false;
        }
        cXML1 = GetEditJson(dataRows, [], []);//json转xml
    } else if (m_OpenFlag == 'edit') {
        var row2 = {};
        row2.planid = $('#planid').val();
        row2.bakuser = m_UserInfo.userName;
        row2.bakdt = dateUtil_dateFomaterA(new Date(), '-');
        var bakRows = [];
        bakRows.push(row2);
        cXML1 = GetEditJson([], dataRows, bakRows);//json转xml
    } 
    flag = hr_saveSalesBreachPlan(cXML1, m_UserInfo.userName);
    if (flag) {
        $('#cfgdlg').dialog('close');
        //刷新主数据
        actLoadData(m_PageNumber, m_PageSize);
        $(m_DatagridID).datagrid('selectRow', m_LastIndex);
        alert('提交成功！');
    }
    return flag;
}