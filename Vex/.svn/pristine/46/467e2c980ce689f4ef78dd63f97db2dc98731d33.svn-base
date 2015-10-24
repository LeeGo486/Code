/* 全局变量*/ 
var m_DatagridID = '#jbjllb'; //加班记录列表
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

var m_OTApply = '';
var m_MID = '';
var m_curM = dateUtil_getMonthByDay('', '-', '5').substring(0, 7); //操作月份 
var m_EmpList = [];
var m_OTReason = [{ text: "店铺缺编" }, { text: "商场大型活动、店庆" }, { text: "装修值班" }, { text: "其他" }];

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
    var type = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '');
    var type1 = dataUtil_undefinedOrNull(basedata_getUrlParam("v1"), '');
    m_MID = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
    m_ApproveID = dataUtil_undefinedOrNull(basedata_getUrlParam("v3"), '');
    if (m_MID == '') {
        return false;
    }
    //初始化列表
    if (type == 'N') {  // 新建
        setDataGrid('1'); // 明细可编辑
        controlTools(2);  // 无提交按钮，保存后生成待办
        $('#shopNameSpan').html(m_UserInfo.deptName);
        $('#OTMonthSpan').html(m_curM);
        $('#stateSpan').html('未提交');
    } else {            // 查看 或 待办任务  
        var cons = ' AND  HR1_ID= \'' + m_MID + '\'';
        m_OTApply = hr_getOTApply(cons);
        if (m_OTApply == '' || m_OTApply.hr1_id == undefined) {
            alert('id无效, 未找到对应加班明细！');
            return;
        }
        m_curM = m_OTApply.hr1_otmonth;
        $('#shopNameSpan').html(m_OTApply.hr1_shopname);
        $('#OTMonthSpan').html(m_OTApply.hr1_otmonth);
        $('#stateSpan').html(m_OTApply.hr1_state); 
        if (type == 'Q1') {   
            setDataGrid('1'); // 明细可编辑
            //获取店铺员工
            controlTools(3);  // 申请人-待办           
        } else if (type == 'Q2' || type == 'Q3') {
            setDataGrid('2'); // 明细只读
            if (type == 'Q3') {  // 审批人-待办
                controlTools(4);
            } else {    //仅供查看
                controlTools(1);
            }
        }
        m_Filter1 = ' AND hr2_mid = \'' + m_MID + '\'';
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
    var cXML = '<Page>' + page + '</Page><Num>' + number + '</Num>'
            + '<Cons>' + m_Filter + m_Filter1 + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>';
    cXML = basedata_addROOT(cXML);
    var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetDs&XML=" + encodeURIComponent(cXML); //拼接url
    //alert(cXML);	
    $.ajax({
        url: curl,
        type: "GET",
        async: false,
        dataType: "json",
        success: function (data) {
            //alert(jsonUtil_jsonToStr(data));
            if (data && data.rows) {
                if (dataUtil_undefinedOrNull(data.total, 0) == 0) {
                    $(m_DatagridID).datagrid('loadData', []);
                    totalCount = 0;
                } else {
                    totalCount = dataUtil_undefinedOrNull(data.total, 0);
                    $(m_DatagridID).datagrid('loadData', data.rows);
                    $(m_DatagridID).datagrid('clearSelections');
                }
            }
        }
    })
    $('#numsSpan').html(totalCount);
}


/***********************************************************************
*  新增
*  DLY 
*/
function actAdd() {
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var rownew = {};
    rownew.hr2_id = dataUtil_NewGuid();
    rownew.hr2_mid = m_MID;
    //工资默认为0
    rownew.hr2_otmoney = 0;
    rownew.hr2_rguser = m_UserInfo.userName;
    rownew.hr2_rgdt = dateUtil_dateFomaterA(new Date(), '-');
    rownew.hr2_uptno = 0; 
    $(m_DatagridID).datagrid('appendRow', rownew);
    m_LastIndex = $(m_DatagridID).datagrid('getRows').length - 1;
    $(m_DatagridID).datagrid('selectRow', m_LastIndex);
    $(m_DatagridID).datagrid('beginEdit', m_LastIndex); 
}


/***********************************************************************
*  复制
*  DLY 
*/
function actCopy() {
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var row = $(m_DatagridID).datagrid('getSelected');
    if (row) {
        var rownew = {};
        rownew.hr2_id = dataUtil_NewGuid();
        rownew.hr2_rguser = m_UserInfo.userName;
        rownew.hr2_rgdt = dateUtil_dateFomaterA(new Date(), '-'); 
        rownew.hr2_uptno = 0;
        rownew.hr2_mid = m_MID;
        rownew.hr2_empname = row.hr2_empname;
        rownew.hr2_empcode = row.hr2_empcode;
        rownew.hr2_reason = row.hr2_reason;
        rownew.hr2_remark = row.hr2_remark;
        rownew.hr2_otdt = row.hr2_otdt;
        rownew.hr2_otstart = row.hr2_otstart;
        rownew.hr2_otend = row.hr2_otend;
        rownew.hr2_othours = row.hr2_othours;
        //新增工资字段
        rownew.hr2_otmoney = row.hr2_otmoney;
        rownew.hr2_sales = row.hr2_sales;  
        $(m_DatagridID).datagrid('appendRow', rownew);
        m_LastIndex = $(m_DatagridID).datagrid('getRows').length - 1;
        $(m_DatagridID).datagrid('selectRow', m_LastIndex);
        $(m_DatagridID).datagrid('beginEdit', m_LastIndex);
    } else {
        alert('请先选中被复制行！');
    }
    
    
}


/***********************************************************************
*  删除
*  DLY 
*/
function actDel() {
    var row = $(m_DatagridID).datagrid('getSelected');
    if (row) {
        $.messager.confirm('确认框', '确认删除此记录吗？', function (r) {
            if (r) {
                var index = $(m_DatagridID).datagrid('getRowIndex', row);
                $(m_DatagridID).datagrid('deleteRow', index);
                m_LastIndex = -1; 
            }
        });
    } 
}
 

/***********************************************************************
*  保存
*  DLY 
*/
function actSave() {
    var flag = false; //总标志
    var flag1 = false; //分步保存成功标志
    var flag2 = false; //是否新建标志
    var type = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), ''); 
    var shopCode = m_UserInfo.deptCode 
    var zrow = {}; //主信息

    //获取明细 
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    var dataRows = $(m_DatagridID).datagrid('getRows');

    //校验
    if (m_UserInfo.empCode1 == undefined) {
        alert('未获取到店铺对于大区经理配置，请截图联系系统管理员！');
        return flag;
    }
    if (m_UserInfo.empCode2 == undefined) {
        alert('未获取到公司对于人资负责人配置，请截图联系系统管理员！');
        return flag;
    } 
    for (var i = 0; i < dataRows.length; i++) {
        var j = i * 1 + 1;
        if (dataRows[i].hr2_empcode == '') {
            alert('第' + j + '行职员代码不能为空！');
            return flag;
        }
        if (dataRows[i].hr2_reason == '') {
            alert('第' + j + '行加班原因不能为空！');
            return flag;
        }
        if (dataRows[i].hr2_otdt == '') {
            alert('第' + j + '行加班日期不能为空！');
            return flag;
        }
        if (dataRows[i].hr2_otdt.substring(0, 7) != m_curM) {
            alert('第' + j + '行加班日期不属于申请月份！');
            return flag;
        }
        if (dataRows[i].hr2_othours*1 < 2) {
            alert('第' + j + '行加班(小时)必须超过2小时！');
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
            updated[i].hr2_lmdt = dateUtil_dateFomaterA(new Date(), '-')
            updated[i].hr2_lmuser = m_UserInfo.userName;
            updated[i].hr2_uptno = updated[i].hr2_uptno * 1 + 1;
            updated[i].hr2_uptno = updated[i].hr2_uptno * 1 + 1;
        }
        cXMLd = GetEditJson(inserted, updated, deleted);//json转xml
    } else {
        alert('没有修改信息！');
        return flag;
    }
    //alert(cXMLd);


    //保存校验
    // 1.每月一单校验
    var cons = ' AND  HR1_OTMonth= \'' + m_curM + '\''
             + ' AND  HR1_ShopCode= \'' + shopCode + '\'';
    var res = hr_getOTApply(cons);
    var zrow = {};
    if (res == '1') {
        flag2 = 'new';
        zrow.hr1_id = m_MID;
        zrow.hr1_otmonth = $('#OTMonthSpan').html(); 
        zrow.hr1_shopname = m_UserInfo.deptName;
        zrow.hr1_shopcode = m_UserInfo.deptCode;
        zrow.hr1_shopid = m_UserInfo.deptID;
        zrow.hr1_state = '未提交';
        zrow.hr1_rguser = m_UserInfo.userName;
        zrow.hr1_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.hr1_uptno = 0; 
    } else if (res.hr1_id != undefined && res.hr1_id != '') {
        if (type == 'N'){ 
            alert('已存在' + m_curM + '申请，不可保存新建申请！');
            return flag;
        }
        //2.单据状态校验
        if (res.hr1_state == '经理待批' || res.hr1_state == '人资待批' ||
              res.hr1_state == '已完结' || res.hr1_otmonth != m_curM) {
            alert('该申请已不可修改, 请确认当前状态或月份！');
            return flag;
        }
        flag2 = 'old';
        zrow = res;
        zrow.hr1_lmuser = m_UserInfo.userName;
        zrow.hr1_lmdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.hr1_uptno = 1 * zrow.hr1_uptno + 1;
    } else {
        alert('每月一单,校验失败，请截全屏图发给系统管理员！');
        return flag;
    }
    //3.加班明细校验
    //if (!saveCheck()) {
    //    return flag;
    //} 
     

    //新建申请
    if (flag2 == 'new') {
        //保存主表
        flag1 = hr_saveOTApply('N', zrow, m_UserInfo.userName);
        if (!flag1) {
            alert('保存加班主信息失败！')
            return flag;
        }

        //生成任务行
        var arow = {};
        arow.hr3_id = dataUtil_NewGuid();
        arow.hr3_rid = zrow.hr1_id;
        arow.hr3_type = m_taskTypes[0].value;
        arow.hr3_subject = m_UserInfo.deptName + '(' + $('#OTMonthSpan').html() + ') - '+m_taskTypes[0].value;
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
        flag1 = hr_saveOTRecords(cXMLd, m_UserInfo.userName);
        if (!flag1) {
            alert('保存加班明细信息失败！')
            return flag;
        } 

        //加班申请保存成功后，调用存储过程计算加班工资
        flag1 = hr_setOTMoney(arow.hr3_id);
        if (!flag1) {
            alert('加班工资计算失败！')
            return flag;
        }
       
        alert('保存成功！');
        setDataGrid('2'); // 明细只读
        // 跳转到任务页
        var curlo = 'overtimesRecode.html?' + 'v0=Q1&v1=task&v2=' + zrow.hr1_id
                     + '&v3=' + arow.hr3_id
                     + '&s=' + new Date().getTime();
        parent.turnPage('B', 'tasksPage', curlo);
    } else if (flag2 == 'old') {
        //保存主表
        flag1 = hr_saveOTApply('U', zrow, m_UserInfo.userName);
        if (!flag1) {
            alert('保存加班主信息失败！')
            return flag;
        }

        //保存明细
        flag1 = hr_saveOTRecords(cXMLd, m_UserInfo.userName);
        if (!flag1) {
            alert('保存加班明细信息失败！')
            return flag;
        }

        //加班申请保存成功后，调用存储过程计算加班工资
        flag1 = hr_setOTMoney(m_ApproveID);
        if (!flag1) {
            alert('加班工资计算失败！')
            return flag;
        }

        actLoadData(1, m_PageSize);
        alert('保存成功！');
    }
}


/***********************************************************************
*  流程  店长——大区经理——人资
*  DLY 
*/
function actApprove(type) {
    var flag = false;
    //数据修改校验 
    $(m_DatagridID).datagrid('endEdit', m_LastIndex); 
    if ($(m_DatagridID).datagrid('getChanges').length > 0) { 
        alert('数据已修改，请先保存！');
        return;
    } 
         
    //任务状态校验 
    var taskid = dataUtil_undefinedOrNull(basedata_getUrlParam("v3"), '');
    if (taskid == '') {
        alert('任务ID无效，请截全屏图发给系统管理员！');
        return;
    }
    var cons = ' AND  HR3_ID= \'' + taskid + '\'';
    var res = hr_getTask(cons);
    var zrow = {};
    if (res == '1') {
        alert('未找到对应待办任务，请截全屏图发给系统管理员！');
        return;
    } else if (res.hr3_id != undefined && res.hr3_id != '') {
        if(res.hr3_state != $('#stateSpan').html()){ 
            alert('该任务状态已更新，请刷新任务！');
            return flag;
        } 
    } else {
        alert('待办任务信息获取失败，请截全屏图发给系统管理员！');
        return flag;
    }
     

    //审批操作
    var actinfo = '';  
    var actT = dateUtil_dateFomaterA(new Date(), '-');
    if (type == 'tj') {
        actinfo = '提交';
        res.hr3_comment = res.hr3_comment + '店长：' + m_UserInfo.userName + ' ' + actT + actinfo + 'rrbrrr';
        res.hr3_state = '经理待批';
        res.hr3_actor = '经理';
    } else if (type == 'sh') {
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
     
    $.messager.confirm('确认框', '确认' + actinfo + '该加班申请吗？', function (r) {
        if (r) { 
            //修改任务信息  
            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
            if (!flag1) {
                alert(actinfo + '失败，请截全屏图发给系统管理员！')
                return flag;
            }
            //修改主表状态 
            var zrow = {};
            zrow.hr1_id = m_MID;
            zrow.hr1_state = res.hr3_state;
            flag1 = hr_saveOTApply('U', zrow, m_UserInfo.userName);
            if (!flag1) {
                alert('回写加班主信息失败，请截全屏图发给系统管理员！')
                return flag;
            }
            alert(actinfo + '成功！');
            parent.turnPage('A', 'tasks', '');
        }
    }); 
}


/***********************************************************************
*  设置汇总
*  DLY 
*/
function setHZInfo() {
    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    $('#hzInfodlg').dialog('open'); 
    var rows = $(m_DatagridID).datagrid('getRows');
    var pers = [];
    for (var i = 0; i < rows.length; i++) {
        var flag = 0;  
        for (var j = 0; j < pers.length; j++) { 
            if (rows[i].hr2_empcode == pers[j].hr2_empcode) {
                flag = 1;
                pers[j].hr2_othours = 1 * pers[j].hr2_othours + 1 * rows[i].hr2_othours;
                break;
            }
        } 
        if (flag == 0) {
            var obj = {};
            obj.hr2_empcode = rows[i].hr2_empcode;
            obj.hr2_empname = rows[i].hr2_empname;
            obj.hr2_othours = rows[i].hr2_othours;
            pers.push(obj);
        } 
    } 
    var hzinfo = '<table style="width:300px; margin-left:10px;">';
    hzinfo = hzinfo + '<tr><td>姓 名</td><td>加班(小时)</td></tr>'
    for (var j = 0; j < pers.length; j++) {
        hzinfo = hzinfo + '<tr>';
        hzinfo = hzinfo + '<td>' + pers[j].hr2_empname + '</td>'
               + '<td>' + pers[j].hr2_othours + '</td>'; 
        hzinfo = hzinfo + '</tr>';
    } 
    hzinfo = hzinfo + '</table>'; 
    $('#hzInfoSpan').html(hzinfo);
}


/***********************************************************************
*  关闭
*  DLY 
*/
function actClose() {
    var type = dataUtil_undefinedOrNull(basedata_getUrlParam("v1"), '');
    if (type == 'task') {
        parent.turnPage('A', 'tasks', '');
    } else if (type == 'list') {  
        parent.turnPage('A', 'overtimesApply', '');
    } 
}


/***********************************************************************
*  工具条及按钮控制
*  DLY 
*/
function controlTools(type) {
    if (type == 1) {    //全不可见 - （除汇总查询）
        $('#tool1').show();
        $('#tjbtn').hide();
        $('#shbtn').hide();
        $('#bhbtn').hide();
        $('#tool2').hide();
    } else if (type == 2) { //申请人 - 新建
        $('#tool1').show();
        $('#tjbtn').hide();
        $('#shbtn').hide();
        $('#bhbtn').hide();
        $('#tool2').show();
    } else if (type == 3) { //申请人 - 待办
        $('#tool1').show();
        $('#shbtn').hide();
        $('#bhbtn').hide();
        $('#tool2').show();
    } else if (type == 4) {  //审批人 - 待办
        $('#tool1').show();  
        $('#tjbtn').hide();
        $('#tool2').hide();
    } 
}


/***********************************************************************
*  设置列表
*  DLY 
*/
function setDataGrid(type) {
    if (type == '1') {
        //信息列表
        $(m_DatagridID).datagrid({
            //title:'加班记录列表',
            //iconCls:'icon-save',
            width: $(document.body).width(),
            height: 460,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            sortName: 'hr2_empname',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'hr2_id',
            frozenColumns: [[
                //{field:'ck',checkbox:true},
            ]],
            columns: [[
                { field: 'hr2_id', title: 'FID', width: 80, hidden: true },
                { field: 'hr2_mid', title: 'MID', width: 80, hidden: true },
                { field: 'hr2_empname', title: '姓名', width: 70, sortable: true, editor: {
                    type: 'combobox', editable: true, options: {
                        valueField: 'c_name', textField: 'c_name',
                        data: m_EmpList, panelHeight: "100",
                        onShowPanel: function () {
                            //重新加载人员信息   
                            if (m_EmpList.length == 0) {
                                var row = { type: '1', c_employeestatus: '\'1\',\'2\',\'6\'', c_orgunitid: m_UserInfo.deptID };
                                m_EmpList = hr_getShopPers(row); 
                            }
                            var ed = $(m_DatagridID).datagrid('getEditor', { index: m_LastIndex, field: 'hr2_empname' });
                            ed.target.combobox('loadData', m_EmpList);
                        },
                        onSelect: function (record) {
                                //填充人员编码 
                                var ed = $(m_DatagridID).datagrid('getEditor', { index: m_LastIndex, field: 'hr2_empcode' });
                                ed.target.val(record.c_code);
                            },
                        onHidePanel: function () { 
                        }
                      }
                    }
                },
                { field: 'hr2_empcode', title: '职员代码', width: 70, editor: 'text' },
                { field: 'hr2_reason', title: '加班原因', width: 150
                     , editor: {
                         type: 'combobox', options: {
                             valueField: 'text', textField: 'text',
                             data: m_OTReason, editable: false, panelHeight: "100",
                             onShowPanel: function () {
                             },
                             onSelect: function (record) {
                             },
                             onHidePanel: function () {
                             }
                         }
                     }
                },
                { field: 'hr2_remark', title: '备注', width: 150, editor: 'text' },
                { field: 'hr2_otdt', title: '加班日期', width: 90, editor: 'datebox' },
                { field: 'hr2_otstart', title: '加班开始', width: 80, editor: 'text' },
                { field: 'hr2_otend', title: '加班结束', width: 80, editor: 'text' },
                { field: 'hr2_othours', title: '加班(小时)', width: 88, align: "right"
				    , editor: { type: 'numberbox', options: { precision: 2, min: 0 } }
                },
                { field: 'hr2_otmoney', title: '加班工资', width: 88, align: "right"},
                { field: 'hr2_sales', title: '个人销售额', width: 88, align: "right"
				    , editor: { type: 'numberbox', options: { precision: 2, min: 0 }}},
                { field: 'hr2_rguser', title: '创建人', width: 70 },
                { field: 'hr2_rgdt', title: '创建时间', width: 125 },
                { field: 'hr2_lmdt', title: '修改时间', width: 105, hidden: true },
                { field: 'hr2_lmuser', title: '修改人', width: 70, hidden: true },
                { field: 'hr2_uptno', title: '修改次数', width: 70, hidden: true }
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
            },
            toolbar: '#xxcxk'
        });
    } else if (type == '2') {
        //信息列表
        $(m_DatagridID).datagrid({
            //title:'加班记录列表',
            //iconCls:'icon-save',
            width: $(document.body).width(),
            height: 460,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            sortName: 'hr2_empname',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'hr2_id',
            frozenColumns: [[
                //{field:'ck',checkbox:true},
            ]],
            columns: [[
                { field: 'hr2_id', title: 'FID', width: 80, hidden: true },
                { field: 'hr2_mid', title: 'MID', width: 80, hidden: true },
                { field: 'hr2_empname', title: '姓名', width: 70, sortable: true },
                { field: 'hr2_empcode', title: '职员代码', width: 70, sortable: true },
                { field: 'hr2_reason', title: '加班原因', width: 150, sortable: true },
                { field: 'hr2_remark', title: '备注', width: 150, sortable: true },
                { field: 'hr2_otdt', title: '加班日期', width: 90 },
                { field: 'hr2_otstart', title: '加班开始', width: 80 },
                { field: 'hr2_otend', title: '加班结束', width: 80 },
                { field: 'hr2_othours', title: '加班(小时)', width: 88, align: "right" },
                { field: 'hr2_otmoney', title: '加班工资', width: 88, align: "right" },
                { field: 'hr2_sales', title: '个人销售额', width: 88, align: "right" },
                { field: 'hr2_rguser', title: '创建人', width: 70 },
                { field: 'hr2_rgdt', title: '创建时间', width: 125 },
                { field: 'hr2_lmdt', title: '修改时间', width: 105, hidden: true },
                { field: 'hr2_lmuser', title: '修改人', width: 70, hidden: true },
                { field: 'hr2_uptno', title: '修改次数', width: 70, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true,
            //onRowContextMenu:onRowContextMenu,
            onDblClickRow: function () {
            },
            onClickRow: function (rowIndex) {
            },
            toolbar: '#xxcxk'
        });
    }


}
