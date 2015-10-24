<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserContactUs, App_Web_bp_usercontactus.aspx.4969a439" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="css/project.css" type="text/css"  rel="stylesheet">
    		       
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">联系我们</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
   <!--head end-->
   
        
    <div  class="BContent"  style=" height:400px"  >
    <table width="100%" >
    
   <tr> 
   <td align="center"> 
    <table borderColor="#cccccc"  cellSpacing="5" borderColorDark="#ffffff" cellPadding="5" width="100%" align="center" border="1" style="vertical-align:middle; margin-top:50px; margin-left:20px">
	  <colgroup>
	  <col  align="right" />
	  <col style="text-align:left;"/>
	  </colgroup> 
	 <tr>
    <td colspan="2" align="center"><asp:Label id="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
    <tr>
	  <tr>
          <td align="left" colspan="2">
            公司名称:<asp:Label id="LblCompanyName" runat="server" ></asp:Label></td>
    </tr>
    <tr>
        <td align="left" colspan="2">
            联 系 人:<asp:Label id="LblContactUser" runat="server" ></asp:Label></td>
    </tr>
    <tr>
      
    <tr>
        <td align="left" colspan="2" style="height: 26px">
            电 &nbsp; &nbsp;话:<asp:Label id="LblTel" runat="server" ></asp:Label></td>
    </tr>
    <tr>
        <td align="left" colspan="2">
            传 &nbsp; &nbsp;真:<asp:Label id="LblFax" runat="server" ></asp:Label></td>
    </tr>
   
  

      <tr>
          <td align="left" colspan="2">
              电子邮箱:<asp:Label id="LblEmail" runat="server" ></asp:Label></td>
    </tr>
      <tr>
          <td align="left" colspan="2">
              公司地址:<asp:Label id="LblAddress" runat="server" ></asp:Label></td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            &nbsp;
        </td>
    </tr>
    
	  </table>
	  </td>
   <tr>
   
   </tr>
    <tr>
   
   <td align="center">

</td>
   </tr>
 </table>
    </div>
    </form>
</body>
</html>

