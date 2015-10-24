
$(function() {
    // 绑定单头
    e_bind();
    // 设置参数
    initprint();

})

// 直接打印
function e_print() {
    try {
        eprint.Print(true);
    } catch (err) { }
    //setTimeout(function() { window.close() }, 300);
}
// 打印预览
function e_preview() {
    try {
        eprint.Preview();
    } catch (err) { }
}

// 单头数据绑定
var e_bind = e_bind || function() {
    var obj = { id: $.QueryString().id || '' };
    $.ajaxWebService("Get", obj, function(result) {
        result = result.d || new Object();
        if (result.success > 0) {
            $('.field').fillFields(result.obj);

            //act=1 自动打印
            //act=2 弹出预览
            var act = $.QueryString().act;
            if (act == 1) {
                window.setTimeout(e_print, 0);
            } else if (act == 2) {
                window.setTimeout(e_preview, 0);
            } else {
                //$(window).bind('resize', dolayout).trigger('resize');
            }

        } else {
            alert(result.msg);
            //window.close();
        }
    });
}

// 打印控件初始化
var initprint = initprint || function() {
    try {

        eprint.InitPrint();
        eprint.setMarginMeasure(1);

        eprint.paperSize = "26*9.2***"; //用户自定义
        //eprint.paperSize = "US Std Fanfold"; //用户自定义
        //eprint.orientation = 1;

        var settings = printSettings || {};

        //alert($.toJSON(settings))

        //eprint.pageWidth = 147.00;
        //eprint.pageHeight = 107.00;
        eprint.pageWidth = settings.pageWidth || 210.00;
        eprint.pageHeight = settings.pageHeight || 297.00;
        eprint.marginLeft = settings.marginLeft || 10.00;
        eprint.marginTop = settings.marginTop || 10.00;
        eprint.marginRight = settings.marginRight || 10.00;
        eprint.marginBottom = settings.marginBottom || 10.00;

        //eprint.header = "";
        //eprint.footer = "";

        if (eprint.defaultPrinterName.length == 0) {
            alert("没找到打印机！");
            return;
        }
    } catch (msg) {
        if (confirm('打印控件初始化失败，请确定是否未安装打印插件！')) {
            window.open('/setup/regdll.aspx');
        }
    }
    //
}

var dolayout = dolayout || function() {
    //    var fh = $('#pagefooter').outerHeight();
    //    var hh = $('#pagetoolbar').outerHeight() + $('#pageheader').outerHeight();
    //    var h = $(window).height() - fh - hh;
    //    $('#pagecontent').height(h);
}