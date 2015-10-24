<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_findPublish, App_Web_fp_findpublish.aspx.a918743" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
	
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		<script  type="text/javascript">
function GoUrlVipShop() 
{ 
		var id=	window.document.getElementById("TxtBillNo2").value;
		if (id=="" || id==undefined)
		{
		    window.alert("请先保存主单数据!");
		}
		else
		{
	//var url="/FindProduct/FP_ShowShop.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
	var url="FP_ShowShop.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
	
	//showaspx(url,860,653);
	LoadWindow(url,860,653);
	}
	
	

}
function GoUrlBorthday() 
{ 
				var id=	window.document.getElementById("TxtBillNo2").value;
		if (id=="" || id==undefined)
		{
		    window.alert("请先保存主单数据!");
		}
		else
		{
		          // var url="/FindProduct/FP_ShowStyle.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
		           var url="FP_ShowStyle.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
            	var result=LoadWindow(url,860,653);//showaspx(url,860,653);
	            if (result!="" && result!=undefined)
                 {

                     window.document.getElementById("ctl00$ContentPlaceHolder1$TxtSStyleID").value=result;  
                 }
     }
	

}
function GoUrlShowMode() 
{ 
		
		        //var url="/FindProduct/FP_ShowModel.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
		          var url="FP_ShowModel.aspx?BillCode="+window.document.getElementById("TxtBillNo").value;
	       // var result=showaspx(url,860,653);
        	var result=LoadWindow(url,860,653);
	          if (result!="" && result!=undefined)
                 {     
                    var arvalues=result.split(",");
                    
                    window.document.getElementById("TxtModelName").disabled=false;//=arvalues[1]; 
                     window.document.getElementById("TxtModelCode").value=arvalues[0];
                     window.document.getElementById("TxtModelName").value=arvalues[1];       
                 }
	

}
</script> 
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                    
    <!--head end-->
    <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看未审申请" CssClass="btn"   OnClientClick="window.location.href='FP_FindPublishEidt.aspx'; return false;"   />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="Savedata" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
 
    <div  class="BContent"  style="height:100%">
    <!----contant------------------>
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
        <table  width="100%"  >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
           <tr>
        <td >
            调查主题:</td>
              <td align="left" colspan="4">
                  <asp:TextBox ID="TxtTitle" runat="server" MaxLength="100" Width="90%" CssClass="tbox"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                      ID="RequiredFieldValidator6" runat="server" ControlToValidate="TxtTitle" ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
         <tr>
        <td style="height: 60px" >
            调查目的:</td>
            <td colspan="4" >
                <asp:TextBox ID="TxtCommet" runat="server"   MaxLength="300" TextMode="MultiLine"
                    Width="90%"  CssClass="tbox" Height="40px"></asp:TextBox></td>
        </tr>
              <tr>
        <td >
        单据编号:
        </td>
        <td >
            <asp:TextBox ID="TxtBillNo" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="TxtBillNo"></asp:RequiredFieldValidator></td>
     <td >
        
        </td>
        <td>
            申请起草人:
        </td>
      
          <td >
              <asp:TextBox ID="TxtCrUser" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtCrUser"
                  ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
          
        
          <tr>
        <td >
            调查开始日期:</td>
        <td >
             <igsch:WebDateChooser ID="WebDateChooserDateBegin" runat="server" Value="" Width="203px">
            </igsch:WebDateChooser>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="WebDateChooserDateBegin"
                ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
     <td >
        
        </td>
        <td>
            调查结束日期:
        </td>
      
          <td >
                <igsch:WebDateChooser ID="WebDateChooserDateEnd" runat="server" Value="" Width="203px">
            </igsch:WebDateChooser>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="WebDateChooserDateEnd"
                  ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
              
          
             <tr>
        <td >
            调查内容:</td>
              <td align="left" >
                  <asp:TextBox ID="TxtModelName" runat="server" MaxLength="100" Width="200px" CssClass="tbox" Enabled="False"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                      ID="RequiredFieldValidator7" runat="server" ControlToValidate="TxtModelName"
                      ErrorMessage="*"></asp:RequiredFieldValidator>
                 
            </td>
            <td>
            <asp:TextBox ID="TxtModelCode" runat="server"  CssClass="hidden"></asp:TextBox>
                <asp:Image ID="Image1" runat="server" BorderWidth="0px" ImageUrl="~/icon/go3.gif" /></td>
             <td>    <div id="divq" runat="server" visible="false">
            <a  href="FP_ModelShow.aspx?modelcode=<%=TxtModelCode.Text.ToString() %>">查看调查题目</a>
            </div></td>
             <td>
                  <asp:Button ID="Button1" runat="server" OnClientClick="GoUrlShowMode()"
            Text="选择调查内容"  Width="200px"   CssClass="NormalBtn"    /></td>
             
        </tr>       
  

         <tr>
 
       
     
         <tr>
        <td style="height: 28px" >
            调查店铺:</td>
        <td style="height: 28px;" >

       <asp:Button ID="BtnChoiceShop" runat="server" OnClientClick="GoUrlVipShop()"
            Text="***店铺选择"  Width="200px"   CssClass="NormalBtn"    /></td>
     <td style="height: 28px" >
        
        </td>
        <td style="height: 28px">
            调查款式:</td>
      
          <td style="height: 28px" >
        <asp:Button ID="BtnChoiceStyle" runat="server" OnClientClick="GoUrlBorthday()"
            Text="***款式选择"  Width="200px"   CssClass="NormalBtn"    /></td>
        </tr>
           <tr>
         <td  >
            </td>
            <td colspan="4" >
            (请先保存,再选择店铺及款式)
               </td>
        </tr>
        </table>
            <igsch:WebDateChooser ID="WebDateChooserCrdate" runat="server" Value="" Width="203px" Visible="False">
            </igsch:WebDateChooser>
              <asp:TextBox ID="TxtBillNo2" runat="server" MaxLength="50" Width="200" CssClass="hidden"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="WebDateChooserDateBegin"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
    </tr>
        <tr>
    <td>
    <table width="100%">
    <tr>
    <td style="height: 27px;padding-left:85px" width="50%" >

       </td>
    <td style="height: 27px;padding-left:40px">
        </td>
    </tr>
        <tr>
    <td valign="top">
        <asp:GridView ID="GridViewShop" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SP_ID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SP_ID" HeaderText="编号" InsertVisible="False" ReadOnly="True"  SortExpression="SP_ID"  >
                    <ItemStyle CssClass="hidden" />
                    <HeaderStyle CssClass="hidden" />
                    <FooterStyle CssClass="hidden" />
                </asp:BoundField>
                <asp:BoundField DataField="SP_ShopID" HeaderText="店铺编号" SortExpression="SP_ShopID" />
                <asp:BoundField DataField="SP_ShopName" HeaderText="店铺名称" SortExpression="SP_ShopName" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick="return confirm('确认要删除此数据吗？')" Text="删除"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                     <tr  Class="dgHeader" >
                        <th scope="col">
                            店铺编号</th>
                        <th scope="col">
                            店铺名称</th>
                    </tr>
                      <tr style="color: White; font-weight: bold;" bgcolor="White" height="100">
                        <th scope="col">
                          &nbsp;  </th>
                        <th scope="col">
                            &nbsp;  </th>
 
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header"  />
            <HeaderStyle CssClass="dgHeader"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DC_DelPublishShop" SelectMethod="DC_GetPublishShop" TypeName="ddl_FindProduct">
            <DeleteParameters>
                <asp:Parameter Name="SP_ID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TxtBillNo" Name="SY_BillCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </td>
    <td valign="top">
        <asp:GridView ID="GridViewStyle" runat="server" AllowPaging="True" AllowSorting="True"  CssClass="tbGrid" CellSpacing="1" 
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SY_ID" DataSourceID="ObjectDataSource2"
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SY_ID" HeaderText="编号" InsertVisible="False" ReadOnly="True"
                   ItemStyle-CssClass="hidden"  HeaderStyle-CssClass="hidden"  FooterStyle-CssClass="hidden" SortExpression="SY_ID" />
            
                <asp:BoundField DataField="SY_StyleNo" HeaderText="款式编号" SortExpression="SY_StyleNo" />
                <asp:BoundField DataField="SY_StyleName" HeaderText="款式名称" SortExpression="SY_StyleName" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick="return confirm('确认要删除此数据吗？')" Text="删除"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr Class="dgHeader" >
                        <th scope="col">
                            款式编号</th>
                        <th scope="col">
                            款式名称</th>
 
                    </tr>
                    <tr style="color: White; font-weight: bold;" bgcolor="White" height="100">
                        <th scope="col">
                          &nbsp;  </th>
                        <th scope="col">
                            &nbsp;  </th>
 
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" />
            <HeaderStyle CssClass="dgHeader"/>
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView><asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="DC_DelPublishStyle"  SelectMethod="DC_GetPublishStyle" TypeName="ddl_FindProduct">
            <DeleteParameters>
                <asp:Parameter Name="SY_ID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TxtBillNo" Name="SY_BillCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>
