function changeThemeFun(themeName) {/* 更换主题 */
    var $easyuiTheme = $('#easyuiTheme');
    var url = $easyuiTheme.attr('href');
    var href = url.substr(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
    $easyuiTheme.attr('href', href);

    var $iframe = $('iframe');
    if ($iframe.length > 0) {
        for (var i = 0; i < $iframe.length; i++) {
            var ifr = $iframe[i];
            $(ifr).contents().find('#easyuiTheme').attr('href', href);
        }
    }

    if (themeName == "Vex") {
        $("#divHead").css({ "backgroundColor": "#257DD0" });
    }
    else {
        $("#divHead").css({ "backgroundColor": "rgb(102, 102, 102)" });
    }

    $.cookie('easyuiThemeName1' + window.hzy_WebName, themeName, { path: "/", expires: 365 * 10 });
};

if ($.cookie('easyuiThemeName1' + window.hzy_WebName)) {
    changeThemeFun($.cookie('easyuiThemeName1' + window.hzy_WebName));
    //changeThemeFun('default');
}
else {
    //changeThemeFun('gray');
}
