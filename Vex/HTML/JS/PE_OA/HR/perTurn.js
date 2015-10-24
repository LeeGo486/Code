 var m_DatagridID = '#deptgrid'; //部门选择列表ID
 var m_LastIndex = -1;  //部门选择列表最后一次选中行下标  
 var m_PageSize = 20;  //查询记录数
 var m_dlgID = '#deptdlg'; //部门选择窗ID
 var m_dlgOFlag = 0; //是否首次打开标志
 
 
 //状态下拉选择
 var m_protimesZT = [ {statets:'启用',statevs:'启用'},{statets:'禁用',statevs:'禁用'} ];
 var m_depttree = []; //组织架构树
 
 //用户信息
 var m_UserInfo = parent.m_UserInfo;
 

 
 var m_pers = [];

 //选项组 
 var m_StaffChangeTypes = [];
 var m_BooleanTypes = [];
 var m_EmployeeTypes = [];
 var m_ProbationDays = [];
 var m_Jobs = [];

 var m_widths = [153, 150, 120, 100, 70]; 


 var m_task = {};
 var m_perinfo = '';

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


     //获取基础数据选项
     getTypeItems(); 
     
     // 设置相关控件 
     setDatebox('#c_recordtime'); 
     setDatebox('#syqEndDate');
     setCombobox('#syqMonth', m_widths[0], m_widths[0], m_widths[2], false, false, 'c_code', 'c_name', m_ProbationDays);
     setCombobox('#c_type', m_widths[0], m_widths[0], m_widths[2], false, false, 'c_code', 'c_name', m_EmployeeTypes);
     setCombobox('#c_changetype', m_widths[0], m_widths[0], m_widths[2], false, false, 'c_code', 'c_name', m_StaffChangeTypes);
     setCombobox('#c_newjobname', m_widths[0], m_widths[0], m_widths[2], false, false, 'c_name', 'c_name', m_Jobs);

      

     //岗位 下拉框设置 
     $('#c_newjobname').combobox({
         onSelect: function (data) { 
             $('#c_newjobid').val(m_UserInfo.selfInfo.c_jobid);
             $('#c_newjobcode').val(m_UserInfo.selfInfo.c_jobcode);
         },
         onShowPanel: function () {
             if (m_Jobs.length == 0) {
                 alert('请先选择调转部门！');
             }
         }
     });
       
     
     // 初始化权限数据控制
     setbillInfoByURL(); 
    
     $('#otherdiv').show();
 }); 
 

/***********************************************************************
  *  初始化权限数据控制
  *  DLY 
  */
 function setbillInfoByURL() {
     var flag = false;
     var type = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '');
     var type1 = dataUtil_undefinedOrNull(basedata_getUrlParam("v1"), '');
     controlTools(1); //先隐藏所以按钮  
     if (type == 'old' && type1 == "list") {   // 新建调转
         //获取hr人员信息
         var peroid = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
         var row = { c_oid: peroid };
         per = hr_getPer(row);
         setInfo('new', per);
         controlTools(2);
         actChangeST('0');
     } else if (type == 'old1' || type == 'old2') {   // 待办或查询 
         var taskid = dataUtil_undefinedOrNull(basedata_getUrlParam("v3"), '');
         var cons1 = ' AND  HR3_ID= \'' + taskid + '\''; 
         var res1 = hr_getTask(cons1);
         if (res1 == '1') {
             alert('未找到对应待办任务信息，请截全屏图发给系统管理员！');
             return flag;
         } else if (res1.hr3_id != undefined && res1.hr3_id != '') {
             m_task = res1;
         } else {
             alert('待办任务信息获取失败，请截全屏图发给系统管理员！');
             return flag;
         }

         var rid = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
         if (rid == '') {
             alert('记录ID无效，请截全屏图发给系统管理员！');
             return;
         }
         var cons = ' AND  HR7_ID= \'' + rid + '\'';
         var res = hr_getPerTurnRecord(cons);
         if (res == '1') {
             alert('未找到对应人员调转信息，请截全屏图发给系统管理员！');
             return flag;
         } else if (res.hr7_id != undefined && res.hr7_id != '') {
             m_perInfo = res; 
         } else {
             alert('人员调转信息获取失败，请截全屏图发给系统管理员！');
             return flag;
         } 

         //设置值
         setInfo('old', m_perInfo);

         //权限控制 
         if (type == 'old1' && m_task.hr3_actor == '申请人') {  //待办，区分申请人和审核人 
             controlTools(3);
         } else if (type == 'old1' && m_task.hr3_actor == '经理') {
             controlTools(4);
         } else if (type == 'old1' && m_task.hr3_actor == '人资') {
             controlTools(4);
         } else {
             controlFields(1);
             actChangeST('');
         } 
     }
 }
 
 

/***********************************************************************
 *  设置日期控件
 *  DLY 
 */
function setDatebox(field) { 
    $(field).datebox({
        width: m_widths[0],
        closeText: '关闭',
        editable: false,
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
 *  设置员工信息
 *  DLY 
 */
function setInfo(type, per) {
    if (type == 'new') {
        $('#dqbmspan').html(per.c_unitname);
        $('#dqgwspan').html(per.c_jobname);
        $('#hr7_name').html(per.c_name);
        $('#hr7_code').html(per.c_code);
        $('#c_recordtime').datebox('setValue', ''); 
        $('#c_type').combobox('setValue', '3');
        $('#c_changetype').combobox('setValue', '');
        $('#c_newjobname').combobox('setValue', '');
        $('#c_newunitname').val('');
        $('#c_newunitid').val('');
        $('#c_newunitcode').val('');
        $('#c_newjobid').val('');
        $('#c_newjobcode').val('');
        $('#hr7_neworgid').val('');
        $('#hr7_neworgcode').val('');
        $('#hr7_neworgname').val('');
        $('#c_remark').val('');

        $('#c_oid_staffrecord').val('');
        $('#c_empoid').val(per.c_oid);
        $('#c_oldunitname').val(per.c_unitname);
        $('#c_oldunitid').val(per.c_unitid);
        $('#c_oldunitcode').val(per.c_unitcode);
        $('#c_oldjobname').val(per.c_jobname);
        $('#c_oldjobid').val(per.c_jobid);
        $('#c_oldjobcode').val(per.c_jobcode);
        $('#c_oldempstatus').val(per.c_employeestatus); 
        $('#c_oldtype').val(per.c_employeetype);

        //试用期   
        $("#isSYQ").attr("checked", false);
        $(':radio[name="syqtype"]').eq(0).attr("checked", true);
        $('#syqEndDate').datebox('setValue', '');
        $('#syqMonth').combobox('setValue', '3');  
        //alert($(':radio[name="syqtype"]:checked').val());
    } else if (type == 'old') {
        $('#dqbmspan').html(per.c_oldunitname);
        $('#dqgwspan').html(per.c_oldjobname);
        $('#hr7_name').html(per.hr7_name);
        $('#hr7_code').html(per.hr7_code);
        $('#c_recordtime').datebox('setValue', per.c_recordtime);
        $('#c_type').combobox('setValue', per.c_type);
        $('#c_changetype').combobox('setValue',per.c_changetype);
        $('#c_newunitname').val(per.c_newunitname);
        $('#c_newjobname').combobox('setValue', per.c_newjobname);
        $('#c_newunitid').val(per.c_newunitid);
        $('#c_newunitcode').val(per.c_newunitcode);
        $('#c_newjobid').val(per.c_newjobid);
        $('#c_newjobcode').val(per.c_newjobcode);
        $('#hr7_neworgid').val(per.hr7_neworgid);
        $('#hr7_neworgcode').val(per.hr7_neworgcode);
        $('#hr7_neworgname').val(per.hr7_neworgname);
        $('#c_remark').val(per.c_remark); 
       
        $('#c_oid_staffrecord').val(per.c_oid_staffrecord);
        $('#c_empoid').val(per.c_empoid);
        $('#c_oldunitname').val(per.c_oldunitname);
        $('#c_oldunitid').val(per.c_oldunitid);
        $('#c_oldunitcode').val(per.c_oldunitcode);
        $('#c_oldjobname').val(per.c_oldjobname);
        $('#c_oldjobid').val(per.c_oldjobid);
        $('#c_oldjobcode').val(per.c_oldjobcode);
        $('#c_oldempstatus').val(per.c_oldempstatus);
        $('#c_oldtype').val(per.c_oldtype);

        //获取岗位信息
        var row1 = { c_unitid: per.c_newunitid };
        m_Jobs = hr_getJobs(row1);
        $('#c_newjobname').combobox('loadData', m_Jobs);

        //试用期  
        $('#syqEndDate').datebox('setValue', per.hr7_syqenddate); 
        $('#syqMonth').combobox('setValue', (per.hr7_syqmonth == ''&& per.hr7_syqenddate=='')  ? '3' : per.hr7_syqmonth);
        var raflag = '0';
        if (per.hr7_syqenddate != '') {
            $(':radio[name="syqtype"]').eq(1).attr("checked", true);
            raflag = '1';
        } else {
            $(':radio[name="syqtype"]').eq(0).attr("checked", true);
        }

        if (per.hr7_syqbegindate != '') {
            $("#isSYQ").attr("checked", true);
        } else { 
            $("#isSYQ").attr("checked", false);
        }
        actChangeST(raflag);
    }
}


/***********************************************************************
*  工具条及按钮控制
*  DLY 
*/
function controlTools(type) {
    if (type == 1) {    //全不可见  
        $('#bcbtn').hide();
        $('#deptbtn').hide();
        $('#tjbtn').hide();
        $('#shbtn').hide();
        $('#bhbtn').hide(); 
        $('#qxbtn').hide(); 
    } else if (type == 2) { //申请人 - 新建
        $('#bcbtn').show();
        $('#deptbtn').show();
        $('#tjbtn').hide();
        $('#shbtn').hide();
        $('#bhbtn').hide(); 
        $('#qxbtn').hide(); 
    } else if (type == 3) { //申请人 - 待办 
        $('#bcbtn').show();
        $('#deptbtn').show();
        $('#tjbtn').show();
        $('#shbtn').hide();
        $('#bhbtn').hide();
        $('#qxbtn').show(); 
    } else if (type == 4) {  //审批人 - 待办 
        $('#bcbtn').show();
        $('#deptbtn').show();
        $('#tjbtn').hide();
        $('#shbtn').show();
        $('#bhbtn').show();
        $('#qxbtn').show(); 
    }
}


/***********************************************************************
*  控件控制
*  DLY 
*/
function controlFields(type) {
    if (type == 1) {    //全只读 
        $('form').find('input, textarea').prop("disabled", "disabled");  
        $(':checkbox').attr("disabled", true);
        $(':radio').attr("disabled", true); 
        // 设置相关控件 
        $('#c_recordtime').datebox('disable');
        $('#syqEndDate').datebox('disable'); 
        $('#syqMonth').combobox('disable');
        $('#c_type').combobox('disable');
        $('#c_changetype').combobox('disable'); 
        $('#c_newjobname').combobox('disable');   
    }  
}


/***********************************************************************
 *  获取基础选项
 *  DLY 
 */
function getTypeItems() {
    var type13 = hr_getCodeType(13);//调转原因  
    var type15 = hr_getCodeType(15);//员工类别 
    var type11 = hr_getCodeType(11);//试用期

    var types = '\'0\',' + '\'' + type13 + '\',' + '\'' + type11 + '\','
              + '\'' + type15 + '\'';
    var row = { c_typecode: types };
    var codeitems = hr_getCodeItems(row);
    for (var i = 0; i < codeitems.length; i++) {
        var t1 = codeitems[i].c_typecode.toUpperCase();
        if (t1 == type13.toUpperCase()) {
            m_StaffChangeTypes.push(codeitems[i]);
        } else if (t1 == type15.toUpperCase()) {
            m_EmployeeTypes.push(codeitems[i]);
        } else if (t1 == type11.toUpperCase()) {
            m_ProbationDays.push(codeitems[i]);
        } 
    }  
}
 

/***********************************************************************
 *  保存
 *  DLY 
 */
function actSave() {
    var resFlag = false;
    //alert(jsonUtil_form2json('#ryxxForm'));
    //保存校验 并获取记录信息 
    var perInfo = saveCheck();
    if (perInfo == '') {
        return resFlag;
    }
    var flag2 = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '');
    //alert(jsonUtil_jsonToStr(perInfo[0]));

    //新建申请
    if (flag2 == 'old') { 
        //生成任务行
        var atype = '人员调转'; 

        //保存主表 
        perInfo[0].hr7_id = dataUtil_NewGuid();
        flag1 = hr_savePerTurn('N', perInfo[0], m_UserInfo.userName);
        if (!flag1) {
            alert('保存人员调转记录失败！')
            return resFlag;
        } 

        var zrow = perInfo[0]; 
        
        var arow = {};
        arow.hr3_id = dataUtil_NewGuid();
        arow.hr3_rid = zrow.hr7_id;
        arow.hr3_type = atype;
        arow.hr3_subject = m_UserInfo.deptName + ' - ' + atype + ' - ' + $('#hr7_name').html();
        arow.hr3_state = '未提交';
        arow.hr3_rguser = m_UserInfo.userName;
        arow.hr3_actor = '申请人';
        arow.hr3_perid = m_UserInfo.deptID;
        //arow.hr3_perid1 = m_UserInfo.empCode1; // 无需大区经理审批 
        if (hr_FlowComFlag(m_UserInfo.selfInfo.c_orgid) == '1') { //雅莹特殊控制
            arow.hr3_perid2 = m_UserInfo.empCode1; // 分公司人资 
            arow.hr3_perid1 = m_UserInfo.empCode2; // 便于总部人资查看
        } else {
            arow.hr3_perid1 = m_UserInfo.empCode1; // 分公司人资 
            arow.hr3_perid2 = m_UserInfo.empCode2; // 总部人资
        }
        arow.hr3_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        arow.hr3_uptno = 0;
        arow.hr3_com = m_UserInfo.selfInfo.c_orgid;
        flag1 = hr_saveTask('N', arow, m_UserInfo.userName);
        if (!flag1) {
            alert('生成待办任务失败！')
            return resFlag;
        }   
        alert('保存成功！');

        // 跳转到任务页
        var curlo = 'perTurn.html?' + 'v0=old1&v1=task&v2=' + zrow.hr7_id
                     + '&v3=' + arow.hr3_id
                     + '&s=' + new Date().getTime();
        parent.turnPage('B', 'tasksPage', curlo);
    } else if (flag2 == 'old1') { 
        var rid = dataUtil_undefinedOrNull(basedata_getUrlParam("v2"), '');
        perInfo[0].hr7_id = rid;
        flag1 = hr_savePerTurn('U', perInfo[0], m_UserInfo.userName);
        if (!flag1) {
            alert('保存人员信息失败！')
            return resFlag;
        }  
        alert('保存成功！');
    } 
    resFlag = true;
    return resFlag;
}


/***********************************************************************
*  保存校验 返回记录信息
*  DLY 
*/
function saveCheck() {
    var res = ''; 
    var perInfo = eval('(' + '[{' + jsonUtil_form2json('#ryxxForm') + '}]' + ')'); //获取单据主信息json  
    perInfo[0].c_remark = $('#c_remark').val();
    perInfo[0].hr7_code = $('#hr7_code').html();
    perInfo[0].hr7_name = $('#hr7_name').html();

    if (perInfo[0].c_recordtime == ''
        || perInfo[0].c_type == ''
        || perInfo[0].c_changetype == ''
        || perInfo[0].c_newunitname == ''
        || perInfo[0].c_newjobname == '') {
        alert( "带 *  的字段都必填!"); 
        return res;
    } 

    //试用期
    var isSYQ = $('#isSYQ').is(':checked');
    if (isSYQ) {
        var ravalue = $(':radio[name="syqtype"]:checked').val();
        if (ravalue == 0) {
            var m = $('#syqMonth').combobox('getValue');
            if (m == '') {
                alert('请选择试用期月数！');
                return res;
            }
            perInfo[0].hr7_syqbegindate = perInfo[0].c_recordtime;
            perInfo[0].hr7_syqenddate = '';
            perInfo[0].hr7_syqmonth = m;
        } else {
            var edate = $('#syqEndDate').datebox('getValue');
            if (edate == '') {
                alert('请选择试用期结束日期！');
                return res;
            }
            perInfo[0].hr7_syqbegindate = perInfo[0].c_recordtime;
            perInfo[0].hr7_syqenddate = edate;
            perInfo[0].hr7_syqmonth = '';
        }
    } else {
        perInfo[0].hr7_syqbegindate = '';
        perInfo[0].hr7_syqenddate = '';
        perInfo[0].hr7_syqmonth = '';
    }
    res = perInfo;
    return res;
}


/***********************************************************************
*  流程  店长——人资
*  DLY 
*/
function actApprove(type) { 
    var flag = false;
    //数据修改校验 
    //$(m_DatagridID).datagrid('endEdit', m_LastIndex);
    //if ($(m_DatagridID).datagrid('getChanges').length > 0) {
    //    alert('数据已修改，请先保存！');
    //    return;
    //}

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
        if (res.hr3_state != m_task.hr3_state) {
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
        res.hr3_comment = res.hr3_comment + '店长：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
        if (hr_FlowComFlag(m_UserInfo.selfInfo.c_orgid) == '3') { //卓莱雅等经过分公司经理环节
            res.hr3_state = '经理待批';
            res.hr3_actor = '经理';
        } else { //其他公司不经过分公司经理环节
            res.hr3_state = '人资待批';
            res.hr3_actor = '人资';
        }
    } else if (type == 'sh') {
        actinfo = '审核';
        if (res.hr3_actor == '经理') {
            res.hr3_comment = res.hr3_comment + '经理：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
            res.hr3_state = '人资待批';
            res.hr3_actor = '人资';
        } else if (res.hr3_actor == '人资') {
            res.hr3_comment = res.hr3_comment + '人资：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
            res.hr3_state = '已完结';
            res.hr3_actor = '';
        }
    } else if (type == 'bh') {
        actinfo = '驳回';
        if (res.hr3_actor == '经理') {
            res.hr3_comment = res.hr3_comment + '经理：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
            res.hr3_state = '经理(驳回)';
            res.hr3_actor = '申请人';
        } else if (res.hr3_actor == '人资') {
            res.hr3_comment = res.hr3_comment + '人资：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
            res.hr3_state = '人资(驳回)';
            res.hr3_actor = '申请人';
        }
    } else if (type == 'qx') {
        actinfo = '取消';
        res.hr3_comment = res.hr3_comment + res.hr3_actor + '：' + m_UserInfo.userName + ' ' + actinfo + ' ' + actT + 'rrbrrr';
        res.hr3_state = '已取消';
        res.hr3_actor = '';
    }

    //alert(jsonUtil_jsonToStr(res));
    $.messager.confirm('确认框', '确认' + actinfo + '该人员信息吗？', function (r) {
        if (r) {
            //同步到EHR
            if (res.hr3_state == '已完结') {
                var row = { type: "emp", taskid: res.hr3_id, actorid: m_UserInfo.empID };
                var ressjtb = hr_ActDataSync(row);
                if (ressjtb == undefined || ressjtb == "") {
                    alert('EHR数据同步失败！');
                    return flag;
                } else if (ressjtb.flag == '0') {
                    alert('EHR数据同步错误： ' + ressjtb.message);
                    return flag;
                }
            }
            //修改任务信息  
            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
            if (!flag1) {
                alert(actinfo + '失败，请截全屏图发给系统管理员！')
                return flag;
            } 
            alert(actinfo + '成功！');
            parent.turnPage('A', 'tasks');
        }
    });
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
        parent.turnPage('A', 'persons', '');
    } 
}


/***********************************************************************
*  试用期方式控制
*  DLY 
*/
function actChangeST(type) { 
    if (type == '0') { 
        $('#syqEndDate').datebox('disable');
        $('#syqMonth').combobox('enable');
    } else if (type == '1') {
        $('#syqEndDate').datebox('enable');
        $('#syqMonth').combobox('disable');
    } else { 
        $('#syqEndDate').datebox('disable');
        $('#syqMonth').combobox('disable');
    }
     
}


/***********************************************************************
 *  打开部门选择窗体
 *  DLY 
 */
function openDeptdlg() {
    $(m_dlgID).dialog('open');
    if (m_dlgOFlag == 0) {  
        $(m_DatagridID).datagrid({
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
                { field: 'c_orgcode', title: '公司编码', width: 70},
                { field: 'c_orgname', title: '公司名称', width: 180},
                { field: 'c_unitid', title: '部门ID', width: 70, hidden: true },
                { field: 'c_unitcode', title: '部门编码', width: 70 },
                { field: 'c_unitname', title: '部门名称', width: 260} 
            ]],
            pagination: false,
            rownumbers: true,
            singleSelect: true,
            onClickRow: function (rowIndex) { 
            },
            onDblClickRow: function () {
                //setDeptxx();
            }

        });

        m_dlgOFlag = 1;
    } 
    $(m_DatagridID).datagrid('clearSelections');
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
        if ($('#cxDept').val() == '') {
            alert('请填写部门名称查询条件！');
            return false;
        } 
        var cons = ' AND A.C_NAME like \'%' + cxDept + '%\'';
        var row = { cons: cons, type: '1', rows: m_PageSize }; 
        var depts = hr_getUnitInfo(row);
        $(m_DatagridID).datagrid('loadData', depts);
        $(m_DatagridID).datagrid('clearSelections');
    } if (type == 'Clear') { 
        $('#cxDept').val('');
    } 
}
 

/***********************************************************************
 *  填充选中部门到页面
 *  DLY 
 */
function setDeptxx() { 
    var row = $(m_DatagridID).datagrid('getSelected');  
    if (row) {
        $('#c_newunitname').val(row.c_unitname);
        $('#c_newunitid').val(row.c_unitid);
        $('#c_newunitcode').val(row.c_unitcode);
        $('#hr7_neworgid').val(row.c_orgid);
        $('#hr7_neworgcode').val(row.c_orgcode);
        $('#hr7_neworgname').val(row.c_orgname);
        $('#c_newjobname').combobox('setValue', '');
        $('#c_newjobid').val('');
        $('#c_newjobcode').val('');
        $(m_dlgID).dialog('close');
        //获取岗位信息
        var row1 = { c_unitid: row.c_unitid };
        m_Jobs = hr_getJobs(row1);  
        $('#c_newjobname').combobox('loadData', m_Jobs);
    } else {
        alert('请选择调转后部门记录！');
        return false;
    }


}