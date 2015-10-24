var Cookies = {};
Cookies.set = function (name, value) {
    var argv = arguments;
    var argc = arguments.length;
    var expires = (argc > 2) ? argv[2] : null;
    var path = (argc > 3) ? argv[3] : '/';
    var domain = (argc > 4) ? argv[4] : null;
    var secure = (argc > 5) ? argv[5] : false;
    document.cookie = name + "=" + escape(value) +
      ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
      ((path == null) ? "" : ("; path=" + path)) +
      ((domain == null) ? "" : ("; domain=" + domain)) +
      ((secure == true) ? "; secure" : "");
};

Cookies.get = function (name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    var j = 0;
    while (i < clen) {
        j = i + alen;
        if (document.cookie.substring(i, j) == arg)
            return Cookies.getCookieVal(j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0)
            break;
    }
    return '';
};

Cookies.clear = function (name) {
    if (Cookies.get(name)) {
        var expdate = new Date();
        expdate.setTime(expdate.getTime() - (86400 * 1000 * 1));
        Cookies.set(name, "", expdate);
    }
};

Cookies.getCookieVal = function (offset) {
    var endstr = document.cookie.indexOf(";", offset);
    if (endstr == -1) {
        endstr = document.cookie.length;
    }
    return unescape(document.cookie.substring(offset, endstr));
};

function setSkinOnCookie(skinColor){
	//var cookieString = new String(document.cookie);
	//var cookieString = document.cookie;
	var Then = new Date();
	Then.setTime(Then.getTime() + 500*24*60*60*1000);
	Cookies.set("skinColor",skinColor,Then);
		
}

function getSkinFromCookie(){
	return Cookies.get("skinColor");
	
}


function changeSkin(color) {
	
	$('body').css('background', '#' + color);
	if($('#header')!=undefined){
		$('#header').css('background', '#' + color);
	}
	/*if(skinColor!=undefined){
		skinColor = color;
	}*/
	//
	if($('#test2')!=undefined){
		$('#test2').css('background','#'+color);
	};
	if($('#main')!=undefined){
		$('#main').css('background','#'+color);
	};
	
	if($('#footer')!=undefined){
		$('#footer').css('background','#'+color);
	};
	
	
	
	
	
	
	setSkinOnCookie(color);
	
}