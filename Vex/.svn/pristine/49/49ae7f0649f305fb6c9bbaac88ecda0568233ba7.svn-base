
/***********************************************************************
  * 
  *  导航菜单项控制
  *  返回值：  
  */
function menus_control(actor) {
    if (actor == '') {
        actor = 'J';
    }
    var cons = ' AND hr15_Actor' + actor + ' = \'0\' ';
    var items = hr_getPowerConfig(cons, '1', '1000', ' hr15_itemid ');
    for (var i = 0; i < items.length; i++) {
        $('#' + items[i].hr15_itemid).hide();
    }
}


/***********************************************************************
  * 
  *  菜单单击事件
  *  参数： type
  *  返回值：  
  */
function menus_itemOnClick(itemID, value) {
    if (value == undefined || value == null) {
        value = '';
    }
    var taskTypes = hr_getBaseItems(3); // 获取任务类型
    //alert(itemID);
    if (itemID == 'item03_r01') { //入司
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有店铺人员维护的权限！');
            return false;
        }
        var v0 = 'new';
        var v1 = 'list'
        var curl = 'perInfo.html?' + 'v0=' + v0 + '&v1=' + v1
                 + '&s=' + new Date().getTime();
        curl = curl + '&l1=店铺管理&l2=人员&l3=' + taskTypes[1].value;
        menus_turnPage('B', 'persons', curl); //页面跳转 
    } else if (itemID == 'item03_r02'
        || itemID == 'item03_r04' || itemID == 'item03_r05') {
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有店铺人员维护的权限！');
            return false;
        }
        var lable3 = '';
        if (itemID == 'item03_r02') { //更新
            lable3 = taskTypes[2].value;
        } else if (itemID == 'item03_r04') { //调转
            lable3 = taskTypes[3].value;
        } else if (itemID == 'item03_r05') { //离职
            lable3 = taskTypes[4].value;
        }
        //type 用来控制子页面按钮  l3 用来控制子页面顶部lable
        var curl = 'persons.html?' + 'type=' + value + '&l3=' + lable3 + '&v1=' + v1
                 + '&v2=' + dataUtil_NewGuid() + '&s=' + new Date().getTime();
        menus_turnPage('B', 'persons', curl); //页面跳转 
    }
    else if (itemID == 'item03_r11') {  //加班申请 
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有新建加班申请的权限！');
            return false;
        }
        // 校验（每月一单）
        var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);//新建月份    
        var cons = ' AND HR1_OTMonth= \'' + curmonth + '\''
                 + ' AND hr1_shopcode = \'' + m_UserInfo.deptCode + '\' ';
        var res = hr_getOTApply(cons);
        if (res == '1') {
            // 跳转到明细页 
            var v0 = 'N';
            var v1 = 'list';
            var curl = 'overtimesRecode.html?' + 'v0=' + v0 + '&v1=' + v1
                     + '&v2=' + dataUtil_NewGuid() + '&s=' + new Date().getTime();
            menus_turnPage('B', 'overtimesRecode', curl); //页面跳转
        } else if (res.hr1_id != undefined && res.hr1_id != '') {
            alert('已存在' + curmonth + '月申请，不可新建申请！');
            return false;
        } else {
            alert('每月一单,校验失败，请截全屏图发给系统管理员！');
            return false;
        }
    } else if (itemID == 'item03_r21') {  //考勤申请
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有新建考勤申请的权限！');
            return false;
        }
        //判断当前月份是否已经新增申请
        //若是，则跳转界面新建申请；否则，提示不能再次新增考勤记录
        //校验（考勤每月申请一次） 
        //新建时获取当前月份
        var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
        var cons = ' AND HR11_ATMonth= \'' + curmonth + '\''
                 + ' AND hr11_shopid = \'' + m_UserInfo.deptID + '\' ';
        var res = hr_getAttendanceInfo(cons, 1, 10, 'HR11_ATMonth DESC');
        if (res == '') {
            // 跳转到明细页 
            var v0 = "new";
            var v2 = dataUtil_NewGuid();    //主表ID
            var v3 = dataUtil_NewGuid();    //待办ID
            var curl = 'checkAttendanceAdd.html?' + 'v0=' + v0 + '&v1=list'
                     + '&v2=' + v2 + '&v3=' + v3 + '&s=' + dateUtil_dateFomaterA(new Date(), '-');
            menus_turnPage('B', 'checkAttendance', curl);  //页面跳转
        } else if (res.hr11_id != undefined && res.hr11_id != '') {
            alert('已存在' + curmonth + '月申请，不可新建申请！');
            return;
        } else {
            alert('每月一单,校验失败，请截全屏图发给系统管理员！');
            return;
        }
    } else if (itemID == 'item03_r41') {  //特殊薪资申请
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有新建特殊薪资申请的权限！');
            return false;
        }
        //判断当前月份是否已经新增申请
        //若是，则跳转界面新建申请；否则，提示不能再次新增特殊考勤记录
        //校验（特殊考勤每月申请一次） 
        var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
        var cons = ' AND HR13_ATMonth= \'' + curmonth + '\''
                 + ' AND hr13_shopid = \'' + m_UserInfo.deptID + '\' ';
        var res = hr_getSpecialPay(cons, 1, 10, 'HR13_ATMonth DESC');
        if (res == '') {
            // 跳转到明细页 
            var v0 = "new";
            var v2 = dataUtil_NewGuid();    //主表ID
            var v3 = dataUtil_NewGuid();    //待办ID
            var curl = 'specialPayRecord.html?' + 'v0=' + v0 + '&v1=list'
                     + '&v2=' + v2 + '&v3=' + v3 + '&s=' + dateUtil_dateFomaterA(new Date(), '-');
            menus_turnPage('B', 'specialPayRecord', curl);//页面跳转
        } else if (res.hr11_id != undefined && res.hr11_id != '') {
            alert('已存在' + curmonth + '月申请，不可新建申请！');
            return;
        } else {
            alert('每月一单,校验失败，请截全屏图发给系统管理员！');
            return;
        }
    } else if (itemID == 'item03_r51') {  //销售目标制定
        if (m_UserInfo.actor != 'A') {
            alert('对不起,您没有销售目标制定的权限！');
            return false;
        }
        //判断当前月份是否已经新增申请
        //若是，则跳转界面新建申请；否则，提示不能再次新增
        //校验（销售目标制定每月申请一次） 
        var curmonth = dateUtil_getMonthByDay('', '-', '5').substring(0, 7);
        var cons = ' AND HR3_Subject LIKE \'%' + curmonth + '%\''
                 + ' AND HR3_PerID = \'' + m_UserInfo.deptID + '\' '
                 + ' AND HR3_Type = \'' + taskTypes[7].value + '\' ';
        var res = hr_getTask(cons);
        if (res == '1') {
            // 跳转到明细页 
            var v0 = "new";
            var v2 = dataUtil_NewGuid();    //主表ID
            var v3 = dataUtil_NewGuid();    //待办ID
            var curl = 'salesTargetMake.html?' + 'v0=' + v0 + '&v1=list'
                     + '&v2=' + v2 + '&v3=' + v3 + '&s=' + dateUtil_dateFomaterA(new Date(), '-');
            menus_turnPage('B', 'salesTargetMake', curl);//页面跳转
        } else if (res.hr3_id != undefined && res.hr3_id != '') {
            alert('已存在' + curmonth + '月销售预算制定，不可新建申请！');
            return;
        } else {
            alert('每月一单,校验失败，请截全屏图发给系统管理员！');
            return;
        }
    } else if (itemID == 'item03_r32') {  //分单查询
        if (m_UserInfo.actor != 'A') {
            var curl = 'retailShareListQuery.html?'
            menus_turnPage('B', 'retailShareListQuery', curl);  //页面跳转
        } else {
            var curl = 'retailShareListShopQuery.html?'
            menus_turnPage('B', 'retailShareListShopQuery', curl);  //页面跳转
        }
    } else if (itemID == 'item06_r02') {  //操作文档
        window.open("../../../Export/GridExcel/店长.docx");       //******仅用于测试操作文档*******
    }
}


/*********************************************************************** 
 *  切换页面 
 *  参数： type
 */
function menus_turnPage(type, page, curl) {
    var url = 'error.html';
    if (type == 'A') {
        if (page != undefined && page != null && page != '') {
            url = page + '.html' + '?s=' + new Date().getTime();
        }
    } else if (type == 'B') {
        if (curl != undefined && curl != null && curl != '') {
            url = curl;
        }
    } else if (type == 'C') { //贝爱薪资重新用户认证(排除pos关联打开)
        url = hr_getServUrl(3);
    }
    //alert(url);
    if (type == 'C' && url != '') {                 //新建选项卡 
        window.open(url);
    } else {                           //替换内容页面
        document.getElementById('openhere').src = url;
    }
}


/***********************************************************************
  * 
  *  菜单单击事件
  *  参数： type 控制是任务还是查询
  *         type1 控制是待办还是全部
  *         page 控制具体查询页面
  *  返回值：  
  */
function menus_back(type, type1, page) {
    if (type == 'back') { // 返回上一次记录的链接
        var filter = actsonfilter('get');
        if (filter.url_local != undefined && filter.url_local != null && filter.url_local != '')
            menus_turnPage('B', '', filter.url_local);
    } else if (type == 'task') {
        if (type1 == '待办') {
            menus_turnPage('A', 'tasks', '');
        } else if (type1 == '全部') {
            menus_turnPage('A', 'tasksQuery', '');
        }
    } else if (type == 'list') {
        menus_turnPage('A', page, '');
    }
}

