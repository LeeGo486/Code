var ProxyPost = "/Proxy/Redirect/Post?url=";
var ProxyGet = "/Proxy/Redirect/Get?url=";
var WsrrUrl = "http://192.168.0.114/wsrr.asmx/CallByXML";
var WsrrTestUrl = "http://172.16.205.57:8080/wsrr.asmx/CallByXML";

//全局错误码
ErrorMsg = {NetError:"网络异常，数据加载失败！"};

//页面加载，权限验证
$(function () {
    var url = location.href;
    url = url.replace("http://", "");
    url = url.substring(url.indexOf("/"));
    $.post("/Proxy/Redirect/CheckAuth/?url=" + url, function (data) {
        if (!data.success) {
            alert("OK");
            //location.href = "/Content/404.html";
        }
    });
});

//对URL重新封装
function urlPacking(t,u) {
    if (u.lastIndexOf("?") > 0) {
        u = u + "&";
    }
    else {
        u = u + "?";
    }
    u = u + "moduleId=" + getUrlParam("moduleId") + "&tokenId=" + getUrlParam("tokenId");
    return (t.toLowerCase() == "get" ? ProxyGet : ProxyPost) + encodeURIComponent(u);
}

//获取URL参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return "";
}

//检查数据返回值
function checkResponse(data) {
    var obj = ""
    if (typeof (data) == "string") {
        try {
            obj = JSON.parse(data);
        } catch (e) {
            obj = { success: true, msg:'ok' };
        }        
    }
    else if (typeof (data) == "object") {
        obj = data;
    }

    if (obj.success != undefined && !obj.success) {
        alert(obj.msg=="relogin"?"令牌已过期，请您重新登录！":obj.msg);
        return false;
    }
    return true;
}