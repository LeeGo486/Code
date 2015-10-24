var m_DatagridID = '#ryxxlb'; //列表ID
var m_PaginationID = '#cxpager';   //分页ID
var m_LastIndex = -1;  //人员列表最后一次选中行下标 
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数 

var m_dlgupdcfgID = '#ryxxupddlg'; //更新
var m_dlgaddcfgID = '#ryxxadddlg'; //新增——兼任
var m_dlgmodifycfgID = '#ryxxmodifydlg'; //调整

var m_DataGridEmpID = '#dzxxlb';
var m_DataGridShopID = '#shoplb';

var m_ComboGrid = '#unitname';

//用户信息
var m_UserInfo = parent.m_UserInfo;

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = 'unitcode,empcode'; //排序方式

//基础数据
var m_WorkTeams = {};   //班组
var m_SalesType = {};   //销售类型
var m_employeestatus = [];  //员工状态
//状态是否有效转换
var m_IsUse = [{ isuseid: '0', isusetext: '无效' }, { isuseid: '1', isusetext: '有效' }];

//宽度设置
var m_widths = [120, 150, 120, 100, 70, 200, 300];
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

    if (m_UserInfo.actor == 'A') {
        m_Filter = ' AND UnitID=\'' + m_UserInfo.deptID + '\'';
        $(m_ComboGrid).val(m_UserInfo.deptName);
        $(m_ComboGrid).attr('disabled', 'disabled');
    }

    if (m_UserInfo.actor != 'A') {
        setComboGrid();
    }

    //设置日期控件
    setDatebox('#begindt');

    //初始设置当前月的数据
    $('#begindt').datebox('setValue', dateUtil_dateFomaterB(new Date(), '-').substring(0, 7) + '-01');

    //获取基础数据（班组和销售类型）
    var cons = ' AND TypeCode=\'Code_WorkTeam\'';
    m_WorkTeams = hr_getDBCode(cons, 1, 1000, 'Code', 'GetSYSCodeItem');//班组

    cons = ' AND TypeCode=\'Code_SalesType\'';
    m_SalesType = hr_getDBCode(cons, 1, 1000, 'Code', 'GetSYSCodeItem');//销售类型

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

    //设置表格
    setDataGrid(m_DatagridID);

    //根据权限显示按钮
    setPagination(m_UserInfo.actor);

    actLoadData(m_PageNumber, m_PageSize);  //加载数据
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
            return dateUtil_dateFomaterB(date, '-');
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
 *  设置下拉表的控件
 *  SY 
 */
function setComboGrid() {;
    var cXML = '<Page>' + 1 + '</Page><Num>' + 10000 + '</Num>'
            + '<Cons>' + ' AND HR9_Type=1' + '</Cons><OrderBy>' + '' + '</OrderBy>';
    cXML = dataUtil_addROOT(cXML);
    $(m_ComboGrid).combogrid({
        width: 120,
        panelWidth: 200,
        idField: 'hr9_ehrunitid',
        textField: 'hr9_ehrunitname',
        url: GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetSYSConfig&XML=" + encodeURIComponent(cXML),
        columns: [[
            { field: 'hr9_ehrunitid', title: '部门编号', align: 'center', width: 80 },
            { field: 'hr9_ehrunitname', title: '部门名称', align: 'center', width: 85 },
        ]],
        onSelect: function (rowindex, rowData) {
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
 *  加载数据
 *  DLY 
 */
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    m_PageNumber = page;
    m_PageSize = number;

    // 拼接查询条
    m_Filter1 = ' OR BeginDt is null';
    var cons = m_Filter;
    var begindt = $('#begindt').datebox('getText');
    var shopEmp = $('#shopEmp').val();
    if (begindt != '') {
        cons += ' AND ( \'' + begindt + '\' between begindt and enddt';
        cons += m_Filter1 + ')';
    }
    if (shopEmp != '') {
        cons = cons + ' AND ( EmpCODE Like \'%' + shopEmp + '%\''
        cons = cons + ' OR EMPName Like \'%' + shopEmp + '%\')';
    }

    var res = hr_getUserInfo(cons, page, number, m_OrderBy);

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
    $('#begindt').datebox('setValue', '');
    $('#shopEmp').val('');
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
            { field: 'empcode', title: '工号', width: 80 },
            { field: 'empname', title: '姓名', width: 80 },
            {
                field: 'empstatus', title: '状态', width: 60, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_employeestatus, val, 'c_code', 'c_name');
                }
            },
            { field: 'jobcode', title: '职位号', width: 80, hidden: true },
            { field: 'jobname', title: '岗位', width: 80 },
            { field: 'idcard', title: '卡号', width: 80, hidden: true },
            { field: 'phonenumber', title: '手机号', width: 80, hidden: true },
            {
                field: 'hiredate', title: '聘用时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'gender', title: '性别', width: 80, hidden: true },
            { field: 'age', title: '年龄', width: 80, hidden: true },
            {
                field: 'birthday', title: '出生日期', width: 80, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            { field: 'address1', title: '住址', width: 120, hidden: true },
            { field: 'operator', title: '操作人', width: 70, hidden: true },
            {
                field: 'operatetime', title: '操作时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'unitID', title: '部门ID', width: 80, hidden: true },
            { field: 'unitcode', title: '部门号', width: 80, hidden: true },
            { field: 'unitname', title: '部门名称', width: 80, hidden: true },
            { field: 'costcenterid', title: '成本中心ID', width: 80, hidden: true },
            { field: 'costcentercode', title: '成本中心号', width: 80, hidden: true },
            { field: 'costcentername', title: '成本中心', width: 80, hidden: true },
            { field: 'orgid', title: '公司编号', width: 80, hidden: true },
            {
                field: 'isuse', title: '是否有效', width: 60, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'isuseid', 'isusetext');
                }
            },
            {
                field: 'workteamcode', title: '班组', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_WorkTeams.rows, val, 'code', 'name');
                }
            },
            {
                field: 'salesid', title: '销售类型', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_SalesType.rows, val, 'code', 'name');
                }
            },
            {
                field: 'begindt', title: '起始日期', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'enddt', title: '结束日期', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'rgdt', title: '创建时间', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'rguser', title: '创建人', width: 60 },
            {
                field: 'lmdt', title: '修改时间', width: 130,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'lmuser', title: '修改人', width: 60 },
            { field: 'rgtype', title: '类型', width: 60 }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        },
        onRowContextMenu: function (e, rowIndex, rowData) {
            //e.preventDefault(); //阻止浏览器捕获右键事件
            //$(this).datagrid("clearSelections"); //取消所有选中项
            ////$(this).datagrid("selectRow", rowIndex); //根据索引选中该行
            //$('#menu').menu('show', {
            //    //显示右键菜单
            //    left: e.pageX,//在鼠标点击处显示菜单
            //    top: e.pageY
            //});
        }
    });
}


/***********************************************************************
*  设置分页
*  SY 
*/
function setPagination(actor) {
    if (actor == 'A') {
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
                id: 'btnmodify',
                text: dataUtil_actSetNStr('调整', 1),
                iconCls: 'icon-redo-green',
                handler: function () {
                    opendlg('modify');
                }
            },
            {
                id: 'btnupdate',
                text: dataUtil_actSetNStr('更新', 1),
                iconCls: 'icon-edit-green',
                handler: function () {
                    opendlg('update');
                }
            }]
        });
    } else {
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
                text: dataUtil_actSetNStr('新增', 1),
                iconCls: 'icon-plus-green',
                handler: function () {
                    opendlg('add');
                }
            }]
        });
    }
}


/***********************************************************************
*  设置列表(对话框)
*  SY
*/
function setDataGriddlg() {
    //店长信息列表
    $(m_DataGridEmpID).datagrid({
        width: $('#dispalytable').width,
        height: 80,
        nowrap: true,
        striped: true,
        collapsible: true,
        remoteSort: false,
        idField: 'id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'ID', title: 'FID', width: 80, hidden: true },
            { field: 'empid', title: '员工新ID', width: 80, hidden: true },
            { field: 'employeeid', title: '员工旧ID', width: 80, hidden: true },
            { field: 'empcode', title: '工号', width: 80 },
            { field: 'empname', title: '姓名', width: 80 },
            {
                field: 'empstatus', title: '状态', width: 60, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_employeestatus, val, 'c_code', 'c_name');
                }
            },
            { field: 'jobcode', title: '职位号', width: 80, hidden: true },
            { field: 'jobname', title: '岗位', width: 80 },
            { field: 'idcard', title: '卡号', width: 80, hidden: true },
            { field: 'phonenumber', title: '手机号', width: 80, hidden: true },
            {
                field: 'hiredate', title: '聘用时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'gender', title: '性别', width: 80, hidden: true },
            { field: 'age', title: '年龄', width: 80, hidden: true },
            {
                field: 'birthday', title: '出生日期', width: 80, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            { field: 'address1', title: '住址', width: 120, hidden: true },
            { field: 'operator', title: '操作人', width: 70, hidden: true },
            {
                field: 'operatetime', title: '操作时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'unitID', title: '部门ID', width: 80, hidden: true },
            { field: 'unitcode', title: '部门号', width: 80, hidden: true },
            { field: 'unitname', title: '部门名称', width: 80, hidden: true },
            { field: 'costcenterid', title: '成本中心ID', width: 80, hidden: true },
            { field: 'costcentercode', title: '成本中心号', width: 80, hidden: true },
            { field: 'costcentername', title: '成本中心', width: 80, hidden: true },
            { field: 'orgid', title: '公司编号', width: 80, hidden: true },
            {
                field: 'isuse', title: '是否有效', width: 60, align: "center", hidden: true,
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'isuseid', 'isusetext');
                }
            },
            {
                field: 'workteamcode', title: '班组', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_WorkTeams.rows, val, 'code', 'name');
                }
            },
            {
                field: 'salesid', title: '销售类型', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_SalesType.rows, val, 'code', 'name');
                }
            },
            {
                field: 'begindt', title: '起始日期', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'enddt', title: '结束日期', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'rgdt', title: '创建时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'rguser', title: '创建人', width: 60, hidden: true },
            {
                field: 'lmdt', title: '修改时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'lmuser', title: '修改人', width: 60, hidden: true },
            { field: 'rgtype', title: '类型', width: 60, hidden: true }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        }
    });

    $(m_DataGridShopID).datagrid({
        width: $('#dispalytable').width,
        height: 80,
        nowrap: true,
        striped: true,
        collapsible: true,
        remoteSort: false,
        idField: 'hr9_id',
        frozenColumns: [[
            //{field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'ID', title: 'FID', width: 80, hidden: true },
            { field: 'empid', title: '员工新ID', width: 80, hidden: true },
            { field: 'employeeid', title: '员工旧ID', width: 80, hidden: true },
            { field: 'empcode', title: '工号', width: 80, hidden: true },
            { field: 'empname', title: '姓名', width: 80, hidden: true },
            {
                field: 'empstatus', title: '状态', width: 60, align: "center", hidden: true,
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_employeestatus, val, 'c_code', 'c_name');
                }
            },
            { field: 'jobcode', title: '职位号', width: 80, hidden: true },
            { field: 'jobname', title: '岗位', width: 80, hidden: true },
            { field: 'idcard', title: '卡号', width: 80, hidden: true },
            { field: 'phonenumber', title: '手机号', width: 80, hidden: true },
            {
                field: 'hiredate', title: '聘用时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'gender', title: '性别', width: 80, hidden: true },
            { field: 'age', title: '年龄', width: 80, hidden: true },
            {
                field: 'birthday', title: '出生日期', width: 80, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            { field: 'address1', title: '住址', width: 120, hidden: true },
            { field: 'operator', title: '操作人', width: 70, hidden: true },
            {
                field: 'operatetime', title: '操作时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'unitID', title: '部门ID', width: 80, hidden: true },
            { field: 'unitcode', title: '部门号', width: 80 },
            { field: 'unitname', title: '部门名称', width: 120 },
            { field: 'costcenterid', title: '成本中心ID', width: 80, hidden: true },
            { field: 'costcentercode', title: '成本中心号', width: 80, hidden: true },
            { field: 'costcentername', title: '成本中心', width: 80, hidden: true },
            { field: 'orgid', title: '公司编号', width: 80, hidden: true },
            {
                field: 'isuse', title: '是否有效', width: 60, align: "center", hidden: true,
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_IsUse, val, 'isuseid', 'isusetext');
                }
            },
            {
                field: 'workteamcode', title: '班组', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_WorkTeams.rows, val, 'code', 'name');
                }
            },
            {
                field: 'salesid', title: '销售类型', width: 70, align: "center",
                formatter: function (val, row, index) {
                    return dataUtil_getCodename(m_SalesType.rows, val, 'code', 'name');
                }
            },
            {
                field: 'begindt', title: '起始日期', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'enddt', title: '结束日期', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterB(new Date(val), '-');
                    }
                }
            },
            {
                field: 'rgdt', title: '创建时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'rguser', title: '创建人', width: 60, hidden: true },
            {
                field: 'lmdt', title: '修改时间', width: 130, hidden: true,
                formatter: function (val, row, index) {
                    if (val) {
                        return dateUtil_dateFomaterA(new Date(val), '-');
                    }
                }
            },
            { field: 'lmuser', title: '修改人', width: 60, hidden: true },
            { field: 'rgtype', title: '类型', width: 60, hidden: true }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
        },
        onClickRow: function (rowIndex) {
            m_LastIndex = rowIndex;
        }
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
            alert('当前员工已离职无需配置！');
            return false;
        }

        $('#empCode').html(rowData.empcode);
        $('#empName').html(rowData.empname);

        //设置下拉菜单
        setCombobox('#workTeam', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_WorkTeams.rows);
        setCombobox('#salesID', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_SalesType.rows);
        $('#workTeam').combobox('setValue', rowData.workteamcode);
        $('#salesID').combobox('setValue', rowData.salesid);

        //设置日期控件
        setDatebox('#beginDate');
        setDatebox('#endDate');
        if (rowData.begindt != '') {
            $('#beginDate').datebox('setValue', dateUtil_dateFomaterB(new Date(rowData.begindt), '-'));
        } else {
            $('#beginDate').datebox('setValue', '');
        }
        if (rowData.enddt != '') {
            $('#endDate').datebox('setValue', dateUtil_dateFomaterB(new Date(rowData.enddt), '-'));
        } else {
            $('#endDate').datebox('setValue', '');
        }

        $(m_dlgupdcfgID).dialog('open');
    }
    else if (type == 'modify') {         //调整店铺人员信息
        if (m_LastIndex == -1) {
            alert('请选中一行信息进行更新！');
            return false;
        }

        //获取当前选中人员信息
        var rowData = $(m_DatagridID).datagrid('getSelected');

        //判断当前人员状态是否可修改，若离职则不可更改
        if (rowData.empstatus == 3) {
            alert('当前员工已离职无需配置！');
            return false;
        }

        if (rowData.isuse == 0) {
            alert('请选择状态有效的员工记录，进行新增！');
            return false;
        }

        $('#shopEmpCode').html(rowData.empcode);
        $('#shopEmpName').html(rowData.empname);

        //初始化当前记录信息
        $('#workTeamSpan').html(dataUtil_getCodename(m_WorkTeams.rows, rowData.workteamcode, 'code', 'name'));
        $('#salesIDSpan').html(dataUtil_getCodename(m_SalesType.rows, rowData.salesid, 'code', 'name'));
        if (rowData.begindt != '') {
            $('#beginDateSpan').html(dateUtil_dateFomaterB(new Date(rowData.begindt), '-'));
        }
        if (rowData.enddt != '') {
            $('#endDateSpan').html(dateUtil_dateFomaterB(new Date(rowData.enddt), '-'));
        }


        //设置下拉菜单
        setCombobox('#shopWorkTeam', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_WorkTeams.rows);
        setCombobox('#shopSalesID', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_SalesType.rows);
        $('#shopWorkTeam').combobox('setValue', '');
        $('#shopSalesID').combobox('setValue', '');

        //设置日期控件
        setDatebox('#shopBeginDate');
        setDatebox('#shopEndDate');
        $('#shopBeginDate').datebox('setValue', '');
        $('#shopEndDate').datebox('setValue', '');

        $(m_dlgmodifycfgID).dialog('open');
    } else if (type == 'add') {
        $('#shopname').val('');
        $('#dzcode').val('');
        $('#cxTypeShop').attr('checked', false);
        $('#cxTypeEmp').attr('checked', false);
        setDatebox('#Empbegindate');
        setDatebox('#Empenddate');
        $('#Empbegindate').datebox('setValue', '');
        $('#Empenddate').datebox('setValue', '');
        //设置下拉菜单
        setCombobox('#Empworkteam', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_WorkTeams.rows);
        setCombobox('#Empsalesid', m_widths[0], m_widths[0], m_widths[4], true, false, 'code', 'name', m_SalesType.rows);
        $('#Empworkteam').combobox('setValue', '');
        $('#Empsalesid').combobox('setValue', '');
        setDataGriddlg();
        actLoadDataEmp(1, 1);
        actLoadDataShop(1, 1);
        $(m_dlgaddcfgID).dialog('open');
    }
}


/***********************************************************************
 *  提交配置
 *  DLY 
 */
function upCfgdlg(type) {
    if (type == 'update') {
        //校验
        var workTeam = $('#workTeam').combobox('getValue');
        var salesID = $('#salesID').combobox('getValue');
        var beginDate = $('#beginDate').datebox('getValue');
        var endDate = $('#endDate').datebox('getValue');
        if (workTeam == '') {
            alert('班组不能为空！');
            return false;
        } else if (salesID == '') {
            alert('销售类型不能为空！');
            return false;
        } else if (beginDate == '') {
            alert('起始时间不能为空！');
            return false;
        } else if (endDate == '') {
            alert('结束时间不能为空！');
            return false;
        } else if (beginDate > endDate) {
            alert('起始时间大于结束时间！');
            return false;
        }

        //更新
        var row = $(m_DatagridID).datagrid('getSelected');
        var begindttemp = '';
        var enddttemp = '';
        if (row.begindt != '') {
            begindttemp = dateUtil_dateFomaterB(new Date(row.begindt), '-')
        }
        if (row.enddt != '') {
            enddttemp = dateUtil_dateFomaterB(new Date(row.enddt), '-')
        }
        if (row) {
            if (workTeam == row.workteamcode
                && salesID == row.salesid
                && beginDate == begindttemp
                && endDate == enddttemp) { // 没有更新
                alert('未存在更新数据！');
                $(m_dlgupdcfgID).dialog('close');
            } else {
                $.messager.confirm('确认框', '确认提交该配置吗？', function (r) {
                    if (r) {
                        //提交配置
                        var res = {
                            mid: row.id, unitid: row.unitid, empcode: row.empcode,
                            workteamcode: workTeam, salesid: salesID,
                            begindt: beginDate, enddt: endDate,
                            actor: m_UserInfo.userName, confirmtype: 'update'
                        };
                        //var resresult = hr_updEmpCfg(res);
                        //if (resresult[0].result.toLowerCase() == 'false') {
                        //    alert(resresult[0].message);
                        //} else {
                        //    alert('保存成功！');
                        //    $(m_dlgupdcfgID).dialog('close');
                        //    actLoadData(m_PageNumber, m_PageSize);
                        //}
                        var result = hr_saveEmpCfg(res);
                        if (result[0].flag == 'T') {
                            alert('保存成功！');
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
    } else if (type == 'modify') {
        //校验
        var workTeam = $('#shopWorkTeam').combobox('getValue');
        var salesID = $('#shopSalesID').combobox('getValue');
        var beginDate = $('#shopBeginDate').datebox('getValue');
        var endDate = $('#shopEndDate').datebox('getValue');
        if (workTeam == '') {
            alert('班组不能为空！');
            return false;
        } else if (salesID == '') {
            alert('销售类型不能为空！');
            return false;
        } else if (beginDate == '') {
            alert('起始时间不能为空！');
            return false;
        } else if (endDate == '') {
            alert('结束时间不能为空！');
            return false;
        } else if (beginDate > endDate) {
            alert('起始时间大于结束时间！');
            return false;
        }

        //调整
        var row = $(m_DatagridID).datagrid('getSelected');
        if (row) {
            $.messager.confirm('确认框', '确认提交该配置吗？', function (r) {
                if (r) {
                    //提交配置
                    var res = {
                        mid: row.id, unitid: row.unitid, empcode: row.empcode,
                        workteamcode: workTeam, salesid: salesID,
                        begindt: beginDate, enddt: endDate,
                        actor: m_UserInfo.userName, confirmtype: 'modify'
                    };
                    //var resresult = hr_updEmpCfg(res);
                    //if (resresult[0].result.toLowerCase() == 'false') {
                    //    alert(resresult[0].message);
                    //} else {
                    //    alert('保存成功！');
                    //    $(m_dlgmodifycfgID).dialog('close');
                    //    actLoadData(m_PageNumber, m_PageSize);
                    //}
                    var result = hr_saveEmpCfg(res);
                    if (result[0].flag == 'T') {
                        alert('保存成功！');
                        $(m_dlgmodifycfgID).dialog('close');
                        actLoadData(m_PageNumber, m_PageSize);
                    } else {
                        alert(result[0].message);
                    }
                }
            });
            //}
        } else {
            alert('未找到选择行，请重新选择行！');
            $(m_dlgmodifycfgID).dialog('close');
        }
    } else if (type == 'add') {
        //校验
        var cxTypeEmp = $('#cxTypeEmp').is(':checked');
        var cxTypeShop = $('#cxTypeShop').is(':checked');
        var beginDate = $('#Empbegindate').datebox('getValue');
        var endDate = $('#Empenddate').datebox('getValue');
        var emprow = $(m_DataGridEmpID).datagrid('getRows');
        var shoprow = $(m_DataGridShopID).datagrid('getRows');
        var empworkteam = $('#Empworkteam').combobox('getValue');
        var empsalesid = $('#Empsalesid').combobox('getValue');
        if (!cxTypeEmp) {
            alert('请确认店长信息！');
            return false;
        } else if (!cxTypeShop) {
            alert('请确认兼任店铺信息！');
            return false;
        } else if (emprow.length <= 0) {
            alert('请输入兼任店长！');
            return false;
        } else if (shoprow.length <= 0) {
            alert('请输入兼任店铺信息！');
            return false;
        } else if (empworkteam == '') {
            alert('班组不能为空！');
            return false;
        } else if (empsalesid == '') {
            alert('销售类型不能为空！');
            return false;
        } else if (beginDate == '') {
            alert('起始时间不能为空！');
            return false;
        } else if (endDate == '') {
            alert('结束时间不能为空！');
            return false;
        } else if (beginDate > endDate) {
            alert('起始时间大于结束时间！');
            return false;
        }

        //兼任店长
        $.messager.confirm('确认框', '确认提交该配置吗？', function (r) {
            if (r) {
                //提交配置
                var res = {
                    mid: '', unitid: shoprow[0].unitid, empcode: emprow[0].empcode,
                    workteamcode: empworkteam, salesid: empsalesid,
                    begindt: beginDate, enddt: endDate,
                    actor: m_UserInfo.userName, confirmtype: 'add'
                };
                var result = hr_saveEmpCfg(res);
                if (result[0].flag == 'T') {
                    alert('保存成功！');
                    $(m_dlgaddcfgID).dialog('close');
                    actLoadData(m_PageNumber, m_PageSize);
                } else {
                    alert(result[0].message);
                }
            }
        });
    }
}