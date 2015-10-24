var rsTimer, currentRow, currentAjax, isEditMode, st1 = null; ;
$(function () {
    $(".field").focus();
    $('.st_field').addClass('disabled');
    $(".field").bind('keydown', 'return', e_query);
    var obj = $(".dateInput").serializeObject();
    DateRender(obj);
    $("#progressbar").fadeOut();
    $("#btnclose").click(e_closeexplan);

    $(window).bind('resize', autoLayout);
    autoLayout();

    $('#key')
    .bind("focus", function () { $('#key').select() })   
    .bind('keydown', 'return', function () {
        filter();
    });
});

function filter() {
    $(frames['grid'].document.all.key).val($("#key").val());
    frames['grid'].e_query();
}



function autoLayout() {
    var h = $(window).height();
    h -= $('#grid').offset().top;
    $('#grid').height(h);
}

function e_query() {
    $("#btnquery").addClass('disabled');
    $("#btnexport").addClass('disabled');
    $("#btnexporttxt").addClass('disabled');
    e_closeexplan();
    //    try {
    //        if ($("#grid").attr("src") != "about:blank") {
    //            frames['grid'].GridControl1.fnClearTable();
    //        }
    //    }
    //    catch (e) {
    //    }
    $("#progressbar").show();
    $("#progressbar").progressBar(20);
    var para = getparams();
    var menusubid = $.QueryString().menusubid;
    var url = "PreViewSub.aspx?menusubid=" + menusubid + "&para=" + $.toJSON(para) + "&_=" + (new Date().valueOf());
    $("#grid").attr("src", url);
}

var getparams = getparams || function () {
    return $(".field").serializeObjectgb2312();
}

function progress(percentage) {
    // $("#progressbar").fadeIn();  
    $("#progressbar").progressBar(percentage);
}

//vip权限店
function e_selvipdpt() {
    var url = "/Public/DepotMultiSelector.aspx?action=powerdepot&type=vip";
    $.openModal(url, "600px", "480px");
}

//发货店
function e_selsetdpt() {
    var url = "/Public/DepotMultiSelector.aspx?action=powerdepot&type=set";
    $.openModal(url, "600px", "480px");
}

//收货店 普通
function e_selgetdpt() {
    var url = "/Public/DepotMultiSelector.aspx?action=powerdepot&type=get";
    $.openModal(url, "600px", "480px");
}

//供应商
function e_selsupp() {
    var url = "/Public/SupplierMultiSelector.aspx";
    $.openModal(url, "600px", "480px");
}

//选加盟商
function e_selmerch() {
    var url = "/Public/MerchantMultiSelector.aspx";
    $.openModal(url, "600px", "480px");
}
//选择款式
function e_style() {
    var url = "/Public/StyleSelector.aspx";
    $.openModal(url, "600px", "480px");
}
//按虚拟结构选款
function e_stylestruc() {//
    var url = "/Public/StyleStructSelector.aspx";
    $.openModal(url, "800px", "480px");
}

function e_stylecolorstruc() {
    var url = "/Public/StyColorStructSelector.aspx";
    $.openModal(url, "800px", "480px");
}

//选虚拟发货地
function e_selsetdptstruct() {
    var url = "/Public/DepotStructSelector.aspx?action=powerdepot&type=set";
    $.openModal(url, "800px", "480px");
}

//选虚拟收货地
function e_btnselgetdptx() {
    var url = "/Public/DepotStructSelector.aspx?action=powerdepot&type=get";
    $.openModal(url, "800px", "480px");
}
//function e_singstyle() {
//    var url = "/Public/StyleSelector.aspx";
//    $.openModal(url, "600px", "480px");
//}

// 导出
function e_export() {
    try {
        frames['grid'].e_export();
    } catch (e) {

    }
}

// 导出
function e_exporttxt() {
    try {
        //frames['grid'].e_export();
        frames['grid'].e_exporttxt();
    } catch (e) {
        //alert(e.message);
    }
}

//报表说明
function e_explain() {
    var btn = this;
    if ($(this).text() == '隐藏报表说明') {
        $(".divinfo").fadeOut('fast');
        $(btn).text('显示报表说明');
    } else {
        $(".divinfo").fadeIn('fast');
        $(btn).text('隐藏报表说明');
    }
}
function e_closeexplan() {
    $(".divinfo").hide();
}

//渲染

function DateRender(obj) {
    var d = new Date();
    d.setMonth(d.getMonth() + 1 - 1);
    $.each(obj, function (i, o) {
        $("#" + i).datePicker({ clickInput: true, displayClose: true, inline: false }).dpSetOffset(20, 0).val(d.asString()).trigger('change').dpSetStartDate(new Date(0001, 0, 1).asString()).dpSetEndDate(new Date(9999, 11, 31).asString());
    });
}

$.extend({
    progressBar: new function () {
        this.defaults = {
            steps: 20, 										// steps taken to reach target
            stepDuration: 1,
            max: 100, 										// Upon 100% i'd assume, but configurable
            showText: true, 										// show text with percentage in next to the progressbar? - default : true
            textFormat: 'percentage', 								// Or otherwise, set to 'fraction'
            width: 120, 										// Width of the progressbar - don't forget to adjust your image too!!!												// Image to use in the progressbar. Can be a single image too: 'images/progressbg_green.gif'
            height: 12, 										// Height of the progressbar - don't forget to adjust your image too!!!
            callback: null, 										// Calls back with the config object that has the current percentage, target percentage, current image, etc
            boxImage: '/Public/lib/progressbar/images/progressbar.gif', 					// boxImage : image around the progress bar
            barImage: {
                0: '/Public/lib/progressbar/images/progressbg_red.gif',
                30: '/Public/lib/progressbar/images/progressbg_orange.gif',
                70: '/Public/lib/progressbar/images/progressbg_green.gif'
            },
            // Internal use
            running_value: 0,
            value: 0,
            image: null
        };

        /* public methods */
        this.construct = function (arg1, arg2) {
            var argvalue = null;
            var argconfig = null;

            if (arg1 != null) {
                if (!isNaN(arg1)) {
                    argvalue = arg1;
                    if (arg2 != null) {
                        argconfig = arg2;
                    }
                } else {
                    argconfig = arg1;
                }
            }

            return this.each(function (child) {
                var pb = this;
                var config = this.config;

                if (argvalue != null && this.bar != null && this.config != null) {
                    this.config.value = parseInt(argvalue)
                    if (argconfig != null)
                        pb.config = $.extend(this.config, argconfig);
                    config = pb.config;
                } else {
                    var $this = $(this);
                    var config = $.extend({}, $.progressBar.defaults, argconfig);
                    config.id = $this.attr('id') ? $this.attr('id') : Math.ceil(Math.random() * 100000); // random id, if none provided

                    if (argvalue == null)
                        argvalue = $this.html().replace("%", "")	// parse percentage

                    config.value = parseInt(argvalue);
                    config.running_value = 0;
                    config.image = getBarImage(config);

                    var numeric = ['steps', 'stepDuration', 'max', 'width', 'height', 'running_value', 'value'];
                    for (var i = 0; i < numeric.length; i++)
                        config[numeric[i]] = parseInt(config[numeric[i]]);

                    $this.html("");
                    var bar = document.createElement('img');
                    var text = document.createElement('span');
                    var $bar = $(bar);
                    var $text = $(text);
                    pb.bar = $bar;

                    $bar.attr('id', config.id + "_pbImage");
                    $text.attr('id', config.id + "_pbText");
                    $text.html(getText(config));
                    $bar.attr('title', getText(config));
                    $bar.attr('alt', getText(config));
                    $bar.attr('src', config.boxImage);
                    $bar.attr('width', config.width);
                    $bar.css("width", config.width + "px");
                    $bar.css("height", config.height + "px");
                    $bar.css("background-image", "url(" + config.image + ")");
                    $bar.css("background-position", ((config.width * -1)) + 'px 50%');
                    $bar.css("padding", "0");
                    $bar.css("margin", "0");
                    $this.append($bar);
                    $this.append($text);
                }

                function getPercentage(config) {
                    // alert(config.running_value);
                    return config.running_value * 100 / config.max;
                }

                function getBarImage(config) {
                    var image = config.barImage;
                    if (typeof (config.barImage) == 'object') {
                        for (var i in config.barImage) {
                            if (config.running_value >= parseInt(i)) {
                                image = config.barImage[i];
                            } else { break; }
                        }
                    }
                    return image;
                }

                function getText(config) {
                    if (config.showText) {
                        if (config.textFormat == 'percentage') {
                            return " " + Math.round(config.running_value) + "%";
                        } else if (config.textFormat == 'fraction') {
                            return " " + config.running_value + '/' + config.max;
                        }
                    }
                }

                config.increment = Math.round((config.value - config.running_value) / config.steps);
                if (config.increment < 0)
                    config.increment *= -1;
                if (config.increment < 1)
                    config.increment = 1;

                var t = setTimeout(function () {
                    var pixels = config.width / 100; 		// Define how many pixels go into 1%

                    if (config.running_value > config.value) {
                        if (config.running_value - config.increment < config.value) {
                            config.running_value = config.value;
                        } else {
                            config.running_value -= config.increment;
                        }
                    }
                    else if (config.running_value < config.value) {
                        if (config.running_value + config.increment > config.value) {
                            config.running_value = config.value;
                        } else {
                            config.running_value += config.increment;
                        }
                    }

                    if (config.running_value == config.value)
                        clearInterval(t);

                    var $bar = $("#" + config.id + "_pbImage");
                    var $text = $("#" + config.id + "_pbText");
                    var image = getBarImage(config);
                    if (image != config.image) {
                        $bar.css("background-image", "url(" + image + ")");
                        config.image = image;
                    }
                    $bar.css("background-position", (((config.width * -1)) + (getPercentage(config) * pixels)) + 'px 50%');
                    $bar.attr('title', getText(config));
                    $text.html(getText(config));
                    if (config.running_value == 100) {
                        $("#progressbar").fadeOut();
                        $("#progressbar").progressBar();
                        $("#btnquery").removeClass("disabled");
                        $("#btnexport").removeClass("disabled");
                        $("#btnexporttxt").removeClass("disabled");
                    }
                    if (config.running_value > 10) {
                        setTimeout(function () {
                            $("#progressbar").fadeOut();
                            $("#progressbar").progressBar();
                            $("#btnquery").removeClass("disabled");
                            $("#btnexport").removeClass("disabled");
                            $("#btnexporttxt").removeClass("disabled");
                        }, 1500);

                    }

                    if (config.callback != null && typeof (config.callback) == 'function')
                        config.callback(config);

                    pb.config = config;
                }, config.stepDuration);
            });
        };
    }
});

$.fn.extend({
    progressBar: $.progressBar.construct
});