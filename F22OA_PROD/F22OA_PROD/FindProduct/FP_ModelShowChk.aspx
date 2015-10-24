<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_ModelShowChk, App_Web_fp_modelshowchk.aspx.a918743" %>
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
					<span id="rm_MainPanel_lFunctionName">调查内容</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
   
   <div  class="BContent" style="width:100%">
      
    <table width="100%">
    <tr>
    <td colspan="2">
         <div class="content" style="font-size:18px"  >
		        <strong>
        </strong>
		    </div>
        </td>
    </tr>
 <tr>
    <td colspan="2">
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
      <td><asp:HiddenField ID="HFmodelsubid" runat="server" Value='<%# Eval("BillQuestionID")%>' /> <%# (Container.ItemIndex+1)%>.<%# Eval("ModelSubname")%> (分值系数:<%# Eval("ModelNum")%> )</td>
       <td  align="right"></td>
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
