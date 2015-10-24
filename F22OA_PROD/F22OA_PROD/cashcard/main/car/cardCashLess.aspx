<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardCashLess, App_Web_cardcashless.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<script  type="text/javascript">
    function GoUrlVipShop() 
    {
        var url="SDBuildVipShop.aspx";	    
        var result=window.showModalDialog(url,self,"edge:sunken;scroll:2;status:0;help:0;resizable:1;center:yes;dialogWidth:700px;dialogHeight:400px;");
	    if (result!="" && result!=undefined)
         {     
            var arvalues=result.split(",");
             window.document.getElementById("ctl00_ctplhder_txtDepotid").value=arvalues[0];
             window.document.getElementById("ctl00_ctplhder_TextBox1").value=arvalues[1];       
         }
     }    
</script>
<%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
   <contenttemplate>--%>
&nbsp;<TABLE ><TBODY>
<TR><TD style="WIDTH: 90px"><asp:Label id="Label6" runat="server" Text="卡号："></asp:Label></TD><TD style="WIDTH: 152px; COLOR: #ff3300"><asp:TextBox id="txtcardid" runat="server" Width="130px"></asp:TextBox>*</TD><TD><asp:Label id="Label9" runat="server" Width="76px" Text="充值流水号："></asp:Label></TD><TD style="COLOR: #ff3333"><asp:TextBox id="txtsums" runat="server" Width="70px" OnTextChanged="txtsums_TextChanged"></asp:TextBox>*</TD><TD>
    <asp:Button id="btnSelectdepot" runat="server" Width="75px" Text="选择店铺" BorderStyle="Groove" BorderColor="White" BackColor="#ECF3F6" Visible="False" OnClientClick="GoUrlVipShop()"></asp:Button><asp:RequiredFieldValidator id="RequiredFieldValidator11" runat="server" ControlToValidate="txtDepotid" ErrorMessage="请选择店铺！" Display="Dynamic">请选择店铺！</asp:RequiredFieldValidator>
    <asp:TextBox id="txtDepotid" runat="server" Width="72px" BorderStyle="None" BackColor="#ECF3F6" Font-Underline="True" OnTextChanged="txtDepotid_TextChanged" ForeColor="#ECF3F6"></asp:TextBox><asp:TextBox id="TextBox1" runat="server" Width="123px" BorderStyle="None" BackColor="#ECF3F6" Font-Underline="True" OnTextChanged="TextBox1_TextChanged" ForeColor="#ECF3F6"></asp:TextBox></TD>
<TD>
    </TD><TD></TD></TR><TR><TD style="HEIGHT: 20px" align=center colSpan=2><asp:CustomValidator id="CVtxtcardid" runat="server" Width="50px" Display="Dynamic" ControlToValidate="txtcardid" ErrorMessage="卡号无效" SetFocusOnError="True" OnServerValidate="CVtxtcardid_ServerValidate"></asp:CustomValidator> <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtcardid" ErrorMessage="卡号不能为空"></asp:RequiredFieldValidator> </TD><TD style="HEIGHT: 20px" align=center colSpan=2><asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="txtsums" ErrorMessage="请填写充值流水号！"></asp:RequiredFieldValidator>&nbsp;
    </TD><TD style="HEIGHT: 20px"></TD></TR><TR><TD style="WIDTH: 90px"><asp:Label id="Label11" runat="server" Text="请输入卡密码："></asp:Label></TD><TD style="WIDTH: 152px; COLOR: #ff3333"><asp:TextBox id="txtPassword" runat="server" Width="130px" TextMode="Password">1</asp:TextBox>*</TD><TD><asp:Label id="Label7" runat="server" Text="说明："></asp:Label></TD><TD><asp:TextBox id="txtcomment" runat="server" Width="70px"></asp:TextBox></TD><TD><asp:Button id="Button1" onclick="btnnext_Click" runat="server" Width="54px" Text="查询" Height="24px"></asp:Button></TD></TR>
<TR><TD align=center colSpan=2><asp:CustomValidator id="CVtxtPassword" runat="server" Width="76px" Display="Dynamic" ControlToValidate="txtPassword" ErrorMessage="密码不正确" SetFocusOnError="True" OnServerValidate="CVtxtPassword_ServerValidate"></asp:CustomValidator>&nbsp; <asp:Label id="Label4" runat="server" Width="101px" Text="Label" ForeColor="Red" Visible="False"></asp:Label></TD><TD colSpan=3><asp:RangeValidator id="RangeValidator1" runat="server" Display="Dynamic" ControlToValidate="txtsums" ErrorMessage="金额不正确" Enabled="False" Type="Currency" MinimumValue="1" MaximumValue="10000000"></asp:RangeValidator><asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="txtsums" ErrorMessage="请填写金额" SetFocusOnError="True" Enabled="False"></asp:RequiredFieldValidator></TD></TR>
<tr>
<td colspan=4>
    &nbsp; &nbsp;
</td>
</tr>
</TBODY></TABLE>
<%--</contenttemplate>    
</asp:UpdatePanel>--%>
    &nbsp;
    
<%--<asp:UpdatePanel id="UpdatePanel2"  runat="server">
   <contenttemplate>--%>
<TABLE style="WIDTH: 336px; HEIGHT: 82px"><TBODY><TR><TD style="WIDTH: 22%; HEIGHT: 24px; TEXT-ALIGN: left"><asp:Label id="Label1" runat="server" Width="50px" Text="卡编号："></asp:Label></TD><TD style="WIDTH: 30%; HEIGHT: 24px; TEXT-ALIGN: left"><asp:Label id="lbcardid" runat="server" Width="57px" ForeColor="#0000FF"></asp:Label> </TD><TD style="HEIGHT: 24px; TEXT-ALIGN: left" width="100%"></TD></TR><TR><TD style="WIDTH: 22%; HEIGHT: 22px; TEXT-ALIGN: left"><asp:Label id="Label2" runat="server" Width="51px" Text="客户名："></asp:Label> </TD><TD style="WIDTH: 30%; HEIGHT: 22px; TEXT-ALIGN: left"><asp:Label id="lbname" runat="server" ForeColor="#0000FF"></asp:Label> </TD><TD style="HEIGHT: 22px; TEXT-ALIGN: left" width="100%"></TD></TR><TR><TD style="WIDTH: 22%; HEIGHT: 27px; TEXT-ALIGN: left"><asp:Label id="Label5" runat="server" Width="72px" Text="充值流水号："></asp:Label> </TD><TD style="WIDTH: 30%; HEIGHT: 27px; TEXT-ALIGN: left"><asp:Label id="lbllsh" runat="server" ForeColor="Blue"></asp:Label></TD><TD style="HEIGHT: 27px; TEXT-ALIGN: left" width="100%"><asp:Label id="lbrate" runat="server" Width="58px" Visible="False" ForeColor="Blue"></asp:Label></TD></TR><TR><TD style="WIDTH: 22%; HEIGHT: 23px; TEXT-ALIGN: left"><asp:Label id="Label3" runat="server" Width="90px" Text="反充金额(元)："></asp:Label> </TD><TD style="WIDTH: 30%; HEIGHT: 23px; TEXT-ALIGN: left"><asp:Label id="lbsums" runat="server" Width="58px" ForeColor="#0000FF"></asp:Label> </TD><TD style="HEIGHT: 23px; TEXT-ALIGN: left" width="100%"></TD></TR><TR><TD>当前卡金额：</TD><TD><asp:Label id="lblcardsums" runat="server" ForeColor="Blue"></asp:Label></TD><TD></TD></TR><TR><TD colSpan=3><asp:Label id="lblmessage" runat="server" ForeColor="Red"></asp:Label></TD></TR><TR><TD colSpan=3><asp:Button id="btnnex2" onclick="btnnex2_Click" runat="server" Width="114px" Text="确定反充值" Height="35px"></asp:Button> </TD></TR></TBODY></TABLE>
<%--</contenttemplate>
</asp:UpdatePanel>--%>
    &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp;
    &nbsp;&nbsp;&nbsp;<br />

</asp:Content>

