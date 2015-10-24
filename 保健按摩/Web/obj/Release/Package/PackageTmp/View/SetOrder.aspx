<%@ Page Title="" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="SetOrder.aspx.cs" Inherits="Web.View.SetOrder" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>雅莹保健预约</title>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div style="height: 70px;">
            <div style="height: 60px; float: left; width: 160px; margin: auto; background-image: url(../Images/abouthealth.png);">
            </div>
            <div style="height: 60px; float: right; width: 780px; margin: auto; background-image: url(../Images/heathtitle.png);">
                <div style="padding-left: 20px; float: left; height: 60px; line-height: 60px; overflow: hidden;">
                    <span style="color: #3366CC"><strong style="color: #787CC8">预约保健服务</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li><a href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li class="liselect"><a style="color: White;" href="UserOrder.aspx">我要预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医师排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false"><a  href="PinHistory.aspx">评价记录</a></li>
             
                </ul>
            </div>
            <div style="width: 780px; float: right;">
                <div style="border: 1px solid #CCCCFF; margin: auto; padding: 5px 10px 10px 20px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div>
                                <div style="padding: 10px 0px 10px 0px; font-weight: 700; text-align: center; font-size: large">
                                    保健预约信息描述</div>
                                <table class="Tmain3">
                                    <tr>
                                        <td>
                                            &nbsp; 保健医师：<asp:Label ID="LabelDoctor" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp; 保健时间段：<asp:Label ID="LabelDateTime" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp; 保健人：<asp:Label ID="LabelUser" runat="server" Text="Label" Width="150px"></asp:Label>
                                            所属部门：<asp:Label ID="LabelDept" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp; 联系电话：<asp:TextBox ID="TextBoxTel" runat="server" AutoCompleteType="Disabled" ></asp:TextBox>
                                        </td>
                                    </tr>
                                     <tr id="healthother1" runat="server" visible="false" >
                                        <td>
                                            <div runat="server" style="color: Red;">
                                                &nbsp; 其他保健人：<asp:TextBox ID="TextBoxOther" runat="server"  Width="100px"  AutoCompleteType="Disabled" ></asp:TextBox>
                                                   &nbsp; 所属部门：<asp:TextBox ID="TextBoxOtherDept" runat="server" AutoCompleteType="Disabled" ></asp:TextBox>
                                                *若为他人预约服务，请在此处输入保健人姓名
                                            </div>
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td style="background-color: #BFCFFF">
                                            &nbsp; 保健需求描述：
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <textarea id="TextAreaXuqiu" cols="20" style="width: 98%;" rows="10" runat="server"></textarea>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%--<div style=" color:Red; font-size: small;">
                    为了确保预约成功，请您在五分钟之内填写好保健需求并提交。
                    </div>--%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="Button1" runat="server" Text="提交" Width="100px" Font-Size="Larger" OnClick="Btn_OK" />
                </div>
            </div>
        </form>
    </body>
    </html>
</asp:Content>
