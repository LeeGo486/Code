///var waiting = '<p> 请稍等.. </p>';
var disabledall = false;
$(function() {
    $(".TryAgain").live("click", function() {
        $(this).text("  重试保存，请稍等。。。");
        $(this).attr("disabled", "disabled");
    });

    $.extend($.blockUI.defaults, {
        message: '<b>请稍等……</b>',
        css: {
            textAlign: 'center',
            top: '40%',
            left: '40%',
            border: 'none',
            padding: '10px',
            width: '120px',
            backgroundColor: '#000',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px',
            opacity: .5,
            color: '#fff'
        },
        overlayCSS: {
            opacity: 0
        }
    });

    // $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

    $("#employeeid").val($("#TextBox3").val());
    //收银
    $("#F2").click(function() {
        disabledall = true;

        var dt = new Date();
        if ($("#severDay").val() != dt.getDate()) {
            alert("当前日期与服务器日期不一致.系统不允许收银,请您重新登录POS!");
            return false;
        }

        if ($(this).attr('disabled')) { return; }
        chgnum();
        //ajax_disbtn(false);
        //判断价格是否相等
        var index_cash = getPaymentIndex('现金');
        var index_bankcard = getPaymentIndex('刷卡');

        var row = $("#pbody").find("INPUT[name='sums']");

        var bank_sums = (parseFloat(row.eq(index_bankcard).val()) || 0)
        var bank_recodes = $("#PayCode").val();

        var tbsums = 0;
        $.each(row, function() {
            tbsums += (parseFloat($(this).val()) || 0);
        })

        tbsums = tbsums - parseFloat($('#Label3').text());

        //实收金额格式判断
        if ($('#TextBox2').val() != parseFloat($('#TextBox2').val())) {
            alert("实收金额格式错误！")
            $('#TextBox2').focus();
            //ajax_disbtn(true);
            return;
        }

        //总额相加判断
        else if ($('#Label6').text() != tbsums) {
            alert("收款方式每项金额之和与应收金额不一致！")
            row[index_cash].focus();
            //ajax_disbtn(true);
            return;
        }

        //销售员编号
        else if ($('#Label5').text() == "") {
            alert("请输入销售员编号！")
            $('#TextBox3').focus();
            //ajax_disbtn(true);
            return;
        }

        //退货情况刷卡，目前退货刷卡从现金走帐
        //            else if($("#thType").val() == "1" && bank_sums < 0 && bank_recodes.length < 6){
        //                isSave = false;
        //                var bank_sn = $("#pbody").find("INPUT[name='sn']");
        //                chkpay('PRA',$("#userid").val(),bank_sums,$(bank_sn[1]).val(),'');
        //            }

        //正常刷卡情况        
        else if ($("#thType").val() == "0" && bank_sums > 0 && bank_recodes.length < 6 && $("#UseBankCard").val() != 'false') {
            $("input[id!='F4']").attr("disabled", 'disabled');
            $(row.eq(index_bankcard)).attr('disabled', 'disabled');

            //工行多商户刷卡
            IcbcTran($("#userid").val(), bank_sums);
            //chkpay('PCA', $("#userid").val(), bank_sums, '', '');
            return;
        }

        //刷卡金额不能为负数
        // modify by jackie 20100820 刷卡金额小于0的情况下将值赋回给现金
        else if (bank_sums < 0) {
            alert("刷卡金额不能小于零！");
            var s = parseFloat(row[index_bankcard].value) || 0;
            s += parseFloat(row[index_cash].value) || 0;
            row[index_cash].value = s;
            row[index_cash].focus();
            row[index_bankcard].value = '';
            //ajax_disbtn(true);
            return;
        }
        ShowAjaxMsg("正在执行,请稍等。。。");

        //确认保存
        //if(confirm('确定收银吗？')){
        ajax_save();
        //}else{
        //ajax_disbtn(true);
        //}
    });
    //改实收金额
    $("#TextBox2").keydown(function() {
        if (event.keyCode == 13) {
            $(this).change();
            event.keyCode = 0
            event.cancelBubble = true;
            return false;
        }
    }).focus(function() {
        $(this).select();
    }).change(function() {
        if (!isNumber($(this).val())) {
            $(this).val($("#Label6").text());
            alert('实收金额格式错误！');
            $(this).focus();
        }

        $(this).val(Math.round($(this).val() * 100) / 100);
        if (parseFloat($(this).val()) < parseFloat($("#Label6").text())) {
            alert('实收金额不能少于应收金额！');
            $(this).val($("#Label6").text());
            $("#Label4").text(0);
            $(this).focus();
        } else {
            $("#Label4").text(Math.round(($(this).val() - $("#Label6").text()) * 100) / 100);
            $("#TextBox3").focus();
        }
    });
    //改营业员
    $("#TextBox3").keydown(function() {
        if (event.keyCode == 13) {
            $(this).change();
            event.keyCode = 0
            event.cancelBubble = true;
            return false;
        }
    }).focus(function() {
        $(this).select();
    }).change(function() {
        if ($(this).val().indexOf(",") > -1 || $(this).val().indexOf("，") > -1) {
            //            alert("只能录入一个营业员!");
            //            $("#TextBox3").val($("#employeeid").val());
            //            return false;
        }
        $.ajax({ url: "../AJAX/CHKEMPLOYEE.ASPX",
            type: "post",
            async: false,    //不允许同步做其它操作
            dataType: "json",
            data: "id=" + $(this).val(),
            error: function(msg) {
                alert('营业员查询出错!');
            },
            success: function(json) {
                $.each(json["Head"], function(i, o) {
                    $("#employeeid").val(o.employeeids);
                    $("#TextBox3").val(o.employeeids);
                    $("#Label5").text(o.names);
                    if (o.msg.length > 0) {
                        alert(o.msg);
                        $(this).focus();
                    } else {
                        $("#F2").focus();
                    }
                });
                return false;
            }
        });
    });
    //使用充值卡
    $("#F3").click(function() {
        if ($(this).attr('disabled')) { return; }
        var index_cash = getPaymentIndex('现金');
        var index_cashcard = getPaymentIndex('充值卡')
        var row = $("#pbody").find("INPUT[name='sums']");
        var xj = (parseFloat(row.eq(index_cash).val()) || 0);
        //var m = openModal('../Modal/input_cashcard.aspx?pay='+$("#Label6").text(),320,320);
        var m = openModal('../Modal/input_cashcard.aspx?pay=' + xj, 320, 320);
        var tbsums = $("#pbody").find("INPUT[name='sums']");
        var cardid = $("#pbody").find("INPUT[name='cardid']");
        if (m) {
            var x = m.split('$');
            var j = (parseFloat(tbsums[index_cash].value) - parseFloat(x[1])).toFixed(2);
            cardid[index_cashcard].value = x[0];
            tbsums[index_cashcard].value = x[1];
            if (j >= 0) tbsums[index_cash].value = j;
            $("#F2").focus();
        } else {
            cardid[index_cashcard].value = '';
            tbsums[index_cashcard].value = '';
        }
        chgnum();
        chgcash(this);
        return false;
    });
    //刷卡
    $("#F4").click(function() {
        if ($('#Label5').text() == "") {
            alert("请输入销售员编号！")
            $('#TextBox3').focus();
            return;
        }

        if ($(this).attr('disabled')) { return; }
        var tbsums = $("#pbody").find("INPUT[name='sums']");
        var index_cash = getPaymentIndex('现金');
        var index_bankcard = getPaymentIndex('刷卡');

        tbsums[index_bankcard].value = Math.round((parseFloat(reNumber($(tbsums[index_bankcard]).val()))
												 + parseFloat(reNumber($(tbsums[index_cash]).val()))) * 100) / 100;
        tbsums[index_cash].value = 0;
        $(tbsums[index_bankcard]).attr('disabled', 'disabled');
        $('#F2').click();
    });
    //积分抵扣
    $("#F5").click(function() {
        if ($(this).attr('disabled')) { return; }
        var pay = $("#Label6").text();
        var m = openModal('../Modal/input_convertjf.aspx?pay=' + pay, 500, 300);
        var tbsums = $("#pbody").find("INPUT[name='sums']");
        var cardid = $("#pbody").find("INPUT[name='cardid']");
        var comment = $("#pbody").find("INPUT[name='comment']");

        var index_cash = getPaymentIndex('现金');
        var index_centum = getPaymentIndex('积分抵扣');

        if (m) {
            var x = m.split('$');
            var j = parseFloat((parseFloat(pay) - parseFloat(x[1])).toFixed(2));
            if (x[1] == "" || x[1] == "0") {
                cardid[index_centum].value = "";
                tbsums[index_centum].value = "";
                comment[index_centum].value = "";
            } else {
                cardid[index_centum].value = x[0];
                tbsums[index_centum].value = parseFloat(x[1]);
                comment[index_centum].value = '扣减' + parseFloat(x[2]) + '积分';
            }
            if (j >= 0) tbsums[index_cash].value = j;
            $("#F2").focus();
        } else {
            cardid[index_centum].value = '';
            tbsums[index_centum].value = '';
            comment[index_centum].value = '';
        }
        chgnum();
        return false;

    });
    //抵值券
    $("#F6").click(function() {
        if ($(this).attr('disabled') || $(this).css('display') == "none") { return; }

        var m = openModal('../Modal/input_ticket.aspx?ttype=1', 600, 320);

        if (m) {
            var cash = $('#pbody').find("INPUT[name='sums']").eq(getPaymentIndex('现金'));  //应收总额
            var xj = $('#pbody').find("INPUT[name='sums']").eq(getPaymentIndex('现金券'));
            var dz = $('#pbody').find("INPUT[name='sums']").eq(getPaymentIndex('抵值券'));
            cash.val((parseFloat(cash.val()) || 0) + (parseFloat(xj.val()) || 0) + (parseFloat(dz.val()) || 0));
            xj.parents('tr').find(':text').val('');
            dz.parents('tr').find(':text').val('');
            var pay = cash.val();  //应收总额
            var jsums = $("#jsums").val();  //原价总额
            var zssums = $("#zssums").val();  //赠送优惠总额

            //分隔返回的值
            var x = m.split('$');
            //现金券
            var s = setVipTicketSums(getPaymentIndex('现金券'), x[1], pay, "总面值：" + x[1]);

            //抵值券计算公式
            //var t = Math.ceil((pay / (jsums - zssums)) * x[0]);
            //抵值券
            //if (s > 0) pay = parseFloat(reNumber(pay)) - parseFloat(reNumber(s));
            //setVipTicketSums(getPaymentIndex('抵值券'), t, pay, "总面值：" + x[0]);
            $("#F2").focus();
        }

        chgnum();
        return false;
    });
    //选择营业员
    $("#F8").click(function() {
        var m = openModal('../Modal/input_employee.aspx?e=' + $("#TextBox3").val(), 450, 320);
        if (m) {
            var x = m.split('$');
            $("#TextBox3").val(x[0]);
            $("#employeeid").val(x[0]);
            $("#Label5").text(x[1]);
        }
        return false;
    })
    //		
    //		//收款方式
    //		$("#F9").click(function()
    //		{
    //		    
    //			 if($(this).attr('disabled')){return;}
    //			 $.each($("#pbody").find("TR"), function(){
    //				var retype = $(this).find("TD:first").text();
    //				var sums = $(this).find("INPUT[name='sums']");
    //				var crtype = $(this).find("[name='crtype']");
    //				var cardid = $(this).find("INPUT[name='cardid']");
    //				var comment = $(this).find("INPUT[name='comment']");
    //				var sn = $(this).find("INPUT[name='sn']");
    //				
    //						if(retype=='现金')
    //						{
    //						 sums.focus();
    //						}
    //				});
    //			
    //		});
    //取消
    $("#Button2").click(function() {
        window.close();
    });
    initPayment();

    $(document).bind('keydown', KeyDown);

});

//移动光标改款
function jmove(e, t) {

    var k = window.event ? e.keyCode : e.which;

    //回车变成换行
    //if (k==13)
    //{
    //  k=40;
    //}

    if (k == 38 || k == 40) {

        var input = $("#pbody").find("INPUT[name='" + $(t).attr('name') + "']");
        var m = 0;
        for (i = 0; i < input.length; i++) {
            if (input[i] == t) {
                m = i;
                break;
            }
        }
        if (k == 38) {
            m = m - 1;
        } else if (k == 40) {
            m = m + 1;
        }

        if (m >= 0 && m < input.length) {
            input[m].focus();
        }
        else {
            input[0].focus();
        }
    }
    else if (k == 13 || k == 27) {
        chgnum();
        $("#F2").focus();
        event.keyCode = 0;
        event.cancelBubble = true;
        return false;
    }

}
var cashindex = 0;
//加载收款方式
function initPayment() {
    $.ajax({
        url: "../AJAX/CHECKOUT_SUB.ASPX",
        type: "POST",
        dataType: "json",
        data: '',
        error: function (x) {
            alert('收款方式加载出错!');
        },
        success: function (msg) {
            $("#pbody").empty();
            var tbsums = 0;
            var readonlyArr = ['充值卡', '积分抵扣', '促销优惠', '现金券', '抵值券'];
            var json = msg["Head"];
            $.each(json, function (i, o) {
                //收款方式
                var retype = $.trim(o.retype);
                //收款方式按钮
                switch (retype) {
                    case '现金': cashindex = i; $('#F2').removeAttr('disabled');
                        break;
                    case '充值卡': if ($("#thType").val() != "1") $('#F3').removeAttr('disabled');
                        break;
                    case '刷卡': if ($("#thType").val() != "1") $('#F4').removeAttr('disabled');
                        break;
                    case '积分抵扣': if ($('#vipcode').val() != '' && $("#thType").val() != "1") $('#F5').removeAttr('disabled');
                        break;
                    case '现金券': if ($("#thType").val() != "1" && parseFloat($("#Label6").text()) > 0) $('#F6').removeAttr('disabled');
                        break;
                    //modify by jackie 20100603 抵值券移至收银界面                   
                    //case '抵值券': if ($("#thType").val() != "1") $('#F6').removeAttr('disabled');                   
                    //    break;                   
                }
                //行
                var row = $('<tr />');
                ///控件

                //判断有刷卡金额不是允许修改的
                if(o.retype == "刷卡" && o.sums != "")
                    var input_sums = $('<input name="sums" style="width:60px" class="text" readonly="readonly" style="background:#f2f3f4;" />'); //金额
                else
                    var input_sums = $('<input name="sums" style="width:60px" class="text" />'); 		//金额

                var input_cardid = $('<input name="cardid" style="width:90px;background:#f2f3f4;" readonly="readonly" />'); //卡号
                if (o.retype == "刷卡") {
                    var input_comment = $('<input name="comment" style="width:60px" class="text" /><span id="btnIsCash" onclick="SelIsCahs()" title="选择已刷卡成功，但未收银成功记录">已刷卡</span>'); //备注
                } else {
                    var input_comment = $('<input name="comment" style="width:100px" class="text" />'); //备注
                }
                var input_crtype = $('#crtype').clone(); 	//币种
                var input_sn = $('<input type="hidden" name="sn" />'); //序列

                //添加控件的事件
                input_sums.focus(function () { $(this).select() })
									.keydown(function () { return jmove(event, this) })
									.change(function () { chgnum(this) })
									.keyup(function () { chgcash(this) });
                input_crtype.keydown(function () { return jmove(event, this) })
                input_cardid.focus(function () { $(this).select() }).keydown(function () { return jmove(event, this) })
                input_comment.focus(function () { $(this).select() }).keydown(function () { return jmove(event, this) })

                //整单退货情况 
                if ($("#thType").val() == "1") {
                    //整单退货情况下或设定不可修改值范围内SUMS值不能修改
                    input_sums.attr('readonly', 'readonly').css({ 'background': '#f2f3f4' });
                    //整单退货时退到现金的付款方式
                    if ($.inArray(retype, ['other', '现金券', '抵值券', '刷卡']) > 0) {
                        // if ($.inArray(retype, ['other','刷卡']) > 0) {
                    }
                    else {
                        input_sums.val(((Math.round(o.sums * 100) / 100) || ''));
                        input_crtype.val(o.crtype);
                        input_cardid.val(o.cardid);
                        input_comment.val(o.comment); //备注
                    }
                }
                else {
                    //刷卡特殊处理
                    if (retype == '刷卡') {
                        input_sums.val(((Math.round(o.sums * 100) / 100) || ''));
                        input_cardid.val(o.cardid);
                        $("#PayCode").val(o.comment);
                        input_sn.val(o.sn);
                    }

                    if (retype == '促销优惠') {
                        input_sums.val(((Math.round(o.sums * 100) / 100) || ''));
                    }

                    if (retype == '抵值券') {
                        var dz = parseFloat(o.sums) || 0;
                        if (dz > 0) {
                            var wf = parseFloat($('#Label6').text()) || 0;
                            dz = dz > wf ? wf : dz;
                            input_sums.val(((Math.round(dz * 100) / 100) || ''));
                            input_comment.val("总面值：" + o.sums);
                            $('#F6').hide();
                        }
                    }

                    //只读模式的输入框
                    if ($.inArray(retype, readonlyArr) >= 0) {
                        input_sums.attr('readonly', 'readonly').css({ 'background': '#f2f3f4' });
                    }
                }

                //单元格
                $('<td />').append(retype).appendTo(row);
                $('<td />').append(input_sums).appendTo(row);
                $('<td />').append(input_crtype).appendTo(row);
                $('<td />').append(input_cardid).appendTo(row);
                $('<td />').append(input_comment).append(input_sn).appendTo(row);
                row.appendTo("#pbody");
            });

            //合计
            chgnum();
            var wf = (parseFloat($("#wfsums").text()) || 0);
            if (wf != 0) {
                var cashInput = $('#pbody').find("INPUT[name='sums']").eq(getPaymentIndex('现金'));
                cashInput.val((parseFloat(cashInput.val()) || 0) + wf);
                chgnum();
            }

        }
    });
}
//是否失效按钮
function ajax_disbtn(b) {
    /*		if(b)
    {
    $("#F2").val('收　银[F2]');
    $("#F2,#Button2").removeAttr('disabled');
    if($("#thType").val()!="0"){
    $("#F3,#F4,#F5").attr('disabled','disabled');
    }else{
    $("#F3,#F4,#F5").removeAttr('disabled');
    }
				
    //if(!testmode) $("#F4").hide();
    //$("#F4").attr('disabled','disabled').attr('title','WEB刷卡功能未开放使用！');
    if($('#PayCode').val()!="") $("#F4").attr('disabled','disabled').attr('title','不能重复使用刷卡功能！');
				
    //if(!useCashCard) $("#F3").hide();
    //if(!useScore) $("#F5").hide();
    //if(!useTicket) $("#F6").hide();
				
    }
    else
    {
    $("#F2").val('请稍等...');
    $("#F2,#Button2,#F3,#F4,#F5").attr('disabled','disabled');
    }
    */
}
///AJAX提交
function ajax_save() {
    //打包数据
    var bank_recodes = $('#PayCode').val();
    var bank_sums = 0;
    var bank_cardid = "", bank_sn = ""
    var ys = $('#Label6').text() || 0;           //应收
    var s_sums = $('#TextBox2').val() || 0;      //实收
    var z_sums = $('#Label4').text() || 0;       //找回
    var employeeids = $('#TextBox3').val() || ""; //营业员
    var nums = $('#Label2').text() || 0;         //数量
    var saler = $('#Label5').text() || "";        //营业员名称
    var cxyh = $('#Label3').text() || 0;         //找回

    var sk_retype = "", sk_skje = "", sk_crtype = "", sk_cardid = "", sk_comment = "", sk_sn = "";

//    if (employeeids.indexOf(',') > -1) {
//        alert("只能选择一个营业员!");
//        $('#TextBox3').focus();
//        return false;
//    }
    try {

        if (bank_recodes.length > 50) {
        bank_cardid = getRecordStr(bank_recodes, 2,19);                   //银行卡号
        bank_sn = getRecordStr(bank_recodes, 53, 8);                      //检索号
        bank_sums = parseFloat(getRecordStr(bank_recodes, 65, 12) / 100);    //消费金额
    }
 
        $.each($("#pbody").find("TR"), function() {
        var retype = $(this).find("TD:first").text();
        var sums = $(this).find("INPUT[name='sums']");
        var crtype = $(this).find("[name='crtype']");
        var cardid = $(this).find("INPUT[name='cardid']");
        var comment = $(this).find("INPUT[name='comment']");
        var sn = $(this).find("INPUT[name='sn']");
        if ((parseFloat(sums.val()) || 0) != 0) {
            if (retype == '刷卡' && $("#UseBankCard").val() != 'false') {
                cardid.val(bank_cardid);
                sn.val(bank_sn);
                sums.val(bank_sums).attr('readonly', 'readonly'); //刷卡了不能修改金额
            }
            if (retype == '促销优惠') {
                //cxyh = sums.val(bank_sums) ? 
                cxyh = sums.val();

            }
            sk_retype += retype + " |";
            sk_skje += sums.val() + " |";
            sk_crtype += crtype.val() + " |";
            sk_cardid += cardid.val() + " |";
            sk_comment += comment.val().replace('|', ' ') + " |";
            sk_sn += sn.val() + " |";
        }
    });

        var data = { "ys": ys, "saler": saler, "nums": nums, "s_sums": s_sums, "employeeids": employeeids,
            "retype": sk_retype, "skje": sk_skje, "crtype": sk_crtype, "cardid": sk_cardid,
            "comment": sk_comment, "sn": sk_sn, "yhje": cxyh,
            "bank_recodes": bank_recodes, "bank_sums": bank_sums, "bank_cardid": bank_cardid
        };

        if (data.ys == null || data.ys == undefined) {
            alert("应收金额传入失败，请重试！");
            return false;
        }

        data = $.param(data);

    } catch (e) {
        alert(e.Description);
        return false;
    }

    //alert(data)
    //传送数据
    $.ajax({
        url: "../AJAX/CHECKOUT_SAVE.ASPX",
        type: "POST",
        beforeSend: function() {
            disabledall = true;
            //$.blockUI({ message: waiting })
        },
        complete: function() {
            disabledall = false;
            //$.unblockUI();
        },
        dataType: "script",
        data: data,
        error: function(xml, e) {
            var err = "";
            try {
                obj = $.evalJSON(xml.responseText);
                err += obj.Message;
            } catch (e) {
                try {
                    var str = xml.responseText;
                    var l = str.indexOf('<title>') + 7;
                    var r = str.indexOf('</title>');
                    err += str.substring(l, r);
                } catch (e) {
                    err += '未知的错误!';
                }
            }
            alert('零售单提交时超时或出现错误！\n错误信息：\n' + err);
            //ajax_disbtn(true);
        }
    });
}
//取得付款方式序号
function getPaymentIndex(retype) {
    var index = -1;
    $.each($("#pbody").find("tr"), function(i) {
        var txt = $(this).find("td:first").text();
        if ($.trim(txt) == $.trim(retype)) {
            index = i;
            return;
        }
    })
    return index;
}
//使用电子券后...
function setVipTicketSums(n, sums, pay, cmText) {
    var osums = sums;
    var tbsums = $("#pbody").find("INPUT[name='sums']");
    var comment = $("#pbody").find("INPUT[name='comment']");
    var index_cash = getPaymentIndex('现金');

    if (parseFloat(pay) < parseFloat(sums)) sums = pay;
    tbsums[index_cash].value = parseFloat((parseFloat(pay) - parseFloat(sums)).toFixed(2));

    if (sums == "" || sums == "0") {
        tbsums[n].value = "";
        comment[n].value = "";
    }
    else {
        tbsums[n].value = parseFloat(sums);
        comment[n].value = cmText;
    }

    return sums;
}
//更改收款方式金额
function chgnum(t) {
    if (t) {
        if (t.value == parseFloat(t.value)) {
            t.value = Math.round(parseFloat(t.value) * 100) / 100;
        } else {
            t.value = '';
        }
    }
    var row = $("#pbody").find("INPUT[name='sums']");
    var tbsums = 0;
    for (i = 0; i < row.length; i++) {
        tbsums += parseFloat(reNumber(row[i].value));
    }

    var lb6 = reNumber($('#Label6').text());
    $("#hjsums").text(tbsums.toFixed(2));

    var yh = 0;
    if ($('#Label3').text() != '') {
        yh = parseFloat($('#Label3').text());
    }
    //整单退货情况 
    if ($("#thType").val() == "1") {
        $("#wfsums").text((parseFloat(lb6) - tbsums + yh).toFixed(2));
    } else {

        $("#wfsums").text((parseFloat(lb6) - tbsums + yh).toFixed(2));
    }

}

function chgcash(t) {


    if (t) {
        var row = $("#pbody").find("INPUT[name='sums']");
        var tbsums = 0;
        var notcash = 0;

        for (i = 0; i < row.length; i++) {

            if (i != cashindex) {
                notcash += parseFloat(reNumber(row[i].value));
            }
            tbsums += parseFloat(reNumber(row[i].value));
        }
        var cash = parseFloat($('#Label6').text()) - parseFloat(notcash) + parseFloat($('#Label3').text());

        if (parseFloat($("#Label6").text()) >= 0) {

            if (cash < 0) {
                alert("收款金额录入错误,收款金额不等于应收金额！");
                return;
            }
            else {
                $(row[cashindex]).val(cash);
            }
        }
        else {
            if (cash > 0) {
                alert("收款金额录入错误,收款金额不等于应收金额！");
                return;
            }
            else {
                $(row[cashindex]).val(cash);
            }
        }

    }
}

//刷卡事件
function chkpay(act, userid, sums, sn, pc) {
    //需要的所有参数都不为空的情况下，才能进行下一步
    if (userid != "" && sums != "" && act != "") {
        var InStr = "";
        sums = parseFloat(sums);
        if (sums == 0) {
            alert('消费金额不能为0!');
            //ajax_disbtn(true);
        }
        else {
            sums = parseInt(Math.abs(sums * 100));      //以分为单位
            sums = padLeft(sums, 12);                  //左补0填充到12位
            InStr = act + padLeft(userid, 6) + sums + padLeft(sn, 6) + padLeft(pc, 6);
            if (InStr.length > 0) {
                //ajax_disbtn(false);
                try {
                    //调用工行刷卡控件
                    var ret = Trans1.OnTrans(InStr);
                    //var ret = "000000120404081181   004     556222305012620870   00000821    03220955231310000000                003666000000000000013900";
                    chkTrans(ret, InStr);
                }
                catch (e) {
                    alert('调用工行控件时出错，请确定是否安装了工商刷卡控件或与管理员联系!');
                    //ajax_disbtn(true);
                    return;
                }
            }
            else {
                alert('传入参数格式错误!');
                //ajax_disbtn(true);
            }
        }
    }
    else {
        alert('传入参数不能为空!');
        //ajax_disbtn(true);
    }
}

//处理刷卡返回的信息
function chkTrans(ret, InStr) {

    //处理返回值
    if (ret.length >= 6) {
        if (ret.substring(0, 6) == "000000") {
            icbclogsave(getTransInfo(ret), ret, InStr, ajax_save);      //交易成功
            //ajax_disbtn(false);
            $("#PayCode").val(ret);
        }
        else {
            icbclogsave(getTransInfo(ret), ret, InStr);     //失败信息提示
            $("#PayCode").val("");
            alert(getTransInfo(ret));
            //ajax_disbtn(true);
        }
    }
    else if (ret.length == 0) {
        icbclogsave('银行没有返回数据!', ret, InStr);       //工行没有返回数据
        alert('银行没有返回数据');
        //ajax_disbtn(true);
    }
    else {
        icbclogsave('没有收到银行返回信息!', ret, InStr);       //工行没有返回数据
        alert('银行返回信息出错，返回数据为：“' + ret + '”'); //工行返回其它信息
        //ajax_disbtn(true);
    }
}


////保存工行控件刷卡日志
//function icbclogsave(msg, ret, InStr, callback) {
//    $.ajax({
//        url: "../AJAX/ICBCLOG_SAVE.ASPX",
//        type: "POST",
//        cache: false,
//        dataType: "html",
//        data: 'r=' + ret + '&i=' + msg + '&s=' + InStr,
//        //success: function(msg) { },
//        complete: function() {
//            if (typeof callback == 'function') {
//                callback();
//            }
//        }
//    });
//}

//按键
function KeyDown() {
    with (event) {
        if (keyCode == 113) {//F2键收银
            if (!disabledall) $('#F2').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }
        if (keyCode == 114) {//F3充值卡
            if (!disabledall) $('#F3').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }

        if (keyCode == 115) {//F4刷卡
            if (!disabledall) $('#F4').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }

        if (keyCode == 116) {//F5积分抵扣
            if (!disabledall) $('#F5').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }

        if (keyCode == 117) {//F6使用现金券
            if (!disabledall) $('#F6').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }
        //				
        //				if(keyCode==120){//F7改变收款方式
        //						if(!disabledall) $('#F9').click();
        //						event.keyCode = 0; 
        //						event.cancelBubble = true; 
        //						return false;
        //				}

        if (keyCode == 27) {//ESC返回输入状态
            if (!disabledall) document.getElementById('Button2').click();
            event.keyCode = 0;
            event.cancelBubble = true;
            return false;
        }
    }
}

//liangyu 200906
var wnd;
function BeginPrint(obj) {
    if (obj.contentWindow.document.readyState == 'complete') {
        //obj.contentWindow.document.getElementById('btnPrint').click();
        //            var wnd = window.open(obj.url,'','');
        wnd = window.open('about:blank', 'newwindow', 'height=520, width=650, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');
        //            openModal(obj.url,450,420);
        wnd.location = obj.url;
        //            window.close();

        setInterval(function() { closeself() }, 100);

    }
}
function closeself() {

    try {
        var v2 = wnd.location.toString().split('?');
    }
    catch (e) {

        self.close();
    }
}
