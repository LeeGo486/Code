<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_EmployeeRegister, App_Web_report_employeeregister.aspx.7863a146" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>店铺营业员月销售登记表</title>
    <%--<script src="js/Fixed.js" type="text/javascript"></script>--%>
   <link href="css/base.css" rel="stylesheet" type="text/css" />
   <%--<link type="text/css" rel="Stylesheet" href="css/lockedheaders.css" />--%>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
    <link href="../Utility/base.css" rel="stylesheet" type="text/css" />
   <style type="text/css">
        .tab
        {
            text-align:center;
            width:250px;
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
        
        .counttd
        {
            background:#99CCFF;
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
        var xsfiles = "";
        function LoadData(y, m) {
            $("#list_tableLayout").remove();
            $("#remark").text("")
            $("#lbl_mb").text("");
             $("#mainTable").html("");
             $("#mainTable").html("<div style='width:100%;text-align:center'>正在加载数据...</div>");
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
                 url: "ajax/Employee.ashx",
                 type: "post",
                 dataType: "json",
                 data: { "act": "EmployeeRegister", "year": y, "month": m, "dt": new Date().toString() },
                 success: function (data) {
                     if (data.error == 0) {
                         $("#btnsure").removeClass("disabled");
                         $("#btnunsure").removeClass("disabled");
                         $("#hidid").val(data.id);
                         $("#hidchk_sure").val(data.chkSure);
                         var dis = "";
                         if (data.chkSure == 1) {
                             dis = "disabled='disabled'";
                             $("#btnsure").addClass("disabled");
                         } else {
                             $("#btnunsure").addClass("disabled");
                         }
                         $("#lbl_mb").text(data.goal);
                         var employee = data.employee;
                         var head = data.head;
                         var mainData = data.main;
                         var TDwidth = 55;
                         var ZHTDwidth = 80;
                         var width = 300 + (head.length * employee.length * TDwidth) + (head.length * ZHTDwidth);
                         //组合表
                         var html = "<table id='list' class='miantable' width='" + width + "'>";
                         html += "<thead><tr><td  rowspan='2' class='Locked'>日期</td><td  rowspan='2' class='Locked'>星期</td>" +
                        "<td rowspan='2' class='Locked'>店铺日目标</td><td  rowspan='2' class='VLocked'>天气</td><td  rowspan='2' class='VLocked'>店铺活动折扣</td>";
                         $.each(employee, function (i, item) {
                             html += "<td class='VLocked' colspan='" + head.length + "' width='" + (head.length * TDwidth) + "px'>" + item["names"] + "</td>";
                         });
                         html += "<td class='VLocked' colspan='" + head.length + "' width='" + (head.length * ZHTDwidth) + "px'>合计</td>";
                         html += "</tr>"
                         html += "<tr>"
                         $.each(employee, function (i, item) {
                             $.each(head, function (xi, xitem) {
                                 html += "<td width='" + TDwidth + "px' class='VLocked h_" + (item.employeeid + "_" + xitem.key) + "'>" + xitem.lookname + "</td>"
                             });
                         });
                         $.each(head, function (xi, xitem) {
                             html += "<td width='" + ZHTDwidth + "px' class='VLocked count_" + xitem.key + "'>" + xitem.lookname + "</td>";
                         });
                         html += "</tr></thead><tbody>"
                         var t1 = {};

                         $.each(mainData, function (i, item) {
                             var bg = dd == item["d"] ? "clickbg" : "";
                             //onmouseover=\"this.style.background='#FFCC33'\" onmouseout=\"this.style.background='#FFF'\"
                             html += "<tr class='" + bg + " tr_" + item["d"] + "' onclick=\"setdate('" + i + "','" + item["d"] + "')\">";
                             html += "<td class='td_" + item["d"] + " HLocked' width='60px'>" + item.date + "</td><td width='60px' class='" + bg + " HLocked'>" + item.week + "</td><td width='70px' class='" + bg + " HLocked'>" + (item.Sums_RetailGoal == "0.00" ? "" : parseFloat(item.Sums_RetailGoal).toFixed(0)) + "&nbsp;</td>";
                             html += "<td class='td_" + item["d"] + "' width='60px'><input type='text' " + dis + " style='width:55px' id='tq_" + (item.RetailId + "_" + item.d) + "' value='" + item.Weather + "'/></td>";
                             html += "<td class='td_" + item["d"] + "' width='60px'><input type='text' " + dis + " style='width:55px' id='zk_" + (item.RetailId + "_" + item.d) + "' value='" + (parseFloat(item.ActivityDis) == 0 ? "" : item.ActivityDis) + "' /></td>";
                             var t = {};
                             $.each(employee, function (xi, xitem) {
                                 $.each(head, function (xxi, xxitem) {
                                     var key = xitem.employeeid + "_" + xxitem.key;

                                     html += "<td width='" + TDwidth + "px'><input defval='" + (parseFloat(item[key]) == 0 ? "" : Number(item[key])) + "' type='text' " + dis + " style='width:40px' class='nums num_" + (item.d + "_" + xxitem.key) + "' id='num_" + (item.RetailId + "_" + item.d + "_" + key) + "' value='" + (parseFloat(item[key]) == 0 ? "" : Number(item[key])) + "'/></td>";
                                     if (t[xxitem.key] != undefined) {
                                         t[xxitem.key] = Number(t[xxitem.key]) + Number(item[key]);
                                     }
                                     else {
                                         t[xxitem.key] = item[key];
                                     }
                                     if (t1[key] != undefined) {
                                         t1[key] = Number(t1[key]) + Number(item[key]);
                                     }
                                     else {
                                         t1[key] = item[key];
                                     }
                                 });
                             });
                             $.each(head, function (xxi, xxitem) {
                                 var num = parseFloat(t[xxitem.key]) == 0 ? "&nbsp;" : parseFloat(t[xxitem.key]).toFixed(0);
                                 html += "<td width='" + ZHTDwidth + "px' class='counttd xfootcount_" + xxitem.key + " count_" + (item.d + "_" + xxitem.key) + "' id='count_" + (item.d + "_" + xxitem.key) + "'>" +  num + "</td>";
                             });
                             html += "</tr>";
                         });
                         html += "</tbody>";
                         html += "<table>";
                         $("#mainTable").html("");
                         $("#mainTable").html(html);

                         var countTR = "<tr class='head'><td colspan='3' width='410px' class='Locked'>合计</td><td class='VLocked'>&nbsp;</td><td class='VLocked'>&nbsp;</td>";
                         var t2 = {};
                         $.each(employee, function (xi, xitem) {
                             $.each(head, function (xxi, xxitem) {
                                 var key = xitem.employeeid + "_" + xxitem.key;
                                 var num = parseFloat(t1[key]) == 0 ? "&nbsp;" : t1[key];
                                 num = (num != "&nbsp;" && parseFloat(num) != 0) ? Number(parseFloat(num).toFixed(2)) : num;
                                 countTR += "<td width='" + TDwidth + "px' class='footc_" + xxitem.key + " footcount_" + key + " VLocked' id='footcount_" + key + "'>" + num + "</td>";
                                 if (t2[xxitem.key] != undefined) {
                                     t2[xxitem.key] = Number(t2[xxitem.key]) + Number(t1[key]);
                                 }
                                 else {
                                     t2[xxitem.key] = t1[key];
                                 }
                             });
                         });
                         $.each(head, function (xxi, xxitem) {
                             var num = parseFloat(t2[xxitem.key]) == 0 ? "&nbsp;" : parseFloat(t2[xxitem.key]).toFixed(0);
                             countTR += "<td width='" + ZHTDwidth + "px' class='counttd xfootc_" + xxitem.key + " xxfootcount_" + xxitem.key + " VLocked' id='xfootcount_" + xxitem.key + "'>" + num + "</td>";
                         });
                         countTR += "</tr>";
                         $("#list thead").append(countTR);
                         //销售员月目标
                         var goalTR = "<tr class='head'><td colspan='3' width='410px' class='Locked'>本月目标</td><td class='VLocked'>&nbsp;</td><td class='VLocked'>&nbsp;</td>";
                         var totalGoal = 0;
                         $.each(employee, function (i, item) {
                             var v = 0;
                             if (item.RetailGoal != "" && parseInt(item.RetailGoal) != 0) {
                                 v = parseInt(item.RetailGoal);
                             }
                             totalGoal += v;
                             goalTR += "<td colspan='" + head.length + "' class='VLocked' id='" + item.employeeid + "_mb'>" + (v == 0 ? "&nbsp;" : v) + "</td>";
                         });
                         goalTR += "<td colspan='" + head.length + "' class='VLocked' id='zh_mb'>" + (totalGoal == 0 ? "&nbsp;" : totalGoal) + "</td>";
                         $("#list thead").append(goalTR);
                         //销售员月目标完成率
                         $.each(head, function (i, item) {
                             if (item.lookname == "销售金额") {
                                 xsfiles = item.key;
                             }
                         });
                         var wclTR = "<tr class='head'><td colspan='3' width='410px' class='Locked' style='background:#FFFF99'>完成率</td><td style='background:#FFFF99' class='VLocked'>&nbsp;</td><td style='background:#FFFF99' class='VLocked'>&nbsp;</td>";
                         var totalGoal = 0;
                         $.each(employee, function (i, item) {
                             var key = "footcount_" + item.employeeid + "_" + xsfiles;
                             var xs = 0;
                             if ($("#" + key) != undefined && $("#" + key).html() != "" && $("#" + key).html() != "&nbsp;") {
                                 xs = parseInt($("#" + key).html());
                             }
                             var RetailGoal = 0;
                             var key1 = item.employeeid + "_mb";
                             if ($("#" + key1) != undefined && $("#" + key1).html() != "" && $("#" + key1).html() != "&nbsp;") {
                                 RetailGoal = parseInt($("#" + key1).html());
                             }
                             var v = (xs == 0 || RetailGoal == 0) ? "&nbsp;" : parseFloat((xs / RetailGoal * 100)).toFixed(2) + "%";
                             wclTR += "<td colspan='" + head.length + "' class='xVLocked' id='" + item.employeeid + "_wcl'>" + v + "</td>";
                         });

                         var key2 = "xfootcount_" + xsfiles;
                         var xs1 = 0;
                         if ($("#" + key2) != undefined && $("#" + key2).html() != "" && $("#" + key2).html() != "&nbsp;") {
                             xs1 = parseInt($("#" + key2).html());
                         }
                         var countGoal = 0;
                         if ($("#zh_mb") != undefined && $("#zh_mb").html() != "" && $("#zh_mb").html() != "&nbsp;") {
                             countGoal = parseInt($("#zh_mb").html());
                         }
                         var v1 = (xs1 == 0 || countGoal == 0) ? "&nbsp;" : parseFloat((xs1 / countGoal * 100)).toFixed(2) + "%";
                         wclTR += "<td colspan='" + head.length + "' class='xVLocked' id='zh_wcl'>" + v1 + "</td>";
                         $("#list thead").append(wclTR);

                         $("input:text").keydown(function (e) {
                             if (e.keyCode == 13) {
                                 $(this).change();
                             }
                         })
                        .bind("change", function () {
                            var id = $(this).attr("id");
                            var v = $(this).val();
                            v = v == "" ? "0" : v;
                            SaveData(id, v);

                        }).keypress(function (e) {
                            if ($(this).hasClass('nums')) {
                                if (parseInt(ver) == 6) {
                                    if (e.keyCode == 13) {
                                        $(this).change();
                                        return false;
                                    }
                                }
                                if ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 46 && e.keyCode != 45) {
                                    return false;
                                }
                            }
                        });
                     } else if (data.error == -1) {
                         alert("没有单据");
                         $("#mainTable").html("<div style='width:100%;text-align:center'>没有单据</div>");
                         $("#btnsure").addClass("disabled");
                         $("#btnunsure").addClass("disabled");
                         $("#btncount").addClass("disabled");
                         $("#btnrecount").addClass("disabled");
                     } else {
                         alert("加载数据出错,错误：" + data.msg);
                     }
                     setpow();

                     $("#list .tr_" + dd).find("td:eq(0)").css({ "background": "#FFCC33" });
                     $("#list .tr_" + dd).find("td:eq(1)").css({ "background": "#FFCC33" });
                     $("#list .tr_" + dd).find("td:eq(2)").css({ "background": "#FFCC33" });
                     $("#list .tr_" + dd).find("td:eq(3)").css({ "background": "#FFCC33" });
                     $("#list .tr_" + dd).find("td:eq(4)").css({ "background": "#FFCC33" });
                     //var width = $(document.body).width();
                     //FixTable("list", 1, width - 10, 470);
                 },
                 error: function (d) {
                     alert("加载数据出错");
                 }
             });
        }

        function clearNoNum(obj) {
            //先把非数字的都替换掉，除了数字和.
            obj.value = obj.value.replace(/[^\d.]/g, "");
            //必须保证第一个为数字而不是.
            obj.value = obj.value.replace(/^\./g, "");
            //保证只有出现一个.而没有多个.
            obj.value = obj.value.replace(/\.{2,}/g, ".");
            //保证.只出现一次，而不能出现两次以上
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");

            var index = obj.value.indexOf('.');
            if (index > 0) {
                obj.value = obj.value.substring(0, index + 3);
            }
        }
        var ver
        $(function () {
            var height = $(window).height();
            $("#mainTable").height(height - 112);
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();

            var ug = navigator.userAgent.toLowerCase();
            var IE = ug.match(/msie\s*\d\.\d/);
            ver = IE.join(" ").match(/[0-9]/g).join(".");
            LoadData(y, m);
        });

        function SaveData(id, v) {
            var arr = id.split('_');
            var type = arr[0];
            var id = arr[1];
            var date = arr[2];
            var employeeid = "";
            var o = "";
            //alert(type + "  " + id + "  " + date + "  " + employeeid + "  " + o);
            var typesubstr = "";
            var reg = /^-?\d+(\.\d{0,2})?$/;
            if (type == "num") {
                employeeid = arr[3];
                o = arr[4];
                var hclass = "h_" + employeeid + "_" + o;
                typesubstr = $("." + hclass).html();
                if (v != "") {
                    if (!reg.test(v)) {
                        alert("输入整数或者保留2位数的值");
                        $("#" + id).focus();
                        return false;
                    }
                }
                else {
                    v = "0";
                }
            }
            var obj = {
                "act": "SaveData",
                "type": type,
                "id": id,
                "date": date,
                "employeeid": employeeid,
                "typesubstr": typesubstr,
                "value": v
            };
            $("#remark").text("数据保存中...")
            $.ajax({
                url: "ajax/Employee.ashx",
                type: "post",
                dataType: "json",
                data: obj,
                success: function (data) {
                    if (data.error == 0) {
                        $("#remark").text("数据保存成功");
                        if (type == "num") {
                            var nums = 0;
                            $("#list .num_" + date + "_" + o).each(function () {
                                if ($(this).val() != "") {
                                    nums += Number($(this).val());
                                }
                            });
                            $("#list .count_" + date + "_" + o).html(nums);

                            nums = 0;
                            $("#list input:text[id$='" + (employeeid + "_" + o) + "']").each(function () {
                                if ($(this).val() != "") {
                                    nums += Number($(this).val());
                                }
                            });
                            $("#list .footcount_" + employeeid + "_" + o).html(Number(nums.toFixed(2)));

                            nums = 0;
                            $("#list .xfootcount_" + o + "").each(function () {
                                if ($(this).html() != "" && $(this).html() != "&nbsp;") {
                                    nums += Number($(this).html());
                                }
                            });
                            $("#xfootcount_" + o).html(Number(nums.toFixed(2)));

                            //如果更新了销售金额，则更新占比
                            if (o == xsfiles) {
                                var key = "footcount_" + employeeid + "_" + xsfiles;
                                var xs = 0;
                                if ($("#" + key).html() != "" && $("#" + key).html() != "&nbsp;") {
                                    xs = parseInt($("#" + key).html());
                                }
                                var key1 = employeeid + "_mb";
                                var goal = 0;
                                if ($("#" + key1).html() != "" && $("#" + key1).html() != "&nbsp;") {
                                    goal = parseInt($("#" + key1).html());
                                }
                                var v = (xs == 0 || goal == 0) ? "&nbsp;" : parseFloat((xs / goal * 100)).toFixed(2) + "%";
                                $("#" + employeeid + "_wcl").html(v);

                                var key2 = "xfootcount_" + xsfiles;
                                var xs1 = 0;
                                if ($("#" + key2).html() != "" && $("#" + key2).html() != "&nbsp;") {
                                    xs1 = parseInt($("#" + key2).html());
                                }
                                var totalgoal = 0;
                                if ($("#zh_mb").html() != "" && $("#zh_mb").html() != "&nbsp;") {
                                    totalgoal = parseInt($("#zh_mb").html());
                                }
                                var v1 = (xs1 == 0 || totalgoal == 0) ? "&nbsp;" : parseFloat((xs1 / totalgoal * 100)).toFixed(2) + "%";
                                $("#zh_wcl").html(v1);
                            }
                        }
                    }
                    else {
                        alert("保存成功，错误：" + data.msg);
                    }
                },
                error: function (d) {
                    alert("保存出错");
                }
            });
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
                url: "ajax/Employee.ashx",
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
                url: "ajax/Employee.ashx",
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
                        alert("单据已登账，不能反审核");
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

        function query() {
            var y = $("#drp_Year").val();
            var m = $("#drp_Month").val();
            LoadData(y, m);
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
                url: "ajax/Employee.ashx",
                type: "post",
                dataType: "json",
                data: { "act": "OnCount", "date": date, "id": id, "re": "0", "dt": new Date() },
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
                alert("单据已经审核，不能进行计算");
                return false;
            }
            if (!confirm("是否要重算" + date + "的数据？\n注意：重算会把当天录入的数据覆盖")) {
                return false;
            }
            $.ajax({
                url: "ajax/Employee.ashx",
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
                    } else {
                        alert("重算失败，错误：" + data.msg);
                    }
                },
                error: function (d) {
                    alert("重算过程中出现错误！");
                }
            });
        }

        function setdate(i,date) 
        {
            var d=$("#hiddate").val();
            $("#list tr").removeClass("clickbg");
            $("#list .tr_" + date).addClass("clickbg");

            $("#list .tr_" + d).find("td:eq(0)").css({ "background": "#fff" });
            $("#list .tr_" + d).find("td:eq(1)").css({ "background": "#fff" });
            $("#list .tr_" + d).find("td:eq(2)").css({ "background": "#fff" });
            $("#list .tr_" + d).find("td:eq(3)").css({ "background": "#fff" });
            $("#list .tr_" + d).find("td:eq(4)").css({ "background": "#fff" });
            $("#list .tr_" + date).find("td:eq(0)").css({ "background": "#FFCC33" });
            $("#list .tr_" + date).find("td:eq(1)").css({ "background": "#FFCC33" });
            $("#list .tr_" + date).find("td:eq(2)").css({ "background": "#FFCC33" });
            $("#list .tr_" + date).find("td:eq(3)").css({ "background": "#FFCC33" });
            $("#list .tr_" + date).find("td:eq(4)").css({ "background": "#FFCC33" });   
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
            var id = $("#hidid").val();
            window.location = "ajax/Excel.aspx?act=6&id=" + id + "&year=" + y + "&month=" + m;
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
    <div class="x-toolbar" >
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="query" />
                 <cc1:ButtonItem ID="btncount" runat="server" Text="计算今天" CssClass="icon icon-pencil" Callback="OnCount" />
                 <cc1:ButtonItem ID="btnrecount" runat="server" Text="重算今天" CssClass="icon icon-pencil" Callback="OnReCount" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="审核" CssClass="icon icon-tick" Callback="Sure" />
                 <cc1:ButtonItem ID="btnunsure" runat="server" Text="反审核" CssClass="icon icon-delete" Callback="unSure" />
                 <cc1:ButtonItem ID="btnexcel" runat="server" Text="导出Excel" CssClass="icon icon-export" Width="80px" Callback="Excel" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>
    <div id="main">
    <div style="width:280px;float:left">
        <table border="0" cellpadding="1" cellspacing="1" width="250px">
            <tr class="trNor" >
                <td width="125px" >年份：<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="125px" >月份：<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            </div>
            <div style="width:280px;float:left">
        <table border="0" cellpadding="1" cellspacing="1" width="250px">
            <tr class="trNor">
                <td>月销售金额目标：<label id="lbl_mb"></label>元</td>
            </tr>
            </table>
            </div>
        <br />
        <div id="mark">按回车保存数据&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label></div>
        
        <div id="mainTable" style="width:100%;" class="divmain"></div>
    </div>
    
    </form>
</body>
</html>
