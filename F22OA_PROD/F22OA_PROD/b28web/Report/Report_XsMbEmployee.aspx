<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_XsMbEmployee, App_Web_report_xsmbemployee.aspx.7863a146" enableviewstatemac="false" enableEventValidation="false" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <script src="js/Fixed.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
    <title>营业员销售目标</title>
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
            width:100%;
            color:Red;
            font-size:13px;
            font-weight:bold;
            margin-top:5px;
            margin-bottom:5px;
            float:left;
        }
        
        .sumsinput
        {
            border:none;    
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
            getData(y, m);
        });
        function getData(y, m) {
            $("#hidid").val("");
            $("hidsure").val("0");
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "getXsMbEmployee", "year": y, "month": m, "dt": new Date().toString() },
                type: "post",
                dataType: "json",
                success: function (d) {
                    $("#mainTable").find("tr").not("tr:first").remove();
                    $("#lbl_TotalGoal").text("");
                    //$("#s_dw").text("");
                    //$("#hiddw").val("");
                    $("#btnsure").removeClass("disabled");
                    $("#btnunsure").removeClass("disabled");
                    if (d.msg == 1) {
                        $("#lbl_TotalGoal").text(d.totalgoal);
                        //$("#s_dw").text("(" + d.dw + ")");
                        //$("#hiddw").val(d.dw1);
                        $("hidsure").val(d.chksure);
                        if (d.chksure == 0) {
                            $("#btnunsure").addClass("disabled");
                        } else {
                            $("#btnsure").addClass("disabled");
                        }
                        var sums = 0;
                        var hidid = "";
                        if (d.list.length > 0) {
                            $.each(d.list, function (i, itme) {
                                if (hidid == "") {
                                    hidid = itme.id;
                                }
                                sums += parseFloat(itme.goal);
                                var strdis = "";
                                if (d.chksure == 1) {
                                    strdis = "disabled='disabled'";
                                }
                                var strgoal = "<div class'hidtxt' style='display:none'>" + itme.goal + "</div><input type='text' class='txtsums' id='" + (itme.id + "_" + itme.employeeid) + "' value='" + (parseFloat(itme.goal) == 0 ? "" : parseFloat(itme.goal).toFixed(0)) + "' style='width:100px' " + strdis + "/>"; ;
                                var tr = $("<tr class='trNor'><td>" + itme.employeeid + "</td><td>" + itme.names + "</td><td>" + strgoal + "</td></tr>");
                                tr.appendTo($("#mainTable tbody"));
                            });
                        }
                        $("#hidid").val(hidid);
                        var foot = $("<tr class='head'><td colspan='2'>合计</td><td><div class='totalGoal'>" + sums + "</div></td></tr>")
                        foot.appendTo($("#mainTable tbody"));
                        $("#chaer").html(d.totalgoal - sums);
                        $("input:text").keydown(function (e) {
                            if (e.keyCode == 13) {
                                $(this).change();
                            }
                        }).change(function () {
                            var id = $(this).attr("id");
                            var goal = $(this).val();
                            var dval = $(this).attr("defval");
                            SaveGoal(id, goal);
                        }).keypress(function (e) {
                            if (parseInt(ver) == 6) {
                                if (e.keyCode == 13) {
                                    $(this).change();
                                    return false;
                                }
                            }
                            if (e.keyCode < 48 || e.keyCode > 57)
                                return false;
                        });
                    } else if (d.msg == -1) {
                        $("#btnunsure").addClass("disabled");
                        $("#btnsure").addClass("disabled");
                        alert("没有单据");
                    } else {
                        $("#btnunsure").addClass("disabled");
                        $("#btnsure").addClass("disabled");
                        $("#lbl_TotalGoal").text('未制定月销售目标');
                    }
                    setpow();
                    var height = $(window).height();
                    FixTable("mainTable", 0, 480, (height - 145));

                    $("#tt").html($("#mainTable").html());
                    $("#tt").find("input").remove();
                    $("#tt .hidtxt").show();
                },
                error: function (d) {
                    alert("数据加载失败");
                }
            });
        }
        function SaveGoal(id, goal) {
            $("#remark").text("")
            var mrg = /^\d+(\.\d{0,2})?$/;
            if (goal != "") {
                if (!mrg.test(goal)) {
                    alert("请输入大于0的营业员销售目标金额(保留2位小数)");
                    $("#" + id).focus();
                    return false;
                } 
            }
            else {
                goal = "0";
            }
            var sure = $("hidsure").val();
            if (sure == "1") {
                alert("审核审核单据不能修改")
                return false;
            }
            var xid = $("#hidid").val();
            var employeeid = id.split('_')[1];
            //var billtype = $("#hiddw").val();
            var sums = 0;
            $("#mainTable .txtsums").each(function () {
                if ($(this).val() != "") {
                    sums += parseFloat($(this).val());
                }
            });
//            if (sums < parseFloat($("#lbl_TotalGoal").text())) {
//                alert("营业员销售目标合计[" + sums + "]不能小于本月销售目标[" + $("#lbl_TotalGoal").text() + "]");
//                $("#" + id).focus();
//                return false;
//            }
            $("#remark").text("数据保存中...")
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "SaveEmployeeGoal", "id": xid, "employeeid": employeeid, "goal": goal, "billtype": "0", "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {
                        $("#remark").text("数据保存成功");

                        $(".totalGoal").html(sums);
                        var c = parseFloat($("#lbl_TotalGoal").text()) - sums;
                        $("#chaer").html(c);
                    } else {
                        alert("数据保存失败,错误：" + data.msg);
                        $("#remark").text("数据保存失败");
                    }
                },
                error: function (d) {
                    alert("保存失败");
                    $("#remark").text("数据保存失败");
                }
            });
        }

        function Sure() {
            if ($("#btnsure").hasClass("disabled")) {
                return false;
            }
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            var id = $("#hidid").val();
            //var billtype = $("#hiddw").val();
            var totalgoal = parseFloat($("#lbl_TotalGoal").text());
            var goal = parseFloat($("#mainTable .totalGoal").html());
            if (goal < totalgoal) {
                alert("当月销售目标合计[" + goal + "]不能小于本月销售目标[" + totalgoal + "],相差" + (parseFloat(totalgoal) - parseFloat(goal)) + "");
                return false;
            }

            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "SureEmployeeGoal", "id": id, "year": y, "month": m, "billtype": "0", "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {
                        $("hidsure").val("1");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").removeClass("disabled");
                        alert("审核成功")
                        $("input:text").attr("disabled",true);
                    } else if (data.error == -1) {
                        alert("当月销售目标合计[" + data.msg + "]不能小于本月销售目标[" + totalgoal + "],相差" + (parseFloat(totalgoal) - parseFloat(data.msg)) + "");
                        return false;
                    } else if (data.error == -2) {
                        alert("单据已登账");
                        return false;
                    } else {
                        alert("审核失败,错误：" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("保存失败");
                }
            });
        }

        function unSure() {
            if ($("#btnunsure").hasClass("disabled")) {
                return false;
            }
            var sure=$("hidsure").val();
            if (sure == "0") {
                alert("此单未审核，不能进行反审核")
                return false;
            }
            var id = $("#hidid").val();
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "unSureEmployeeGoal", "id": id, "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {
                        $("hidsure").val("0");
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        alert("反审核成功")
                        $("input:text").attr("disabled", false);
                    } else if (data.error == -1) {
                        alert("单据已登账，不能反审核");
                    } else {
                        alert("审核失败,错误：" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("保存失败");
                }
            });
        }
        function q_query() {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            getData(y, m);
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
            window.location = "ajax/Excel.aspx?act=1&year=" + y + "&month=" + m;
        }

        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="pow" value="" />
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
            <input type="hidden" id="hidid" value="" />
            <input type="hidden" id="hidsure" value="" />
            <div class="tit">店铺：<label id="lblDepot" runat="server"></label></div>
            <div class="tit">月金额销售目标：<label id="lbl_TotalGoal"></label>元</div>
            <table border="0" cellpadding="1" cellspacing="1"  width="250" >
            <tr class="trNor">
                <td width="125px" align="left">年份：<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="125px" align="left">月份：<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            <div id="mark">按回车保存数据&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label>&nbsp;&nbsp;&nbsp;&nbsp;差额:<label id="chaer"></label>元</div>
            <div id="abc">
            <table id="mainTable" border="0" cellpadding="1" cellspacing="1" class="tab">
            <thead>
            <tr class="head">
                <td width="180px">营业员编号</td>
                <td width="120px">营业员</td>
                <td width="150px">本月销售目标<span id="s_dw">(元)</span><input type="hidden" value="" id="hiddw" /></td>
            </tr>
            </thead>
            <tbody></tbody>
            </table>
            </div>
        </div>
    </form>
    <table border="1" id="tt" style="display:none"></table>
</body>
</html>
