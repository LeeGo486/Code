/* 全局变量*/
var m_div3bgcolor = '#c5dff7'; //事件div初始背景
var m_div3bgcolor1 = '#58adfb'; //事件div选中背景
var m_td1bgcolor1 = '#f6f9fb'; //事件td1选中背景
var m_tabletypebgcolor = '#ff6a00' //按钮week或month的选中背景
var m_divid = '';
var m_act = '';
var m_datesbt = ''; //表头日期
var m_rows = []
 
var m_pers = [];
var m_pers1 = [];
var m_user;
var m_tabletype='week';

// 禁用滚动屏幕事件
var e_preventDefault = function (e) { e.preventDefault(); };

/* 初始化函数 */
$(function () {
	Mask.Hide();
	m_user = Cookies.get("hzyapp.username");
    $('#loginuser').html(m_user);
    m_pers = getPersons(m_user);
    m_pers1 = m_pers;
    $('#selectshowpers').html(setSelectshowpers(m_pers, 'all'));  
	
    //初始化加载数据 
    setMainDiv(m_tabletype); //初始化打开week模块
    $('#weekNO').attr('value', theWeek(new Date())); //设置当前周
    $('#spannow').html(getDayInfo('2', new Date())); //设置当前日期信息
    //设置当前月
    var mno = new Date().getMonth()+1; 
    var m1 = document.getElementById("monthSelect");
    for (var i = 0; i < m1.options.length; i++) { 
        if (mno == m1.options[i].value * 1) {
            m1.options[i].selected = true;
        }
    }
     
    //初始化加载设置数据到页面
    loadData('current',m_tabletype);

    /* 添加约见人员事件 */
    $('.td3').click(function () {
        var per = $(this).html();
        var curpers = $('#persons').val();
        if (curpers.indexOf(per) < 0) {
            if (per == '...') {
                curpers = curpers + per;
            } else {
                curpers = curpers + per + ',';
            }
        } else {
            curpers = curpers.replace(per + ',', '');
            curpers = curpers.replace(per, '');
        }
        $('#persons').val(curpers);
    });
    

});
 


/* NEWID */
function S4() {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}
function NewGuid() {
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}

/* 获取url参数 */
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURIComponent(r[2]); return "";
}

/* 获取日期对应星期几信息 */
function getDayInfo(type, now) {
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var day;
    switch (now.getDay()) {
        case 0: day = "日";
            break;
        case 1: day = "一";
            break;
        case 2: day = "二";
            break;
        case 3: day = "三";
            break;
        case 4: day = "四";
            break;
        case 5: day = "五";
            break;
        case 6: day = "六";
            break;
    }
    function formatNumber(value) {
        return (value < 10 ? '0' : '') + value;
    }
    if (type == '1') {
        return year + "年" + month + "月" + date + "日";
    } else if (type == '2') {
        return year + "年" + month + "月" + date + "日" + "&nbsp;&nbsp;星期" + day;
    } else if (type == '3') {
        return month + "." + date;
    } else if (type == '4') {
        return year + "/" + formatNumber(month) + "/" + formatNumber(date);
    } else if (type == '5') {
        return year + formatNumber(month) + formatNumber(date);
    }
}

/* 获取日期为第几周 */
function theWeek(now) {
    var totalDays = 0;
    var year = now.getFullYear();
    var days = new Array(12);
    days[0] = 31;
    days[2] = 31;
    days[3] = 30;
    days[4] = 31;
    days[5] = 30;
    days[6] = 31;
    days[7] = 31;
    days[8] = 30;
    days[9] = 31;
    days[10] = 30;
    days[11] = 31; 

    //判断是否为闰年，针对2月的天数进行计算
    if ((year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0)) {
        days[1] = 29
    } else {
        days[1] = 28
    }
     
    if (now.getMonth() == 0) {
        totalDays = totalDays + now.getDate();
    } else {
        var curMonth = now.getMonth();
        for (var count = 1; count <= curMonth; count++) {
            totalDays = totalDays + days[count - 1];
        }
        totalDays = totalDays + now.getDate();
    }
     
    //当年1月1日是第一周的第几天
    var totalDays1 = new Date(year + '/01/01').getDay();
    if (totalDays1 == 0) {
        totalDays1 = 7;
    }

    //得到第几周   第一周 + （总天数-第一周天数）除以7并向上取整
    var week = 1 +  Math.ceil((totalDays - (8 - totalDays1)) / 7) ;
    return week;
}

/* 根据第几周和当前日获取并设置日期 */
function setweektitle(weekNo, n) {

    var nowWeekNo = theWeek(new Date());
    if (weekNo == undefined) {
        weekNo = nowWeekNo;
    }
    var now = new Date();
    var currentDay = now.getDay();
    //if (currentDay == 0) {
    //    currentDay = 7;
    //}
    var dtime = 24 * 60 * 60 * 1000;
    var addtime = (weekNo - nowWeekNo) * 7 * dtime;
    var cbtdate1 = new Date(now.getTime() - (currentDay - 1) * dtime + addtime);
    var cbtdate2 = new Date(now.getTime() - (currentDay - 2) * dtime + addtime);
    var cbtdate3 = new Date(now.getTime() - (currentDay - 3) * dtime + addtime);
    var cbtdate4 = new Date(now.getTime() - (currentDay - 4) * dtime + addtime);
    var cbtdate5 = new Date(now.getTime() - (currentDay - 5) * dtime + addtime);
    var cbtdate6 = new Date(now.getTime() - (currentDay - 6) * dtime + addtime);
    var cbtdate7 = new Date(now.getTime() - (currentDay - 7) * dtime + addtime);
      
    if (n != undefined) { 
        n = '_' + n;
    } 
    //设置表头日期显示
    $('#spanday1' + n).html(getDayInfo('3', cbtdate1));
    $('#spanday2' + n).html(getDayInfo('3', cbtdate2));
    $('#spanday3' + n).html(getDayInfo('3', cbtdate3));
    $('#spanday4' + n).html(getDayInfo('3', cbtdate4));
    $('#spanday5' + n).html(getDayInfo('3', cbtdate5));
    $('#spanday6' + n).html(getDayInfo('3', cbtdate6));
    $('#spanday7' + n).html(getDayInfo('3', cbtdate7));
    //设置表头日期隐藏
    $('#btdate1' + n).attr('value', getDayInfo('4', cbtdate1));
    $('#btdate2' + n).attr('value', getDayInfo('4', cbtdate2));
    $('#btdate3' + n).attr('value', getDayInfo('4', cbtdate3));
    $('#btdate4' + n).attr('value', getDayInfo('4', cbtdate4));
    $('#btdate5' + n).attr('value', getDayInfo('4', cbtdate5));
    $('#btdate6' + n).attr('value', getDayInfo('4', cbtdate6));
    $('#btdate7' + n).attr('value', getDayInfo('4', cbtdate7));
};

/* 获取月份对应有几天 */
function theMDays(month, year) { 
    var days = new Array(12);  
    days[0] = 31;
    days[2] = 31;
    days[3] = 30;
    days[4] = 31;
    days[5] = 30;
    days[6] = 31;
    days[7] = 31;
    days[8] = 30;
    days[9] = 31;
    days[10] = 30;
    days[11] = 31;

    //判断是否为闰年，针对2月的天数进行计算 
    if ((year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0)) {
        days[1] = 29
    } else {
        days[1] = 28
    } 
    return  days[month-1];  
}

/* 设置对应月的背景图片 和 追加内置spanid*/
function setMDaysBG(month, n) { 
    n = '_' + n;
    var now = new Date();
    var year = now.getFullYear(); 
    var mdays = theMDays(month*1, year); 
    var firday = new Date(year + '/' + month + '/01').getDay(); 
    if (firday == 0) {
        firday = 6;
    } else {
        firday = firday - 1;
    }
    var d = 1; //背景图片序号
    for (var f = firday; f < 7; f++) { 
        $('#tdm0' + f + n).css("background", "url(Resources/img/" + d + ".png) right top no-repeat"); 
        //追加内置spanid 用已存放实际记录内容
        //var shtml = '<div style="padding-top:16px" onclick="show2(\'tdm' + 0 + n
        //          + '\',\''+ year +'/'+ month +'/'+ formatNumber(d)+'\')" id="spantdm' 
        //          + year + month + formatNumber(d) + n + '"><div>'
        //$('#tdm' + i + j + n).html(shtml);
        var shtml = '<div style="padding-top:22px"  id="spantdm' + year + month + formatNumber(d) + n + '">'
                  + '<span style="display:none" id="tdm0' + f + n + 'date">' + year + '/' + month + '/' + formatNumber(d)
                  + '</span>'
                  + '</div>'
        $('#tdm0' + f + n).html(shtml);
        d = d*1 + 1;
    } 
    for (var i = 1; i < 6; i++) { 
        for (var j = 0; j < 7; j++) {
            if (d <= mdays) {
                $('#tdm' + i + j + n).css("background", "url(Resources/img/" + d + ".png) right top no-repeat");
                //追加内置spanid 用已存放实际记录内容
                //$('#tdm' + i + j + n).html('<div style="padding-top:16px"  id="spantdm' + year + month + formatNumber(d) + n + '"><div>');
                var shtml = '<div style="padding-top:22px"  id="spantdm' + year + month + formatNumber(d) + n + '">'
                          + '<span style="display:none" id="tdm' + i + j + n + 'date">' + year + '/' + month + '/' + formatNumber(d)
                          + '</span>'
                          + '</div>'
                $('#tdm' + i + j + n).html(shtml);
                d = d * 1 + 1;
                //最后一行显示（很少用到的行）
                if (i == 5) {
                    $('#trm' + i + n).show();
                }
            } else {
                break;
                //$('#tdm' + i + j + n).css("background-color", "#eee"); //无效单元格可设置背景
            }
        } 
    }
    function formatNumber(value) {
        return (value < 10 ? '0' : '') + value;
    }
} 

/* 根据 id 获取记录信息 */
function getrow(rows, id) {
    var res = '';
    for (var i = 0; i < m_rows.length; i++) {
        if (m_rows[i].id == m_divid) {
            res = m_rows[i];
            break;
        }
    }
    return res;
}

/* 根据 id 修改记录信息 */
function updrow(rows, id, obj) {
    var oldrow = '';
    for (var i = 0; i < m_rows.length; i++) {
        if (m_rows[i].id == m_divid) {
            oldrow = m_rows[i];
            if (obj == 'del') {
                obj = oldrow;
                obj.id = '';
                obj.date = '';
            }
            m_rows[i] = obj;
            break;
        }
    }
    return oldrow;
}

/* 设置事件div内容 */
function setEventDiv(cobj, type) {
    //div的id=row.id   而 span的id=span + row.id
    var strspan = cobj.bgtime + ' - ' + cobj.edtime + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + cobj.theme;
    if (cobj.persons != "") {
        strspan = strspan + "<br>约见：" + cobj.persons;
    }
    var shtml = "<div id=\"" + cobj.id + "\" class=\"div3\" onclick=\"m_divid='" + cobj.id + "'; m_act = 'edit';\">"
                + "<span id=\"span" + cobj.id + "\">"
                + strspan
                + "</span>"
                + "</div> "
    if (type != undefined && type == 'span') {
        shtml = strspan;
    }
    return shtml;
}

/* 设置事件div选中背景 */
function set_div3bgcolor(cdivid) { 
    $('.div3').css("background-color", m_div3bgcolor);
    $('#' + cdivid).css("background-color", m_div3bgcolor1);
}

/* 设置单元格td1选中背景 */
function set_td1bgcolor(ctdid) {
    for (var i = 0; i < 8; i++) {
        $('.td1').css("background-color", "#fff");
        $('#' + ctdid).css("background-color", "#f6f9fb");
    }
}

/* 删除事件 */
function deleteEvent(divid) {
    hideEventModal();
    if (divid != '') {
        var obj = getrow(m_rows,divid);
        if (setRData('del', obj)) {
            $('#' + divid).remove();
            updrow(m_rows, divid, 'del');
        }
    }
}

/* 保存事件 */
function saveEvent(divid) { 
    // 获取人员table位置并校验是否与当前编辑窗人员一致
    var k = -1
    for (var i = 0; i < m_pers.length; i++) {
        if (m_user == m_pers[i].name) {
            k = i;
            break;
        }
    } 
    var tdid = $('#curtdid').val();
    if (k == -1 || k * 1 != tdid.substr(tdid.length-1,1))
    {
        alert('没有操作权限！');
        return false;
    }

    var obj = new Object();
    obj.id = divid;
    obj.theme = $('#theme').val();
    obj.persons = $('#persons').val();
    obj.date = $('#date').html();
    obj.bgtime = $('#bgtime1').val() + ':' + $('#bgtime2').val();
    obj.edtime = $('#edtime1').val() + ':' + $('#edtime2').val();
    obj.remark = $('#remark').val();
    obj.per = m_user;
    if (obj.theme == '') {
        alert('“行程”必填！');
        return false;
    }

    if (obj.bgtime >= obj.edtime) {
        alert('“结束时间”比较晚于“开始时间”！');
        return false;
    }
     
    hideEventModal();

    if (m_tabletype=='week') {  //type = week 
        for (var j = 1; j < 8; j++) { // 内循环 星期几 
            var cdate = getDayInfo('3', new Date($('#date').html())); //记录的日期
            var tdate = $('#spanday' + j + '_' + k).html(); //表头的日期
            if (cdate == tdate) {
                if (divid == '') {
                    divid = NewGuid();
                    obj.id = divid;
                    if (setRData('new', obj)) { 
                        //添加全局数组数据记录
                        m_rows.push(obj);
                        var shtml = setEventDiv(obj);
                        if (obj.bgtime < '12') {
                            shtml = $('#tdam' + j + '_' + k).html() + shtml;
                            $('#tdam' + j + '_' + k).html(shtml);
                        } else {
                            shtml = $('#tdpm' + j + '_' + k).html() + shtml;
                            $('#tdpm' + j + '_' + k).html(shtml);
                        }
                        //设置div背景色 
                        set_div3bgcolor(divid);
                    }
                }
                else {
                    //替换全局数组数据记录 判断显示位置是否替换
                    if (setRData('upd', obj)) {
                        var oldrow = updrow(m_rows, divid, obj);
                        var told = 'am';
                        if (oldrow.bgtime > '12') {
                            told = 'pm';
                        }
                        var tnew = 'am';
                        if (obj.bgtime > '12') {
                            tnew = 'pm';
                        }
                        if (told == tnew) {
                            var shtml = setEventDiv(obj, 'span');
                            $('#span' + divid).html(shtml);
                        } else { //删除并新增    
                            $('#' + divid).remove();
                            var shtml = setEventDiv(obj);
                            shtml = $('#td' + tnew + j + '_' + k).html() + shtml;
                            $('#td' + tnew + j + '_' + k).html(shtml);
                            //设置td1及div3背景色 
                            set_div3bgcolor(divid);
                            set_td1bgcolor('td' + tnew + j + '_' + k);
                        } 
                    } 
                }
            }
        }
    } else if (m_tabletype == 'month') {  //type = month 
        //设置各记录内容  
        var cdate = getDayInfo('5', new Date($('#date').html())); //记录的日期
        if (divid == '') {
            divid = NewGuid();
            obj.id = divid;
            if (setRData('new', obj)) { 
                //添加全局数组数据记录
                m_rows.push(obj);
                var shtml = setEventDiv(obj); 
                var spantdmid = 'spantdm' + cdate + '_' + k;
                shtml = $('#' + spantdmid).html() + shtml;
                $('#' + spantdmid).html(shtml);
            
                //设置div背景色 
                set_div3bgcolor(divid);
            }
        }
        else {
            //替换全局数组数据记录 
            if (setRData('upd', obj)) {
                var oldrow = updrow(m_rows, divid, obj);
                var shtml = setEventDiv(obj, 'span');
                $('#span' + divid).html(shtml);

                //设置td1及div3背景色 
                set_div3bgcolor(divid);
            } 
        }
        
    }
}

/* 隐藏编辑窗 */
function hideEventModal() {
    $('#eventModal').hide();
    $('#bgdiv').hide(); 
    //document.removeEventListener('touchmove', e_preventDefault, true);
}

/* 显示编辑窗 */
function showEventModal() {
    $('#eventModal').show();
    $('#bgdiv').show();
    $('#eventModal').height(455);
    //document.addEventListener('touchmove', e_preventDefault, true);
}

/* 打开编辑窗 week*/
function show1(col, tdid) { 
    // 获取人员table位置
    var k = -1
    for (var i = 0; i < m_pers1.length; i++) {
        if (m_user == m_pers1[i].name) {
            k = i;
            break;
        }
    }
    //校验是否与当前编辑窗人员一致
    var tdids = tdid.split('_');
    if (k == -1 || k * 1 != tdids[tdids.length - 1]) {
        if (m_act == '') {
            return false;
        } else if (m_act == 'edit') {
            //只读控制
            eventModalcontral(0);

        }
    } else {
        if (m_act == '') { 
            $('#labelEdit').html('新建事件');
        } else if (m_act == 'edit') {
            $('#labelEdit').html('修改事件');
        }
        //非只读控制 
        eventModalcontral(1);
    }

    //设置当前单元格背景颜色 
    set_td1bgcolor(tdid);
    $('#curtdid').val(tdid);
    //设置编辑窗的位置
	//alert($('#' + tdid.replace('pm', 'am')).offset().top);
	$('#eventModal').css("top", $('#' + tdid).offset().top + 20);
    //$('#eventModal').css("top", $('#' + tdid.replace('pm', 'am')).offset().top + 150);
    showEventModal();  // 显示编辑窗
    $('#choosePers').hide();  // 隐藏约见人员列表
    if (m_act == '') { //新建
        m_divid = '';
        //设置div背景色 
        set_div3bgcolor(m_divid);  
        $('#date').html($('#btdate' + col + tdid.substr(tdid.length-2,2)).val());
        $('#theme').val('');
        $('#persons').val('');
        $('#remark').val('');
        var t1 = document.getElementById("bgtime1");
        t1.options[2].selected = true;
        var t2 = document.getElementById("bgtime2");
        t2.options[0].selected = true;
        var t3 = document.getElementById("edtime1");
        t3.options[3].selected = true;
        var t4 = document.getElementById("edtime2");
        t4.options[0].selected = true;
    } else if (m_act == 'edit') {  //编辑
        //设置div背景色 
        set_div3bgcolor(m_divid);
        var row = getrow(m_rows, m_divid);
        if (row != '') {
            $('#theme').val(row.theme);
            $('#persons').val(row.persons);
            $('#remark').val(row.remark);
            $('#date').html(row.date);
            var bgtimes = row.bgtime.split(':');
            if (bgtimes.length == 2) {
                var t1 = document.getElementById("bgtime1");
                for (var i = 0; i < t1.options.length; i++) {//给select赋值
                    if (bgtimes[0] == t1.options[i].value) {
                        t1.options[i].selected = true;
                    }
                }
                var t2 = document.getElementById("bgtime2");
                for (var i = 0; i < t2.options.length; i++) {//给select赋值
                    if (bgtimes[1] == t2.options[i].value) {
                        t2.options[i].selected = true;
                    }
                }
            }
            var edtimes = row.edtime.split(':');
            if (edtimes.length == 2) {
                var t3 = document.getElementById("edtime1");
                for (var i = 0; i < t3.options.length; i++) {//给select赋值
                    if (edtimes[0] == t3.options[i].value) {
                        t3.options[i].selected = true;
                    }
                }
                var t4 = document.getElementById("edtime2");
                for (var i = 0; i < t4.options.length; i++) {//给select赋值
                    if (edtimes[1] == t4.options[i].value) {
                        t4.options[i].selected = true;
                    }
                }
            }
            //只读时显示的时间
            $('#xsbgtime').html($("#bgtime1").val() + ':' + $("#bgtime2").val()); 
            $('#xsedtime').html($("#edtime1").val() + ':' + $("#edtime2").val());
        }
    }
    m_act = ''; //操作设置为空  
}

/* 打开编辑窗 month*/
function show2(tdid, date) {
    //设置了背景图片的才是有效单元格
    if ($("#" + tdid).css("background-image") == 'none') {
        return false;
    }

    // 获取人员table位置
    var k = -1
    for (var i = 0; i < m_pers1.length; i++) {
        if (m_user == m_pers1[i].name) {
            k = i;
            break;
        }
    }
    //校验是否与当前编辑窗人员一致
     var tdids = tdid.split('_');
    if (k == -1 || k * 1 != tdids[tdids.length - 1]) {
        if (m_act == '') {
            return false;
        } else if (m_act == 'edit') {
            //只读控制
            eventModalcontral(0);

        }
    } else {
        if (m_act == '') {
            $('#labelEdit').html('新建事件');
        } else if (m_act == 'edit') {
            $('#labelEdit').html('修改事件');
        }
        //非只读控制 
        eventModalcontral(1);
    }
     
    //$('#eventModal').css("top", $('#spanMonthsInfo' + tdid.substr(tdid.length - 2, 2)).offset().top + 80);
    //设置当前单元格背景颜色 
    set_td1bgcolor(tdid);
    $('#curtdid').val(tdid);
    //设置编辑窗的位置
    //$('#eventModal').css("top", $('#' + tdid.replace('pm', 'am')).offset().top + 50);
	$('#eventModal').css("top", $('#' + tdid).offset().top + 20);
    showEventModal();  // 显示编辑窗
    $('#choosePers').hide();  // 隐藏约见人员列表
    if (m_act == '') { //新建
        m_divid = '';
        //设置div背景色 
        set_div3bgcolor(m_divid); 
        $('#date').html($('#' + tdid +'date').html());
        $('#theme').val('');
        $('#persons').val('');
        $('#remark').val('');
        var t1 = document.getElementById("bgtime1");
        t1.options[2].selected = true;
        var t2 = document.getElementById("bgtime2");
        t2.options[0].selected = true;
        var t3 = document.getElementById("edtime1");
        t3.options[3].selected = true;
        var t4 = document.getElementById("edtime2");
        t4.options[0].selected = true;
    } else if (m_act == 'edit') {  //编辑
        //设置div背景色 
        set_div3bgcolor(m_divid);
        var row = getrow(m_rows, m_divid);
        if (row != '') {
            $('#theme').val(row.theme);
            $('#persons').val(row.persons);
            $('#remark').val(row.remark);
            $('#date').html(row.date);
            var bgtimes = row.bgtime.split(':');
            if (bgtimes.length == 2) {
                var t1 = document.getElementById("bgtime1");
                for (var i = 0; i < t1.options.length; i++) {//给select赋值
                    if (bgtimes[0] == t1.options[i].value) {
                        t1.options[i].selected = true;
                    }
                }
                var t2 = document.getElementById("bgtime2");
                for (var i = 0; i < t2.options.length; i++) {//给select赋值
                    if (bgtimes[1] == t2.options[i].value) {
                        t2.options[i].selected = true;
                    }
                }
            }
            var edtimes = row.edtime.split(':');
            if (edtimes.length == 2) {
                var t3 = document.getElementById("edtime1");
                for (var i = 0; i < t3.options.length; i++) {//给select赋值
                    if (edtimes[0] == t3.options[i].value) {
                        t3.options[i].selected = true;
                    }
                }
                var t4 = document.getElementById("edtime2");
                for (var i = 0; i < t4.options.length; i++) {//给select赋值
                    if (edtimes[1] == t4.options[i].value) {
                        t4.options[i].selected = true;
                    }
                }
            }
            //只读时显示的时间
            $('#xsbgtime').html($("#bgtime1").val() + ':' + $("#bgtime2").val());
            $('#xsedtime').html($("#edtime1").val() + ':' + $("#edtime2").val());
        }
    }
    m_act = ''; //操作设置为空     
}

/* 编辑窗 只读控制*/
function eventModalcontral(type) {
    if (type == 0) {
        //只读控制
        $('#labelEdit').html('查看事件');
        $("#theme").prop("disabled", true);
        $("#persons").prop("disabled", true);
        $("#remark").prop("disabled", true);
        //$("#bgtime1").prop("disabled", true);
        //$("#bgtime2").prop("disabled", true);
        //$("#edtime1").prop("disabled", true);
        //$("#edtime2").prop("disabled", true);
        $('#btnEventSave').hide();
        $('#btnEventDelete').hide();
        $('#btnchoosePers').hide();
        $("#bgtime1").hide();
        $("#bgtime2").hide();
        $("#edtime1").hide();
        $("#edtime2").hide();
        $(".spanmh").hide(); 
        $('#xsbgtime').show(); 
        $('#xsedtime').show();
    } else if (type == 1) {
        //非只读控制 
        $("#theme").prop("disabled", false);
        $("#persons").prop("disabled", false);
        $("#remark").prop("disabled", false);
        //$("#bgtime1").prop("disabled", false);
        //$("#bgtime2").prop("disabled", false);
        //$("#edtime1").prop("disabled", false);
        //$("#edtime2").prop("disabled", false);
        $('#btnEventSave').show();
        $('#btnEventDelete').show();
        $('#btnchoosePers').show(); 
        $("#bgtime1").show();
        $("#bgtime2").show();
        $("#edtime1").show();
        $("#edtime2").show();
        $(".spanmh").show(); 
        $('#xsbgtime').hide();
        $('#xsedtime').hide();
    }
}

/* 加载数据 */
function loadData(type, type1) {
    //重新加载数据
    getRData(m_tabletype);
    if (type1 == 'week') {
        var wno = $('#weekNO').val();
        var te = /^[1-9]+[0-9]*]*$/;
        if (!te.test(wno) || wno < 1 || wno > 53) {
            wno = theWeek(new Date());
        }
        if (type == 'next') {
            wno = wno * 1 + 1;
        } else if (type == 'previous') {
            wno = wno * 1 - 1;
        } else if (type == 'current') {
            wno = wno * 1;
        } 
        $('#weekNO').val(wno);
        //测试表格 begin
        /* 
        setweektitle(wno, undefined);
        for (var i = 0; i < m_rows.length; i++) { // 外循环 所有行程记录
            for (var j = 1; j < 8; j++) { // 内循环 星期几 
                var cdate = getDayInfo('3', new Date(m_rows[i].date)); //记录的日期
                var tdate = $('#spanday' + j).html(); //表头的日期
                if (cdate == tdate) { 
                    var shtml = setEventDiv(m_rows[i]);
                    if (m_rows[i].bgtime < '12') {
                        shtml = $('#td' + j + 'am').html() + shtml;
                        $('#td' + j + 'am').html(shtml);
                    } else {
                        shtml = $('#td' + j + 'pm').html() + shtml;
                        $('#td' + j + 'pm').html(shtml);
                    } 
                }
            }
        } 
        */
        // 测试表格 end
       
        //设置所选人员weektables  
        $('#spanMonthsInfo').html(''); //先清空！
        $('#spanWeeksInfo').html(''); //先清空！
        for (var i = 0; i < m_pers1.length; i++) {
            var sthml = $('#spanWeeksInfo').html()+ setWeekTable(i, m_pers1[i].name);
            $('#spanWeeksInfo').html(sthml); 
            setweektitle(wno, i);  
        }

        //设置各记录内容  
        for (var i = 0; i < m_rows.length; i++) { // 外循环 所有行程记录
            for (var k = 0; k < m_pers1.length; k++) { // 内循环 人员
                var cname = m_rows[i].per; //记录的人员
                var tname = m_pers1[k].name; //表单的人员 
                if (cname == tname) {
                    for (var j = 1; j < 8; j++) { // 内循环 星期几 
                        var cdate = getDayInfo('3', new Date(m_rows[i].date)); //记录的日期
                        var tdate = $('#spanday' + j+ '_' + k).html(); //表头的日期
                        if (cdate == tdate) { 
                            var shtml = setEventDiv(m_rows[i]);
                            if (m_rows[i].bgtime < '12') {
                                shtml = $('#tdam' + j + '_' + k).html() + shtml;
                                $('#tdam' + j + '_' + k).html(shtml);   
                            } else {
                                shtml = $('#tdpm' + j + '_' + k).html() + shtml;
                                $('#tdpm' + j + '_' + k).html(shtml);
                            }
                        }
                    }
                }
            }
        }   
    } else if (type1 == 'month') {
        var mno = $('#monthSelect').val();
        if (type != 'current') {
            mno = type;
        } 
        //设置所选人员monthtables   
        $('#spanWeeksInfo').html(''); //先清空！
        $('#spanMonthsInfo').html(''); //先清空！
        for (var i = 0; i < m_pers1.length; i++) {
            var sthml = $('#spanMonthsInfo').html() + setMonthTable(i, m_pers1[i].name);
            $('#spanMonthsInfo').html(sthml);
            setMDaysBG(mno, i);
        }

        //设置各记录内容  
        for (var i = 0; i < m_rows.length; i++) { // 外循环 所有行程记录
            for (var k = 0; k < m_pers1.length; k++) { // 内循环 人员
                var cname = m_rows[i].per; //记录的人员
                var tname = m_pers1[k].name; //表单的人员 
                if (cname == tname) {
                    var shtml = setEventDiv(m_rows[i]); 
                    var spantdmid = 'spantdm' + getDayInfo('5', new Date(m_rows[i].date)) + '_' + k;
                    shtml = $('#' + spantdmid).html() + shtml;
                    $('#' + spantdmid).html(shtml);
                }
            }
        }
    }
}

/* 设置主窗体 */
function setMainDiv(type) {
    if (type == 'week') {
        m_tabletype = 'week';
        $('#mainWeek').show();
        $('#mainMonth').hide();
        $('#weekInfo').show();
        $('#monthInfo').hide();
        loadData('current', m_tabletype);
        $('#btnweek').css("background-color", m_tabletypebgcolor);
        $('#btnweek').css("color", '#fff');
        $('#btnmonth').css("background-color", '#fff');
        $('#btnmonth').css("color", m_tabletypebgcolor);
    } else if (type == 'month') {
        m_tabletype = 'month';
        $('#mainWeek').hide();
        $('#mainMonth').show(); 
        $('#weekInfo').hide();
        $('#monthInfo').show(); 
        loadData('current', m_tabletype); 
        $('#btnmonth').css("background-color", m_tabletypebgcolor);
        $('#btnmonth').css("color", '#fff');
        $('#btnweek').css("background-color", '#fff');
        $('#btnweek').css("color", m_tabletypebgcolor);
    } 
}

/* 设置人员的weektable */
function setWeekTable(n, name) { 
    var str = ''; 
    n = '_' + n;
    str = str + '<table id="weekstable' + n + '" class="table1" >';
    str = str + '<tr class="tr1" >';
    str = str + '<td class="td2" style="width:110px;" colspan="2">Week</td>';
    str = str + '<td class="td2">周一<br><span id="spanday1'+n+'"></span><input id="btdate1'+n+'" type="hidden"></td>';
    str = str + '<td class="td2">周二<br><span id="spanday2'+n+'"></span><input id="btdate2'+n+'" type="hidden"></td>';
    str = str + '<td class="td2">周三<br><span id="spanday3'+n+'"></span><input id="btdate3'+n+'" type="hidden"></td>';
    str = str + '<td class="td2">周四<br><span id="spanday4'+n+'"></span><input id="btdate4'+n+'" type="hidden"></td>'; 
    str = str + '<td class="td2">周五<br><span id="spanday5'+n+'"></span><input id="btdate5'+n+'" type="hidden"></td>'; 
    str = str + '<td class="td2">周六<br><span id="spanday6'+n+'"></span><input id="btdate6'+n+'" type="hidden"></td>'; 
    str = str + '<td class="td2">周日<br><span id="spanday7'+n+'"></span><input id="btdate7'+n+'" type="hidden"></td>'; 
    str = str + '</tr>'; 
    str = str + '<tr  class="tr2"> '; 
    str = str + '<td style="width:30px;" rowspan="2"><span id="spanperw'+n+'">' + name + '</span></td>';
    str = str + '<td class="td2" style="width:80px;">上午</td>'; 
    str = str + '<td class="td1" id="tdam1'+n+'" onclick="show1(1,\'tdam1' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam2'+n+'" onclick="show1(2,\'tdam2' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam3'+n+'" onclick="show1(3,\'tdam3' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam4'+n+'" onclick="show1(4,\'tdam4' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam5'+n+'" onclick="show1(5,\'tdam5' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam6'+n+'" onclick="show1(6,\'tdam6' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdam7'+n+'" onclick="show1(7,\'tdam7' + n + '\')"></td>';
    str = str + '</tr> '; 
    str = str + '<tr class="tr2">'; 
    str = str + '<td class="td2" style="width:80px;">下午</td>'; 
    str = str + '<td class="td1" id="tdpm1'+n+'" onclick="show1(1,\'tdpm1' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdpm2'+n+'" onclick="show1(2,\'tdpm2' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdpm3'+n+'" onclick="show1(3,\'tdpm3' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdpm4'+n+'" onclick="show1(4,\'tdpm4' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdpm5'+n+'" onclick="show1(5,\'tdpm5' + n + '\')"></td>';
    str = str + '<td class="td1" id="tdpm6'+n+'" onclick="show1(6,\'tdpm6' + n + '\')"></td> ';
    str = str + '<td class="td1" id="tdpm7'+n+'" onclick="show1(7,\'tdpm7' + n + '\')"></td>';
    str = str + '</tr>'; 
    str = str + '</table> '; 
    return str;
}

/* 设置人员的monthtable */
function setMonthTable(n, name) {
    var str = '';
    n = '_' + n;
    str = str + '<table id="spanMonthsInfo' + n + '" class="table1" >';
    str = str + '<tr class="tr1" >'; 
    str = str + '<td class="td2" style="width:100px;">Month</td>';
    str = str + '<td class="td2">周一</td>'; 
    str = str + '<td class="td2">周二</td>';
    str = str + '<td class="td2">周三</td>';
    str = str + '<td class="td2">周四</td>';
    str = str + '<td class="td2">周五</td>';
    str = str + '<td class="td2">周六</td>';
    str = str + '<td class="td2">周日</td>'; 
    str = str + '</tr>';
    for (var i = 0; i < 6; i++) {
        //默认不显示最后行，用的少
        if (i == 5) { 
            str = str + '<tr id="trm' + i + n + '" class="tr2_m" style="display:none"> ';
        } else { 
            str = str + '<tr id="trm' + i + n + '" class="tr2_m"> ';
        }
        //首行加姓名列
        if (i == 0) {
            str = str + '<td rowspan="6"><div id="spanperm' + n + '" style="width:20px;margin-left:30px">' + name + '</div></td> ';
        }
        //公共列自增生成
        for (var j = 0; j < 7; j++) { 
            str = str + '<td class="td1" id="tdm' + i + j + n + '" onclick="show2(\'tdm' + i + j + n + '\')"></td>';
        }
        str = str + '</tr>'; 
    } 
    str = str + '</table> '; 
    return str;
}

/* 设置关注人员select */
function setSelectshowpers(pers, type) { 
    var str = '';
    str = str + '<select id="showpers" class="select1" multiple="multiple"'
        + ' style="height:30px; width:150px;" onchange="getshowpers()" >';
    if(pers.length>0){ 
        str = str + '<option value="全选">全选</option>';
        str = str + '<option value="全不选">全不选</option>';
        if (type == 'all') {
            for (var i = 0; i < pers.length; i++) {
                str = str + '<option value="' + pers[i].name + '" selected="true">' + pers[i].name + '</option>';
            }
        }else if (type == 'none') {
            for (var i = 0; i < pers.length; i++) {
                str = str + '<option value="' + pers[i].name + '">' + pers[i].name + '</option>';
            }
        }

    } 
    str = str + '</select>'; 
    return str;  
}

/* 设置关注人员select */
function getshowpers() { 
    m_pers1 = [];
    var obj = document.getElementById("showpers"); 
    for (var i = 0; i < obj.options.length; i++) {
        if (obj.options[i].selected) {
            if (obj.options[i].value == '全选') {
                m_pers1 = m_pers; 
                $('#selectshowpers').html(setSelectshowpers(m_pers,'all'));
                break;
            } else if (obj.options[i].value == '全不选') {
                m_pers1 = [];
                $('#selectshowpers').html(setSelectshowpers(m_pers, 'none'));
                break;
            }
            m_pers1.push({ name: obj.options[i].value });
        } 
    }

    loadData('current', m_tabletype);
}
 
/* 获取记录数据 */
function getRData(type) { 
    //后期需要添加查询条件
    if (type = 'week') {

    } else if (type = 'month') {

    }
    var cons = 'AND dail_rguser IN (\'无\' ';
    for (var i = 0; i < m_pers.length; i++) {
        cons = cons + ',\'' + m_pers[i].name + '\''
    }
    cons = cons + ')';
    var m_OrderBy = 'ORDER BY dail_rguser, dail_eventdate, dail_validatefrom, dail_validateto'
    var cXML = '<Page>0</Page><Num>0</Num>'
             + '<Cons>' + cons + '</Cons><OrderBy>' + m_OrderBy + '</OrderBy>'
    cXML = '<ROOT><LIST><ROWS>' + cXML + '</ROWS></LIST></ROOT>';
    var curl = GetWSRRURL('35c2758f-6b2b-4b5d-8fee-edf4b8dc750c') + "&type=GetHs&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    
    //var jsonData = '{XML:"' + encodeURIComponent(cXML) + '"}';
    //alert(cXML);	
    $.ajax({
        //url: curl,
        url: urlPacking('get',curl),
        type: "GET",
        async: false,
        //data: cxmlsJson,
        dataType: "json",
        success: function (result) {
            try {
                if (result.Error) {
                    alert(result.Error);
                } else if (result.rows.length > 0 && result.rows[0].result == "False") {
                    alert(result.rows[0].message);
                } else {
                    if (result.rows && result.rows.length > 0) {
                        m_rows = result.rows;
                    } else {
                        m_rows = [];
                    } 
                }
            } catch (ex) {
                alert(ex);
            }
        },
        error: function () {
            alert("查询错误！");
        }
    })
}

/* 保存记录数据 */
function setRData(type, obj) {
    var flag = false;  
    row = [{
        dail_id: obj.id, dail_eventdate: obj.date, dail_validatefrom: obj.bgtime
        , dail_validateto: obj.edtime, dail_desp: obj.remark, dail_travel: obj.theme
        , dail_appointment: obj.persons, dail_rguser: obj.per
    }];
    var curl = GetWSRRURL('35c2758f-6b2b-4b5d-8fee-edf4b8dc750c');
    if (type == 'new') {
        curl = curl + "&type=New&actor=" + m_user;
    } else if (type == 'upd') { 
        curl = curl + "&type=Upd&actor=" + m_user; //拼接url 
    } else if (type == 'del') {
        curl = curl + "&type=Del&actor=" + m_user; //拼接url 
    }
    var cXML = GetEditJson(row, [], []); //json转xml   
    var cxmlsJson = { XML: cXML };
    
    var jsonData = '{XML:"' + encodeURIComponent(cXML) + '"}';
    $.ajax({
        url: urlPacking('get', curl + "&XML=" + encodeURIComponent(cXML)),
        type: "GET",
        async: false,
        //data: cxmlsJson,
        //data: { proxyData: (jsonData) },
        dataType: "json",
        success: function (result) {
            try { 
                if (result.Error) {
                    alert(result.Error);
                } else if (result.rows[0].result == "False") {
                    alert(result.rows[0].message);
                } else if (result.rows[0].result == "True") { 
                    flag = true;
                }
            } catch (ex) {
                alert(ex);
            }
        },
        error: function () {
            alert("保存失败！");
        }
    })
    return flag; 
}

/* 获取关注人员列表 */
function getPersons(user) {
    var pers = [];
    var cons = ' AND AUTH_FatherID = \'' + user + '\'';
    var orderby = ' ORDER BY CASE WHEN AUTH_UserName = \'' + user + '\' THEN 0 ELSE 1 END ASC' 
    var cXML = '<Page>0</Page><Num>0</Num>'
             + '<Cons>'+cons+'</Cons><OrderBy>' + orderby + '</OrderBy>'
    cXML = '<ROOT><LIST><ROWS>' + cXML + '</ROWS></LIST></ROOT>';
    var curl = GetWSRRURL('35c2758f-6b2b-4b5d-8fee-edf4b8dc750c') + "&type=GetPers&XML=" + encodeURIComponent(cXML)
            + "&s=" + new Date().getTime();  //拼接url   
    //var jsonData = '{XML:"' + encodeURIComponent(cXML) + '"}';
    //alert(cXML);	
    $.ajax({
        //url: curl,
        url: urlPacking('get',curl),
        type: "GET",
        async: false,
        //data: { proxyData: (jsonData) },
        //data: cxmlsJson,
        dataType: "json",
        success: function (result) {
            try {
                if (result.Error) {
                    alert(result.Error);
                } else if (result.rows.length > 0 && result.rows[0].result == "False") {
                    alert(result.rows[0].message);
                } else {
                    if (result.rows && result.rows.length > 0) {
                        pers = result.rows;
                    } else {
                        pers = [];
                    }
                }
            } catch (ex) {
                alert(ex);
            }
        },
        error: function () {
            alert("查询错误！");
        }
    })
    return pers;
}