/// <reference path="jquery-1.4.1.min.js" />
$(document).ready(function() {
    $.extend($.blockUI.defaults, {
        message: '<b>正在等待服务器响应...</b>',
        css: {
            textAlign: 'center',
            bottom: '5px',
            left: '5px',
            border: 'none',
            padding: '5px',
            width: '150px',
            backgroundColor: '#328aa4',
            opacity: .5,
            color: '#fff'
        },
        overlayCSS: {
            backgroundColor: '#000',
            opacity: 0,
            cursor: 'wait'
        }
    });
    $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

    // effect
    $(".x-toolbar :button").bind('mousedown', function() { $(this).addClass('mousedown') })
                            .bind('mouseup', function() { $(this).removeClass('mousedown') })
                            .bind('mouseout', function() { $(this).removeClass('mousedown').removeClass('hover') })
                            .bind('mouseover', function() { $(this).addClass('hover') });

});

$.fn.extend({
    // 将表单序列化成一个对象
    serializeObject: function() {
        var d = new Object();
        var ele = $(this);
        if (ele.length == 0) return d;
        $.each(ele, function() {
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
    // JSON数据填充
    fillFields: function(obj) {
        $(this).each(function() {
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
    makerowselector: function(multi) {
        var rows = $(this).find('tbody tr');
        rows.hover(
            function() { $(this).addClass('hover'); },
            function() { $(this).removeClass('hover') }
        );
        if (multi) {
            rows.click(function() { $(this).addClass('selected'); });
        } else {
            rows.click(function() { $(this).addClass('selected').siblings().removeClass('selected'); });
        }
        return $(this);
    }
});

//some jQuery extends..
$.extend({
    //为Object添加Clone的方法，因为所有的对象的顶级对象都是Object
    clone: function(srcObj) {
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
    format: function() {
        var args = arguments;
        return this.replace(/\{(\d+)\}/g, function(m, i) {
            return args[i];
        });
    },
    ajaxWebService: function(url, dataMap, fnSuccess) {
        if (typeof dataMap == 'object') {
            dataMap = $.toJSON(dataMap);
        }
        if (url.indexOf('/') == -1) { url = location.href.split('?')[0] + '/' + url }

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: dataMap,
            dataType: "json",
            success: fnSuccess,
            error: function(xml, str) {
                try {
                    obj = $.evalJSON(xml.responseText);
                    alert(obj.Message);
                } catch (e) {
                    try {
                        var str = xml.responseText;
                        var l = str.indexOf('<title>') + 7;
                        var r = str.indexOf('</title>');
                        alert(str.substring(l, r));
                    } catch (e) {
                        alert('未知的错误!')
                    }
                }
            }
        });
    },
    // 获取地址栏参数
    // 示例:QueryString().ID
    QueryString: function() {
        var args = new Object();
        var query = location.search.substring(1);      // Get query string
        var pairs = query.split("&");                  // Break at ampersand
        for (var i = 0; i < pairs.length; i++) {
            var pos = pairs[i].indexOf('=');           // Look for "name=value"
            if (pos == -1) continue;                   // If not found, skip
            var argname = pairs[i].substring(0, pos); // Extract the name
            var value = pairs[i].substring(pos + 1);     // Extract the value
            //argname = argname.toLowerCase();		//将名称转换成小写，解决大小写值无法获取问题。by jackie 20091222
            value = decodeURIComponent(value);         // Decode it, if needed
            args[argname] = value;                     // Store as a property
        }
        return args;                                   // Return the object
    },
    json2Table: function(json, opts) {
        var thead = "", tbody = "";
        var width = 0;
        opts = opts || {};

        $.each(json.thead, function(i, row) {
            thead += '<tr>';
            $.each(row, function(i, cell) {
                if (opts.rowclass) {
                    $.each(opts.rowclass, function(n, o) {
                        if (o.name == cell["name"]) { o.idx = i; }
                    });
                }
                thead += '<td name="' + cell["name"] + '"'
                    + (cell["colspan"] > 0 ? " colspan=" + cell["colspan"] : "")
                    + (cell["rowspan"] > 0 ? " rowspan=" + cell["rowspan"] : "")
                    + (cell["width"] > 0 ? " width=" + cell["width"] : "")
                    + (cell["AllowEdit"] ? " AllowEdit=" + cell["AllowEdit"] : "")
                    + (cell["fieldType"] ? " fieldType=" + cell["fieldType"] : "")
                    + '>' + cell["caption"] + '</td>';
                width += cell["width"];
            });
            thead += '</tr>';
        });
        $.each(json.data, function(i, r) {

            var cls = [];
            if (opts.rowclass) {
                $.each(opts.rowclass, function(n, o) {
                    if (r[o.idx] == o.value) { cls.push(o.cls) }
                });
            }
            cls = cls.length > 0 ? ' class="' + cls.join(' ') + '"' : "";
            tbody += '<tr' + cls + '><td>' + r.join('</td><td>') + '</td></tr>';
        });

        return "<table cellspacing=\"1\" cellpadding=\"3\" border=\"0\" class=\"dltab\" width=\"" + width + "\"><thead>" + thead + "</thead><tbody>" + tbody + "</tbody></table>";
    },
    ///
    string2int: function(str) {
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
    padLeft: function(str, len, c) {
        if (str.length >= len) {
            return str;
        } else {
            c = c || '0';
            return $.padLeft(c + str, len, c);
        }
    },
    param2obj: function(p) {
        var o = new Object();
        if (p) {
            p = p.replace(/\&/g, '","');
            p = p.replace(/\=/g, '":"');
            p = '{"' + p + '"}';
            o = $.evalJSON(p);
        }
        return o;
    },
    openModal: function(url, width, height) {
        width = parseInt(width) || 450;
        height = parseInt(height) || 300;
        url.indexOf('?') >= 0 ? url += '&_=' : url += '?_=';
        url += (new Date()).valueOf()
        var m = showModalDialog('' + url + '', window, 'dialogWidth:' + width + 'px;dialogHeight:' + height + 'px;center:yes;help:no;resizable:yes;status:no');
        return m;
    },
    depotSelector: function(params) {
        var obj = $.openModal("../public/depotselector.aspx?" + params, 780, 400);
        return obj ? $.evalJSON(obj) : null;
    },
    makehtmltable: function(json) {
        var thead = "", tbody = "", tfoot = "";
        var width = 0;
        if (json) {
            //header
            thead += '<tr>';
            var cols = json.columns;
            var fd = json.foot || {};
            var ws = [];
            var level = 0;
            for (var name in cols) {
                var col = cols[name];
                thead += '<th name=' + name + ' width="' + col.Width + '">' + col.Caption + '</th>';
                tfoot += '<td width="' + col.Width + '">' + (fd[name] || '&nbsp;') + '</td>';
                width += col.Width + 7;
                ws.push(col.Width);
                var gn = col.GroupName || [];
                if (gn.length > 0) {
                    level = level > gn.length ? level : gn.length;
                }
            }
            thead += '</tr>';

            // footer;
            tfoot = tfoot.length > 0 ? "<tfoot><tr>" + tfoot + "</tr></tfoot>" : "";


            // mulit header
            if (level > 0) {
                var ts = [];
                for (var i = 0; i < level; i++) {
                    var w = 0, txt = undefined;
                    ts[i] = ts[i] || new Array();
                    for (var key in cols) {
                        var obj = cols[key];
                        var g = obj.GroupName || [];
                        var cell = g[i] || '';
                        if (cell != txt && txt != undefined) w++;
                        ts[i][w] = ts[i][w] || new Array();
                        ts[i][w].push(cell);
                        txt = cell;
                    }
                }
                //alert($.toJSON(ts))
                $.each(ts, function(i, arr) {
                    var t = ''; var m = 0;
                    $.each(arr, function(i, o) {
                        var w = 0;
                        for (var n = 0; n < o.length; n++) { w += ws[m]; m++ }
                        var txt = o[0] || '&nbsp;';
                        t += '<td colspan="' + o.length + '" width="' + w + '">' + txt + '</td>';
                    });
                    thead = '<tr>' + t + '</tr>' + thead;
                });
            }
            function getColIndex(key) {
                var i = 0;
                for (var k in cols) {
                    if (key == k)
                        return i;
                    i++;
                }
                return -1;
            }

            //body
            $.each(json.data, function(m, cells) {
                var rowstate = [], row = "";
                var n = 0;
                for (var name in cols) {
                    var col = cols[name.toString()];
                    var txt = cells[n] == "" ? "&nbsp;" : cells[n];
                    row += '<td width="' + col.Width + '">' + txt + '</td>';
                    n++;
                }

                $.each(json.states, function(i, o) {
                    var idx = getColIndex(o.name);
                    if (idx >= 0) {
                        if (cells[idx] == o.value) {
                            rowstate.push(o.cls);
                        }
                    }
                })
                var cls = rowstate.length > 0 ? ' class="' + rowstate.join(' ') + '"' : "";
                tbody += '<tr' + cls + '>' + row + '</tr>';

            });

        }
        return "<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\""
				+ width + "\"><thead>" + thead + "</thead><tbody>"
				+ tbody + "</tbody>" + tfoot + "</table>";
    }


});