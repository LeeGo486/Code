<%@ page language="C#" autoeventwireup="true" inherits="car_userQuery1Detail, App_Web_userquery1detail.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>卡明细</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href=".././css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
<table style="WIDTH: 780px">
    <tr>
        <td>
        <table width="100%">
        <tr>
        <td align="left" style="width:600px">
        <asp:Label ID="lblTitle" runat="server" Text="卡明细列表："></asp:Label>
        </td>
        <td>
            &nbsp;</td>
        </tr>
        </table>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView id="GridView1" runat="server" Width="100%" DataKeyNames="cardid" CaptionAlign=left 
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" 
            DataSourceID="ObjectDataSource1" AllowPaging="True" PageSize=10 >
            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
            <Columns>

                <asp:BoundField DataField="names" HeaderText="姓名" ReadOnly="True" SortExpression="cardid" />
                <asp:BoundField DataField="cardid" HeaderText="卡号" ReadOnly="True" SortExpression="cardid" />
                <asp:BoundField DataField="cardname" HeaderText="卡名称" SortExpression="cardname" />
                <asp:BoundField DataField="sums" HeaderText="金额" SortExpression="sums" />
                <asp:BoundField DataField="crdate" HeaderText="创建日期" SortExpression="crdate" DataFormatString={0:d} HtmlEncode=False  />
                <asp:BoundField DataField="lastdate" HeaderText="lastdate" SortExpression="lastdate" Visible=false />
                <asp:BoundField DataField="username" HeaderText="创建人" SortExpression="crname" />                
                <%--<asp:CheckBoxField DataField="start" HeaderText="是否有效" SortExpression="start" />--%>
                <asp:BoundField DataField="statename" HeaderText="卡状态" SortExpression="start" />
                <asp:BoundField DataField="proposerid" HeaderText="proposerid" SortExpression="proposerid" Visible=false />
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" Visible=false />
                <asp:BoundField DataField="d_name" HeaderText="发卡店铺" SortExpression="depotid" />
                <asp:BoundField DataField="comment" HeaderText="备注" SortExpression="comment" />
              
                
            </Columns>

            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

            <EditRowStyle BackColor="#2461BF"></EditRowStyle>

            <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

            <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

            <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
            </asp:GridView>
            
            <asp:ObjectDataSource ID=ObjectDataSource1 TypeName=jproposer SelectMethod="queryselectDetil" runat=server>
                <SelectParameters>
                    <asp:Parameter Name=proposerid Type=Int32 />
                </SelectParameters>
            </asp:ObjectDataSource>
        </td>
    </tr>
    <tr>
        <td align=center>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>
