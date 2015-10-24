//WSID:603d9fc5-cd4a-4d8b-80bc-020a906c5041
$().ready(function () {
    //初始化
    initGrid();

    $("input").live("blur", function () {
        var num = $(this).val();
        var goodsNo = this.id;
        goodsNo = goodsNo.match(/C\d+/g);
        handleEvent(goodsNo[0], num);
    });
});

//initGrid
function initGrid() {
    $.ajax({
        url: GetWSRRURL('603d9fc5-cd4a-4d8b-80bc-020a906c5041'),
        type: 'post',
        async: true, //同步,
        data: { "XML": GetGetJson([], "GetCart") },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    buildTbody(result);
                    //slide(result[0].rows[0].message); //提示信息
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

function buildCartHtml(tbody,count,sumAmount) {
    var htmlCode = "";
    htmlCode += "<table  class=\"cart-main\" id=\"cart_main\" style=\"width:100%\">";
    htmlCode += "<colgroup><col class=\"col-1\">";
    htmlCode += "<col class=\"col-2\">";
    htmlCode += "<col class=\"col-3\">";
    htmlCode += "<col class=\"col-4\">";
    htmlCode += "<col class=\"col-5\">";
    htmlCode += "<col class=\"col-6\">";
    htmlCode += "</colgroup>";
    htmlCode += "<thead><tr><th colspan=\"2\">商品</th>";
    htmlCode += "<th>属性</th>";
    htmlCode +="<th>单价</th>";
    htmlCode += "<th>数量</th>";
    htmlCode += "<th>小计</th>";                                    
    htmlCode +="<th>操作</th>";
    htmlCode += "</tr></thead>";
    htmlCode += tbody;
    htmlCode += "<tfoot><tr class=\"hr-bg\"><td id=\"order_price\" class=\"order-price\" colspan=\"7\">";
    htmlCode += "<ul><li class=\"goods\"><span class=\"label\">";
    htmlCode += "<span class=\"cart_number\" style=\"color:#D1BDAB\">"
    htmlCode += "(共 <span class=\"op-cart-number\">"+count+"</span> 件)</span>";
    htmlCode += "<em>商品金额：</em></span><span class=\"price\"><b>￥<span id=\"sumGoods\">" + sumAmount + "</span></b></span>";
    htmlCode += "</li></ul></td></tr><tr>";
    htmlCode += "<td class=\"cart-left\" colspan=\"3\"></td>";
    htmlCode += "<td class=\"cart-right\" colspan=\"4\">";
    htmlCode += "<a id=\"IDcartgobuy\" class=\"btn-link\" href=\"../PresentOutSide/Goods.HTML\">继续选购</a>";
    htmlCode += "<button  class=\"btn-OK\" id=\"IDsettle\" onclick=\"buildOrder()\"><span>提交订单</span></button>";
    htmlCode += "</td></tr></tfoot></table>";
    $("#cartForm").html("").html(htmlCode);
}
function buildTbody(result) {
    var htmlCode = "";
    var sumAmount = 0;
    if (result[0].rows[0].goodsno != "") {
        //商品数量
        var count = result[0].rows.length;
        var i = 0;
        while (i < result[0].rows.length) {
            var data = result[0].rows.pop();
            var picpath = data.picpath;
            sumAmount += +data.count;
            picpath = picpath.replace(/.*.jpg,/, "");
            htmlCode += "<tbody class=\"cart-item\">";
            htmlCode += "<tr class=\"cart-product last\">";
            htmlCode += "<td>";
            htmlCode += "<div class=\"p-pic\">";
            htmlCode += "<input type=\"hidden\" name=\"CartID\" value=\"" + data.cartid + "\">";
            htmlCode += "<input type=\"hidden\" name=\"Retailprice\" value=\"" + data.retailprice + "\" id=\"price" + data.goodsno + "\">";
            htmlCode += "<input type=\"hidden\" value=\"" + data.goodsno + "\" name=\"GoodsNo\">";
            htmlCode += "<img alt=\"商品图片\" src=\"http://172.16.205.35:90" + picpath + "\">";
            htmlCode += "</div></td>";
            htmlCode += "<td class=\"p-info\">";
            htmlCode += "<div class=\"p-title\">";
            htmlCode += "<p>" + data.name + "</p>";
            htmlCode += "</div></td>";
            htmlCode += "<td><div>" + data.spec + "</div></td>";
            htmlCode += "<td class=\"p-price\">￥" + data.retailprice + "</td>";
            htmlCode += "<td><div class=\"p-quantity\">";
            htmlCode += "<a class=\"btn-decrease\" href=\"javascript:void(0);\" onclick=setNum('down','" + data.goodsno + "')>-</a>";
            htmlCode += "<input type=\"txt\" value=\"" + data.goodsnum + "\" id=\"quantity" + data.goodsno + "\" name=\"GoodsNum\">";
            htmlCode += "<a class=\"btn-increase\" href=\"javascript:void(0);\" onclick=setNum('up','" + data.goodsno + "')>+</a>";
            htmlCode += "</div></td>";
            htmlCode += "<td class=\"p-subtotal\">￥<span id=\"count" + data.goodsno + "\">" + data.count + "</span></td>";
            htmlCode += "<td class=\"p-action\"><a id=\"del" + data.goodsno + "\" class=\"btn-delete\" onclick=\"showMsg('del','" + data.goodsno + "')\" href=\"javascript:void(0);\">移除</a>";
            htmlCode += "</td></tr></tbody>";
            buildCartHtml(htmlCode, count, sumAmount);
        };
    } else {
        htmlCode += "<div class=\"cart-empty\">";
        htmlCode += "<q class=\"icon\">=</q>";
        htmlCode += "<q class=\"empty-tip\">";
        htmlCode += "<b>您的购物车里还没有商品</b>";
        htmlCode += "<a class=\"go\" href=\"../PresentOutSide/Goods.html\">商品列表 »</a>";
        htmlCode += "</q></div>";
        $("#cartForm").html("").html(htmlCode);
    };
    
}

function setNum(manipulation, goodsNo) {
    var id = "quantity" + goodsNo;
    var oldNum = $("#"+id).val();
    var newNum = 0;

    if (manipulation == "up") {
        newNum = +oldNum + 1;
    }
    else if (manipulation == "down") {
        newNum = +oldNum - 1;
        if (newNum < 1) {
            newNum = 1;
        };
    }
    else {
        newNum = arguments[2];
    };
    $("#" + id).val(newNum);
    calculateMoney(goodsNo);    //计算小计
    sumMoney(); //计算总金额
    var data = [];
    data[data.length] = { "name": "txtGoodsNo", "value": goodsNo };
    data[data.length] = { "name": "txtNum", "value": newNum };
    data[data.length] = { "name": "txtType", "value": manipulation };
    var XMLData = GetFormJson(data, "setNum");
    $.post(GetWSRRURL("603d9fc5-cd4a-4d8b-80bc-020a906c5041") + "&XML=" + XMLData, function (data) { checkCarNum() });
}
function calculateMoney(goodsNo) {
    var id_count = "count" + goodsNo;        //金额小记
    var id_price = "price" + goodsNo;          //商品单价
    var id_num = "quantity" + goodsNo;     //商品数量

    var price = $("#" + id_price).val();
    var num = $("#" + id_num).val();
    var count = price * num;
    $("#" + id_count).html("").html(count);
}
function sumMoney() {
    var num = $("#cart_main span[id^=count]");
    var sum = 0;
    if (num.length > 0) {
        for (var i = 0; i < num.length; i++) {
            sum += +num[i].innerHTML;
        };
        $("#sumGoods").html("").html(sum);
    };
}
//失去焦点事件
function handleEvent(goodsNo,num) {
    if (isNaN(num) || num == 0) {
        num = 1;
    };
    setNum("", goodsNo, num);
}

function showMsg() {
    if (arguments[0] == 'del') {
        $("#messgeDel").modal({ keyboard: false });
        var htmCode = "";
        htmCode += "<button class=\"btn\" data-dismiss=\"modal\" aria-hidden=\"true\">关闭</button>";
        htmCode += "<button class=\"btn btn-primary\" onclick=\"delGoods('" + arguments[1] + "')\">确认删除</button>";
        $("#buttonDel").html("").html(htmCode);
    } else {
        $("#").modal({ keyboard: false });
    }
}
//移出商品
function delGoods(goodsno){
    var data = [];
    data[data.length] = { "name": "txtGoodsNo", "value": goodsno };
    var XMLData = GetFormJson(data, "DelGoods");
    $.ajax({
        url: GetWSRRURL('603d9fc5-cd4a-4d8b-80bc-020a906c5041'),
        type: 'post',
        async: true, //同步,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("系统错误", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("提示", result[0].rows[0].message, 'error');
                }
                else {
                    $("#messgeDel").modal('hide');
                    buildTbody(result);
                }
            } catch (ex) {
                $.messager.progress('close');
                $.messager.alert("提示", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("提示", "提交错误了！", 'error');
        }
    });
}

function buildOrder() {
    var $amount = $("#sumGoods");
    var amount = $amount[0].innerText;
    var $point = $("#Credits");
    var point = $point[0].innerText
    amount = parseInt(amount);          //总金额
    point = point.match(/\d+/g);
    point = parseInt(point[0]);             //总积分
    if (point < amount) {
        alert("对不起，您的积分不够兑换所选商品。");
        return;
    } else {
        var data = $("#cartForm").serializeArray();
        //data[data.length] = { "name": "txtAmount", "value": amount };
        var XMLData = GetFormArray(data, 'buildOrder', 'GoodsNum');
        $.ajax({
            url: GetWSRRURL('603d9fc5-cd4a-4d8b-80bc-020a906c5041'),
            type: 'post',
            async: true, //同步,
            data: { "XML": XMLData },
            success: function (result) {
                try {
                    var result = eval("[" + result + "]");

                    if (result[0].Error) {
                        $.messager.progress('close');

                        $.messager.alert("系统错误", result[0].Error, 'error');
                    } else if (result[0].rows[0].result == "False") {
                        $.messager.progress('close');

                        $.messager.alert("提示", result[0].rows[0].message, 'error');
                    }
                    else {
                        buildTbody(result);
                        //slide(result[0].rows[0].message); //提示信息
                    }
                } catch (ex) {
                    $.messager.progress('close');
                    $.messager.alert("提示", ex, 'error');
                }
            },
            error: function () {
                $.messager.alert("提示", "提交错误了！", 'error');
            }
        });
    }

}