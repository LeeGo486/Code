var _errmsg = "", _sums = 0, _busicode = "", _ret = "", _InStr = "", _msg="";

//签到
function openTrans() {
    try {
        var busicode = $("#busicode").val();
        if (busicode == "") { alert("工行MIS业务编号未设置，请联系管理员！"); return; }
        var ret = document.ocx.DoICBCZJMisTranSTD_Multi("4001", "", "", "", "", busicode);

        if (ret.substring(0, 2) == "00") {
            alert("签到成功!");
        } else {
            alert("签到失败：" + ret);
        }
    } catch (e) {
        if (confirm("调用插件失败：" + e.Description + ",是否确认重新下载？"))
            window.open("/setup/IcbcInstall.exe");
    }
}

//余额查询
function f_query() {
    try {
        var busicode = $("#busicode").val();
        var ret = document.ocx.DoICBCZJMisTranSTD_Multi("2002", "", "", "", "", busicode);
        if (ret.substring(0, 2) == "00") {
            alert("余额查询成功!");
        } else {
            alert("余额查询失败：" + ret);
        }
    } catch (e) {
        if (confirm("调用插件失败：" + e.Description + ",是否确认重新下载？"))
            window.open("/setup/IcbcInstall.exe");
    }
}

function IcbcTran(userid, sums) {
    if (sums <= 0) {
        alert("刷卡金额必须大于零！");
        ButEnabled();
        return;
    }
    var PayCode = $('#PayCode').val() || "";

    try {
        if (PayCode.length >= 50 && PayCode.substr(0, 2) == "00") {
            //如果有刷卡记录，就直接收银
            ajax_save();
        } else {
            _busicode = $("#busicode").val();
            _sums = sums * 100;
            beforeSave();
        }
    } catch (e) {
        var errmsg = "刷卡失败。错误：" + e.description;
        alert(errmsg);

        if (confirm("刷卡失败：" + e.description + ",是否确认重新下载？"))
            window.open("/setup/IcbcInstall.exe");
        ButEnabled();
    }
}

//调用前保存
function beforeSave() {
    setTimeout(function() {
        _InStr = 'document.ocx.DoICBCZJMisTranSTD_Multi("1001", "AMT1=' + _sums + '", "", "", "", "' + _busicode + '")';
        var result = icbclogsave("", "", _InStr, MisTran);
        if (!result) {
            ShowAjaxMsg("保存刷卡前信息失败：" + _errmsg + "<p>请勿关闭当前页面，点击<a class='TryAgain' onclick='beforeSave();'>&nbsp;&nbsp;重试&nbsp;&nbsp;</a></p>");
        } 
    }, 100);
}

//调用刷卡
function MisTran() {
    ShowAjaxMsg("开始刷卡。。。");
    var ret = document.ocx.DoICBCZJMisTranSTD_Multi("1001", "AMT1=" + _sums, "", "", "", _busicode);
    ShowAjaxMsg("刷卡已完成,正在保存银行返回信息，请稍等。。。银行返回值为：" + ret);

    _ret = ret;
    //获取响应码 00 表示成功，其它表示失败。
    var code = ret.substring(0, 2);

    if (isNaN(code)) {
        $('#PayCode').val("");
        _msg = "刷卡失败，错误信息为：" + _ret.substring(2, 500);
        alert(_msg);
        ErrorSave();
        ButEnabled();
    }
    else if (code == "00") {
        $('#PayCode').val(ret);
        _msg = getTranInfo(code);
        SuccessSave();
    }
    else {
        _msg = getTranInfo(code);
        alert(_msg);
        ErrorSave();
        $('#PayCode').val("");
        ButEnabled();
    }
}

//刷卡成功保存
function SuccessSave() {
    setTimeout(function() {
        var result = icbclogsave(_msg, _ret, _InStr, ajax_save);
        if (!result) {
            ShowAjaxMsg("保存刷卡返回信息失败：" + _errmsg + "<p>请勿关闭当前页面，点击<a class='TryAgain' onclick='SuccessSave();'>&nbsp;&nbsp;重试&nbsp;&nbsp;</a></p>");
        }  
    },100);
}

//刷卡失败保存
function ErrorSave() {
    setTimeout(function() {
        var result = icbclogsave(_msg, _ret, _InStr, null);
        if (!result) {
            ShowAjaxMsg("保存刷卡返回信息失败：" + _errmsg + "<p>请勿关闭当前页面，点击<a class='TryAgain' onclick='ErrorSave()'>&nbsp;&nbsp;重试&nbsp;&nbsp;</a></p>");
        } else {
            ButEnabled();
        }
    }, 100);
}


//保存工行控件刷卡日志
function icbclogsave(msg, ret, InStr, callback) {
    var success = false;
    $.ajax({
        url: "../AJAX/ICBCLOG_SAVE.ASPX",
        type: "POST",
        cache: false,
        dataType: "html",
        async: false,
        data: 'r=' + escape(ret) + '&i=' + escape(msg) + '&s=' + escape(InStr),
        error: function (xml, str) {
            _errmsg = str;
        },
        success: function (json) {
            json = eval("(" + json + ")");
            if (json.success == 0) {
                _errmsg = json.msg;
                return false;
            } else {
                success = true;
            }

            if (typeof callback == 'function') {
                callback();
            }
        }
    });
    return success;
}

//调用工行返回代码描述
function getTranInfo(id) {
    var code = new Array();
    var info = new Array();

    code[0] = "00";
    code[1] = "01";
    code[2] = "02";
    code[3] = "03";
    code[4] = "04";
    code[5] = "05";
    code[6] = "06";
    code[7] = "07";
    code[8] = "08";
    code[9] = "09";
    code[10] = "10";
    code[11] = "11";
    code[12] = "12";
    code[13] = "13";
    code[14] = "14";
    code[16] = "16";
    code[17] = "17";
    code[18] = "18";
    code[19] = "19";
    code[21] = "21";
    code[22] = "22";
    code[23] = "23";
    code[24] = "24";
    code[25] = "25";
    code[26] = "26";
    code[27] = "27";
    code[28] = "28";
    code[29] = "29";
    code[30] = "30";
    code[32] = "32";
    code[33] = "33";
    code[34] = "34";
    code[35] = "35";
    code[36] = "36";
    code[37] = "37";
    code[38] = "38";
    code[39] = "39";
    code[41] = "41";
    code[42] = "42";
    code[43] = "43";
    code[45] = "45";
    code[46] = "46";
    code[47] = "47";
    code[49] = "49";
    code[51] = "51";
    code[52] = "52";
    code[53] = "53";
    code[54] = "54";
    code[55] = "55";
    code[56] = "56";
    code[57] = "57";
    code[58] = "58";
    code[59] = "59";
    code[60] = "60";
    code[61] = "61";
    code[62] = "62";
    code[63] = "63";
    code[64] = "64";
    code[65] = "65";
    code[66] = "66";
    code[67] = "67";
    code[68] = "68";
    code[69] = "69";
    code[70] = "70";
    code[71] = "71";
    code[72] = "72";
    code[73] = "73";
    code[74] = "74";
    code[75] = "75";
    code[76] = "76";
    code[77] = "77";
    code[78] = "78";
    code[81] = "81";
    code[82] = "82";
    code[83] = "83";
    code[84] = "84";
    code[85] = "85";
    code[87] = "87";
    code[88] = "88";
    code[89] = "89";
    code[90] = "90";
    code[91] = "91";
    code[92] = "92";
    code[93] = "93";
    code[94] = "94";
    code[95] = "95";
    code[96] = "96";
    code[97] = "97";
    code[98] = "98";
    code[99] = "99";

    info[0] = "交易成功";
    info[1] = "终端未签到";
    info[2] = "终端不可用";
    info[3] = "终端已签到";
    info[4] = "销售终端未签到";
    info[5] = "非法卡";
    info[6] = "过期卡";
    info[7] = "止付卡";
    info[8] = "密码错请重输";
    info[9] = "未知交易";
    info[10] = "非止付卡";
    info[11] = "止付卡";
    info[12] = "交易未能处理";
    info[13] = "无未知交易";
    info[14] = "柜员轧账错";
    info[16] = "交易未授权";
    info[17] = "原始交易已冲正";
    info[18] = "权限不匹配";
    info[19] = "非联名卡";
    info[21] = "异地卡";
    info[22] = "异地交易";
    info[23] = "非取款卡";
    info[24] = "通讯校验错";
    info[25] = "无效的操作员号";
    info[26] = "操作员需签到";
    info[27] = "信息文件出错";
    info[28] = "已签到";
    info[29] = "操作员密码错";
    info[30] = "卡号校验错";
    info[32] = "同一张卡不能转帐";
    info[33] = "已取消";
    info[24] = "非法交易";
    info[35] = "金额不匹配";
    info[36] = "非法交易";
    info[37] = "对话超时";
    info[38] = "不可退货";
    info[39] = "报文格式错";
    info[41] = "超消费比例";
    info[42] = "已兑奖";
    info[43] = "已取消兑奖";
    info[45] = "流水号错";
    info[46] = "授权已确认";
    info[47] = "消费已付，交易拒绝";
    info[49] = "帐不平";
    info[51] = "商户资金不足";
    info[52] = "帐户文件不可用";
    info[53] = "原始交易未找到";
    info[54] = "该授权已消费";
    info[55] = "超限额";
    info[56] = "请索权";
    info[57] = "付出卡不存在";
    info[58] = "不允许本地取现";
    info[59] = "止付卡";
    info[60] = "记录不存在";
    info[61] = "系统故障";
    info[62] = "只做本地取现";
    info[63] = "授权号错";
    info[64] = "非法卡";
    info[65] = "非法卡";
    info[66] = "过期卡";
    info[67] = "积分不足";
    info[68] = "预授权当日不可取消";
    info[69] = "帐户不存在";
    info[70] = "已超兑奖期";
    info[71] = "非法卡";
    info[72] = "检查帐户错";
    info[73] = "交易未能处理";
    info[74] = "应用未找到";
    info[75] = "卡片状态不对";
    info[76] = "上门收款错误";
    info[77] = "外卡错误信息";
    info[78] = "表版本错误";
    info[81] = "请与发卡行联系";
    info[82] = "个人标识号错";
    info[83] = "交易不能处理";
    info[84] = "主机通讯故障";
    info[85] = "数据传输错";
    info[87] = "总行文件打开错";
    info[88] = "超限额，请电话索权";
    info[89] = "通讯校验错";
    info[90] = "无相应记录";
    info[91] = "权限不匹配";
    info[92] = "读数据库文件失败";
    info[93] = "商场记录错";
    info[94] = "更新数据库文件失败";
    info[95] = "不能在本商户使用";
    info[96] = "异地网未开通";
    info[97] = "非法交易";
    info[98] = "应用子系统未激活";
    info[99] = "交易过程未发现";

    var str = "";

    for (i = 0; i < code.length; i++) {
        if (code[i] == id) {
            str = info[i] + "(" + code[i] + ")";
            break;
        }
    }
    if (str.length == 0) str = "参数传递错误!";
    return str;

}

//字符截取
function getRecordStr(recodes, start, len) {
    return recodes.substr(start, len);
}

//选择刷卡记录
function SelIsCahs() {
    var pay = $('#Label6').text();  //应收总额
    if (pay <= 0) {
        alert("退货不能选择刷卡记录！");
        return;
    }


    var bank_recodes = $('#PayCode').val();
    if (bank_recodes.length > 0) {
        alert("此零售单已有刷卡不能选择其它记录！");
        return false;
    }

    var m = openModal('IsCash_Records.aspx', 590, 350);
    if (m == undefined ||  m.length == 0) {
        return;
    }
    m = m[0];

    $.ajax({
        url: "../AJAX/ICBCLOG_UDP.ASPX",
        type: "POST",
        cache: false,
        dataType: "html",
        data: 'logid=' + m + '&pay=' + pay,
        success: function (json) {
            var arr = eval("(" + json + ")")
            if (arr.success == "1") {
                var ret = arr.msg;
                $('#PayCode').val(ret);
                var index_sk = getPaymentIndex('刷卡');

                var tbsums = $("#pbody").find("INPUT[name='sums']"); //消费金额
                var tbsn = $("#pbody").find("INPUT[name='sn']"); //检索号
                var tbcardid = $("#pbody").find("INPUT[name='cardid']"); //银行卡号

                tbsums[index_sk].value = parseFloat(getRecordStr(ret, 65, 12) / 100);
                tbsn[index_sk].value = getRecordStr(ret, 53, 8);
                tbcardid[index_sk].value = getRecordStr(ret, 2, 19);

                //选择刷卡记录后，设置刷卡不能修
                $(tbsums[index_sk]).attr('readonly', 'readonly').css({ 'background': '#f2f3f4' });
                chgcash(this);
            } else {
                alert(arr.msg);
            }
        },
        error: function (err) {
            alert(err.responseText);
        }
    });

}

function ButEnabled() {
    $("#F2,#F4,#Button2").removeAttr("disabled");

    var index_sk = getPaymentIndex('刷卡');
    var index_xj = getPaymentIndex('现金');
    var tbsums = $("#pbody").find("INPUT[name='sums']");

    $(tbsums[index_sk]).removeAttr('disabled').css({ 'background': '#ffffff' });
    $(tbsums[index_xj]).removeAttr('disabled').css({ 'background': '#ffffff' });

    $.unblockUI();
}

//显示提示信息
function ShowAjaxMsg(msg) {
    $.blockUI({
        message: '<b style="color:#1EA900;">' + msg + '</b>',
        css: {
            textAlign: 'center',
            top: '40%',
            left: '15%',
            border: 'none',
            padding: '10px',
            width: '400px',
            backgroundColor: '#000',
            '-webkit-border-radius': '10px',
            '-moz-border-radius': '10px',
            opacity: .8,
            'font-size': '16px',
            color: '#fff'
        },
        overlayCSS: {
            opacity: 0
        }
    });

}