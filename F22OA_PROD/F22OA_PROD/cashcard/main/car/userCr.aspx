<%@ page language="C#" masterpagefile="carmaster.master" autoeventwireup="true" inherits="userCr, App_Web_usercr.aspx.f3086b61" title="Untitled Page" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%--<%@ Register Src="usercontrol/userinfo.ascx" TagName="userinfo" TagPrefix="uc1" %>--%>
<asp:Content  ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
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
<%--<uc1:userinfo id="Userinfo1" runat="server" Visible=false></uc1:userinfo>--%>     
&nbsp;

    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<table  border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc" bordercolordark="#ffffff" align=center width=99%>
    <tr>
        <td align=right>登记店铺：</td>
        <td>
    <asp:Button id="btnSelectdepot" runat="server"  Text="选择店铺" OnClientClick="GoUrlVipShop()" Visible="False" BackColor="#ECF3F6" BorderColor="White" BorderStyle="Groove"></asp:Button><asp:Label id="lbdepotid" runat="server"  ForeColor="#FF3333"></asp:Label><asp:Label id="lbdepotname" runat="server"  ForeColor="#FF3333"></asp:Label>
            <asp:RequiredFieldValidator id="RequiredFieldValidator11" runat="server"  ErrorMessage="请选择店铺！" ControlToValidate="txtDepotid">请选择店铺！</asp:RequiredFieldValidator><asp:TextBox id="txtDepotid" runat="server" Width="72px"  ForeColor="#ECF3F6" BackColor="#ECF3F6" BorderStyle="None" OnTextChanged="txtDepotid_TextChanged" Font-Underline="True"></asp:TextBox><asp:TextBox id="TextBox1" runat="server" Width="123px" ForeColor="#ECF3F6" BackColor="#ECF3F6" BorderStyle="None" OnTextChanged="TextBox1_TextChanged" Font-Underline="True"></asp:TextBox></td>
    </tr>
    <tr>
        <td></td>
        <td>
        </td>
    </tr>
  <tr>
    <td  align=right>姓名：</td>
    <td style="color: #ff3333;">
        <asp:TextBox ID="txtname" runat="server" MaxLength="50" Width="400px" AutoPostBack="True" OnTextChanged="txtname_TextChanged" ></asp:TextBox>(必填)
        <asp:RequiredFieldValidator ID="RFVname" runat="server" ControlToValidate="txtname"
            ErrorMessage="请填写姓名" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:CustomValidator ID="csVduser" runat="server" ControlToValidate="txtidcard" ErrorMessage="用户名已经存在"
            OnServerValidate="csVduser_ServerValidate" Display="Dynamic"></asp:CustomValidator>
        <asp:Label ID="lblname" runat="server" ForeColor="Blue"></asp:Label></td>
  </tr>
  <tr>
    <td align=right> 性别：</td>
    <td >
        <asp:RadioButton ID="rbsexm" runat="server" Checked="True" Text="男" GroupName="rbsex" />
        <asp:RadioButton ID="rbsexw" runat="server" Text="女" GroupName="rbsex" /></td>
  </tr>
  <tr>
    <td  align=right>证件号：</td>
    <td style="color: #ff0000;"><asp:TextBox ID="txtidcard" runat="server" MaxLength="50" Width="400px"></asp:TextBox>(必填)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtidcard"
            ErrorMessage="请填写证件号" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td   align=right>固定电话：</td>
    <td style="color: #ff0000;"><asp:TextBox ID="txttel" runat="server" MaxLength="50" Width="400px"></asp:TextBox>(必填)
        <asp:RequiredFieldValidator ID="RFVtel" runat="server" ControlToValidate="txttel"
            ErrorMessage="请填写固定电话" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txttel"
            ErrorMessage="*只能数字" ValidationExpression="^([0-9]|-)*$"></asp:RegularExpressionValidator></td>
  </tr>
  <tr>
    <td  align=right style="height: 30px">联系地址：</td>
    <td style="color: #ff3333; height: 30px;">
        <asp:TextBox ID="txtaddr" runat="server" MaxLength="50" Width="400px"></asp:TextBox>(必填) 
        <asp:RequiredFieldValidator ID="RFVaddr" runat="server" ControlToValidate="txtaddr"
            ErrorMessage="请填写联系地址" SetFocusOnError="True" Display="Dynamic">*</asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td  align=right style="height: 30px">&nbsp;移动电话：</td>
    <td style=" color: #ff3333; height: 30px;"><asp:TextBox ID="txtmtel" runat="server"  MaxLength="50" Width="400px"></asp:TextBox>(必填)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtmtel"
            ErrorMessage="请填写移动电话" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtmtel"
            ErrorMessage="*只能数字" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator></td>
  </tr>
  <tr>
    <td><asp:Label ID="Label10" runat="server" Text="密码电话：" Visible=false></asp:Label></td>
    <td>
        <asp:TextBox ID="txtpswtel" runat="server" MaxLength="50" Visible=false Width="400px"></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td  align=right>备注：</td>
    <td ><asp:TextBox ID="txtcomment1" runat="server" MaxLength="50" Width="400px"></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td  align=right>推荐人：</td>
    <td ><asp:TextBox ID="txtpresenter" runat="server" MaxLength="50" Width="400px"></asp:TextBox></td>
  </tr>
  <tr>
    <td  align=right>卡号：</td>
    <td>
        <asp:TextBox id="txtcardid" runat="server"  MaxLength="50" Width="400px" AutoPostBack="true" OnTextChanged="txtcardid_TextChanged"></asp:TextBox> <FONT style="COLOR: red">
            (必填)</FONT> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"  ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid">*</asp:RequiredFieldValidator> 
        <asp:CustomValidator id="CustomValidator6" runat="server"  ErrorMessage="卡号无效" ControlToValidate="txtcardid" OnServerValidate="CustomValidator6_ServerValidate" Display="Dynamic"></asp:CustomValidator> 
        <asp:RadioButton ID="rbsingle" runat="server" Checked="True" GroupName="rbsendcard"
            Text="单张" AutoPostBack="True" OnCheckedChanged="rbsingle_CheckedChanged" />
        <asp:RadioButton ID="rbmulti" runat="server" GroupName="rbsendcard" Text="多张" AutoPostBack="True" OnCheckedChanged="rbmulti_CheckedChanged" /></td>
  </tr>
  <tr>
    <td  align=right>金额：</td>
    <td>
        <asp:TextBox id="txtsums" runat="server"  OnTextChanged="txtsums_TextChanged" MaxLength="50" Width="400px"></asp:TextBox> 
        <FONT style="COLOR: red">(必填)</FONT> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"  ErrorMessage="RequiredFieldValidator" ControlToValidate="txtsums" Display="Dynamic">*</asp:RequiredFieldValidator> 
        <asp:RangeValidator id="RangeValidator1" runat="server"  ErrorMessage="金额不正确" ControlToValidate="txtsums" Display="Dynamic" MinimumValue="1" MaximumValue="1000000" Type="Currency"></asp:RangeValidator> 
    </td>
  </tr> 
  <asp:Panel ID=plmul runat=server Visible=false>
    <tr>    
    <td colspan=2>        
        <table border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc" bordercolordark="#ffffff" align=center width=100%>
            <TR>
                <TD align=right>
                    <asp:CheckBox ID="ckb1" runat="server" Text=" " OnCheckedChanged="ckb1_CheckedChanged" AutoPostBack=true  />卡号1：</TD>
                <TD >
                    <asp:TextBox id="txtcardid1" runat="server" MaxLength="50"  AutoPostBack="true" OnTextChanged="txtcardid1_TextChanged" ></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid1" Display="Dynamic">*</asp:RequiredFieldValidator> 
                    <asp:CustomValidator id="CustomValidator1" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid1" OnServerValidate="CustomValidator1_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                </TD>
                <TD  align=right>
                    充值金额1：</TD>
                <TD  colSpan=2>
                    <asp:TextBox id="txtsums1" runat="server" MaxLength="10"></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="txtsums1" SetFocusOnError="True" Display="Dynamic" ></asp:RequiredFieldValidator> 
                    <asp:RangeValidator id="RangeValidator2" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums1"  SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency" Display="Dynamic"></asp:RangeValidator>
                </TD>
            </TR>
            <TR>
                <TD  align=right>
                    <asp:CheckBox ID="ckb2" runat="server" Text=" "  AutoPostBack=true OnCheckedChanged="ckb2_CheckedChanged" />卡号2：</TD>
                <TD >
                    <asp:TextBox id="txtcardid2" runat="server" MaxLength="50" Enabled="False"  AutoPostBack="true" OnTextChanged="txtcardid2_TextChanged"></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator9" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid2"  Enabled=false Display="Dynamic">*</asp:RequiredFieldValidator> 
                    <asp:CustomValidator id="CustomValidator2" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid2" OnServerValidate="CustomValidator2_ServerValidate"  Enabled=false Display="Dynamic"></asp:CustomValidator>
                </TD>
                <TD align=right>
                    充值金额2：</TD>
                <TD style="TEXT-ALIGN: left" colSpan=2>
                    <asp:TextBox id="txtsums2" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="txtsums2" SetFocusOnError="True"  Enabled=false Display="Dynamic"></asp:RequiredFieldValidator> 
                    <asp:RangeValidator id="RangeValidator3" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums2" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false Display="Dynamic"></asp:RangeValidator>
                </TD>
            </TR>
            <TR>
                <TD align=right>
                    <asp:CheckBox ID="ckb3" runat="server" Text=" " AutoPostBack=true OnCheckedChanged="ckb3_CheckedChanged" />卡号3：</TD>
                <TD>
                    <asp:TextBox id="txtcardid3" runat="server" MaxLength="50"  Enabled=false  AutoPostBack="true" OnTextChanged="txtcardid3_TextChanged"></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator12" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid3"  Enabled=false Display="Dynamic">*</asp:RequiredFieldValidator> 
                    <asp:CustomValidator id="CustomValidator3" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid3" OnServerValidate="CustomValidator3_ServerValidate"  Enabled=false Display="Dynamic"></asp:CustomValidator>
                </TD>
                <TD  align=right>
                    充值金额3：</TD>
                <TD style=" TEXT-ALIGN: left" colSpan=2>
                    <asp:TextBox id="txtsums3" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator13" runat="server" ErrorMessage="*" ControlToValidate="txtsums3" SetFocusOnError="True"  Enabled=false Display="Dynamic"></asp:RequiredFieldValidator> 
                    <asp:RangeValidator id="RangeValidator4" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums3" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false Display="Dynamic"></asp:RangeValidator>
                </TD>
            </TR>
            <TR>
                <TD  align=right>
                    <asp:CheckBox ID="ckb4" runat="server" Text=" " AutoPostBack=true OnCheckedChanged="ckb4_CheckedChanged" />卡号4：</TD>
                <TD>
                    <asp:TextBox id="txtcardid4" runat="server" MaxLength="50"  Enabled=false  AutoPostBack="true" OnTextChanged="txtcardid4_TextChanged"></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator14" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtcardid4"  Enabled=false Display="Dynamic">*</asp:RequiredFieldValidator> 
                    <asp:CustomValidator id="CustomValidator4" runat="server" ErrorMessage="卡号无效" ControlToValidate="txtcardid4" OnServerValidate="CustomValidator4_ServerValidate"  Enabled=false Display="Dynamic"></asp:CustomValidator>
                </TD>
                <TD  align=right>
                    充值金额4：</TD>
                <TD style="TEXT-ALIGN: left" colSpan=2>
                    <asp:TextBox id="txtsums4" runat="server" MaxLength="10"  Enabled=false></asp:TextBox> 
                    <asp:RequiredFieldValidator id="RequiredFieldValidator15" runat="server" ErrorMessage="*" ControlToValidate="txtsums4" SetFocusOnError="True"  Enabled=false Display="Dynamic"></asp:RequiredFieldValidator> 
                    <asp:RangeValidator id="RangeValidator5" runat="server" ErrorMessage="金额不正确" ControlToValidate="txtsums4" SetFocusOnError="True" MaximumValue="10000000" MinimumValue="1" Type="Currency"  Enabled=false Display="Dynamic"></asp:RangeValidator>
                </TD>
            </TR>
        </table>
  </asp:Panel>
  <tr>
    <td colspan=2 align=center style="height: 22px"><asp:Label id="lblsumsrange" runat="server"  ForeColor="Red"></asp:Label></td>
  </tr>
  <tr>
    <td  align=right style="height: 45px">
    <asp:CheckBox id="ckbpwd" runat="server"  Text="输入卡密码：" AutoPostBack="True" Checked="true" OnCheckedChanged="ckbpwd_CheckedChanged"></asp:CheckBox></td>
    <td style="color: #ff0000; height: 45px;">
        <asp:TextBox id="txtcardpwd" runat="server" Width="400px"  Height="16px" TextMode="Password" MaxLength="6"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server"  ErrorMessage="*" ControlToValidate="txtcardpwd" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:Label ID="lblpwdmessage" runat="server" Text="(输入六位卡密码(只能是数字))"></asp:Label>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtcardpwd"
            ErrorMessage="*请输入数字" ForeColor="Blue" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator></td>
  </tr>
  <tr>
    <td  align=right>再输入卡密码：</td>
    <td>
        <asp:TextBox id="txtcardpwdre" runat="server" Width="400px"  Height="16px" TextMode="Password" MaxLength="6"></asp:TextBox> 
        <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server"  ErrorMessage="请再输入一次！" ControlToValidate="txtcardpwdre" Enabled="False"></asp:RequiredFieldValidator> 
        <asp:CompareValidator id="CompareValidator1" runat="server"  ErrorMessage="两次输入卡密码不一致！" ControlToValidate="txtcardpwdre" Display="Dynamic" ControlToCompare="txtcardpwd"></asp:CompareValidator>
    </td>
  </tr>
  <tr>
    <td colspan=2 align=center><asp:Button id="btnreg" onclick="btnreg_Click" runat="server" Width="89px" Text="注册" Height="26px"></asp:Button></td>
  </tr>
  <tr>
    <td colspan=2 align=center><SPAN style="COLOR: blue">说明：申请到卡后要立即消费，则选中'输入卡密码'让客户输入卡的密码。</SPAN></td>
  </tr>
</table>

<cr:crystalreportviewer id="CrystalReportViewer1" runat="server" autodatabind="true"></cr:crystalreportviewer>
</contenttemplate>
    </asp:UpdatePanel>    
<br />        
</asp:Content>

