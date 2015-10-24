var tempsure;
$(function () {
    $('#btnsubmit').removeAttr('disabled');
    $(document).bind('keydown', 'return', e_submit).bind('keydown', 'esc', e_cancel);

});

var isAlert = null;    //警告
var isError = false;    //错误
var isStop = false;     //中止

function e_cancel() {
    window.returnValue = null;
    window.close();
}

function e_submit() {
    //是否需要执行更新临时标识   
    tempsure = eval($.QueryString().tempsure);   
    if (tempsure) {
        updatetempsure(1);
    } else {
        callupdate();
    }
}

function callupdate() {
    isStop = false;
    isError = false;
    var obj = $(".field").serializeObject();
    $('#btnsubmit').attr('disabled', 'disabled');
    var arr = updatestate(); //更新
    obj.sql = arr[0];
    obj.isSure = arr[1];
    getchecked(obj);
}


//更新临时状态
function updatetempsure(sure) {
    var obj = {
        menuid: $(":input[name='menuid']").val(),
        id: $(":input[name='sheetid']").val(),
        sure: sure
    };

    $.ajaxWebService("UpdateTempSure", obj, function (result) {
        var o = result.d || new Object();
        if (o.success > 0) {
            if (sure == 1) { callupdate(); }
        } else {
            alert(o.msg);
        }
    });
}

// 更新状态
function updatestate(str, state, info, butname) {
    var isExists = 0;
    var arr = new Array();
    $.each(CheckList.fnGetNodes(), function (i) {
        var d = CheckList.fnGetData(this)
        var s = d[4], sure = d[5];
        if (!str || isExists == 1) {
            if ((isAlert) || (isError && d[5] == 'True') || isStop) {
                CheckList.fnUpdate(4, i, 3); //更新结果
                CheckList.fnUpdate('存在未解决的项!', i, 2); //更新结果
                isStop = true;
                return true;
            } else {
                CheckList.fnUpdate(1, i, 3); //loading状态
                arr[0] = s; arr[1] = sure;
                isExists = 2
                return false;
            }
        } else if (str == s) {
            CheckList.fnUpdate((butname || ''), i, 6); //更新结果
            CheckList.fnUpdate(state, i, 3); //更新结果
            CheckList.fnUpdate(info, i, 2); //更新结果
            isExists = 1;
            return true;
        }
    });
    return isExists == 2 ? arr : null;
}

// 获取检查结果
function getchecked(obj) {
    $.ajaxWebService("GetChecked", obj, function (json) {
        json = json.d || {};
        butname = (json.obj || {}).butname;
        //更新状态并将返回下一步SQL;
        var arr = updatestate(json.nextsetp, json.success, json.msg, butname);
        // 结束
        if (arr == null) {
            if (isError)  //存在未通过的项..需要继续检查
            {
                if (tempsure) { updatetempsure(0); }
                $('#btnsubmit').text('继续检查...').removeAttr('disabled');
            } else //全部通过
            {
                if (tempsure) { updatetempsure(0); }
                window.returnValue = true;
                window.close();
            }
        } else {
            obj.sql = arr[0];
            obj.isSure = arr[1];
            getchecked(obj);
        }
    });
}

// 状态栏渲染
function stateRender(obj) {
    var v = obj.aData[obj.iDataColumn];
    if (v == 0) {
        v = "未检查";
    } else if (v == 1) {
        v = '<span class="x-icon icon-loading" >检查中</span>';
    } else if (v == 2) {
        isError = true;
        v = '<a class="x-icon icon-delete" href="#" onclick="javascript:openwin(\''
        + obj.aData[4] + '\',\'' + obj.aData[6] + '\');" title="点击查看原因">不通过</a>';
        $(CheckList.fnGetNodes()[obj.iDataRow]).addClass('gradeX');
    } else if (v == 3) {
        v = '<a class="x-icon icon-info" href="#" onclick="javascript:openwin(\''
        + obj.aData[4] + '\',\'' + obj.aData[6] + '\');" title="点击查看原因">警告</a>';
        $(CheckList.fnGetNodes()[obj.iDataRow]).addClass('gradeC');
    } else if (v == 4) {
        v = '<span class="x-icon icon-delete">中止</span>';
        $(CheckList.fnGetNodes()[obj.iDataRow]).addClass('gradeX');
    } else if (v == 5) {
        v = '<span class="x-icon icon-accept">通过</span>';
        $(CheckList.fnGetNodes()[obj.iDataRow]).addClass('gradeA');
    } else {
        isError = true;
        v = '<span class="x-icon icon-delete" >异常</span>';
        $(CheckList.fnGetNodes()[obj.iDataRow]).addClass('gradeX');
    }
    return v;
}

function openwin(proc, butname) {
    var obj = $.QueryString();
    $.extend(obj, { proc: proc, butname: butname, setdate: $('#setdate').val() });
    var url = 'SheetCheckInfo.aspx?' + $.param(obj);
    $.openModal(url, '700px', '350px');
    return false;
}

 