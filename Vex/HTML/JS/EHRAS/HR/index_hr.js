/* 全局变量*/
var m_a3bgcolor = 'rgba(255,255,255,0)'; //页面链接a3初始背景rgba(255,255,255,0)
var m_a3bgcolor1 = '#b5c6e2'; //页面链接a3选中背景fcb262
var m_a3fontcolor = '#b0a8a8'; //页面链接a3初始字体颜色
var m_a3fontcolor1 = '#000'; //页面链接a3选中字体颜色

//获取用户名
var m_UserInfo = {};

var loginurl = hr_getServUrl(1);


var m_taskTypes = hr_getBaseItems(3);
var m_states = hr_getBaseItems(2);
var m_actors = hr_getBaseItems(1);


var m_sonfilter = {type: ''};


/***********************************************************************
 *  初始化
 *  DLY 
 */ 
$(function () { 
    //用户认证
    getUserInfo(); 
    $('#userNameSpan').html(m_UserInfo.userName);
    $('#comSpan').html(m_UserInfo.com);
    sc();
    // 非店长隐藏加班申请页
    if (m_UserInfo.actor != 'A') {
        $('#overtimesApplyPage').hide();
        $('#checkAttendancePage').hide();
        $('#specialPayPage').hide();
    }
    // 非人资隐藏权限配置页
    if (m_UserInfo.actor != 'C') {
        $('#sysconfigPage').hide();
    }
    // 贝爱大区经理显示薪资页 
    $('#shoppayPage').hide();
    if( hr_FlowComFlag(m_UserInfo.selfInfo.c_orgid) == '4'){
        if ((m_UserInfo.actor == 'B' || m_UserInfo.actor == 'D')) { //大区经理或城市经理
                $('#shoppayPage').show();
        } else { 
            //既是店长又是大区经理或城市经理
            var shopids = hr_getUnitidByCSJL('2', m_UserInfo.selfInfo.c_code);  //获取负责店铺id   
            if (shopids != '') {
                $('#shoppayPage').show();
            }
            shopids = hr_getUnitidByDQJL('2', m_UserInfo.selfInfo.c_code);  //获取负责店铺id   
            if (shopids != '') {
                $('#shoppayPage').show();
            }
        }
    }
    turnPage('A', 'tasks');
}); 
 


/*********************************************************************** 
 * 滚动条在居顶
 * DLY
 */
function sc() {
    //var e = document.getElementById("body"); 
    //e.scrollTop = -10;
    //alert($('#body').scrollTop());
    //$('#body').scrollTop(0); 
    document.getElementById('topdiv').scrollIntoView(); 
}


/*********************************************************************** 
 * 切换页面
 * DLY
 */
function turnPage(type, page, curl) { 
    var url = 'error.html'; 
    if (type == 'A') {
        if (page == undefined || page == null) {
            page = '';
        }
        //$('.a3').css("background-color", m_a3bgcolor);
        $('.a3').css("color", m_a3fontcolor);
        if (page != '') {
           // $('#' + page + 'Page').css("background-color", m_a3bgcolor1);
            $('#' + page + 'Page').css("color", m_a3fontcolor1);
            url = page + '.html' + '?s=' + new Date().getTime();
        }
    } else if (type == 'B') { 
        if (curl == undefined || curl == null) {
            curl = '';
        }
        $('.a3').css("background-color", m_a3bgcolor);
        $('.a3').css("color", m_a3fontcolor1);
        if (curl != '') {
            //$('#' + page + 'Page').css("background-color", m_a3bgcolor1);
            $('#' + page + 'Page').css("color", m_a3fontcolor1);
            url = curl;
        }
    } else if (type == 'C') { //贝爱薪资重新用户认证(排除pos关联打开)
        //url = hr_getServUrl(3) + '&name=' + $.cookie('name') + '&code=' + $.cookie('code')  + '&oid=' + $.cookie('oid'); 
        url = hr_getServUrl(3);
    }
    
    // 非店长切换人员查询页
    if (m_UserInfo.actor != 'A') { 
        url = url.replace('persons.html', 'personsQ.html');
    } 
    
    if (type == 'C' && url!='') {                 //新建选项卡
        //alert($.cookie('name'));
        window.open(url);
        //document.getElementById('openhere').src = url;
    } else {                           //替换内容页面
        document.getElementById('openhere').src = url;
        sc();
    }
}
 
 

/***********************************************************************
 *  获取操作人信息
 *  DLY 
 */
function checkUser(type) {
    if (type == 'open') {
        if (m_UserInfo.actor == 'A') {
            $('#pwd').val('');
            $('#pwddlg').dialog('open');
        } else {
            turnPage('C', 'shoppay');
        }
    } else if (type == 'check') {
        var pwd = $('#pwd').val();
        if (hr_ehrLogin(m_UserInfo.selfInfo.c_code, pwd)) {
            turnPage('C', 'shoppay');
            $('#pwddlg').dialog('close');
        } else {
            alert("验证失败!请输入正确密码"); 
        }
    }
}

/***********************************************************************
 *  获取操作人信息
 *  DLY 
 */
function getUserInfo() {  
    setCookie(1);  // 测试  
    m_UserInfo.actor = '';
    m_UserInfo.userName = $.cookie('name');
    m_UserInfo.empID = $.cookie('oid');
    m_UserInfo.empCode = $.cookie('code'); 
    m_UserInfo.empCode1 = ''; 
    m_UserInfo.empCode2 = '';
    m_UserInfo.shopids = '0';
    m_UserInfo.shopids1 = '0';
    if (m_UserInfo.empID == null || m_UserInfo.empID == '') {
        alert("会话过期,请重新登陆!");
        top.location.href = loginurl;
        return;
    }

    
    var row = { c_oid: m_UserInfo.empID };
    per = hr_getPer(row); 
    if (per.c_name != m_UserInfo.userName || per.c_code != m_UserInfo.empCode) {
        alert("用户认证失败,请重新登陆!");
        top.location.href = loginurl;
        return;
    } else if ((per.c_jobname == '店长' || per.c_jobname == '见习店长'
        || per.c_jobname == '中阶店长' || per.c_jobname == '高阶店长'
        || per.c_jobname == '大店长' || per.c_jobname == '临时店长'
        || per.c_jobname == '初阶店长')
        && per.c_employeestatus != '3') {   //店长认证  
        m_UserInfo.actor = 'A'; 
        // 获取大区经理
        var dqjlpercode = hr_getDQJLPer(2, per.c_unitid);
        if (dqjlpercode ==undefined || dqjlpercode == '') {
            alert("您所属公司未配置大区经理, 请通知系统管理员, 避免审批流程出现问题!");
        } 
        m_UserInfo.empCode1 = dqjlpercode;

        // 获取人资负责人
        var hrpercode = hr_getHRPer(2, per.c_orgid);
        if (hrpercode == '') {
            alert("您所属公司未配置人资负责人, 请通知系统管理员, 避免审批流程出现问题!");
        }
        m_UserInfo.empCode2 = hrpercode;
    } else {
        //城市经理认证
        var shopids1 = hr_getUnitidByCSJL('2', per.c_code);  //获取负责店铺id  
        if (shopids1 != '') {
            m_UserInfo.shopids1 = shopids1; 
            m_UserInfo.actor = 'D'; 
        }

        // 人资负责人认证
        var orgid = hr_getHRPer(1, per.c_code);
        //alert(orgid);
        if (orgid != '') {
            m_UserInfo.comID = per.c_orgid;
            m_UserInfo.comIDs = orgid; //多个公司
            m_UserInfo.actor = 'C';
        } else {
            //大区经理认证
            var shopids = hr_getUnitidByDQJL('2', per.c_code);  //获取负责店铺id   
            if (shopids != '') {
                m_UserInfo.actor = 'B';
                m_UserInfo.shopids = shopids;
            } 
        } 
    } 

    // 设置系统公司
    m_UserInfo.selfInfo = per;
    m_UserInfo.com = per.c_orgname;
    m_UserInfo.deptID = per.c_unitid;  
    m_UserInfo.deptCode = per.c_unitcode;
    m_UserInfo.deptName = per.c_unitname;
    if (m_UserInfo.actor == '') {
        alert("您没有权限!");
        top.location.href = loginurl;
        return;
    } 
    return m_UserInfo;
}


/*
* SetCookie 测试用
*/
function setCookie(n) {
    //var Then = new Date();
    //Then.setTime(Then.getTime() + 24 * 60 * 60 * 1000);  
    if (n == 1) {
        //店长
        $.cookie('name', '何亚燕', { expires: 1 });
        $.cookie('oid', '814893', { expires: 1 });
        $.cookie('code', '0741305', { expires: 1 });
    }else if (n == 2) {
        //经理
        $.cookie('name', '邓乐韵', { expires: 1 });
        $.cookie('oid', '109380346', { expires: 1 });
        $.cookie('code', '1112137', { expires: 1 });
    } else if (n == 3) {
        //人资
        $.cookie('name', '谢晔', { expires: 1 });
        $.cookie('oid', '84761703', { expires: 1 });
        $.cookie('code', '1103227', { expires: 1 });
    }else if (n == 4) {
        //经理
        $.cookie('name', '周敏娟', { expires: 1 });
        $.cookie('oid', '141237129', { expires: 1 });
        $.cookie('code', '1211591', { expires: 1 });
    }
    		
}


/***********************************************************************
 * 退出
 *  DLY 
 */
function layout() {
    $.cookie('userName', null);
    $.cookie('empID', null);
    $.cookie('empCode', null);
    m_UserInfo = {};
    top.location.href = loginurl;
}


/***********************************************************************
 *  设置或获取子页面参数
 *  DLY 
 */
function actsonfilter(type, fil) {
    if (type == 'get') {
        return m_sonfilter;
    } else if (type == 'set') {
        m_sonfilter = fil;
    } else if (type == 'new') {
        m_sonfilter = { type: '' };
    }
} 


 