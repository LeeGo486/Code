<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="SafeMoney.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeMoney" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <meta charset="utf-8" content="" />
    <link href="../kindediter/themes/default/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../kindediter/themes/default/default.css" />
    <link rel="stylesheet" href="../kindediter/plugins/code/prettify.css" />
    <script charset="utf-8" src="../kindediter/kindeditor.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/lang/zh_CN.js" type="text/javascript"></script>
    <script charset="utf-8" src="../kindediter/plugins/code/prettify.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">


        function ValidategridDelete(btnCtrl) {


            return confirm('您真的要删除此行吗？');

        }
        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
        function CheckNull() {
            var v_TextBoxdept = document.getElementById("<%= DropDownListDept.ClientID%>").value;
            var v_TextBoxName = document.getElementById("<%= TextBoxReward.ClientID%>").value;
            var v_TextBoxyear = document.getElementById("<%= DropDownListYear.ClientID%>").value;


            if (Trim(v_TextBoxdept).length <= 0) {
                alert('部门不能为空！');
                return false;
            }
            if (Trim(v_TextBoxName).length <= 0) {
                alert('金额不能为空！');
                return false;
            }
            if (Trim(v_TextBoxyear).length <= 0) {
                alert('年度不能为空！');
                return false;
            }




            return true;
        }
   
    </script>
    <style type="text/css">
        #TextArea1
        {
            height: 140px;
            width: 450px;
        }
        #TextArea2
        {
            height: 60px;
            width: 450px;
        }
        #TextArea3
        {
            height: 60px;
            width: 450px;
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
            <div style="width: 240px; padding-left: 3px;">
                <div class="NewsTabList" id="lableType" runat="server" style="width: 670px;">
                    <span runat="server" id="SpanType" style="color: #0087ce;">部门金额</span>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                            <table style="width: 700px;">
                                <tr>
                                    <td style="width: 60px;">
                                        部门:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListDept" runat="server" Width="140px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 60px;">
                                        金额：
                                    </td>
                                    <td style="width: 100px;">
                                        <asp:TextBox Width="100px" ID="TextBoxReward" runat="server" AutoCompleteType="Disabled" Style="ime-mode: disabled" onkeypress="if ((event.keyCode<48 || event.keyCode>57) && event.keyCode!=45 ) event.returnValue=false;"></asp:TextBox>
                                    </td>
                                    <td style="width: 60px;">
                                        年度：
                                    </td>
                                    <td style="width: 80px;">
                                        <asp:DropDownList ID="DropDownListYear" runat="server" Width="140px">
                                        </asp:DropDownList>
                                                   </td>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="新增部门金额" OnClientClick="return CheckNull();" OnClick="AddValue" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="padding-left: 3px;">
                            <asp:GridView ID="GridViewEmployee" DataKeyNames="fid" HeaderStyle-HorizontalAligna="Center" AutoGenerateColumns="false" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnRowDeleting="GridViewEmployee_RowDeleting" OnRowEditing="GridViewEmployee_RowEditing" OnRowUpdating="GridViewEmployee_RowUpdating" OnRowCancelingEdit="GridViewEmployee_RowCancelingEdit" AllowSorting="True" Width="692px">
                                <HeaderStyle BackColor="#006699" ForeColor="White" />
                                <PagerSettings FirstPageText="" LastPageText="" NextPageText="" />
                                <Columns>
                                    <asp:BoundField DataField="fid" HeaderText="ID" ReadOnly="True" Visible="false" />
                                    <asp:BoundField DataField="deptname" HeaderText="部门" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="380" ReadOnly="true">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ControlStyle Width="180px" />
                                        <ItemStyle Width="180px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="deptmoney" HeaderText="金额" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="380">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ControlStyle Width="180px" />
                                        <ItemStyle Width="180px" />
                                    </asp:BoundField>
                                   
                                    <asp:BoundField DataField="deptyear" HeaderText="年份" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="380">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ControlStyle Width="180px" />
                                        <ItemStyle Width="180px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="编辑" HeaderStyle-BackColor="#006699" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="lcmdUpdate" runat="server" CommandName="Update" Width="30px">更新</asp:LinkButton>
                                            <asp:LinkButton ID="lcmdCancel_E" runat="server" CommandName="Cancel" Width="30px">取消</asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lcmdModify" runat="server" CommandName="Edit" Width="30px">修改</asp:LinkButton>
                                            <asp:LinkButton ID="lcmdDelete" runat="server" CommandName="Delete" Width="30px" OnClientClick="return ValidategridDelete(this);">刪除</asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="#006699" />
                                        <ItemStyle HorizontalAlign="Center" Width="120px" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings FirstPageText="" LastPageText="" NextPageText="" PreviousPageText="" />
                                <RowStyle Height="20px" BackColor="#F7F6F3" ForeColor="#333333" />
                                <FooterStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
