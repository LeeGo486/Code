<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Track_BP_TrackOver, App_Web_bp_trackover.aspx.40cff5d2" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料分配审核</title>
    <base target="_self" />
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
           <script language="javascript" type="text/javascript">
           function GoUrlShowAddTrack(pid) 
           {
		      var url="BP_PublishSuperList.aspx?SupmaterID="+pid
	          LoadWindow(url,860,653);
	       }
	        function bt_return()
     {
        
        window.returnValue="0";
         window.close();
     }
            </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">采购结案</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
   
             <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="结  案" CssClass="btn" OnClick="BtnSubmit_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    <div  class="BContent" style="height:250px">
     <!----contant------------------>
     <table  width="100%" align="center">
       <tr>
        <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label>
        </td>
    </tr>
     <tr>
     <td>
             <table width="100%">
       

            <tr>
            <td align="left">
                物料编号:</td>
            <td align="left">
                <asp:Label ID="LblMater" runat="server" Text=""></asp:Label></td>
           
            <td align="left">
                采 购 员:</td>
            <td align="left">
                <asp:Label ID="LblBuyer" runat="server" Text=""></asp:Label></td>
        </tr>
         <tr>
            <td align="left">
                结 案 人:</td>
            <td align="left">
                <asp:Label ID="LblOverUser" runat="server" Text=""></asp:Label></td>
            
            <td align="left">
                结案时间:</td>
            <td align="left">
                <asp:Label ID="LblOverTime" runat="server" Text=""></asp:Label></td>
        </tr>
       <tr>
            <td align="left">
                综合分数:</td>
            <td align="left">
                <asp:TextBox ID="TxtProStore" runat="server" Width="180px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtProStore"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="REVvs" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtProStore"></asp:RegularExpressionValidator></td>
          
            <td align="left">
                审 &nbsp;&nbsp; 核:</td>
            <td align="left">
                <asp:CheckBox ID="ChkBoxState" runat="server" /></td>
        </tr>
         
         <tr>
             <td align="center" colspan="4">
              
                 </td>
        </tr>
         <tr>
             <td align="center" colspan="4">
                 <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        </table>
    <asp:HiddenField ID="HFSupmaterID" runat="server" />
     </td>
     </tr>
     </table>
    <!----contant end---------------->
    </div>
    </form>
</body>
</html>
