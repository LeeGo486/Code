<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="RewAdd.aspx.cs" Inherits="EPReper.Web.EPSafe.RewAdd" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" });
        });
    </script>
    <style type="text/css">
        .style1
        {
            width: 60px;
            height: 135px;
        }
        .style2
        {
            height: 135px;
        }
        .style3
        {
            width: 100px;
            height: 135px;
        }
        #TextAreaQuyu
        {
            height: 122px;
            width: 222px;
        }
        .style4
        {
            width: 230px;
        }
        .style5
        {
            height: 135px;
            width: 230px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 693px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>
            </div>
        </div>
        <div style="float: left; width: 120px;">
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全新闻管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="SateUl" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全新闻&type=安全新闻">安全新闻</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全信息管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul1" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公文">安全公文</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公告">安全公告</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=规章制度">规章制度</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=会议纪要">会议纪要</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全法规">安全法规</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全知识">安全知识</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全工作管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul3" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全工作&type=安全工作">安全工作</a></li>
                      <li><a href="SafeSugList.aspx">安全建议</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全责任管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul2" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeResAdd.aspx">安全隐患</a></li>
                    <li><a href="SafeDuAdd.aspx">安全责任</a></li>
                    <li><a href="SafeRewAdd.aspx">安全奖励</a></li>
                    <li><a href="SafeMoney.aspx">部门金额</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全书籍推荐</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul4" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeBookAdd.aspx">安全书籍</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全热点专题</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul5" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeZhuan.aspx">安全热点专题</a></li>
                </ul>
            </div>
        </div>
        <div style="float: left; width: 840px;">
            <div style="width: 240px; padding-left: 5px;">
                <div class="NewsTabList" id="lableType" runat="server" style="width: 520px;">
                    <span runat="server" id="SpanType" style="color: #0087ce;">安全奖励</span>
                </div>
                <div style="border: 1px solid #C0C0C0; padding: 5px; height: 300px; width: 800px; margin: auto; float: left;">
                    <table style="width: 700px;">
                        <tr>
                            <td style="width: 100px;">
                                部门
                            </td>
                            <td class="style4">
                                <asp:DropDownList ID="DropDownListDept" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true" Width="140px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 60px;">
                                责任人
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListPerson" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true" Width="140px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1">
                                区域
                            </td>
                            <td class="style5">
                                <textarea id="TextAreaQuyu" rows="6" runat="server"></textarea>
                            </td>
                            <td class="style3">
                                奖励金额
                            </td>
                            <td class="style2">
                                <asp:TextBox ID="TextBoxReward" runat="server" AutoCompleteType="Disabled" Style="ime-mode: disabled" onkeypress="if ((event.keyCode<48 || event.keyCode>57) && event.keyCode!=45 ) event.returnValue=false;"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <asp:Button ID="Button1" runat="server" Text="提交内容" OnClick="GetValue" OnClientClick="return CheckNull();" />
                    <script type="text/javascript">
                        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
                        function CheckNull() {
                            var v_TextBoxQuyu = document.getElementById("<%= TextAreaQuyu.ClientID%>").value;
                            var v_TextBoxPerson = document.getElementById("<%= DropDownListPerson.ClientID%>").value;
                            var v_TextBoxDept = document.getElementById("<%= DropDownListDept.ClientID%>").value;
                            var v_TextBoxReward = document.getElementById("<%= TextBoxReward.ClientID%>").value;



                            if (Trim(v_TextBoxQuyu).length <= 0) {
                                alert('区域 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxPerson).length <= 0) {
                                alert('责任人 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxDept).length <= 0) {
                                alert('部门 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxReward).length <= 0) {
                                alert('奖惩 不能为空！');
                                return false;
                            }

                            return true;
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
