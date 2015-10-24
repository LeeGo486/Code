<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindResultTitlePic, App_Web_fp_findresulttitlepic.aspx.a918743" %>

<html  xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head runat="server">
    <title>图报表</title>
       <link  href="../css/project.css" type="text/css"  rel="stylesheet">
         <style type="text/css">
  A:link {
	COLOR: #005a5a; TEXT-DECORATION: none
}
  </style>
    	<STYLE>
		v\:* { BEHAVIOR: url(#default#VML) }
		o\:* { BEHAVIOR: url(#default#VML) }
		</STYLE>
				<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDiv3(z){
var z;
var s=document.getElementById("input3_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
</head>
<body>
    <form id="form1" runat="server">
       
    <div style="margin-top:0px;padding:5px 2px 10px 2px; height:500px;background:#fff;" >
    <table width="100%" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F7F7F7,endColorStr=#FFFFFF);">
    <tr>
      <td align="center"> <h2><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></h2></td>
    </tr>
        <tr>
           
    <td>
    <table width="100%">
    <tr>
    <td align="left"><asp:Label ID="LblTitle2" runat="server" Text=""></asp:Label></td>
    <td align="right">图表查看方式:<asp:DropDownList id="DropDownList1" runat="server" CssClass="dropd"  AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
					
					<asp:ListItem Value="2">柱状图</asp:ListItem>
					<asp:ListItem Value="1">饼图</asp:ListItem>
				</asp:DropDownList></td>
    </tr>
    </table>
     
	</td>
    </tr>
    <tr>
    <td>调查内容:
				</td>
    </tr>
    <tr>
    <td>
    <!--the proj---->
        <asp:HiddenField ID="HFModelSubname" runat="server" />
        <asp:HiddenField ID="HFStyleid" runat="server" />
        <asp:HiddenField ID="HFTitleCode" runat="server" />

    <table width="100%" border="0" cellpadding="1" cellspacing="1" ID="Table1">
			<tr valign="middle" class="ProTitle">
				<td >
				        <div id="tabs4">
                              <ul>
         <asp:Repeater ID="RepeaterQuestion" runat="server"  >
            <ItemTemplate>
               
               <li> <asp:Button ID="BtnProject"  OnClick="BtnProject_Click" CommandArgument='<%# Eval("ModelSubname")%>' runat="server" Text='<%# Eval("ModelSubname")%>'  CssClass="btn"  /></li>
           </ItemTemplate>
      </asp:Repeater>
        </ul>
                        </div>
                 </td>
			</tr>
		</table>
		 <!--the proj---->
    </td>
    </tr>
    <tr>
    <td>
				
				
    </td>
    </tr>
    <tr>
    <td height="400px">
    
    	<asp:Panel id="Panel1" runat="server" ></asp:Panel>
  
    </td>
    </tr>
    <tr>
    <td><asp:Label ID="LblReply" runat="server" Text=""></asp:Label><a href="#" title="显示回复内容"  onClick='showDiv(1)' id="ShowDivLink">(显示回复内容)</a>
              <a href="#" title="显示建议内容"  onClick='showDiv3(3)' id="A2">(显示建议内容)</a>        
                   
                     </td>
    </tr>
     <tr>
    <td>
    <div id="input_1" style="display:none;">
        <table>
        <asp:Repeater ID="RepeaterReply" runat="server">
        <ItemTemplate>
         <tr>
        <td><%# (Container.ItemIndex+1)%>.<%# Eval("ReplyText")%>&nbsp;&nbsp;&nbsp;&nbsp;(回复人:<%# Eval("d_name")%>-<%# Eval("cr_name")%>)</td>
        </tr>
        </ItemTemplate>
        </asp:Repeater>
        </table>
    </div>
          <div id="input3_3" style="display:none;">
        <table>
        <asp:Repeater ID="RepeaterSeguest" runat="server">
        <ItemTemplate>
         <tr>
        <td><%# (Container.ItemIndex+1)%>.<%# Eval("AdvanText")%>&nbsp;&nbsp;&nbsp;&nbsp;(建议人:<%# Eval("d_name")%>-<%# Eval("cr_name")%>)</td>
        </tr>
        </ItemTemplate>
        </asp:Repeater>
        </table>
    </div>
    </td>
    </tr>
    </table>
			
		
       </div>
    </form>
</body>
</html>
