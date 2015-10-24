/* 全局变量*/
var m_DatagridID = '#cqtxlb'; //加班记录列表
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

var m_Flag = '';

var m_MID = '';     //主表ID
var m_ShopID = '';  //店铺ID
var m_ShopName = '';//店铺名字
var m_ATState = ''; //当前状态
var m_ATMonth = '';   //考勤月份
var m_ApproveID = '';   //待办ID

var m_Footer = [];
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
    var type = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '');
    m_MID = dataUtil_undefinedOrNull(basedata_getUrlParam("v1"), '');
    m_ApproveID = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
    if (type == 'old') {
        controlTools(1);
    } else if (type == 'approve') {
        controlTools(2);
    }
    //获取主信息
    var cons = ' AND ( HR11_ID = \'' + m_MID + '\')';
    var res = hr_getAttendanceInfo(cons, 1, 1, '');
    if (res == '') {
        alert('id对应的主表信息无法获取！');
        return;
    }
    zrow = res.rows[0];
    m_ATState = zrow.hr11_state;
    m_ATMonth = zrow.hr11_atmonth;
    m_ShopID = zrow.hr11_shopid;
    m_ShopName = zrow.hr11_shopname;
    m_Flag = dateUtil_DayNumOfMonth(m_ATMonth.substring(0, 4), m_ATMonth.substring(5, 7));
    $('#shopname').html(zrow.hr11_shopname);
    $('#month').html(zrow.hr11_atmonth);
    setDataGrid();
    actLoadData(1, m_PageSize);
});


/***********************************************************************
*  加载数据
*  DLY 
*/
function actLoadData(page, number) {
    $(m_DatagridID).datagrid('loadData', []);

    var cons = ' AND ( HR12_MID = \'' + m_MID + '\')';
    var res = hr_getAttendanceRecord(cons, page, number, 'HR12_EmpCode');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    } else if (res.total > 0) {
        //计算总数
        var footer = {
            hr12_empname: "<font color='red' size='2'>合计:</font>", hr12_attendance: 0, hr12_rest: 0, hr12_absence: 0, hr12_casualleave: 0, hr12_sickleave: 0, hr12_marriageleave: 0,
            hr12_maternityleave: 0, hr12_bereavementleave: 0, hr12_annualleave: 0, hr12_dimission: 0, hr12_blank: 0
        }
        for (var i = 0; i < res.rows.length; i++) {
            footer.hr12_attendance += parseInt(res.rows[i].hr12_attendance);
            footer.hr12_rest += parseInt(res.rows[i].hr12_rest);
            footer.hr12_absence += parseInt(res.rows[i].hr12_absence);
            footer.hr12_casualleave += parseInt(res.rows[i].hr12_casualleave);
            footer.hr12_sickleave += parseInt(res.rows[i].hr12_sickleave);
            footer.hr12_marriageleave += parseInt(res.rows[i].hr12_marriageleave);
            footer.hr12_maternityleave += parseInt(res.rows[i].hr12_maternityleave);
            footer.hr12_bereavementleave += parseInt(res.rows[i].hr12_bereavementleave);
            footer.hr12_annualleave += parseInt(res.rows[i].hr12_annualleave);
            footer.hr12_dimission += parseInt(res.rows[i].hr12_dimission);
            footer.hr12_blank += parseInt(res.rows[i].hr12_blank);
        }
        m_Footer.push(footer);
        res.footer = m_Footer;
        $(m_DatagridID).datagrid('loadData', res.rows);
    }
    $(m_DatagridID).datagrid("clearSelections");
}


/***********************************************************************
*  流程  (店长——）大区经理——人资
*  SY
*/
function actApprove(type) {
    //数据修改校验 
    if (m_LastIndex != -1) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }

    //任务状态校验 
    var taskid = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
    if (taskid == '') {
        alert('任务ID无效，请截全屏图发给系统管理员！');
        return;
    }
    var cons = ' AND  HR3_ID= \'' + taskid + '\'';
    var res = hr_getTask(cons);
    if (res == '1') {
        alert('未找到对应待办任务，请截全屏图发给系统管理员！');
        return;
    } else if (res.hr3_id != undefined && res.hr3_id != '') {
        if (res.hr3_state != m_ATState) {
            alert('该任务状态已更新，请刷新任务！');
            return;
        }
    } else {
        alert('待办任务信息获取失败，请截全屏图发给系统管理员！');
        return;
    }


    //审批操作
    var actinfo = '';
    var actT = dateUtil_dateFomaterA(new Date(), '-');
    if (type == 'sh') {
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
    } else if (type == 'bh') {
        actinfo = '驳回';
        if (res.hr3_actor == '经理') {
            res.hr3_comment = res.hr3_comment + '经理：' + m_UserInfo.userName + ' ' + actT + actinfo + 'rrbrrr';
            res.hr3_state = '经理(驳回)';
            res.hr3_actor = '申请人';
        } else if (res.hr3_actor == '人资') {
            res.hr3_comment = res.hr3_comment + '人资：' + m_UserInfo.userName + ' ' + actT + actinfo + 'rrbrrr';
            res.hr3_state = '人资(驳回)';
            res.hr3_actor = '申请人';
        }
    }

    $.messager.confirm('确认框', '确认' + actinfo + '该考勤申请吗？', function (r) {
        if (r) {
            //修改任务信息  
            var flag = hr_saveTask('U', res, m_UserInfo.userName);
            if (!flag) {
                alert(actinfo + '失败，请截全屏图发给系统管理员！')
                return;
            }
            //修改主表状态 
            var zrow = {};
            var cons = ' AND  HR11_ID= \'' + m_MID + '\'';
            var zrows = hr_getAttendanceInfo(cons, 1, 1, '');
            if (zrows == '') {
                alert('id对应的主表信息无法获取！');
                return;
            }
            zrow = zrows.rows[0];
            zrow.hr11_state = res.hr3_state;
            zrow.hr11_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            zrow.hr11_lmuser = m_UserInfo.userName;
            zrow.hr11_uptno++;
            zrows = [];
            zrows.push(zrow);
            var cXMLd = GetEditJson([], zrows, []);//json转xml
            //保存主表
            flag = hr_saveAttendanceInfo(cXMLd, m_UserInfo.userName);
            if (!flag) {
                alert('回写考勤主信息失败，请截全屏图发给系统管理员！')
                return flag;
            }
            alert(actinfo + '成功！');
            parent.turnPage('A', 'tasks', '');
        }
    });
}


/***********************************************************************
*  关闭
*  SY 
*/
function actClose() {
    parent.turnPage('A', 'tasks', '');
}


/***********************************************************************
*  工具条及按钮控制
*  SY 
*/
function controlTools(type) {
    if (type == 1) {    //全不可见 - （除汇总查询）
        $('#tool').show();
        $('#btndetail').show();
        $('#btnsh').hide();
        $('#btnbh').hide();
    } else if (type == 2) {  //审批人 - 待办
        $('#tool').show();
        $('#btndetail').show();
        $('#btnsh').show();
        $('#btnbh').show();
    }
}


/***********************************************************************
*  设置列表
*  SY
*/
function setDataGrid() {
    //信息列表
    $(m_DatagridID).datagrid({
        //title:'加班记录列表',
        //iconCls:'icon-save',
        width: $(document.body).width(),
        height: 420,
        nowrap: true,
        striped: true,
        collapsible: true,
        //url:'mroomlist.action',
        sortName: 'hr12_empcode',
        sortOrder: 'asc',
        remoteSort: false,
        idField: 'hr12_id',
        showFooter: true,
        frozenColumns: [[
            //{field:'ck',checkbox:true},
            { field: 'hr12_id', title: 'ID', width: 80, hidden: true },
            { field: 'hr12_mid', title: 'MID', width: 80, hidden: true },
            { field: 'hr12_empid', title: '员工号', width: 80, hidden: true },
            { field: 'hr12_empcode', title: '工号', width: 70, align: 'center' },
            { field: 'hr12_empname', title: '姓名', width: 65, align: 'center' },
        ]],
        columns: [[
            { field: 'hr12_day01', title: '1', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day02', title: '2', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day03', title: '3', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day04', title: '4', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day05', title: '5', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day06', title: '6', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day07', title: '7', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day08', title: '8', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day09', title: '9', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day10', title: '10', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day11', title: '11', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day12', title: '12', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day13', title: '13', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day14', title: '14', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day15', title: '15', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day16', title: '16', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day17', title: '17', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day18', title: '18', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day19', title: '19', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day20', title: '20', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day21', title: '21', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day22', title: '22', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day23', title: '23', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day24', title: '24', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day25', title: '25', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day26', title: '26', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day27', title: '27', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day28', title: '28', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day29', title: '29', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day30', title: '30', width: 45, align: 'center', hidden: true },
            { field: 'hr12_day31', title: '31', width: 45, align: 'center', hidden: true },
            { field: 'hr12_attendance', title: '出勤', width: 80, align: 'center' },
            { field: 'hr12_rest', title: '休息', width: 80, align: 'center' },
            { field: 'hr12_absence', title: '旷工', width: 80, align: 'center' },
            { field: 'hr12_casualleave', title: '事假', width: 80, align: 'center' },
            { field: 'hr12_sickleave', title: '病假', width: 80, align: 'center' },
            { field: 'hr12_marriageleave', title: '婚假', width: 80, align: 'center' },
            { field: 'hr12_maternityleave', title: '产假', width: 80, align: 'center' },
            { field: 'hr12_bereavementleave', title: '丧假', width: 80, align: 'center' },
            { field: 'hr12_annualleave', title: '年休', width: 80, align: 'center' },
            { field: 'hr12_dimission', title: '离职', width: 80, align: 'center' },
            { field: 'hr12_blank', title: '空白', width: 80, align: 'center' }
        ]],
        rownumbers: true,
        singleSelect: true,
        //onRowContextMenu:onRowContextMenu,
        onDblClickRow: function () {
        },
        onClickRow: function (rowIndex) {
        },
        onLoadSuccess: function (data) {
            $(m_DatagridID).datagrid('reloadFooter', m_Footer);
        }
    });
}


/***********************************************************************
*  查看明细
*  SY
*/
function actDetail() {
    window.open("../../../WEB/PE_OA/HR/checkAttendancePrint.html?v0=" + m_MID + "&v1=" + m_ATMonth);
}