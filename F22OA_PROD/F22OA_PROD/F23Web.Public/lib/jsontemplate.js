/*
name:iteratejson for Jquery
author:arn
date:2010-2-6
remark: 把JOSN的字符串，格式化到HTML
<div id="jsontemplate">
<DIV>${id}</DIV>
<DIV>${name}</DIV>
<div>
    
$("#mk").jsontemplate({jsonArray:obj.fields}); 
or 
$("#ulfunc").jsontemplate({url:"/basis/dict/dict.ashx", data:p}); ajaxurl返回JSON字符
*/
(function ($) {
    $.iterate = function (t, p) {

        if (t.checkbox) return false; //return if already exist	

        // apply default properties
        p = $.extend({
            jsonArray: [], //ALL ITEMS
            url: false, //ajax url
            data: {}, // ajax 提交的数据
            method: 'POST', // data sending method
            dataType: 'json',
            onSuccess: false, // using a custom populate function
            onBeforeSubmit: false //提交之前处理事项
        }, p);

        var d = {
            json2str: function (json) {
                var isArrObj = $.isArray(json);
                var arr = [];
                //
                for (var key in json) {
                    var k = isArrObj ? '' : key + ":";

                    if (typeof json[key] == 'object' && json[key] != null)
                        arr.push(k + d.json2str(json[key])); 		//JSON对象
                    else
                        arr.push(k + "'" + decodeURIComponent(json[key]) + "'"); //普通值
                }
                return isArrObj ? '[' + arr.join(',') + ']' : '{' + arr.join(',') + '}';
            },
            str2json: function (str) {
                return eval('(' + str + ')');
            },
            initData: function (data) {
                //获取模板
                var temp = $(t).html();
                var id = 'jt' + $(t).attr('id');
                $("#" + id).remove();
                var template = $(t).clone(true);
                $(t).after(template);
                $(template).attr('id', id);

                var reg = new RegExp('{.*?}');
                $("#" + id).empty();
                var clone = "";

                var alltemp = "";
                $(data).each(function (i, k) {
                    clone = temp;
                    for (var key in k) {
                        reg = new RegExp('{' + key + '}', "gi");
                        clone = clone.replace(reg, k[key]);
                    }

                    alltemp += clone;
                });
                $("#" + id).append(alltemp);
                $("#" + id).show();
            },
            ajaxSubmit: function (para) {
                if (p.url) {

                    if (p.onBeforeSubmit) para = p.onBeforeSubmit();
                    $.ajax({
                        type: p.method,
                        timeout: 20 * 1000,
                        url: p.url,
                        async: false,
                        data: para,
                        dataType: p.dataType,
                        success: function (data) {
                            if (data != null && data.Head != undefined && data.Head != null) {
                                d.initData(data.Head);
                            }
                            return false;
                            if (data.state == 1) {
                                d.initData(data.fields);
                                if (p.onSuccess) //执行成功后
                                {
                                    p.onSuccess();
                                }
                            } else {
                                alert('数据加载失败<br/>' + data.msg);
                            }
                        },
                        error: function (data) { try { alert(data.toString()) } catch (e) { } },
                        beforeSend: function (data) { },
                        complete: function () { }
                    });
                }

            }
        };

        t.list = d;
        $(t).show();
        $(t).hide();
        //load items, 没有url,则加载jsonArray
        if (p.url) {
            d.ajaxSubmit(p.data);
        } else {
            d.initData(p.jsonArray);
        };
        return t;
    };

    var docloaded = false;

    $(document).ready(function () { docloaded = true });
    //初始化
    $.fn.jsontemplate = function (p) {
        return this.each(function () {
            var t = this;
            if (!docloaded) {
                $(this).hide();
                $(document).ready
					(
						function () {
						    $.iterate(t, p);
						}
					);
            } else {
                $.iterate(this, p);
            }
        });

    }; //end iteratejson    

})(jQuery);
