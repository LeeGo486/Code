function openModal(url, width, height) {
    var m = showModalDialog('' + url + '', window, 'dialogWidth:'
    + width + 'px;dialogHeight:' + height + 'px;center:yes;help:no;resizable:yes;status:no');
    return m;
}
function keycode(e) {
    if (window.event) { return e.keyCode } else if (e.which) { return e.which } else { return 0 }
}

function isNumber(val) {
    if (parseFloat(val) == val) {
        return true
    } else {
        return false
    }
}
//转换为数字类型
function reNumber(val) {
    if (parseFloat(val) > 0 || parseFloat(val) < 0) {
        str = parseFloat(val);
    } else {
        val = 0;
    }
    return val;
}
function nokey() {
    event.keyCode = 0;
    event.cancelBubble = true;
    return false;
}
