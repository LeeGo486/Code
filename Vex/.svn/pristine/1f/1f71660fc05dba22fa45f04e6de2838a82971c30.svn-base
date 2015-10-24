
var m_MID = '';

var m_ATMonth = '';

var m_Flag=31;

/*********************************/
/**
 * 设置打印页面数据
 * 
 */
function setValues() {
    m_MID = dataUtil_undefinedOrNull(basedata_getUrlParam("v0"), '');
    m_ATMonth = dataUtil_undefinedOrNull(basedata_getUrlParam("v1"), '');
    m_Flag=dateUtil_DayNumOfMonth(m_ATMonth.substring(0, 4), m_ATMonth.substring(5, 7));

    if (m_MID==''){
        alert('id无效，请联系系统管理员！');
        return; 
    }

    if (m_ATMonth == '') {
        //获取主信息
        var cons = ' AND ( HR11_ID = \'' + m_MID + '\')';
        var res = hr_getAttendanceInfo(cons, 1, 1, '');
        if (res == '') {
            alert('id对应的主表信息无法获取！');
            return;
        }
        m_ATMonth = res.rows[0].hr11_atmonth;
    }

    var cons = ' AND ( HR12_MID = \'' + m_MID + '\')';
    var res = hr_getAttendanceRecord(cons, 1, 1000, 'HR12_EmpCode');
    if(res==''){
        alert('未查到考勤明细！');
        return;
    }
    
    //根据当月月份的天数设置表头
    var info = '<table class="mytable" style="border: 2px solid black;">';
    info = info + '<tr style="text-align: center; height: 30px;">'
                + '<td style="width:60px">工 号</td>'
                + '<td style="width:70px">姓 名</td>';
    for (var i = 1; i <= m_Flag; i++) {
        info += '<td style="width:20px">' + i + '</td>';
    }
    info += '</tr>';

    //构造人员考勤明细信息
    for (var i = 0; i < res.rows.length; i++) {
        info = info + '<tr tr style="text-align: center; height: 30px;">';
        info = info + '<td style="width:60px">' + res.rows[i].hr12_empcode + '</td>';
        info = info + '<td style="width:70px">' + res.rows[i].hr12_empname + '</td>';
        for (var j = 1; j <= m_Flag; j++) {
            var fieldname = 'hr12_day';
            var name = (j < 10) ? ('0' + j) : j;
            fieldname = fieldname + name;
            info = info + '<td style="width:20px">' + res.rows[i][fieldname] + '</td>';
        }
        info = info + '</tr>';
    }
    info = info + '</table>';
    $('#attendanceRecordspan').html(info);
    $('#titlespan').html(m_ATMonth);
}