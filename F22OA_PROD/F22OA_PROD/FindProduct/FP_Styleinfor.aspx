<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_Styleinfor, App_Web_fp_styleinfor.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>款式资料明细</title>
     <link  href="../css/project.css" type="text/css"  rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">款式资料明细</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
  
    <div>
    <table width="690px" align="center">
     <tr >
        <td class="ProTitle">&nbsp;</td>
        </tr>
    <tr>
    <td>
        <table width="690">
      
            <tr>
                <td align="left" style="width: 100%" valign="top">
                    <table>
                        <tr>
                            <td align="left" width="50%" height="360">
                                <table   border="0" cellspacing="5" cellpadding="0">
                                <colgroup>
                                <col align="right" />
                                <col />
                                </colgroup>
                                    <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label1" runat="server" Text="款式名称:"></asp:Label>
                                        </td>
                                        <td >
                                            <asp:Label ID="LblName" runat="server"></asp:Label>
                                        </td>
                                      
                                        
                                    </tr >
                                    <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label3" runat="server" Text="款式编号:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblID" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                    <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label7" runat="server" Text="款式年份:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblNian" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                    <tr class="ProTitle">
                                        <td  style="height: 18px">
                                            <asp:Label ID="Label11" runat="server" Text="原    料:"></asp:Label></td>
                                        <td  style="height: 18px">
                                            <asp:Label ID="LblYanliao" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                   <tr class="ProTitle">
                                        <td  style="height: 18px">
                                            <asp:Label ID="Label17" runat="server" Text="款式性别:"></asp:Label></td>
                                        <td  style="height: 18px">
                                            <asp:Label ID="LblSex" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                    <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Lbel9" runat="server" Text="款式季节:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblJin" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                       <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label13" runat="server" Text="款式大类:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblStyleMax" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                          <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label15" runat="server" Text="款式小类:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblStyleMin" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                         <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Lbl21" runat="server" Text="目前库存:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblStore" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                      <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label2" runat="server" Text="最早到货日期:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblGetDate" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                    <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label19" runat="server" Text="零销价格:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblPrice" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                   <tr class="ProTitle">
                                        <td >
                                            <asp:Label ID="Label23" runat="server" Text="计量单位:"></asp:Label></td>
                                        <td >
                                            <asp:Label ID="LblDianwei" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                      
                    </table>
                </td>
                <td width="50%" height="360">
                    <table width="330" border="0" align="center" cellpadding="0" cellspacing="5" style="border:solid 1px #07aba0;">
                    <tr>
                    <td>
                   
                        <a href="#" target="_blank">
                            <asp:Image ID="ImgNew" runat="server" Height="300px" ImageUrl="~/images/nophoto.gif" Width="320px" />
                        </a>
                         </td>
                    </tr>
                    </table>
                </td>
            </tr>
        </table>
    <!--contant--->
    
    <!--contant end-->
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
