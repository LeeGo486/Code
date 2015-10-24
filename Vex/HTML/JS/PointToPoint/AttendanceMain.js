
var m_Nowyear;
var m_Lastyeay;
var m_month;
var m_name;//登入名字
var m_app;//获取所有审批人
var m_c_oid;//员工编号
var m_sfz;//身份证
var m_oid_user;//操作人
var m_approvedata = undefined;//获取审批数据
var checkedInfo = [];//审批数据
var m_usernamec;//姓名
var type = "";//登录设备
//初始化
$(function () {

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    if ($.cookie('devicetype') == undefined || $.cookie('devicetype') == "") {
        m_c_oid = getQueryString("c_oid");
        m_sfz = getQueryString("sfz");
        m_oid_user = getQueryString("oid_user");
        m_usernamec = getQueryString("namec");
        m_devicetype = getQueryString("devicetype");
        m_name = getQueryString("name");
    }
    else {
        m_sfz = $.cookie('sfz');
        m_c_oid = $.cookie('c_oid');
        m_oid_user = $.cookie('oid_user');
        m_usernamec = $.cookie('namec');
        m_devicetype = $.cookie('devicetype');
        m_name = $.cookie('name');
    }


    if ((m_sfz == "" || m_sfz == undefined) || (m_c_oid == "" || m_c_oid == undefined) || (m_devicetype == "" || m_devicetype == undefined)) {
        window.location = "AttendanceIndex.HTML";
    }
    if (m_devicetype == "pc") {
        type = "ipad";
    }
    else {
        type = "iphone";
        $.cookie('sfz', m_sfz, { path: "/", expires: 1 * 1 });
        $.cookie('namec', m_usernamec, { path: "/", expires: 1 * 1 });
        $.cookie('name', m_name, { path: "/", expires: 1 * 1 });
        $.cookie('c_oid', m_c_oid, { path: "/", expires: 1 * 1 });
        $.cookie('oid_user', m_oid_user, { path: "/", expires: 1 * 1 });
        $.cookie('devicetype', m_devicetype, { path: "/", expires: 1 * 1 });
    }
});

function btnLink(link) {
    if (link.indexOf('PE_OA/HR') >= 0) {
        window.location = link + "?r=" + Math.random() + "&namec=" + m_usernamec + "&name=" + m_name + "&c_oid=" + m_c_oid;
    } else {
        window.location = link + "?r=" + Math.random();
    }
    //window.location = link + "?r=" + Math.random() + "&sfz=" + m_sfz + "&namec=" + m_usernamec + "&name=" + m_name + "&c_oid=" + m_c_oid + "&oid_user=" + m_oid_user + "&devicetype=" + type;
}
