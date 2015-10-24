<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_BsModelSubEidt, App_Web_fp_bsmodelsubeidt.aspx.a918743" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">

</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">调查内容编辑</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看调查方案" CssClass="btn"   OnClientClick="window.location.href='FP_BsModel.aspx'; return false;"   />
      <asp:Button ID="BtnGo2" Width="100px" runat="server" Text="查看调查题目" CssClass="btn" CausesValidation="false"  OnClick="BtnGo2_Click"     />
      <asp:Button ID="BtnGo3" Width="100px" runat="server" Text="增加调查题目" CssClass="btn" CausesValidation="false"  OnClick="BtnGo3_Click"     />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="Savedata" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    
    <div  class="BContent" style="width:100%">
    
   <table width="100%">
    <tr>
    <td colspan="2">
         <div class="content" style="font-size:18px"  >
		        <strong><asp:Label ID="LblModelId" runat="server"  CssClass="hidden"></asp:Label>
        <asp:Label ID="LblModelName" runat="server" ></asp:Label><asp:Label ID="LblT" runat="server" Font-Size="14pt"></asp:Label>
        </strong>
		    </div>
        </td>
    </tr>
    <tr>
   

    <td align="center" colspan="2">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
     <tr>
    <td>调查题目：</td>
    <td>
    
        <asp:TextBox ID="TxtTitle" runat="server" Width="300px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtTitle"
            ErrorMessage="*"></asp:RequiredFieldValidator>
        分值系数:
        <asp:TextBox ID="TxtTitleNum" runat="server" Text="100" Width="50px"></asp:TextBox>(%)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtTitleNum"
            ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtTitleNum"
            ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)"></asp:RegularExpressionValidator><asp:HiddenField ID="HFModelSubID" runat="server" />
    </td>
    </tr>
    <tr>
    <td>
        </td>
    <td>
        说明:题目的分值系数*答案分值=该题目所得分,请分配好调查各题的分值系统，各题分值系数加起来为100</td>
    </tr>
     <tr>
    <td colspan="2">
    <hr  style="display:inline;"/>
    </td>
    </tr>
   <tr>
   <td valign="top">答题选项：</td>
    <td >
    <table width="100%">
    <tr>
    <td>
       <asp:GridView id="GridView1" runat="server" Width="100%"  CssClass="tbGrid" CellSpacing="1" ForeColor="#333333" RowStyle-HorizontalAlign="Center" GridLines="None" DataSourceID="ObjectDataSource1" DataKeyNames="AnswerID" CellPadding="4" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>

<asp:TemplateField SortExpression="AnswerID" HeaderText="序号">
<EditItemTemplate>
                     <asp:Label ID="LblmodelID" runat="server" Text='<%# (Container.DataItemIndex+1)%>'></asp:Label>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# (Container.DataItemIndex+1)%>'></asp:Label>
                
</ItemTemplate>

</asp:TemplateField>
<asp:TemplateField SortExpression="AnswerNo" HeaderText="编号">
<EditItemTemplate>
                   <asp:TextBox ID="TxtAnswerNo" runat="server" Text='<%# Bind("AnswerNo") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVAnswerNo" runat="server" ControlToValidate="TxtAnswerNo" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>

<ItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%#  Bind("AnswerNo")%>'></asp:Label>
                
</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField SortExpression="AnswerName" HeaderText="选项">
<EditItemTemplate>
                    <asp:TextBox ID="TxtAnswerName" runat="server" Text='<%# Bind("AnswerName") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVAnswerName" runat="server" ControlToValidate="TxtAnswerName" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("AnswerName") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="AnswerScore" HeaderText="分数">
<EditItemTemplate>
                    <asp:TextBox ID="TxtAnswerScore" runat="server" Text='<%# Bind("AnswerScore") %>' Width="100px"></asp:TextBox>
                     <br />
                    <asp:RequiredFieldValidator id="RFVAnswerScore" runat="server" ControlToValidate="TxtAnswerScore" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtAnswerScore"
            ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)"></asp:RegularExpressionValidator>
</EditItemTemplate>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("AnswerScore") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>



<asp:TemplateField  HeaderText="操作"><EditItemTemplate>
<asp:LinkButton runat="server" Text="更新" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton runat="server" Text="编辑" CommandName="Edit" CausesValidation="False" id="LinkButton1"></asp:LinkButton>&nbsp;

<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>

</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
            <table cellspacing="0" cellpadding="3" rules="cols" border="1" id="ctl00_ctplhder_GridView11" 
            　　 class="header">
		<tr style="color:White;background-color:#507CD1;font-weight:bold;">
		
			<th scope="col">编号</th>
			<th scope="col">选项</th>
			
			
		</tr>
	
	
		</table>
        
</EmptyDataTemplate>

<SelectedRowStyle ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle CssClass="header"  HorizontalAlign="Center" ></PagerStyle>

<HeaderStyle CssClass="dgHeader"  ></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
    <EditRowStyle  />
</asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="DC_UpAnswer" TypeName="ddl_FindProduct" SelectMethod="DC_GetAnswer" DeleteMethod="DC_DelAnswer">
        <DeleteParameters>
            <asp:Parameter Name="AnswerID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AnswerID" Type="Int32" />
            <asp:Parameter Name="AnswerNo" Type="String" />
            <asp:Parameter Name="AnswerName" Type="String" />
            <asp:Parameter Name="AnswerScore"  Type="single" />
           <asp:Parameter Name="AnswerNum"  Type="single" />
        </UpdateParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="HFModelSubID" Name="ModelSubid" PropertyName="Value"
            Type="Int32" />
    </SelectParameters>
    </asp:ObjectDataSource>
    </td>
    </tr>
    <tr>
    <td>
   编号:<asp:TextBox ID="TxtAnwserNo" runat="server" Width="50px" Text="A" ValidationGroup="a"></asp:TextBox>
         <asp:RequiredFieldValidator ID="RFVAnserNo" runat="server" ControlToValidate="TxtAnwserNo"
             ErrorMessage="*"></asp:RequiredFieldValidator>
         内容:<asp:TextBox ID="TxtAnserName" runat="server" Width="137px" ValidationGroup="a"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="TxtAnserName"
             ErrorMessage="*" ValidationGroup="a"></asp:RequiredFieldValidator>
             分值:<asp:TextBox ID="TxtAnserScore" runat="server"
                     Width="50px" ValidationGroup="a">100</asp:TextBox>
         <asp:RequiredFieldValidator ID="RFVScore" runat="server" ControlToValidate="TxtAnserScore"
             ErrorMessage="*"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="REVScore"
                 runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtAnserScore" ></asp:RegularExpressionValidator>
        <asp:Button ID="BtnAddAnswer" runat="server" Text="增加答题选项" ValidationGroup="a" OnClick="BtnAddAnswer_Click" /></td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    </div>
    </form>
    
</body>
</html>
