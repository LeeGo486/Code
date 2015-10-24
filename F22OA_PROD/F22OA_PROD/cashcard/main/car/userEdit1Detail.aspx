<%@ page language="C#" autoeventwireup="true" inherits="car_userEdit1Detail, App_Web_useredit1detail.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href=".././css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width=100% align=center>
            <tr>
                <td  align=left >
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
                         <table border=1 width=100% align=center cellpadding=0 cellspacing=0 bordercolor="#cccccc"  bordercolordark="#ffffff">
                                <tr height=40><td colspan=2 align=center><font color=red size=3>维护卡使用人档案</font></td></tr>
                                <tr>
                                    <td width=20% align=right>编号：</td>
                                    <td> <asp:Label ID="proposeridLabel" runat="server" Text='<%# Eval("proposerid") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align=right>姓名：</td>
                                    <td>
                                        <asp:Label ID="namesLabel" runat="server" Text='<%# Bind("names") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtNames" runat="server" Text='<%# Bind("names") %>' Width=400px></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtNames" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>性别：</td>
                                    <td>
                                        <asp:Label ID="sexLabel" runat="server" Text='<%# Bind("sex") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtSex" runat="server" Text='<%# Bind("sex") %>' Width=400px></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate=txtSex runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>证件号：</td>
                                    <td>
                                        <asp:Label ID="identityLabel" runat="server" Text='<%# Bind("identity") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtIdentity" runat="server" Text='<%# Bind("identity") %>' Width=400px ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate=txtIdentity runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>固定电话：</td>
                                    <td>
                                        <asp:Label ID="telLabel" runat="server" Text='<%# Bind("tel") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtTel" runat="server" Text='<%# Bind("tel") %>' Width=400px ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate=txtTel runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTel"
            ErrorMessage="*只能输入数字" ValidationExpression="^([0-9]|-)*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                   <tr>
                                    <td align=right>移动电话：</td>
                                    <td>
                                        <asp:Label ID="mtelLabel" runat="server" Text='<%# Bind("mtel") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtMtel" runat="server" Text='<%# Bind("mtel") %>' Width=400px></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate=txtMtel></asp:RequiredFieldValidator>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtMtel"
            ErrorMessage="*只能输入数字" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>联系地址：</td>
                                    <td>
                                        <asp:Label ID="lblAdd" runat="server" Text='<%# Bind("add") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtAdd" runat="server" Text='<%# Bind("add") %>' Width=400px></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtAdd" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                    </td>
                                </tr>
                             
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Label ID="passwordtelLabel" runat="server" Text='<%# Bind("passwordtel") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtPasswordtel" runat="server" Text='<%# Bind("passwordtel") %>' Visible=false></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><asp:Label ID="passwordLabel" runat="server" Text='<%# Bind("password") %>' Visible=false></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align=right>备注：</td>
                                    <td>
                                        <asp:Label ID="commentLabel" runat="server" Text='<%# Bind("comment") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtComment" runat="server" Text='<%# Bind("comment") %>' Width=400px></asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                                 <tr>
                                    <td align=right>推荐人：</td>
                                    <td>
                                        <asp:Label ID="presenterLabel" runat="server" Text='<%# Bind("presenter") %>' Visible=false></asp:Label>
                                        <asp:TextBox ID="txtPresenter" runat="server" Text='<%# Bind("presenter") %>' Width=400px></asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                                 <tr>
                                    <td align=right>店铺编号：</td>
                                    <td>
                                        <asp:Label ID="depotidLabel" runat="server" Text='<%# Bind("depotid") %>'></asp:Label>
                                        <asp:TextBox ID="txtDepodid" runat="server" Text='<%# Bind("depotid") %>' Visible=false> </asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>建立店铺：</td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("d_name") %>' Visible=false> </asp:TextBox>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align=right>卡号：</td>
                                    <td>
                                       <asp:TextBox ID="txtcardid" runat="server" OnTextChanged="txtcardid_TextChanged"  Width=400px> </asp:TextBox><font color=red>*</font>
                                       <asp:RequiredFieldValidator  ID="RequiredFieldValidator7" runat="server" ErrorMessage="请输入卡号!" ControlToValidate="txtcardid" ></asp:RequiredFieldValidator><asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtcardid"
                                            ErrorMessage="卡号无效" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator> 
                                    </td>
                                </tr>
                         </table>
                        </ItemTemplate>
                    </asp:FormView>
                    </td>
            </tr>
            
            <tr>
                <td >
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnUpddate" runat="server" Text="更新" Width=70px OnClick="btnUpddate_Click" />&nbsp;&nbsp;
                    &nbsp;&nbsp;
                    <asp:HyperLink ID=hylReturn runat=server NavigateUrl='userEdit1.aspx?aspxid=CA1080&aspxname=维护申请人档案' Text="返回"></asp:HyperLink>
                    <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>--%>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblSavemessage" runat="server" Font-Size="15px" Visible=False ForeColor="Red"></asp:Label></td>
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
