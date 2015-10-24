<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_chkprice_BP_ChkGiveMaterNum, App_Web_bp_chkgivematernum.aspx.68adc8a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布物料</title>
    <base target="_self" />
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script type="text/javascript">
     function bt_close_onclick()
 {
     //window.dialogArguments.location=window.dialogArguments.location;
       window.close();
  
 }
 function bt_return()
     {
        
       
        //var values=window.document.getElementById("HFID").value;
        //debugger;
        //window.returnValue=values;
        //window.dialogArguments.location.reload();
        window.dialogArguments.location=window.dialogArguments.location;
       window.returnValue=0;
         window.close();
     }
    </script>
  
</head>
<body  >
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 当前功能：
					<span id="rm_MainPanel_lFunctionName">分配物料</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
  
 
    <table  width="98%">
    <tr>
    <td align="right">
    <div class="menu">

        <asp:Button ID="BtnSubmit" runat="server" Width="100" Text="确定" CssClass="btn" OnClick="BtnSubmit_Click"   />
        <asp:Button ID="BtnClose" runat="server" Width="100" Text="取消" CssClass="btn"  CausesValidation="false" OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    	<!--head end-->
       
        
        
           
    <div class="BContent"  style="height:100%; padding-left:50px; padding-right:50px; padding-top:5px" >
     <!----contant------------------>
     <table width="100%" >
     <tr>
     <td>
     
    <table width="100%" class="tbBluebd">
   
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label>
                 <asp:HiddenField ID="HFPublishCode" runat="server" />
          <asp:HiddenField ID="HFMaterID" runat="server" />
          <asp:HiddenField ID="HFSupMoneyID" runat="server" />
                </td>
    </tr>
    <tr>
    <td>
    <table>
    <tr>
    <td style="height: 22px">分配量:</td>
    <td style="height: 22px">
        <asp:TextBox ID="TxtGiveNum" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator
                ID="RFVBuyNum" runat="server" ControlToValidate="TxtGiveNum"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REVBuyNum" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtGiveNum" Display="Dynamic"></asp:RegularExpressionValidator>
    </td>
    <td style="height: 22px">
        (可分配量:<asp:Label ID="LblCanNum" runat="server" Text=""></asp:Label>)</td>
    <td style="height: 22px"></td>
    </tr>
    </table>
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
            单&nbsp;&nbsp;&nbsp;&nbsp;价:</td>
              <td align="left" >
         
           <asp:Label ID="LblPrice" runat="server" Text=""></asp:Label>
              </td>
            <td style="width: 10px">
            </td>
                 <td colspan="2" rowspan="10">
                         
           
            <asp:Image  ID="ImgNewSup" ImageUrl="../../../images/nophoto.gif" runat="server"  Height="150px" Width="170px" /></td>
             
        </tr>  
        <tr>
        <td>
        税率(%):</td>
        <td>
                 
                   <asp:Label ID="LblRateNum" runat="server" Text=""></asp:Label>
        </td>
        <td style="width: 10px"></td>
        </tr>
          <tr>
        <td>
            起订量:</td>
        <td>
           
             <asp:Label ID="LblLiminitNum" runat="server" Text=""></asp:Label>
        </td>
        <td style="width: 10px"></td>
        </tr>
        <tr>
        <td >
           可到货时间:</td>
        <td >
        <asp:Label ID="LblSupGetMaterDate" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px" >
            &nbsp;</td>
        </tr>
         <tr>
        <td >
        </td>
        <td >
         </td>
        <td style="width: 10px" ></td>
        </tr>
        
         <tr>
        <td >
            </td>
        <td >
            </td>
        <td style="width: 10px" ></td>
        </tr>
                     <tr>
        <td  >
            </td>
              <td align="left" >
         
            </td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                 <tr>
        <td  >
            </td>
              <td align="left" >
         
            </td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            </td>
              <td align="left" >

            </td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            </td>
              <td align="left" >

            </td>
            <td style="width: 10px">
            </td>
             
        </tr> 
         <tr>
        <td style="height: 16px; " >
        </td>
        <td style="height: 16px" colspan="4" >
         </td>
        </tr>
           <tr>
        <td style="height: 16px; " >
            备注:</td>
        <td style="height: 16px" colspan="4" >
            
              <asp:Label ID="LblSupCommet" runat="server" Text=""></asp:Label>
             </td>
        </tr>

        </table>
         </td>
    </tr>
    <!--the extran-->
   <tr>
       <td align="left">
          <!--the extran-->
   <table width="100%" >
   <tr>
   <td>
      
       <asp:Panel ID="Panel1" runat="server" >
     
       </asp:Panel>
   
   </td>
   </tr>
   </table>
   <!--the extran end-->
       </td>
   </tr>
    <!--the extran end-->
    </td>
     </tr>
     </table>
     <table width="100%" class="tbBluebd">
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
                 <td colspan="2" rowspan="10">
                         
           
            <asp:Image  ID="ImgNew" ImageUrl="../../../images/nophoto.gif" runat="server"  Height="150px" Width="170px" /></td>
             
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
            到样天数:</td>
              <td align="left" >

            <asp:Label
                  ID="LblModelGetDate" runat="server" Text=""></asp:Label></td>
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


