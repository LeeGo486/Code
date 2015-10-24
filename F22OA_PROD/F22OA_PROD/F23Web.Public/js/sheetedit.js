
/// <reference path="/Public/jquery-1.4.2.min.js" />

var barcodeurl = barcodeurl || "barcode.aspx";  //条码录入
var detailurl = detailurl || "detail.aspx";     //显示明细
var sediturl = sediturl || "sheetedit.aspx";     //发货差异单编辑页
var txtimporturl = txtimporturl || "/public/txtimport.aspx"; //盘点机导入
var xlsimporturl = xlsimporturl || "/public/xlsimport.aspx"; //xls导入
var boximporturl = boximporturl || "/public/boximport.aspx"; //录入装箱
var importtype = importtype || "inventory"; //导入单据类型
var importtarget = importtarget || "1"; // //导入目标　0:总部 1：分支机构
var importreprice = importreprice || true; // //导入时是否刷新价格 
var readonly = readonly || false;   //编辑界面只读
var stygridreadonly = stygridreadonly || false;   //款式界面只读,以控制根据参照单生成的单据，不能进行款式新增、编辑、删除
var tempsure = tempsure || "true"; //是否需要执行更新临时标识
var keys;
var i = 0;
var currentAjax, currentRow, isEditModel, isNewSheet, isSaveing;
var ColorSizeGrid = null, StyleGrid = null,ColorSizeGrid1 = null;
// 返回对象
window.returnValue = { success: 0, obj: null };


//
$(function () {
    $('form').bind('submit', function () { return false; }); //去掉表单事件
    $('form').bind('reset', function () { return false; }); //去掉表单事件
    $(':text').bind('focus', function () { this.select(); });
    $('.field', '.container')
	.bind('keydown', 'return', function (e) {
	    var s = false; var t = this;
	    if ($(this).hasClass('required') && $(this).val() == "") return false;
	    $(':text,:radio,:checkbox,select,button', '.container').each(function (i, obj) {
	        if ($(obj).is('[readonly],[disabled]')) { return true; }
	        var expr = ':radio[name=' + $(t).attr('name') + ']';
	        if (s == true && !$(obj).is(expr)) {
	            $(this).focus(); return false;
	        }
	        if (t == obj) { s = true; }
	    });
	    return false;
	});

    $(document).bind('keydown', 'ctrl+del', deletestyle);
    $(document).bind('keydown', 'ctrl+h', findstyle);
    $(document).bind('keydown', 'ctrl+s', function () { $('.inputbox').focus(); return false; });
    //
    $('#sheetid').val($.QueryString().id || '');
    //
    e_bind();
    e_query();
});
/* ====================================================== */
/*                         表单事件                       */
/* ====================================================== */
// 显示明细
var e_detail = e_detail || function () {
    var id = $('#sheetid').val()
    if (!id) return;
    $.openModal(detailurl + '?id=' + id, '90%', '70%');
}

// 条码录入
var e_barcode = e_barcode || function () {
    var id = $('#sheetid').val()
    if (!id) return;
    var noticeid = $('#noticeid').val() || '';
    t_barcode(barcodeurl + '?id=' + id + '&noticeid=' + noticeid);  //带参照单号

}
// 条码录入
var t_barcode = t_barcode || function (url) {
    savesheet(function () {
        var m = $.openModal(url, '800px', '450px');
        if (m) { e_query(); }
    });
}

//盘点机导入
var e_importtxt = e_importtxt || function () {
    var id = $('#sheetid').val()
    if (!id) return;
    savesheet(function () {
        var m = $.openModal(txtimporturl + '?id=' + id + "&importtype=" + importtype + "&importtarget=" + importtarget + "&importreprice=" + importreprice, '500px', '500px');
        if (m) { e_query(); }
    });
}
// stylegrid query
var e_query = e_query || function () {
    setTimeout(function () {
        currentRow = null;
        if (ColorSizeGrid) { ColorSizeGrid.fnClearTable(); }
        if (ColorSizeGrid1) { ColorSizeGrid1.fnClearTable(); }
        if (StyleGrid) { StyleGrid.fnReloadAjax(); }
    }, 0);
}

//xls导入
var e_importxls = e_importxls || function () {
    var id = $('#sheetid').val()
    if (!id) return;
    savesheet(function () {
        var m = $.openModal(xlsimporturl + '?id=' + id + "&importtype=" + importtype + "&importtarget=" + importtarget + "&importreprice=" + importreprice, '750px', '500px');
        if (m) { e_query(); }
    });
}

//录入装箱
var e_importbox = e_importbox || function () {

    var dptid = $("#getdepotid").val();
    var dptname =escape($("#getdepotid_label").text());
    var id = $('#sheetid').val()
    if (!id) return;
    savesheet(function () {
        var m = $.openModal(boximporturl + '?id=' + id + "&importtype=d_outindentpro&dptid=" + dptid + "&dptname=" + dptname, '975px', '653px');
         if (m) { e_query(); }
    });
}

function MakeNewSheet(b) {
    isNewSheet = b;
    if (b) {
        $('.st_field').addClass('disabled');
    } else {
        $('.st_field').removeClass('disabled');
    }
}

// 表单数据绑定
var e_bind = e_bind || function () {
    var obj = { id: $.QueryString().id || '' };
    if (!obj.id) MakeNewSheet(true);

    $.ajaxWebService("Get", obj, function (result) {
        result = result.d || new Object();
        if (result.success > 0) {
            ajax_success(result.obj);
            $('.field').fillFields(result.obj);
            $('button:submit').removeAttr('disabled');
            $('.field').not(':hidden,[disabled],[readonly]').eq(0).trigger('focus');
        } else {
            alert(result.msg);
            window.close();
        }
    }, { beforeSend: ajax_beforeSend, complete: ajax_complete });
}

// 表单加载前
var ajax_beforeSend = ajax_beforeSend || function () { }
// 表单加载完成
var ajax_complete = ajax_complete || function () { }
// 加载成功
var ajax_success = ajax_success || function () { }

// 保存
var e_save = e_save || function () {
    if ($(this).hasClass('disabled')) return;
    if (!confirm('保存为草稿单时并没有“提交”到下一步处理。\n您确定要执行此操作吗？')) return;
    if (isEditModel) //明细未保存，先保存明细
    {
        savestyle(function () { savesheet(e_close); })
    } else {
        savesheet(e_close);
    }
    return false;
}

// 保存
var savesheet = savesheet || function (callback) {
    if (readonly) { if (typeof callback == 'function') { callback(); } return; }
    var obj = $(".field").serializeObject();
    if (!e_chkform(obj)) return;
    var data = { obj: obj }
    $.ajaxWebService("Save", data, function (result) {
        //
        var o = result.d || new Object();
        //
        window.returnValue = o;
        if (o.success > 0) {
            //
            MakeNewSheet(false);

            // set importtarget
            if ($('#m_type').size()) {
                importtarget = $.inArray(parseInt($('#m_type').val()), [0, 1]) == -1 ? 1 : 0;
            }

            //
            if (isEditModel) {
                savestyle(callback); //子表未保存，同时保存子表
            } else if (typeof callback == 'function') {
                callback.call(this, o.obj);
            }
        } else {
            alert(o.msg);
        }
    }, {
        beforeSend: function () {
            $('#btnsave').addClass('disabled');
        },
        complete: function () {
            $('#btnsave').removeClass('disabled');
        }
    });
    return false;
}

// 单据操作
var e_sure = e_sure || function () {
    if ($(this).hasClass('disabled')) return;
    if (isEditModel) {
        savestyle(function () { savesheet(t_sure); })
        return;
    } else {
        savesheet(t_sure);
        return;
    }
    return false;
}

// 执行提交操作
var t_sure = t_sure || function () {
    $("#sheetid").focus();
    setTimeout(exec_sure, 300);
}

//手工输入导致从任意仓库发货，所以增加此步
var exec_sure = exec_sure || function () {
    
    var obj = $(".field").serializeObject();
    if (!e_chkform(obj)) return;

    var id = $('#sheetid').val()
    if (!id) return;
    $.doOperation("Sure", id, tempsure, function (obj) {
        window.returnValue.success = 2;
        window.close();
    });
}

// 删除
var e_delete = e_delete || function () {
    var id = $('#sheetid').val()
    if (!id) return;
    if ($(this).hasClass('disabled')) return;
    if (!confirm('确定要删除此单据吗？')) return;
    $.ajaxWebService("Delete", { id: id }, function (result) {
        var m = result.d || new Object();
        if (m.success == 1) {
            window.returnValue.success = 3;
            window.close();
        } else {
            alert(m.msg);
        }
    });
}
//关闭窗口
var e_close = e_close || function () {
    window.close();
    return false;
}

// 表单验证
var e_chkform = e_chkform || function () {
    var b = true;
    //    $('.required').each(function() {
    //        var v = $(this).val();
    //        if (!$.trim(v)) { 
    //            alert( v)
    //        }
    //    });
    return b;
}

// 取得列的ID（第一列）
var GetRowId = GetRowId || function (row) {
    var v = $("td", row).eq(0).text();
    v = $.trim(v);
    v = v.toUpperCase();
    return v;
}

/* ====================================================== */
/*                       款添加及验证                     */
/* ====================================================== */

// stylegrid加载完毕后添加验证行
var stylegrid_ajaxcomplete = stylegrid_ajaxcomplete || function () {
    window.setTimeout(InitInputRow, 0);
}
// 初始化录入行
var InitInputRow = InitInputRow || function () {

    if (readonly) { return; }
    if (stygridreadonly) { return; }
    var d = ['<input type="text" class="inputbox" />', '', 0, 0, 0, '', 0, 0, '', '', '', '', '', ''];
    var i = StyleGrid.fnAddData(d);
    var cells = $('td', StyleGrid.fnGetNodes()[i]);

    if (!readonly) {
        cells.eq(0).addClass('edit').siblings().removeClass('edit'); //.attr('colspan', cells.size()).nextAll().hide();
        var input = cells.eq(0).find('input').css('ime-mode', 'disabled');
        input
        .bind('keydown', 'return', function () {
            var v = $(this).val();
            v = $.trim(v).toUpperCase();
            if (!v) return;
            $(this).val('');
            ValidInputRow(v);
            return false;
        })
        .bind('focus', function () {
            this.select();
            $('.dataTables_scrollBody:first,.dataTables_scrollHead:first').scrollLeft(0);
        })
        .bind('keydown', 'ctrl+s', savesheet)
        .bind('keydown', 'ctrl+h', findstyle)
        .bind('keydown', 'ctrl+return', e_sure)
        .bind('keydown', 'ctrl+del', deletestyle);
    }
}

// 验证录入内容
// 2010-09-02 liangyu modify
// 2011-03-31 wzj 增加传收货店铺编号
var ValidInputRow = ValidInputRow || function (v) {
    var rows = StyleGrid.fnGetNodes();
    var row = null;
    $.each(rows, function (i, o) {
        var styleid = GetRowId(o);
        if (styleid == v) {
            row = o;
            return false;
        }
    });
    if (isEditModel) { savestyle(); } // 先处理当前未保存的数据
    if (row) // is exists
    {
        LoadColorSize(row);
    }
    else // start validate
    {
        var data = $(".field").serializeObject();

        // add by jackie 根据 m_type 判断是否向总部操作（取价格使用用）
        var dtype = 1;
        if ($('#m_type').size()) {
            dtype = $.inArray(parseInt($('#m_type').val()), [0, 1]) == -1 ? 3 : 2;
        }
        $.extend(data, { styleid: v, dtype: dtype, getdepotid: $("#getdepotid").val() });

        $.ajaxWebService('ValidateStyle', data, function (result) {
            result = result.d || {};
            if (result.success > 0) {
                UpdateInputRow(result.obj);
            } else {
                alert(result.msg);
            }
        });
    }
    return false;
}
// 更新录入行数据（将返回数据更新到添加列，并创初始化的录入行（InputRow））
var UpdateInputRow = UpdateInputRow || function (obj) {
    //
    var _d = [];
    $.each(StyleGrid.fnSettings().aoColumns, function (i, o) {
        var _o = obj[o.sName];
        _o = _o == null ? '' : _o == undefined ? '' : _o;
        _d.push(_o.toString());
    });
    var boxid = GetNewBoxId(); //最后一个是boxid;
    _d[_d.length - 1] = boxid;
    var rows = StyleGrid.fnGetNodes();
    var i = rows.length - 1;
    var cell = $('td', rows[i]).eq(0);
    cell.attr('colspan', '1').removeClass('edit').find('input').unbind('keydown', 'return').remove();
    cell.text(v); //.nextAll().show();
    StyleGrid.fnDeleteRow(i);
    i = StyleGrid.fnAddData(_d);
    LoadColorSize(StyleGrid.fnGetNodes()[i]);
    InitInputRow();
}

// 获取最新序号
var GetNewBoxId = GetNewBoxId || function () {
    var maxid = 0;
    var rows = StyleGrid.fnGetNodes();
    $.each(rows, function (i, row) {
        var m = $.string2int($('td', row).last().text());
        maxid = maxid > m ? maxid : m;
    });
    return 'W' + $.padLeft(maxid + 1, 7);
}

/* ====================================================== */
/*                       颜色尺码加载                     */
/* ====================================================== */

// 获取子表数据
var LoadColorSize = LoadColorSize || function (row) {
    var rows = StyleGrid.fnGetNodes();
    $(rows).removeClass('row_selected');
    $(row).addClass('row_selected');
    LoadSubGrid(row);

}

// 加载指定行颜色尺码
var LoadSubGrid = LoadSubGrid || function (row) {
    var styleid = GetRowId(row);
    if (!styleid) { return; }
    if (currentRow == row) { CurrentRowFocus(); return; }
    var data = { id: $('#sheetid').val(), styleid: styleid };
    if (currentAjax) { currentAjax.abort(); currentAjax = null; } //中断上一次的请求
    currentAjax = $.ajaxWebService('GetColorSizeNums', data, function (result) {
        InitColorSizeGrid(result.d);
        currentRow = row;   //当前行
        currentAjax = null;
        CurrentRowFocus();
        InitOtherGrid(styleid); //其它grid显示
    });
}

//其它grid显示
var InitOtherGrid = InitOtherGrid || function (styleid) {
    //$("#divOtherGrid").empty();
   // $("#divOtherGrid").append("<a>"+styleid+"</a>");     
}


var st = null
var CurrentRowFocus = CurrentRowFocus || function () {
    if (st) window.clearTimeout(st);
    st = window.setTimeout(function () {
        if ($('input:first', currentRow).hasClass('text')) {
            $('input:first', ColorSizeGrid).focus();
        } else {
            $('input:first', currentRow).focus();
        }
    }, 100)
}

//
var InitColorSizeGrid = InitColorSizeGrid || function (data) {

    var settings = fnGetDefaultSettings();
    $.extend(settings, data);
    if (!data.sColumns) return;   //没有可显示的列
    settings.aoColumns = [];

    var cols = data.sColumns.split(',');
    $.each(cols, function (i, o) {
        if (i == 0)
            settings.aoColumns.push({ "sTitle": "色码", "sName": o, "sWidth": "50px" });
        else if (i == 1)
            settings.aoColumns.push({ "sTitle": "色名", "sName": o, "sWidth": "80px" });
        else if (i == cols.length - 1)
            settings.aoColumns.push({ "sTitle": "合计", "sName": '', "sWidth": "50px", 'fnRender': totalRender });
        else
            settings.aoColumns.push({ "sTitle": o, "sName": o, "sWidth": "40px", "sClass": readonly ? "" : "edit", 'fnRender': numsRender });
    });

    $.extend(settings, {
        "sScrollY": '45%',
        "sScrollX": '100%',
        "iBottomHeight": '0',
        "bAutoWidth": true,
        "fnDrawCallback": CurrentRowFocus,
        "fnInitComplete": ColorSizeGridInitComplete,
        "sScrollXInner": (settings.aoColumns.length * 40 + 60) + 'px'
    });

    if (!ColorSizeGrid) {
        $('#ColorSizePanel').append('<table cellpadding="0" cellspacing="0" border="0" class="display" id="ColorSizeGrid"></table>');
        ColorSizeGrid = $('#ColorSizeGrid').dataTable(settings);
        ColorSizeGrid.fnAdjustColumnSizing();
        $(window).bind('resize', function () {
            ColorSizeGrid.AdjustScrollLayout();
        }); //.trigger('resize');
        ColorSizeGrid.AdjustScrollLayout();
    } else {
        ColorSizeGrid.fnClearTable()
        ColorSizeGrid.fnDestroy()
        ColorSizeGrid.empty();
        ColorSizeGrid.dataTable(settings);
        ColorSizeGrid.fnAdjustColumnSizing();
        ColorSizeGrid.AdjustScrollLayout();

    }
    setTimeout(function () {
        $('#loadingPanel', '#ColorSizePanel').hide();
    }, 0);
}

/* ====================================================== */
/*                       明细保存                         */
/* ====================================================== */

var savestyle = savestyle || function (callback) {
    if (currentAjax) { return; } //加载中,不执行保存
    if (!currentRow) { return; }
    if (isNewSheet) { savesheet(callback); return; } //先保存主表
    if (!isEditModel) { $('.inputbox').focus(); return; } //无更改
    var nBoxs = $('td.modify', ColorSizeGrid);
    var d = GetStyleGridDate(currentRow);
    var obj = { id: $('#sheetid').val() }
    $.each(StyleGrid.fnSettings().aoColumns, function (i, o) {
        if (o.sName) { obj[o.sName] = d[i]; }
    });

    var clothings = [];
    var iTotal = 0; //

    $('input:text', ColorSizeGrid).each(function (i, o) {
        var nums = $(this).val();
        if (nums != "") {
            nums = nums * 1 || 0;
            var colorid = $(this).attr('colorid');
            var sizeid = $(this).attr('sizeid');
            var clothingid = obj.styleid + '' + colorid + '' + sizeid; // as string
            clothings.push({
                clothingid: clothingid,
                colorid: colorid,
                sizeid: sizeid,
                nums: nums
            });
            iTotal += nums;
        }
    });

    // 至少保存一个款 add by jackie 20101209;
    if (clothings.length == 0) {
        var firstipt = $('input:text', ColorSizeGrid).first();
        var colorid = firstipt.attr('colorid');
        var sizeid = firstipt.attr('sizeid');
        var clothingid = obj.styleid + '' + colorid + '' + sizeid; // as string
        clothings.push({
            clothingid: clothingid,
            colorid: colorid,
            sizeid: sizeid,
            nums: 0
        });
    }
    // submit data;
    var data = { obj: obj, clothings: clothings };

    //alert($.toJSON(obj));

    $.ajaxWebService('SaveColorSizeNums', data, function (result) {
        result = result.d || {};
        if (result.success > 0) {
            //
            isEditModel = false;
            /// 
            UpdateStyleGridRow(iTotal, StyleGrid.fnGetPosition(currentRow), 7, function (data) {
                $('td.modify', currentRow).removeClass('modify');
                $('td.modify', ColorSizeGrid).removeClass('modify');
                if (typeof callback == 'function') {
                    (callback)(result.obj, data);
                }
            }); //change Total and Update Row;

        } else {
            alert(result.msg);
        }

    });
    return false;
}

//查找款式
var findstyle = findstyle || function () {
    var m = $.openModal('/public/findstyle.aspx', '650px', '360px');
    if(m != null){ 
        $('.inputbox').val(m[0]);
        $('.inputbox').focus();
    }
    return false;
}
// 删除记录
var deletestyle = deletestyle || function () {
    if (readonly || stygridreadonly) { return; } //
    if (currentAjax) { return; } //加载中,不执行保存
    if (!currentRow) { return; }
    var styleid = GetRowId(currentRow);
    if (!styleid) return; //新增行
    if (!confirm('确定要删除吗？')) return;
    var d = GetStyleGridDate(currentRow);
    if (!d) return;
    var n = d[7];  //已保存数量为0需要到数据库删除
    if (n) {
        var obj = { id: $('#sheetid').val(), styleid: styleid }
        $.ajaxWebService('DeleteSub', obj, function (result) {
            result = result.d || {};
            if (result.success > 0) {
                //$(currentRow).prev().click();
                StyleGrid.fnDeleteRow(currentRow);
                currentRow = null;
                ColorSizeGrid.fnClearTable();
                if (ColorSizeGrid1) { ColorSizeGrid1.fnClearTable(); }
                isEditModel = false;
                $('.inputbox').focus();
            } else {
                alert(result.msg);
            }
        });
    } else {
        //var row = $(currentRow).prev();
        StyleGrid.fnDeleteRow(currentRow);
        currentRow = null;
        ColorSizeGrid.fnClearTable();
        if (ColorSizeGrid1) { ColorSizeGrid1.fnClearTable(); }
        isEditModel = false;
        $('.inputbox').focus();
    }
    return false;
}

/* ====================================================== */
/*                       GRID 渲染器                     */
/* ====================================================== */

var spriceRender = spriceRender || function (obj) {
    var data = ConvertToGridDataFormat(obj.aData);
    var v = ((Math.round(data[obj.iDataColumn] * 100) / 100) || 0).toString();
    if (readonly || stygridreadonly) {
        return v;
    } else {
        return obj.aData[obj.aData.length - 1] ? '<input type="text" class="edit numeric" irow="' + obj.iDataRow
                + '"  icol="' + obj.iDataColumn + '" value="' + v + '" defval="' + v
                + '" lastval="' + v + '"  minval="0" maxval="' + obj.aData[4] + '"  nullval="0"/>' : '';
    }
}

var discountRender = discountRender || function (obj) {
    var data = ConvertToGridDataFormat(obj.aData);
    var d = ((Math.round(data[obj.iDataColumn] * 100000) / 100000) || 0).toString();
    if (readonly || stygridreadonly) {
        return d;
    } else {
        return obj.aData[obj.aData.length - 1] ? '<input type="text" class="edit numeric" irow="' + obj.iDataRow
                + '"  icol="' + obj.iDataColumn + '"  value="' + d + '"  defval="' + d
                + '" lastval="' + d + '" minval="0" maxval="1"  nullval="0"/>' : '';
    }
}

var commentRender = commentRender || function (obj) {
    var d = obj.aData[obj.iDataColumn] || $(obj.aData[obj.iDataColumn]).val() || '';
    if (readonly) {
        return d;
    } else {
        return obj.aData[obj.aData.length - 1] ? '<input type="text" class="edit text"  irow="' + obj.iDataRow
        + '"  icol="' + obj.iDataColumn + '"  value="' + d + '" defval="' + d
        + '" lastval="' + d + '"  nullval="" />' : '';
    }
}

var sumsRender = sumsRender || function (obj) {
    var i = obj.iDataColumn;
    if (i == 11)  //结算金额 
    {
        var d = parseFloat(obj.aData[5]) || $(obj.aData[5]).val() || 0; //折扣
        var s = parseFloat(obj.aData[6]) || $(obj.aData[6]).val() || 0; //结算价
        v = (parseFloat(obj.aData[7]) || 0) * s;
    } else {
        v = (parseFloat(obj.aData[i - 6]) || 0) * (parseFloat(obj.aData[7]) || 0);
    }

    return (Math.round(v * 100) / 100).toString();
}

var priceRender = priceRender || function (obj) {
    return (Math.round(obj.aData[obj.iDataColumn] * 100) / 100).toString();
}

//数量渲染（加文本框 ）
var numsRender = numsRender || function (obj) {
    var d = obj.aData[obj.iDataColumn];
    if (readonly) {
        return d;
    } else {

        return '<input type="text" class="edit integer" colorid="' + obj.aData[0]
            + '" sizeid="' + obj.oSettings.aoColumns[obj.iDataColumn].sName
            + '" value="' + d + '"  defval="' + d + '" lastval="' + d + '" minval="0" maxval="9999"  nullval=""/>';
    }
}

//数量行合计
var totalRender = totalRender || function (obj) {
    var v = 0;
    for (var i = 0; i < obj.aData.length; i++) {
        if (i >= 2 && i < obj.aData.length - 1) {
            v += (parseFloat($(obj.aData[i]).val()) || 0);
        }
    }
    return v.toString();
}

/* ====================================================== */
/*                       GRID 其它事件                      */
/* ====================================================== */

// 更新行的数据
var UpdateStyleGridRow = UpdateStyleGridRow || function (str, irow, icol, fnCallback) {
    var row = StyleGrid.fnGetNodes()[irow];
    if (!row) { return; }
    var data = GetStyleGridDate(row);
    data[icol] = str.toString();
    if (icol == 5) {
        data[6] = ((Math.round(data[4] * data[5] * 100) / 100) || 0).toString();
    } else if (icol == 6) {
        if (data[4]!=0)
        data[5] = ((Math.round(data[6] / data[4] * 100000) / 100000) || 0).toString();
    }
    StyleGrid.fnUpdate(data, irow);

    if (fnCallback) {
        fnCallback(data);
    }
}

// 取数据
var GetStyleGridDate = GetStyleGridDate || function (row) {
    var data = StyleGrid.fnGetData(row);
    return ConvertToGridDataFormat(data);
}

// 数据转换
var ConvertToGridDataFormat = ConvertToGridDataFormat || function (data) {
    var nd = [];
    $.each(data, function (i, s) {
        s = $(s).is('input') ? $(s).val() : s;
        nd.push(s);
    });
    return nd;
}

var st1 = null;
var StyleGridInitComplete = StyleGridInitComplete || function () {
    var that = this;
    that.fnAdjustColumnSizing();
    $(window).bind('resize', function () {
        if (st1) window.clearTimeout(st1);
        st1 = window.setTimeout(function () {
            that.AdjustScrollLayout();
        }, 100);
    }).trigger('resize');

    //
    $('#StyleGridPanel').append('<div class="bluepanel"><span class="x-icon icon-info">' +
    '快捷键：删除[Ctrl+Del]、刷新单价[Ctrl+Y]、查找[Ctrl+H]</span></div>');

    $('#ColorSizePanel').after('<div class="bluepanel" id="ColorSizeTips" style="display:none;position:fixed;bottom:5px;"><span class="x-icon icon-info">' +
    '快捷键：保存[Ctrl+S]、填行[Ctrl+L]、填列[Ctrl+U]、全填[Ctrl+D]</span></div>');
    $('#ColorSizePanel').after('<div id="divOtherGrid"></div>');

    // loading mask
    $('#ColorSizePanel').append('<div id="loadingPanel" style="display:none;">正在加载...</div>');

}

// timer
var LoadSubGridTimer = null;

// 左表加载完成
var StyleGridDrawCallback = StyleGridDrawCallback || function () {
    var that = this;
    //if (!isEditModel) { $('.inputbox').focus(); }
    $('tbody tr', that).unbind('click').bind('click', function () {
        var _this = this;
        if (!GetRowId(this) || currentRow == this) { return; }
        if (isEditModel) { savestyle(); }
        $(this).addClass('row_selected').siblings().removeClass('row_selected');

        $('#loadingPanel', '#ColorSizePanel').show();

        // 增加延时处理，防止操作过于频繁引起的左右数据不对应情况 by jackie 20110509
        if (LoadSubGridTimer) {
            window.clearTimeout(LoadSubGridTimer);
            LoadSubGridTimer = null;
        }
        // new timer
        LoadSubGridTimer = window.setTimeout(function () {
            LoadSubGrid(_this);
        }, 500);

    });
    var size = $('tbody tr:first input.edit', that).size();
    var ipts = $('input.edit', this)
        .unbind('update').bind('update', function () {
            var irow = $(this).attr('irow');
            var icol = $(this).attr('icol');
            UpdateStyleGridRow($(this).val(), irow, icol);

        });
    inputHandler(ipts, size, StyleGrid);
}

var ColorSizeGridInitComplete = ColorSizeGridInitComplete || function () {

    var size = $('tbody tr:first input.integer', this).size();
    var ipts = $('input.integer', this)
    inputHandler(ipts, size, this);
    $('#ColorSizeTips').show();
}

var inputHandler = inputHandler || function (ipts, size, that) {

    //unbinds..
    ipts.unbind('focus').unbind('blur').unbind('keydown');

    //mask;
    $.each(ipts, function (i, o) {
        if ($(this).hasClass('integer')) {
            $(this).numeric({ allow: '-' }).css('ime-mode', 'disabled')
            .bind('keydown', 'ctrl+d', function () {
                $('input.integer', ColorSizeGrid).val(($(this).val() || ''));
                isEditModel = true;
                return false;
            })
            .bind('keydown', 'ctrl+u', function () {
                var sizeid = $(this).attr('sizeid');
                $('input.integer[sizeid="' + sizeid + '"]', ColorSizeGrid).val(($(this).val() || ''));
                isEditModel = true;
                return false;
            })
            .bind('keydown', 'ctrl+l', function () {
                var colorid = $(this).attr('colorid');
                $('input.integer[colorid="' + colorid + '"]', ColorSizeGrid).val(($(this).val() || ''));
                isEditModel = true;
                return false;
            })
            .bind('keydown', 'ctrl+s', function () {
                savestyle(function () { $('.inputbox').focus(); })
                return false;
            })
            .bind('keydown', 'ctrl+del', deletestyle);

        } else if ($(this).hasClass('numeric')) {
            $(this).numeric({ allow: '.' }).css('ime-mode', 'disabled')
            .bind('keydown', 'ctrl+del', deletestyle)
            .bind('keydown', 'return', function () {
                setTimeout(function () {
                    $('input:first', ColorSizeGrid).focus();
                }, 0);
                return false;
            });
        } else if ($(this).hasClass('text')) {
            $(this).bind('keydown', 'ctrl+del', deletestyle)
            .bind('keydown', 'return', function () {
                $('.dataTables_scrollBody:first,.dataTables_scrollHead:first').scrollLeft(0);
                setTimeout(function () {
                    $('input:first', ColorSizeGrid).focus();
                }, 0);
                return false;
            });
        }
    })
    //binds..
    ipts.bind('focus', function () { this.select(); })
        .bind('blur', function () {
            var isChange = false;
            var v = $(this).val();
            var defval = parseFloat($(this).attr('defval'));
            var maxval = $(this).attr('maxval');
            var minval = $(this).attr('minval');
            var lastval = $(this).attr('lastval');
            var nullval = $(this).attr('nullval');  //当结果为空或0时替换此值
            // 根据类型不同处理
            if ($(this).hasClass('numeric')) {
                v = parseFloat(v) || 0;
                minval = parseFloat(minval) || 0;
                maxval = parseFloat(maxval) || 0;
                v = v < minval ? minval : v;
                v = (v > maxval && maxval != 0) ? maxval : v; //20120508 by andy 现价为0可以改结算价
            }
            $(this).val((v || nullval));
            // 若当前值与默认值不匹配则为更改状态
            if (v != defval || v != lastval) {
                isEditModel = true;
                $(this).parent().addClass('modify');
                $(this).attr('lastval', v)
                $(this).trigger('update');
            }

        })
        .bind('keydown', function (e) {
            var k = window.event ? e.keyCode : e.which;
            var n = $.inArray(this, ipts);
            if (k == 37) {
                n--;
            } else if (k == 39) {
                n++;
            } else if (k == 38) {
                n -= size;
            } else if (k == 40) {
                n += size;
            } else if (k == 13 && $(this).hasClass('integer')) {
                n++
            } else {
                return true;
            }
            // 范围内
            if (n >= 0 && n < ipts.length) {
                ipts[n].focus();
            } else if ($(this).hasClass('integer')) {
                //最后一个文本框
                window.setTimeout(function () {
                    savestyle(function () { $('.inputbox').focus(); })
                }, 0);
                return false;
            }
            return false;
        });
}

// 打印
var e_print = e_print || function (url, width, height, act) {
    savesheet(function () {
        var id = $('#sheetid').val();
        url = $.format(url, id);
        $.print(url, width, height, act);
    });
}

// 生成差异
var e_crdiff = e_crdiff || function () {
    if ($(this).hasClass('disabled')) return;
    savesheet(function () {
        if ($(this).hasClass('disabled')) return;
        if (!window.confirm("确定要根据收货生成差异发货单吗？")) return;
        //加载框
        var id = $('#sheetid').val();
        var ajax = $.ajaxWebService("GenerateDiff", { id: id }, function (obj) {
            obj = obj.d;
            var s = obj.msg.split('单号：');
            if (s.length > 1) {
                if (confirm(obj.msg + '\n\n现在查看此差异发货单吗？'))
                    $.openModal(sediturl + '?id=' + s[1].substring(0, 22), '90%', '70%');
            } else {
                alert(obj.msg);
            }
        }, {
            beforeSend: function () { $.mask('正在生成差异发货单...', ajax) },
            complete: function () { $.unmask(); }
        });
    });

}
// 查看差异
var e_showdiff = e_showdiff || function () {
    if ($(this).hasClass('disabled')) return;
    var url = 'ShowDiff.aspx?id=' + $('#sheetid').val();
    $.openModal(url, '800px', '500px');
}
//
var getparams = getparams || function (obj) {
    return { id: $('#sheetid').val() || '' }
}