/* 全局变量*/
var m_PageNumber = 1;  //当前页码
var m_PageSize = 20;  //每页显示行数

//获取用户名
var m_UserInfo = parent.m_UserInfo;
var m_Filter = '';  //主的条件
var m_Filter1 = ''; //查询条件
var m_OrderBy = ''; //排序方式


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

    setHelpInfo();
    setHelpRZInfo();
});



/***********************************************************************
*  设置IT支持
*  SY
*/
function setHelpInfo() {
    var cons = ' AND TypeCode=\'Code_Admin\'';
    var info = hr_getDBCode(cons, 1, 1000, '', 'GetSYSCodeItem');
    var itzc = ''
    for (var i = 0; i < info.total; i++) {
        itzc = itzc + '&nbsp;&nbsp;&nbsp;' + info.rows[i].name ;
    }
    $('#Name').html(itzc);
}


/***********************************************************************
*  设置EHR负责人
*  DLY
*/
function setHelpRZInfo() {
    var cons = ' AND HR9_Type=0 ';
    var info = hr_getSYSConfig(cons, 1, 1000, 'HR9_ID');
    var rzcom = ''
    var j = 0; //单元格序号 
    for (var i = 0; i < info.length; i++) {
        //rzcom = rzcom + info[i].hr9_rzempname + info[i].hr9_com + ' '; 
        $('#td' + j).html(info[i].hr9_com); //设置公司
        j = j + 1; 
        $('#td' + j).html(info[i].hr9_rzempname);  //设置负责人
        j = j + 1;

        
        if (i % 2 == 0 && i / 2 >= 5) { //默认只显示10行，后面需做显示设置 
            $('#tr' + i / 2).show();
        } 
        if (j == 99) { //最多可设置50个公司
            break;
        }
    }
    //$('#ehrcom').html(rzcom);
}