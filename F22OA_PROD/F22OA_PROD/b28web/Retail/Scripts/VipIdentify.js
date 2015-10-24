var _ajaxurl = "/b28web/AJAX/vip_Identify.ashx";
var _callback = null;
var _time = 60;
var _deftime = _time;
var _st = null;
var _method = "";

//调用AJAX返回JSON对象
var getjson = getjson || function (url, data) {
    var html = $.ajax({
        url: url,
        type: "POST",
        data: data,
        async: false
    }).responseText;
    return eval('(' + html + ')');
}

//显示验证码对话框
function SendVipMsg(method, vipcode, callback) {
    _method = method;
    vipcode = vipcode.replace(/\s+/g, "");
    clearInterval(_st);
    var json = getjson(_ajaxurl, "act=Set_IdentifyCode&vipcode=" + vipcode+"&method="+method);

    if (json.success == 1) {
        ShowIdentifyModal(method,vipcode, json.msg);
        _callback = callback;
    }else if(json.success == 2){ //已验证
        if (typeof callback == 'function') {
            callback();
        }
    } else {
        alert(json.msg);
    }
}

//发送短信
function SendMobileMsg(mobtel, vipcode) {
    var json = getjson(_ajaxurl, "act=SendMobileMsg&vipcode=" + vipcode + "&mobtel=" + mobtel + "&method=" + _method);
    if (json.success == 1) {
        TimeOutClick();
    } else {
        _time = 0;
        alert(json.msg);
    }
}

//检查验证码
function ChkIdentifyCode(method,vipcode) {
    var identifycode = $("#identifycode").val();
    if (identifycode.length < 1) {
        alert("验证码输入不正确！");
        $("#identifycode").focus();
        return false;
    }

    var json = getjson(_ajaxurl, "act=Chk_IdentifyCode&identifycode=" + identifycode + "&vipcode=" + vipcode+"&method="+method);
    if (json.success == 1) {
        if (typeof _callback == 'function') {
	    _time =0
            IdentifyCancel();
            _callback();
        }
    } else {
        alert(json.msg);
    }
}

//使用vip发送验证码
function ShowIdentifyModal(method,vipcode,mobtel) {

    var html = '<div id="divIdentify" style="background-color: #fff; border: 1px solid #cad9ea;font-size:12px;"> ' +
            '<div style="color:White;background-color:#2A92D9;height:35px;vertical-align:middle;" >' +
            '<div style="padding:10px 5px;font-weight:bold;width:120px;">短信验证</div>' +
            '</div>' +
            '<div style="margin:10px 5px;border-width:1px; height:40px;border-style:dotted;border-color:#D0D39E;background-color:#FFFFDD;font-size:12px;">' +
            '  <div style="margin:10px">' +
            '       将向此手机：<span id="mobile" style="font-weight:bold;color:#FF9900;">' + mobtel + '</span> 发送手机验证码信息</div>' +
            '  </div>' +
            '<div style="margin:10px 5px;border-width:1px; border-style:dotted;border-color:#68858D;background-color:#F2F9FF;font-size:12px;">' +
            '    <div style="margin:10px 10px 10px 40px;">' +
            '        验证码：<input type="text" style="width:80px;font-weight:bold;" maxlength="6" id="identifycode" />' +
            '        <a href="#"  id="restSend" style="padding-left:10px;color:Blue;" onclick="RestSendVipMsg(\'' + mobtel + '\',\'' + vipcode + '\')">获取验证码</a>' +
            '        <div style="margin:15px 60px;">' +
            '            <input type="button" value="验 证" onclick="ChkIdentifyCode(\''+method+'\',\'' + vipcode + '\')" /> ' +
            '            <a href="#" style="padding-left:15px;color:Gray;" onclick="IdentifyCancel()">取  消</a>' +
            '        </div>' +
            '    </div>' +
            '</div>' +
            '</div>';


    $.blockUI({
        theme: true,
        themedCSS: {
            width: '380px',
            top: ($(window).height() - 220) / 2 + 'px',
            left: ($(window).width() - 400) / 2 + 'px'
        },
        message: html
    });

    if (_time > 0 && _time != _deftime) {
        TimeOutClick();
    }
}  

function TimeOutClick() {
    $("#restSend").attr("disabled", "disabled");
    clearInterval(_st);

    _st = setInterval(function () {
        if (_time == 0) {
            clearInterval(_st);
            $("#restSend").removeAttr("disabled").text("获取验证码");
        } else {
            $("#restSend").text(_time + "秒后重新获取");
            _time--
        }
    }, 1000);
}

//重新发送
function RestSendVipMsg(mobtel, vipcode) {
    if($("#restSend").attr("disabled"))  return false;
    $("#restSend").attr("disabled", "disabled")
     
    _time = _deftime;
    SendMobileMsg(mobtel, vipcode);
    TimeOutClick();
}

function IdentifyCancel() {
    $.unblockUI();
}

