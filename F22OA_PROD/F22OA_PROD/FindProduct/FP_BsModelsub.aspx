<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_BsModelsub, App_Web_fp_bsmodelsub.aspx.a918743" %>

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
					<span id="rm_MainPanel_lFunctionName">调查内容管理</span>&nbsp;&nbsp;&nbsp;
					
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
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="增加调查题目" CssClass="btn" OnClick="btnSave_Click" />
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
		        <asp:Label ID="LblModelSubID" runat="server"  CssClass="hidden"></asp:Label>
        <asp:Label ID="LblModelName" runat="server" ></asp:Label><asp:Label ID="LblT" runat="server" Font-Size="14pt"></asp:Label>
        </strong>
		    </div>
        </td>
    </tr>
 <tr>
    <td colspan="2">
    <hr  style="display:inline;border:solid 1px #1b9bbf; "/>
      <asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label>
    </td>
    </tr>
    <tr>
    <td colspan="2">
    
      <asp:DataList ID="DataListTitle" runat="server" OnItemDataBound="DataListTitle_ItemDataBound" Width="600px">
      <ItemTemplate>
      <table>
      <tr>
      <td style="height: 64px">
      <!--title----->
      <table  Width="600">
          
      <tr>
      <td><asp:HiddenField ID="HFmodelsubid" runat="server" Value='<%# Eval("ModelSubid")%>' /> <%# (Container.ItemIndex+1)%>.<%# Eval("ModelSubname")%> (分值系数:<%# Eval("ModelNum")%> )</td>
       <td  align="right"><a href="FP_BsModelSubEidt.aspx?modelsubid=<%# Eval("ModelSubid")%>&modelsubname=<%# Eval("ModelSubname")%>&modelid=<%=LblModelId.Text %>&modelname=<%=LblModelName.Text %>">编辑</a><asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"  CommandArgument='<%# Eval("ModelSubid") %>'  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" OnClick="IbDel_Click" ></asp:ImageButton></td>
      </tr>
      </table>
      <!--title end-->
      </td>
      </tr>
      <tr>
          <td>
           <table>
          <tr> <td>
            <asp:DataList ID="DataListAnwser" runat="server" RepeatDirection="horizontal" CellPadding="10">
             <ItemTemplate>
         
         
          <%# Eval("AnswerNo")%>. <%# Eval("AnswerName")%>&nbsp;&nbsp;&nbsp;(分数:<%# Eval("AnswerScore")%>)
          
          
           </ItemTemplate>
           
            </asp:DataList></td></tr>
          </table>
          </td>
      </tr>
      </table>
      </ItemTemplate>
        </asp:DataList>
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
