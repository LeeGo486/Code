<%@ page language="C#" autoeventwireup="true" inherits="car_userQuery1Detail1, App_Web_userquery1detail1.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href=".././css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width=100%>
            <tr>
                <td>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="proposerid" DataSourceID="ObjectDataSource1" Width=100%>
                        <EditItemTemplate>
                            proposerid:
                            <asp:Label ID="proposeridLabel1" runat="server" Text='<%# Eval("proposerid") %>'>
                            </asp:Label><br />
                            names:
                            <asp:TextBox ID="namesTextBox" runat="server" Text='<%# Bind("names") %>'>
                            </asp:TextBox><br />
                            sex:
                            <asp:TextBox ID="sexTextBox" runat="server" Text='<%# Bind("sex") %>'>
                            </asp:TextBox><br />
                            identity:
                            <asp:TextBox ID="identityTextBox" runat="server" Text='<%# Bind("identity") %>'>
                            </asp:TextBox><br />
                            tel:
                            <asp:TextBox ID="telTextBox" runat="server" Text='<%# Bind("tel") %>'>
                            </asp:TextBox><br />
                            add:
                            <asp:TextBox ID="addTextBox" runat="server" Text='<%# Bind("add") %>'>
                            </asp:TextBox><br />
                            mtel:
                            <asp:TextBox ID="mtelTextBox" runat="server" Text='<%# Bind("mtel") %>'>
                            </asp:TextBox><br />
                            passwordtel:
                            <asp:TextBox ID="passwordtelTextBox" runat="server" Text='<%# Bind("passwordtel") %>'>
                            </asp:TextBox><br />
                            password:
                            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>'>
                            </asp:TextBox><br />
                            comment:
                            <asp:TextBox ID="commentTextBox" runat="server" Text='<%# Bind("comment") %>'>
                            </asp:TextBox><br />
                            presenter:
                            <asp:TextBox ID="presenterTextBox" runat="server" Text='<%# Bind("presenter") %>'>
                            </asp:TextBox><br />
                            depotid:
                            <asp:TextBox ID="depotidTextBox" runat="server" Text='<%# Bind("depotid") %>'>
                            </asp:TextBox><br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                Text="更新">
                            </asp:LinkButton>
                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="取消">
                            </asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            names:
                            <asp:TextBox ID="namesTextBox" runat="server" Text='<%# Bind("names") %>'>
                            </asp:TextBox><br />
                            sex:
                            <asp:TextBox ID="sexTextBox" runat="server" Text='<%# Bind("sex") %>'>
                            </asp:TextBox><br />
                            identity:
                            <asp:TextBox ID="identityTextBox" runat="server" Text='<%# Bind("identity") %>'>
                            </asp:TextBox><br />
                            tel:
                            <asp:TextBox ID="telTextBox" runat="server" Text='<%# Bind("tel") %>'>
                            </asp:TextBox><br />
                            add:
                            <asp:TextBox ID="addTextBox" runat="server" Text='<%# Bind("add") %>'>
                            </asp:TextBox><br />
                            mtel:
                            <asp:TextBox ID="mtelTextBox" runat="server" Text='<%# Bind("mtel") %>'>
                            </asp:TextBox><br />
                            passwordtel:
                            <asp:TextBox ID="passwordtelTextBox" runat="server" Text='<%# Bind("passwordtel") %>'>
                            </asp:TextBox><br />
                            password:
                            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>'>
                            </asp:TextBox><br />
                            comment:
                            <asp:TextBox ID="commentTextBox" runat="server" Text='<%# Bind("comment") %>'>
                            </asp:TextBox><br />
                            presenter:
                            <asp:TextBox ID="presenterTextBox" runat="server" Text='<%# Bind("presenter") %>'>
                            </asp:TextBox><br />
                            depotid:
                            <asp:TextBox ID="depotidTextBox" runat="server" Text='<%# Bind("depotid") %>'>
                            </asp:TextBox><br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                Text="插入">
                            </asp:LinkButton>
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="取消">
                            </asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                         <table  border=1 width=100% align=center cellpadding=0 cellspacing=0 bordercolor="#cccccc"  bordercolordark="#ffffff" >
                                <tr height=40><td colspan=2 align=center><font color=red size=3>查看卡使用人档案</font></td></tr>
                                <tr height=20>
                                    <td width=30%  align=right>编号：</td>
                                    <td> <asp:Label ID="proposeridLabel" runat="server" Text='<%# Eval("proposerid") %>'></asp:Label></td>
                                </tr>
                                <tr height=20>
                                    <td align=right>姓名：</td>
                                    <td>
                                        <asp:Label ID="namesLabel" runat="server" Text='<%# Bind("names") %>'></asp:Label>&nbsp;                                        
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>性别：</td>
                                    <td>
                                        <asp:Label ID="sexLabel" runat="server" Text='<%# Bind("sex") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>证件号：</td>
                                    <td>
                                        <asp:Label ID="identityLabel" runat="server" Text='<%# Bind("identity") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>固定电话：</td>
                                    <td>
                                        <asp:Label ID="telLabel" runat="server" Text='<%# Bind("tel") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>联系地址：</td>
                                    <td>
                                        <asp:Label ID="lblAdd" runat="server" Text='<%# Bind("add") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>移动电话：</td>
                                    <td>
                                        <asp:Label ID="mtelLabel" runat="server" Text='<%# Bind("mtel") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Label ID="passwordtelLabel" runat="server" Text='<%# Bind("passwordtel") %>' Visible=false></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><asp:Label ID="passwordLabel" runat="server" Text='<%# Bind("password") %>' Visible=false></asp:Label></td>
                                </tr>
                                <tr height=20>
                                    <td align=right>备注：</td>
                                    <td>
                                        <asp:Label ID="commentLabel" runat="server" Text='<%# Bind("comment") %>' Width=400px></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>推荐人：</td>
                                    <td>
                                        <asp:Label ID="presenterLabel" runat="server" Text='<%# Bind("presenter") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>店铺编号：</td>
                                    <td>
                                        <asp:Label ID="depotidLabel" runat="server" Text='<%# Bind("depotid") %>'></asp:Label>
                                        <asp:TextBox ID="txtDepodid" runat="server" Text='<%# Bind("depotid") %>' Visible=false> </asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>建立店铺：</td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("d_name") %>' Visible=false> </asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                         </table>
                        </ItemTemplate>
                    </asp:FormView>
                </td>
            </tr>
            <tr>
                <td align=center>
                    
                    <asp:Button ID="btnUpddate" runat="server" Text="更新" Width=70px OnClick="btnUpddate_Click" Visible="False" />
                    <asp:HyperLink ID=hylReturn runat=server NavigateUrl='userquery1.aspx?aspxid=CA1080&aspxname=维护申请人档案' Text="返回"></asp:HyperLink>
                    <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>--%>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSavemessage" runat="server" Text="" Font-Size=20px Visible=false></asp:Label></td>
            </tr>
        </table>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:carcn %>"
            SelectCommand="SELECT * FROM [j_proposer]"></asp:SqlDataSource>
            
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetUpdateProposer"
            TypeName="jcard">
            <SelectParameters>
                <asp:Parameter  Type=String Name="ID" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>