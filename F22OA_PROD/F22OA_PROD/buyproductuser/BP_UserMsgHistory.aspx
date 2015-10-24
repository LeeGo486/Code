<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserMsgHistory, App_Web_bp_usermsghistory.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>留言信息</title>
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
    <style>
*{
font-size:12px;
}
#errTable{
border:solid 1px #999999;
background:#FFFFFF;
position:absolute; top:-4px;left:-4px;
}
#errShowDown{
background:#CCCCCC;
position:relative;
width:500px;
height:120px;
}
#errTitle{
background:#ff8a01;color:white;font-weight:bold;
text-align:center
}
#showDetail{
color:#666666;
padding:5px;
}
#showSpan{
font-family:Webdings;
}
#sdlink{
border:solid 1px #ffd099;
background:#fff7ee;
text-decoration:none;color:black;
display:block;width:99%;
margin-top:10px;
}
#sdlink:hover{
border:solid 1px #65bcff;
background:#e5f1ff;
}
</style>
<script>
function showDetail(){
	if(document.getElementById('showDetail').style.display=='none'){
		document.getElementById('showDetail').style.display='block';
		document.getElementById('showSpan').innerHTML='6'
	}else{
		document.getElementById('showDetail').style.display='none';
		document.getElementById('showSpan').innerHTML='4'
	}
		document.getElementById('errShowDown').style.height=document.getElementById('errTable').offsetHeight-2;
}
</script>	
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">留言信息</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
   
    <div  class="BContent">
     <!----contant------------------>
     <table width="100%">

     <tr>
     <td>
     <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupMsgID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%" OnRowDataBound="GridView1_RowDataBound">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:TemplateField HeaderText="内容" SortExpression="Content">
                        <ItemTemplate>
                          <asp:Image ID="imgnew" runat="server" ImageUrl="icon/new.gif" Visible="false"  />
                              <asp:Label ID="Lblmsgnum" runat="server" Text='<%# Eval("Content").ToString()%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="发送者" SortExpression="msgnum">
                        <ItemTemplate>
                              <asp:Label ID="LblUser" runat="server" Text='<%# Eval("fromuserid").ToString()=="采购方"?"(采购方)"+Eval("aduser").ToString():Eval("fromuserid").ToString()%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                  <asp:BoundField DataField="Crdate" HeaderText="发送时间" SortExpression="Crdate" /> 
                  <asp:BoundField DataField="fromuserid" HeaderText="发送者" SortExpression="fromuserid"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"/>
                  <asp:TemplateField HeaderText="是否已阅" SortExpression="toread" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                        <ItemTemplate>
                            <asp:Label ID="Lblmsgnew" runat="server" Text='<%# Eval("toread").ToString()%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText="查看"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" >
                   <ItemTemplate>
                      <asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Eval("Content").ToString()+","+ Eval("SupMsgID").ToString()%>'   CommandName='<%# Bind("touserid") %>' runat="server" Text="详细内容" CausesValidation="false" OnClick="LinkBtnChange_Click" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">内容</th>
                            <th scope="col">发送者</th>
                            <th scope="col">发送时间</th>
                           
                    </tr>
                         <tr  bgcolor="White">
                      
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                 
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetMsg" TypeName="ddl_cgnew" OldValuesParameterFormatString="original_{0}" >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSupMoneyID" Name="SupMoneyID" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
           
        </asp:ObjectDataSource>
        <asp:HiddenField ID="HFSupMoneyID" runat="server" />
        </td>
     </tr>
     <tr>
     <td align="left">
     <br />
     <br />
     <br />
    <a href="#" onclick="showDetail()" onfocus="this.blur()" id="sdlink" runat="server" visible="false" >&nbsp;<span id="showSpan">4</span>信息详细内容<div id="showDetail" ><asp:Label ID="LblDetail" runat="server" Text="" ></asp:Label></div></a>
     
     <br />
     
         </td>
     </tr>
     <tr>
     <td align="center">
     
     
     </td>
     </tr>
     
     </table>
    <!----contant-end--------------->
    </div>
    </form>
</body>
</html>
