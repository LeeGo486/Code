<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_RetailRegister, App_Web_report_retailregister.aspx.7863a146" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>店铺月销售登记表</title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/base.css" rel="stylesheet" type="text/css" />
    <%--<link type="text/css" rel="Stylesheet" href="css/lockedheaders.css" mce_href="css/lockedheaders.css" />--%>
    <%--<script src="js/Fixed.js" type="text/javascript"></script>--%>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
   <style type="text/css">
        .miantable tbody tr input
        {
            margin:0;
            padding:0;
            width:35px;	
        }
         .miantable tr td
         {
            margin:0;
            padding:0;
        }
         .miantable thead tr td
         {
         	word-break: break-all;
         }
        
        #main
        {
           
            margin-top:10px;
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
            cursor:pointer;
        }
        .trNor1
        {
            height:20px;
            background:#FFFF99;
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
        
        .onfocus
        {
            border:1px solid #CC0033;    
        }
        
        .clickbg
        {
           background:#FFCC33;
        }
    </style>
    <style type="text/css">
    .divmain
{
	overflow: scroll; border: solid 1px gray;
}
.miantable 
{
    text-align:center;
	border-collapse: collapse; 
}
.miantable td 
{
	position: relative; padding: 5px;
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
.miantable td.Locked /* 水平与垂直方向锁住单元格, 不随鼠标或滚动条移动 */
{
	z-index: 30; position: relative; 
    top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
.miantable td.HLocked /* 水平方向锁住单元格 */
{
	z-index: 10; position: relative; left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #fff; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.xHLocked /* 水平方向锁住单元格 */
{
	z-index: 10; position: relative; left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.VLocked /* 垂直方向锁住单元格 */
{
	z-index: 20; position: relative; top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    background-color: #99CCFF; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}

.miantable td.xVLocked /* 垂直方向锁住单元格 */
{
	z-index: 20; position: relative; top: expression(parentNode.parentNode.parentNode.parentNode.scrollTop); 
    background-color: #FFFF99; text-align: center; 
    border-top: solid 0px #666666; border-bottom: solid 1px #666666; border-left: solid 0px #666666; border-right: solid 1px #666666;
}
    </style>
    <script type="text/javascript">
        function LoadData(y, m) {
            $("#remark").html("");
            $("#mainTable").html("");
            $("#mainTable").html("<div style='width:100%;text-align:center'>正在加载数据...</div>");
            $("#lbl_jemb").text("");
            $("#lbl_sjje").text("");
            $("#lbl_jewcl").text("");
            $("#lbl_slmb").text("");
            $("#lbl_sjsl").text("");
            $("#lbl_slwcl").text("");
            $("#hidid").val("");
            var dd = $("#hiddate").val();
            var ym = $("#hidmonth").val();
            
            if (ym == (y + "-" + m)) {
                $("#btncount").removeClass("disabled");
                $("#btnrecount").removeClass("disabled");
            }
            else {
                $("#btncount").addClass("disabled");
                $("#btnrecount").addClass("disabled");
                dd = y + "-" + (parseInt(m) < 10 ? "0" + m : m) + "-01";
                $("#hiddate").val(dd);
            }
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "RetailRegister", "year": y, "month": m, "dt": new Date().toString() },
                success: function (data) {
                    if (data.error == "0") {
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").removeClass("disabled");
                        $("#hidid").val(data.id);
                        $("#hidchk_sure").val(data.Chk_Sure);
                        //alert(data.Chk_Sure + "  " + data.id);
                        var t = {};
                        var columns = data.columns.split('|');
                        for (var i = 0; i < columns.length; i++) {
                            var u1 = columns[i].split(',')[0];
                            var u2 = columns[i].split(',')[1];
                            if (t[u1] != undefined) {
                                t[u1] = parseInt(t[u1]) + 1;
                            } else {
                                t[u1] = 1;
                            }
                        }
                        var width = 150 + (columns.length * 40);
                        var sums = data.sums;
                        var nums = data.nums;
                        var v1 = parseFloat(sums.mb) == 0 ? "0" : (parseFloat(sums.sums) / parseFloat(sums.mb) * 100).toFixed(2);
                        var v2 = parseFloat(nums.mb) == 0 ? "0" : (parseFloat(nums.nums) / parseFloat(nums.mb) * 100).toFixed(2);
                        $("#lbl_jemb").text(sums.mb);
                        $("#lbl_sjje").text(sums.sums);
                        $("#lbl_jewcl").text(v1 + "%");
                        $("#lbl_slmb").text(nums.mb);
                        $("#lbl_sjsl").text(nums.nums);
                        $("#lbl_slwcl").text(v2 + "%");
                        var html = "<table id='list' class='miantable' width='" + width + "px'>";
                        html += "<thead><tr><td width='100px' rowspan='2' class='Locked'>日期</td><td width='100px' rowspan='2' class='Locked'>星期</td>";
                        for (var obj in t) {
                            html += "<td class='VLocked' width='" + (parseInt(t[obj]) * 40) + "px' colspan='" + t[obj] + "'>" + obj + "</td>";
                        }
                        html += "</tr>";
                        html += "<tr id='typehead'>";
                        for (var i = 0; i < columns.length; i++) {
                            html += "<td width='40px' class='VLocked'>" + columns[i].split(',')[1] + "</td>";
                        }
                        html += "</tr></thead><tbody>";
                        var dis = "";
                        if (data.Chk_Sure == 1) {
                            dis = "disabled='disabled'";
                            $("#btnsure").addClass("disabled");
                        } else {
                            $("#btnunsure").addClass("disabled");
                        }

                        $.each(data.mlist, function (i, item) {
                            var bg = dd == item["date"] ? "clickbg" : "";
                            //onmouseover=\"this.style.background='#FFCC33'\" onmouseout=\"this.style.background='#FFF'\"
                            html += "<tr class='" + bg + " tr_" + item["date"] + "' id='tr_" + item["date"] + "' onclick=\"setdate('" + i + "','" + item["date"] + "')\">";
                            var m = 0;
                            for (var obj in item) {
                                var v = parseInt(item[obj]) == 0 ? "" : item[obj];
                                var td = "";
                                if (obj != "date" && obj != "week") {
                                    td = "<td>" +
                                    "<span id='s_" + (item["date"] + "_" + obj) + "' style='display:none'>" + columns[m] + "</span>" +
                                    "<input class='n_" + obj + "' defval='" + v + "' type='text' id='" + (data.id + "," + item["date"] + "," + obj) + "' " + dis + " value='" + v + "' />" +
                                    "</td>";
                                    m += 1;
                                } else {
                                   
                                    if (obj == "date") {
                                        
                                        v = item[obj].split('-')[1] + "月" + item[obj].split('-')[2] + "日";
                                    }
                                    td = "<td width='120px' class='HLocked'>" + v + "</td>";
                                }
                                html += td;
                            }
                            html += "</tr>";
                        });
                        html += "</tbody></table>";
                        $("#mainTable").html("");
                        $("#mainTable").html(html);
                        $("#list .tr_" + dd).find("td:eq(0)").css({ "background": "#FFCC33" });
                        $("#list .tr_" + dd).find("td:eq(1)").css({ "background": "#FFCC33" });
                        var zhtr = "<tr class='head' id='count'><td colspan='2' class='Locked'>合计</td>"
                        var x = 0;
                        var z = 0;
                        var classid = "";
                        for (var obj in t) {
                            classid = "count" + z;
                            for (var i = 0; i < parseInt(t[obj]); i++) {
                                var nums = 0;
                                $(".n_v_" + x).each(function () {
                                    if ($(this).val() != "") {
                                        nums += parseInt($(this).val());
                                    }
                                });
                                zhtr += "<td class='VLocked " + classid + " zh_v_" + x + "' id='zh_v_" + x + "'>" + (nums == 0 ? "&nbsp;" : nums) + "</td>";
                                x += 1;
                            }
                            z += 1;
                        }
                        zhtr += "</tr>";
                        $(zhtr).insertAfter($("#typehead"));
                        var zbtr = "<tr class='trNor1'><td colspan='2' class='Locked' style='background:#FFFF99'>占比</td>";
                        x = 0;
                        z = 0;
                        for (var obj in t) {
                            classid = "count" + z;

                            var cnum = 0;
                            $("." + classid).each(function () {
                                if ($(this).html() != "" && $(this).html() != "&nbsp;") {
                                    cnum += parseInt($(this).html());
                                }
                            });
                            classid = "zb" + z;
                            for (var i = 0; i < parseInt(t[obj]); i++) {
                                var v = "&nbsp;";
                                if ($("#zh_v_" + x).html() != "" && $("#zh_v_" + x).html() != "&nbsp;") {
                                    var nums = $("#zh_v_" + x).html();
                                    v = nums == "" ? "&nbsp;" : (parseInt(nums) / cnum * 100).toFixed(1) + "%";
                                }
                                zbtr += "<td class='xVLocked zb_zh_v_" + x + " id='zbmv_" + x + "'>" + v + "</td>";

                                x += 1;
                            }
                            z += 1;
                        }
                        zbtr += "</tr>";
                        $(zbtr).insertAfter($("#count"));

                        $("input:text").keydown(function (e) {
                            if (e.keyCode == 13) {
                                $(this).change();
                            }
                        })
                        .bind("change", function () {
                            var id = $(this).attr("id");
                            var v = $(this).val() == "" ? "0" : $(this).val();
                            SaveData(id, v);
                        }).keypress(function (e) {
                            if (parseInt(ver) == 6) {
                                if (e.keyCode == 13) {
                                    $(this).change();
                                    return false;
                                }
                            }
                            if ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 45)
                                return false;
                        });
                    } else if (data.error == "-2") {
                        alert("没有单据");
                        $("#mainTable").html("<div style='width:100%;text-align:center'>没有单据</div>");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        $("#btncount").addClass("disabled");
                        $("#btnrecount").addClass("disabled");
                    } else if (data.error == "-1") {
                        alert("本月还未设置金额目标");
                        $("#mainTable").html("<div style='width:100%;text-align:center'>本月还未设置金额目标</div>");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        $("#btncount").addClass("disabled");
                        $("#btnrecount").addClass("disabled");
                    } else if (data.error == "1") {
                        alert("加载数据出错,错误：" + data.msg);
                    }
                    setpow();
                    //var width = $(document.body).width();
                    //FixTable("list", 2, width - 10, 410);
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
        var ver
        $(function () {
            var height = $(window).height();
            $("#mainTable").height(height - 200);
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();

            var ug = navigator.userAgent.toLowerCase();
            var IE = ug.match(/msie\s*\d\.\d/);
            ver = IE.join(" ").match(/[0-9]/g).join(".");
            LoadData(y, m);
        });

        function SaveData(id, v) {
            
            var RetailId = id.split(',')[0];
            var d = id.split(',')[1];
            var o = id.split(',')[2];
            //alert($("#zh_" + o).attr("class"));
            //return false;
            var column = $("#s_" + d + "_" + o).html();
            var g2 = /^-?[0-9]\d*$/;
            if (v != "") {
                if (!g2.test(v)) {
                    alert("请输入整数！");
                    $("#" + id).focus();
                    return false;
                }
            } else {
                v = "0";
            }
            var obj = {
                "act": "SaveRetail",
                "retailid": RetailId,
                "date": d,
                "typestr": column.split(',')[0],
                "typesubstr": column.split(',')[1],
                "nums": v
            };
            $("#remark").text("数据保存中...")
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: obj,
                success: function (data) {
                    if (data.error == 0) {
                        $("#remark").text("数据保存成功");
                        var classid = "zh_" + o;
                        //var classid1 = "zbm" + o;
                        var countclass = $("." + classid).attr("class").split(' ')[1];
                        //var zbclass = $("." + classid1).attr("class").split(' ')[0];
                        var num = 0;
                        $("#list .n_" + o).each(function () {
                            if ($(this).val() != "") {
                                num += parseInt($(this).val());
                            }
                        });

                        $("." + classid).html(num);
                        var cnum = 0;
                        $("#list ." + countclass).each(function () {
                            if ($(this).html() != "" && $(this).html() != "&nbsp;") {
                                cnum += parseInt($(this).html());
                            }
                        });
                        $("#list ." + countclass).each(function () {
                            var n = "&nbsp";
                            if ($(this).html() != "" && $(this).html() != "&nbsp;") {
                                var v = $(this).html();
                                n = v == "" ? "&nbsp;" : (parseInt(v) / cnum * 100).toFixed(1) + "%";
                                //$(".zb" + o).html(n);
                            }
                            $(".zb_" + $(this).attr('id')).html(n);
                        });
                    } else {
                        alert("数据保存失败，错误：" + data.msg);
                        return false;
                    }
                },
                error: function (d) {
                    alert("提交出错");
                    return false;
                }
            });
        }

        function query() {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            LoadData(y, m);
        }

        function Sure() {
            if ($("#btnsure").hasClass("disabled")) {
                return false;
            }

            var id = $("#hidid").val();
            if (id == "") {
                alert("ID为空，请刷新再试！");
                return false;
            }
            
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "SureRetail", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("审核成功");
                        $("#hidchk_sure").val("1");
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
            var id = $("#hidid").val();
            if (id == "") {
                alert("ID为空，请刷新再试！");
                return false;
            }
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "unSureRetail", "id": id, "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("反审核成功");
                        $("#hidchk_sure").val("0");
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        $("input:text").attr("disabled", false);
                    } else if (data.error == -1) {
                        alert("单据已登账,不能反审核");
                    } else {
                        alert("反审核失败，错误：" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("反审核出错");
                }
            });
        }

        function OnCount() {
            if ($("#btncount").hasClass("disabled")) {
                return false;
            }
            var date = $("#hiddate").val();
            var id = $("#hidid").val();
            
            if (id == "") {
                alert("ID为空，请刷新再试！");
                return false;
            }
            var chksure = $("#hidchk_sure").val();
            if (chksure == "1") {
                alert("单据已经审核，不能进行计算");
                return false;
            }
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "OnCount", "date": date,"id":id,"re":"0", "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("计算成功");
                        var y = $("#drp_Year").val();
                        var m = $("#drp_Month").val();
                        LoadData(y, m);
                    } else if (data.error == -1) {
                        alert("只能计算当月的数据，历史数据不能计算");
                    } else {
                        alert("计算失败，错误：" + data.msg);
                    }
                },
                error: function (d) {
                    alert("计算过程中出现错误！");
                }
            });
        }

        function OnReCount() {
            if ($("#btnrecount").hasClass("disabled")) {
                return false;
            }
            var date = $("#hiddate").val();
            var id = $("#hidid").val();
            if (id == "") {
                alert("ID为空，请刷新再试！");
                return false;
            }
            var chksure = $("#hidchk_sure").val();
            if (chksure == "1") {
                alert("单据已经审核，不能进行重算算");
                return false;
            }
            if (!confirm("是否要重算" + date + "的数据？\n注意：重算会把当天录入的数据覆盖")) {
                return false;
            }
            $.ajax({
                url: "ajax/Register.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "OnCount", "date": date, "id": id, "re": "1", "dt": new Date() },
                success: function (data) {
                    if (data.error == 0) {
                        alert("重算成功");
                        var y = $("#drp_Year").val();
                        var m = $("#drp_Month").val();
                        LoadData(y, m);
                    } else if (data.error == -1) {
                        alert("只能重算当月的数据，历史数据不能重算");
                    }else {
                        alert("重算失败，错误：" + data.msg);
                    }
                },
                error: function (d) {
                    alert("重算过程中出现错误！");
                }
            });
        }
        function setdate(i, date) {
            var d = $("#hiddate").val();
            $("#list tr").removeClass("clickbg");
            $("#list .tr_" + date).addClass("clickbg");
            $("#list .tr_" + d).find("td:eq(0)").css({ "background": "#fff" });
            $("#list .tr_" + d).find("td:eq(1)").css({ "background": "#fff" });
         
            $("#list .tr_" + date).find("td:eq(0)").css({ "background": "#FFCC33" });
            $("#list .tr_" + date).find("td:eq(1)").css({ "background": "#FFCC33" });
            
            $("#hiddate").val(date);
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
            window.location = "ajax/Excel.aspx?act=5&year=" + y + "&month=" + m;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="pow" value="" />
    <input type="hidden" id="hidid" value="" />
    <input type="hidden" id="hidchk_sure" value="" />
    <input type="hidden" runat="server" id="hiddate" value="" />
    <input type="hidden" runat="server" id="hidmonth" value="" />
    <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="query" />
                 <cc1:ButtonItem ID="btncount" runat="server" Text="计算当天" CssClass="icon icon-pencil" Callback="OnCount" />
                 <cc1:ButtonItem ID="btnrecount" runat="server" Text="重算当天" CssClass="icon icon-pencil" Callback="OnReCount" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="审核" CssClass="icon icon-tick" Callback="Sure" />
                 <cc1:ButtonItem ID="btnunsure" runat="server" Text="反审核" CssClass="icon icon-delete" Callback="unSure" />
                 <cc1:ButtonItem ID="btnexcel" runat="server" Text="导出Excel" CssClass="icon icon-export" Callback="Excel"/>
            </Buttons>
        </cc1:ToolbarControl>
   </div>
    <div id="main">
        <table border="0" cellpadding="1" cellspacing="1" width="450px">
            <tr class="trNor">
                <td width="225px" align="left">年份：<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="225px" align="left">月份：<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            <br />
        <div style="width:600px;float:left">
        <table border="0" cellpadding="1" cellspacing="1" class="tab">
        <tr class="trNor">
            <td colspan="3" align="center"><b>金额（元）</b></td>
            <td colspan="3" align="center"><b>数量（件）</b></td>
        </tr>
        <tr class="trNor" align="center">
            <td width="100px" >月金额目标</td>
            <td width="100px" >实际金额</td>
            <td width="100px" >金额完成率</td>
            <td width="100px" >月数量目标</td>
            <td width="100px" >实际数量</td>
            <td width="100px" >数量完成率</td>
        </tr>
        <tr class="trNor" align="center">
            <td ><label id="lbl_jemb"></label></td>
            <td ><label id="lbl_sjje"></label></td>
            <td ><label id="lbl_jewcl"></label></td>
            <td ><label id="lbl_slmb"></label></td>
            <td ><label id="lbl_sjsl"></label></td>
            <td ><label id="lbl_slwcl"></label></td>
        </tr>
        </table>
        </div>
        <br />
        <div id="mark">按回车保存数据&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label></div>
    </div>
    <div id="mainTable" style="width:100%;" class="divmain"></div>
    </form>
</body>
</html>
