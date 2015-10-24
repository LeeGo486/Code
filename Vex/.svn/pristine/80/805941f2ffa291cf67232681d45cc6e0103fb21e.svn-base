var m_DatagridID = '#ryxxlb'; //列表ID
var m_PaginationID = '#cxpager';   //分页ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

var m_dlgupdcfgID = '#ryxxupddlg'; //更新    

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = 'unitcode,empcode'; //排序方式

//基础数据
var m_WorkTeams = [];           //班组
var m_SalesType = [];           //销售类型
var m_employeestatus = [];      //员工状态
var m_Companys = [];            //公司 
var m_IsUse = [];               //状态 
var m_IsCfg = [{ code: '0', name: '未配置' }, { code: '1', name: '已配置' }]; //条件是否配置

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300];
var actorType = 'AT1'; // AT1-店长  AT2-人资  AT3-管理员  

var m_OpenFlag = '0';     //打开明细窗标志 0-首次打开， 1-非首次打开

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

    //权限的设置
    m_Filter = ' AND 1 = 2 ';
    if (m_UserInfo.actor == 'E') { 
        m_Filter = '';
        actorType = 'AT3';
    } else if (m_UserInfo.actor == 'C') { //人资 大区经理或城市经理只可查看涉及部门
        m_Filter = 'AND OrgID IN (' + m_UserInfo.comIDs + '-2 )';
        actorType = 'AT2';
    } else if (m_UserInfo.actor == 'A') {
        m_Filter = ' AND UnitID=\'' + m_UserInfo.deptID + '\''; 
    }


    //获取公司选项 
    var cons = ' AND 1 = 2 ';
    if (m_UserInfo.actor == 'E') { 
        cons = ' AND HR9_TYPE = 0 ';
    } else if (m_UserInfo.actor == 'C') { //人资 大区经理或城市经理只可查看涉及部门
        cons = ' AND HR9_TYPE = 0  '
             + ' AND HR9_EHROrgID IN (' + m_UserInfo.comIDs + '-2 )';
    } 
    m_Companys = hr_getSYSConfig(cons, 1, 1000, 'HR9_Com'); 
    hr_setCombobox('#orgname', m_widths[0], m_widths[0], m_widths[3], true, false, 'hr9_ehrorgid', 'hr9_com', m_Companys);
    hr_setCombobox('#isCfg', m_widths[3], m_widths[3], m_widths[4], true, false, 'code', 'name', m_IsCfg);
     

    //获取基础数据（班组和销售类型 员工状态  ）  
    var cons2 = ' AND Status = 1';
    cons2 = cons2 + ' AND TypeCode IN (\'Code_Status\', \'Code_SalesType\', \'Code_WorkTeam\', \'Code_StaffStatus\')';
    var res = hr_getDBCode(cons2, '1', '1000', 'TypeCode, Seq', 'GetSYSCodeItem');
    for (var i = 0; i < res.rows.length; i++) {
        if (res.rows[i].typecode == 'Code_Status') {
            m_IsUse.push(res.rows[i]);
        } else if (res.rows[i].typecode == 'Code_SalesType') {
            m_SalesType.push(res.rows[i]);
        } else if (res.rows[i].typecode == 'Code_WorkTeam') {
            m_WorkTeams.push(res.rows[i]);
        } else if (res.rows[i].typecode == 'Code_StaffStatus') {
            m_employeestatus.push(res.rows[i]);
        }
    } 
     

    //设置表格
    setDataGrid(m_DatagridID);

    //根据权限显示按钮
    setPagination(actorType);

    actLoadData(m_PageNumber, m_PageSize);  //加载数据
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

    // 拼接查询条 
    var cons = m_Filter;
    var orgid = $('#orgname').combobox('getValue');
    var shopName = $('#unitname').val();
    var shopEmp = $('#shopEmp').val();
    var isCfg = $('#isCfg').combobox('getValue');

    if (orgid != '') {
        cons = cons + ' AND ORGID = \'' + orgid + '\'' ;
    }
    if (shopName != '') {
        cons = cons + ' AND UnitName Like \'%' + shopName + '%\'';
    }

    if (isCfg == '0') {
        cons += ' AND ISNULL(salesid,\'\') in (\'\')'; 
    } else if (isCfg == '1') {
        cons += ' AND ISNULL(salesid,\'\') not in (\'\')'; 
    }

    if (shopEmp != '') {
        cons = cons + ' AND ( EmpCODE Like \'%' + shopEmp + '%\''
        cons = cons + ' OR EMPName Like \'%' + shopEmp + '%\')';
    }

    var res = hr_getUserInfo(cons, page, number, m_OrderBy);
    //alert(jsonUtil_jsonToStr(res));
    if (res != '' && res.total > 0) {
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
    $('#shopEmp').val('');
    $('#unitname').val('');
    $('#orgname').combobox('setValue', '');
    $('#isCfg').combobox('setValue', '');
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'店员配置表',
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
        idField: 'id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'id', title: 'FID', width: 80, hidden: true },
            { field: 'empid', title: '员工新ID', width: 80, hidden: true },
            { field: 'employeeid', title: '员工旧ID', width: 80, hidden: true },
            { field: 'empcode', title: '工号', width: 70 },
            { field: 'empname', title: '姓名', width: 70 },
            { field: 'empstatus', title: '在职状态', width: 60, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_employeestatus, val, 'code', 'name');
                }
            },
            { field: 'jobcode', title: '岗位编码', width: 80, hidden: true },
            { field: 'jobname', title: '岗位', width: 90 },
            { field: 'salesid', title: '销售类型', width: 80, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_SalesType, val, 'code', 'name');
                }
            },
            { field: 'workteamcode', title: '班组', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_WorkTeams, val, 'code', 'name');
                }
            }, 
            { field: 'sdplanid', title: '提成方案ID', width: 80 },
            { field: 'sbplanid', title: '奖金方案ID', width: 80 },
            {
                field: 'isuse', title: '状态', width: 50, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'code', 'name');
                }
            },
            { field: 'unitID', title: '部门ID', width: 80, hidden: true },
            { field: 'unitcode', title: '部门号', width: 80, hidden: true },
            { field: 'unitname', title: '部门名称', width: 120},
            {
                field: 'orgid', title: '公司', width: 80
                , formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_Companys, val, 'hr9_ehrorgid', 'hr9_com');
                }
            },
            { field: 'costcenterid', title: '成本中心ID', width: 80, hidden: true },
            { field: 'costcentercode', title: '成本中心号', width: 80, hidden: true },
            { field: 'costcentername', title: '成本中心', width: 80, hidden: true },
            { field: 'rgdt', title: '创建时间', width: 130, hidden: true },
            { field: 'rguser', title: '创建人', width: 60, hidden: true },
            { field: 'lmdt', title: '修改时间', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'lmuser', title: '修改人', width: 60 },
            { field: 'rgtype', title: '来源', width: 60 }
        ]],
        rownumbers: true,
        singleSelect: true,
        onRowContextMenu: onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
            if (actorType != 'AT1') {
                opendlg('update');
            }
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        } 
    });
}


/***********************************************************************
*  设置分页
*  DLY
*/
function setPagination(type) {
    var btns = [];
    if (type == 'AT2') {
        btns =  [
        {
            id: 'btnupdate',
            text: '配置',
            iconCls: 'icon-edit-green',
            handler: function () {
                opendlg('update');
            }
        }];
    } else if (type == 'AT3') {
        btns = [ 
            {
                id: 'btnupdate',
                text: '配置',
                iconCls: 'icon-edit-green',
                handler: function () {
                    opendlg('update');
                }
            },{
                id: 'btnadd',
                text: dataUtil_actSetNStr('兼任店长', 1),
                iconCls: 'icon-plus-green',
                handler: function () {
                    opendlg('add');
                }
            }];
    }

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
        buttons: btns
    });
}
 

/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadDataEmp(page, number) {
    $(m_DataGridEmpID).datagrid('loadData', []);

    // 拼接查询条
    m_Filter1 = 'AND IsUse=1';
    var cons = m_Filter + m_Filter1;
    var empcode = $('#dzcode').val();
    if (empcode != '') {
        cons += ' AND ( EmpCODE =\'' + empcode + '\')';
        var res = hr_getUserInfo(cons, page, number, m_OrderBy);

        if (res.total > 0) {
            $(m_DataGridEmpID).datagrid('loadData', res.rows);
        }
    }
    $(m_DataGridEmpID).datagrid("clearSelections");
}


/***********************************************************************
 *  加载数据
 *  DLY 
 */
function actLoadDataShop(page, number) {
    $(m_DataGridShopID).datagrid('loadData', []);

    m_Filter1 = 'AND IsUse=1';
    var cons = m_Filter + m_Filter1;
    var shopname = $('#shopname').val();
    if (shopname != '') {
        cons += ' AND ( UnitName =\'' + shopname + '\')';
        var res = hr_getUserInfo(cons, page, number, m_OrderBy);

        if (res.total > 0) {
            $(m_DataGridShopID).datagrid('loadData', res.rows);
        }
    }
    $(m_DataGridShopID).datagrid("clearSelections");
}


/***********************************************************************
 *  打开配置窗体
 *  DLY 
 */
function opendlg(type) {
    //双击选中一条记录进行调整
    if (type == 'update') {         //修改店铺人员信息
        if (m_LastIndex == -1) {
            alert('请选中一行信息进行更新！');
            return false;
        }

        //获取当前选中人员信息
        var rowData = $(m_DatagridID).datagrid('getSelected');

        //判断当前人员状态是否可修改，若离职则不可更改
        if (rowData.empstatus == 3) {
            alert('当前员工已离职，不可配置！');
            return false;
        }

        //初始化弹窗的控件
        if (m_OpenFlag == '0') {
            //设置下拉菜单
            hr_setCombobox('#workTeam', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_WorkTeams);
            hr_setCombobox('#salesID', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_SalesType);
            
            var SPCons = '【操作类型,GET】【实体, 查询方案】【CONO,】【DIVI,】'
               + '【《W》页码,' + '1' + '】'
	           + '【《W》记录数,' + '1000' + '】'
	           + '【《W》条件,' + '' + '】'
	           + '【《W》排序,' + 'CompanyID, PlanID' + '】'
	           + '【返回内容, 主表列表】'
            SPCons = '<SPCons>' + SPCons + '</SPCons>'  
            var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_SalesDeductPlan&actor="
                + encodeURIComponent(m_UserInfo.userName) + "&XML=" + encodeURIComponent(dataUtil_addROOT(SPCons))
                + "&s=" + new Date().getTime(); //拼接url 

            //提成方案  下拉框设置 
            $('#sdplanid').combogrid({
                panelWidth: "280",
                panelHeight: "160",
                animate: true,
                idField: 'planid',
                textField: 'planid',
                editable: true,
                url: curl,
                columns: [[
                    { field: 'planid', title: '方案ID', width: 90 },
                    { field: 'remark', title: '方案描述', width: 270 }
                ]],
                onClickRow: function (rowIndex) {
                    var row = $('#sdplanid').combogrid('grid').datagrid('getSelected');
                },
                onShowPanel: function () {
                    // $('#sdplanid').combogrid('grid').datagrid('loadData', rows);
                }
            });

            var SPCons1 = '【操作类型,GET】【实体, 查询方案】【CONO,】【DIVI,】'
               + '【《W》页码,' + '1' + '】'
	           + '【《W》记录数,' + '1000' + '】'
	           + '【《W》条件,' + '' + '】'
	           + '【《W》排序,' + 'CompanyID, PlanID' + '】'
	           + '【返回内容, 主表列表】'
            SPCons1 = '<SPCons>' + SPCons + '</SPCons>'
            var curl1 = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=ActSP_SalesBreachPlan&actor="
                + encodeURIComponent(m_UserInfo.userName) + "&XML=" + encodeURIComponent(dataUtil_addROOT(SPCons1))
                + "&s=" + new Date().getTime(); //拼接url 

            //奖金方案  下拉框设置 
            $('#sbplanid').combogrid({
                panelWidth: "280",
                panelHeight: "160",
                animate: true,
                idField: 'planid',
                textField: 'planid',
                editable: true,
                url: curl1,
                columns: [[
                    { field: 'planid', title: '方案ID', width: 90 },
                    { field: 'remark', title: '方案描述', width: 270 }
                ]],
                onClickRow: function (rowIndex) {
                    var row = $('#sbplanid').combogrid('grid').datagrid('getSelected');
                },
                onShowPanel: function () {
                    // $('#sdplanid').combogrid('grid').datagrid('loadData', rows);
                }
            }); 
        }
        $('#uid').html(rowData.id);
        $('#empCode').html(rowData.empcode);
        $('#empName').html(rowData.empname); 
        $('#workTeam').combobox('setValue', rowData.workteamcode);
        $('#salesID').combobox('setValue', rowData.salesid);
        $('#sdplanid').combogrid('setValue', rowData.sdplanid);
        $('#sbplanid').combogrid('setValue', rowData.sbplanid); 
        $(m_dlgupdcfgID).dialog('open');
    } 
    m_OpenFlag = '1';
}


/***********************************************************************
 *  提交配置
 *  DLY 
 */
function upCfgdlg(type) {
    var uid = $('#uid').html();
    if (type == 'update') {
        //校验
        var workTeam = $('#workTeam').combobox('getValue');
        var salesID = $('#salesID').combobox('getValue');
        var sdplanid = $('#sdplanid').combogrid('getValue');
        var sbplanid = $('#sbplanid').combogrid('getValue');
        if (salesID == '') {
            alert('销售类型不能为空！');
            return false;
        }
        if (workTeam == '') {
            alert('班组不能为空！');
            return false;
        }
       
        /*
        if (sdplanid == '') {
            alert('不能为空！');
            return false;
        }
        if (sbplanid == '') {
            alert('结束时间不能为空！');
            return false;
        }  
        */

        //更新
        var row = $(m_DatagridID).datagrid('getSelected'); 
        if (row) {
            if (uid != row.id) { 
                alert('选中记录失效，请重新选择！');
                $(m_dlgupdcfgID).dialog('close');
            }
            if (workTeam == row.workteamcode
                && salesID == row.salesid
                && sdplanid == row.sdplanid
                && sbplanid == row.sbplanid) { // 没有更新
                alert('未存在更新数据！');
                $(m_dlgupdcfgID).dialog('close');
            } else {
                $.messager.confirm('确认框', '确认提交该配置吗？', function (r) {
                    if (r) { 
	                   var SPCons = '【操作类型,SAVE】【实体, 店员配置HR】【CONO,】【DIVI,】'
                                   + '【《W》ID,' + uid + '】'
	                               + '【《W》班组编号,' + workTeam + '】'
	                               + '【《W》销售类型,' + salesID + '】'
	                               + '【《W》提成方案,' + sdplanid + '】'
	                               + '【《W》奖金方案,' + sbplanid + '】'
	                               + '【《W》操作人,' + m_UserInfo.userName + '】'
	                               + '【返回内容, 主表列表】'
                        SPCons = '<SPCons>' + SPCons + '</SPCons>'
                        var result = hr_actSP_UserInfo(SPCons, m_UserInfo.userName); 
                        if (result[0].flag == 'T') {
                            alert('提交成功！');
                            $(m_dlgupdcfgID).dialog('close');
                            actLoadData(m_PageNumber, m_PageSize);
                        } else {
                            alert(result[0].message);
                        }
                    }
                });
            }
        } else {
            alert('未找到选择行，请重新选择行！');
            $(m_dlgupdcfgID).dialog('close');
        }
    }    
}


/***********************************************************************
 *  添加右击菜单内容
 *  DLY 
 */
function onRowContextMenu(e, rowIndex, rowData) {
    $(m_DatagridID).datagrid('selectRow', rowIndex); 
    e.preventDefault();    
    $('#mm').menu('show', {
        left: e.pageX,
        top: e.pageY
    }); 
}


/***********************************************************************
 *  添加右击菜单内容
 *  DLY 
 */
function view(type) {
    if (type == 'userInfoT') {  
        var rowData = $(m_DatagridID).datagrid('getSelected');
        if (rowData) {
            $('#userInfoTdlg').dialog({
                title: '配置历史',
                width: 460,
                height: 200,
                left: event.clientX - 20,
                top: event.clientY - 40
            });
            var itext = '';
            var SPCons = '【操作类型,GET】【实体, 获取店员配置历史】【CONO,】【DIVI,】'
                        + '【《W》员工号,' + rowData.empcode + '】'
                        + '【《W》部门ID,' + rowData.unitid + '】'
                        + '【《W》操作人,' + m_UserInfo.userName + '】'
                        + '【返回内容, 主表列表】'
            SPCons = '<SPCons>' + SPCons + '</SPCons>'
            var rows = hr_actSP_UserInfo(SPCons, m_UserInfo.userName);
            if (rows == '') {
                alert('查询失败！');
            } else if (rows.length > 0 && rows[0].id != '') {
                itext = itext + '<tr>'
                for (var i = 0; i < rows.length; i++) {
                    itext = itext + '<td  style="height:18px; width:15%;">' + rows[i].m_month + '</td>'
                          + '<td style="width:20%;">' + dataUtil_getCodename(m_SalesType, rows[i].salesid, 'code', 'name') + '</td>'
                          + '<td style="width:15%;">' + dataUtil_getCodename(m_WorkTeams, rows[i].workteamcode, 'code', 'name') + '</td>'
                          + '<td style="width:25%;">' + rows[i].sdplanid + '</td>'
                          + '<td style="width:25%;">' + rows[i].sbplanid + '</td>';
                    itext = itext + '</tr>'
                }
            }
            if (itext != '') {
                itext = '<table style="width:420px; margin-left: 15px; ">'
                      + '<tr style="height:26px;"><td>月份</td><td>销量类型</td><td>班组</td><td>提成方案ID</td><td>奖金方案ID</td></tr>'
                      + itext + '</table>';
            }
            itext = '&nbsp;&nbsp;&nbsp;&nbsp;' + rowData.empcode + '&nbsp;&nbsp;-&nbsp;&nbsp;' + rowData.empname + '<br>' + itext;
            $('#userInfoTSpan').html(itext);
            $('#userInfoTdlg').dialog('open');
        } 
        
        alert(jsonUtil_jsonToStr(result)); 
    }
}