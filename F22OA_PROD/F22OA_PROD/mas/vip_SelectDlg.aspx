<%@ page language="C#" autoeventwireup="true" inherits="mas_vip_SelectDlg, App_Web_vip_selectdlg.aspx.e229d74e" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VIP选择</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
   <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
   		<script language="javascript" type="text/javascript" src="../js/select.js"></script>

    <style type="text/css"> 
  .tbRpt {  width:95%; padding:0px; margin:0px;background-color:#F7F7F7;}
  .tbRptLTD { background-color:#ffffff;  white-space:nowrap; text-align:right;  height:20px; padding:0px 0px 0px 10px; margin:0px;}
  .tbRptRTD{  background-color:#ffffff;text-align:left; height:20px; padding:0px 0px 0px 0px; margin:0px;}

    </style>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:100%;text-align:center;"><br /><br />
      <table  class="tbRpt">
      <tr>
          <td class="" align="right"><input id="chkState" type="checkbox" runat="server" /></td><td align="left">按VIP状态</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpState" runat="server">
            <asp:ListItem Text="全部" Value="-1"></asp:ListItem> 
             </asp:DropDownList>          
           </td>
      </tr>
      <tr>
          <td ><input id="chkOccupation" type="checkbox" runat="server" /></td><td align="left">按职业</td>
          <td  class="tbRptRTD"> <asp:DropDownList ID="drpOccupation" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
      <tr>
          <td ><input id="chkCity" type="checkbox" runat="server" /></td><td align="left">按地区</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpCity" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
      <tr>
          <td ><input id="chkDepot" type="checkbox" runat="server" /></td><td align="left">按店铺</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpDepot" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
      <tr>
          <td ><input id="chkSex" type="checkbox" runat="server" /></td><td align="left">按性别</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpSex" runat="server">
           <asp:ListItem Text="全部" Value="-1"></asp:ListItem><asp:ListItem Text="男" Value="0"></asp:ListItem><asp:ListItem Text="女" Value="1"></asp:ListItem>
          </asp:DropDownList>             
          </td>
      </tr>
      <tr>
          <td ><input id="chkCentum" type="checkbox" runat="server" /></td><td align="left">按积分范围</td>
          <td class="tbRptRTD"><asp:TextBox ID="txtCentum1" runat="server"></asp:TextBox><asp:TextBox ID="txtCentum2" runat="server"></asp:TextBox>
          </td>
      </tr>
      <tr>
          <td ><input id="chkInvlid" type="checkbox" runat="server" /></td><td align="left">按失效顾客</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpInvlid" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
      <tr>
          <td ><input id="chkName" type="checkbox" runat="server" /></td><td align="left">按姓名</td>
          <td class="tbRptRTD"><asp:TextBox ID="txtName" runat="server"></asp:TextBox> </td>
      </tr>
      <tr>
          <td ><input id="chkTel" type="checkbox" runat="server" /></td><td align="left">按手机号</td>
          <td class="tbRptRTD"> <asp:TextBox ID="txtTel" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
          <td ><input id="chkBirth" type="checkbox" runat="server" /></td><td align="left">按生日</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpBirth" runat="server">
           <asp:ListItem Text="全部" Value="-1"></asp:ListItem>
           <asp:ListItem Text="一月" Value="1"></asp:ListItem><asp:ListItem Text="二月" Value="2"></asp:ListItem>
           <asp:ListItem Text="三月" Value="3"></asp:ListItem><asp:ListItem Text="四月" Value="4"></asp:ListItem>
           <asp:ListItem Text="五月" Value="5"></asp:ListItem><asp:ListItem Text="六月" Value="6"></asp:ListItem>
           <asp:ListItem Text="七月" Value="7"></asp:ListItem><asp:ListItem Text="八" Value="8"></asp:ListItem>
           <asp:ListItem Text="九月" Value="-1"></asp:ListItem><asp:ListItem Text="十月" Value="10"></asp:ListItem>
           <asp:ListItem Text="十一月" Value="11"></asp:ListItem><asp:ListItem Text="十二月" Value="12"></asp:ListItem>
          </asp:DropDownList>
           </td>
      </tr>
      <tr>
          <td ><input id="chkPeople" type="checkbox" runat="server" /></td><td align="left">按民族</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpPeople" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
       <tr>
          <td ><input id="chkTypeid" type="checkbox" runat="server" /></td><td align="left">按申卡类型</td>
          <td class="tbRptRTD"> <asp:DropDownList ID="drpTypeid" runat="server"><asp:ListItem Text="全部" Value="-1"></asp:ListItem></asp:DropDownList> </td>
      </tr>
     <tr><td colspan="3"></td></tr>
      </table>
      <table width="95%">
            <tr><td align="left">&nbsp;</td>
      <td><asp:Button ID="btnOk" runat="server" Text="确定" OnClick="btnOk_OnClick"  CssClass="btn" /></td>
      <td><input id="btnCancel" type="button" runat="server" value="取消" class="btn" onclick="javascript:window.close();" /></td>
      </tr>

      </table>
    </div>
    </form>
</body>
</html>
