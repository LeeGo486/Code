/* 全局变量*/
var m_DatagridID = '#tsxzmxlb'; //特殊薪资明细列表
var m_LastIndex = -1;         //最后一次选中行下标
var m_PageNumber = 1;  //当前页码
var m_PageSize =1000;  //每页显示行数

//获取用户名
var m_UserInfo = parent.m_UserInfo;
var m_taskTypes = hr_getBaseItems(3);
var m_states = hr_getBaseItems(2);
var m_actors = hr_getBaseItems(1);

var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式

var m_MID = '';     //主表ID
var m_ShopID = '';  //店铺ID
var m_ShopName = '';//店铺名字
var m_ATState = ''; //当前状态
var m_ATMonth = '';   //考勤月份
var m_ApproveID = '';   //待办ID

var m_Footer = [{ hr14_empname: "<font color='red' size='2'>合计</font>", hr14_money: 0.00 }];    //表格footer


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
     

    var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v0"), '');
    var type1 = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v1"), '');
    m_MID = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v2"), '');

    //设置页面顶部标签   
    page_pTopDisplay(type, type1, dataUtil_getUrlParam("l1")
        , dataUtil_getUrlParam("l2"), dataUtil_getUrlParam("l3"));

    //初始化列表
    if (type == 'new') {  // 新建
        m_ShopID = m_UserInfo.deptID;
        m_ShopName = m_UserInfo.deptName;
        //获取当前月份
        m_ATMonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
        m_ApproveID = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v3"), '');
        m_ATState = m_states[0].value;
        $('#shopname').html(m_ShopName);
        $('#month').html(m_ATMonth);
        $('#state').html(m_ATState);
        controlTools(2);  // 无提交按钮，保存后生成待办
        setDataGrid(1);
    }
    else {
        //根据主表ID获取当前特殊薪资主信息
        var cons = ' AND  HR13_ID= \'' + m_MID + '\'';
        var res = hr_getSpecialPay(cons, 1, 1, '');
        if (res == '') {
            alert('主表信息获取失败!');
            return;
        }
        var zrow = res.rows[0];
        m_ATState = zrow.hr13_state;    //当前状态
        m_ATMonth = zrow.hr13_atmonth;  //月份
        m_ShopID = zrow.hr13_shopid;    //店铺ID
        m_ShopName = zrow.hr13_shopname;//店铺名称
        $('#shopname').html(m_ShopName);
        $('#month').html(m_ATMonth);
        $('#state').html(m_ATState);
        if (type == 'submit') {//待办——申请人
            controlTools(3);  // 有提交按钮
            setDataGrid(1);
        }
        if (type == 'old') {//查看——申请人/状态已完结
            controlTools(1);  // 查询，仅供汇总
            setDataGrid(0);
        }
        else if (type == 'approve') {//待办——审核人
            controlTools(4);  // 待办
            setDataGrid(0);
        }
        actLoadData(m_PageNumber, m_PageSize);
    }
});


/***********************************************************************
*  加载数据
*  SY 
*/
function actLoadData(page, number) {
    $(m_DatagridID).datagrid('loadData', []);

    var cons = ' AND ( HR14_MID = \'' + m_MID + '\')';
    var res = hr_getSpecialPayRecord(cons, page, number, 'HR14_EmpCode');

    //alert(jsonUtil_jsonToStr(res));
    if (res == '') {
        alert('查询失败！');
    } else if (res.total > 0) {
        m_Footer[0].hr14_money = getHZMoney(res.rows);
        $(m_DatagridID).datagrid('loadData', res.rows);
    }
    $(m_DatagridID).datagrid("clearSelections");
}


/***********************************************************************
 *  新增数据行，设置默认值
 *  DLY 
 */
function actAdd() {
    //结束最后一次编辑
    if (m_LastIndex != -1) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }
    var rowIndex = $(m_DatagridID).datagrid('getRows').length;


    //新增一行,并且设置默认值
    var rownew = {};
    rownew.hr14_id = dataUtil_NewGuid();
    rownew.hr14_mid = m_MID;
    //rownew.hr14_money = 0.00;
    rownew.hr14_rgdt = dateUtil_dateFomaterA(new Date(), '-');
    rownew.hr14_rguser = m_UserInfo.userName;
    //新增时，修改次数默认为空
    rownew.hr14_uptno = 0;

    $(m_DatagridID).datagrid('appendRow', rownew);
    $(m_DatagridID).datagrid('selectRow', rowIndex);
    $(m_DatagridID).datagrid('beginEdit', rowIndex);
    m_LastIndex = rowIndex;
}


/***********************************************************************
 *  删除事件
 *  DLY 
 */
function actDelete() {
    //结束最后一次编辑项
    if (m_LastIndex != -1) {
        $.messager.confirm('确认框', '确认删除选中记录吗？', function (r) {
            if (r) {
                $(m_DatagridID).datagrid('endEdit', m_LastIndex);
                //var row1 = $(m_DatagridID).datagrid('getSelected');

                //$(m_DatagridID).datagrid('cancelEdit', m_LastIndex);
                $(m_DatagridID).datagrid('deleteRow', m_LastIndex);

                $(m_DatagridID).datagrid("clearSelections");
                m_LastIndex = -1;
            }
        });
    }
    else {
        $.messager.alert('提示', '请选择要删除的记录！', 'warning');
    }

}


/***********************************************************************
*  保存
*  SY 
*/
function actSave() {
    if (m_LastIndex != -1) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
    }
    //获取明细 
    var dataRows = $(m_DatagridID).datagrid('getRows');

    if (dataRows.length <= 0) {
        alert('不存在需要保存的信息！');
        return;
    }
    //校验
    if (m_UserInfo.empCode1 == undefined) {
        alert('未获取到店铺对于大区经理配置，请截图联系系统管理员！');
        return;
    }
    if (m_UserInfo.empCode2 == undefined) {
        alert('未获取到公司对于人资负责人配置，请截图联系系统管理员！');
        return;
    }

    var allmoney = 0.00;
    for (var i = 0; i < dataRows.length; i++) {
        var j = i * 1 + 1;
        if (dataRows[i].hr14_empcode == '') {
            alert('第' + j + '行职员代码不能为空！');
            return;
        }
        if (dataRows[i].hr14_empname == '') {
            alert('第' + j + '行职员姓名不能为空！');
            return;
        }
        if (dataRows[i].hr14_money*1<=0) {
            alert('第' + j + '行金额填写不当！');
            return;
        }
        if (dataRows[i].hr14_remark == '') {
            alert('第' + j + '行备注不能为空！');
            return;
        }
        allmoney += dataRows[i].hr14_money*1;
    }

    var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v0"), '');
    var zrow = {}; //主信息
    var cXMLd = '';
    //新建申请
    if (type == 'new') {
        var inserted = [];
        zrow.hr13_id = m_MID
        zrow.hr13_shopid = m_ShopID;
        zrow.hr13_shopname = m_ShopName;
        zrow.hr13_atmonth = m_ATMonth;
        zrow.hr13_money = allmoney;
        zrow.hr13_state = '未提交';
        zrow.hr13_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.hr13_rguser = m_UserInfo.userName;
        zrow.hr13_uptno = 0;

        inserted.push(zrow);
        cXMLd = GetEditJson(inserted, [], []);//json转xml
        //保存主表
        var flag = hr_saveSpecialPay(cXMLd, m_UserInfo.userName);
        if (!flag) {
            alert('保存特殊薪资主信息失败！')
            return;
        }

        //生成任务行
        var arow = {};
        arow.hr3_id = m_ApproveID;
        arow.hr3_rid = m_MID;
        arow.hr3_type = m_taskTypes[6].value;
        arow.hr3_subject = m_UserInfo.deptName + '(' + $('#month').html() + ') - ' + m_taskTypes[6].value;
        arow.hr3_state = m_states[0].value;
        arow.hr3_rguser = m_UserInfo.userName;
        arow.hr3_actor = m_actors[0].value;
        arow.hr3_perid = m_UserInfo.deptID;
        arow.hr3_perid1 = m_UserInfo.empCode1;
        arow.hr3_perid2 = m_UserInfo.empCode2;
        arow.hr3_rgdt = dateUtil_dateFomaterA(new Date(), '-');
        arow.hr3_uptno = 0;
        arow.hr3_com = m_UserInfo.selfInfo.c_orgid;

        flag = hr_saveTask('N', arow, m_UserInfo.userName);
        if (!flag) {
            alert('生成待办任务失败！')
            return;
        }

        cXMLd = GetGetJson(dataRows, 'INSERT');//数组转xml
        //保存明细
        flag = hr_saveSpecialPayRecord(cXMLd, m_UserInfo.userName);
        if (!flag) {
            alert('保存特殊薪资明细信息失败！')
            return flag;
        }

        alert('保存成功！');
        type = 'submit';

        //跳转到提交页面——待办
        var curlo = 'specialPayRecord.html?' + 'v0=' + type + '&v1=task' + '&v2=' + m_MID + '&v3=' + m_ApproveID
                     + '&v3=task&s=' + dateUtil_dateFomaterA(new Date(), '-');
        parent.menus_turnPage('B', 'tasksPage', curlo);
    } else if (type == 'submit') {
        if ($(m_DatagridID).datagrid('getChanges').length <= 0) {
            alert("没有修改信息！")
            return;
        }

        var inserted = $(m_DatagridID).datagrid('getChanges', "inserted");
        var updated = $(m_DatagridID).datagrid('getChanges', "updated");
        var deleted = $(m_DatagridID).datagrid('getChanges', "deleted");

        //保存主表
        var cons = ' AND  HR13_ID= \'' + m_MID + '\'';
        var res = hr_getSpecialPay(cons, 1, 1, '');
        if (res == '') {
            alert('主表信息获取失败!');
            return;
        }
        zrow = res.rows[0];
        zrow.hr13_money = allmoney;
        zrow.hr13_lmdt = dateUtil_dateFomaterA(new Date(), '-');
        zrow.hr13_lmuser = m_UserInfo.userName;
        zrow.hr13_uptno++;

        var zrows = [];
        zrows.push(zrow);
        cXMLd = GetEditJson([], zrows, []);//json转xml
        //保存主表
        var flag = hr_saveSpecialPay(cXMLd, m_UserInfo.userName);
        if (!flag) {
            alert('保存特殊薪资主信息失败！')
            return;
        }

        for (var i = 0; i < updated.length; i++) {
            updated[i].hr14_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            updated[i].hr14_lmuser = m_UserInfo.userName;
            updated[i].hr14_uptno = 1 + updated[i].hr14_uptno*1;
        }

        //保存明细
        cXMLd = GetEditJson(inserted, updated, deleted);//json转xml
        //保存明细
        flag = hr_saveSpecialPayRecord(cXMLd, m_UserInfo.userName);
        if (!flag) {
            alert('保存特殊薪资明细信息失败！')
            return;
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

    //流程控制 
    var taskid = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v3"), '');
    var result = hr_flowControl('Flow01', type, taskid, m_UserInfo.userName, m_ATState);
    if (!result.flag) {
        return flag;
    }
    var res = result.res;

    $.messager.confirm('确认框', '确认' + result.actinfo + '该特殊薪资申请吗？', function (r) {
        if (r) {
            //修改任务信息  
            var flag1 = hr_saveTask('U', res, m_UserInfo.userName);
            if (!flag1) {
                alert(result.actinfo + '失败，请截全屏图发给系统管理员！(' + taskid + ')');
                return flag;
            }
            //修改主表状态 
            var zrow = {};
            var cons = ' AND  HR13_ID= \'' + m_MID + '\'';
            var zrows = hr_getSpecialPay(cons, 1, 1, '');
            if (zrows == '') {
                alert('特殊薪资主表信息无法获取，请截全屏图发给系统管理员！(' + m_MID + ')');
                return;
            }
            zrow = zrows.rows[0];
            zrow.hr13_state = res.hr3_state;
            zrow.hr13_lmdt = dateUtil_dateFomaterA(new Date(), '-');
            zrow.hr13_lmuser = m_UserInfo.userName;
            zrow.hr13_uptno = zrow.hr13_uptno*1+1;
            zrows = [];
            zrows.push(zrow);
            var cXMLd = GetEditJson([], zrows, []);//json转xml
            //保存主表
            flag = hr_saveSpecialPay(cXMLd, m_UserInfo.userName);
            if (!flag1) {
                alert('回写特殊薪资主信息失败，请截全屏图发给系统管理员！(' + m_MID + ')')
                return flag;
            }
            alert(result.actinfo + '成功！');
            parent.menus_turnPage('A', 'tasks', '');
        }
    });
}


/***********************************************************************
*  获得总金额
*  SY 
*/
function getHZMoney(rows) {
    var result = 0.00;
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].hr14_money) {
            result += rows[i].hr14_money * 1;
        }
    }
    result = result.toFixed(2);
    return result;
}


/***********************************************************************
*  设置汇总
*  SY
*/
function setHZInfo() {
    //结束最后一次编辑，并且清除选择项
    if (m_LastIndex != -1) {
        $(m_DatagridID).datagrid('endEdit', m_LastIndex);
        $(m_DatagridID).datagrid("clearSelections");
        m_LastIndex = -1;
    }

    var rows = $(m_DatagridID).datagrid('getRows');
    if (rows.length <= 0) {
        alert('不存在相关汇总信息！');
        return;
    }

    $('#hzInfodlg').dialog('open');

    var info = [];
    var perinfo = { empcode: '', empname: '', money: 0.00 };
    perinfo.empcode = rows[0].hr14_empcode;
    perinfo.empname = rows[0].hr14_empname;
    perinfo.money = rows[0].hr14_money;
    info.push(perinfo);
    //总金额
    var allmoney = rows[0].hr14_money*1;

    //信息汇总
    for (var i = 1; i < rows.length; i++) {
        var flag = false;   //判断是否需要添加新的工号记录
        var perinfo = { empcode: '', empname: '', money: 0.00 };
        allmoney += rows[i].hr14_money * 1;
        for (var j = 0; j < info.length; j++) {
            if (info[j].empcode == rows[i].hr14_empcode) {
                info[j].money = (info[j].money * 1 + rows[i].hr14_money * 1).toFixed(2);
                flag = false;
                break;
            } else {
                flag = true;
            }
        }
        if (flag) {
            perinfo.empcode = rows[i].hr14_empcode;
            perinfo.empname = rows[i].hr14_empname;
            perinfo.money = rows[i].hr14_money * 1;
            info.push(perinfo);
        }
    }

    //汇总显示
    var hzinfo = '<table style="width:320px; margin-left:40px;margin-top:10px;">';
    hzinfo = hzinfo + '<tr><td align="center" width="100px">工 号</td><td align="center" width="100px">姓 名</td>'
                    + '<td align="center" width="120px">金 额</td></tr>';
    for (var j = 0; j < info.length; j++) {
        hzinfo = hzinfo + '<tr>';
        hzinfo = hzinfo + '<td align="center">' + info[j].empcode + '</td>';
        hzinfo = hzinfo + '<td align="center">' + info[j].empname + '</td>';
        hzinfo = hzinfo + '<td align="center">' + info[j].money + '</td></tr>';
    }
    hzinfo = hzinfo + '<tr>';
    hzinfo = hzinfo + '<td></td>';
    hzinfo = hzinfo + '<td align="center"><font color="red">合 计</font></td>';
    hzinfo = hzinfo + '<td align="center"><font color="red">' + allmoney.toFixed(2)+ '</font></td></tr>';
    hzinfo = hzinfo + '</table>';
    $('#hzInfoSpan').html(hzinfo);
}


/***********************************************************************
*  关闭
*  DLY 
*/
function actClose() {
    //返回上一次界面
    parent.menus_back('back', '', '');
    ////特殊流程跳转
    //var type = dataUtil_undefinedOrNull(dataUtil_getUrlParam("v1"), ''); 
    //var label2 = $('#pTopLabel2').text();
    //parent.menus_back(type, label2, 'specialPay');
}


/***********************************************************************
*  工具条及按钮控制
*  SY 
*/
function controlTools(type) {
    if (type == 1) {    //全不可见 - （除汇总查询）
        $('#tool').show();
        $('#btnadd').hide();
        $('#btndelete').hide();
        $('#btnsave').hide();
        $('#btntj').hide();
        $('#btnsh').hide();
        $('#btnbh').hide();
        $('#btnall').show();
    } else if (type == 2) { //申请人 - 新建
        $('#tool').show();
        $('#btnadd').show();
        $('#btndelete').show();
        $('#btnsave').show();
        $('#btntj').hide();
        $('#btnsh').hide();
        $('#btnbh').hide();
        $('#btnall').show();
    } else if (type == 3) { //申请人 - 待办
        $('#tool').show();
        $('#btnadd').show();
        $('#btndelete').show();
        $('#btnsave').show();
        $('#btntj').show();
        $('#btnsh').hide();
        $('#btnbh').hide();
        $('#btnall').show();
    } else if (type == 4) { //审核人- 待办
        $('#tool').show();
        $('#btnadd').hide();
        $('#btndelete').hide();
        $('#btnsave').hide();
        $('#btntj').hide();
        $('#btnsh').show();
        $('#btnbh').show();
        $('#btnall').show();
    }
}

/***********************************************************************
*  设置列表
* SY
*/
function setDataGrid(type) {
    $.extend($.fn.datagrid.defaults.editors, {
        combogrid: {
            init: function (container, options) {
                var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
                input.combogrid(options);
                return input;
            },
            destroy: function (target) {
                $(target).combogrid('destroy');
            },
            getValue: function (target) {
                return $(target).combogrid('getValue');
            },
            setValue: function (target, value) {
                $(target).combogrid('setValue', value);
            },
            resize: function (target, width) {
                $(target).combogrid('resize', width);
            }
        }
    });

    if (type == 1) {
        //查找人员信息的条件
        var row = [{ type: '2', c_employeestatus: '', c_orgunitid: m_UserInfo.deptID }];
        //信息列表
        $(m_DatagridID).datagrid({
            //title:'特殊薪资记录列表',
            //iconCls:'icon-save',
            width: $(document.body).width(),
            height: 400,
            nowrap: true,
            striped: true,
            collapsible: true,
            //url:'mroomlist.action',
            sortName: 'hr14_empcode',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'hr14_id',
            showFooter: true,
            frozenColumns: [[
                { field: 'hr14_id', title: 'ID', width: 80, hidden: true },
                { field: 'hr14_mid', title: 'MID', width: 80, hidden: true },
                { field: 'hr14_empid', title: '员工号', width: 80, hidden: true ,editor: 'text' },
                {
                    field: 'hr14_empcode', title: '工号', width: 100, align: 'center', editor: {
                        type: 'combogrid', options: {
                            panelWidth: 200,
                            idField: 'c_code',
                            textField: 'c_code',
                            url: GetWSRRURL('261f8014-1912-4768-87ec-994eb365cf01') + "&XML=" + encodeURIComponent(GetEditJsonbyType(row, 'GetEHRShopPersonInfo')),
                            columns: [[
                                { field: 'c_oid', title: '员工号',align: 'center', width: 80, hidden: true },
                                { field: 'c_code', title: '工号', align: 'center',width: 85 },
                                { field: 'c_name', title: '姓名',align: 'center', width: 85 }
                            ]],

                            onSelect: function (rowindex, rowData) {
                                //填充员工号
                                var ed = $(m_DatagridID).datagrid('getEditors', m_LastIndex)
                                ed[0].target.val(rowData.c_oid);
                                //填充员工姓名
                                ed[2].target.val(rowData.c_name);
                            }
                        }
                    }
                },
                { field: 'hr14_empname', title: '姓名', width: 100, align: 'center', editor: 'text' }
            ]],
            columns: [[
                {
                    field: 'hr14_money', title: '金额', width: 100, align: 'center', editor: {
                        type: 'numberbox', options: { precision: 2 }
                    }
                },
                { field: 'hr14_remark', title: '备注', width: 500, align: 'center', editor: 'text' },
                { field: 'hr14_rgdt', title: '创建时间', width: 80, hidden: true },
                { field: 'hr14_rguser', title: '创建人', width: 80, hidden: true },
                { field: 'hr14_lmdt', title: '修改时间', width: 80, hidden: true },
                { field: 'hr14_lmuser', title: '修改人', width: 80, hidden: true },
                { field: 'hr14_uptno', title: '修改次数', width: 80, hidden: true }
            ]],
            rownumbers: true,
            singleSelect: true,
            //onRowContextMenu:onRowContextMenu,
            onDblClickRow: function (rowIndex) {
            },
            onClickRow: function (rowIndex) {
                if (m_LastIndex != -1) {
                    $(m_DatagridID).datagrid('endEdit', m_LastIndex);
                    var rows = $(m_DatagridID).datagrid('getRows');
                    m_Footer[0].hr14_money = getHZMoney(rows)
                    $(m_DatagridID).datagrid('reloadFooter', m_Footer);
                }
                $(m_DatagridID).datagrid('selectRow', rowIndex);
                $(m_DatagridID).datagrid('beginEdit', rowIndex);
                m_LastIndex = rowIndex;
            },
            onDblClickCell: function (index, field, value) {
            },
            onClickCell: function (index, field) {
            },
            onLoadSuccess: function (data) {
                $(m_DatagridID).datagrid('reloadFooter', m_Footer);
            }
        });
    }
    else {
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
            sortName: 'hr14_empcode',
            sortOrder: 'asc',
            remoteSort: false,
            idField: 'hr14_id',
            showFooter: true,
            frozenColumns: [[
                 { field: 'hr14_id', title: 'ID', width: 80, hidden: true },
                 { field: 'hr14_mid', title: 'MID', width: 80, hidden: true },
                 { field: 'hr14_empid', title: '员工号', width: 80, hidden: true },
                 { field: 'hr14_empcode', title: '工号', width: 100, align: 'center' },
                 { field: 'hr14_empname', title: '姓名', width: 100, align: 'center' },
            ]],
            columns: [[
                { field: 'hr14_money', title: '金额', width: 100, align: 'center' },
                { field: 'hr14_remark', title: '备注', width: 500, align: 'center' },
                { field: 'hr14_rgdt', title: '创建时间', width: 80, hidden: true },
                { field: 'hr14_rguser', title: '创建人', width: 80, hidden: true },
                { field: 'hr14_lmdt', title: '修改时间', width: 80, hidden: true },
                { field: 'hr14_lmuser', title: '修改人', width: 80, hidden: true },
                { field: 'hr14_uptno', title: '修改次数', width: 80, hidden: true },
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
}