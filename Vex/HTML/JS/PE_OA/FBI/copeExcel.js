var comm = {};
comm.clipboard = {};

//ctrol + v 事件
comm.clipboard._cellkeydown = function (event, id, gid) {
    var _id = id;
    if (event.ctrlKey && event.keyCode == 86 && id) { 
        alert(id);
        var _help = document.getElementById(id);
        _help.focus();
        _help.select();
        var fncall = "comm.clipboard._dealwithData('" + _id + "','" + gid + "')";
        setTimeout(fncall, 50);
    }
    _help = fncall = event = id = null;
}
//将粘贴事件转移到textArea中
comm.clipboard._dealwithData = function (id, gid) {
    var _help = document.getElementById(id);
    _help.blur();
    alert($(_help).val());
    var excelValues = comm.clipboard._getColumnsByClipboard($(_help).val()),
        rowIndex = comm.clipboard.curIdx,
        field = comm.clipboard.curField;
    comm.datagrid.excel2grid(gid, rowIndex, field, excelValues);
    _help = id = null;
}
//将贴过来的Excel中内容分解成数组
comm.clipboard._getColumnsByClipboard = function (context) {
    var cols = [];
    if (context) {
        cols = context.split('\n');
        if ('' == cols[cols.length - 1]) {
            cols.pop();
        }
    }
    context = null;
    return cols;
}
/**
 *设置gridid在idx行的第fieldName列为fieldValue
 *@gridid grid的Id
 *@idx 第idx行
*@fieldName 更新的字段名称
*@fieldValue 更新的值
*/
comm.datagrid = {};
comm.datagrid.setCell = function (gridid, idx, fieldName, fieldValue) {
    if (!(gridid && (idx >= 0) && fieldName)) {
        return;
    }
    var _r = $('#' + gridid).datagrid('selectRow', idx);
    _r[fieldName] = fieldValue;
    $('#' + gridid).datagrid('updateRow', { index: idx, row: _r });
    _r = gridid = idx = fieldName = fieldValue = null;
}
/**
 *设置gridid在idx行的第fieldName列为fieldValue
 *@gridid grid的Id
 *@staIdx 第idx行
*@fieldName 更新的字段名称
*@fieldValues 更新的值
*/
comm.datagrid.setCells = function (gridid, staIdx, fieldName, fieldValues) {
    if (!(gridid && (staIdx >= 0) && fieldName && fieldValues)) {
        return;
    }
    var recs = $('#' + gridid).datagrid('getRows');
    comm.datagrid.updateAndAdd(recs, staIdx, fieldName, fieldValues);
    $('#' + gridid).datagrid('loadData', { total: recs.length, rows: recs });
    gridid = staIdx = fieldName = fieldValues = null;
}
comm.datagrid.updateAndAdd = function (recs, startIdx, fieldName, fieldValues) {
    if (!(fieldName && fieldValues)) {
        return;
    }
    if (!recs) {
        recs = [];
    }
    var rcnt = recs.length,
        fcnt = fieldValues.length,
        ucnt = fcnt > rcnt ? fcnt : fcnt + startIdx;
    //console.info(startIdx,rcnt,fcnt,ucnt,fieldName,recs);
    for (var i = startIdx, len = ucnt; i < len; i++) {
        if (i < rcnt) {
            recs[i][fieldName] = fieldValues[i - startIdx];
        } else {
            var _r = {};
            _r[fieldName] = fieldValues[i - startIdx];
            recs.push(_r);
        }
    }
}
/**
 *从Excel复制到datagrid之中
*@gridid grid的Id
 *@staIdx 第idx行
*@fieldName 更新的字段名称
*@fieldValues 更新的值
*/
comm.datagrid.excel2grid = function (gridid, staIdx, fieldName, fieldValues) {
    if (!(gridid && (staIdx >= 0) && fieldName && fieldValues)) {
        return;
    }
    comm.datagrid.setCells(gridid, staIdx, fieldName, fieldValues);
    gridid = staIdx = fieldName = fieldValues = null;
}
/**
 *初始从Excel复制到datagrid之中功能
*@option 初始化参数,其中gid是指grid的ID
 *@example
 *comm.datagrid.initExcel2Grid({gid:'t1'});
 */
comm.datagrid.initExcel2Grid = function (option) {
    var opt = option;
    if (!(opt && opt.gid)) {
        return;
    }
    var _clipToolId_ = '_clipToolId_' + opt.gid;
    var _clipToolDIV = '<textarea id="' + _clipToolId_ + '" style="width:0px;height:0px"></textarea>';
    //获取剪切板的内容
    $('body').append(_clipToolDIV);
    //Ctrol + V事件必须在body上面
    $('body').keydown(function (event) {
        var _id = _clipToolId_;
        comm.clipboard._cellkeydown(event, _id, opt.gid);
    });
    //添加grid onClickCell事件，用于传递当前Grid编辑信息
    $('#' + opt.gid).datagrid({
        onClickCell: function (rowIndex, field, value) {
            comm.clipboard.curIdx = rowIndex;
            comm.clipboard.curField = field;
        }
    });
}
/**
 *销毁Excel2Grid功能
*@option 初始化参数,其中gid是指grid的ID
 */
comm.datagrid.destoryExcel2Grid = function (option) {
    var opt = option;
    if (!(opt && opt.gid)) {
        return;
    }
    var _clipToolId_ = '_clipToolId_' + opt.gid;
    $('#' + _clipToolId_).remove();
    $('body').unbind('keydown');
}