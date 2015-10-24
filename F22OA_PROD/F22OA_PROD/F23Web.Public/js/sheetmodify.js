var _isNumsControl = _isNumsControl || true; //录入最大数量是否控制
//数量渲染（加文本框 ）
function numsRender(obj) {
    var d = obj.aData[obj.iDataColumn];
    
    if (readonly) {
        return d;
    } else {
        var maxval = 0;
        if (_isNumsControl == true) {
            maxval = d == "" ? 0 : d;
        } else {
            maxval = 9999;
        }

    return '<input type="text" class="edit integer" colorid="' + obj.aData[0]
        + '" sizeid="' + obj.oSettings.aoColumns[obj.iDataColumn].sName
        + '" value="' + d + '"  defval="' + d + '" lastval="' + d + '" minval="0" maxval="' + maxval + '"  nullval=""/>';
    }
}


function StyleGridInitComplete() {
    var that = this;
    that.fnAdjustColumnSizing();
    $(window).bind('resize', function () {
        if (st1) window.clearTimeout(st1);
        st1 = window.setTimeout(function () {
            that.AdjustScrollLayout();
        }, 100);
    }).trigger('resize');

    //
    $('#StyleGridPanel').append('<div class="bluepanel" ><span class="x-icon icon-info">' +
    '快捷键：删除[Ctrl+Del]、刷新单价[Ctrl+Y]、查找[Ctrl+H]</span></div>');

    $('#ColorSizePanel').after('<div id="diverror" style="display:none;" >录入数量大于商管回复数量</div><div class="bluepanel" id="ColorSizeTips" style="display:none;position:fixed;bottom:5px;"><span class="x-icon icon-info">' +
    '快捷键：保存[Ctrl+S]、填行[Ctrl+L]、填列[Ctrl+U]、全填[Ctrl+D]</span></div>');
    $('#ColorSizePanel').after('<div id="divOtherGrid"></div>');

    // loading mask
    $('#ColorSizePanel').append('<div id="loadingPanel" style="display:none;">正在加载...</div>');

}