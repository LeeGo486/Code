/// <reference path="../lib/jquery-1.4.2.min.js" />
$(document).ready(function () {
    //    $.extend($.blockUI.defaults, {
    //        message: '<b>正在等待服务器响应...</b>',
    //        css: {
    //            textAlign: 'center',
    //            bottom: '5px',
    //            left: '5px',
    //            border: 'none',
    //            padding: '5px',
    //            width: '150px',
    //            backgroundColor: '#328aa4',
    //            opacity: .5,
    //            color: '#fff'
    //        },
    //        overlayCSS: {
    //            backgroundColor: '#000',
    //            opacity: 0,
    //            cursor: 'wait'
    //        }
    //    });
    //    $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

    window.onerror = function (sMessage, sUrl, sLine) {
        var description = "An error occurred:\n" + sMessage + "\nURL: " + sUrl + "\nLine Number: " + sLine;
        $.WriteLog('window', self.location.href, 'null', description);
        //alert('当前页面发生脚本错误：\n' + description)
        return false; //正常返回错误信息
    }

});


$.fn.extend({
    // 将表单序列化成一个对象
    serializeObject: function () {
        var d = new Object();
        var ele = $(this);
        if (ele.length == 0) return d;
        $.each(ele, function () {
            var c = $(this);
            //for asp.net 自动生成的checbox HTML
            if (c.is('span') && c.find("input[type='checkbox']").length == 1) { c = c.find("input[type='checkbox']") }
            var n = c.attr("name");
            if (!n) return true;
            var v;
            //for asp.net 自动生成的name 格式
            n = n.split('$');
            n = n[n.length - 1];

            //根据不同控件取值
            if (c.is("input[type='checkbox']")) {
                d[n] = c.attr("checked") ? '1' : '0';
            }
            else if (c.is("input[type='radio']")) {
                if (c.attr("checked")) { d[n] = c.val() };

            } else if (c.is("select") || c.is("textarea") || c.is("input")) {
                d[n] = c.val();
            } else {
                d[n] = $.trim(c.text());
            }
        });
        return d;
    },
    // 将表单序列化成一个对象
    serializeObjectgb2312: function () {
        var d = new Object();
        var ele = $(this);
        if (ele.length == 0) return d;
        $.each(ele, function () {
            var c = $(this);
            //for asp.net 自动生成的checbox HTML
            if (c.is('span') && c.find("input[type='checkbox']").length == 1) { c = c.find("input[type='checkbox']") }
            var n = c.attr("name");
            if (!n) return true;
            var v;
            //for asp.net 自动生成的name 格式
            n = n.split('$');
            n = n[n.length - 1];

            //根据不同控件取值
            if (c.is("input[type='checkbox']")) {
                d[n] = c.attr("checked") ? '1' : '0';
            }
            else if (c.is("input[type='radio']")) {
                if (c.attr("checked")) { d[n] = c.val() };

            } else if (c.is("select") || c.is("textarea") || c.is("input")) {
                d[n] = window.encodeURI(c.val());
            } else {
                d[n] = window.encodeURI($.trim(c.text()));
            }
        });
        return d;
    },
    // JSON数据填充
    fillFields: function (obj) {
        $(this).each(function () {
            var c = $(this); //control
            var n = c.attr('name');
            if (!n) return true; 	// name is undefined
            n = n.split('$'); //get field name
            n = n[n.length - 1];
            var v = obj[n];
            if (v == null) {
                return true;    // value is null;
                //v = "";
            }
            if (c.is("span") || c.is("label")) {
                c.text(v);
            } else {
                if (c.is(":radio")) {
                    c.val([v.toString()]);
                } else if (c.is(":checkbox")) {
                    v ? c.attr('checked', 'checked') : c.removeAttr('checked');
                } else {
                    c.val(v);
                }
            }

        });
    },
    makerowselector: function (multi) {
        var rows = $(this).find('tbody tr');
        rows.hover(
            function () { $(this).addClass('hover'); },
            function () { $(this).removeClass('hover') }
        );
        if (multi) {
            rows.click(function () { $(this).addClass('selected'); });
        } else {
            rows.click(function () { $(this).addClass('selected').siblings().removeClass('selected'); });
        }
        return $(this);
    }
});

//some jQuery extends..
$.extend({
    //为Object添加Clone的方法，因为所有的对象的顶级对象都是Object
    clone: function (srcObj) {
        if (srcObj == null) { return srcObj; } //undefined or null
        var newObject;
        switch (typeof (srcObj)) {
            case "object":
                newObject = new srcObj.constructor();
                for (var property in srcObj) {
                    //Do not clone inherited values
                    if (srcObj.hasOwnProperty(property) || typeof (srcObj[property]) === 'object') {
                        newObject[property] = cloneObject(srcObj[property]);
                    }
                }
                break;
            default:
                newObject = srcObj;
                break;
        }
        return newObject;
    },
    format: function () {
        var args = arguments;
        var str = args[0];
        if (args.length < 2) return str;
        return str.replace(/\{(\d+)\}/g, function (m, i) {
            return args[parseInt(i) + 1];
        });
    },
    ajaxWebService: function (url, dataMap, fnSuccess, settings) {
        if (typeof dataMap == 'object') {
            dataMap = $.toJSON(dataMap);
        }
        if (url.indexOf('/') == -1) { url = location.href.split('?')[0].split('#')[0] + '/' + url }
        var options = {
            type: "POST",
            contentType: "application/json",
            url: url,
            data: dataMap,
            dataType: "json",
            success: fnSuccess,
            error: function (xml, str) {
                try {
                    obj = $.evalJSON(xml.responseText);
                    str = obj.Message;
                } catch (e) {
                    try {
                        str = xml.responseText;
                        var l = str.indexOf('<title>') + 7;
                        var r = str.indexOf('</title>');
                        str = str.substring(l, r);
                    } catch (e) {
                        str = '未知的错误!';
                    }
                }
                // save log
                $.WriteLog('ajax', this.url, dataMap, str);
                // show error info
                alert(str);
            }
        };

        options = $.extend(settings, options)

        $.ajax(options);
    },
    exportcsv: function (type) {

    },
    //  exportxls: function (head, foot, url) {
    //    var msg = $('<div id="ExportLoadingDiv" />')
    //    var msg1 = $('<span class="x-icon icon-loading" id="waitexport">文件正在生成中，请稍等...</span>');
    //    $('<a href="#cancel" style="float:right;">[取消]</a>').click(function () {
    //      if (ajax) ajax.abort();
    //      $.unblockUI();
    //      return false;
    //    }).prependTo(msg);
    //    $.blockUI({
    //      message: msg.append(msg1),
    //      css: {
    //        textAlign: 'center',
    //        top: ($(window).height() / 2 - 120) + 'px',
    //        left: ($(window).width() / 2 - 150) + 'px',
    //        border: 'none',
    //        padding: '20px',
    //        width: '270px',
    //        backgroundColor: '#fff',
    //        opacity: 1,
    //        color: '#000'
    //      },
    //      overlayCSS: {
    //        backgroundColor: '#000',
    //        opacity: 0.2,
    //        cursor: 'default'
    //      }
    //    });
    //    var obj = {
    //      head: head,
    //      foot: foot
    //    }
    //    var ajax = $.ajaxWebService(url, obj, function (json) {
    //      msg.empty().append('<span>文件生成成功！请<a href="' + json.d + '" target="_blank">点击此处</a>下载</span>')
    //                .prepend('<a href="#close" style="float:right;">[关闭]</a>')
    //               .find('A').click($.unblockUI)
    //    });
    //  },
    // 导出类型及HTML内容
    output: function (act, data) {
        var ajax;
        var msg = $('<div id="ExportLoadingDiv" />')
        var msg1 = $('<span class="x-icon icon-loading" id="waitexport">文件正在生成中，请稍等...</span>');
        $('<a href="#cancel" style="float:right;">[取消]</a>').click(function () {
            if (ajax) ajax.abort();
            $.unblockUI();
            return false;
        }).prependTo(msg);

        $.blockUI({
            message: msg.append(msg1),
            css: {
                textAlign: 'center',
                top: ($(window).height() / 2 - 120) + 'px',
                left: ($(window).width() / 2 - 150) + 'px',
                border: 'none',
                padding: '20px',
                width: '270px',
                backgroundColor: '#fff',
                opacity: 1,
                color: '#000'
            },
            overlayCSS: {
                backgroundColor: '#000',
                opacity: 0.1,
                cursor: 'default'
            }
        });
        ajax = $.ajax({
            url: '/ajax/ajaxoutput.ashx',
            type: 'post',
            cache: false,
            dataType: "json",
            data: { act: act, data: encodeURI(data) },
            success: function (obj) {
                if (!obj) return;
                msg.empty().append('<span>文件生成成功！请<a href="' + obj.url + '" target="_blank">点击此处</a>下载</span>')
                .prepend('<a href="#close" style="float:right;">[关闭]</a>')
                .find('A').click(function () { $.unblockUI(); return; })
            },
            error: function () {
                $.WriteLog('export', location.href, $.toJSON(this.data), '导出时发生错误！');
                msg.empty().append('<span>导出时发生错误！')
                .prepend('<a href="#close" style="float:right;">[关闭]</a>')
               .find('A').click($.unblockUI);
            }
        });
    },
    // 获取地址栏参数
    // 示例:QueryString().ID
    QueryString: function () {
        var args = new Object();
        var query = location.search.substring(1);      // Get query string
        var pairs = query.split("&");                  // Break at ampersand
        for (var i = 0; i < pairs.length; i++) {
            var pos = pairs[i].indexOf('=');           // Look for "name=value"
            if (pos == -1) continue;                   // If not found, skip
            var argname = pairs[i].substring(0, pos); // Extract the name
            var value = pairs[i].substring(pos + 1);     // Extract the value
            argname = argname.toLowerCase(); 	//将名称转换成小写，解决大小写值无法获取问题。by jackie 20091222
            value = decodeURIComponent(value);         // Decode it, if needed
            args[argname] = value;                     // Store as a property
        }
        return args;                                   // Return the object
    },
    openHelp: function () {
        var url = 'http://www.zhxit.com.cn/jumpurl.aspx?'
        url += $.param({ act: 'help', 'product': 'f23', 'menuid': $('#MenuId').val(), 'title': $(document).attr('title') });
        window.open(url, 'jumpurl');
    },
    string2int: function (str) {
        if (typeof str != 'string' || str == "") {
            return 0;
        } else {
            if (isNaN(parseInt(str))) {
                return $.string2int(str.substring(1));
            } else {
                return parseFloat(str);
            }
        }
    },
    //向左填充
    padLeft: function (str, len, c) {
        if (str.length >= len) {
            return str;
        } else {
            c = c || '0';
            return $.padLeft(c + str, len, c);
        }
    },
    param2obj: function (p) {
        var o = new Object();
        if (p) {
            p = p.replace(/\&/g, '","');
            p = p.replace(/\=/g, '":"');
            p = '{"' + p + '"}';
            o = $.evalJSON(p);
        }
        return o;
    },
    openModal: function (url, width, height, allowcache) {
        width = width || '450px';
        height = height || '300px';

        if (width.indexOf('%') >= 0) { width = (window.screen.availWidth * parseFloat(width) / 100) + 'px'; }
        if (height.indexOf('%') >= 0) { height = (window.screen.availHeight * parseFloat(height) / 100) + 'px'; }
        // 转换成URI标准格式
        url = window.encodeURI(url);
        // 不缓存
        if (!allowcache) {
            url.indexOf('?') >= 0 ? url += '&_=' : url += '?_=';
            url += (new Date()).valueOf();
        }
        var settings = 'dialogWidth:' + width + ';dialogHeight:' + height + ';center:yes;help:no;resizable:yes;location=no;status:no';
        try {
            return showModalDialog(url, window, settings);
        } catch (msg) {
            alert('您的浏览器阻止了弹出窗口！\n'
                + '请设置允许当前站点弹出窗口或关闭弹出窗口阻止程序！');
            return null;
        }
    },
    createHiddenIframe: function (url, callback) {
        if ($('#HiddenIframe').size()) {
            $('#HiddenIframe').remove();
        }
        var iframe = document.createElement("iframe");
        var loaded = function () {
            if (typeof callback == 'function')
                callback.call(this, iframe);
        };
        iframe.id = "HiddenIframe";
        $(iframe).attr('src', url).hide();
        if (iframe.attachEvent) {
            iframe.attachEvent("onload", loaded);
        } else {
            iframe.onload = loaded;
        }
        document.body.appendChild(iframe);
        return false;
    },
    print: function (url, width, height, act) {
        if (act == 0) {
            $.openModal(url, width, height, false);
        } else {
            url.indexOf('?') >= 0 ? url += '&' : url += '?';
            url += 'act=' + act;
            $.createHiddenIframe(url); //
        }
    },
    //是否需要执行更新临时标识
    doOperation: function (op, id,tempsure, callback) {
        if (!id || !op) return;
        var url = '/public/sheetchecker.aspx?' + $.param({ o: op, id: id, m: $('#MenuId').val(), tempsure: tempsure });
        var obj = $.openModal(url, '400px', '400px');
        if (obj) {
            if (typeof callback == 'function') {
                (callback)(obj);
            }
        }
    },
    playSound: function (src) {
        src = src || '/Public/sound/error.wav';
        var bgs = $('bgsound', 'body');
        if (!bgs.size()) {
            bgs = $('<bgsound loop="0" />').appendTo('body');
        }
        bgs.attr('src', src);
    },
    WriteLog: function (type, url, data, description) {
        var data = {
            act: 'writelog',
            obj: $.toJSON({
                type: type,
                url: url,
                data: data,
                description: description
            })
        }
        $.post("/ajax/ajaxfoundation.ashx", data);
    },
    // mask loading...
    mask: function (text, ajax, msg) {
        if (!msg) {
            text = text || '正在等待服务器响应...';
            msg = $('<div id="loading-mask" />').html('<div class="loading-mask-panel" />');
            $('.loading-mask-panel', msg)
            .append('<span class="x-icon icon-loading">' + text + '</span>')
            .append('<a href="#cancel" style="float: right;">[取消]</a>');
            // bind cancel event
            $('A[href="#cancel"]', msg).click(function () {
                if (ajax) ajax.abort();
                $.unmask();
                return false;
            });
        }
        $.blockUI({
            message: msg,
            css: {
                textAlign: 'center',
                top: ($(window).height() / 2 - 120) + 'px',
                left: ($(window).width() / 2 - 150) + 'px',
                border: 'none',
                padding: '20px',
                width: '270px',
                height: '20px',
                backgroundColor: '#fff',
                opacity: 1,
                color: '#000'
            },
            overlayCSS: {
                backgroundColor: '#000',
                opacity: 0.2,
                cursor: 'default'
            }
        });
    },
    // unmask loading..
    unmask: function () {
        $('#loading-mask').remove();
        $.unblockUI();
    },
    numberOnly: function (obj) {
        $(obj).keyup(function () {
            var tmptxt = $(this).val();
            $(this).val(tmptxt.replace(/\D|^/g, ''));
        })
        .bind("paste", function () {
            var tmptxt = $(this).val();
            $(this).val(tmptxt.replace(/\D|^/g, ''));
        }).css("ime-mode", "disabled");
    }
});

// formatters for grid
; (function ($) {
    var formatters = {
        IgnoreZreo: function (obj) {
            var value = obj.aData[obj.iDataColumn];
            return parseInt(value) == 0 ? '' : value;
        },
        YesNoFormatter: function (obj) {
            var value = obj.aData[obj.iDataColumn];
            return parseInt(value) > 0 ? '是' : '否';
        },
        SexFormatter: function (obj) {
            var value = obj.aData[obj.iDataColumn];
            return parseInt(value) == 1 ? '男' : '女';
        },
        NumericFormatter: function (obj) {
            if (typeof obj == 'object' && obj != null) {
                var value = obj.aData[obj.iDataColumn];
                return Math.round(value * 100) / 100;
            } else {
                return Math.round(obj * 100) / 100;
            }
        },
        DateFormatter: function (obj) {
            var value = obj.aData[obj.iDataColumn];
            return value.split(' ')[0];
        },
        TotalFormatter: function (value) {
            return '合计：' + value;
        }
    }
    $.extend(window, formatters);
})(jQuery);



/********************/
var escapeHtml = function (htmlString) {
    // Escaping unsecured characters. note: '&' has to be first.
    var escapeChar = [[/&/g, "&amp;"], [/</g, "&lt;"], [/>/g, "&gt;"],
                        [/\"/g, "&quot;"], [/'/g, "&#39;"]];
    jQuery.each(escapeChar, function (e) {
        htmlString = htmlString.replace(escapeChar[e][0], escapeChar[e][1]);
    });
    return htmlString;
};
/********************/
