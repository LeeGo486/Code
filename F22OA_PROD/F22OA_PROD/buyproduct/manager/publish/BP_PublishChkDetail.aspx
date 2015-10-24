<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishChkDetail, App_Web_bp_publishchkdetail.aspx.874e4ad9" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购发布维护</title>
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

</script>
       <script language="javascript" type="text/javascript">
        function GoUrlShowAddMater() 
        { 
        	
//		             var url="/buyproduct/manager/publish/BP_PublishAddMater.aspx?pid="+window.document.getElementById("LblPublishCode").value;
//	                 var result=showaspx(url,860,653);
                    var url="BP_PublishAddMater.aspx?pid="+window.document.getElementById("LblPublishCode").innerText;
	                 var result=LoadWindow(url,860,653);
	            
        }
            function GoUrlShowEditMater(msid) 
        { 
        		
//		             var url="/buyproduct/manager/publish/BP_PublishEditMater.aspx?MaterSubid="+msid;
//	                 var result=showaspx(url,860,653);
var url="BP_PublishEditMater.aspx?MaterSubid="+msid;
	                 var result=LoadWindow(url,860,653);
	           
	        
       }
         function GoUrlShowAddMaterL18() 
        { 
        			
//		     var url="/buyproduct/manager/publish/BP_PublishMaterModle.aspx?pid="+window.document.getElementById("LblPublishCode").value;
//	         var result=showaspx(url,860,653);
var url="BP_PublishMaterModle.aspx?pid="+window.document.getElementById("LblPublishCode").innerText;
	         var result=LoadWindow(url,860,653);
	        
	        
        }
        function GoUrlShowADDSuper(pid,mid) 
        { 

		   var url="BP_PublishSuperList.aspx?pid="+pid+"&mid="+mid
	        LoadWindow(url,860,653);
       }
         
    </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">采购发布审核</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="待审申请" CssClass="btn" PostBackUrl="BP_PublishChkList.aspx"  />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="审 核" CssClass="btn" OnClick="btnSave_Click" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

        
    <div  class="BContent" style="height:100%">
    <!----contant------------------>
    <table width="100%">
    <tr>
    <td>
    <!--pi wen-->
     <table width="100%" class="tbBlock" >
        <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="100" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          <tr>
    <td>
        审核:</td>
          <td colspan="4">
              <asp:RadioButton ID="RBtnNoPass" runat="server" GroupName="chk"  Text="审核不通过" />
              <asp:RadioButton ID="RBtnPass" runat="server" GroupName="chk" Checked="true"  Text="审核通过"/></td>
    </tr>          
    <tr>
    <td>
        审核人:</td>
     <td>
         <asp:TextBox ID="TxtChkUser" runat="server" Width="200px" CssClass="tbox" MaxLength="50"></asp:TextBox></td>
     <td>
    </td>
     <td>
         审核时间:</td>
     <td>
          <igsch:WebDateChooser ID="WebDateChooserChkDate" runat="server" Value="" Width="200px" Enabled="false">
            </igsch:WebDateChooser></td>
    </tr>
    
      <tr>
    <td>
        批文:</td>
          <td colspan="4">
              <asp:TextBox ID="TxtChkCommet" runat="server" Width="95%" CssClass="tbox" MaxLength="100"></asp:TextBox></td>
    </tr>
    </table>
    <!--pi wen end-->
    </td>
    </tr>
    <tr>
    <td>
    <!--old bill-->
    
         <table border="0" width="100%"  class="tbBluebd"   style="height:100%">
       <tr>
            <td align="center" style="height: 14px"><span style="font-size:14px">发布申请单</span>
        </td>
    </tr>
    <tr>
    <td>
    <hr />
    </td>
    </tr>
     <tr>
    <td align="left">
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label>
        <asp:HiddenField ID="HFPublishCode" runat="server" />
        </td>
    </tr>
    <tr>
    <td align="left">
        <table  width="100%"  >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          
          <tr>
             <tr>
        <td >
            发布编号:</td>
              <td align="left" >
                  <asp:Label ID="LblPublishCode" runat="server" Text=""></asp:Label>
                 </td>
            <td>
           </td>
             <td>    
            采购类型:</td>
             <td>
               <asp:Label ID="LblBuyType" runat="server" Text=""></asp:Label>
             </td>
             
        </tr>  
                     <tr>
        <td >
            发 布 人:</td>
              <td align="left" >
               <asp:Label ID="LblCrUser" runat="server" Text=""></asp:Label>
            </td>
            <td>
            </td>
             <td>    申请日期:</td>
             <td> 
              <asp:Label ID="LblCrdate" runat="server" Text=""></asp:Label>
             </td>
             
        </tr>         
       <tr>
        <td >
            开始时间:</td>
              <td align="left" > 
              <asp:Label ID="LblDateBegin" runat="server" Text=""></asp:Label>
             
              </td>
            <td>
            </td>
             <td>    结束时间:</td>
             <td> 
             <asp:Label ID="LblDateEnd" runat="server" Text=""></asp:Label>

             </td>
             
        </tr>      
           <tr>
        <td style="height: 16px" >
            </td>
        <td style="height: 16px" >
            </td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            </td>
      
          <td style="height: 16px" >
              </td>
        </tr>
           <tr>
        <td style="height: 16px" >
            备 &nbsp;&nbsp; 注:</td>
               <td colspan="4" style="height: 16px">
                 <asp:Label ID="LblCommet" runat="server" Text=""></asp:Label>
          </td>
        </tr>
           <tr>
        <td >
            </td>
        <td valign="top" >
        <asp:Button ID="BtnChoiceShop" runat="server" OnClientClick="GoUrlShowAddMater()"
            Text="手工新增物料"  Width="200px"   CssClass="NormalBtn"    />
            </td>
     <td >
        
        </td>
        <td>
        </td>
      
          <td valign="top" >
              &nbsp;<asp:Button ID="Button1" runat="server" OnClientClick="GoUrlShowAddMaterL18()"
            Text="从Cl18导入物料"  Width="200px"   CssClass="NormalBtn"    /></td>
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
            <asp:GridView ID="GridViewMater" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="MaterSubid"  CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                   
                    <asp:BoundField DataField="PublishCode" HeaderText="PublishCode" ReadOnly="True" SortExpression="PublishCode" Visible="False" />
                    <asp:BoundField DataField="MaterID" HeaderText="物料编号" SortExpression="MaterID" />
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="BuyNum" HeaderText="采购数量" SortExpression="BuyNum" />
                    <asp:BoundField DataField="unit" HeaderText="单位" SortExpression="unit" />
                    <asp:BoundField DataField="BuyDate" HeaderText="采购日期" SortExpression="BuyDate" DataFormatString="{0:d}" HtmlEncode="False" />
                    <asp:BoundField DataField="Matergetdate" HeaderText="到货日期" SortExpression="Matergetdate" DataFormatString="{0:d}" HtmlEncode="False"  />
                     <asp:BoundField DataField="Supernum" HeaderText="供应商数" SortExpression="Supernum" />
         <asp:TemplateField HeaderText="编辑">
                        <ItemTemplate>
                         <img src="../../../icon/go3.gif" border="0" /> 
                        <asp:LinkButton ID="lbtnCheck" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# Eidtstring(Eval("MaterSubid").ToString()) %>'
                        CommandName="Check" Text='编辑' >
                         </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <img src="../../../icon/go3.gif" border="0" /> 
                          <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# EidtSupter(Eval("PublishCode").ToString(),Eval("MaterID").ToString()) %>'
                        CommandName="Check" Text='供应商' >
                         </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                    <asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                   
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
            <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="CG_DelPublishMater" SelectMethod="CG_GetPublishMater" TypeName="ddl_cgnew" >
            <DeleteParameters>
                <asp:Parameter Name="MaterSubid" Type="Int32" />
    
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="LblPublishCode" Name="PublishCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    <!--old bill end-->
    </td>
    </tr>
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>
