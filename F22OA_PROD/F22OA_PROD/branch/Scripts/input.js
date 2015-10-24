/* 二维录入通用脚本 */
/* Author : jackie 2010-05-11 创建 */
//
$(function() {

    $('.x-toolbar :text').focus(function() { this.select() });

    $("form").submit(function() { return false; })
    // events
    $("button").click(function() {
        return false;
    });

    $('button[name="add"]').click(e_add);
    $('button[name="save"]').click(e_save);
    $('button[name="ok"]').click(e_ok);
    $('button[name="delete"]').click(e_delete);

    // hotkeys
    $('#key').bind('keydown', 'return', function() { e_add(); return false; });
    $(document).bind('keydown', 'del', function() { e_delete(1); return false; });
    $(document).bind('keydown', 'ctrl+s', function() { e_save(); return false; });

    // auto height
    $(window).bind("resize", function() {
        var $ms = $("#MySplitter");
        var t = $ms.offset().top;
        var wh = $(window).height();
        var mrg = parseInt($ms.css("marginBottom")) || 0;
        var brd = parseInt($ms.css("borderBottomWidth")) || 0;
        $ms.css("height", (wh - t - mrg - brd) + "px");
        if (!jQuery.browser.msie) {
            $ms.trigger("resize");
        }
    }).trigger("resize");
    //
    $("#MySplitter").splitter({ type: 'v' });
    //
    setTimeout(e_bind, 0);
});


// 表单数据绑定
var e_bind = e_bind || function() {
    var obj = {
        id: $.QueryString().id || ''
    }
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("Get", obj, function(result) {
        var obj = result.d || new Object();
        $('.info').fillFields(obj);
        //alert($.toJSON(obj)); return;
        $('.field[name="depotid"]').val(obj.set_depotid);
        $('.field[name="setdepotid"]').val(obj.get_depotid);
        e_query();
    });
}

// query
var e_query = e_query || function() {
    $("#MySplitter").trigger("resize", [$(window).width()]);
    var obj = $(".field").serializeObject();

    //alert($.toJSON(obj)); return;
    $.ajaxWebService("getList", obj, function(result) {

        $('#queryTable,#detailTable').empty();
        var html = $.json2Table(result.d);
        $('#queryTable').html(html);
        //
        $('#queryTable tbody tr').not(":last").bindRowEvents();
        $('#key').focus();
    });
}
/* 根据款式编号获取一行
----------------------------------------------------------------*/
var e_getrow = e_getrow || function(styleid) {
    var row = null;
    if (styleid) {
        var idx = getColumnIndex('styleid');
        $('#queryTable tbody tr').not(":last").each(function() {
            if ($(this).find('td').eq(idx).text() == styleid) {
                row = $(this);
                return false;
            }
        });
    }
    return row;
}
/* 添加款
----------------------------------------------------------------*/
var e_add = e_add || function() {
    var key = $('#key').val();
    if (!key) { $('#key').focus(); return; }
    key = key.toUpperCase();
    $('#styleid').val(key);
    $('#key').val('').focus();
    var row = e_getrow(key);
    if (row != null) {
        row.click();
        row.find(':text:first').focus();
        return;
    }
    var obj = $(".field").serializeObject();
    obj.boxid = getboxid();

    //alert($.toJSON(obj)); return;

    $.ajaxWebService("Add", obj, function(result) {
        if (result.d.success != 1) { alert(result.d.msg); return; }
        var row = e_addStyleRow(result.d.Style);
        row.click();
        row.find(':text:first').focus();
    });
}


/* 行单击事件
----------------------------------------------------------------*/
var e_rowclick = e_rowclick || function() {
    if ($(this).hasClass('selected')) return;
    if ($('.modify').length > 0) {
        if (confirm('当前编辑中的行存在未保存的数据，确定要取消吗？')) {
            $('.modify').resetValue();
        } else {
            return; //中断
        }
    }
    var id = $(this).find('td').eq(getColumnIndex('styleid')).text();
    id = $.trim(id);
    if (!id) return true;
    $(this).addClass("selected").siblings('tr').removeClass('selected');
    e_showdetail(id);
}

/* 加载并显示明细
----------------------------------------------------------------*/
var e_showdetail = e_showdetail || function(styleid) {
    if (!styleid) return;
    var obj = $(".field").serializeObject();
    obj.styleid = styleid;
    //alert($.toJSON(obj));  return;
    $.ajaxWebService("getDetail", obj, function(result) {
        if (result.d.success != 1) { alert(result.d.msg); return; }
        e_initColorSizeTable(result.d);
    });
}
/* 添加行
----------------------------------------------------------------*/
var e_addStyleRow = e_addStyleRow || function(obj) {
    var row = $('<tr />');
    $('#queryTable thead tr:last td').each(function() {
        var txt = obj[$(this).attr('name')] || '';
        row.append('<td>' + txt + '</td>');
    });
    row.bindRowEvents();
    $('#queryTable tbody tr:last').before(row);
    return row;
}
/* 生成颜色尺码表
----------------------------------------------------------------*/
var e_initColorSizeTable = e_initColorSizeTable || function(o) {

    $('#detailTable').empty();
    var style = o.Style;    //款式表
    var color = o.Color;    //颜色表
    var size = o.Size;      //尺码表
    var clothingnums = o.ClothingNums; //数量表

    var thead = "", tbody = "";
    thead += '<td width="75">颜色\\尺码</td>';
    var width = 75;
    for (var x in size) {
        thead += '<td width="30">' + size[x] + '</td>';
        width += 30;
    }
    thead = '<tr>' + thead + '<td width="40">合计</td></tr>';
    width += 40;

    for (var c in color) {
        var cnt = 0;
        tbody += '<tr><td >' + color[c] + '(' + c + ')</td>';
        for (var x in size) {
            var cid = style.styleid + c + x;
            var v = parseInt(clothingnums[cid]) || '';
            if (v) cnt += v;
            tbody += '<td><input type="text" name="' + cid + '" colorid="' + c + '"  sizeid="' + x + '" maxlength="3" title="' + cid + '" class="editbox" value="' + v + '" defval="' + v + '" /></td>';
        }
        tbody += '<td>' + cnt + '</td></tr>';
    }

    var html = "<table cellspacing=\"1\" cellpadding=\"3\" border=\"0\" class=\"dltab\" width=\"" + width + "\"><thead>" + thead + "</thead><tbody>" + tbody + "</tbody></table>";
    $('#detailTable').html(html);
    $('#detailTable').find(':text')
            .change(txtChange)
            .keydown(txtKeydown)
            .focus(txtFocus)
            .keyfilter(/[\d]/);
    //加数量
    for (var clothingid in clothingnums) {
        $('#detailTable :text[name="' + clothingid + '"]').val(clothingnums[clothingid]);
    }
    //调整大小
    $("#MySplitter").trigger("resize", [$(window).width() - width - 100]);
}
/* 取得指定字段所在位置
----------------------------------------------------------------*/
var e_save = e_save || function() {
    var row = $('#queryTable tbody tr.selected');
    if (row.length == 0) return;
    var obj = $(".field").serializeObject();
    obj.styleid = row.find('td').eq(getColumnIndex('styleid')).text();
    obj.boxid = row.find('td').eq(getColumnIndex('boxid')).text() || '000000';
    obj.s_price = parseFloat(row.find(':text[name="s_price"]').val()) || -1;
    obj.discount = parseFloat(row.find(':text[name="discount"]').val()) || -1;
    obj.clothingnums = new Array();
    $('#detailTable :text').not('[value=""]').each(function() {
        obj.clothingnums.push({
            clothingid: $(this).attr('name'),
            colorid: $(this).attr('colorid'),
            sizeid: $(this).attr('sizeid'),
            nums: $(this).val()
        });
    });
    //alert($.toJSON(obj)); return;
    $.ajaxWebService("Save", obj, function(result) {
        if (result.d.success != 1) { alert(result.d.msg); return; }
        e_query();
    });
}
/* 关闭
----------------------------------------------------------------*/
var e_ok = e_ok || function() {
    window.returnValue = true;
    window.close();
}
/* 删除 
----------------------------------------------------------------*/
var e_delete = e_delete || function() {
    var row = $('#queryTable tbody tr.selected');
    if (row.length == 0) return;
    if (!confirm('确定要删除吗？')) return;
    var obj = $(".field").serializeObject();

    obj.styleid = row.find('td').eq(getColumnIndex('styleid')).text();
    obj.boxid = row.find('td').eq(getColumnIndex('boxid')).text();

    //alert($.toJSON(obj)); return;

    $.ajaxWebService("Delete", obj, function(result) {
        if (result.d.success != 1) { alert(result.d.msg); return; }
        e_query();
    });
}

/* 数量已更改 
----------------------------------------------------------------*/
var e_numschange = e_numschange || function(t) {
    return true;
}

/* 明细值更改 
----------------------------------------------------------------*/
var e_stylechange = e_stylechange || function(t) {
    var row = t.parents('tr');
    var obj = e_getrowdata(row);
    if (t.attr('name') == 'discount') {
        if (parseFloat(obj.discount) > 1) {
            alert('折扣必须小于或等于1.000000！');
            return false;
        }
        obj.s_price = (obj.x_price * obj.discount).toFixed(2);
        obj.xpricesums = (obj.nums * obj.x_price).toFixed(2);
        obj.sums = (obj.nums * obj.s_price).toFixed(2);
    } else if (t.attr('name') == 's_price') {
        if (parseFloat(obj.s_price) > parseFloat(obj.x_price)) {
            alert('结算价不能大于现价！');
            return false;
        }
        obj.discount = ((parseFloat(obj.s_price) || 0) / (parseFloat(obj.x_price) || 0)).toFixed(6);
        obj.xpricesums = (obj.nums * obj.x_price).toFixed(2);
        obj.sums = (obj.nums * obj.s_price).toFixed(2);
    } else {
        return true;
    }
    //alert($.toJSON(obj));
    e_setrowdata(row, obj);
    return true;
}
/* 获取一个新的序号
----------------------------------------------------------------*/
function getboxid() {
    var rows = $('#queryTable tbody tr').not(':last');
    var maxid = 0;
    if (rows.length > 0) {
        var idx = getColumnIndex('boxid');
        maxid = rows.last().find('td').eq(idx).text();
        maxid = $.string2int(maxid);
    }
    return 'W' + $.padLeft(maxid + 1, 5);
}
/* 返回行数据 
----------------------------------------------------------------*/
function e_getrowdata(row) {
    row = row || $('#queryTable tbody tr.selected');
    var obj = {};

    $('#queryTable thead tr:last td').each(function(i) {
        var name = $(this).attr('name');
        if (!name) return true;
        var cell = row.find('td').eq(i);
        if (cell.find(':text').length > 0) {
            obj[name] = cell.find(':text').val();
        } else {
            obj[name] = cell.text();
        }
    });

    obj.s_price = parseFloat(obj.s_price) || 0;
    obj.x_price = parseFloat(obj.x_price) || 0;
    obj.nums = parseFloat(obj.nums) || 0;
    obj.xpricesums = parseFloat(obj.xpricesums) || 0;
    obj.sums = parseFloat(obj.sums) || 0;

    return obj;
}
/* 更新行的值 
----------------------------------------------------------------*/
function e_setrowdata(row, obj) {
    var head = $('#queryTable thead tr:last td');
    for (var key in obj) {
        var idx = getColumnIndex(key);
        if (idx >= 0) {
            var cell = row.find('td').eq(idx);
            if (cell.find(':text').length > 0) {
                cell.find(':text').val(obj[key]).attr('oldval', obj[key]);
            } else {
                cell.text(obj[key]);
            }
        }
    }
}
/* 根据字段名称获取单元格对象
----------------------------------------------------------------*/
function getCellObject(name, row) {
    row = row || $('#queryTable tbody tr.selected');
    var i = getColumnIndex(name);
    if (i == -1) return null;
    return row.find('td').eq(i);
}
/* 取得指定字段所在位置
----------------------------------------------------------------*/
function getColumnIndex(fieldname) {
    var h = $('#queryTable thead tr:last');
    return h.find('td').index(h.find('td[name="' + fieldname + '"]'));
}

/* 键盘事件
----------------------------------------------------------------*/
var pos = -1;
function txtKeydown(e) {
    var key = window.event ? e.keyCode : e.which;
    if (key == 38) {
        JumpToBox('up', this);
        return false;
    } else if (key == 40) {
        JumpToBox('down', this);
        return false;
    } else if (key == 37) {
        JumpToBox('prev', this);
        return false;
    } else if (key == 13 || key == 39) {
        JumpToBox('next', this);
        return false;
    }
}
function txtFocus(e) {
    $(this).select();
    pos = $('#detailTable input').index($(this));
}
function txtChange() {

    // 与默认值对比
    var defval = $(this).attr('defval') || '';
    var oldval = $(this).attr('oldval') || defval;
    if (defval != $(this).val()) {
        $(this).addClass('modify');
    } else {
        $(this).removeClass('modify');
    }
    // 与上一次修改的值对比

    if (oldval != $(this).val()) {
        var fn = null;
        var t = $(this);
        //验证
        fn = t.parents('#LeftPane').length > 0 ? e_stylechange : e_numschange;
        if (fn(t)) {
            t.attr('oldval', t.val());
        } else {
            t.val(oldval);
            t.focus();
        }

    }
}
function JumpToBox(act, txtbox) {
    var tab = $(txtbox).parents('table:first');
    if (!tab) return;
    var ts = tab.find('input');
    var rl = tab.find('tbody tr:first input').length;    /* 列数 */
    var np = -1;
    switch (act) {
        case 'up': np = pos - rl; break;
        case 'down': np = pos + rl; break;
        case 'prev': np = pos - 1; break;
        case 'next': np = pos + 1; break;
    }
    if (np == ts.length) { np = 0; }
    if (np >= 0 && np < ts.length) { ts.eq(np).focus(); pos = np; }
    if (!$.browser.msie) { $(txtbox).change(); }
}

//添加行事件
$.fn.extend({
    bindRowEvents: function() {
        var rows = $(this);
        rows.hover(function() { $(this).addClass('hover') }, function() { $(this).removeClass('hover') }).click(e_rowclick);
        // maske editor
        $('#queryTable thead td[allowedit="true"]').each(function() {
            var name = $(this).attr('name');
            var ft = $(this).attr('fieldtype');
            var idx = getColumnIndex(name);
            var ipt = $('<input type="text" name="' + name + '" class="editbox" />');

            rows.each(function() {
                var cell = $(this).find('td').eq(idx);
                var nipt = ipt.clone().attr({ 'value': cell.text(), 'defval': cell.text() })
                .bind('focus', function() { $(this).select(); })
                .bind('change', txtChange)
                .bind('keydown', function(e) {
                    var key = window.event ? e.keyCode : e.which;
                    if (key == 13) {
                        $('#detailTable :text:first').focus();
                        //if (!$.browser.msie || ($.browser.msie && (parseFloat($.browser.version) || 0) < 7)) { nipt.change(); }
                        nipt.change();
                        return false;
                    }
                });

                if (ft == 0) {
                    // 0 为文本型，不用控制
                } else if (ft == 1) {
                    nipt.keyfilter(/[\d\.]/);
                }
                cell.empty().append(nipt);
            });
        });
        return rows;
    },
    resetValue: function() {
        $(this).each(function() {
            var v = $(this).attr('defval') || '';
            $(this).val(v);
        });
    }
})