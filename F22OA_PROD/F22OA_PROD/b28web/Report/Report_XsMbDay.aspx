<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_Report_XsMbDay, App_Web_report_xsmbday.aspx.7863a146" enableviewstatemac="false" enableEventValidation="false" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

<link href="css/base.css" rel="stylesheet" type="text/css" />
    <script src="js/Fixed.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-1.2.6.min.js" type="text/javascript"></script> 
    <title>����ÿ������Ŀ��</title>
    <style type="text/css">
        .mian
        {
            width: 450px;
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
            height:25px;
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
            $("#remark").text("");
            $("#hidid").val("");
            $("hidsure").val("0");
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "getXsMbDay", "year": y, "month": m, "dt": new Date().toString() },
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
                        if (d.list.length > 0) {
                            $("#hidid").val(d.list[0].id);
                            $.each(d.list, function (i, itme) {
                                sums += parseFloat(itme.goal);
                                var strdis = "";
                                if (d.chksure == 1) {
                                    strdis = "disabled='disabled'";
                                }
                                var strgoal = "<input type='text' class='txtsums' id='" + (itme.id + "_" + itme.date) + "' value='" + (parseFloat(itme.goal) == 0 ? "" : parseFloat(itme.goal).toFixed(0)) + "' style='width:100px' " + strdis + "/>";
                                var tr = $("<tr class='trNor'><td width='180px'>" + itme.day + "</td><td width='120px'>" + itme.week + "</td><td width='150px'>" + strgoal + "</td></tr>");
                                tr.appendTo($("#mainTable tbody"));
                            });
                        }
                        var foot = $("<tr class='head'><td colspan='2'>�ϼ�</td><td ><div class='totalGoal'>" + sums + "</div></td></tr>")
                        foot.appendTo($("#mainTable tbody"));
                        $("#chaer").html(d.totalgoal - sums);
                        $("input:text").keydown(function (e) {
                            if (e.keyCode == 13) {
                                $(this).change();
                            }
                        }).bind("change", function () {
                            var id = $(this).attr("id");
                            var goal = $(this).val();
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
                        alert("û�е���");
                    }
                    else {
                        $("#btnunsure").addClass("disabled");
                        $("#btnsure").addClass("disabled");
                        $("#lbl_TotalGoal").text('δ�ƶ�������Ŀ��');
                    }
                    setpow();
                    var height = $(window).height();
                    FixTable("mainTable", 0, 480, (height - 145));
                },
                error: function (d) {
                    alert("���ݼ���ʧ��");
                }
            });
        }
        function SaveGoal(id, goal) {
            var mrg = /^\d+(\.\d{0,2})?$/;
            if (goal != "") {
                if (!mrg.test(goal)) {
                    alert("���������0��������Ŀ����(����2λС��)");
                    return false;
                }
            } else {
                goal = "0";
            }
            var sure = $("hidsure").val();
            if (sure == "1") {
                alert("�����˵��ݲ����޸�")
                return false;
            }
            var xid = id.split('_')[0];
            var date = id.split('_')[1];
            //var billtype = $("#hiddw").val();
            var sums = 0;
            $("#mainTable .txtsums").each(function () {
                if ($(this).val() != "") {
                    sums += parseFloat($(this).val());
                }
            });
//            if (sums < parseFloat($("#lbl_TotalGoal").text())) {
//                alert("��������Ŀ��ϼ�[" + sums + "]����С�ڱ�������Ŀ��[" + $("#lbl_TotalGoal").text() + "]");
//                $("#" + id).focus();
//                return false;
//            }
            $("#remark").text("���ݱ�����...")
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "SaveDayGoal", "id": xid, "date": date, "goal": goal, "billtype": "0", "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {

                        $("#remark").text("���ݱ���ɹ�");
                        $(".totalGoal").html(sums);
                        var c = parseFloat($("#lbl_TotalGoal").text()) - sums;
                        $("#chaer").html(c);
                    } else {
                        alert("���ݱ���ʧ��,����" + data.msg);
                        $("#remark").text("���ݱ���ʧ��");
                    }
                },
                error: function (d) {
                    alert("����ʧ��");
                    $("#remark").text("����ʧ��");
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
                alert("��������Ŀ��ϼ�[" + goal + "]����С�ڱ�������Ŀ��[" + totalgoal + "],���" + (parseFloat(totalgoal) - parseFloat(goal)) + "");
                return false;
            }
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "SureDayGoal", "id": id, "year": y, "month": m, "billtype": "0", "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {
                        $("hidsure").val("1");
                        $("#btnsure").addClass("disabled");
                        $("#btnunsure").removeClass("disabled");
                        alert("��˳ɹ�")
                        $("input:text").attr("disabled",true);
                    } else if (data.error == -1) {
                        alert("��������Ŀ��ϼ�[" + data.msg + "]����С�ڱ�������Ŀ��[" + totalgoal + "],���" + (parseFloat(totalgoal) - parseFloat(data.msg)) + "");
                        return false;

                    } else if (data.error == -2) {
                        alert("�����ѵ���");
                        return false;
                    } else {
                        alert("���ʧ��,����" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("����ʧ��");
                }
            });
        }

        function unSure() {
            if ($("#btnunsure").hasClass("disabled")) {
                return false;
            }
            var sure=$("hidsure").val();
            if (sure == "0") {
                alert("�˵�δ��ˣ����ܽ��з����")
                return false;
            }
            var id = $("#hidid").val();
            $.ajax({
                url: "ajax/XsMb.ashx",
                data: { "act": "unSureDayGoal", "id": id, "dt": new Date() },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.error == 0) {
                        $("hidsure").val("0");
                        $("#btnsure").removeClass("disabled");
                        $("#btnunsure").addClass("disabled");
                        alert("����˳ɹ�")
                        $("input:text").attr("disabled", false);
                    } else if (data.error == -1) {
                        alert("�����ѵ��ˣ����ܷ����");
                    }
                    else {
                        alert("���ʧ��,����" + data.msg);
                    }
                    setpow();
                },
                error: function (d) {
                    alert("����ʧ��");
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
            window.location = "ajax/Excel.aspx?act=0&year=" + y + "&month=" + m;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="pow" value="" />
    <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="��ѯ" CssClass="icon icon-find" Callback="q_query" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="���" CssClass="icon icon-tick" Callback="Sure" />
                 <cc1:ButtonItem ID="btnunsure" runat="server" Text="�����" CssClass="icon icon-delete" Callback="unSure" />
                 <cc1:ButtonItem ID="btnexcel" runat="server" Text="����Excel" CssClass="icon icon-export" Callback="Excel" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>
        <div style="float:left;width:100%">
        <input type="hidden" id="hidid" value=""  />
            <input type="hidden" id="hidsure" value="" />
            <div class="tit">���̣�<label id="lblDepot" runat="server"></label></div>
            <div class="tit">�½������Ŀ�꣺<label id="lbl_TotalGoal"></label>Ԫ</div>
            <table border="0" cellpadding="1" cellspacing="1" width="250" >
            <tr class="trNor">
                <td width="125px" align="left">��ݣ�<asp:DropDownList runat="server" ID="drp_Year"></asp:DropDownList></td>
                <td width="125px" align="left">�·ݣ�<asp:DropDownList runat="server" ID="drp_Month"></asp:DropDownList></td>
            </tr>
            </table>
            <div id="mark">���س���������&nbsp;&nbsp;&nbsp;&nbsp;<label id="remark"></label>&nbsp;&nbsp;&nbsp;&nbsp;���:<label id="chaer"></label>Ԫ</div>
            </div>
        <div class="mian">
            <table id="mainTable" border="0" cellpadding="" cellspacing="1" class="tab">
            <thead>
            <tr class="head">
                <td width="180px">����</td>
                <td width="120px">����</td>
                <td width="150px">����Ŀ��<label id="s_dw">(Ԫ)</label><input type="hidden" value="" id="hiddw" /></td>
            </tr>
            </thead>
            <tbody></tbody>
            </table>
        </div>
       
    </form>
</body>
</html>

