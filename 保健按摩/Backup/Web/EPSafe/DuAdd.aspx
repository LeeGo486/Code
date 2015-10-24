<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="DuAdd.aspx.cs" Inherits="EPReper.Web.EPSafe.DuAdd" %>

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
        #TextAreaQuyu
        {
            width: 455px;
        }
        .style1
        {
            height: 24px;
            width: 257px;
        }
      
        .style3
        {
            height: 24px;
            width: 206px;
        }
        .style4
        {
            width: 120px;
        }
        .style5
        {
            height: 24px;
            width: 120px;
        }
        .style6
        {
            width: 120px;
        }
        .style7
        {
            height: 24px;
            width: 120px;
        }
        .style8
        {
            width: 257px;
        }
        .style9
        {
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
            <div style="width: 794px; padding-left: 5px;">
                <div class="NewsTabList" id="lableType" runat="server" style="width: 520px;">
                    <span runat="server" id="SpanType" style="color: #0087ce;">安全责任</span>
                </div>
                <div style="border: 1px solid #C0C0C0; padding: 5px; height: 300px; width: 800px; margin: auto; float: left;">
                    <table style="width: 85%;">
                        <tr>
                            <td class="style4">
                                部门</td>
                            <td class="style9">
                            <asp:TextBox ID="TextBoxDept" runat="server" AutoCompleteType="Disabled" Width="120px"></asp:TextBox>
                       
                                </td>
                            <td class="style6">
                                时间</td>
                            <td class="style8">
                                <asp:DropDownList ID="DropDownListYear" runat="server" Width="140px">
                                        </asp:DropDownList>
                              <%--  <asp:TextBox ID="TextBoxDate" runat="server" AutoCompleteType="Disabled" Width="120px"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                                安全员</td>
                            <td class="style3">
                                <asp:TextBox ID="TextBoxPerson" runat="server" AutoCompleteType="Disabled" Width="120px"></asp:TextBox>
                            </td>
                            <td class="style7">
                                是否重点区域</td>
                            <td class="style1">
                                <asp:DropDownList ID="DropDownListImportant" runat="server">
                                <asp:ListItem Value="是">是</asp:ListItem>
                                <asp:ListItem Value="否">否</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style4">
                                部门长</td>
                            <td class="style9">
                                <asp:TextBox ID="TextBoxDeptLeader" runat="server" AutoCompleteType="Disabled" Width="120px"></asp:TextBox>
                            </td>
                            <td class="style2">
                                区域分类</td>
                            <td class="style6">
                                <asp:TextBox ID="TextBoxFenlei" runat="server" AutoCompleteType="Disabled" Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style4">
                                安全区域</td>
                            <td class="style9" colspan="3" rowspan="2">
                                <textarea id="TextAreaQuyu" cols="60" rows="8" runat="server" name="S1"></textarea></td>
                        </tr>
                        <tr>
                            <td class="style4">
                                &nbsp;</td>
                        </tr>
                    </table>
                    <asp:Button ID="Button1" runat="server" Text="提交内容" OnClick="GetValue" OnClientClick="return CheckNull();" />
                    <script type="text/javascript">
                        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
                        function CheckNull() {
                            var v_TextBoxQuyu = document.getElementById("<%= TextAreaQuyu.ClientID%>").value;
                            var v_TextBoxPerson = document.getElementById("<%= TextBoxPerson.ClientID%>").value;
                            var v_TextBoxDept = document.getElementById("<%= TextBoxDept.ClientID%>").value;
                            var v_TextBoxFenlei = document.getElementById("<%= TextBoxFenlei.ClientID%>").value;

                            var v_TextBoxDate = document.getElementById("<%= DropDownListYear.ClientID%>").value;


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

                            if (Trim(v_TextBoxFenlei).length <= 0) {
                                alert('区域类型 不能为空！');
                                return false;
                            }

                            if (Trim(v_TextBoxDate).length <= 0) {
                                alert('区域类型 不能为空！');
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
