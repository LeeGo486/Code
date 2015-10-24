<%@ page language="C#" autoeventwireup="true" inherits="car_cardEdit1Detail, App_Web_cardedit1detail.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>维护充值档案明细</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href=".././css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
   <%-- <script  type="text/javascript">
    function GetVipShop() 
    { 			
	    var url="SDBuildVipShop.aspx";	    
        window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
    }
    </script>--%>
    <script  type="text/javascript">
    function GoUrlVipShop() 
    { 
    			
//	    var url="SDBuildVipShop.aspx";
//	    var result=showaspx(url,660,353);
//    	
//	    if (result!="" && result!=undefined)
//         {
//         
//            var arvalues=result.split(",");
//             window.document.getElementById("ctl00_ctplhder_txtDepotid").value=arvalues[0];
//    //         window.document.getElementById("ctl00_ctplhder_TxtShopName").value=arvalues[1];
//           
//         }

    var url="SDBuildVipShop.aspx";	    
    var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
	if (result!="" && result!=undefined)
     {
     
        var arvalues=result.split(",");
         window.document.getElementById("hiddepot").value=arvalues[0];
//         window.document.getElementById("ctl00_ctplhder_txtDepotid").value=arvalues[1];
       
     }

    }

    </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width=95%>
            <tr>
                <td>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cardid" DataSourceID="ObjectDataSource1" Width=100% Caption="" Font-Size=Larger CaptionAlign=left  Font-Bold=true>
                        <EditItemTemplate>
                            cardid:
                            <asp:Label ID="cardidLabel1" runat="server" Text='<%# Eval("cardid") %>'></asp:Label><br />
                            cardname:
                            <asp:TextBox ID="cardnameTextBox" runat="server" Text='<%# Bind("cardname") %>'>
                            </asp:TextBox><br />
                            sums:
                            <asp:TextBox ID="sumsTextBox" runat="server" Text='<%# Bind("sums") %>'>
                            </asp:TextBox><br />
                            crdate:
                            <asp:TextBox ID="crdateTextBox" runat="server" Text='<%# Bind("crdate") %>'>
                            </asp:TextBox><br />
                            lastdate:
                            <asp:TextBox ID="lastdateTextBox" runat="server" Text='<%# Bind("lastdate") %>'>
                            </asp:TextBox><br />
                            crname:
                            <asp:TextBox ID="crnameTextBox" runat="server" Text='<%# Bind("crname") %>'>
                            </asp:TextBox><br />
                            comment:
                            <asp:TextBox ID="commentTextBox" runat="server" Text='<%# Bind("comment") %>'>
                            </asp:TextBox><br />
                            start:
                            <asp:CheckBox ID="startCheckBox" runat="server" Checked='<%# Bind("start") %>' /><br />
                            proposerid:
                            <asp:TextBox ID="proposeridTextBox" runat="server" Text='<%# Bind("proposerid") %>'>
                            </asp:TextBox><br />
                            password:
                            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>'>
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
                            cardid:
                            <asp:TextBox ID="cardidTextBox" runat="server" Text='<%# Bind("cardid") %>'>
                            </asp:TextBox><br />
                            cardname:
                            <asp:TextBox ID="cardnameTextBox" runat="server" Text='<%# Bind("cardname") %>'>
                            </asp:TextBox><br />
                            sums:
                            <asp:TextBox ID="sumsTextBox" runat="server" Text='<%# Bind("sums") %>'>
                            </asp:TextBox><br />
                            crdate:
                            <asp:TextBox ID="crdateTextBox" runat="server" Text='<%# Bind("crdate") %>'>
                            </asp:TextBox><br />
                            lastdate:
                            <asp:TextBox ID="lastdateTextBox" runat="server" Text='<%# Bind("lastdate") %>'>
                            </asp:TextBox><br />
                            crname:
                            <asp:TextBox ID="crnameTextBox" runat="server" Text='<%# Bind("crname") %>'>
                            </asp:TextBox><br />
                            comment:
                            <asp:TextBox ID="commentTextBox" runat="server" Text='<%# Bind("comment") %>'>
                            </asp:TextBox><br />
                            start:
                            <asp:CheckBox ID="startCheckBox" runat="server" Checked='<%# Bind("start") %>' /><br />
                            proposerid:
                            <asp:TextBox ID="proposeridTextBox" runat="server" Text='<%# Bind("proposerid") %>'>
                            </asp:TextBox><br />
                            password:
                            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>'>
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
                            <table  border=1 width=100% align=center cellpadding=0 cellspacing=0 bordercolor="#cccccc"  bordercolordark="#ffffff">
                                <tr height=40><td colspan=2 align=center><font color=red size=3>维护充值卡档案</font></td></tr>
                                <tr height=20>
                                    <td width=15% align=right>卡号：</td>
                                    <td><asp:Label ID="cardidLabel" runat="server" Text='<%# Eval("cardid") %>'></asp:Label></td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>卡名称:</td>
                                    <td>
                                        <asp:TextBox ID="txtCardname" runat="server" Text='<%# Bind("cardname") %>' Visible=false></asp:TextBox>
                                        <asp:Label ID="cardnameLabel" runat="server" Text='<%# Bind("cardname") %>' ></asp:Label>
                                    </td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>金额:</td>
                                    <td><asp:Label ID="sumsLabel" runat="server" Text='<%# Bind("sums") %>'></asp:Label>&nbsp;</td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>创建日期:</td>
                                    <td><asp:Label ID="crdateLabel" runat="server" Text='<%# Bind("crdate") %>'></asp:Label></td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>最后更新日期:</td>
                                    <td><asp:Label ID="lastdateLabel" runat="server" Text='<%# Bind("lastdate") %>'></asp:Label></td>
                                </tr>
                                 <tr height=20>
                                    <td align=right>创建人：</td>
                                    <td><asp:Label ID="crnameLabel" runat="server" Text='<%# Bind("username") %>'></asp:Label>&nbsp;</td>
                                </tr>
                                <tr height=20>
                                    <td align=right>备注：</td>
                                    <td>
                                        <asp:TextBox ID="txtComment" runat="server"  Text='<%# Bind("comment") %>' Width=400px></asp:TextBox>
                                        <asp:Label ID="commentLabel" runat="server" Text='<%# Bind("comment") %>' Visible=false></asp:Label>                                    
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>卡状态：</td>
                                    <td>
                                        <%--<asp:CheckBox ID="startCheckBox" runat="server" Checked='<%# Bind("start") %>' Enabled=true />--%>
                                        <asp:DropDownList ID="ddlcardstate" runat="server">
                                            <asp:ListItem Text=待定 Value="-"></asp:ListItem>
                                            <asp:ListItem Text=启用 Value=1></asp:ListItem>
                                            <asp:ListItem Text=未启用 Value=0></asp:ListItem>
                                            <asp:ListItem Text=冻结 Value=2></asp:ListItem>
                                            <asp:ListItem Text=挂失 Value=3></asp:ListItem>
                                            <asp:ListItem Text=失效 Value=4></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>客户编号：</td>
                                    <td><asp:Label ID="proposeridLabel" runat="server" Text='<%# Bind("proposerid") %>'>
                            </asp:Label>&nbsp;</td>
                                    
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><asp:Label ID="passwordLabel" runat="server" Text='<%# Bind("password") %>' Visible=false></asp:Label></td>
                                </tr>
                                <tr height=20>
                                    <td align=right>店铺编号:</td>
                                    <td>
                                        <asp:TextBox ID="txtDepotid" runat="server" Text='<%# Bind("depotid") %>'></asp:TextBox>
                                        <asp:Label ID="depotidLabel" runat="server" Text='<%# Bind("depotid") %>' Visible=false></asp:Label>
                                        <asp:Button ID="btnSelectDepot" runat="server" Text="选择店铺" OnClientClick="GoUrlVipShop()" />
                                    </td>
                                </tr>
                                <tr height=20>
                                    <td align=right>店铺名称:</td>
                                    <td>                                       
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:carcn %>"
                        SelectCommand="SELECT * FROM [j_card]"></asp:SqlDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetUpdateJcard"
                        TypeName="jcard">
                        <SelectParameters>
                            <asp:Parameter  Type=String Name="ID" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
            <tr>
        <td align=center>
            <asp:Button ID="btnUpddate" runat="server" Text="更新" Width=70px OnClick="btnUpddate_Click" />&nbsp;&nbsp;
            &nbsp;&nbsp;
            <asp:HyperLink ID=hylReturn runat=server NavigateUrl='cardedit1.aspx?aspxid=CA1030&aspxname=维护充值卡档案' Text="返回"></asp:HyperLink>
            <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-2);' >返回上一页</asp:HyperLink>--%>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblSavemessage" runat="server" Text="" Font-Size=20px Visible=false></asp:Label></td>
    </tr>
    <tr>
        <td>
            <asp:HiddenField  ID=hiddepot runat=server OnValueChanged="hiddepot_ValueChanged"/>
        </td>
    </tr>
            
        </table>
    </div>
    </form>
</body>
</html>
