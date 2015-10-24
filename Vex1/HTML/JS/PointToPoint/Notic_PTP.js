/// JS名：Notic_PTP.js
/// 说明：总部人资公告管理查询点一点
/// 创建人：郭琦琦 
/// 创建日期：2014-10-22
var m_user;
var result;
//初始化
$(function () {
    m_user = window.m_UserID;
    m_user = "郭琦琦";
    InitGird();
})

//初始化表格
function InitGird(url) {

    var urlGetNotic_PTP = GetWSRRURL('f1a2f406-c0ae-4fef-a62d-3be8c522d0a0') + "&XML=" + escape(GetFormJson([], 'GetNoticForPTP'));
    //urlGetNotic_PTP = urlPacking('GET', urlGetNotic_PTP)
    htmlobj = $.ajax({
        url: urlGetNotic_PTP,
        type: 'post',
        async: false
    });
    result = $.parseJSON(htmlobj.responseText);

    var html = "";

    for (var i = 0; i < result.rows.length; i++) {
        html = html + '<tr onclick="noticInfo(' + i + ')"><th>' + i + "." + '</th><td>' + result.rows[i].notictitle + '</td><td>' + result.rows[i].creatrdate + '</td></tr>'
    }
    $('#tb').append(html);

}

function noticInfo(id) {

    $('#noticInfo').window({
        title: "内容",
        top: document.body.clientWidth * .1,
        left: document.body.clientWidth * .05,
        width: document.body.clientWidth * .9,
        height: document.documentElement.clientHeight * 0.7,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        closable: false,
        draggable:false
    }).window('open');
    //.removeClass("background-color").addClass("background-color:rgba(239, 239, 239, 1)");

    $('#tbInfo').html("");
    ////$('#noticInfo').append(result.rows[id].noticcontent);
    var html1 = '<thead><tr><td style="text-align: center;font-size:20px">' + result.rows[id].notictitle + '</td></tr></thead>' +
    '<tbody><tr><td style="text-align: center;font-size:10px;height:4px">' + result.rows[id].creatrdate + '</td></tr>' +
    '<tr><td style="background-color:rgba(239, 239, 239, 1)">' + result.rows[id].noticcontent + '</td></tr></tbody>';
    $('#tbInfo').html(html1);

}
