<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_dlgDepot, App_Web_mat_dlgdepot.aspx.e229d74d" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet"/>
</head>
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <div>
       <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <table  width="100%">
    <tr>   
        <td align="left">  
                &nbsp;删选条件：&nbsp;&nbsp;
              <asp:DropDownList ID="drps" runat="server"> 
              <asp:ListItem Text="无" Value="-1" Selected="True"></asp:ListItem> 
             <asp:ListItem Text="按编号" Value="0"></asp:ListItem> 
             <asp:ListItem Text="按店名称" Value="1" ></asp:ListItem>
              <asp:ListItem Text="地区编号" Value="2" ></asp:ListItem> 
              <asp:ListItem Text="地区名称" Value="3" ></asp:ListItem> 
              <asp:ListItem Text="助记码" Value="4"></asp:ListItem>
             </asp:DropDownList>
             &nbsp;<input id="txtCondition" runat="server"  />
         </td>
         <td>
          <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查 询" CssClass="btn" OnClick="BtnSearch_onclick" />           
        </td>
        
        </tr>
        </table>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
     <table width="100%"><tr><td align="center">
         <asp:Panel ID="Panel1" runat="server" Width="95%" Height="420" ScrollBars="Vertical" >
         
     <asp:GridView ID="gv" runat="server" AllowPaging="false" AllowSorting="True" DataKeyNames="depotid"
          AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
          ForeColor="#333333" GridLines="None" Width="100%" PageSize="15" 
          onpageindexchanged="gv_PageIndexChanged" onrowcommand="gv_RowCommand" 
                        onrowcreated="gv_RowCreated" onrowdeleted="gv_RowDeleted" 
          onrowdeleting="gv_RowDeleting" onpageindexchanging="gv_PageIndexChanging" 
               onrowdatabound="gv_RowDataBound">
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <Columns > 
              <asp:BoundField DataField="depotid" HeaderText="店铺编号"  />               
              <asp:BoundField DataField="d_name" HeaderText="店铺名称"  />  
              <asp:BoundField DataField="dpthelp" HeaderText="助记码"  />  
              <asp:BoundField HeaderText="地区编号" DataField="areaid" />  
              <asp:BoundField DataField="shutname" HeaderText="地区名称"  />   
              <asp:BoundField DataField="dptname" HeaderText="类别名称" />
          </Columns>
          <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
         <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
           <EmptyDataTemplate>
          <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
	    <tr class="header" >
		<th scope="col"><a href="#">店铺编号</a></th>
		<th scope="col"><a href="#" >店铺名称</a></th>
		<th scope="col"><a href="#" >地区编号</a></th>	
		<th scope="col"><a href="#" >地区名称</a></th>	
		<th scope="col"><a href="#" >类别名称</a></th>
	  </tr>
      </table>
          </EmptyDataTemplate>
          <EditRowStyle BackColor="#2461BF" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <PagerStyle CssClass="header"  HorizontalAlign="Left" />
          <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
          <AlternatingRowStyle BackColor="White" />
      </asp:GridView>
      </asp:Panel>
      </td></tr></table>
       </ContentTemplate>
     <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSearch" /></Triggers> 
    </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
