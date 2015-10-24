<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Repair.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.Repair" %>
<%@ Import Namespace="System.Data"%> 
<%@ Register src="../../Controls/PageNavigator.ascx" tagname="PageNavigator" tagprefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>自助维修平台</title>
    <link  href="../../Styles/css.css" rel="Stylesheet" type="text/css"/>
    <link  href="../../Styles/style.css" rel="Stylesheet" type="text/css"/>
    <style type="text/css">a{TEXT-DECORATION:none}</style>
    <script src="../../Scripts/public.js" type="text/javascript"></script>
</head>
<body>
<center>
    <form id="form1" runat="server" >
    <table class="table" border="0"  cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
    <tr>
        <td>
   <table width="100%" >
     <tr align="left">
            <td>
            <asp:Button id="baoxiu" runat="server" onclick="bx" Text="报    修" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="报修"/>&nbsp;&nbsp;
      <asp:Button  id="gz" runat="server" Text="维修任务"  OnClick="work" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="维修任务"/>&nbsp;&nbsp;
    <asp:Button  id="repair" runat="server" Text="维修员"  OnClick="rep" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="维修员"/>&nbsp;&nbsp;
        <asp:Button  id="wjs" runat="server" Text="未接受"  OnClick="nojs" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="未接受"/>&nbsp;&nbsp;
          <asp:Button  id="yjs" runat="server" Text="已接受"  OnClick="yesjs" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="已接受"/>&nbsp;&nbsp;
  <asp:Button  id="ywc" runat="server" Text="已完成"  OnClick="isfinish" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="已完成"/>&nbsp;&nbsp;
    <asp:Button id="mulu" runat="server" visible="false" Text="目录管理" OnClick="ml" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="目录管理"/>&nbsp;&nbsp;
  <asp:Button  id="renyuan" runat="server" Text="人员管理" visible="false" OnClick="ry" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="人员管理"/>

  </td>
  <td><a href="../../logout.aspx">注销</a></td>
        </tr>
    </table>
    <asp:Repeater ID="show" runat="server">
        <HeaderTemplate>
            <table   width="100%"  bgcolor="#FFFFFF"  style="background:#E4F3FC" class="table" border="0"  cellpadding="1" cellspacing="1" >
                <tr class="TR_BG">
                    <td align='center' valign='middle' class='sysmain_navi' style="width:30px">编号</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:60px">维修类别</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:50px">申请人</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:50px">维修人</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:180px">申请时间</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:180px">接受时间</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:180px">完成时间</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:50px">时限</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:200px">申请描述</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:200px">完成描述</td>
                    <td align='center' valign='middle' class='sysmain_navi' style="width:60px">操作<!--<input type="checkbox" value="-222" onclick="selectAll(this.form,this.checked);" />--></td>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
                <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'> 
                    <td align='center' valign='middle' class='sysmain_navi' width='30px'>
                        <%#((DataRowView)Container.DataItem)["ids"] %>
                    </td>               
                    <td align='center' valign='middle' class='sysmain_navi' width='60px'>
                        <%#((DataRowView)Container.DataItem)["ClassName"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='50px'>
                        <%#((DataRowView)Container.DataItem)["ApplyName"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='50px'>
                        <%#((DataRowView)Container.DataItem)["RepairName"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='180px'>
                        <%#((DataRowView)Container.DataItem)["UpTime"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='180px'>
                        <%#((DataRowView)Container.DataItem)["DoTime"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='180px'>
                        <%#((DataRowView)Container.DataItem)["OverTime"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='50px'>
                        <%#((DataRowView)Container.DataItem)["Times"] %>天
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='200px'>
                        <%#((DataRowView)Container.DataItem)["StartComment"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='200px'>
                        <%#((DataRowView)Container.DataItem)["OverComment"] %>
                    </td>
                    <td align='center' valign='middle' class='sysmain_navi' width='60px'>
                        <%#((DataRowView)Container.DataItem)["op"] %>
                    </td>
                </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>

      <span style='margin-right:5px'>
 每页显示条数
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
         onselectedindexchanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>10</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>20</asp:ListItem>
        <asp:ListItem>25</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
        <asp:ListItem>50</asp:ListItem>
        <asp:ListItem>100</asp:ListItem>
        <asp:ListItem>200</asp:ListItem>
    </asp:DropDownList>
    <uc2:PageNavigator ID="PageNavigator1" runat="server" />
</span>
    &nbsp;</td>
    </tr>
    </table>
    </form>
    </center>
</body>
</html>
