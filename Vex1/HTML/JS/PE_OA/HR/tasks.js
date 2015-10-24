/* 全局变量*/
var m_DatagridID = '#rwlb'; //任务列表
var m_LastIndex = -1;         //人员列表最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize = 10;  //每页显示行数

//获取用户名
var m_UserInfo = parent.m_UserInfo; 

var m_Types = [{ text: "待办任务" }, { text: "非待办任务" }];

var m_taskTypes = hr_getBaseItems(3);
var m_states = hr_getBaseItems(2);
var m_actors = hr_getBaseItems(1);
 

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ' convert(varchar(20),hr3_rgdt,120) desc'; //排序方式


var m_pers = []; //加班汇总 

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
    //初始化列表
    setDataGrid();

    //任务类别 下拉框设置 
    $('#cxTaskType').combobox({
        panelWidth: "100",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'value',
        textField: 'value',
        data: m_taskTypes
    }); 
    //状态 下拉框设置 
    $('#cxState').combobox({
        panelWidth: "100",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'value',
        textField: 'value',
        data: m_states
    });
    //环节 下拉框设置 
    $('#cxActor').combobox({
        panelWidth: "100",
        panelHeight: "120",
        editable: false,
        multiple: false,
        valueField: 'value',
        textField: 'value',
        data: m_actors
    });

    var filter = parent.actsonfilter('get'); 
    if (filter.type != undefined && filter.type == 'task') { //恢复到跳转前参数
        setCons(filter);
    }
    else {
        clearText();
        cxTypeChange();
        searchByCons();
    } 
});
 

/***********************************************************************
 *  清除按钮事件：清除查询条件
 *  DLY 
 */
function clearText() { 
    $('#cxType').attr('checked', 'true'); 
    $('#cxTaskType').combobox('setValue', '');
    $('#cxState').combobox('setValue', '');
    $('#cxActor').combobox('setValue', '');
    $('#cxAppPer').val(''); 
}


/***********************************************************************
 *  查询按钮事件：根据条件查询
 *  DLY
 */
function searchByCons() {
    m_PageNumber = 1;
    var cxType = $('#cxType').is(':checked');
    var cxAppPer = $('#cxAppPer').val(); 
    var cxTaskType = $('#cxTaskType').combobox('getValue');
    var cxState = $('#cxState').combobox('getValue');
    var cxActor = $('#cxActor').combobox('getValue');

    var cfilter1 = ''; 
    if (cxType) { //待办任务 
        cfilter1 = ' AND ( (HR3_PerID  = \'' + m_UserInfo.deptID + '\' AND HR3_Actor =\'申请人\')'
                 + ' OR (HR3_PerID1  = \'' + m_UserInfo.empCode + '\'AND HR3_Actor =\'经理\')'
                 + ' OR (HR3_PerID2  = \'' + m_UserInfo.empCode + '\'AND HR3_Actor =\'人资\') )';
    } else {
        cfilter1 = ' AND ( HR3_PerID  = \'' + m_UserInfo.deptID + '\''
                 + ' OR HR3_PerID1  = \'' + m_UserInfo.empCode + '\''
                 + ' OR HR3_PerID2  = \'' + m_UserInfo.empCode + '\' )';
    }

    var cfilter2 = '';
    if (cxAppPer != '') {
        cfilter2 = cfilter2 + ' AND HR3_RgUser LIKE \'%' + cxAppPer + '%\'';
    }
    if (cxTaskType != '' && cxTaskType != '全部') {
        cfilter2 = cfilter2 + ' AND hr3_type = \'' + cxTaskType + '\'';
    }
    if (cxState != '' && cxState != '全部') {
        cfilter2 = cfilter2 + ' AND hr3_state = \'' + cxState + '\'';
    } 
    if (cxActor != '' && cxActor != '全部') {
        cfilter2 = cfilter2 + ' AND hr3_actor = \'' + cxActor + '\'';
    }
    m_Filter1 = cfilter1 + cfilter2;
    //alert(m_Filter1);
    actLoadData(m_PageNumber, m_PageSize);

}



/***********************************************************************
 *  根据跳转前的参数设置页面
 *  DLY
 */
function setCons(filter) { 
    if (filter.cxType == 'T') {
        $("#cxType").attr("checked", true);
    } else {
        $("#cxType").attr("checked", false);
    } 
    $('#cxAppPer').val(filter.cxAppPer);
    $('#cxTaskType').combobox('setValue', filter.cxTaskType);
    $('#cxState').combobox('setValue', filter.cxState);
    $('#cxActor').combobox('setValue', filter.cxActor);
    m_Filter = filter.fil;
    m_Filter1 = filter.fil1; 
    actLoadData(filter.page, m_PageSize); 
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) { 
        if (filter.sid.toUpperCase() == rows[i].hr3_id.toUpperCase()) {
            $(m_DatagridID).datagrid('selectRow', i);
        }
    }  
}


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
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAs&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (dataUtil_undefinedOrNull(data.total, 0) == 0 ) {
                    $(m_DatagridID).datagrid('loadData', []);
                    totalCount = 0;
                } else {
                    totalCount = dataUtil_undefinedOrNull(data.total, 0);
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    if (data.rows[0].hr3_id == '') {
                        $(m_DatagridID).datagrid('loadData', []);
                    }
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

    //重置父页面的子页面参数
    parent.actsonfilter('new');

    
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'任务列表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 420,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        //sortName: 'hr3_rgdt',
        //sortOrder: 'desc',
        remoteSort: false,
        idField: 'hr3_id',
        frozenColumns: [[
            {field:'ck',checkbox:true},
        ]],
        columns: [[
            { field: 'hr3_id', title: 'FID', width: 80, hidden: true },
            { field: 'hr3_rid', title: '关联ID', width: 70, hidden: true },
            { field: 'hr3_type', title: '类型', width: 120 },
            { field: 'hr3_subject', title: '主题', width: 450 },
            { field: 'hr3_state', title: '状态', width: 120 },
            { field: 'hr3_actor', title: '环节', width: 60 },
            { field: 'hr3_comment', title: '历史', width: 300, hidden: true },
            { field: 'hr3_rguser', title: '创建人', width: 70 },
            { field: 'hr3_rgdt', title: '创建时间', width: 125 },
            { field: 'hr3_lmdt', title: '修改时间', width: 105, hidden: true },
            { field: 'hr3_lmuser', title: '修改人', width: 70, hidden: true },
            { field: 'hr3_uptno', title: '修改次数', width: 70, hidden: true }
        ]],
        rownumbers: true,
        singleSelect: false,
        onRowContextMenu: onRowContextMenu,
        onDblClickRow: function (rowIndex, rowData) {
            gridDBClickRow(rowIndex, rowData);
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
*  双击行事件
*  DLY 
*/
function gridDBClickRow(rowIndex, rowData) {
    var cxType = $('#cxType').is(':checked');
    var v1 = 'task';
    var curl = '';
    if (rowData.hr3_type == m_taskTypes[0].value) { //加班申请
        var v0 = 'Q1';
        if (!cxType) {
            v0 = 'Q2';
        } else if (rowData.hr3_actor != m_actors[0].value) { //非申请人
            v0 = 'Q3';
        }
         
        curl = 'overtimesRecode.html?' + 'v0=' + v0 + '&v1=' + v1
             + '&v2=' + rowData.hr3_rid + '&v3=' + rowData.hr3_id
             + '&s=' + new Date().getTime();
    } else if (rowData.hr3_type == m_taskTypes[1].value
        || rowData.hr3_type == m_taskTypes[2].value) {
        var v0 = 'old1';
        if (!cxType) {
            v0 = 'old2';
        }
        curl = 'perInfo.html?' + 'v0=' + v0 + '&v1=' + v1
             + '&v2=' + rowData.hr3_rid + '&v3=' + rowData.hr3_id
             + '&s=' + new Date().getTime();
    } else if (rowData.hr3_type == m_taskTypes[3].value) {
        var v0 = 'old1';
        if (!cxType) {
            v0 = 'old2';
        }
        curl = 'perTurn.html?' + 'v0=' + v0 + '&v1=' + v1
             + '&v2=' + rowData.hr3_rid + '&v3=' + rowData.hr3_id
             + '&s=' + new Date().getTime();
    } else if (rowData.hr3_type == m_taskTypes[4].value) {
        var v0 = 'old1';
        if (!cxType) {
            v0 = 'old2';
        }
        curl = 'perDimiss.html?' + 'v0=' + v0 + '&v1=' + v1
             + '&v2=' + rowData.hr3_rid + '&v3=' + rowData.hr3_id
             + '&s=' + new Date().getTime();
    }

    //保存当前页参数到父页面 begin
    if (cxType) {
        ft = 'T';
    } else {
        ft = 'F';
    }
    var filter = {
        type: "task", cxType: ft,
        cxAppPer: $('#cxAppPer').val(),
        cxTaskType: $('#cxTaskType').combobox('getValue'),
        cxState: $('#cxState').combobox('getValue'),
        cxActor: $('#cxActor').combobox('getValue'),
        page: m_PageNumber,
        sid: rowData.hr3_id, fil: m_Filter, fil1: m_Filter1
    };
    parent.actsonfilter('set', filter);
    //保存当前页参数到父页面 end

    //alert(curl);
    //跳转页面
    parent.turnPage('B', 'tasksPage', curl);
}

/***********************************************************************
 *  添加右击菜单内容
 *  DLY
 *  2014-06-04
 */
function onRowContextMenu(e, rowIndex, rowData) {
    e.preventDefault();
    var rows = $(m_DatagridID).datagrid('getSelections');
    if (rows == null || rows.length == 0) {
        alert('请先选择一条记录！');
        return false;
    }
    if (rows.length > 1) {
        alert('请只选择一行记录，方可查看！');
        return false;
    }
    if (rows.length == 1) {
        $('#mm').menu('show', {
            left: e.pageX,
            top: e.pageY
        });
    }

}


/***********************************************************************
 *  查看审批历史 
 *  DLY 
 */
function view(act) {
    var rowData = $(m_DatagridID).datagrid('getSelected');
    if (act == 'actspls') {
        if (rowData) {
            $('#flowHistoryInfo').dialog({
                title: '审批历史',
                width: 460,
                height: 180,
                left: event.clientX - 20,
                top: event.clientY - 40
            });  
            var itext = '';
            itext = rowData.hr3_comment; 
            var reg = new RegExp("rrbrrr", "g");
            itext = itext.replace(reg, '<br>'); 
            $('#flowHistoryInfoSpan').html(itext);
            $('#flowHistoryInfo').dialog('open');
        } else {
            alert('请先选择一条记录！');
        }
    }   
}


/***********************************************************************
 *  待办任务勾选事件
 *  DLY
 */
function cxTypeChange() { 
    var btns = []
    var cxType = $('#cxType').is(':checked');
    if (cxType) {
        if (m_UserInfo.actor != 'A') {
            btns = [{
                text: '批量审核',
                iconCls: 'icon-redo',
                handler: function () {
                    actApproves();
                }
            }]
        } 
    } else {
        if (m_UserInfo.actor == 'C') {
            btns = [{
                text: '同步加班申请',
                iconCls: 'icon-redo',
                handler: function () { 
                    $('#overtimeSyc').dialog({
                        title: '同步加班申请',
                        width: 460,
                        height: 120,
                        left: 400,
                        top: 100
                    }); 
                    $('#overtimeSyc').dialog('open');
                    $('#c_year').val(new Date().getFullYear());
                }
            }]   
        }
        
    }
    $('#cxpager').pagination({
        buttons: btns
    });
    searchByCons();
}


/***********************************************************************
 *  同步加班申请到EHR
 *  DLY
 */
function actSycOvertimes() {
    var flag = false;
    var year = $('#c_year').val();
    var month = $('#c_month').val();
    if (year == '' || month == '') {
        alert('年份和月份不能为空！');
        return flag;
    }
    var curmonth = year + '-' + month;
    $.messager.confirm('确认框', '确认同步 ' + curmonth + ' 月加班申请吗？', function (r) {
        if (r) {
            //同步到EHR 
            var row = { type: "ovt", month: curmonth, actorid: m_UserInfo.empID };
            var ressjtb = hr_ActDataSync(row);
            if (ressjtb == undefined || ressjtb == "") {
                alert('EHR数据同步失败！');
                return flag;
            } else if (ressjtb.flag == '0') {
                alert('EHR数据同步错误： ' + ressjtb.message);
                return flag;
            } else if (ressjtb.flag == '1') {
                alert('同步数据成功！ '); 
                $('#overtimeSyc').dialog('close');
                return flag;
            }
        }
    });
    return flag;
}


/***********************************************************************
*  查看汇总
*  DLY 
*/
function getOTHZInfo() { 
    var flag = false;
    var year = $('#c_year').val();
    var month = $('#c_month').val();
    if (year == '' || month == '') {
        alert('年份和月份不能为空！');
        return flag;
    }
    var curmonth = year + '-' + month;
    $('#hzInfodlg').dialog('open');
    var con = { orgid: m_UserInfo.selfInfo.c_orgid, month: curmonth };
    m_pers = hr_getOTHZInfo(con);
    var hzinfo = '<table style="width:420px; margin-left:10px;">';
    hzinfo = hzinfo + '<tr><td>店铺名称</td><td>姓 名</td><td>员工号</td><td>加班(小时)</td>'
           + '<td><a href="#" class="easyui-linkbutton" data-options=" plain:true," onclick="actToExcel(1)">导出excel</a> </td></tr>'
    for (var j = 0; j < m_pers.length; j++) {
        hzinfo = hzinfo + '<tr>';
        hzinfo = hzinfo + '<td>' + m_pers[j].shopname + '</td>'
               + '<td>' + m_pers[j].hr2_empname + '</td>'
               + '<td>' + m_pers[j].hr2_empcode + '</td>'
               + '<td>' + m_pers[j].hr2_othours + '</td>';
        hzinfo = hzinfo + '</tr>';
    }
    hzinfo = hzinfo + '</table>';
    $('#hzInfoSpan').html(hzinfo);
}

/***********************************************************************
*  流程 批量审批
*  DLY 
*/
function actApproves() {
    var flag = false;
    var flagBreak = false;
    var rows = $(m_DatagridID).datagrid('getSelections');
    if(rows.length>0){
        var rowDataT = [];
        var billsStr = ''; //可审批记录
        var billsStr1 = ''; //不可审批记录
        var n = 0;
        for (var i = 0; i < rows.length; i++) {
            //不可审批记录校验 
        }  
        if(n>0){ 
        }else if(n==0){
            var str = '确认批量审批如下申请吗？ 共<font color="red">' + rows.length + '</font>条 <br> <br> ' ;
            $.messager.confirm('确认框',str,function(r){   
                if (r){    
                    for (var i = 0; i < rows.length; i++) {
                        res = rows[i];  
                        if ([i].hr3_type == m_taskTypes[0].value) {  //加班申请
                            //审批操作
                            var actinfo = '';
                            var actT = dateUtil_dateFomaterA(new Date(), '-');
                            actinfo = '审核';
                            if (res.hr3_actor == '经理') {
                                res.hr3_comment = res.hr3_comment + '经理：' + m_UserInfo.userName + ' ' + actT + actinfo + 'rrbrrr';
                                res.hr3_state = '人资待批';
                                res.hr3_actor = '人资';
                            } else if (res.hr3_actor == '人资') {
                                res.hr3_comment = res.hr3_comment + '人资：' + m_UserInfo.userName + ' ' + actT + actinfo + 'rrbrrr';
                                res.hr3_state = '已完结';
                                res.hr3_actor = '';
                            }
                            //修改任务信息  
                            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
                            if (!flag1) {
                                alert(actinfo + '失败，请截全屏图发给系统管理员！');
                                actLoadDataToS(res.hr3_id);
                                flagBreak = true;
                                break;
                            }
                            //修改主表状态 
                            var zrow = {};
                            zrow.hr1_id = m_MID;
                            zrow.hr1_state = res.hr3_state;
                            flag1 = hr_saveOTApply('U', zrow, m_UserInfo.userName);
                            if (!flag1) {
                                alert('回写加班主信息失败，请截全屏图发给系统管理员！'); 
                                actLoadDataToS(res.hr3_id);
                                flagBreak = true;
                                break;
                            }
                        } else {
                            //审批操作
                            var actinfo = '';
                            var actT = dateUtil_dateFomaterA(new Date(), '-'); 
                            actinfo = '审核';
                            if (res.hr3_actor == '人资') {
                                res.hr3_comment = res.hr3_comment + '人资：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
                                res.hr3_state = '已完结';
                                res.hr3_actor = '';
                            } 
                            //同步到EHR
                            if (res.hr3_state == '已完结') {
                                var row = { type: "emp", taskid: res.hr3_id, actorid: m_UserInfo.empID };
                                var ressjtb = hr_ActDataSync(row);
                                if (ressjtb == undefined || ressjtb == "") {
                                    alert('EHR数据同步失败！'); 
                                    actLoadDataToS(res.hr3_id);
                                    flagBreak = true;
                                    break;
                                } else if (ressjtb.flag == '0') {
                                    alert('EHR数据同步错误： ' + ressjtb.message); 
                                    actLoadDataToS(res.hr3_id);
                                    flagBreak = true;
                                    break;
                                }
                            }
                            //修改任务信息  
                            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
                            if (!flag1) {
                                alert(actinfo + '失败，请截全屏图发给系统管理员！') 
                                actLoadDataToS(res.hr3_id);
                                flagBreak = true;
                                break;
                            } 
                        }  
                    }  
                }
                if (!flagBreak) {
                    flag = true;
                    actLoadData(m_PageNumber, m_PageSize);
                    alert('批量审批成功！');
                }
            });   
        }   
    }else{
        alert('至少选择一条记录，方可审批！');
        return flag;
    }
    return flag;
}


/***********************************************************************
*  刷新到特殊行
*  DLY 
*/
function actLoadDataToS(sid) {
    actLoadData(m_PageNumber, m_PageSize);
    var rows = $(m_DatagridID).datagrid('getRows');
    for (var i = 0; i < rows.length; i++) {
        if (sid.toUpperCase() == rows[i].hr3_id.toUpperCase()) {
            $(m_DatagridID).datagrid('selectRow', i);
        }
    } 
}


/***********************************************************************
*  导出Excel
*  DLY 
*/
function actToExcel(type) {
    var rows = []
    if (type == 1) {
        rows = dataExpotToFile('1', m_pers);
        return;
    }
}
