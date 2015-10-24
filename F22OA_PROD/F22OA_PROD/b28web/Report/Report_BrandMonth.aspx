<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_BrandMonth, App_Web_report_brandmonth.aspx.7863a146" enableviewstatemac="false" enableEventValidation="false" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>店铺竞争品牌月销售排名调查</title>
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
            $("#mainTable_tableFix").remove();
            $("#mainTable_tableHead").remove();
            $("#mainTable_tableColumn").remove();
            //$("#mainTable_tableData table").html();
            $("#mainTable tbody").find("tr").remove();
            $("#id").val("");
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "getBrandMonth", "year": y, "month": m, "dt": new Date().toString() },
                success: function (data) {
                    $("#btnsure").addClass("disabled");
                    $("#btnunsure").addClass("disabled");
                    if (data.SurveyId != "") {
                        $("#id").val(data.SurveyId);
                        var disb = "";
                        if (data.chksure == 0) {
                            $("#btnsure").removeClass("disabled");
                        } else {
                            $("#btnunsure").removeClass("disabled");
                            disb = "disabled='disabled'";
                        }
                        if (data.list.length > 0) {
                            $.each(data.list, function (i, item) {
                                var v = parseInt(item.Number) != 0 ? item.Number : "";
                                var Sums_RetailGoal = parseInt(item.Sums_RetailGoal) != 0 ?parseInt(item.Sums_RetailGoal) : "";
                                var put = "<input type='text' " + disb + " defval='" + v + "' class='" + item.BrandId + " number' brandid='" + item.BrandId + "' id='" + (data.SurveyId + "," + item.BrandId) + "' value='" + v + "' style='width:60px'/>";
                                var put1 = "<input type='text' " + disb + " defval='" + v + "' class='" + item.BrandId + " goal' brandid='" + item.BrandId + "' id='" + (data.SurveyId + "," + item.BrandId) + "_goal' value='" + Sums_RetailGoal + "' style='width:80px'/>";
                                var tr = $("<tr class='trNor'><td>" + (i + 1) + "</td><td>" + item.drName + "</td><td>" + put + "</td><td>" + put1 + "</td></tr>");
                                tr.appendTo($("#mainTable tbody"));
                            });
                        }

                        $("input:text").keydown(function (e) {
                            if (e.keyCode == 13) {
                                $(this).change();
                            }
                        }).bind("change", function () {
                            var id = $(this).attr("id");
                            var v = $(this).val();
                            var flag = "number";
                            if ($(this).hasClass("goal"))
                                flag = "goal";
                            Save(id, v, $(this).attr("brandid"), flag);
                        }).keypress(function (e) {
                            if (parseInt(ver) == 6) {
                                if (e.keyCode == 13) {
                                    $(this).change();
                                    return false;
                                }
                            }
                            if (e.keyCode < 48 || e.keyCode > 57)
                                return false;

                            if ($(this).hasClass("number") && $(this).val().length >= 4)
                                return false;
                            else if ($(this).hasClass("goal") && $(this).val().length >= 10)
                                return false;
                        });
                    }
                    else {
                        alert("没有单据");
                        var pphead = $("<tr class='head'></tr>");
                        for (var i = 0; i < pptd.length; i++) {
                            pphead.append("<td width='120px'>无竞争品牌</td>");
                        }
                        pphead.appendTo($("#mainTable tbody"));
                    }
                    setpow();
                    var height = $(window).height();
                    FixTable("mainTable", 0, 480, height - 90);
                },
                error: function (d) {
                    alert("加载数据出错");
                }
            });
        }

        function clearNoNum(obj) {
            //先把非数字的都替换掉，除了数字和.
            obj.value = obj.value.replace(/[^\d]/g, "");
        }

        function Save(id, v, brand, flag) {
            var arr = id.split(',');
            var SurveyId = arr[0];
            var brandid = brand;
            if (flag == "number") {
                var g2 = /^[0-9]{1,4}$/;
                if (!g2.test(v)) {
                    alert("请输入小于9999的正整数排名");
                    $("#" + id).focus();
                    return false;
                }
            }
            else {
                var g2 = /^[0-9]{1,10}$/;
                if (!g2.test(v)) {
                    alert("请输入正确的月销售金额");
                    $("#" + id).focus();
                    return false;
                }
            }
            var sums = v == "" ? "0" : v;
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            var obj = {
                "act": "SavegetBrandMonth",
                "id": SurveyId,
                "brandid": brandid,
                "value": v,
                "flag":flag
            };
            $("#remark").text("数据保存中...")
            $.ajax({
                url: "ajax/BrandSurvey.ashx",
                type: "post",
                dataType: "json",
                data: obj,
                success: function (data) {
                    if (data.error == 0) {
                        $("#remark").text("数据保存成功");
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
                data: { "act": "SureBrandMonth", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("审核成功");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").removeClass("disabled");
                        $("input:text").attr("disabled", true);
                    }
                    else if (data.error == -1) {
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
                data: { "act": "unSureBrandMonth", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("反审核成功");
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        $("input:text").attr("disabled", false);
                    } else if (data.error == -1) {
                        alert("单据已登账,不能反审核");
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

        function selectDpt() {
            showModalDialog("~/branch/public/DepotMultiSelector.aspx", window, "dialogHeight:700px;dialogWidth:500px;center:yes;help:no;resizable:no;status:no;scroll:no");
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
            window.location = "ajax/Excel.aspx?act=3&id=" + id + "&year=" + y + "&month=" + m;
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
            <table border="0" cellpadding="1" cellspacing="1" width="400px">
            <tr class="trNor">
                <td width="200px" align="left">年份：<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="200px" align="left">月份：<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            <div id="mark">按回车保存数据&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label></div>
            <table id="mainTable" border="0" cellpadding="1" cellspacing="1" class="tab">
            <thead>
            <tr class='head'>
                <td width="80px">序号</td>
                <td width="150px">楼层竞品</td>
                <td width="100px">排名</td>
                <td width="120px">月销售</td>
            </tr>
            </thead>
            <tbody></tbody>
            </table>
        </div>
    </form>
</body>
</html>
