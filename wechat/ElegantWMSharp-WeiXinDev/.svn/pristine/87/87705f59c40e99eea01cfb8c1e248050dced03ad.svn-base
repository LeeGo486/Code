var doTime = 1;
var cdhander;
$(function () {

    CountDown(2400);


    $("#btnSubmit").click(function () {
        if (doTime == 2) {
            Msg.show("您已经提交一次，请勿提交2次！", 1);
            return;
        }
        //判断是否所有题目都填写完整？
        var rstList = [];
        //if ($('input[type="radio"]').length / 4 != $('input[type="radio"]:checked').length) {
        //    Msg.show("请完成所有单选题目！", 1);
        //    return;
        //}

        //$('input[type="radio"]:checked').each(function () {
        //    rstList.push({
        //        "Qid": $(this).attr("name"),
        //        "Result": $(this).val()
        //    });
        //});
        var r1 = "Z"; var r2 = "Z"; var r3 = "Z"; var r4 = "Z"; var r5 = "Z"; var r6 = "Z"; var r7 = "Z"; var r8 = "Z"; var r9 = "Z"; var r10 = "Z";

        $('input[name="q1"]:checked').each(function () { r1 = $(this).val(); });
        $('input[name="q2"]:checked').each(function () { r2 = $(this).val(); });
        $('input[name="q3"]:checked').each(function () { r3 = $(this).val(); });
        $('input[name="q4"]:checked').each(function () { r4 = $(this).val(); });
        $('input[name="q5"]:checked').each(function () { r5 = $(this).val(); });
        $('input[name="q6"]:checked').each(function () { r6 = $(this).val(); });
        $('input[name="q7"]:checked').each(function () { r7 = $(this).val(); });
        $('input[name="q8"]:checked').each(function () { r8 = $(this).val(); });
        $('input[name="q9"]:checked').each(function () { r9 = $(this).val(); });
        $('input[name="q10"]:checked').each(function () { r10 = $(this).val(); });

        var r11 = "Z"; var r12 = "Z"; var r13 = "Z"; var r14 = "Z"; var r15 = "Z"; var r16 = "Z"; var r17 = "Z"; var r18 = "Z"; var r19 = "Z"; var r20 = "Z";
        $('input[name="q11"]:checked').each(function () { r11 += $(this).val(); });
        $('input[name="q12"]:checked').each(function () { r12 += $(this).val(); });
        $('input[name="q13"]:checked').each(function () { r13 += $(this).val(); });
        $('input[name="q14"]:checked').each(function () { r14 += $(this).val(); });
        $('input[name="q15"]:checked').each(function () { r15 += $(this).val(); });
        $('input[name="q16"]:checked').each(function () { r16 += $(this).val(); });
        $('input[name="q17"]:checked').each(function () { r17 += $(this).val(); });
        $('input[name="q18"]:checked').each(function () { r18 += $(this).val(); });
        $('input[name="q19"]:checked').each(function () { r19 += $(this).val(); });
        $('input[name="q20"]:checked').each(function () { r20 += $(this).val(); });

        //if (r11 == "" || r12 == "" || r13 == "" || r14 == "" || r15 == "" || r16 == "" || r17 == "" || r18 == "" || r19 == "" || r20 == "") {
        //    Msg.show("请完成所有多选题目！", 1);
        //    return;
        //}

        for (var i = 1; i < 21; i++) {
            rstList.push({
                "Qid": "q" + i,
                "Result": eval("r" + i),
            });
        }


        var total = 0;
        //for (var b = 0; b < 20; b++) {
        if (rstList[0].Result == "D") { total += 4 }
        if (rstList[1].Result == "B") { total += 4 }
        if (rstList[2].Result == "C") { total += 4 }
        if (rstList[3].Result == "D") { total += 4 }
        if (rstList[4].Result == "A") { total += 4 }
        if (rstList[5].Result == "B") { total += 4 }
        if (rstList[6].Result == "A") { total += 4 }
        if (rstList[7].Result == "C") { total += 4 }
        if (rstList[8].Result == "D") { total += 4 }
        if (rstList[9].Result == "B") { total += 4 }
        if (rstList[10].Result == "ZABCDE") { total += 6 }
        if (rstList[11].Result == "ZBCDE") { total += 6 }
        if (rstList[12].Result == "ZAE") { total += 6 }
        if (rstList[13].Result == "ZBCD") { total += 6 }
        if (rstList[14].Result == "ZACD") { total += 6 }
        if (rstList[15].Result == "ZABDE") { total += 6 }
        if (rstList[16].Result == "ZAC") { total += 6 }
        if (rstList[17].Result == "ZACE") { total += 6 }
        if (rstList[18].Result == "ZAC") { total += 6 }
        if (rstList[19].Result == "ZABD") { total += 6 }
        //}

        $(this).button("loading");
        Msg.show("提交中...", 3);
        $.post("/Game/Questionnaire/SumitQA?q1="
            + rstList[0].Result
            + "&q2=" + rstList[1].Result
            + "&q3=" + rstList[2].Result
            + "&q4=" + rstList[3].Result
            + "&q5=" + rstList[4].Result
            + "&q6=" + rstList[5].Result
            + "&q7=" + rstList[6].Result
            + "&q8=" + rstList[7].Result
            + "&q9=" + rstList[8].Result
            + "&q10=" + rstList[9].Result
            + "&q11=" + rstList[10].Result
            + "&q12=" + rstList[11].Result
            + "&q13=" + rstList[12].Result
            + "&q14=" + rstList[13].Result
            + "&q15=" + rstList[14].Result
            + "&q16=" + rstList[15].Result
            + "&q17=" + rstList[16].Result
            + "&q18=" + rstList[17].Result
            + "&q19=" + rstList[18].Result
            + "&q20=" + rstList[19].Result
            + "&total=" + total
            , function (data) {
                Msg.hide();
                doTime = 2;
                //Msg.show(data.msg, data.result);
                $("#btnSubmit").button("reset");
                bootbox.alert("您的得分是：" + "</br></br>" + data.msg);
            });

    });
});


function CountDown(time) {
    $("#dtimer").html(time);
    cdhander = setInterval(function () {
        if (time <= 0) {
            $("#dtimer").html("00");
            clearInterval(cdhander);
            //完成了，提交成绩
            $("#btnSubmit").click()
        }
        else {
            if (time-- <= 10)
                $("#dtimer").html("0" + time);
            else
                $("#dtimer").html(time);
        }
    }, 1000);
}