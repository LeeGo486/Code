
var currentAjax;
$(function () {
    var querystring = location.href.split('?')[1];
    var obj = $.param2obj(querystring);
    if (obj.seltype != null) {
        $("#" + decodeURI(obj.seltype)).attr("checked", "checked");
    }
    else {
        $("input:checkbox:first").attr("checked", "checked");
    }
    $('#GridControl1_table').numeric();
    $('#btnsubmit').removeAttr('disabled');
    ShowCanNums();

});

function e_submit() {
    if (currentAjax) { return; } //加载中,不执行保存
    var querystring = location.href.split('?')[1];
    var obj = $.param2obj(querystring);
    //类型
    obj.type = [];
    $('input:checkbox').each(function (i, o) {
        if (o.checked) {
            obj.type.push(o.value);
        }
    });
    if (obj.type.length == 0) {
        alert("至少选择一种类型！");
        return;
    }
    obj.clothings = [];
    $('input:text', GridControl1).each(function (i, o) {
        var nums = parseInt($(this).val()) || 0;
        if (nums) {
            var colorid = $(this).attr('colorid');
            var sizeid = $(this).attr('sizeid');
            var clothingid = obj.styleid + '' + colorid + '' + sizeid; // as string
            obj.clothings.push({
                clothingid: clothingid,
                colorid: colorid,
                sizeid: sizeid,
                nums: nums
            });
        }
    });

    currentAjax = $.ajaxWebService('Save', obj, function (result) {
        result = result.d || {};
        if (result.success > 0) {
            window.returnValue = true;
            window.close();
        } else {
            alert(result.msg);
        }
    }, {
        beforeSend: function () {
            $('#btnsubmit').attr('disabled', 'disabled');
        },
        complete: function () {
            $('#btnsubmit').removeAttr('disabled');
        }
    });
    return false;

}

function e_cancel() {
    window.returnValue = null;
    window.close();
}

//数量渲染（加文本框 ）
function numsRender(obj) {
    var d = obj.aData[obj.iDataColumn];
    if (obj.iDataColumn < 2 || obj.iDataColumn >= obj.oSettings.aoColumns.length - 1) {
        return d;
    } else {
        return '<input type="text" class="edit integer" colorid="' + obj.aData[0]
                + '" sizeid="' + obj.oSettings.aoColumns[obj.iDataColumn].sName
                + '" value="' + d + '"  defval="' + d + '" lastval="' + d + '" />';
    }
}

// var arr = [];
//{
//  'I':['1','2','1','1']
//  'S':['1','2','1','1']
//}


//显示可补货数量
function ShowCanNums(styleid, colorid) {

    var querystring = location.href.split('?')[1];
    var obj = $.param2obj(querystring);
 
//    $.ajaxWebService('GetKBNums', obj, function (result) {
//        alert($.toJSON(result));
// 
//    });
//    
 

}

//
function initComplete() {


    var styleid = $.QueryString().styleid;

    var size = $('tbody tr:first input.integer', this).size();
    var ipts = $('input.integer', this);

    //hotkeys..
    ipts
    .numeric().css('ime-mode', 'disabled')
    //.bind('keydown', 'return', e_submit)
    .bind('keydown', 'esc', e_cancel)
    .bind('keydown', 'ctrl+d', function () {
        $('input.integer', GridControl1).val(($(this).val() || ''));
        return false;
    })
    .bind('keydown', 'ctrl+l', function () {
        var sizeid = $(this).attr('sizeid');
        $('input.integer[sizeid="' + sizeid + '"]', GridControl1).val(($(this).val() || ''));
        return false;
    })
    .bind('keydown', 'ctrl+s', function () {
        e_submit.call(this);
        return false;
    })
    .bind('keydown', 'ctrl+u', function () {
        var colorid = $(this).attr('colorid');
        $('input.integer[colorid="' + colorid + '"]', GridControl1).val(($(this).val() || ''));
        return false;
    })
    .bind('focus', function () {
        $(this).select();
        //alert($(this).attr('colorid'))

        //$('table:last>tfoot>tr>th').text('1,2,3,4')


    })
    .bind('blur', function () {
        var isChange = false;
        var v = $(this).val();
        var defval = parseFloat($(this).attr('defval'));
        var lastval = $(this).attr('lastval');

        if (v != defval && v != lastval) {
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
        } else if (k == 39 || k == 13) {
            n++;
        } else if (k == 38) {
            n -= size;
        } else if (k == 40) {
            n += size;
        } else {
            return true;
        }
        if (n >= 0 && n < ipts.length) {
            ipts[n].focus();
            return false;
        }
    });

    setTimeout(function () { ipts.eq(0).focus().select(); }, 200)
}
