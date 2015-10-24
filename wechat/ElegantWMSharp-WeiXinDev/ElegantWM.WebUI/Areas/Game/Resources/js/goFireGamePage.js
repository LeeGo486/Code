var No = 0;
var total = 0;
var result = "";
var xh = 1;

$(function () {

    //$("body").css("background", "url(/Areas/Game/Resources/images/fire/gamesetting.png) center center no-repeat");
    //$("body").css("background-size", "98%").css("background-attachment", "fixed");

    $("#infomation img").load(function () {
        $("#infomation").css("top", ($("#main").height() * 0.30));
        $("#question").css("top", ($("#main").height() * 0.63));
    })
    


    Msg.show("请稍候", 3);
    $.post("/Game/FireKnowledge/getQuestionInfo?TntId=DD3E8022-C6BE-4370-88EA-2DC735AADCC8", function (data) {
        var No = 0;
        result = eval('(' + data + ')');
        loadQuestion(result);

        Msg.hide();
        
        timeDown(60);
    });
})

//获取随机数
function getRandom(n) {
    return Math.floor(Math.random() * n + 1);
}

//加载题目
function loadQuestion(result) {
    
    var quesHead = result.dtQuesHead;
    var quesAns = result.dtQuesAll;

    var qst = quesHead[No];
    var html = "";
    
    if (No != "0") {
        xh++;
    };
    html = "<span style=\"color:#CC000C\">" + xh + "</span>" + qst.Question;
    html += "<ul style='margin:0px 40px;'>";

    var li = "";

    for (i = 0; i < 83; i++) {
        if (quesAns[i].Question == qst.Question) {
            if (quesAns[i].Answer == 1)
                li += "<li " + (quesAns[i].IsRight == 0 ? "" : " attr_data=\"right\"") + " onclick='checkAnswer(this);'>&times;</li>";//叉号

            if (quesAns[i].Answer == 0)
                li += "<li " + (quesAns[i].IsRight == 0 ? "" : " attr_data=\"right\"") + " onclick='checkAnswer(this);'>&radic;</li>";//勾号

            if (quesAns[i].Answer != 1 && quesAns[i].Answer != 0)
                li += "<li " + (quesAns[i].IsRight == 0 ? "" : " attr_data=\"right\"") + " onclick='checkAnswer(this);'>" + quesAns[i].Answer + "</li>";
        }
    }

    html += li;
    html += "</ul>";
    $(".qtitle").html(html);
    No++;
}

//倒计时
function timeDown(time) {
    $("#dtimer").html(time);
    cdhander = setInterval(function () {
        if (time <= 0) {
            $("#dtimer").html("00");
            clearInterval(cdhander);
            submitScore(total);
        }
        else {
            if (time-- <= 10)
                $("#dtimer").html("0" + time);
            else
                $("#dtimer").html(time);
        }
    }, 1000);
}

//答案
function checkAnswer(ths) {
    if (30 < No + 1) {
        clearInterval(cdhander);
        submitScore(total);
        return;
    }

    //alert(ths);
        $("#result").html("");

        if ($(ths).attr("attr_data") == "right") {
            var aright = "<img style=\"width:100px;\" src=\"/Areas/Game/Resources/images/fire/right.png\">";
            $("#result").html(aright);
        } else {
            var awrong = "<img style=\"width:100px;\" src=\"/Areas/Game/Resources/images/fire/wrong.png\">";
            $("#result").html(awrong);
        }
        //ths.removeAttr("onclick");
        //alert("1");
    if ($(ths).attr("attr_data") == "right") {
        total = total + 1;
        $("#count").html("<span class=\"fontsize\">[您已有了" + total + "份干粉]</span>");
    } else {
        $("#count").html("<span class=\"fontsize\">[您已有了" + total + "份干粉]</span>");
    }
    setTimeout(function () { loadQuestion(result); }, 400);
};

function submitScore(count) {
    var html = "<div style=\"position:absolute;top:0px;left:0px;\">";
    var share = "<div style=\"position:absolute;top:0px;left:0px;\"><img style=\"width:100%;height:100%;\" src=\"/Areas/Game/Resources/images/fire/share.png\" \></div>";

    if (count <= 8)
        html += "<img style=\"width:100%;height:100%;\" src=\"/Areas/Game/Resources/images/fire/bad.jpg\" \>";
    if (count >8 && count <= 15)
        html += "<img style=\"width:100%;height:100%;\" src=\"/Areas/Game/Resources/images/fire/qualified.jpg\" \>";
    if (count >15 && count <= 22)
        html += "<img style=\"width:100%;height:100%;\" src=\"/Areas/Game/Resources/images/fire/good.jpg\" \>";
    if (count > 22)
        html += "<img style=\"width:100%;height:100%;\" src=\"/Areas/Game/Resources/images/fire/pro.jpg\" \>";

    html += "</div>";
    $("#main").html(html);

    setTimeout(function () { $("#main").append(share); }, 2000);

}