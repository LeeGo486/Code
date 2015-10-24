//调用方法：<script src="http://192.168.0.114:8001/MenuClick.js" language="JavaScript"></script>


//--------------------------------普通调用方法----------------------------------------------------------------------
/**
 * 构造XMLHttpRequest对象
 * 
 * @return
 */
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        return new ActiveXObject('Microsoft.XMLHTTP');
    } else if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
    }
}

function MenuClick_AjaxPost() {
    try {
        var url = 'http://192.168.0.114:8001/MenuClick.aspx';
        var httpRequest = createXMLHttpRequest();
        if (httpRequest) {
            httpRequest.open("POST", url, true);//异步
            //httpRequest.setRequestHeader("content-length", data.length);
            httpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var params = "referrer=" + document.referrer;
            if (window.m_UserID) {
                params = "&userid=" + window.m_UserID;
            }
            httpRequest.send(params);

        } else {
        }
    }
    catch (ex) {
    }
}
MenuClick_AjaxPost();


//--------------------------------普通调用方法----------------------------------------------------------------------

//--------------------------------Jquery方法----------------------------------------------------------------------
//流量统计
$(function () {

    try {
        var url = 'http://192.168.0.114:8001/MenuClick.aspx';
        var params = { referrer: document.referrer };
        if (window.m_UserID) {
            params.userid = window.m_UserID;
        }
        $.post(url, params);
        alert(document.referrer);
    }
    catch (e) {
    }
});
//--------------------------------Jquery方法----------------------------------------------------------------------