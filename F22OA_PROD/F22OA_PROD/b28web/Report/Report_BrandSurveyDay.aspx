<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_BrandSurveyDay, App_Web_report_brandsurveyday.aspx.7863a146" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>每日竞争品牌销售业绩调查</title>
    <script src="js/Fixed.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #mian
        {
            margin-left:20px;
        }
        .tab
        {
            text-align:center;
            width:450px;
            background:#666666;
        }
        .maintab
        {
            text-align:center;
            background:#666666;
        }
        .head
        {
            height:25px;
            font-size:13px;
            font-weight:bold;
            background:#99CCFF;
        }
        .trNor
        {
            height:20px;
            background:#FFF;
        }
        .tit
        {
            font-size:13px;
            font-weight:bold;
            margin-top:10px;
            margin-bottom:5px;
        }
        .disabled{color: #ccc;text-decoration: none;cursor: default;}
        
        #mark
        {
            color:Red;
            font-size:13px;
            font-weight:bold;
            margin-top:5px;
            margin-bottom:5px;
        }
    </style>
    <script type="text/javascript">
        var ver
        $(function () {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            var ug = navigator.userAgent.toLowerCase();
            var IE = ug.match(/msie\s*\d\.\d/);
            ver = IE.join(" ").match(/[0-9]/g).join(".");
            loadData(y, m);
        });
        function loadData(y, m) {
            $("#remark").text("");
            $("#mainTable").html("");
            $("#mainTable_tableFix").remove();
            $("#mainTable_tableHead").remove();
            $("#mainTable_tableColumn").remove();
            $("#mainTable_tableData table").html("");
            $("#id").val("");
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "getBrandSurveyDay", "year": y, "month": m, "dt": new Date().toString() },
                success: function (data) {
                    $("#btnsure").removeClass("disabled");
                    $("#btnunsure").removeClass("disabled");
                    if (data.columnsCode != "" && data.columnsCode != "none") {
                        var disb = "";
                        if (data.sure == 0) {
                            $("#btnunsure").addClass("disabled");
                        } else {
                            $("#btnsure").addClass("disabled");
                            disb = "disabled='disabled'";
                        }
                        var columnsCode = data.columnsCode.split(',');
                        var columns = data.columns.split(',');
                        var w = 260 + columns.length * 80;
                        $("#mainTable").width(w);
                        //添加竞争品牌表头
                        var head = "<thead><tr class='head'><th rowspan='2' width='80px'>日期</th><th rowspan='2' width='80px'>星期</th><th colspan='" + columns.length + "'>竞品销售业绩 (元)</th><th rowspan='2' width='100px'>本品牌排名</th></tr><tr class='head'>";
                        for (var i = 0; i < columns.length; i++) {
                            head += "<th width='80px'>" + columns[i] + "</th>";
                        }
                        head += "</tr></thead>";
                        $("#mainTable").append(head);
                        //$("#mainTable").find("tbody").remove();
                        $("#mainTable").append("<tbody></tbody>");
                        //添加每日的竞争品牌
                        var id = data.id;
                        $("#id").val(id);
                        $.each(data.list, function (i, item) {
                            var tr = $("<tr class='trNor'><td width='80px'>" + item["date"] + "</td><td width='80px'>" + item["week"] + "</td></tr>");
                            for (var i = 0; i < columnsCode.length; i++) {
                                var v = "";
                                if (item[columnsCode[i]] != "") {
                                    //if (parseFloat(item[columnsCode[i]]) != 0) {
                                        v = item[columnsCode[i]];
                                    //}
                                }
                                tr.append("<td width='80px'><input type='text' defval='" + v + "' " + disb + " class='txtsums " + columnsCode[i] + "' id='" + (id + "," + item["did"] + ",xs," + columnsCode[i]) + "' value='" + (v != "" ? Number(v) : "") + "' style='width:60px'/></td>");
                            }
                            var nb = "";
                            if (item["number"] != "") {
                                //if (parseInt(item["number"]) != 0) {
                                    nb = item["number"];
                                //}
                            }
                            tr.append("<td width='100px'><input type='text' " + disb + " class='zpm' defval='" + nb + "' id='" + (id + "," + item["did"] + ",pm,number") + "' value='" + nb + "' style='width:60px'/></td>");
                            tr.appendTo($("#mainTable tbody"));
                        });
                        //添加合计行
                        var foot = $("<tr class='head'><td >合计</td><td></td></tr>");
                        for (var i = 0; i < columnsCode.length; i++) {
                            var sums = 0;
                            $("." + columnsCode[i]).each(function () {
                                if ($(this).val() != "") {
                                    sums += parseFloat($(this).val());
                                }
                            });
                            foot.append("<td class='c_" + columnsCode[i] + "'>" + sums + "</td>");
                        }
                        foot.append("<td></td>");
                        foot.appendTo($("#mainTable tbody"));
                        $("input:text").keydown(function (e) {
                            if (e.keyCode == 13) {
                                $(this).change();
                            }
                        }).bind("change", function () {
                            var id = $(this).attr("id");
                            var v = $(this).val();
                            var dval = $(this).attr("defval");
                            Save(id, v);
                        }).keypress(function (e) {
                            if ($(this).hasClass('zpm')) {
                                if (e.keyCode < 48 || e.keyCode > 57)
                                    return false;
                                if ($(this).val().length >= 4)
                                    return false;
                            } else {
                                if (parseInt(ver) == 6) {
                                    if (e.keyCode == 13) {
                                        $(this).change();
                                        return false;
                                    }
                                }
                                if ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 46 && e.keyCode != 45)
                                    return false;
                            }
                        });
                    } else if (data.columnsCode == "none") {
                        alert("没有单据");
                        var pphead = $("<tr class='head'></tr>");
                        for (var i = 0; i < pptd.length; i++) {
                            pphead.append("<td width='120px'>没有单据</td>");
                        }
                        pphead.appendTo($("#mainTable tbody"));
                    }
                    else {
                        var pphead = $("<tr class='head'></tr>");
                        for (var i = 0; i < pptd.length; i++) {
                            pphead.append("<td width='120px'>无竞争品牌</td>");
                        }
                        pphead.appendTo($("#mainTable tbody"));
                    }
                    setpow();
                    var width = $(document.body).width();
                    var height = $(window).height();
                    FixTable("mainTable", 2, width - 10, (height - 90));
                },
                error: function (d) {
                    alert("加载数据出错");
                }
            });
        }

        function Save(id, v) {
            var arr = id.split(',');
            var SurveyId = arr[0];
            var date = arr[1]
            var type = arr[2];
            var brandid = arr[3];
            if (v != "") {
                if (type == "xs") {
                    var g1 = /^-?\d+(\.\d{0,2})?$/;
                    if (!g1.test(v)) {
                        $("#" + id).val("");
                        alert("输入错误，请重新输入销售业绩");
                        $("#" + id).focus();
                        return false;
                    }
                } else if (type == "pm") {
                    var g2 = /^[0-9]{1,4}$/;
                    if (!g2.test(v)) {
                        alert("请输入小于9999的正整数排名");
                        $("#" + id).val("");
                        $("#" + id).focus();
                        return false;
                    }
                }
            }
            var sums = v == "" ? "0" : v;
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            var obj = {
                "act": "SaveSurveyDay",
                "id": SurveyId,
                "date": date,
                "type": type,
                "brandid": brandid,
                "year": y,
                "month": m,
                "sums": sums
            };
            $("#remark").text("数据保存中...")
            //alert(SurveyId + "," + date + "," + type + "," + brandid + "," + y + "," + m + "," + sums);
            //return false;
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: obj,
                success: function (data) {
                    if (data.error == 0) {
                        $("#remark").text("数据保存成功");
                        if (type == "xs") {
                            var sums = 0;
                            $("#mainTable ." + brandid).each(function () {
                                if ($(this).val() != "") {
                                    sums += parseFloat($(this).val());
                                }
                            });
                            $(".c_" + brandid).text(sums);
                        }
                    } else {
                        alert("数据保存失败，错误：" + data.msg);
                    }
                },
                error: function (d) {
                    alert("提交出错");
                }
            });
        }

        function Sure() {
            if ($("#btnsure").hasClass("disabled")) {
                return false;
            }
            var id = $("#id").val();
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "SureSurveyDay", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("审核成功");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").removeClass("disabled");
                        $("input:text").attr("disabled", true);
                    }
                    else if (data.error == -1) {
                        alert("本单还没录入数据，不能进行审核操作");
                    } else if (data.error == -2) {
                        alert("单据已登账");
                    }
                    else {
                        alert("审核失败，错误：" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("审核出错");
                }
            });
        }

        function unSure() {
            if ($("#btnunsure").hasClass("disabled")) {
                return false;
            }
            var id = $("#id").val();
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "unSureSurveyDay", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("反审核成功");
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        $("input:text").attr("disabled", false);
                    } else if (data.error == -1) {
                        alert("单据已登账，不能反审核");
                    }
                    else {
                        alert("反审核失败，错误：" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("反审核出错");
                }
            });
        }

        function q_query()
        {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            loadData(y, m);
        }

        function setpow() {
            var pow = $("#pow").val();
            var chk = pow.split(',')[0];
            var unchk = pow.split(',')[1];
            if (chk == "False")
                $("#btnsure").addClass("disabled");
            if (unchk == "False")
                $("#btnunsure").addClass("disabled");
        }

        function Excel() {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            var id = $("#id").val();
            window.location = "ajax/Excel.aspx?act=2&id=" + id + "&year=" + y + "&month=" + m;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="pow" value="" />
    <input type="hidden" id="id" value="" />
    <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="q_query" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="审核" CssClass="icon icon-tick" Callback="Sure" />
                 <cc1:ButtonItem ID="btnunsure" runat="server" Text="反审核" CssClass="icon icon-delete" Callback="unSure" />
                 <cc1:ButtonItem ID="btnexcel" runat="server" Text="导出Excel" CssClass="icon icon-export" Callback="Excel" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>
        <div id="mian">
            <table border="0" cellpadding="1" cellspacing="1" width="250px">
            <tr class="trNor">
                <td width="125px" align="left">年份：<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="125px" align="left">月份：<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            <div id="mark">按回车保存数据&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label></div>
            <div id="m" style="float:left">
            <table id="mainTable" border="0" cellpadding="1" cellspacing="1" class="maintab">
            
            
            </table>
            </div>
        </div>
    </form>
</body>
</html>
