// JavaScript Document

var _scrollpanel = { top: 0, count: 0, cur: 0 };
$(document).ready(function () { 
    initdrawtote();
    scrollpanel(); 
    if (jQuery.browser.version == '6.0') {
        correctPNG();
        alphaBackgrounds();
    } 
});

function scrollpanel() {
    //
    $('#scrollpanel li:first').clone().appendTo('#scrollpanel ul');
    _scrollpanel.count = $('#scrollpanel li').length;

    setInterval(function () {
        _scrollpanel.cur++;
        $('#scrollpanel').animate({ 'top': _scrollpanel.cur * -35 }, function () {
            if (_scrollpanel.cur == _scrollpanel.count - 1) {
                _scrollpanel.cur = 0;
                $('#scrollpanel').css({ 'top': 0 });
            }
        });
    }, 5000);

}



function correctPNG() {
    for (var i = 0; i < document.images.length; i++) {
        var img = document.images[i];
        var imgName = img.src.toUpperCase();
        if (imgName.substring(imgName.length - 3, imgName.length) == "PNG") {
            var imgID = (img.id) ? "id='" + img.id + "' " : "";
            var imgClass = (img.className) ? "class='" + img.className + "' " : "";
            var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' ";
            var imgStyle = "display:inline-block;" + img.style.cssText;
            if (img.align == "left") imgStyle = "float:left;" + imgStyle;
            if (img.align == "right") imgStyle = "float:right;" + imgStyle;
            if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle;
            var strNewHTML = "<span " + imgID + imgClass + imgTitle
			+ " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
			+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
			+ "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>";
            img.outerHTML = strNewHTML;
            i = i - 1;
        }
    }
}

function alphaBackgrounds() {
    var rslt = navigator.appVersion.match(/MSIE (d+.d+)/, '');
    var itsAllGood = (rslt != null && Number(rslt[1]) >= 5.5);
    for (i = 0; i < document.all.length; i++) {
        var bg = document.all[i].currentStyle.backgroundImage;
        if (itsAllGood && bg) {
            if (bg.match(/.png/i) != null) {
                var mypng = bg.substring(5, bg.length - 2);
                document.all[i].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + mypng + "', sizingMethod='scale')";
                document.all[i].style.backgroundImage = "url('')";
            }
        }
    }
}
 
var TotePop = false;
function initdrawtote() { 
    timeDesc(100);
    //待办提醒消息
    $('#Toptote').on('mouseenter', function () {
        if (TotePop) return;
        if ($('#TasksCount').html() > '0') {
            $("#ToptoteContent").show();
        } 
        TotePop = true;
    });
    $('#Toptote').on('mouseleave', function () {
        ToteClose();
    });
    /* 
    //导航子菜单单击显示事件 暂时还有问题
    $('#Header .Nav span').on('mousedown', function () { 
        //alert($(this).attr("id"));
        // $('#subNav1').toggle(); $('#subNav1').focus(); 
        $('#sub'+$(this).attr("id")).toggle(); $('#subNav1').focus();
    }); 
    */ 
}
function ToteClose() {
    TotePop = false;
    $("#ToptoteContent").hide();
}

function ajaxGetToteNum() {  
        var totalCount = 0;
        var cfilter1 = hr_getTasksCons('tasks'); //获取任务公共条件
        var cXML = '<Page>1</Page><Num>1</Num>'
                + '<Cons>' + cfilter1 + '</Cons><OrderBy></OrderBy>'; 
        cXML = dataUtil_addROOT(cXML);
        var curl = GetWSRRURL(peoa_GetWSRRURL(1001)) + "&type=GetAs&XML=" + encodeURIComponent(cXML); //拼接url
        //alert(cXML);	
        $.ajax({
            url: curl,
            type: "GET",
            async: false,
            dataType: "json",
            success: function (data) {
                //alert(jsonUtil_jsonToStr(data));
                if (data && data.rows) {
                    if (dataUtil_undefinedOrNull(data.total, 0) == 0) { 
                        totalCount = 0;
                    } else {
                        totalCount = dataUtil_undefinedOrNull(data.total, 0); 
                    }
                }
            }
        })  
        $('#TasksCount').html(totalCount);
} 
 
/***********************************************************************
 *  刷新任务数
 */
function timeDesc(x) {
    var n = $('#TasksCount').html()*1;
    if (x > 0 ) { 
        //x = x * 1 + 1;
        if (n >= 0) {
            ajaxGetToteNum(); 
        }
        setTimeout("timeDesc(" + x + ")", 30000);
    }  
}




