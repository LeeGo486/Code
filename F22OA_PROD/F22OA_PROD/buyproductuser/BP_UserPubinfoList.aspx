<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserPubinfoList, App_Web_bp_userpubinfolist.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <link  href="css/project.css" type="text/css"  rel="stylesheet">
    <link  href="css/main.css" type="text/css"  rel="stylesheet">		       
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能： <span id="rm_MainPanel_lFunctionName">公告信息列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
   <!--head end-->
  
    <div  >
    <table width="80%" align="center">
    <tr>
    <td>
   
    	<asp:GridView ID="GridView1" runat="server"  BorderStyle="None" BorderWidth="0px"  
	AutoGenerateColumns="False" DataKeyNames="PubNewListID" CellPadding="0" CellSpacing="0"
		DataSourceID="ObjectDataSource1" HorizontalAlign="Center" AllowPaging="True" 
		Width="100%" PageSize="20"  cssclass="ActivityList">
			<Columns>
				<asp:TemplateField>
					 <ItemTemplate>
						  <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" 
						  NavigateUrl='<%#  "BP_UserPubDetail.aspx?sid="+Eval("PubNewListID") %>'
						  Text=''>
						  <%# Eval("PubNewTitle").ToString()%></asp:HyperLink>
					</ItemTemplate>
				</asp:TemplateField>
				
			</Columns>
		   </asp:GridView>
		   <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="CG_GetPubNewList"
			TypeName="ddl_cgnew">
			
		</asp:ObjectDataSource>
		
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
