/// <reference path="../lib/jquery-1.4.2.min.js" />

var isLoging = false;

$(function () {


    // 解决IE6不缓存背景图片
    try { document.execCommand("BackgroundImageCache", false, true); } catch (e) { }

    //    var t = top.location.href;
    //    var s = self.location.href;
    //    if (t != s) { top.location.href = s; }
    //    var sdstr = $("#ServerDate").val(); //server date
    //    var ld = (new Date());
    //    var ldstr = ld.getFullYear() + "-" + ((ld.getMonth() + 1) < 10 ? "0" + (ld.getMonth() + 1) : (ld.getMonth() + 1)) + "-" + ((ld.getDate()) < 10 ? "0" + (ld.getDate()) : (ld.getDate()));

    //    if (sdstr != ldstr) {
    //        //alert('服务器日期与客户端日期不一致！\n请修改本地日期后再登录！'
    //        //+ '\n\n参考信息：\n服务器日期：' + sdstr + '\n客户端日期：' + ldstr + '');
    //    }

    $('.input').bind('focus', function () {
        $(this).select();
    }).bind('keydown', function (e) {
        if ((e.keyCode || e.wilch) == 13) {
            var l = $(this).parent().next('label');
            if (l.size()) {
                l.find('input').focus()
                return false;
            } else {
                return true;
            }
        }
    });

    $('form:first').bind('submit', function () {
        if (!chkForm()) return false;
        if (isLoging) return false;
        var data = $('.input').serializeObject();
        var d = new Date();
        data.clientdate = d;

        //alert($.toJSON(data)); return false;

        $.ajaxWebService("Login.aspx/LoginCheck", data, function (result) {
            var obj = result.d;
            if (obj.success == 1) {
                location.href = $.QueryString().reurl || 'default.aspx'
            } else {
                //alert(obj.msg);
                $('#tipsbox').html('<div style="display:none;"><span class="x-icon icon-delete">&nbsp;</span>' + obj.msg + '</div>');
                $('div', '#tipsbox').fadeIn(200);
                isLoging = false;
                $('.button[type="image"]').attr('src', 'Public/images/login-button.gif');
            }
        }, {
            beforeSend: function () {
                isLoging = true;
                $('#tipsbox').empty();
                $('.button[type="image"]').attr('src', 'Public/images/login-button-wait.gif');
            }
        });
        return false;
    });

    var p = $.QueryString() || {};
    if (p.tbuser && p.tbpwd && p.f18pass) {
        p.userid = p.tbuser;
        p.password = p.tbpwd;
        $('.input').fillFields(p);
        $('form:first').trigger('submit');
    }

    $('#loginbox').hide().fadeIn('slow');

});

function chkForm() {
    if (!CheckLocalInfo()) return false;
    return true;
}

function CheckLocalInfo() {
    try {
        var v = VCLib.getDiskSN();
       // var v = DelphiLib.Get(); by andy 换回就插件 
        v = $.trim(v);
        v = v.length > 14 ? v.substr(v.length - 14) : v; //只取后14位
        $('#regpcv').val(v);
    } catch (e) {
        if (confirm('【客户端插件安装提示】\n当前电脑未安装客户端插件或未被启用！\n点击“确定”查看客户端插件安装说明。')) {
            location.href = '/setup/regdll.aspx';
            return false;
        }
    }
    return true;
}
