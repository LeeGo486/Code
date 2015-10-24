/// JS名：EHRForSalary.js
/// 说明：总部人资工资查询
/// 创建人：郭琦琦 
/// 创建日期：2014-10-20
//初始化
var type = undefined;
var m_Nowyear;
var m_Lastyeay;
var m_lastmonth;
var m_name;//登入明
var m_sfz = "";
$(function () {
    ////m_name =  Cookies.get("hzyapp.username");
    //function getQueryString(name) {
    //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    //    var r = window.location.search.substr(1).match(reg);
    //    if (r != null) return unescape(r[2]); return null;
    //}
    ////m_c_oid = getQueryString("c_oid");
    //m_sfz = getQueryString("sfz");
    ////m_oid_user = getQueryString("oid_user");
    ////m_usernamec = getQueryString("namec");
    //m_devicetype = getQueryString("devicetype");
    ////m_name = getQueryString("name");

    ////type = "iphone";
    //if (m_devicetype == "pc") {
    //    type = "ipad";
    //}
    //else {
    //    type = m_devicetype;
    //}


    m_sfz = $.cookie('sfz');
    m_c_oid = $.cookie('c_oid');
    m_oid_user = $.cookie('oid_user');
    m_usernamec = $.cookie('namec');
    m_devicetype = $.cookie('devicetype');


    if ((m_sfz == "" || m_sfz == undefined) || (m_c_oid == "" || m_c_oid == undefined) || (m_devicetype == "" || m_devicetype == undefined)) {
        window.location = "AttendanceIndex.HTML";
    }

    type = m_devicetype;
    if (m_devicetype == "pc") {
        type = "ipad";
    }


    //$('#txtipadinputname').val(decodeURI(m_name));
    //$('#txtipadsfz').val(m_sfz);
    //m_name = "郭琦琦";
    //m_name = m_name.replace(/\d+/g, '');



    //if (document.body.clientWidth > 700) {
    //    type = "ipad";
    //} else {
    //    type = "iphone";
    //}
    var nowDate = new Date();
    m_Nowyear = nowDate.DateAdd('y', 0).format("yyyy");//当年
    m_Lastyeay = nowDate.DateAdd('y', -1).format("yyyy");//当年
    m_lastmonth = nowDate.DateAdd('m', -1).format("MM");

    $("#ipad").hide();
    $("#iphone").hide();
    $("#" + type).show();


    selectOption();//添加select下拉年月

});

//查询
function btnSearch() {
    //传参数到后台
    var year = $("#txt" + type + "year").val();
    var month = $("#txt" + type + "month").val();

    if (m_sfz == "" || m_sfz == undefined) {
        alert("请重新登录");
        return;
    }
    if (month == "" || month == undefined) {
        alert("请选择月份!");
        return;
    }
    if (year == "" || year == undefined) {
        alert("请选择年份!");
        return;
    }


    var data = [];
    data[data.length] = { "name": "txtyear", "value": year };
    data[data.length] = { "name": "txtmonth", "value": month };
    data[data.length] = { "name": "txtsfz", "value": m_sfz };

    var urlGetEHRForSalary = GetWSRRURL('6caa05b7-cb78-4fb1-9f27-2e61df5c09c6') + "&XML=" + escape(GetFormJson(data, 'GetEHRForSalary'));

    htmlobj = $.ajax({
        url: urlGetEHRForSalary,
        type: 'post',
        async: false
    });
    var result = $.parseJSON(htmlobj.responseText);

    $("#txt" + type + "姓名").text(result.rows[0].姓名);
    $("#txt" + type + "员工号").text(result.rows[0].员工号);
    $("#txt" + type + "部门").text(result.rows[0].部门);
    $("#txt" + type + "岗位").text(result.rows[0].岗位);
    $("#txt" + type + "职级").text(result.rows[0].职级);
    $("#txt" + type + "银行名称").text(result.rows[0].银行);
    $("#txt" + type + "银行卡号").text(result.rows[0].银行卡号);
    $("#txt" + type + "公司承担住房公积金").text(result.rows[0].公司承担住房公积金);
    $("#txt" + type + "公司承担生育保险").text(result.rows[0].公司承担生育保险);
    $("#txt" + type + "公司承担工伤保险").text(result.rows[0].公司承担工伤保险);
    $("#txt" + type + "公司承担失业保险").text(result.rows[0].公司承担失业保险);
    $("#txt" + type + "公司承担医疗保险").text(result.rows[0].公司承担医疗保险);
    $("#txt" + type + "公司承担养老保险").text(result.rows[0].公司承担养老保险);
    $("#txt" + type + "公司承担福利合计").text(result.rows[0].公司承担福利合计);
    $("#txt" + type + "应出勤天数").text(result.rows[0].应出勤天数);
    $("#txt" + type + "出勤天数").text(result.rows[0].出勤天数);
    $("#txt" + type + "月基薪").text(result.rows[0].月基薪);
    $("#txt" + type + "岗位津贴").text(result.rows[0].岗位津贴);
    $("#txt" + type + "全勤奖").text(result.rows[0].全勤奖);
    $("#txt" + type + "保密费及物价补贴").text(result.rows[0].保密费及物价补贴);
    $("#txt" + type + "加班费1").text(result.rows[0].加班费1);
    $("#txt" + type + "加班费2").text(result.rows[0].加班费2);
    $("#txt" + type + "绩效工资").text(result.rows[0].绩效工资);
    $("#txt" + type + "通讯费").text(result.rows[0].通讯费);
    $("#txt" + type + "代发现金福利").text(result.rows[0].代发现金福利);
    $("#txt" + type + "驻外补贴").text(result.rows[0].驻外补贴);
    $("#txt" + type + "请假工资").text(result.rows[0].请假工资);
    $("#txt" + type + "常规扣款").text(result.rows[0].常规扣款);
    $("#txt" + type + "应补应扣").text(result.rows[0].应补应扣);
    $("#txt" + type + "考勤奖").text(result.rows[0].考勤奖);
    $("#txt" + type + "其他").text(result.rows[0].其他);
    $("#txt" + type + "薪资调整扣补").text(result.rows[0].薪资调整扣补);
    $("#txt" + type + "缺勤扣款").text(result.rows[0].缺勤扣款);
    $("#txt" + type + "代扣养老金").text(result.rows[0].代扣养老金);
    $("#txt" + type + "代扣失业金").text(result.rows[0].代扣失业金);
    $("#txt" + type + "代扣基本医疗").text(result.rows[0].代扣基本医疗);
    $("#txt" + type + "代扣住房公积金").text(result.rows[0].代扣住房公积金);
    $("#txt" + type + "代扣个税").text(result.rows[0].代扣个税);
    $("#txt" + type + "互助金").text(result.rows[0].互助金);
    $("#txt" + type + "扣餐费").text(result.rows[0].扣餐费);
    $("#txt" + type + "其他扣款").text(result.rows[0].其他扣款);
    $("#txt" + type + "应发合计").text(result.rows[0].应发合计);
    $("#txt" + type + "实发合计").text(result.rows[0].实发合计);

};

//下拉年月值
function selectOption() {
    if (type == undefined) {
        alert("请重新登入");
        return;
    } else {
        var selyearObj = $("#txt" + type + "year");
        selyearObj.append("<option >" + m_Lastyeay + "</option>");
        selyearObj.append("<option selected>" + m_Nowyear + "</option>");
        var value = new Array("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
        var text = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
        var selmonthObj = $("#txt" + type + "month");
        for (var i = 0; i < 12; i++) {
            selmonthObj.append("<option value='" + value[i] + "'>" + text[i] + "</option>");
        }
    }
    $("#txt" + type + "month").val(m_lastmonth);
}