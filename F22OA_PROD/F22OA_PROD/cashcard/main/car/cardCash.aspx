<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardCash, App_Web_cardcash.aspx.f3086b61" title="Untitled Page" %>
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
<BR /><TABLE style="WIDTH: 600px"><TBODY><TR><TD style="WIDTH: 204px"><asp:Label id="Label6" runat="server" Width="38px" Text="卡号："></asp:Label></TD><TD style="WIDTH: 157px"><asp:TextBox id="txtcardid" runat="server" Width="118px"></asp:TextBox></TD><TD><asp:Label id="Label9" runat="server" Width="60px" Text="实充金额："></asp:Label></TD><TD style="WIDTH: 46px"><asp:TextBox id="txtsums" runat="server" Width="118px"></asp:TextBox></TD><TD style="WIDTH: 86px; TEXT-ALIGN: right"></TD><TD style="WIDTH: 154px">&nbsp; </TD><TD style="WIDTH: 179px; TEXT-ALIGN: left" vAlign=middle align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TD></TR></TBODY></TABLE>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator> <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="卡号不能为空" ControlToValidate="txtcardid"></asp:RequiredFieldValidator>&nbsp; <asp:RangeValidator id="RangeValidator1" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums" Type="Double" MinimumValue="1" MaximumValue="10000000"></asp:RangeValidator> <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="请填写金额" ControlToValidate="txtsums" SetFocusOnError="True"></asp:RequiredFieldValidator>&nbsp; <TABLE><TBODY><TR><TD>&nbsp;<asp:Label id="Label7" runat="server" Width="42px" Text="说明："></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox id="txtcomment" runat="server" Width="118px"></asp:TextBox>&nbsp;&nbsp;&nbsp; <asp:Button id="btnSelectdepot" runat="server" Width="75px" Text="选择店铺" OnClientClick="GoUrlVipShop()" Visible="False" BackColor="#ECF3F6" BorderColor="White" BorderStyle="Groove"></asp:Button><asp:RequiredFieldValidator id="RequiredFieldValidator11" runat="server" ErrorMessage="请选择店铺！" ControlToValidate="txtDepotid" Display="Dynamic">请选择店铺！</asp:RequiredFieldValidator>&nbsp; <asp:TextBox id="txtDepotid" runat="server" Width="72px" ForeColor="#ECF3F6" BackColor="#ECF3F6" BorderStyle="None" OnTextChanged="txtDepotid_TextChanged" Font-Underline="True"></asp:TextBox><asp:TextBox id="TextBox1" runat="server" Width="123px" ForeColor="#ECF3F6" BackColor="#ECF3F6" BorderStyle="None" OnTextChanged="TextBox1_TextChanged" Font-Underline="True"></asp:TextBox> <asp:Button id="btnnext" onclick="btnnext_Click" runat="server" Width="54px" Text="查询"></asp:Button> </TD></TR></TBODY></TABLE>
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
   <%-- <asp:UpdatePanel id="UpdatePanel2" runat="server">
        <contenttemplate>--%>
<TABLE style="WIDTH: 509px"><TBODY><TR><TD style="WIDTH: 179px; HEIGHT: 134px; TEXT-ALIGN: center"><TABLE style="HEIGHT: 82px" width=500><TBODY><TR><TD style="WIDTH: 20%; TEXT-ALIGN: left"><asp:Label id="Label1" runat="server" Width="50px" Text="卡编号："></asp:Label></TD><TD style="TEXT-ALIGN: left" width="100%"><asp:Label id="lbcardid" runat="server" Width="57px" ForeColor="#FF0000"></asp:Label> </TD></TR><TR><TD style="WIDTH: 20%; HEIGHT: 20px; TEXT-ALIGN: left"><asp:Label id="Label2" runat="server" Width="51px" Text="客户名："></asp:Label></TD><TD style="HEIGHT: 20px; TEXT-ALIGN: left" width="100%"><asp:Label id="lbname" runat="server" ForeColor="#FF0000"></asp:Label></TD></TR><TR><TD style="WIDTH: 20%; HEIGHT: 28px; TEXT-ALIGN: left"><asp:Label id="Label8" runat="server" Text="当前金额："></asp:Label></TD><TD style="HEIGHT: 28px; TEXT-ALIGN: left" width="100%"><asp:Label id="lbsumold" runat="server" ForeColor="#FF3333"></asp:Label></TD></TR><TR><TD style="WIDTH: 20%; HEIGHT: 28px; TEXT-ALIGN: left"><asp:Label id="Label3" runat="server" Width="81px" Text="实充金额(元)："></asp:Label></TD><TD style="HEIGHT: 28px; TEXT-ALIGN: left" width="100%"><asp:Label id="lbsums" runat="server" Width="58px" ForeColor="#FF0000"></asp:Label></TD></TR>
<TR>
    <TD style="WIDTH: 20%; HEIGHT: 19px; TEXT-ALIGN: left"><asp:Label id="Label4" runat="server" Width="84px" Text="奖励比例(% )："></asp:Label>
    </TD>
    <TD style="HEIGHT: 19px; TEXT-ALIGN: left" width="100%"><asp:Label id="lbrate" runat="server" Width="44px" ForeColor="#FF0000"></asp:Label>
    </TD>
</TR>
<tr>
    <td align=left>奖励金额：</td>
    <td align=left>
        <asp:Label ID="lbljlje" runat="server" ForeColor="Red"></asp:Label>
    </td>
</tr>
<TR><TD style="WIDTH: 20%; TEXT-ALIGN: left"><asp:Label id="Label5" runat="server" Text="充值合计(元)："></asp:Label></TD><TD style="TEXT-ALIGN: left" width="100%">&nbsp;<asp:Label id="lbsum" runat="server" ForeColor="#FF0000"></asp:Label></TD></TR><TR><TD style="HEIGHT: 21px" align=left><asp:Label id="Label10" runat="server" Text="卡状态："></asp:Label></TD><TD style="HEIGHT: 21px" align=left><asp:Label id="lblcardstate" runat="server" Text="" ForeColor="Red"></asp:Label> </TD></TR><TR><TD colSpan=2><asp:Label id="lblmessage" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label></TD></TR><TR><TD></TD><TD></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><asp:Button id="btnnex2" onclick="btnnex2_Click" runat="server" Width="114px" Text="确定充值" Height="35px"></asp:Button>&nbsp; 
<%--</contenttemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

