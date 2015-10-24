/*
 * 2014-06-17
 * 自定义Mask
 * 陈杰
 * 调用方式Msg.show('消息内容',0/1/3);
 */
var Msg = {};
var overlay;
Msg.show = function (msg, type) {
    if (type == 0) {
        iosOverlay({
            text: msg,
            duration: 2000,
            icon: "/Scripts/IosOverlay/images/check.png"
        });
    } else if (type == 1) {
        iosOverlay({
            text: msg,
            duration: 4000,
            icon: "/Scripts/IosOverlay/images/cross.png"
        });
    } else if (type == 3) {
        var opts = {
            lines: 13, // The number of lines to draw
            length: 11, // The length of each line
            width: 5, // The line thickness
            radius: 17, // The radius of the inner circle
            corners: 1, // Corner roundness (0..1)
            rotate: 0, // The rotation offset
            color: '#FFF', // #rgb or #rrggbb
            speed: 1, // Rounds per second
            trail: 60, // Afterglow percentage
            shadow: false, // Whether to render a shadow
            hwaccel: false, // Whether to use hardware acceleration
            className: 'spinner', // The CSS class to assign to the spinner
            zIndex: 2e9, // The z-index (defaults to 2000000000)
            top: 'auto', // Top position relative to parent in px
            left: 'auto' // Left position relative to parent in px
        };
        var target = document.createElement("div");
        document.body.appendChild(target);
        var spinner = new Spinner(opts).spin(target);
        overlay = iosOverlay({
            text: msg,
            spinner: spinner
        });
        return overlay;
    }
};
Msg.hide = function () {
    overlay.hide();
}
//获取URL参数
var Url = {};
Url.get = function (param) {
    var reg = new RegExp("(^|&)" + param + "=([^&]*)(&|$)");
    var r = location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]); return "";
} 
//判断浏览器类型
var Browser = {};
Browser.isWeiXin = function () {
    if (location.href.toLowerCase().indexOf("/warningmsg/") > 0)
        return true;
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == "micromessenger" || ua.match(/msie/i) == "msie") {
        return true;
    } else {
        window.location.href = "/Matrix/AMLogin/WarningMsg/99";
        return false;
    }
};
//window.onload = Browser.isWeiXin();