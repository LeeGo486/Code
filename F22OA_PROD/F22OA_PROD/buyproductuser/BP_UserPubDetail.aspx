<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserPubDetail, App_Web_bp_userpubdetail.aspx.4969a439" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购合同模板添加</title>
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能： 信息<span id="rm_MainPanel_lFunctionName">详细内容</span>&nbsp;&nbsp;&nbsp;
					
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
        &nbsp;
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
        
    <div  class="BContent" style="height:100%">
        <asp:HiddenField ID="HFSid" runat="server" />
    <table width="100%">
     <tr>
     <td>
       <h2 align="center"><asp:Label id="LblTitle" runat="server" ForeColor="Blue"></asp:Label></h2>
       </td>
     </tr>
     <tr>
     <td>
     <hr />
     </td>
     </tr>
    <tr>
    <td align="center" valign="top">
   
    <!--the title-->
    <table >
    
    <tr>
    <td>
    发布人:<asp:Label id="LblUUser" runat="server" Text=""></asp:Label>
     发布时间:<asp:Label id="LblCrDate" runat="server" Text=""></asp:Label>
     </td>
    </tr>
    </table>
 </td>
    </tr>
    <tr>
    <td align="left" valign="top">
      <!--the wriehead-->
        &nbsp;<!--the writer head end--></td>
    </tr>
    <tr>
    <td align="left" valign="top">
        </td>
    </tr>
    <tr>
    <td align="left" valign="top">
    <!--the wriehead-->
       <asp:Label id="LblContent" runat="server"   Text=""></asp:Label>
    <!--the writer head end-->
    </td>
    </tr>
    <tr>
    <td align="left" valign="top"></td>
    </tr>
    </table>
    <!--the title end-->
    </div>
    </form>
</body>
</html>


