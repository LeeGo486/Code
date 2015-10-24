<%@ page language="C#" autoeventwireup="true" maintainscrollpositiononpostback="true" inherits="buyproductuser_BP_UserWriteNoSureEidter, App_Web_bp_userwritenosureeidter.aspx.4969a439" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布物料</title>
    <base target="_self" />
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
         <script type="text/javascript">
document.onkeydown=function()
{
   if(event.keyCode==13 && event.srcElement.type=="text")
   {
     //&& event.srcElement.type!="button"
       //window.alert(event.srcElement.type);
       event.keyCode=9;  
   }
}
</script>
    <script type="text/javascript">
     function bt_close_onclick()
 {
     window.dialogArguments.location=window.dialogArguments.location;
       window.close();
  
 }
 function bt_return()
     {
        
       
        //var values=window.document.getElementById("HFID").value;
        //debugger;
        //window.returnValue=values;
        //window.dialogArguments.location.reload();
       // window.dialogArguments.location=window.dialogArguments.location;
       window.returnValue=0;
         window.close();
     }
    </script>
       <script language="javascript" type="text/javascript">
    function changepic(obj)
    {
 
       
    	 window.document.getElementById('ImgNewSup').src=obj;
    	
    	if( document.getElementById('ImgNewSup').height> document.getElementById('ImgNewSup').width)
    	{
    	   document.getElementById('ImgNewSup').height=150;
    	 }
    	 else
    	 {
    	  document.getElementById('ImgNewSup').width=150;
    	 }
    }
  
    </script>
</head>
<body  topmargin="100" leftmargin="100">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">采购物料编辑</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="目前采购物料" CssClass="btn"   OnClientClick="window.location.href='BP_UserMasterList.aspx'; return false;"   />

     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    
        
    <div class="BContent"  style="height:100%; padding-left:50px; padding-right:50px; padding-top:5px" >
     <!----contant------------------>
    <table width="100%">
   
    <tr>
    <td align="center">
        &nbsp;<asp:HiddenField ID="HFPublishCode" runat="server" />
          <asp:HiddenField ID="HFMaterID" runat="server" />
          <asp:HiddenField ID="HFSave" runat="server" />
          
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
                 <td colspan="2" rowspan="10">
                         
           
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
            采购时间:</td>
              <td align="left" >

            <asp:Label ID="LblBuydate" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
        
                  <tr>
        <td  >
            到样时间:</td>
              <td align="left" >

            <asp:Label
                  ID="LblModelGetDate" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            到货时间:</td>
              <td align="left" >
         
            <asp:Label ID="LblMatergetdate" runat="server" Text=""></asp:Label></td>
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
          <asp:TextBox ID="TxtPrice" runat="server"  MaxLength="50" Width="100px">1</asp:TextBox><asp:RequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtPrice"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtPrice" Display="Dynamic"></asp:RegularExpressionValidator></td>
            <td style="width: 10px">
            </td>
                 <td colspan="2" rowspan="10">
                         
           
            <asp:Image  ID="ImgNewSup" ImageUrl="images/nophoto.gif" runat="server"  Height="150px" Width="170px" /></td>
             
        </tr>  
        <tr>
        <td>
        税率(%):</td>
        <td>
                  <asp:TextBox ID="TxtRateNum" runat="server" MaxLength="50" Width="100px">1</asp:TextBox><asp:RequiredFieldValidator
                ID="RFVBuyNum" runat="server" ControlToValidate="TxtRateNum"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REVBuyNum" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtRateNum" Display="Dynamic"></asp:RegularExpressionValidator></td>
        <td style="width: 10px"></td>
        </tr>
          <tr>
        <td>
            起订量:</td>
        <td>
            <asp:TextBox ID="TxtLiminitNum" runat="server" MaxLength="50" Width="100px">1</asp:TextBox><asp:RequiredFieldValidator
                ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtLiminitNum"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtLiminitNum" Display="Dynamic"></asp:RegularExpressionValidator></td>
        <td style="width: 10px"></td>
        </tr>
        <tr>
        <td >
            可到货时间:</td>
        <td >
            <igsch:webdatechooser id="WebDateChooserMatergetdate" runat="server" value="" width="100px"></igsch:webdatechooser>
        </td>
        <td style="width: 10px" ></td>
        </tr>
         <tr>
        <td >
            到样时间:</td>
        <td >
             <igsch:webdatechooser id="WebDateChooserMatermodeldate" runat="server" value="" width="100px"></igsch:webdatechooser></td>
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
        上传样图:</td>
        <td style="height: 16px" colspan="4" >
         <input id="File1" runat="server" class="tbinput" name="File" onchange="changepic(this.value)"
            style="width: 200px" type="file" tabindex="-1" /></td>
        </tr>
           <tr>
        <td style="height: 16px; " >
            备注:</td>
        <td style="height: 16px" colspan="4" >
            <asp:TextBox ID="TxtCommet" runat="server" Height="60px" MaxLength="50"
             TextMode="MultiLine" Width="98%"></asp:TextBox></td>
        </tr>

        </table>
         </td>
    </tr>
    <tr>
   <td>
   <!--the extran-->
   <table width="100%">
   <tr>
   <td>
   <asp:HiddenField ID="HFSupMoneyID" runat="server" />
       <asp:Panel ID="Panel1" runat="server" >
     
       </asp:Panel>
   
   </td>
   </tr>
     <tr>
   <td align="center">
       <asp:Button ID="BtnSave" runat="server" Text="保  存" Width="100px"  CssClass="btn"  OnClick="BtnSave_Click" /> <asp:Button ID="BtnSubmit" runat="server" Text="提交报价" Width="100px" OnClientClick="return confirm('请保存后再提交,提交后不可以修改,确认提交吗？')"  CssClass="btn"  OnClick="BtnSubmit_Click" /></td>
   </tr>
   <tr>
   <td  align="center"> <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
   </tr>
    </table>
    <!----contant end------------->
    </div>
    
      
    
        
    
      
    
        </DIV>
    
      
    
        
    
      
    
    </form>
</body>
</html>


