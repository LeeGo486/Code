<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishAddMater, App_Web_bp_publishaddmater.aspx.874e4ad9" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布物料</title>
    <base target="_self" />
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
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
 
       
    	 window.document.getElementById('ImgNew').src=obj;
    	
    	if( document.getElementById('ImgNew').height> document.getElementById('ImgNew').width)
    	{
    	   document.getElementById('ImgNew').height=150;
    	 }
    	 else
    	 {
    	  document.getElementById('ImgNew').width=150;
    	 }
    }
  
        function preview()
        { 
        
            var x = document.getElementById("File1"); 
            var y = document.getElementById("ImgNew"); 
            if(!x || !x.value || !y) return; 
            var patn = /\.jpg$|\.jpeg$|\.gif$/i;
            if(patn.test(x.value)){  y.src = "file://localhost/" + x.value; }
            else{  alert("您选择的似乎不是图像文件。"); }
         }
    </script>
</head>
<body  topmargin="100" leftmargin="100">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">新增采购物料发布</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
            <!--menu----->
   <table  width="98%">
    <tr>
    <td align="right">
    <div class="menu">

      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="btnSave_Click" />
      <asp:Button ID="BtnClear" Width="100px" runat="server" Text="重 置" CssClass="btn" OnClick="btnClear_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退 出" CssClass="btn"  OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
        
    <div  class="BContent"  style="height:100%; padding-left:50px; padding-right:50px">
     <!----contant------------------>
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
     <tr>
    <td >
    <asp:Label ID="Label2" runat="server" Text="说明：物料的通用名称，规格，颜色是显示给供应商识别的,到样时间是要求客户的样板在此之前到"  ></asp:Label>
        </td>
    </tr>
    <tr>
    <td align="left">
        <table  width="100%"  >
             <colgroup>
                <col  width="50" />
                <col  align="left"  width="150" />
                <col   width="20" />
                 <col  width="50"  />
                <col  align="left" width="150"  />
                </colgroup>
          
          <tr>
             <tr>
        <td >
            物料编号:</td>
              <td align="left" >
                   <asp:TextBox ID="TxtMaterNo" runat="server" CssClass="tbox" MaxLength="100" Width="200px"></asp:TextBox><asp:RequiredFieldValidator
                      ID="RVMaterNo" runat="server" ControlToValidate="TxtMaterNo"
                      ErrorMessage="*"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="REVMaterNo" runat="server" ControlToValidate="TxtMaterNo"
        ErrorMessage="*物料编号只能是数字或字母类型" ValidationExpression="^[A-Za-z0-9]+$"></asp:RegularExpressionValidator></td>
            <td>
            <asp:TextBox ID="TxtMaterNo2" runat="server"  CssClass="hidden" Width="45px"></asp:TextBox></td>
             <td> </td>
             <td>
                 &nbsp;<asp:HiddenField ID="HFPublishCode" runat="server" />
                </td>
             
        </tr>  
                     <tr>
        <td >
            物料名称:</td>
              <td align="left" >
            <asp:TextBox ID="TxtMaterName" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="TxtMaterName"></asp:RequiredFieldValidator></td>
            <td>
            </td>
             <td>    通用名称:</td>
             <td>
            <asp:TextBox ID="TxtMaterUName" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="TxtMaterName"></asp:RequiredFieldValidator></td>
             
        </tr> 
                             <tr>
        <td >
            物料类型:</td>
              <td align="left" >
                <asp:DropDownList ID="ddlType" runat="server"  Width="200" CssClass="tbox" AutoPostBack="true"  OnSelectedIndexChanged="ddlType_SelectedIndexChanged"></asp:DropDownList></td>
            <td>
            </td>
             <td>    物料大类:</td>
             <td>
             <asp:DropDownList ID="ddlDL" runat="server"  Width="200" CssClass="tbox"></asp:DropDownList>
            </td>
             
        </tr>           
        <tr>
        <td >
            规 &nbsp; &nbsp;格:</td>
        <td >
            <asp:TextBox ID="TxtModelName" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="TxtModelName"></asp:RequiredFieldValidator></td>
     <td >
        
        </td>
        <td>
            规格代码:</td>
      
          <td >
            <asp:TextBox ID="TxtModelCode" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="TxtModelCode"></asp:RequiredFieldValidator></td>
        </tr>
     <tr>
        <td >
            颜 &nbsp; &nbsp;色:</td>
        <td >
            <asp:TextBox ID="TxtColorName" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ControlToValidate="TxtColorName"></asp:RequiredFieldValidator></td>
     <td >
        
        </td>
        <td>
            颜色代码:</td>
      
          <td >
            <asp:TextBox ID="TxtColorCode" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox></td>
        </tr>
           <tr>
        <td >
            单 &nbsp; &nbsp;位:</td>
        <td >
            <asp:TextBox ID="TxtUnit" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator
                ID="RFVUnit" runat="server" ControlToValidate="TxtUnit"
                ErrorMessage="*"></asp:RequiredFieldValidator></td>
     <td >
        
        </td>
        <td>
            成 &nbsp; &nbsp;份:</td>
      
          <td >
            <asp:TextBox ID="TxtComposition" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox></td>
        </tr>
           <tr>
        <td >
            采购时间:</td>
        <td >
             <igsch:WebDateChooser ID="WebDateChooserBuydate" runat="server" Value="" Width="200">
          </igsch:WebDateChooser>
            &nbsp;
                </td>
     <td >
        
        </td>
        <td>
            采购数量:</td>
      
          <td >
            <asp:TextBox ID="TxtBuyNum" runat="server" CssClass="tbox" MaxLength="50" Width="200" >1</asp:TextBox><asp:RequiredFieldValidator
                ID="RFVBuyNum" runat="server" ControlToValidate="TxtBuyNum"
                ErrorMessage="*"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REVBuyNum" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtBuyNum" Display="Dynamic"></asp:RegularExpressionValidator></td>
        </tr>
           <tr>
        <td >
            到货时间:</td>
        <td ><igsch:WebDateChooser ID="WebDateChooserMatergetdate" runat="server" Value="" Width="200">
            </igsch:WebDateChooser>
         
            </td>
     <td >
        
        </td>
        <td>
            到样时间:
        </td>
      
          <td >
              <igsch:WebDateChooser ID="WebDateChooserModelGetDate" runat="server" Value="" Width="200">
          </igsch:WebDateChooser>
       
                  </td>
        </tr>
       
           <tr>
        <td style="height: 16px" >
            描&nbsp;&nbsp;&nbsp;&nbsp;述:</td>
        <td style="height: 16px" >
            &nbsp;</td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            样 &nbsp; &nbsp;图:</td>
      
          <td style="height: 16px"  >
          <input id="File1" runat="server" class="tbinput" name="File" style="width: 200px"  onchange="changepic(this.value)"
                                type="file" />
              </td>
        </tr>
           <tr>
        <td >
            </td>
        <td valign="top" >
            <asp:TextBox ID="TxtCommet" runat="server" CssClass="tbox" Height="150px" MaxLength="50"
                TextMode="MultiLine" Width="200"></asp:TextBox></td>
     <td >
        
        </td>
        <td>
        </td>
      
          <td valign="top" >
            
            <img  ID="ImgNew" src="../../../images/nophoto.gif" runat="server"  Height="150" />
            
              </td>
        </tr>
         
          
      
        </table>
    </td>
    </tr>
        <tr>
    <td>
    <table width="100%">
    <tr>
    <td >
   
        </td>
    </tr>
  
     <tr>
   
    <td >
   
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
