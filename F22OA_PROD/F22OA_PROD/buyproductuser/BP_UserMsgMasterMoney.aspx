<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserMsgMasterMoney, App_Web_bp_usermsgmastermoney.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布物料</title>
    <base target="_self" />
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
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
  
    </script>
</head>
<body  topmargin="100" leftmargin="100">
    <form id="form1" runat="server">
           <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">信息列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
   
    <div class="BContent"  style="height:100%; padding-left:50px; padding-right:50px; padding-top:5px" >
     <!----contant------------------>
    <table width="100%">
         <tr>
     <td>
          <!----contant------------------>
     <table width="100%">
     <tr>
     <td align="center">
         <asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></td>
     </tr>
     <tr>
     <td style="height: 68px">
         <asp:TextBox ID="TxtContent" runat="server" CssClass="tbox" Width="98%" MaxLength="5000" TextMode="MultiLine" Height="120px"></asp:TextBox>
         </td>
     </tr>
     <tr>
     <td align="center"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtContent"
        ErrorMessage="*信息内容不能为空" ValidationGroup="add"></asp:RequiredFieldValidator><asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
        
          <asp:HiddenField ID="HFSupplyerID" runat="server" />
       </td>
     </tr>
    <tr>
    <td align="center">    <asp:Button ID="BtnSubmit" runat="Server"  Text="提交"   CssClass="btn"  Width="100px" OnClick="BtnSubmit_Click" /> </td>
    </tr>
    <tr>
    <td align="center">
    <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label>
    </td>
    </tr>
     </table>
     <!----contant end---------------->
     </td>
     </tr>
   <tr>
   <td>
   <!----contant------------------>
     <table width="100%">
     <tr>
     <td>
     <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupMsgID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%" >
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
     
         </td>
     </tr>
     <tr>
     <td align="center">
     
     
     </td>
     </tr>
     
     </table>
    <!----contant-end--------------->
   </td>
   </tr>
    <tr>
    <td align="center">
        
                 <asp:HiddenField ID="HFPublishCode" runat="server" />
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
         
            <asp:Label ID="LblMatergetdate" runat="server" Text=""></asp:Label></td>
            <td style="width: 10px">
            </td>
             
        </tr> 
                  <tr>
        <td  >
            到货时间:</td>
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
         
           <asp:Label ID="LblPrice" runat="server" Text=""></asp:Label>
              </td>
            <td style="width: 10px">
            </td>
                 <td colspan="2" rowspan="10">
                         
           
            <asp:Image  ID="ImgNewSup" ImageUrl="images/nophoto.gif" runat="server"  Height="150px" Width="170px" /></td>
             
        </tr>  
        <tr>
        <td>
        税率(%):</td>
        <td>
                 
                   <asp:Label ID="LblRateNum" runat="server" Text=""></asp:Label>
        </td>
        <td style="width: 10px"></td>
        </tr>
          <tr>
        <td>
            起订量:</td>
        <td>
           
             <asp:Label ID="LblLiminitNum" runat="server" Text=""></asp:Label>
        </td>
        <td style="width: 10px"></td>
        </tr>
        <tr>
        <td >
           可到货时间:</td>
        <td >
        <asp:Label ID="LblSupGetMaterDate" runat="server" Text=""></asp:Label></td>
        <td style="width: 10px" >
            &nbsp;</td>
        </tr>
         <tr>
        <td >
            可到样时间:</td>
        <td >
            <asp:Label ID="LblSupModleGetDate" runat="server" Text=""></asp:Label></td>
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
        </td>
        <td style="height: 16px" colspan="4" >
         </td>
        </tr>
           <tr>
        <td style="height: 16px; " >
            备注:</td>
        <td style="height: 16px" colspan="4" >
            
              <asp:Label ID="LblSupCommet" runat="server" Text=""></asp:Label>
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


