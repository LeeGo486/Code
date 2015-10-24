appUrl = "/Application/";
extLibUrl = "/Application/";

Ext.Loader.setConfig({ enabled: true });//, disableCaching: false，是否禁用js缓存
//设置插件路径
Ext.Loader.setPath('Ext.ux', extLibUrl + 'ext/src/ux');
Ext.Loader.setPath('WMC.common', extLibUrl + 'common/src');

Ext.Tools = function () {
    var msgCt;
    function MessageBox(t, m, v) {
        var Type;
        if (v == "E")
            Type = Ext.MessageBox.ERROR;
        else if (v == "I")
            Type = Ext.MessageBox.INFO;
        else if (v == "Q")
            Type = Ext.MessageBox.QUESTION;
        else if (v == "W")
            Type = Ext.MessageBox.WARNING;
        Ext.MessageBox.show({
            title: t,
            msg: m,
            buttons: Ext.MessageBox.OK,
            icon: Type
        });
    }
    return {
        Alert: function (t, m, v) {
            MessageBox(t, m, v);
        },
        Msg: function (msg, type) {
            if (msg == undefined) return;
            if (!msgCt) {
                msgCt = Ext.DomHelper.insertFirst(document.body, { id: 'msg-div' }, true);
            }
            content = "";
            delayTime = 1000;
            if (type == 0)
                content = '<div class="msgOk"><h3>成功</h3><p>' + msg + '</p></div>';
            else if (type == 1) {
                delayTime = 5000;
                content = '<div class="msgError"><h3>失败</h3><p>' + msg + '</p></div>';
            }
            else if (type == 9) {
                delayTime = 5000;
                content = '<div class="msgException"><h3>异常</h3><p>' + msg + '</p></div>';
            }
            var m = Ext.DomHelper.append(msgCt, content, true);
            m.hide();
            m.slideIn('t').ghost("t", { delay: delayTime, remove: true });
            if (msg == "登陆超时，请重新登陆！") {
                window.top.location.reload();
                //window.top.location.href = window.top.location.href;
            }
        },
        //格式化时间，例如2013-12-20或者/Date(139xxxxx)/等
        FormatDate: function (value) {
            if (value == null) return "";
            var argv = arguments;
            var argc = argv.length;
            var format = (argc > 1) ? argv[1] : "Y-m-d H:i:s";
            if (value instanceof Date) {
                return Ext.util.Format.date(value, format);
            }
            if (value.indexOf("Date") <= 0) {
                return Ext.util.Format.date(value, format);
            }
            var dt = eval("new " + value.substr(1, value.length - 2)).toString();
            return Ext.util.Format.date(dt, format);
        },
        //根据权限控制页面按钮显隐,module:页面,grid:按钮位于的panel,hide:true隐藏按钮，false禁用按钮（灰色）
        CtrlButtonsByPermession: function (module,grid,hide) {
            Ext.Ajax.request({
                url: '/Admin/Main/GetModuleButtons',
                method: 'GET',
                params: { module: module },
                success: function (response) {
                    btns = Ext.JSON.decode(response.responseText);
                    Ext.each(btns, function (item) {
                        btn = grid.query("button[action=" + item.ModuleKey + "]")[0];
                        if (hide == true)
                            btn.hide();
                        else
                            btn.setDisabled(true);
                    });
                },
                failure: function (response) {
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        },
        init: function () {
            if (!msgCt) {
                msgCt = Ext.DomHelper.insertFirst(document.body, { id: 'msg-div' }, true);
            }
        }
    };
}();
Ext.onReady(Ext.Tools.init, Ext.Tools);
/*****************************************************************/
/* Cookie操作 */
/*****************************************************************/
var Cookies = {};
Cookies.set = function (name, value) {
    var argv = arguments;
    var argc = arguments.length;
    var expires = (argc > 2) ? argv[2] : null;
    var path = (argc > 3) ? argv[3] : '/';
    var domain = (argc > 4) ? argv[4] : null;
    var secure = (argc > 5) ? argv[5] : false;
    document.cookie = name + "=" + escape(value) +
      ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
      ((path == null) ? "" : ("; path=" + path)) +
      ((domain == null) ? "" : ("; domain=" + domain)) +
      ((secure == true) ? "; secure" : "");
};

Cookies.get = function (name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    var j = 0;
    while (i < clen) {
        j = i + alen;
        if (document.cookie.substring(i, j) == arg)
            return Cookies.getCookieVal(j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0)
            break;
    }
    return null;
};

Cookies.clear = function (name) {
    if (Cookies.get(name)) {
        document.cookie = name + "=" +
        "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
};

Cookies.getCookieVal = function (offset) {
    var endstr = document.cookie.indexOf(";", offset);
    if (endstr == -1) {
        endstr = document.cookie.length;
    }
    return unescape(document.cookie.substring(offset, endstr));
};
/*****************************************************************/
/* VType自定义校验 */
/*****************************************************************/
Ext.apply(Ext.form.VTypes, {
    number: function (val, field) {
        return /^\d+$/.test(val);
    },
    numberText: '只能输入数字',
    mobilephone: function (val, field) {
        return /^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$/.test(val);
    },
    mobilephoneText: '手机号码格式错误',
    postcode: function (val, field) {
        return /^[1-9]\d{5}$/.test(val);
    },
    postcodeText: '邮政编码格式错误',
    idnum: function (val, field) {
        return /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/.test(val);
    },
    idnumText: '身份证格式错误',
    ipaddress: function (val, field) {
        return /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/.test(val);
    },
    ipaddressText: 'IP地址格式错误',
    amount: function (val, field) {
        return /^(([1-9]\d*)|\d)(\.\d{1,2})?$/.test(val);
    },
    amountText: '金额格式错误',
    passwordConfirm: function (value, field) {
        if (!(field.confirmTo instanceof Ext.form.Field)) {
            field.confirmTo = Ext.getCmp(field.confirmTo);
        }
        return (value == field.confirmTo.getValue());
    },
    passwordConfirmText: '两次新密码输入不一致',
    daterange: function (val, field) {
        var date = field.parseDate(val);
        if (!date) {
            return;
        }
        if (field.startDateField
				&& (!this.dateRangeMax || (date.getTime() != this.dateRangeMax
						.getTime()))) {
            var start = Ext.getCmp(field.startDateField);
            start.setMaxValue(date);
            start.validate();
            this.dateRangeMax = date;
        } else if (field.endDateField
				&& (!this.dateRangeMin || (date.getTime() != this.dateRangeMin
						.getTime()))) {
            var end = Ext.getCmp(field.endDateField);
            end.setMinValue(date);
            end.validate();
            this.dateRangeMin = date;
        }
        /*
		 * Always return true since we're only using this vtype to set
		 * the min/max allowed values (these are tested for after the
		 * vtype test)
		 */
        return true;
    }
});
/**********************************************************
图标选择回调函数
***********************************************************/
function setIconFieldValue(comId, iconName) {
    cmp = Ext.getCmp(comId);
    cmp.triggerEl.elements[0].removeCls(cmp.getValue());
    cmp.setValue(iconName);
    cmp.triggerEl.elements[0].addCls(iconName);
    Ext.getCmp('Wms_Icon_Win').close();
}