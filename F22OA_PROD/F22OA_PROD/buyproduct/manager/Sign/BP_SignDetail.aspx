﻿<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Sign_BP_SignDetail, App_Web_bp_signdetail.aspx.9fbedc62" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/select.js"></script>
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
     <script type="text/javascript">
        var GB_ROOT_DIR = "../../../greybox/";
    </script>

    <script type="text/javascript" src="../../../greybox/AJS.js"></script>
    <script type="text/javascript" src="../../../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../../../greybox/gb_scripts.js"></script>
   <link href="../../../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
   	<script type="text/javascript">
GB_myShow = function(caption, url, /* optional */ height, width, callback_fn) {
    var options = {
        caption: caption,
        height: height || 550,
        width: width || 700,
        fullscreen: false,
        show_loading: false,
        callback_fn: callback_fn
    }
    var win = new GB_Window(options);
    return win.show(url);
}
	
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDiv2(z){
var z;
var s=document.getElementById("input2_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}


</script>
       <script language="javascript" type="text/javascript">
       function gop() 
        { 
        	     var id=window.document.getElementById("LblSignCode").innerText;
		         window.open("BP_SignPrint.aspx?hid="+id);
                  return false;   
	        
        }

       

         
    </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    
        <!--head-->
     <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">合同明细</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    	<!--head end-->
  <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >
       <asp:Button ID="BtnPrint" Width="100px" runat="server" Text="打印预览" CssClass="btn" OnClientClick="gop()"   />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    <div  class="BContent" style="height:100%">
     <!----contant------------------>
        <asp:HiddenField ID="HFSupplyerID" runat="server" />
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
        <table    class="tbBlock"  >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          
          <tr>
             <tr>
        <td  >
            供应商名称:</td>
              <td align="left"  >
              <asp:Label ID="LblCompName" runat="server" Text=""></asp:Label>
                  </td>
            <td >
            </td>
             <td >    合同编号:</td>
             <td >
              <asp:Label ID="LblSignCode" runat="server" Text=""></asp:Label>
             </td>
             
        </tr>  
                     <tr>
        <td  >
            供应商编号:</td>
              <td align="left"  >
               <asp:Label ID="LblSupplyNo" runat="server" Text=""></asp:Label>
              </td>
            <td >
            </td>
             <td >    流程编号:</td>
             <td > 
              <asp:Label ID="LblSignUCode" runat="server" Text=""></asp:Label>
             </td>
             
        </tr>         
       <tr>
        <td >
            付 款方 式:</td>
              <td align="left" > 
               <asp:Label ID="LblPayment" runat="server" Text=""></asp:Label>
                  </td>
            <td>
            </td>
             <td>    签定日期:</td>
             <td> 
              <asp:Label ID="LblSignDate" runat="server" Text=""></asp:Label>
             </td>
             
        </tr>      
           <tr>
        <td style="height: 16px" >
            税 票种 类:</td>
        <td style="height: 16px" >
         <asp:Label ID="LblChequeType" runat="server" Text=""></asp:Label>
            </td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            </td>
      
          <td style="height: 16px" >
              </td>
        </tr>
        
     
         
        </table>
    </td>
    </tr>
<tr>
    <td>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" ToolTip="合同符件"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SignFileID"  CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        
            <Columns>
               
                 <asp:TemplateField HeaderText="文件名称" SortExpression="Signfilename">
                    <ItemTemplate>
                   <a href="../../../<%# Eval("fileUrl")%>" target="_blank"><img src="../../../icon/go3.gif" border="0" /><%# Eval("Signfilename")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="crdate" DataFormatString="{0:d}" HeaderText="上传日期" HtmlEncode="False"
                    SortExpression="crdate" />
                 
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader"   />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="CG_DelSignFile"
            SelectMethod="CG_SignFile" TypeName="ddl_cgnew" >
            <DeleteParameters>
                <asp:Parameter Name="SignFileID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="LblSignCode" Name="SignCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </td>
    </tr>
  
    <tr>
    <td valign="top" align="left">
   
    <table width="100%">
    <tr>
    <td>
     <!--the wriehead-->
      <asp:Label ID="LblHeader" runat="server" Text=""></asp:Label>
        
    <!--the writer head end-->
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
    
            <asp:GridView ID="GridViewMater" runat="server" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupmaterID"  CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" OnRowDataBound="GridViewMater_RowDataBound">
            <FooterStyle  BackColor="#EFF3FB" HorizontalAlign="Center" />
            <Columns>
                   
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="False" />
                    <asp:BoundField DataField="MaterID" HeaderText="物料编号" SortExpression="MaterID" />
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="Maternum" HeaderText="数量" SortExpression="Maternum" />
                    <asp:BoundField DataField="Unit" HeaderText="单位" SortExpression="Unit" />
                    <asp:BoundField DataField="MaterPirce" HeaderText="单价" SortExpression="MaterPirce" />
                    <asp:BoundField DataField="MaterTax" HeaderText="税率" SortExpression="MaterTax" />
                    <asp:BoundField DataField="PriceSum" HeaderText="总金额" SortExpression="PriceSum" />
                 <asp:BoundField DataField="MaterCommet" HeaderText="备注" SortExpression="MaterCommet" />
                   <asp:BoundField DataField="TrackUserID" HeaderText="跟进人" SortExpression="TrackUserID"   />
                    
                   
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                         <th scope="col">物料编号</th>
                            <th scope="col">物料名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">采购数量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货时间</th>
                            <th scope="col">供应商</th>
                    </tr>
                     <tr  bgcolor="White">
                      <th scope="col"></th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader"   />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="CG_DelSignMater" 
         SelectMethod="CG_GetSignMaterBySignID" TypeName="ddl_cgnew" >
            <DeleteParameters>
                <asp:Parameter Name="SupmaterID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="LblSignCode" Name="SignCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </td>
    </tr>
    </table>
    </td>
    </tr>
  
    <tr>
    <td valign="top" align="left">
        
    <table width="100%">
    <tr>
    <td>
     <!--the wriehead-->
      <asp:Label ID="LblFoot" runat="server" Text=""></asp:Label>
        
    <!--the writer head end-->
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

