<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSignModelDetail, App_Web_bp_bssignmodeldetail.aspx.11713791" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购合同模板添加</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">采购合同模板详细</span>&nbsp;&nbsp;&nbsp;
					
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
     <td align="center"> </td>
     </tr>
    <tr>
    <td align="left" valign="top">
   
    <!--the title-->
    <table width="100%">
     <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
    
    <tr>
    <td>
        模板编号:</td>
    <td>
    <asp:Label id="LblModelNo" runat="server" Text=""></asp:Label>
    </td>
    <td></td>
    <td>
        模板名称:</td>
    <td>
    <asp:Label id="LblModelName" runat="server" Text=""></asp:Label>
    </td>
    </tr>
    <tr>
    <td>
        备 &nbsp;&nbsp; 注:</td>
        <td colspan="4">
        <asp:Label id="LblCommet" runat="server" Text=""></asp:Label>&nbsp;
        </td>
    </tr>
    <tr>
    <td></td>
    <td colspan="4">
    </td>
    </tr>
    </table>
        模板头部:</td>
    </tr>
    <tr>
    <td align="left" valign="top">
      <!--the wriehead-->
       <asp:Label id="Lblheader" runat="server" Text=""></asp:Label>
    <!--the writer head end-->
    </td>
    </tr>
    <tr>
    <td align="left" valign="top">
        模板底部:</td>
    </tr>
    <tr>
    <td align="left" valign="top">
    <!--the wriehead-->
       <asp:Label id="Lblfoot" runat="server"   Text=""></asp:Label>
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

