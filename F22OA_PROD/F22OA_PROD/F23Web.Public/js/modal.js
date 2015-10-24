$(function() {
    $('.field')
	.bind('keydown', 'return', function(e) {
	    var s = false; var t = this;
	    $(':text,:radio,:checkbox,select,button').each(function(i, obj) {
	        if ($(obj).is('[readonly],[disabled]')) { return true; }
	        if (!$(this).is(':visible')) { return false; }
	        var expr = ':radio[name=' + $(t).attr('name') + ']';
	        if (s == true && !$(obj).is(expr)) {
	            this.focus(); return false;
	        }
	        if (t == obj) { s = true; }
	    });
	    return false;
	});

    //按两下esc会响应表单reset
    $('form').bind('reset', function() {
        return false;
    })

});

var e_submit = e_submit || function() {

}
var e_cancel = e_cancel || function() {
    window.returnValue = null;
    window.close();
}