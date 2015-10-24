/// <reference path="../lib/jquery-1.4.2.min.js" />


///
$.fn.extend({
    LoadTree: function () {
        var url = $(this).attr('url');
        var target = $(this).attr('target');
        if (!url) return;

        $(this).addClass('active').siblings().removeClass('active');

        if ($(target).size()) {
            $(target).show().siblings().hide();
        } else {

            $('<div id="' + target.substring(1) + '"></div>').appendTo('#treepanel').siblings().hide();

            if (target == '#tree5') {
                // dblclick event
                $(target).bind('dblclick', function (event) {
                    if (!event.srcElement) return;
                    var node = $('.bbit-tree-selected', this);
                    var text = node.find('span:last').text();
                    text = encodeURI(text);
                    $('#tabcontrol').CreateTab("send_msg", "/oa/isprit/msg/msg_send.aspx?to=" + text, "发消息");
                });
                // tree settings.
                var settings = {
                    checkstate: 0,
                    url: url,
                    onnodeclick: function (item) {
                        if (item.url && item.url != '#') {
                            //$('img:last', this).click();
                        } else {
                            item.expand(); //没有url的为根目录
                        }
                        return false;
                    },
                    data: null
                };
            } else {
                var settings = {
                    showcheck: false,
                    url: url,
                    onnodeclick: function (item) {
                        if (item.url && item.url != '#') {
                            if (item.url.indexOf('http://f22/') == 0) {
                                return true;
                            } else {
                                //alert('此菜单只能在后台程序使用!');
                                //return false;
                                $('#tabcontrol').CreateTab(item.id, item.url, item.text);
                            }
                        } else {
                            item.expand(); //没有url的为根目录
                        }
                        return false;
                    },
                    data: null
                };
            }
            // 树加载
            $(target).treeview(settings);
        }

    },
    initTab: function () {
        $(this).find('.tab-header > ul >li[href]').hover(
					function () { $(this).addClass('x-state-hover') },
					function () { $(this).removeClass('x-state-hover') }
			).click(function () {
			    $(this).ActiveTab();
			});
    },
    // 
    CreateTab: function (id, url, txt) {
        var self = $(this);
        txt = txt || 'new Tab'
        // 
        var title = txt + '\n' + url;
        // 
        id = id.replace(/[^\w-]/gi, "_").toLowerCase();
        if (!url) return;
        txt = txt.length > 5 ? txt.substring(0, 5) + '...' : txt;
        var tab = self.find('div.tab-header > ul > li.x-tab-button[href="#' + id + '"]');
        if (tab.size()) {
            if (url != tab.attr('title').split('\n')[1]) {
                tab.attr('title', title);
                $('span:last', tab).text(txt);
                $('#' + id + '_iframe').attr('src', url);
            }
            tab.ActiveTab()
            return;
        }
        url += (url.indexOf('?') >= 0 ? '&' : '?') + '_=' + (new Date()).valueOf();
        var d = $('<div />'); var t = $('<li />');
        d.addClass('tab-content').append('<iframe style="border:none;" frameborder="0" src="' + url + '" '
							 + 'width="100%" height="100%" id="' + id + '_iframe"></iframe>').attr('id', id);
        t.append('<div class="x-tab-button-left"> </div>'
							 + '<div class="x-tab-button-center"><span class="icon tab-icon-close"></span><span>' + txt + '</span></div>'
							 + '<div class="x-tab-button-right"> </div>')
					.addClass('x-tab-button x-state-default').attr({ 'href': '#' + id, 'title': title })
				  .hover(function () { $(this).addClass('x-state-hover') },
									function () { $(this).removeClass('x-state-hover') })
					.bind('mousedown', function (e) {
					    if ($.browser.msie && e.button == 4 || !$.browser.msie && e.button == 1) {
					        t.CloseTab();
					        return false;
					    }
					}).bind('dblclick', function (e) { t.CloseTab(); return false; })
					.bind('click', function () { t.ActiveTab() })
					.find('.tab-icon-close')
							.bind('click', function () { t.CloseTab() })
							.hover(
									function () { $(this).addClass('tab-icon-close-hover') },
									function () { $(this).removeClass('tab-icon-close-hover') })

        self.append(d).find('.tab-header ul').append(t);
        t.ActiveTab();
    },
    //
    ActiveTab: function () {
        var self = $(this);
        if (self.hasClass('x-state-active')) return;
        var id = self.attr('href');
        if (!id) return;
        self.addClass('x-state-active').siblings().removeClass('x-state-active');
        $('.tab-content').hide();
        $(id).show().autoLayout();
        //$(id).find('iframe').find(document).trigger('show');    //触发resize事件
        //alert($(id).find('iframe').find(document).size())
        var f = document.getElementById(id.substring(1, id.length) + '_iframe');
        if (f) {
            var jq = f.contentWindow.jQuery;
            if (typeof jq == 'function') {
                setTimeout(function () {
                    jq(f.contentWindow).triggerHandler('resize')
                }, 0)
            }
        }
    },
    //
    CloseTab: function () {
        var self = $(this);
        if (self.length == 0) return;
        var id = self.attr('href');
        if (!id) return;
        $(id).remove();
        self.remove();
        $('.tab-header li:last').ActiveTab();
    },
    //
    OpenTab: function () {
        var url = $(this).attr('href');
        if (!url || url.indexOf('#') == 0) return;
        var taget = $(this).attr('target');
        if (taget == '_blank') {
            return;
        } else if (taget == '_self') {
            location.href = url;
            return;
        } else if (url.indexOf('http://f22/') == 0 || url.indexOf('http://wait/') == 0) {
            return true;
        }
        var txt = $(this).attr('title') || $(this).text();
        txt = $.trim(txt);
        var id = url.split('?')[0].replace(/\//ig, '_').replace('.', ''); //get id from url
        $('#tabcontrol').CreateTab(id, url, txt);
        return false;
    },
    autoLayout: function () {
        if (!$(this).size()) return;
        var h = $(window).height() - $(this).offset().top;
        $.each($(this).parents(), function () {
            h -= (parseInt($(this).css("borderBottomWidth")) || 0);
            h -= (parseInt($(this).css("paddingBottom")) || 0);
        })
        $(this).height(h);
        return this;
    },
    messageBox: function (html, view, close) {
        $m = $('<div class="messagebox" />').html(html);
        $top = $(this).offset().top + $(this).height()
        $left = $(this).offset().left;
        $controler = $('<div class="messagebox-controler"/>')
                .append('<a href="#viewdetail">查看</a> | <a href="#close">关闭</a>');

        if (typeof view == 'function') { $controler.find('a:eq(0)').click(view); }
        if (typeof close == 'function') { $controler.find('a:eq(1)').click(close); }
        $controler.find('a').click(function () { $m.remove(); return false; });

        $m.append($controler).css({ 'top': $top, 'left': $left });
        $('body').append($m);
    },
    ///
    LoadPanel: function (url, ajaxbeforesend, ajaxcomplete) {
        var panel = $('div.panelcontent', this);
        $(this).bind('reload', function () {
            $.ajax({
                url: url,
                dataType: 'html',
                cache: false,
                success: function (result) {
                    panel.empty().append(result).find('a').bind('click', $.fn.OpenTab);
                },
                error: function (xml) {
                    var d = $('<span />').append(xml.responseText).text();
                    d = d.length > 50 ? d.substring(0, 50) + "..." : d;
                    d += '<div>错误源：<a target="_blank" href="' + this.url + '">' + this.url + '</a></div>';
                    panel.empty();
                    $('<span style="color:red" />').append(d).appendTo(panel);

                },
                beforeSend: function () {
                    panel.find('span.icon-loading').remove();
                    panel.prepend('<span class="x-icon icon-loading">数据加载中....</span>');
                    if (typeof ajaxbeforesend == 'function') {
                        (ajaxbeforesend)(panel);
                    }
                },
                complete: function () {
                    //panel.find('span.icon-loading').remove();
                    if (typeof ajaxcomplete == 'function') {
                        (ajaxcomplete)(panel);
                    }
                }
            });
        }).trigger('reload');
    }
});


// TOP加载完成
function TopPanelLoaded(panel) {
    var reftime= $("#tophid").val();//刷新时间
    var si = null, ci = 0;
    var items = $('.panelsubheader a', panel);
    var l = items.size();
    if (l > 0) {
        var autoswitch = function () {
            var n = ci + 1 >= l ? 0 : ci + 1;
            items.eq(n).trigger('mouseover').trigger('mouseout');
        };
        items.hover(function () {
            if (si) window.clearTimeout(si);
            $(this).addClass('bold').siblings().removeClass('bold');
            var txt = $(this).text();
            $('li', panel).hide();
            $('li[lookname="' + txt + '"]', panel).fadeIn('fast')

            ci = $.inArray(this, items);

        }, function () {
            //auto
            if (l == 1) return;
            si = window.setTimeout(autoswitch, reftime);
        }).first().trigger('mouseover').trigger('mouseout');
    }
}

var resizeTimer = null;
function formatItem(row) {
    var x = row[1];
    x = x.length > 7 ? x.substring(0, 7) + "..." : x;
    return "<em style='float:right'>" + row[0] + "</em>" + x;
}
function formatResult(row) {
    return row[0].length > 7 ? row[0].substring(0, 7) + "..." : row[0];
}


$(function () {

    // 布局
    $(window).bind('resize', function () {
        if (resizeTimer) window.clearTimeout(resizeTimer);
        resizeTimer = window.setTimeout(function () {
            $('#tabcontrol>div.tab-content').not('div:hidden').autoLayout();
            $('#body').autoLayout();
            $('#body-west-menu').autoLayout();
        }, 100);
    }).trigger('resize');

    // 解决IE6不缓存背景图片
    try { document.execCommand("BackgroundImageCache", false, true); } catch (e) { }
    // 页面关闭确认
    //window.onbeforeunload = function() { return '确认要离开当前页吗？'; }
    // 标签
    $('#tabcontrol').initTab();

    window.open = function (url, id, text) {
        $('#tabcontrol').CreateTab(id, url, text);
        return false;
    }

    window.closeTab = function () {
        $('.x-state-active', '#tabcontrol').CloseTab();
    }

    // 收缩、展开
    $('.paneltoggle').click(function () { $(this).parents('div:first').next().slideToggle(200); });

    // 自动切换
    var tstimer = null;
    var tsindex = 0;
    var tslinks = $('.panelsublinks .tipslink');
    var autoswitch = function () {
        tsindex = tsindex >= tslinks.length ? 0 : tsindex;
        $('#tipspanel ul').hide().eq(tsindex).show();
        tslinks.eq(tsindex).addClass('tipsactive').siblings().removeClass('tipsactive');
        tsindex++;
    };
    //
    tslinks.hover(function () {
        if (tstimer) window.clearInterval(tstimer);
        tsindex = $.inArray(this, $('.tipslink'));
        autoswitch();
    }, function () {
        tstimer = window.setInterval(autoswitch, 1000 * 20); // ms
    }).eq(0).trigger('mouseover').trigger('mouseout');  //触发

    // 菜单过滤器
    $('#menufilter').autocomplete('ajax/AjaxFoundation.ashx?act=autocomplete', {
        width: 185,
        formatItem: formatItem,
        formatResult: formatResult
    })
    .result(function (event, data, formatted) {
        $('#menufilter').data('result', data);
    }).keydown(function (e) {
        if ((e.keyCode || e.wilch) == 13) {
            var data = $(this).data('result') || [];
            if (data.length == 3) {
                if (data[2].indexOf('http://f22/') == 0) {
                    location.href = data[2];
                } else {
                    $('#tabcontrol').CreateTab(data[0], data[2], data[1]);
                }
            }
            $('#menufilter').val('');
            return false;
        }
    }).change(function () {
        $(this).removeData('result');
    });

    // 绑定树型控件
    $('#body-west-header ul li').click(function () {
        $(this).LoadTree();
    }).first().trigger('click');

    // desktop panel 
    $('#home a').click(function () {
        if ($(this).is('a[href="#refresh"]')) {
            $(this).parents('div.panel:first').trigger('reload');
            $(this).blur();
        } else {
            $(this).OpenTab();
        }
        return false;
    });

    $('#body-close-handler').click(function () {
        $('#body').toggleClass('toggleHide')
    })

    // 
    var mtimer = null;
    var MsgObj = null;
    var MsgRefreshTime = parseInt($('#MsgRefreshTime').val()) || 20;
    // 读取新事件
    var Msg = {
        Init: function () {
            $('a[href="#view"]', '#MessageBoxFooter').click(Msg.View)
            $('a[href="#make"]', '#MessageBoxFooter').click(Msg.Make)
            $('a[href="#hidden"]', '#MessageBoxFooter').click(Msg.Hidden)
            Msg.Load();
        },
        Load: function () {
            $.ajax({
                url: '/ajax/ajaxfoundation.ashx',
                dataType: 'json',
                cache: false,
                beforeSend: function () { $('#MessageBox').hide(); },
                data: { act: 'GetMsg' },
                success: function (result) {
                    if (result.success > 0) {
                        MsgObj = result.obj;
                        $('#MessageBoxContent').html(result.obj.content).attr('title', result.obj.content);
                        Msg.Show();
                    } else {
                        Msg.Wait();
                    }
                }
            });
        },
        Wait: function () {
            // 等待提示
            if (mtimer) window.clearTimeout(mtimer);
            mtimer = window.setTimeout(function () { Msg.Load(); }, MsgRefreshTime * 1000);
        },
        Show: function () {
            if (mtimer) window.clearTimeout(mtimer);
            $('#MessageBox').show().css({ 'bottom': '-100px' }).animate({ 'bottom': '+=100px' }, 'fast');
            setTimeout(function () { $.playSound('/Public/sound/msg.wav'); })
        },
        Hidden: function () {
            $('#MessageBox').fadeOut(300);
            Msg.Wait();
            return false;
        },
        // 查看
        View: function () {
            if (MsgObj.url && MsgObj.url.indexOf('http://f22/') == 0) //FORM调用地址
            {
                location.href = MsgObj.url;
                Msg.Make();
                return false;
            } else if (MsgObj.type == 'msg') //正常信息提示
            {
                $('#tabcontrol').CreateTab("msg_detail", '/oa/isprit/msg/msgdetail.aspx?msgid=' + MsgObj.id + '&remind=false&box=inbox', "收消息");
            } else   //日志提示
            {
                $('#tabcontrol').CreateTab("schedule_detail", '/oa/isprit/schedule/dialytask.aspx?pageFrom=calendar&nDate=' + MsgObj.dtdate, "日程安排");
            }
            Msg.Load();
            return false;
        },
        // 标记
        Make: function () {
            var act = MsgObj.type == 'msg' ? 'MakeRead' : 'MakeDone';
            $.post('/ajax/ajaxfoundation.ashx', { act: act, id: MsgObj.id }, function () {
                Msg.Load();
            });
            return false;
        }
    };

    Msg.Init();
});