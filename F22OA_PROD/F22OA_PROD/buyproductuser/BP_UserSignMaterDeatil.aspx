<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_SignMaterDeatil, App_Web_bp_usersignmaterdeatil.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布物料</title>
    <base target="_self" />
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
   

</head>
<body  topmargin="100" leftmargin="100">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">物料明细</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    
           
    <div class="BContent"  style="height:100%; padding-left:50px; padding-right:50px; padding-top:5px" >
     <!----contant------------------>
    <table width="100%">
   
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label>
                 <asp:HiddenField ID="HFPublishCode" runat="server" />
          <asp:HiddenField ID="HFMaterID" runat="server" />
        &nbsp;
                </td>
    </tr>
    <tr>
    <td align="left">
        <table  width="100%"  >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150"  />
                <col   width="10" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          
          <tr>
             <tr>
        <td  >
            物料编号:</td>
              <td align="left" >
                  <asp:Label ID="LblMaterNo" runat="server" Text=""></asp:Label>
                  </td>
            <td style="width: 10px">
            </td>
                 <td colspan="2" rowspan="13">
                         
           
            <asp:Image  ID="ImgNew" ImageUrl="images/nophoto.gif" runat="server"  Height="150px" Width="170px" /></td>
             
        </tr>  
        <tr>
        <td>
           物料名称:</td>
        <td>
                  <asp:Label ID="LblMaterUName" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px"></td>
        </tr>
          <tr>
        <td>
            规 &nbsp; &nbsp;格:</td>
        <td>
            <asp:Label ID="LblModelName" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px"></td>
        </tr>
        <tr>
        <td >
            颜 &nbsp; &nbsp;色:</td>
        <td >
              <asp:Label ID="LblColorName" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px" ></td>
        </tr>
         <tr>
        <td >
            成 &nbsp; &nbsp;份:</td>
        <td >
              <asp:Label ID="LblComposition" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px" ></td>
        </tr>
        
         <tr>
        <td >
            单 &nbsp; &nbsp;位:</td>
        <td >
            <asp:Label ID="LblUnit" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px" ></td>
        </tr>
                     <tr>
        <td  >
            采购数量:</td>
              <td align="left" >
         
            <asp:Label ID="LblBuyNum" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                         <tr>
        <td  >
            采购单价:</td>
              <td align="left" >
         
            <asp:Label ID="LblPrice" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                         <tr>
        <td  >
            税率:</td>
              <td align="left" >
         
            <asp:Label ID="LblTax" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                 <tr>
        <td  >
            采购时间:</td>
              <td align="left" >
         
            <asp:Label ID="LblMatergetdate" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            到货时间:</td>
              <td align="left" >

            <asp:Label ID="LblBuydate" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            报价编号:</td>
              <td align="left" >

            <asp:Label
                  ID="LblSupMoneyID" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
          <tr>
        <td  >
            发布编号:</td>
              <td align="left" >

            <asp:Label
                  ID="LblPublishID" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
       
           <tr>
        <td style="height: 16px; width: 50px;" >
            描&nbsp;&nbsp;&nbsp;&nbsp;述:</td>
        <td style="height: 16px" colspan="4" >
            <asp:Label ID="LblCommet" runat="server" Text=""></asp:Label>&nbsp;</td>
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


