
//零售单配件检查
function chkretail() {
    var obj = "False";
    $.ajax({ url: "../AJAX/chkRetail.aspx",
        type: "post",
        dataType: "html",
        data: "",   //post过去的参数
        async: false,
        error: function (msg) {
            alert("数据加载错误!");
        },
        success: function (msg) {
            obj = msg;
        }
    });
    return obj;
}

$(function () {
    $("#txtdropreason").autocomplete(["跨年度积分已清零", "积分已经兑换,顾客愿意补差价", "顾客积分被异常挪用", "系统漏洞,导致积分异常"], {
        minChars: 0,
        width: 200
    }).click(function () { $(this).select(); onChange(0, true); });


    //加载
//    $.extend($.blockUI.defaults, {
//        message: '<b>请稍等……</b>',
//        css: {
//            textAlign: 'center',
//            top: '40%',
//            left: '40%',
//            border: 'none',
//            padding: '10px',
//            width: '120px',
//            backgroundColor: '#000',
//            '-webkit-border-radius': '10px',
//            '-moz-border-radius': '10px',
//            opacity: .5,
//            color: '#fff'
//        },
//        overlayCSS: {
//            opacity: 0
//        }
//    });
    //$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

    // 自适应高度
    $(window).bind("resize", function () {
        var $ms = $("#gridTab");
        var t = $ms.offset().top;
        var wh = $(window).height();
        var mrg = parseInt($ms.css("marginBottom")) || 0;
        var brd = parseInt($ms.css("borderBottomWidth")) || 0;
        $ms.css("height", (wh - t - mrg - brd - 80) + "px");
        if (!jQuery.browser.msie) {
            $ms.trigger("resize");
        }
    }).trigger("resize");

    if ($("#oldvnewv").val() == "1") {
        $("#oldnewyn").show();
        $("#f10").show();
    }
    //修改折扣之前隐藏
    if ($("#checkclick").val() == "0") {
        $("#lblchangetype").hide();
        $("#changetype").hide();
        $("#lblreason").hide();
        $("#reason").hide();
        // $("#dropreason").hide();
        $("#txtdropreason").hide();
    }
    //$("#gridTab").prepend('<div id="loading" style=" position:absolute; top:200px; left:0;"><img src="../Images/loading.gif" alt="" align="absmiddle" /> 请稍等..</div>');

    var dd = new Date();    //local datetime
    var sd = $("#LocalDateTime").val();    //host datetime
    var cc = dd.getFullYear() + "-" + (dd.getMonth() + 1) + "-" + dd.getDate();
    if (sd != cc) location.href("../relogin.aspx?datetime=" + encodeURI(dd.toLocaleDateString()));
    ajax_disbtn(0);
    ajax_read(1);
    ajax_retail();
    //签到
    $("#opentrans").click(openTrans);
    //查询银行卡余额
    $("#querycard").click(f_query);

    //关必VIP图片显示
    $("#closevipimg").click(closevippic);

    $("#showvipimg").click(showvippic);

    //刷VIP卡
    $("#f1").click(function () {
        var m = openModal('../Modal/input_bankcard.aspx', 400, 250)
        if (m) {
            //去掉前后的特殊符号
            m = m.replace(';', '').replace('?', '');

            //赋值并触发事件
            $("#vipcard").val(m).change();
        }
        $("#key").focus();
    });
    //收银
    $("#f2").click(function () {
        var channel = $("#channel").val();
        var ActPlanID = $("#ActPlanID").val();
        var ret = chkretail();
        if (channel == "") {
            alert("请选择成交渠道!");
            return false;
        }
        else if (ActPlanID != null && ActPlanID == "-1") {
            alert("请选择商场活动!");
            return false;
        }
        else if (ret != "") {
            alert("款式:" + ret + "没有选择购买楼层!");
            return false;
        }
        else {
            var html = ajax_rText("updRetail.aspx", "act=channel&channel=" + $("#channel").val());
            var html = ajax_rText("updRetail.aspx", "act=ActPlanID&ActPlanID=" + ActPlanID);
            ajax_rFocus(html, $(this));
        }

        //属于加盟编号00001下面的自营门店店铺在收银时，若更改其折扣小于实际跳出的折扣，需要强制填写备注！
        //        if (islow && $("#comment").val() == "" && $("#checkdisc").val() == "true") {
        //            alert("货品折扣小于系统默认折扣，请在备注中填写具体原因!");
        //            $("#comment").focus();
        //            return false;
        //        }

        //改成“强制说明打折/退货理由”设置
        //alert($("#checkdisc").val()); alert($("#checkclick").val());alert($('#changetype').val());
        if ($("#checkdisc").val() == "true" && parseInt($("#checkclick").val()) > 0 && checkdiscount()) {
            if ($('#changetype').val() == "0") {
                alert("请先选择打折/退货类别!");
                $('#changetype').focus();
                return false;
            }
            else if ($('#changetype').val() == "4" && $("#reason").val() == "") {
                alert("选择自定义，请在备注中填写具体原因!");
                $("#reason").focus();
                return false;
            }
            else {
                var comm = "打折";
                if (checkclick == "2") comm = "退货";
                //备注
                var reason = $('#changetype').val() == "4" ? $("#reason").val() : $("#txtdropreason").val();
                if (reason.length > 120) reason = reason.substr(0, 60);
                var html = ajax_rText("updRetail.aspx", "act=changetype&ReasonType=" + comm + ":" + $("#changetype option:selected").text() + "&reason=" + reason)
                ajax_rFocus(html, $(this))
            }
            if ($('#changetype').val() == "5" && $("#txtdropreason").val() == "") {
                alert("选择VIP积分选项，请填写具体原因!");
                $("#txtdropreason").focus();
                return false;
            }
        }
        if ($("#retail_thType").val() == "0") {

            if ($("#vipcard").val() != "") {
                ajax_vipbirthchk();
            }
            else {
                ajax_checkout(0, 0, true, true);     //执行收银判断 
            }
        } else {
            ajax_checkout(0, 0, true, false);    //退货状态，不计算促销与VIP
            //退货状态，不计算促销与VIP
        }
        $("#key").focus();
    });
    //抵吊牌价收银
    $("#f3").click(function () {
        var channel = $("#channel").val();
        var ActPlanID = $("#ActPlanID").val();
        var ret = chkretail();
        if (channel == "") {
            alert("请选择成交渠道!");
            return false;
        }
        else if (ActPlanID != null && ActPlanID == "-1") {
            alert("请选择商场活动!");
            return false;
        }
        else if (ret != "") {
            alert("款式:" + ret + "没有选择购买楼层!");
            return false;
        }
        ajax_checkout(0, 0, true, true, true);
        $("#key").focus();
    });
    //    //挂单
    //    $("#f3").click(function() {
    //        if ((openModal('../Modal/retail_save.aspx', 360, 150) == 1)) { ajax_retail(); ajax_read(1); }
    //        closevippic();
    //        $("#key").focus();
    //    });
    //取单
    $("#f4").click(function () {
        if ((openModal('../Modal/retail_get.aspx', 500, 350) == 1)) { ajax_retail(); ajax_read(1); }
        $("#key").focus();
    });
    //赠送
    $("#f5").click(function () {
        $("#key").focus();
        $("#hd_back").val(0);
        if ($("#hd_zs").val() == 1) {
            $("#key").css("background", '#FFF');
            $("#hd_zs").val(0);
        } else {
            $("#key").css("background", '#BFCAE6');
            $("#hd_zs").val(1);
        }
    });

    //整单打折
    $("#f6").click(function () {
        if ((openModal('../Modal/input_discount.aspx', 360, 120) == 1)) {
            //强制填写备注
            if (document.getElementById("changetype").options.length == 0) {
                $("#checkclick").val("1");
                ajax_dropdownlist();
            }

            ajax_read(1);
        }
        $("#key").focus();
    });
    //整单作废 
    $("#f7").click(function () {
        if (confirm('确认作废此单吗？')) {
            ajax_clear(true);
            //强制填写备注
            $("#checkclick").val("0");
            ajax_dropdownlist();
            // $("#checkclick").val(false);
        }
        $("#key").focus();
    });

    //输入VIP卡
    $("#f8").click(function () {

        var url = '../Modal/input_vipcard.aspx';
        var pos_vipshow = '<%=pos_vipshow%>';

        if (pos_vipshow.toLowerCase() == "true") {
            url = '../Modal/input_vipcardjm.aspx';
        }

        var m = openModal(url, 800, 350);
        if (m != undefined) {
            var ary = m.split("_");
            isChage = ary[1];
            $("#hid_vipcut").val("t");
            $("#vipcard").val(ary[0]).change();
            //$("#vipcard").val(m).change()
        }
        $("#key").focus();
    });
    //退货
    $("#f9").click(function () {
        $("#key").focus();
        $("#hd_zs").val(0);
        if ($("#hd_back").val() == 2) {
            $("#hd_back").val(0);
            $("#key").css("background", '#FFF');
        } else {
            $("#hd_back").val(2);
            $("#key").css("background", '#feb0d0');
        }
    });
    //手工输入 
    //    $("#f10").click(function() {
    //    if (openModal('../Modal/input_clothing.aspx?zs=' + $("#hd_zs").val() + '&back=' + $("#hd_back").val(), 500, 450) == 1) {
    //            ajax_read(1);
    //            $("#hd_zs").val(0);
    //            $("#hd_back").val(0);
    //            $("#key").css("background", '#FFF');
    //        }
    //        $("#key").focus();

    //    });

    //老V带新V
    $("#f10").click(function () {
        var m = openModal('../Modal/input_vipcardcheck.aspx', 380, 210);
        //alert(m);
        if (m != "" && m != undefined) {
            $("#oldnewyn").removeAttr("disabled", "disabled");
            $("#oldnewyn").attr("checked", "checked");
            $("#vipcard").val(m).change();
        }

        $("#f2").focus();
    });

    //整单退货
    $("#f11").click(function () {
        var m = openModal('../Modal/retail_back.aspx', 360, 160);
        //alert(m);
        if (m > 0) {
            if (m == "1" || m == "2") {
                //强制填写备注
                $("#checkclick").val("2");
            }
            else { $("#checkclick").val("0"); }
            //强制填写备注
            if (document.getElementById("changetype").options.length == 0) {
                ajax_dropdownlist();
            }

            ajax_retail();
            ajax_read(1);

            //加载VIP信息
            $("#vipcard").change();

            //alert($("#centum").text());
            //如果退货造成VIP积分为负，强制打折/退货类别选项值为VIP积分选项
            var nocentum = $("#nocentum").attr("checked");
            var totalcentum = $("#centum").text();
            var sssums = $("#ct_sums").text();
            if (nocentum && (parseFloat(totalcentum) + parseFloat(sssums)) < 0 && $("#vipcard").val() != "") {
                $("#lblchangetype").show();
                $("#changetype").show();
                $("#lblreason").show();
                //    $("#dropreason").show();
                $("#txtdropreason").show();
                $("#reason").hide();
                $("#changetype").val("5");
                $("#changetype").attr("disabled", "disabled");
            }
        }
        if ($("#retail_thType").val() == "0") {
            $("#key").focus();
        } else {
            $("#f2").focus();
        }
    });
    //查看VIP消费记录
    $("#f12").click(function () {
        if ($("#vipcard").val() != "") {
            openModal('../Modal/Vipinfo.aspx', 990, 450);
            $("#key").focus();
        } else {
            $("#vipcard").focus();
        }
    });

    //
    $("#key,#vipcard,#x_name,#shopcard,#channel,#comment,#daystat,#ActPlanID").keydown(function (e) {
        var key = window.event ? e.keyCode : e.which;
        if (key < 111 || key > 123) {
            $('#f2').attr('disabled', 'disabled');
        }
        if (key == 13 || key == 10) {
            $(this).change();
            return false;
        }
        else if (key == 38 || key == 40) {
            return false;    //解决内嵌浏览器上下键的问题
        }
    });

    //
    $("#key,#vipcard,#x_name,#shopcard,#channel,#comment,#daystat,#ActPlanID").blur(function () {
        if ($('#sub_body').find('tr').length > 0) $('#f2').removeAttr('disabled');


        return false;
    })
    //添加款
    $("#key").change(function () {
        var cl = $('#clothing_len').val();
        var id = $(this).val();
        var html = ajax_rText("addClothing.aspx", "clothingid=" + id.substring(0, (id.length - cl)) + "&zs=" + $("#hd_zs").val() + "&back=" + $("#hd_back").val() + "&nums=1")

        if (html) {
            //modify by jackie 2010-06-19 若查不到条码再查找是否为款式编号
            if (html.indexOf('styleid=') == 0) {
                var k = html.replace('styleid=', '');
                if (openModal('../Modal/input_clothing.aspx?zs=' + $("#hd_zs").val() + '&back=' + $("#hd_back").val() + '&key=' + k + '&ft=2', 500, 450) == 1) {
                    ajax_read(1);
                    $("#hd_zs").val(0);
                    $("#hd_back").val(0);
                    $("#key").css("background", '#FFF');
                }
                $("#key").focus();
            } else {
                alert(html);
            }
        } else {
            PlayScanSound();
            $("#hd_zs").val(0);
            $("#hd_back").val(0);
            ajax_read(1);
        }
        $(this).val('')
                    .focus()
                    .css("background", "#FFF");
    });
    //改日期
    $("#setdate").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=setdate&setdate=" + $(this).val())
        ajax_rFocus(html, $(this))
    });
    //改班次
    $("#x_name").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=x_name&x_name=" + $(this).val())
        ajax_rFocus(html, $(this))
    });
    //使用商场卡
    $("#shopcard").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=shopcard&shopcard=" + $(this).val())
        ajax_rFocus(html, $(this));
        ajax_read(1);
    });
    //修改成交渠道
    $("#channel").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=channel&channel=" + $(this).val())
        ajax_rFocus(html, $(this));
        ajax_read(1);
    });
    $("#ActPlanID").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=ActPlanID&ActPlanID=" + $(this).val())
        ajax_rFocus(html, $(this));
        ajax_read(1);
    });
    //修改是否积分
    $("#nocentum").click(function () {
        var val = $(this).attr("checked") ? 0 : 1;
        var html = ajax_rText("updRetail.aspx", "act=nocentum&nocentum=" + val);
        ajax_rFocus(html, $(this));
        ajax_read(1);
    });

    //改整单备注
    $("#comment").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=comment&comment=" + $(this).val())
        ajax_rFocus(html, $(this))
    });
    //改天气
    $("#daystat").change(function () {
        var html = ajax_rText("updRetail.aspx", "act=daystat&daystat=" + $(this).val())
        ajax_rFocus(html, $(this))
    });

    //改VIP卡
    $("#vipcard").change(function () {
        var m = $(this).val();
        if ($("#vipcut").val() == "1") {
            m = m.substr(eval($("#vipbeg").val()) - 1, $("#vipcnt").val());
        }
        if ($("#hid_vipcut").val() == "t") {
            m = $("#vipcard").val();
            $("#hid_vipcut").val(undefined);
        }
        var oldnewyn = 0;

        //是否老带新
        if ($("#oldnewyn").attr("checked")) {
            oldnewyn = 1;
        }

        if (m == "" || oldnewyn == 0) {
            $("#oldnewyn").attr("disabled", "disabled");
        }

        var html = ajax_rText("updRetail.aspx", "act=vip&vipcode=" + m + "&oldnewyn=" + oldnewyn + "&isUpdate=false");
        ajax_rFocus(html, $(this));

    });

    //是否老带新
    $("#oldnewyn").click(function () {
        $("#vipcard").val('').change();
    });
    //按键
    //document.onkeydown = KeyDown;


    $(document).bind('keydown', KeyDown);

    // $("#txtdropreason").val($("#dropreason").val());
    //    $("#dropreason").change(function () {
    //        $("#txtdropreason").val($("#dropreason").val());
    //    });
});

// key down
function KeyDown(e) {
    var key = window.event ? e.keyCode : e.which;
    if (key == 27) {
        if ($("#retail_thType").val() == "0") {
            $("#key").val('').focus();
        } else {
            $("#f2").focus();
        }
        return nokey();
    }
    else if (key > 111 && key <= 123) {
        if (!($("#f" + (key - 111) + "").attr('disabled'))) {
            $("#f" + (key - 111) + "").click();
        }
        return nokey();
    }
}

//焦点
function ajax_rFocus(html, _this) {
    var b = false;
    if (html.substr(0, 1) == "$") {
        eval(html);
        if (html.indexOf('alert') > 0)
            b = true;
        else
            b = false;
    } else if (html.length > 0) {
        alert(html);
        b = true;
    } else {
        b = false;
    }

    //焦点
    if (b) {
        $(_this).val('');
        $(_this).focus();
    } else {
        if ($("#retail_thType").val() == "0") {
            $("#key").focus();
        } else {
            $("#f2").focus();
        }
    }
}

//取得更新结果
function ajax_rText(url, data) {
    var html = $.ajax({
        url: "../ajax/" + url,
        type: "POST",
        data: data,
        async: false
    }).responseText;
    return html;
}

//清除界面
function ajax_clear(f) {
     $("#checkclick").val("0");
     ajax_dropdownlist();

    if (f) ajax_post(this, "updRetail.aspx", "act=clear", false, false);
    $("#sub_body").empty();
    $("#vipcard").val('');
    $("#vipname").text('-');
    $("#centum").text('0');
    $("#comment").val('');
    $("#shopcard").val('');
    $("#channel").val('');
    $("#ActPlanID").val('-1');
    $("#ActPlanID").attr("disabled", "");
    $("#nocentum").attr("checked", "checked");
    $("#retail_thType").val(0);
    $("#key").css("background", "#FFF");
    $("#hd_zs").val(0);
    $("#hd_back").val(0);
    $("#oldnewyn").attr("disabled", "disabled");
    $("#oldnewyn").removeAttr("checked", "checked");
    ajax_totalsum(true);
    closevippic();
}

//提交销售单
function ajax_checkout(runid, vipRunType, callback, cx, yj) {
    //alert($("#hd_back").val());
   // $("#checkclick").val(false);
    var path = "../AJAX/CHECKOUT.ASPX?_d=" + (new Date());
    //VIP是否打折
    var vipbdz = $("#chkvipbdz").attr("checked");
   
    var data =
    {
        "runid": runid,
        "vipRunType": vipRunType,
        "callback": callback,
        "cx": cx,
        "yj": yj || false,
        "vipbdz": vipbdz
    }


    // alert($("#chb_date").attr("checked"));
    //if($("#chb_date").attr("checked")){
    //data=data+"&sdate="+$("#setdate").val();
    //path=path+"&sdate="+$("#setdate").val();
    //  alert(path);
    // }
    $.ajax({
        url: path,
        //beforeSend: function() { $("#loading").show() },
        complete: function () {
            //$("#loading").hide();
            //$("#chb_date").attr("checked",false);
            //checkBoxEven("#chb_date");
            $("#key").focus();
            //强制填写备注
            //addselecttion();
           // $("#checkclick").val("0");
           // ajax_dropdownlist();
        },
        type: "POST",
        dataType: "script",
        data: data,
        error: function (o, msg) {
            alert("数据提交时发生错误！\n\n参考数据：\n" + data);
        }
    });
}

//移动光标改款
function jmove(e, t) {
    var k;

    if (window.event) {
        k = e.keyCode;
    } else if (e.which) {
        k = e.which;
    }
    if (k >= 37 && k <= 40) {
        var input = $("#sub_body").find("INPUT[type='text']");
        var m = 0;
        for (i = 0; i < input.length; i++) {
            if (input[i] == t) {
                m = i;
                break;
            }
        }
        if (k == 37) {
            m = m - 1;
        } else if (k == 38) {
            m = m - 4;
        } else if (k == 39) {
            m = m + 1;
        } else if (k == 40) {
            m = m + 4;
        }
        if (m >= 0 && m < input.length) {
            input[m].focus();
        }
        return false;
    }
    else if (k == 13 || k == 27) {
        $(t).change();
        $("#key").focus();
        return false
    }
}

//删除款
function ajax_del(id) {
    var html = ajax_rText("delClothing.aspx", "id=" + id);
    if (html) {
        alert(html);
    } else {
        var tbl = event.srcElement.parentNode.parentElement.parentElement;
        event.cancelBubble = true;
        with (event.srcElement.parentNode.parentElement) {
            if (tagName.toLowerCase() == "tr") tbl.deleteRow(rowIndex - 2);
        }
    }
    ajax_totalsum(true);
}
//更改款信息
function ajax_upd(id, act, _this, data) {
    if (_this.value.length > 0 || act == 'comment') {
        if (act == 'nums') {
            if (parseInt($(_this).val()) < 0) {
                alert('数量不能小于0!');
                ajax_read(1);
                event.returnValue = false;
                return;
            }
        }
        ajax_post(this, "updClothing.aspx", "id=" + id + "&act=" + act + "&" + act + "=" + _this.value + data, false, false);

        if (act == 'discount') {
            $(_this).val(Math.round($(_this).val() * 1000000) / 1000000);
            ajax_calc();
        }
        if (act == 'nums') {
            $(_this).val(parseInt($(_this).val()));
            ajax_calc();
        }
        if (act == 's_price') {
            $(_this).val(ajax_round(Math.round($(_this).val() * 100) / 100));
            ajax_calc();
        }
    }
    else {
        ajax_read(1);
    }
}

//提交处理
function ajax_post(obj, url, data, upd, upd2) {
    $.ajax({ url: "../AJAX/" + url,
        type: "post",
        dataType: "html",
        data: data,   //post过去的参数
        async: false,
        error: function (msg) {
            alert("数据加载错误!");
        },
        success: function (msg) {
            if (msg) {
                alert(msg); //发生错误，重新加载
                ajax_read(1);//如果有异常重新加载
                $(obj).focus();
                return false;
            }
            if (upd) { ajax_read(1); }
            if (upd2) { ajax_retail(); }
        }
    });
}
function addselecttion() {
    checkclick = $("#checkclick").val();
    //alert(checkclick);
    $("#changetype").empty(); //清空下拉框//$("#changetype").html('');
  //  $("#dropreason").empty();
    $("#txtdropreason").val("");
    $("#reason").val(""); //清空备注;
    $("#lblchangetype").hide();
    $("#changetype").hide();
    $("#lblreason").hide();
    $("#reason").hide();
    //$("#dropreason").hide();
    $("#txtdropreason").hide();
    
    if ($("#checkdisc").val() == "true") {
        $("<option value='跨年度积分已清零'>跨年度积分已清零</option>").appendTo("#dropreason")//vip积分选项原因
        $("<option value='积分已经兑换,顾客愿意补差价'>积分已经兑换,顾客愿意补差价</option>").appendTo("#dropreason")//vip积分选项原因
        $("<option value='顾客积分被异常挪用'>顾客积分被异常挪用</option>").appendTo("#dropreason")//vip积分选项原因
        $("<option value='系统漏洞，导致积分异常'>系统漏洞,导致积分异常</option>").appendTo("#dropreason")//vip积分选项原因
        if (checkclick == "1") {
            $("#lblchangetype").show();
            $("#changetype").show();
            $("<option value='0'></option>").appendTo("#changetype")
            $("<option value='1'>活动折扣</option>").appendTo("#changetype")//添加下拉框的option
            $("<option value='2'>特殊申请</option>").appendTo("#changetype")
            $("<option value='3'>退换货</option>").appendTo("#changetype")
            $("<option value='5'>VIP积分选项</option>").appendTo("#changetype")
            $("<option value='4'>自定义</option>").appendTo("#changetype")
        }
        else if (checkclick == "2") {
            $("#lblchangetype").show();
            $("#changetype").show();
            $("<option value='0'></option>").appendTo("#changetype")
            $("<option value='1'>操作错误</option>").appendTo("#changetype")//添加下拉框的option
            $("<option value='2'>顾客退货</option>").appendTo("#changetype")
            $("<option value='3'>顾客换货</option>").appendTo("#changetype")
            $("<option value='5'>VIP积分选项</option>").appendTo("#changetype")
            $("<option value='4'>自定义</option>").appendTo("#changetype")
        }
    }
}

function showselection(changetype, reason) {
    if (changetype.indexOf("打折") > -1) {
        $("#checkclick").val(1);
        ajax_dropdownlist(); 
        for (var i = 0; i < document.getElementById("changetype").options.length; i++) {
            if (document.getElementById("changetype").options[i].text == changetype.substring(3, changetype.length)) {
                document.getElementById("changetype").options[i].selected = true;
                if (i == 5) {
                    $("#lblreason").show();
                    $("#reason").show();
                    $("#reason").val(reason);
                } else if (i == 4) {
                    $("#lblreason").show();
                 //   $("#dropreason").show();
                    $("#txtdropreason").show();
                   // $("#dropreason").val(reason);
                }
            }
        }
    }
    if (changetype.indexOf("退货") > -1) {
        $("#checkclick").val(2);
        ajax_dropdownlist();
        for (var i = 0; i < document.getElementById("changetype").options.length; i++) {
            if (document.getElementById("changetype").options[i].text == changetype.substring(3, changetype.length)) {
                document.getElementById("changetype").options[i].selected = true;
                if (i == 5) {
                    $("#lblreason").show();
                    $("#reason").show();
                    $("#reason").val(reason);
                } else if (i == 4) {
                    $("#lblreason").show();
                  //  $("#dropreason").show();
                    $("#txtdropreason").show();
                   // $("#dropreason").val(reason);
                }
            }
        }
    }
}
//取强制填写备注信息
function ajax_dropdownlist() {
    checkclick = $("#checkclick").val();
    addselecttion();
    $("#changetype").unbind()//去除事件
    //选择自定义，强制填写
    $("#changetype").change(function () {
        selType = $('#changetype').val();
        var treason = "";
        //alert(selType); alert("aaaaaa");
        $("#reason").val("");
        if (selType == "4") {
            $("#lblreason").show();
            $("#reason").show();
            treason = $("#reason").val();
           // $("#dropreason").hide();
            $("#txtdropreason").hide();
        } else if (selType == "5") {
            $("#lblreason").show();
            $("#reason").hide();
           // $("#dropreason").show();
            $("#txtdropreason").show();
            treason = $("#txtdropreason").val();
        }
        else {
            $("#lblreason").hide();
            $("#reason").hide();
          //  $("#dropreason").hide();
            $("#txtdropreason").hide();
        }
        InputPosition();
        //更改备注信息
        if ($("#checkdisc").val() == "true" && parseInt($("#checkclick").val()) > 0) {
            //            if ($('#changetype').val() != "4") {
            //备注
            var comm = "打折";
            if (checkclick == "2") comm = "退货";
            var html = ajax_rText("updRetail.aspx", "act=changetype&ReasonType=" + comm + ":" + $("#changetype option:selected").text() + "&reason=" + treason);
            ajax_rFocus(html, $(this))
            //   }
        }
    }); 
}

function InputPosition() {
  //  $("#txtdropreason").css({ position: "absolute", 'left': $("#dropreason").offset().left, 'top': $("#dropreason").offset().top });
  //  $("#txtdropreason").val($("#txtdropreason").val());
}

//取零售列表
function ajax_read(data) {
    $.ajax({ url: "../AJAX/readClothing.aspx",
        //beforeSend: function() { }, //$("#loading").show();
        complete: function () {
            //$("#loading").hide(); 
            ajax_totalsum(true);
        },
        type: "post",
        dataType: "json",
        data: "cx=" + data,
        async: false,
        error: function (msg) {
            $("#sub_body").empty();
        },
        success: function (msg) {
            var json = msg["Head"];
            $("#sub_body").empty();
            $("#Button1").enabled = false;
            $.each(json, function (i, o) {
                var row = $("#sub_template").clone();
                //负值
                row.find("#sstyleid").html('<a href="#" onclick="return false" title="查看《' + o.s_name + '》详细">' + o.styleid + '</a>');
                row.find("#scolorid").text(o.colorid + o.c_name);
                row.find("#sname").text(o.s_name);
                row.find("#ssizeid").text(o.sizeid);
                row.find("#sub_nums").val(o.nums);
                if ($("#retail_yj").val() == "1") row.find("#sj_price").text(Math.round(o.j_price * 100) / 100);
                row.find("#sx_price").text(Math.round(o.x_price * 100) / 100);
                row.find("#sub_discount").val(Math.round(o.discount * 1000000) / 1000000);
                row.find("#sub_s_price").val(Math.round(o.s_price * 100) / 100);
                row.find("#sub_old_s_price").val(Math.round(o.olds_price * 100) / 100);
                row.find("#sx_sums").text(Math.round(o.xsums * 100) / 100);
                row.find("#ssums").text(Math.round(o.sums * 100) / 100);
                row.find("#sub_comment").val(o.comment);
                //by andy 20120528 添加款式时候的折扣
                row.find("#sub_olddiscount2").val(Math.round(o.olddiscount2 * 1000000) / 1000000);
                row.find("#sub_floor").val(o.buyfloor);

                if (o.comment == "退货.") {
                    row.find("#sub_comment").attr('readonly', 'readonly');
                }

                row.find("#sub_zskc").text(o.kc);
                row.find("#skc").html('<a href="#" onclick="return false" title="其它店铺库存">查看</a>');

                if ($("#retail_thType").val() == "0") {

                    //事件
                    row.find("#sub_del").click(function () { ajax_del(o.id) });

                    //查款详细
                    row.find("#sstyleid a").click(function () { openModal('../../pos/pos/f22/clothing.asp?id=' + o.clothingid, 600, 370) });
                    //查其它库存
                    row.find("#skc a").click(function () { openModal('../../pos/pos/f22/pos_dpkc.asp?id=' + o.clothingid, 600, 370) });

                    row.find("#sub_nums").change(function () { ajax_upd(o.id, 'nums', this, '') })
                                    .focus(function () { this.select() })
                                    .keydown(function () { return jmove(event, this) });

                    if ($("#retail_jsj").val() == "1") {
                        row.find("#sub_s_price").change(function () { ajax_upd(o.id, 's_price', this, '&x_price=' + o.x_price + '&olddiscount=' + o.olddiscount) })
                                .focus(function () { this.select() })
                                .keydown(function () { return jmove(event, this) });
                    } else {
                        if (row.find("#sub_comment").val() != "赠品") {
                            row.find("#sub_s_price").attr('readonly', 'readonly');
                        }
                        else {
                            row.find("#sub_s_price").change(function () { ajax_upd(o.id, 's_price', this, '&x_price=' + o.x_price + '&olddiscount=' + o.olddiscount) })
                                .focus(function () { this.select() })
                                .keydown(function () { return jmove(event, this) });
                        }
                    }

                    if ($("#retail_zk").val() == "1") {

                        row.find("#sub_discount").change(function () {
                            ajax_upd(o.id, 'discount', this, '&olddiscount=' + o.olddiscount)
                        })
                                                .focus(function () { this.select() })
                                                .keydown(function () { return jmove(event, this) });

                    } else {
                        row.find("#sub_discount").attr('readonly', 'readonly');
                    }

                    row.find("#sub_comment").change(function () { ajax_upd(o.id, 'comment', this, '') })
                                            .focus(function () { this.select() })
                                            .keydown(function () { return jmove(event, this) });

                    row.find("#sub_floor").change(function () { ajax_upd(o.id, 'buyfloor', this, '') });

                } else {
                    row.find("#sub_del").hide();
                    row.find("#sub_nums,#sub_discount,#sub_s_price,#sub_comment").attr('readonly', 'readonly');
                    row.find("#sub_floor").change(function () { ajax_upd(o.id, 'buyfloor', this, '') });
                }

                //颜色
                if (o.back == 'True') { row.addClass('row_back'); }
                if (o.zs == 'True') { row.addClass('row_zs'); }
                //显示
                row.appendTo("#sub_body");
                row.show();

            });
        }
    });

    if ($("#isvip").val() == 1) {
        $("#divvippic").show();
    }
    else {
        $("#divvippic").hide();
    }

}

//取主表信息
function ajax_retail() {
    $.ajax({ url: "../AJAX/readRetail.aspx",
        type: "post",
        dataType: "json",
        data: '',
        async: false,
        success: function (msg) {
            var json = msg["Head"];
            $.each(json, function (i, o) {
                $("#x_name").val(o.x_name);
                $("#shopcard").val(o.shopcard);
                $("#channel").val(o.channel);
                $("#ActPlanID").val(o.ActPlanID);
                $("#setdate.calendarSelectDate").val(strToDate(o.setdate));
                $("#vipcard").val(o.vipcode);
                $("#daystat").val(o.daystat);
                $("#comment").val(o.comment);
                $("#retail_thType").val(o.back);
                $("#vipname").text(o.vipname);
                $("#centum").text(o.centum);
                if (o.nocentum == "0") {
                    $("#nocentum").attr("checked", "checked");
                } else {
                    $("#nocentum").removeAttr("checked");
                }
                if (o.vipold != "") {
                    $("#vipcard").val(o.vipold);
                    $("#oldnewyn").removeAttr("disabled", "disabled");
                    $("#oldnewyn").attr("checked", "checked");
                } else {
                    $("#oldnewyn").attr("disabled", "disabled");
                    $("#oldnewyn").removeAttr("checked", "checked");
                }
                if (o.ReasonType.length > 0)
                { showselection(o.ReasonType, o.Reason); }
            });
        }
    });
}
//JS日期格式化
function strToDate(str) {
    var data = new Date(str);
    format = "yyyy-MM-dd";
    var o =
        {
            "M+": data.getMonth() + 1, //month
            "d+": data.getDate(),    //day
            "h+": data.getHours(),   //hour
            "m+": data.getMinutes(), //minute
            "s+": data.getSeconds(), //second
            "q+": Math.floor((data.getMonth() + 3) / 3), //quarter
            "S": data.getMilliseconds() //millisecond
        }

    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (data.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}


//改结算价等
function ajax_calc() {
    var e = event.srcElement;  //对象事件源
    var row = e.parentNode.parentNode;

    var tds = row.all.tags("td");
    var txts = row.all.tags("input");

    var sl = $(txts[0]).val();  //数量
    var zk = $(txts[1]).val();  //折扣
    var jsj = $(txts[2]).val(); //结算价

    //结算价 
    if (e.id == "sub_s_price") {
        if ($(tds[6]).text() != 0) {
            //强制填写备注
            if (document.getElementById("changetype").options.length == 0) {
                $("#checkclick").val("1");
                ajax_dropdownlist();
            }

            $(txts[1]).val(Math.round(($(txts[2]).val() / $(tds[6]).text()) * 1000000) / 1000000);
        }
    }
    //折扣
    if (e.id == "sub_discount") {
        //强制填写备注
        if (document.getElementById("changetype").options.length == 0) {
            $("#checkclick").val("1");
            ajax_dropdownlist();
        }

        $(txts[2]).val(ajax_round(Math.round($(tds[6]).text() * zk * 100) / 100));
    }
    //结算金额
    $(tds[9]).text(Math.round($(tds[6]).text() * sl * 100) / 100);
    $(tds[10]).text(Math.round($(txts[2]).val() * sl * 100) / 100);

    ajax_totalsum(false);
}

function ajax_round(val) {
    //四舍五入方式
    var rt = $("#round_type").val();
    var rb = $("#round_bit").val();
    /*四舍五入位数*/
    if (rt == 0 && rb == 0) {
        return Math.round(val * 1) / 1;
    }
    else if (rt == 0 && rb == 1) {
        return Math.round(val * 10) / 10;
    }
    else if (rt == 1) {
        /*只入不舍*/
        return Math.ceil(val);
    }
    else if (rt == 3) {
        /*只舍不入*/
        return Math.floor(val);
    }
    else {
        return val;
    }
}

//是否关掉没用的按钮
function ajax_disbtn(x) {
    if (x > 0) {
        $("#f2,#cf2").removeAttr('disabled')
    } else {
        $("#f2,#cf2").attr('disabled', 'disabled');
    }

    if ($("#retail_thType").val() != "0") {
        $("#key").attr('readonly', 'readonly');
        $("#clothing_len").attr('readonly', 'readonly');
        $("#vipcard").attr('readonly', 'readonly');
        //$("#f3").attr('disabled', 'disabled');
        //$("#f4").attr('disabled', 'disabled');
        $("#f5").attr('disabled', 'disabled');
        $("#f6").attr('disabled', 'disabled');
        $("#f9").attr('disabled', 'disabled');
        $("#f8").attr('disabled', 'disabled');
        $("#f10").attr('disabled', 'disabled');
        $("#f11").attr('disabled', 'disabled');
        $("#ActPlanID").attr('disabled', 'disabled');
    } else {
        $("#key").removeAttr('readonly');
        $("#clothing_len").removeAttr('readonly');
        $("#vipcard").removeAttr('readonly');
        $("#f8").removeAttr('disabled');
        $("#f10").removeAttr('disabled');
        $("#f11").attr('disabled', 'disabled');
        if (x > 0) {
            //$("#f3").removeAttr('disabled');
            //$("#f4").attr('disabled', 'disabled');
            if ($("#retail_dz").val() == "1") $("#f6").removeAttr('disabled');
            $("#f11").attr('disabled', 'disabled');
        } else {
            //$("#f3").attr('disabled', 'disabled');
            //$("#f4").removeAttr('disabled');
            $("#f6").attr('disabled', 'disabled');
            if ($("#retail_thh").val() == "1") $("#f11").removeAttr('disabled');
        }
        //赠送
        if ($("#retail_zs").val() == "0") {
            $("#f5").attr('disabled', 'disabled');
        } else {
            $("#f5").removeAttr('disabled');
        }
        //退货
        if ($("#retail_back").val() == "0") {
            $("#f9").attr('disabled', 'disabled');
        } else {
            $("#f9").removeAttr('disabled');
        }
      
        if ($("#oldvnewv").val() == "1") {
            $("#oldnewyn").show();
            $("#f10").show();
        }
    }

}

//统计
function ajax_totalsum(f) {

    var nums = 0;
    var xsums = 0;
    var sums = 0;
    var x = 0;
    $("#sub_body").find("tr").each(function (i, n) {
        x += 1;
        var tds = $(n).find("td");
        var txts = $(n).find("input");
        nums += parseInt(txts[0].value);  //数量
        xsums += (Math.round($(tds[9]).text() * 100) / 100); //结算价       
        sums += (Math.round($(tds[10]).text() * 100) / 100); //结算价
    });

    $('#ct_style').text(x);
    $('#ct_nums').text(nums);
    $('#ct_xsums').text((Math.round(xsums * 100) / 100));
    $('#ct_sums').text((Math.round(sums * 100) / 100));

    ajax_disbtn(x);

    if (f) $("#key").focus();
}
var islow = false;

//检查折扣
function checkdiscount() {
    islow = false;
    $("#sub_body").find("tr").each(function (i, n) {
        var tds = $(n).find("td");
        var txts = $(n).find("input");
        var x;
        for (var k = 0; k < txts.length; k++) { x += txts[k].value + ','; }
        var dis = txts[1].value; //修改后的折扣
        var disold = txts[8].value; //最初折扣
        if (parseFloat(dis) != parseFloat(disold)) {
            islow = true
            return islow;
        }
    });
    if (!islow) {
        var html = ajax_rText("updRetail.aspx", "act=changetype&ReasonType=&reason=");
        ajax_rFocus(html, $(this));
    }
    return islow;
};
//function f_query() {
//    try {
//        var ret = Trans1.OnTrans("QUE000000");
//        //处理返回值
//        if (ret.length >= 6) {
//            if (ret.substring(0, 6) == "000000") {
//                //查询成功
//                alert('查询余额成功');
//            }
//            else {
//                //失败信息提示
//                alert(getTransInfo(ret));
//            }
//        }
//        else if (ret.length == 0) {
//            //工行没有返回数据
//            alert('银行没有返回数据');
//        }
//        else {
//            alert('银行返回信息出错，返回数据为：“' + ret + '”'); //工行返回其它信息
//        }
//    }
//    catch (e) { alert("未安装工行刷卡控件!"); }
//}


function showvippic() {
    if ($("#showvip").val() == 1) {
        var y = document.getElementById("f12");
        $("#divvippic").css({ left: getDimX(y) + 98 });
        $("#divvippic").css({ top: getDimY(y) - 155 });
        $("#divvippic").show();
    }
}

function getDimX(el) {
    for (var lx = 0; el != null;
      lx += el.offsetLeft, el = el.offsetParent);
    return lx
}

function getDimY(el) {
    for (var ly = 0; el != null;
       ly += el.offsetTop, el = el.offsetParent);
    return ly
}

function closevippic() {
    $("#divvippic").hide();
}


//检查VIP是否可以进行生日优惠选择
function ajax_vipbirthchk() {

    var isbirth = 0;
    $.ajax({ url: "../AJAX/Vip/vipbirthchk.aspx",
        type: "post",
        dataType: "json",
        data: 'setdate=' + $("#setdate").val(),
        async: false,
        success: function (msg) {
            if (msg != 0) {
                var str = "myVar   =   msgbox('此顾客符合生日优惠条件，是否使用？',VbYesNo   +   VbQuestion   +   vbDefaultButton1,'确认')";
                window.execScript(str, "vbscript");
                if (myVar == "6") {
                    isbirth = 1;
                }
                else {
                    isbirth = 0;
                }
            }
            vipbirthsave(isbirth)
        }
    });
}


//保存使用生日状态
function vipbirthsave(isbirth) {

    $.ajax({ url: "../AJAX/Vip/vipbirthsave.aspx",
        type: "post",
        dataType: "json",
        data: 'isbirth=' + isbirth,
        async: false,
        success: function (json) {
            
            if (json.success == "1") {
                if (isbirth == 1 && json.BirthVerifyMsg == "True") {
                    SendVipMsg("vipbirth", $("#vipcard").val(), ajax_checkoutpre)
                } else {
                    ajax_checkoutpre();
                }
            } else {
                alert("保存生日状态失败:"+json.msg);
            }
        }
    });
}

function ajax_checkoutpre() {
    ajax_checkout(0, 0, true, true);     //执行收银判断 
}