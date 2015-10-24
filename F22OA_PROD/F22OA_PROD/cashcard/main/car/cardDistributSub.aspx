<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardDistributSub, App_Web_carddistributsub.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<script  type="text/javascript">
    function GoUrlVipShop() 
    { 

    var url="SDBuildVipShop.aspx";	    
    var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:353px;");
	if (result!="" && result!=undefined)
     {     
        var arvalues=result.split(",");
         window.document.getElementById("ctl00_ctplhder_txtDepotid").value=arvalues[0];
         window.document.getElementById("ctl00_ctplhder_TextBox1").value=arvalues[1];       
     }

    }

    </script>  
 <%--   <asp:UpdatePanel id="UpdatePanel3" runat="server">
        <contenttemplate>--%>
<BR />
<TABLE style="WIDTH: 732px" height="100%" cellSpacing=0 cellPadding=0 align=center border=0><TBODY>
<TR>
    <TD style="WIDTH: 98px">客户号： </TD>
    <TD style="WIDTH: 256px"><asp:Label id="lbproposerid" runat="server" ForeColor="#3300FF"></asp:Label></TD>
    <TD style="WIDTH: 109px">姓名：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2><asp:Label id="lbname" runat="server" ForeColor="#3300FF"></asp:Label></TD>
</TR>
<TR>
    <TD style="WIDTH: 98px">证件号：</TD>
    <TD style="WIDTH: 256px">&nbsp;<asp:Label id="lbidentity" runat="server" ForeColor="#3300FF"></asp:Label> </TD>
    <TD style="WIDTH: 109px">
        移动电话：</TD><TD style="WIDTH: 592px; HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2><asp:Label id="lbmtelpsw" runat="server" ForeColor="#3300FF"></asp:Label></TD>
</TR>
<TR>
    <TD style="WIDTH: 98px">
        <asp:CheckBox ID="ckb1" runat="server" Text=" " OnCheckedChanged="ckb1_CheckedChanged" AutoPostBack=true Checked=true />卡号1：</TD>
    <TD style="WIDTH: 256px">
        <asp:TextBox id="txtcardid" runat="server" MaxLength="50" AutoPostBack="true" OnTextChanged="txtcardid_TextChanged" ></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid">*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
    </TD>
    <TD style="WIDTH: 109px">
        充值金额1：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2>
        <asp:TextBox id="txtsums" runat="server" MaxLength="10"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtsums" SetFocusOnError="True" ></asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator1" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums"  SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"></asp:RangeValidator>
    </TD>
</TR>
<TR>
    <TD style="WIDTH: 98px; height: 29px;">
        <asp:CheckBox ID="ckb2" runat="server" Text=" "  AutoPostBack=true OnCheckedChanged="ckb2_CheckedChanged" />卡号2：</TD>
    <TD style="WIDTH: 256px; height: 29px;">
        <asp:TextBox id="txtcardid2" runat="server" MaxLength="50" AutoPostBack="true" Enabled="False" OnTextChanged="txtcardid2_TextChanged"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid2"  Enabled=false>*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator2" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid2" OnServerValidate="CustomValidator2_ServerValidate"  Enabled=false></asp:CustomValidator>
    </TD>
    <TD style="WIDTH: 109px; height: 29px;">
        充值金额2：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 29px; TEXT-ALIGN: left" colSpan=2>
        <asp:TextBox id="txtsums2" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtsums2" SetFocusOnError="True"  Enabled=false></asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator2" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums2" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false></asp:RangeValidator>
    </TD>
</TR>
<TR>
    <TD style="WIDTH: 98px">
        <asp:CheckBox ID="ckb3" runat="server" Text=" " AutoPostBack=true OnCheckedChanged="ckb3_CheckedChanged" />卡号3：</TD>
    <TD style="WIDTH: 256px">
        <asp:TextBox id="txtcardid3" runat="server" MaxLength="50" AutoPostBack="true"  Enabled="false" OnTextChanged="txtcardid3_TextChanged"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid3"  Enabled=false>*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator3" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid3" OnServerValidate="CustomValidator3_ServerValidate"  Enabled=false></asp:CustomValidator>
    </TD>
    <TD style="WIDTH: 109px">
        充值金额3：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2>
        <asp:TextBox id="txtsums3" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="txtcardid3" SetFocusOnError="True"  Enabled=false></asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator3" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums3" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false></asp:RangeValidator>
    </TD>
</TR>
<TR>
    <TD style="WIDTH: 98px">
        <asp:CheckBox ID="ckb4" runat="server" Text=" " AutoPostBack=true OnCheckedChanged="ckb4_CheckedChanged" />卡号4：</TD>
    <TD style="WIDTH: 256px">
        <asp:TextBox id="txtcardid4" runat="server" MaxLength="50" AutoPostBack="true"  Enabled=false OnTextChanged="txtcardid4_TextChanged"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid4"  Enabled=false>*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator4" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid4" OnServerValidate="CustomValidator4_ServerValidate"  Enabled=false></asp:CustomValidator>
    </TD>
    <TD style="WIDTH: 109px">
        充值金额4：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 26px; TEXT-ALIGN: left" colSpan=2>
        <asp:TextBox id="txtsums4" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="txtsums4" SetFocusOnError="True"  Enabled=false></asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator4" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums4" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false></asp:RangeValidator>
    </TD>
</TR>
<TR>
    <TD style="WIDTH: 98px; height: 40px;">
        <asp:CheckBox ID="ckb5" runat="server" Text=" " AutoPostBack=true OnCheckedChanged="ckb5_CheckedChanged"/>卡号5：</TD>
    <TD style="WIDTH: 256px; height: 40px;">
        <asp:TextBox id="txtcardid5" runat="server" MaxLength="50" AutoPostBack="true"  Enabled=false OnTextChanged="txtcardid5_TextChanged"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator9" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid5"  Enabled=false>*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator5" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid5" OnServerValidate="CustomValidator5_ServerValidate"  Enabled=false></asp:CustomValidator>
    </TD>
    <TD style="WIDTH: 109px; height: 40px;">
        充值金额5：</TD>
    <TD style="WIDTH: 592px; HEIGHT: 40px; TEXT-ALIGN: left" colSpan=2>
        <asp:TextBox id="txtsums5" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="txtsums5" SetFocusOnError="True"  Enabled=false></asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator5" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums5" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false></asp:RangeValidator>
    </TD>
</TR>
<tr>
    <td  align=left style="width: 98px; height: 8px;">
    <asp:CheckBox id="ckbpwd" runat="server"  Text="输入卡密码：" AutoPostBack="True" 
    OnCheckedChanged="ckbpwd_CheckedChanged" Width="95px" Checked="true"></asp:CheckBox></td>
    <td style="width: 256px; height: 8px">
        <asp:TextBox id="txtcardpwd" runat="server" Width="148px"  Height="16px" TextMode="Password" MaxLength="6"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator12" runat="server" 
         ErrorMessage="输入卡密码!" ControlToValidate="txtcardpwd" Display="Dynamic"></asp:RequiredFieldValidator>
        
    </td>
    <td  align=left style="width: 109px; height: 8px;">
        确认卡密码：</td>
    <td style="height: 8px">
        <asp:TextBox id="txtcardpwdre" runat="server" Width="148px"  Height="16px" TextMode="Password"  MaxLength="6"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator13" runat="server" 
         ErrorMessage="请再输入一次！" ControlToValidate="txtcardpwdre"></asp:RequiredFieldValidator> 
        <asp:CompareValidator id="CompareValidator1" runat="server"  ErrorMessage="两次输入卡密码不一致！" ControlToValidate="txtcardpwdre" Display="Dynamic" Enabled="False" ControlToCompare="txtcardpwd"></asp:CompareValidator>
    </td>
</tr>
<tr><td colspan=4 style="color: #ff0000">
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:Label ID="lblpwdmessage" runat="server" Text="(输入六位卡密码(可含数字和字符,如：0-9,A-Z等))"
        Visible="False"></asp:Label></td></tr>
<TR>
    <TD colSpan=3 style="height: 34px">
        <asp:Label ID="lbldepot" runat="server" Text="发卡店铺："></asp:Label>
        <asp:TextBox ID="txtDepotid" runat="server" Width="91px" BackColor="#ECF3F6" BorderStyle="None" Enabled="False"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="请选择店铺!" ControlToValidate=txtDepotid Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:Button ID="btnSelectdepot" runat="server" Text="选择店铺" OnClientClick="GoUrlVipShop()" Visible="False" BackColor="#ECF3F6" BorderStyle="Groove" />
        <asp:TextBox ID="TextBox1" runat="server" Width="142px" BackColor="#ECF3F6" BorderStyle="None"></asp:TextBox>
    </TD>
    <%--<TD style="WIDTH: 184px; height: 34px;" colSpan=1></TD>--%>
    <TD style="WIDTH: 592px; HEIGHT: 34px; TEXT-ALIGN: left" colSpan=2>
        &nbsp;<asp:Label ID="lblsumsrange" runat="server" ForeColor="Red"></asp:Label>
        <asp:Button id="Button1" onclick="Button1_Click" runat="server" Width="82px" Height="30px" Text="发卡"></asp:Button> </TD>
</TR>

<tr>
    <td colspan=5>
        <asp:GridView id="GridView1" runat="server" Width="100%" DataKeyNames="cardid" CaptionAlign=left 
            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" 
            DataSourceID="ObjectDataSource1" AllowPaging="True" PageSize=10 Caption="已拥有卡列表">
            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
            <Columns>
                <asp:BoundField DataField="names" HeaderText="姓名" ReadOnly="True" SortExpression="cardid" />
                <asp:BoundField DataField="cardid" HeaderText="卡号" ReadOnly="True" SortExpression="cardid" />
                <asp:BoundField DataField="cardname" HeaderText="卡名称" SortExpression="cardname" />
                <asp:BoundField DataField="sums" HeaderText="金额" SortExpression="sums" />
                <asp:BoundField DataField="crdate" HeaderText="创建日期" SortExpression="crdate" DataFormatString={0:d} HtmlEncode=false />
                <asp:BoundField DataField="lastdate" HeaderText="lastdate" SortExpression="lastdate" Visible=false />
                <asp:BoundField DataField="username" HeaderText="创建人" SortExpression="crname" />                
                <%--<asp:CheckBoxField DataField="start" HeaderText="是否有效" SortExpression="start" />--%>
                <asp:BoundField DataField="statename" HeaderText="卡状态" SortExpression="start" />
                <asp:BoundField DataField="proposerid" HeaderText="proposerid" SortExpression="proposerid" Visible=false />
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" Visible=false />
                <asp:BoundField DataField="depotid" HeaderText="店铺编号" SortExpression="depotid" />
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
</TBODY></TABLE>
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

