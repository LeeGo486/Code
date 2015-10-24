<%@ page language="C#" autoeventwireup="true" inherits="pos_pos_f22_aspx_f22qry_retail_style_seach_mxsub, App_Web_f22qry_retail_style_seach_mxsub.aspx.ed8ccbd3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>销售-按款查询-明细</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="head"> 
        <asp:Label ID="Label1" runat="server" Text="Label" Font-Size="12px"></asp:Label>
    </div>
    <div id="conter">
    
        <asp:GridView ID="GridView1" runat="server" Width="500px" 
            AutoGenerateColumns="False" CellPadding="4" Font-Size="12px" 
            ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          
            <RowStyle BorderColor="#660033" BorderStyle="Solid" BorderWidth="1px" />
          
            <EmptyDataRowStyle BorderColor="Maroon" BorderStyle="Solid" BorderWidth="1px" />
          
            <Columns>
                <asp:BoundField DataField="styleid" HeaderText="款式编号" />
                <asp:BoundField DataField="color" HeaderText="颜色" />
                <asp:BoundField DataField="sizeid" HeaderText="尺码" />
                <asp:BoundField DataField="numss" HeaderText="数量" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#FFCCCC" Font-Bold="True" ForeColor="White" 
                Height="25px" />
         
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    
    </div>
    
    <div>
    
    <br/>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <input type="button" name="Submit" class="noprint" value=": 关闭此窗口 :" style="BACKGROUND-COLOR: #FFFFFF; BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; BORDER-RIGHT: 1px solid; BORDER-TOP: 1px solid; FONT-SIZE: 9pt" onClick="javascript:window.opener=null;window.close();">
            </div>
    </form>
</body>
</html>
