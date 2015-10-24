/* 全局变量*/ 
var m_DatagridID = '#ryxsmblb'; //人员销售目标列表
var m_LastIndex = -1;         //人员列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 1000;  //每页显示行数

//获取用户名
var m_UserInfo = parent.m_UserInfo;
var m_taskTypes = hr_getBaseItems(3);
var m_states = hr_getBaseItems(2);
var m_actors = hr_getBaseItems(1);

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式

var m_RowApply = '';
var m_MID = '';
var m_curM = dateUtil_getMonthByDay('', '-', '5').substring(0, 7); //操作月份 
var m_EmpList = [];
var m_SalesType = [];
var m_ApproveID = '';

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
    var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v0"), '');
    var type1 = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v1"), '');
    m_MID = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v2"), '');
    m_ApproveID = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v3"), ''); 

    //设置页面顶部标签  
    page_pTopDisplay(type, type1, dataUtil_getUrlParam("l1")
        , dataUtil_getUrlParam("l2"), dataUtil_getUrlParam("l3"));

    if (m_MID == '') {
        return false;
    }

    //获取基础数据   
    var cons2 = ' AND Status = 1';
    cons2 = cons2 + ' AND TypeCode IN (\'Code_SalesType\')';
    var res = hr_getDBCode(cons2, '1', '1000', 'TypeCode, Seq', 'GetSYSCodeItem');
    for (var i = 0; i < res.rows.length; i++) {
        if (res.rows[i].typecode == 'Code_SalesType') {
            m_SalesType.push(res.rows[i]);
        } 
    }

    //初始化列表
    if (type == 'new') {  // 新建
        setDataGrid('1'); // 明细可编辑
        controlTools(2);  // 无提交按钮，保存后生成待办
        $('#shopNameSpan').html(m_UserInfo.deptName);
        $('#OTMonthSpan').html(m_curM);
        $('#stateSpan').html(m_states[0].value);
        $('#targetamount').numberbox('setValue', 0);
        appendRows(getPers());// 初始化列表 
    } else {            // 查看 或 待办任务  
        var cons = ' AND  ID= \'' + m_MID + '\'';
        m_RowApply = hr_getShopSalesTarget(cons, '1', '1', ''); 
        if (m_RowApply == '' || m_RowApply == '1') {
            alert('m_MID无效, 未找到对应店铺销售目标信息！(' + m_MID + ')');
            return;
        }  
        m_RowApply = m_RowApply.rows[0]
        m_curM =  m_RowApply.fyear + '-' + m_RowApply.fmonth;
        $('#shopNameSpan').html(m_RowApply.hr9_posshopname);
        $('#OTMonthSpan').html(m_curM);  
        var taskcons = ' AND HR3_RID = \'' + m_MID + '\' ';
        var task = hr_getTask(taskcons);
        if (task == '' || task == '1') {
            alert('m_MID无效, 未找到对应待办任务信息！(' + m_MID + ')');
            return;
        } else if (task.hr3_id != undefined && task.hr3_id != '') {
            m_ApproveID = (m_ApproveID == '' ? task.hr3_id : m_ApproveID); 
            $('#stateSpan').html(task.hr3_state);  //设置状态
        }

        $('#targetamount').numberbox('setValue', m_RowApply.targetamount); 
        if (type == 'submit') {  // 申请人-待办   
            setDataGrid('1'); // 明细可编辑
            //获取店铺员工
            controlTools(3);           
        } else if (type == 'approve') { // 审批人-待办
            setDataGrid('1'); // 明细只读 
            controlTools(4); 
        } else if (type == 'old') { // 查询  
            $('#targetamount').attr("disabled", true);
            setDataGrid('2'); // 明细只读
            controlTools(1); 
        } 
        m_Filter1 = ' AND fyear = \'' + m_RowApply.fyear + '\''
                  + ' AND fmonth = \'' + m_RowApply.fmonth + '\''
                  + ' AND shopid = \'' + m_RowApply.shopid + '\'';
        actLoadData(1, m_PageSize);
    }
});


/***********************************************************************
*  加载数据
*  DLY 
*/
function actLoadData(page, number) {
    var totalCount = 0;
    $(m_DatagridID).datagrid('loadData', []);
    var cons = m_Filter + m_Filter1; 
    var res = hr_getUserSalesTarget(cons, page, number, m_OrderBy)
    if (res == '') {
        alert('获取人员销售目标失败！');
    }else if (res != '1' ) { 
        totalCount = dataUtil_undefinedOrNull(res.total, 0);
        $(m_DatagridID).datagrid('loadData', res.rows);
    } 
    $(m_DatagridID).datagrid('clearSelections'); 
    $('#numsSpan').html(totalCount);
}


/***********************************************************************
*  新增列
*  DLY 
*/
function appendRows(pers) {
    var curmonth = $('#OTMonthSpan').html();
    for (var i = 0; i < pers.length; i++) {
        var row1 = {};
        row1.id = dataUtil_NewGuid();
        row1.mid = m_MID;
        row1.fyear = curmonth.substring(0, 4);
        row1.fmonth = curmonth.substring(5, 7);
        row1.companyid = m_UserInfo.selfInfo.c_orgid;
        //row1.shopid = m_UserInfo.deptID;
        row1.shopid = pers[i].posshopcode;
        row1.userid = pers[i].empcode;
        row1.empname = pers[i].empname;
        row1.rguser = m_UserInfo.userName;
        row1.rgdt = dateUtil_dateFomaterA(new Date(), '/');
        row1.salesid = '';
        row1.targetamount = '';
        $(m_DatagridID).datagrid('appendRow', row1);
    } 
}


/***********************************************************************
*  更新人员
*  DLY 
*/
function updatePers() {
    var flag = false; //判断人员是否已存在列表中
    var pers = getPers(); 
    var newPers = [];
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < pers.length; i++) {
        flag = false; 
        for (var j = 0; j < dataRows.length; j++) {
            if (pers[i].empcode == dataRows[j].userid) {
                flag = true;
                break;
            }
        }
        if (!flag) {
            newPers.push(pers[i]);
        }
    }
    if (newPers.length == 0) {
        alert('人员信息已是最新，无需更新！');
    } else {
        appendRows(newPers);
        alert('更新完成！');
    }
}


/***********************************************************************
*  获取店员
*  DLY 
*/
function getPers() {
    var pers = [];
    var curmonth = $('#OTMonthSpan').html();
    curmonth = '2015-08'; // 测试
	var SPCons = '【操作类型,GET】【实体, 查询人员】【CONO,】【DIVI,】'
        + '【《W》店铺ID,' + m_UserInfo.deptID + '】'
	    + '【《W》月份,' + curmonth + '】'
	    + '【返回内容, 主表列表】' 
    SPCons = '<SPCons>' + SPCons + '</SPCons>'
    var rows = hr_actSP_SalesTarget(SPCons, m_UserInfo.userName); 
    if (rows == '') {
        alert('查询失败！');
    } else if (rows.length > 0 && rows[0].empcode != '') {
        pers = rows;
    }
    return pers;
}
 

/***********************************************************************
*  保存
*  DLY 
*/
function actSave(actbtn) { 
    //提交自动保存设置 -- 不弹保存成功提示； 手动保存有提示
    if (actbtn == undefined) {
        actbtn = 'save';
    }

    var flag = false; //总标志
    var flag1 = false; //分步保存成功标志
    var flag2 = false; //是否新建标志
    var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v0"), '');
    var deptName = m_UserInfo.deptName
    var zrow = {}; //店铺销售目标记录 

    var shoptargetamount = $('#targetamount').numberbox('getValue');
    if (shoptargetamount*1 <= 0) {
        alert('店铺月销售目标必须大于0！');
        return flag;
    }

    //获取明细 
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');
    if (dataRows.length == 0) {
        alert('至少包含一条人员销售目标！');
        return flag;
    }

    //校验
    if (m_UserInfo.empCode1 == undefined) {
        alert(deptName + '未获取到店铺对于大区经理配置，请截图联系系统管理员！');
        return flag;
    }
    if (m_UserInfo.empCode2 == undefined) {
        alert(deptName + '未获取到公司对于人资负责人配置，请截图联系系统管理员！');
        return flag;
    }
    
    var j = 0;
    for (var i = 0; i < dataRows.length; i++) {
        j = i * 1 + 1;
        if (dataRows[i].salesid == '') {
            alert('第' + j + '行销售类型不能为空！');
            return flag;
        }
        if (dataRows[i].targetamount == '') {
            alert('第' + j + '行销售目标不能为空！');
            return flag;
        } 
    }

    var cXMLd = '';
    //以下拼接修改记录信息json
    if ($(m_DatagridID).datagrid('getChanges').length > 0) {
        var gridDataChanges = [];
        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");
        for (var i = 0; i < updated.length; i++) {
            updated[i].lmdt = dateUtil_dateFomaterA(new Date(), '-')
            updated[i].lmuser = m_UserInfo.userName;
            updated[i].uptno = updated[i].uptno * 1 + 1; 
        }
        cXMLd = GetEditJson(inserted, updated, deleted);//json转xml
    }  
    //alert(cXMLd);  
    

    //保存校验
    // 1.每月一单校验
    var cons = ' AND  fyear= \'' + dataRows[0].fyear + '\''
             + ' AND  fmonth= \'' + dataRows[0].fmonth + '\''
             + ' AND  shopid= \'' + dataRows[0].shopid + '\'';
    var res = hr_getShopSalesTarget(cons, '1', '1', ''); 
    if (res == '1') {
        flag2 = 'new';
        zrow.id = m_MID;
        zrow.fyear = dataRows[0].fyear;
        zrow.fmonth = dataRows[0].fmonth;
        zrow.companyid = dataRows[0].companyid;
        zrow.shopid = dataRows[0].shopid;
        zrow.rguser = m_UserInfo.userName;
        zrow.rgdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.uptno = 0;
        zrow.state = 0;
        zrow.targetamount = $('#targetamount').numberbox('getValue'); 
    } else if (res.rows[0].id != undefined && res.rows[0].id != '') {
        if (type == 'N') {
            alert('已存在 ' + $('#OTMonthSpan').html() + ' 月的销售目标定制，不可保存新建申请！');
            return flag;
        }
        flag2 = 'old';
        zrow = {}; 
        zrow.id = res.rows[0].id;
        zrow.lmuser = m_UserInfo.userName;
        zrow.lmdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.uptno = 1 * res.rows[0].uptno + 1;
        zrow.targetamount = $('#targetamount').numberbox('getValue');
    } else {
        alert('每月一单,校验失败，请截全屏图发给系统管理员！');
        return flag;
    }
     
    //新建申请
    if (flag2 == 'new') {
        //保存主表
        flag1 = hr_saveShopSalesTarget('N', zrow, m_UserInfo.userName);
        if (!flag1) {
            alert('保存店铺销售目标信息失败！')
            return flag;
        }

        //生成任务行
        var arow = {};
        arow.hr3_id = dataUtil_NewGuid();
        arow.hr3_rid = zrow.id;
        arow.hr3_type = m_taskTypes[7].value;
        arow.hr3_subject = m_UserInfo.deptName + '(' + $('#OTMonthSpan').html() + ') - ' + m_taskTypes[7].value;
        arow.hr3_state = m_states[0].value;
        arow.hr3_rguser = m_UserInfo.userName;
        arow.hr3_actor = m_actors[0].value;
        arow.hr3_perid = m_UserInfo.deptID;
        arow.hr3_perid1 = m_UserInfo.empCode1;
        arow.hr3_perid2 = m_UserInfo.empCode2;
        arow.hr3_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        arow.hr3_uptno = 0;
        arow.hr3_com = m_UserInfo.selfInfo.c_orgid;

        flag1 = hr_saveTask('N', arow, m_UserInfo.userName);
        if (!flag1) {
            alert('生成待办任务失败！')
            return flag;
        }

        //保存明细
        flag1 = hr_saveUserSalesTarget(cXMLd, m_UserInfo.userName);
        if (!flag1) {
            alert('保存人员销售目标信息失败！')
            return flag;
        }  
        if (actbtn == 'save') {
            alert('保存成功！');
        }
        // 跳转到任务页
        var curlo = 'salesTargetMake.html?' + 'v0=submit&v1=task&v2=' + zrow.id
                     + '&v3=' + arow.hr3_id
                     + '&s=' + new Date().getTime();
        parent.menus_turnPage('B', 'tasksPage', curlo);
        flag = true;
    } else if (flag2 == 'old') {
        //保存主表
        flag1 = hr_saveShopSalesTarget('U', zrow, m_UserInfo.userName);
        if (!flag1) {
            alert('保存店铺销售目标信息失败！')
            return flag;
        }

        //保存明细
        if (cXMLd != '') {
            flag1 = hr_saveUserSalesTarget(cXMLd, m_UserInfo.userName);
            if (!flag1) {
                alert('保存人员销售目标信息失败！')
                return flag;
            }
        }

        actLoadData(1, m_PageSize);
        if (actbtn == 'save') {
            alert('保存成功！');
        } 
        flag = true;
    } 
    return flag;
}


/***********************************************************************
*  流程  店长——大区经理——人资
*  DLY 
*/
function actApprove(type) {
    var flag = false;
    // 自动保存
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    if (!actSave('approve')) { 
        return flag;
    } 

    //流程控制 
    var taskid = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v3"), '');
    var result = hr_flowControl('Flow01', type, taskid, m_UserInfo.userName, $('#stateSpan').html());
    if (!result.flag) {
        return flag;
    }
    var res = result.res;

    //流程提交
    $.messager.confirm('确认框', '确认' + result.actinfo + '该销售目标定制吗？', function (r) {
        if (r) {
            //修改任务信息  
            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
            if (!flag1) {
                alert(result.actinfo + '失败，请截全屏图发给系统管理员！(' + taskid + ')');
                return flag;
            }  
            alert(result.actinfo + '成功！');
            parent.menus_turnPage('A', 'tasks', '');
        }
    });
}


/***********************************************************************
*  工具条及按钮控制
*  DLY 
*/
function controlTools(type) {
    if (type == 1) {    //全不可见 - （除汇总查询）
        $('#tool1').hide(); 
    } else if (type == 2) { //申请人 - 新建
        $('#tool1').show();
        $('#gxrybtn').hide();     //更新人员
        $('#bcbtn').show();     //保存
        $('#tjbtn').hide();     //提交
        $('#shbtn').hide();     //审核
        $('#bhbtn').hide();     //驳回
    } else if (type == 3) { //申请人 - 待办
        $('#tool1').show();
        $('#gxrybtn').show();     //更新人员
        $('#bcbtn').show();
        $('#tjbtn').show();
        $('#shbtn').hide();
        $('#bhbtn').hide();
    } else if (type == 4) {  //审批人 - 待办
        $('#gxrybtn').hide();     //更新人员
        $('#tool1').show();
        $('#bcbtn').show();
        $('#tjbtn').hide(); 
        $('#shbtn').show();
        $('#bhbtn').show();
    }
}
 

/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid(type) {
    if (type == '1') { 
        $(m_DatagridID).datagrid({
            //title:'人员销售目标列表',
            //iconCls:'icon-save',
            width: $(document.body).width(),
            height: 400,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            //sortName: 'userid',
            //sortOrder: 'asc',
            remoteSort: false,
            idField: 'id',
            frozenColumns: [[
                //{field:'ck',checkbox:true},
            ]],
            columns: [[
                { field: 'id', title: 'FID', width: 80, hidden: true },
                { field: 'mid', title: 'MID', width: 80, hidden: true },
                { field: 'companyid', title: '公司ID', width: 70, hidden: true },
                { field: 'shopid', title: '店铺ID', width: 70, hidden: true },
                { field: 'fyear', title: '年份', width: 70, hidden: true },
                { field: 'fmonth', title: '月份', width: 70, hidden: true },
                { field: 'userid', title: '员工号', width: 80 },
                { field: 'empname', title: '姓名', width: 80},
                { field: 'salesid', title: '销售类型', width: 120
                     , editor: {
                         type: 'combobox', options: {
                             valueField: 'code', textField: 'name',
                             data: m_SalesType, editable: false, panelHeight: "100",
                             onShowPanel: function () {
                             },
                             onSelect: function (record) {
                             },
                             onHidePanel: function () {
                             }
                         }
                     }
                    , formatter: function (val, row, index) {
                        return dataUtil_getCodename(m_SalesType, val, 'code', 'name');
                    }
                },
                { field: 'targetamount', title: '销售目标', width: 150, align: "right"
                    , editor: { type: 'numberbox', options: { precision: 2, min: 0 }}},
                { field: 'rguser', title: '创建人', width: 70 },
                {
                    field: 'rgdt', title: '创建时间', width: 125,
                    formatter: function (val, row, index) {
                        if (val) {
                            return dateUtil_dateFomaterA(new Date(val), '-');
                        }
                    }
                },
                { field: 'lmuser', title: '修改人', width: 70 },
                {
                    field: 'lmdt', title: '修改时间', width: 125,
                    formatter: function (val, row, index) {
                        if (val) {
                            return dateUtil_dateFomaterA(new Date(val), '-');
                        }
                    }
                },
                { field: 'uptno', title: '修改次数', width: 70, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true,
            //onRowContextMenu:onRowContextMenu,
            onDblClickRow: function () {
            },
            onClickRow: function (rowIndex) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
                $(m_DatagridID).datagrid('selectRow', rowIndex);
                $(m_DatagridID).datagrid('beginEdit', rowIndex);
                m_LastIndex = rowIndex;
            } 
        });
    } else if (type == '2') { 
        $(m_DatagridID).datagrid({
            //title:'人员销售目标列表',
            //iconCls:'icon-save',
            width: $(document.body).width(),
            height: 400,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            sortName: 'userid',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'id',
            frozenColumns: [[
                //{field:'ck',checkbox:true},
            ]],
            columns: [[ 
                { field: 'id', title: 'FID', width: 80, hidden: true },
                { field: 'mid', title: 'MID', width: 80, hidden: true },
                { field: 'companyid', title: '公司ID', width: 70, hidden: true },
                { field: 'shopid', title: '店铺ID', width: 70, hidden: true },
                { field: 'fyear', title: '年份', width: 70, hidden: true },
                { field: 'fmonth', title: '月份', width: 70, hidden: true },
                { field: 'userid', title: '员工号', width: 80 },
                { field: 'empname', title: '姓名', width: 80 },
                { field: 'salesid', title: '销售类型', width: 120
                     , formatter: function (val, row, index) {
                        return dataUtil_getCodename(m_SalesType, val, 'code', 'name');
                    }
                },
                { field: 'targetamount', title: '销售目标', width: 150, align: "right" },
                { field: 'rguser', title: '创建人', width: 70 },
                {
                    field: 'rgdt', title: '创建时间', width: 125,
                    formatter: function (val, row, index) {
                        if (val) {
                            return dateUtil_dateFomaterA(new Date(val), '-');
                        }
                    }
                },
                { field: 'lmuser', title: '修改人', width: 70 },
                {
                    field: 'lmdt', title: '修改时间', width: 125,
                    formatter: function (val, row, index) {
                        if (val) {
                            return dateUtil_dateFomaterA(new Date(val), '-');
                        }
                    }
                },
                { field: 'uptno', title: '修改次数', width: 70, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true, 
            onDblClickRow: function () {
            },
            onClickRow: function (rowIndex) {
            } 
        });
    }
}


/***********************************************************************
*  关闭
*  DLY 
*/
function actClose() {
    parent.menus_back('back', '', '');//返回上一次界面
}