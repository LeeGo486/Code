<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectRI.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.SelectRI" %>

<%@ Import Namespace="System.Data" %>
<%@ Register Src="../../Controls/PageNavigator.ascx" TagName="PageNavigator" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>自助维修平台</title>
    <link href="../../Styles/css.css" rel="Stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="Stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../Scripts/setdaytime1.js" type="text/javascript"></script>
    <style type="text/css">
        a
        {
            text-decoration: none;
            color: Maroon;
        }
    </style>
    <script type="text/javascript" language="javascript">
        $(function () {
            var bigclassid = $("#bigclassid").val();
            var secondclassid = $("#secondclassid").val();
            var thirdclassid = $("#thirdclassid").val();
            $.post("../../Ajax/ClassChuange.ashx", { "id": " 0" }, function (data, status) {
                if (status = "succse") {
                    var shis = $.parseJSON(data);
                    $("#BigClass").empty();
                    //                            var op = $("<option value=''></option>");
                    for (var i = 0; i < shis.length; i++) {
                        var shi = shis[i];
                        var op = $("<option value=" + shi.value + ">" + shi.text + "</option>");
                        $("#BigClass").append(op);
                    }
                    //                    var bigclassid = $("#bigclassid").val();
                    //                    //                    alert(bigclassid);
                    //                    var secondclassid = $("#secondclassid").val();
                    //                    var thirdclassid = $("#thirdclassid").val();
                    //                    var bigclassname = $("#bigclassname").val();
                    ////                    alert(bigclassname);
                    //                    var secondclassname = $("#secondclassname").val();
                    //                    var thirdclassname = $("#thirdclassname").val();
                    //                    $("#BigClass").append($("<option selected='selected' value=" + bigclassid + ">" + bigclassname + "</option>"));
                    //                    $("#SecondClass").append($("<option selected='selected' value=" + secondclassid + ">" + secondclassname + "</option>"));
                    //                    $("#ThirdClass").append($("<option selected='selected' value=" + thirdclassid + ">" + thirdclassname + "</option>"));
                    $("#BigClass").val(bigclassid);

                }
                else {
                    alert("服务器出错，请稍候重试！");
                }
            });

            //            alert(bigclassid);
            if (bigclassid != "") {
                $.post("../../Ajax/ClassChuange.ashx", { "id": bigclassid }, function (data, status) {
                    if (status = "succse") {
                        var shis = $.parseJSON(data);
                        $("#SecondClass").empty();
                        $("#ThirdClass").empty();
                        //                            var op = $("<option value=''></option>");
                        for (var i = 0; i < shis.length; i++) {
                            var shi = shis[i];
                            var op = $("<option value=" + shi.value + ">" + shi.text + "</option>");
                            $("#SecondClass").append(op);
                        }
                        $("#SecondClass").val(secondclassid);
                    }
                    else {
                        alert("服务器出错，请稍候重试！");
                    }
                });
            }

            //            alert(secondclassid);
            if (secondclassid != "") {
                $.post("../../Ajax/ClassChuange.ashx", { "id": secondclassid }, function (data, status) {
                    if (status = "succse") {
                        var shis = $.parseJSON(data);
                        $("#ThirdClass").empty();
                        //                            var op = $("<option value=''></option>");
                        for (var i = 0; i < shis.length; i++) {
                            var shi = shis[i];
                            var op = $("<option value=" + shi.value + " >" + shi.text + "</option>");
                            $("#ThirdClass").append(op);
                        }
                        $("#ThirdClass").val(thirdclassid);
                    }
                    else {
                        alert("服务器出错，请稍候重试！");
                    }
                });
            }
//            if (thirdclassid != "") {
//                $("#ThirdClass").val(thirdclassid);
//            }
            //主类别change事件
            $("#BigClass").change(function () {
                //                    alert($(this).val());
                var id = $(this).val();
                //                alert(id);
                $("#bigclassid").val(id);
                $("#secondclassid").val("");
                $("#thirdclassid").val("");
                $.post("../../Ajax/ClassChuange.ashx", { "id": id }, function (data, status) {
                    if (status = "succse") {
                        var shis = $.parseJSON(data);
                        $("#SecondClass").empty();
                        $("#ThirdClass").empty();
                        //                            var op = $("<option value=''></option>");
                        for (var i = 0; i < shis.length; i++) {
                            var shi = shis[i];
                            var op = $("<option value=" + shi.value + ">" + shi.text + "</option>");
                            $("#SecondClass").append(op);
                        }
                    }
                    else {
                        alert("服务器出错，请稍候重试！");
                    }
                });
            });
            //次类别change事件
            $("#SecondClass").change(function () {
                //                    alert($(this).val());
                var id = $(this).val();
                $("#secondclassid").val(id);
                $("#thirdclassid").val("");
                //                alert(id);
                $.post("../../Ajax/ClassChuange.ashx", { "id": id }, function (data, status) {
                    if (status = "succse") {
                        var shis = $.parseJSON(data);
                        $("#ThirdClass").empty();
                        //                            var op = $("<option value=''></option>");
                        for (var i = 0; i < shis.length; i++) {
                            var shi = shis[i];
                            var op = $("<option value=" + shi.value + " >" + shi.text + "</option>");
                            $("#ThirdClass").append(op);
                        }
                    }
                    else {
                        alert("服务器出错，请稍候重试！");
                    }
                });
            });
            //类别change事件
            $("#ThirdClass").change(function () {
                var id = $(this).val();
                $("#thirdclassid").val(id);
            });
        });
    </script>
    <script src="../../Scripts/public.js" type="text/javascript"></script>
</head>
<body>
    <center>
        <form id="form1" runat="server">
        <div class="header">
         <div style="display: none; text-align: center; color: #000; font-size: 14px;">
                <a href="../../RepairHealth.aspx"><strong style="height: 36px; line-height: 32px; float: left; text-decoration: underline;">用户自助首页</strong></a>
                <div style="height: 36px; font-size: xx-large;font-family: 微软雅黑;" >
                    自助维修平台</div>
            </div>
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="ReperInfo.aspx" style="margin-left: 10px"
                        title="我要报修">报 修</a><a href="ReperInfo.aspx?type=select" style="margin-left: 10px"
                            title="我要查询">查 询</a><span id="admins" runat="server" visible="false"><a href="../ReperClass/ReperClass_List.aspx"
                                style="margin-left: 10px" title="我是管理员">管理员</a><a href="../ReperInfo/SelectRI.aspx"
                                    style="margin-left: 10px" title="数据统计" class="on">数据统计</a></span>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="80%" colspan="2">
                                <font style="font-size: 20px; font-family: 微软雅黑;">统计信息</font>
                            </td>
                            <td width="20%" style="font-size: 18px; font-family: 微软雅黑;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left">
                                &nbsp;维修主类别：<select id="BigClass" runat="server" style="width: 150px"></select><input
                                    type="hidden" id="bigclassid" runat="server" /><input id="bigclassname" runat="server"
                                        type="hidden" />
                                &nbsp;维修次类别：<select id="SecondClass" runat="server" style="width: 150px"></select><input
                                    type="hidden" id="secondclassid" runat="server" /><input id="secondclassname" runat="server"
                                        type="hidden" />
                                &nbsp;维修类别：<select id="ThirdClass" runat="server" style="width: 150px"></select><input
                                    type="hidden" id="thirdclassid" runat="server" /><input id="thirdclassname" runat="server"
                                        type="hidden" />
                                <br />
                                <br />
                                &nbsp; &nbsp; 报修部门：<input id="applydep" runat="server" style="width: 145px" />
                                &nbsp; &nbsp; &nbsp; 报修人：<input id="applyname" runat="server" style="width: 145px" />
                                &nbsp; &nbsp; 维修人：<input id="repairname" runat="server" style="width: 145px" />
                                <br />
                                <br />
                                &nbsp; &nbsp; 报修时间：<input id="starttime" runat="server" style="width: 145px"  readonly="readonly" onclick="setDayHM(this);" />&nbsp;
                                &nbsp; &nbsp; &nbsp; 至 &nbsp; &nbsp; &nbsp; &nbsp;<input id="endtime" runat="server"
                                    style="width: 150px"  readonly="readonly" onclick="setDayHM(this);" />
                                &nbsp;任务状态：<select id="start" runat="server" style="width: 150px">
                                    <option></option>
                                    <option value="finish = 0 and isdel = 0">未接受</option>
                                    <option value="finish = 1">已接受</option>
                                    <option value="finish = 2">已完成</option>
                                    <option value="isdel = 1">已取消</option>
                                </select>&nbsp;&nbsp;
                                <asp:Button ID="Save" runat="server" class="btn3_mouseout" Font-Size="12px" Height="20px"
                                    OnClick="Save_Click" onmousedown="this.className='btn3_mousedown'" onmouseout="this.className='btn3_mouseout'"
                                    onmouseover="this.className='btn3_mouseover'" onmouseup="this.className='btn3_mouseup'"
                                    Text="查  询" title="查  询" Width="60px" />&nbsp; &nbsp;
                                <asp:Button ID="Button2" runat="server" class="btn3_mouseout" Font-Size="12px" Height="20px"
                                    OnClick="Clear_Click" onmousedown="this.className='btn3_mousedown'" onmouseout="this.className='btn3_mouseout'"
                                    onmouseover="this.className='btn3_mouseover'" onmouseup="this.className='btn3_mouseup'"
                                    Text="全  部" title="全  部" Width="60px" />&nbsp; &nbsp;
                                <asp:Button ID="Button1" runat="server" class="btn3_mouseout" Font-Size="12px" Height="20px"
                                    OnClick="Execl_Click" onmousedown="this.className='btn3_mousedown'" onmouseout="this.className='btn3_mouseout'"
                                    onmouseover="this.className='btn3_mouseover'" onmouseup="this.className='btn3_mouseup'"
                                    Text="数据导出" title="导出Excel" Width="80px" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Repeater ID="show" runat="server">
                        <HeaderTemplate>
                            <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0"
                                cellpadding="1" cellspacing="1">
                                <tr class="TR_BG">
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                        报修单号
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        维修主类别
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        维修次类别
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        维修类别
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 6%">
                                        报修人
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 19%">
                                        报修部门
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 6%">
                                        维修人
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        报修时间
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 7%">
                                        任务状态
                                    </td>
                                    <%--<td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        要求完成时间
                                    </td>--%>
                                    <%--                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 60px">
                                        任务操作<!--<input type="checkbox" value="-222" onclick="selectAll(this.form,this.checked);" />-->
                                    </td>--%>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>
                                <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                    <%#((DataRowView)Container.DataItem)["BaseCodes"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["BigClassName"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["SecondClassName"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["ThirdClassName"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='6%'>
                                    <%#((DataRowView)Container.DataItem)["ApplyName"]%>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='19%'>
                                    <%#((DataRowView)Container.DataItem)["ApplyDEP"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='6%'>
                                    <%#((DataRowView)Container.DataItem)["RepairName"]%>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["UpTime"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='7%'>
                                    <%#((DataRowView)Container.DataItem)["state"] %>
                                </td>
                                <%--<td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["Times"] %>
                                </td>--%>
                                <%--                                <td align='center' valign='middle' class='sysmain_navi' width='60px'>
                                    <%#((DataRowView)Container.DataItem)["op"] %>
                                </td>--%>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <span style='margin-right: 5px'>每页显示条数
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>15</asp:ListItem>
                            <asp:ListItem>20</asp:ListItem>
                            <asp:ListItem>25</asp:ListItem>
                            <asp:ListItem>30</asp:ListItem>
                            <asp:ListItem>50</asp:ListItem>
                            <asp:ListItem>100</asp:ListItem>
                            <asp:ListItem>200</asp:ListItem>
                        </asp:DropDownList>
                        <uc2:PageNavigator ID="PageNavigator1" runat="server" />
                    </span>&nbsp;
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        </form>
    </center>
</body>
</html>
