<%@ page language="C#" autoeventwireup="true" inherits="AJAX_Vip_vipdetails, App_Web_vipdetails.aspx.3005feca" %>
<form id="form4" runat="server" style="text-align:left;">
<table style="width: 100%;">
    <tr>
        <td style="width:30%;" valign="top">
        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" 
            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="0" CellPadding="4" 
            Font-Names="arial" Font-Size="12px" Height="50px" Width="100%" 
            AutoGenerateRows="False" ForeColor="Black" GridLines="Vertical">
            <RowStyle BackColor="#F7F7DE" />
            <AlternatingRowStyle BackColor="White" />
            <Fields>
            <asp:BoundField DataField="vipname" HeaderText="姓名："/>
            <asp:BoundField DataField="vipstate" HeaderText="VIP状态："/>
            <asp:BoundField DataField="vipsex" HeaderText="性别："/>
            <asp:BoundField DataField="birth" HeaderText="出生日期："/>
            <asp:BoundField DataField="vippaper" HeaderText="证件类型："/>
            <asp:BoundField DataField="vippassport" HeaderText="证件号："/>
            <asp:BoundField DataField="viptel" HeaderText="固定电话："/>
            <asp:BoundField DataField="mobtel" HeaderText="移动电话："/>
            <asp:BoundField DataField="vipapply" HeaderText="申办方式："/>
            <asp:BoundField DataField="country" HeaderText="籍贯："/>
            <asp:BoundField DataField="people" HeaderText="民族："/>
            <asp:BoundField DataField="stature" HeaderText="身高："/>
            <asp:BoundField DataField="waistline" HeaderText="腰围："/>
            </Fields>
        </asp:DetailsView>
        </td>
        <td style="width:30%;" valign="top">
        <asp:DetailsView ID="DetailsView2" runat="server" BackColor="White" 
            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="0" CellPadding="4" 
            Font-Names="arial" Font-Size="12px" Height="50px" Width="100%" 
            AutoGenerateRows="False" ForeColor="Black" GridLines="Vertical">
            <FooterStyle BackColor="#CCCC99" />
            <RowStyle BackColor="#F7F7DE" />
            <AlternatingRowStyle BackColor="White" />
            <Fields>
            <asp:BoundField DataField="city" HeaderText="所在区域："/>
            <asp:BoundField DataField="vipoccupation" HeaderText="职业："/>
            <asp:BoundField DataField="vippay" HeaderText="收入："/>
            <asp:BoundField DataField="vipmin" HeaderText="接受价位1："/>
            <asp:BoundField DataField="vipmax" HeaderText="接受价位2："/>
            <asp:BoundField DataField="viplove" HeaderText="个人爱好："/>
            <asp:BoundField DataField="vipgrab" HeaderText="着装风格："/>
            <asp:BoundField DataField="vipstyle" HeaderText="喜欢款式："/>
            <asp:BoundField DataField="vipcolor" HeaderText="喜欢颜色："/>
            <asp:BoundField DataField="vipsize" HeaderText="上装尺码："/>
            <asp:BoundField DataField="vipsize1" HeaderText="下装尺码："/>
            <asp:BoundField DataField="vipplace" HeaderText="购物场所："/>
            </Fields>
        </asp:DetailsView>
        </td>
        <td style="width:40%;" valign="top">
        <asp:DetailsView ID="DetailsView3" runat="server" BackColor="White" 
            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="0" CellPadding="4" 
            Font-Names="arial" Font-Size="12px" Height="50px" Width="100%" 
            AutoGenerateRows="False" ForeColor="Black" GridLines="Vertical">
            <FooterStyle BackColor="#CCCC99" />
            <RowStyle BackColor="#F7F7DE" />
            <AlternatingRowStyle BackColor="White" />
            <Fields>
            <asp:BoundField DataField="vipbrand1" HeaderText="喜爱品牌1："/>
            <asp:BoundField DataField="vipbrand2" HeaderText="喜爱品牌2："/>
            <asp:BoundField DataField="vipbrand3" HeaderText="喜爱品牌3："/>
            <asp:BoundField DataField="vipemail" HeaderText="电子邮箱："/>
            <asp:BoundField DataField="vippostalcode" HeaderText="邮政编码："/>
            <asp:BoundField DataField="vipadd" HeaderText="通讯地址："/>
            <asp:BoundField DataField="zcentum" HeaderText="总积分："/>
            <asp:BoundField DataField="pcentum" HeaderText="上季积分："/>
            <asp:BoundField DataField="zsums" HeaderText="总储值："/>
            <asp:BoundField DataField="tj_name" HeaderText="推荐人："/>
            <asp:BoundField DataField="tz_name" HeaderText="拓展人："/>
            <asp:BoundField DataField="comment" HeaderText="备注："/>    
            </Fields>
        </asp:DetailsView>
        </td>
    </tr>
</table>
</form>
