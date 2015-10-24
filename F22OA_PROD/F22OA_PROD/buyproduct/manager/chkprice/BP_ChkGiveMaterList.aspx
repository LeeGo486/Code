<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_chkprice_BP_ChkGiveMater, App_Web_bp_chkgivematerlist.aspx.68adc8a" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购发布申请审核</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
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
 function config() 
        { 
        		var id=	window.document.getElementById("LbMaterlNoNum").innerText;
        		 
		        if (id!="" && id!=undefined)
		        {
		            if(id!="0")
		            {
		              question = confirm("还有数量没有分配完，审核之后不可再分配，你确认要审核吗!");
		              // window.alert(question);
		              if(question)
		              {
		                return true;
		              }
		              else
		              {
		                return false;
		              }
		            
		            }
		            else
		            {
		               question = confirm("审核之后不可再分配，你确认要审核吗!");
		              // window.alert(question);
		              if(question)
		              {
		                return true;
		              }
		              else
		              {
		                return false;
		              }
		            }
		        }
		        
        }
        function GoUrlShowGiveNum(pmid,pid,mid,cannum,spid) 
        { 
        
               var url="BP_ChkGiveMaterNum.aspx?SupMoneyID="+pmid+"&pid="+pid+"&mid="+mid+"&cannum="+cannum+"&spid="+spid;
	            LoadWindow(url,860,653);
	            // document.forms[0].submit();
	     }
	     function GoUrlAddMsg(smid,spid,spno) 
        { 
        
               var url="BP_ChkMsgWrite.aspx?smid="+smid+"&spid="+spid+"&spno="+spno;
	            LoadWindow(url,560,353);
	          
	     }
</script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">分配物料</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->

    <table  width="98%">
    <tr>
    <td align="right">
    <div class="menu">
         <asp:Button ID="BtnGo" Width="100px" runat="server" Text="返回待审报价" CssClass="btn"   OnClientClick="window.location.href='BP_ChkPricelist.aspx'; return false;"   />
        <asp:Button ID="BtnCheck" runat="server" Width="100" Text="审核报价" CssClass="btn" OnClick="BtnCheck_Click"  OnClientClick ="return config()" />
        <asp:Button ID="BtnDel" runat="server" Width="100" Text="打回所选项" CssClass="btn" OnClick="btnDel_Click" />
         
     </div>  
        </td> 
    </tr>
    </table>
    	<!--head end-->
        
    <div  class="BContent">
     <!----contant------------------>
      <asp:HiddenField ID="HFPublishCode" runat="server" />
          <asp:HiddenField ID="HFMaterID" runat="server" />
    <table width="100%">
    <tr>
        <td>
        
        </td>
    </tr>
  
    <tr>
        <td>
        <table >
          
        <tr>
        <td>已分供应商数:</td>
        <td>
            <asp:Label ID="LblHaveSperNum" runat="server" ForeColor="Red"></asp:Label>,</td>
        <td>已分量:</td>
        <td><asp:Label ID="LblMaterHaveNum" runat="server" ForeColor="Red"></asp:Label>,</td>
        <td>未分配量:</td>
        <td><asp:Label ID="LbMaterlNoNum" runat="server" ForeColor="Red"></asp:Label></td>
         <td>
        (<a href="BP_MaterDetail.aspx?pid=<%= HFPublishCode.Value.ToString()%>&mid=<%=HFMaterID.Value.ToString()  %>" onclick="return GB_showPage('物料明细', this.href)">查看物料</a>)
        </td>
        </tr>
        </table>
        </td>
    </tr>
      <tr>
    <td style="height: 16px"><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td style="height: 16px"><asp:Label ID="LblTitleBuyInfo" runat="server" Text=""></asp:Label></td>
    </tr>
    
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupMoneyID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="False" />
                      <asp:TemplateField HeaderText="供应商" SortExpression="SupplyNo">
                        <ItemTemplate>
                            <a href="../basic/BP_BSSupplyerDetail.aspx?LoginID=<%# Eval("SupplyerID") %>&SupplyNo=" rel="gb_pageset[search_sites]" title='供应商明细' ><img src="../../../icon/go3.gif" border="0" /><%#Eval("SupplyNo")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Sprice" HeaderText="单价" SortExpression="Sprice" />
                    <asp:BoundField DataField="Tax" HeaderText="税率(%)" SortExpression="Tax" />
                    <asp:BoundField DataField="Suplimitnum" HeaderText="起订量" SortExpression="Suplimitnum" />
                    <asp:BoundField DataField="Supmodeldate" HeaderText="到样期" SortExpression="Supmodeldate"  DataFormatString="{0:d}" HtmlEncode="False" />
                    <asp:BoundField DataField="Supgivealldate" HeaderText="到货期" SortExpression="Supgivealldate" DataFormatString="{0:d}" HtmlEncode="False" />
                    <asp:BoundField DataField="Wegivenum" HeaderText="分配量" SortExpression="Wegivenum" />
                   
                    <asp:TemplateField HeaderText="状态" SortExpression="Backstate">
                   
                        <ItemTemplate>
                            <asp:Label ID="LabelState" runat="server" Text='<%# Eval("Backstate").ToString()=="True"?"打回":"正常"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="信息" SortExpression="msgnum">
                   
                        <ItemTemplate><img src="../../../icon/go3.gif" border="0" />
                          <a href="BP_ChkMsgList.aspx?SupMoneyID=<%# Eval("SupMoneyID") %>" rel="gb_pageset[search_sites1]" title='' >
                          <asp:Image ID="imgnew" runat="server" ImageUrl="../../../icon/new.gif"  />
                         
                            <asp:Label ID="Lblmsgnew" runat="server" Text='<%# Eval("newmsg").ToString()=="0"?"":"("+Eval("newmsg").ToString()+")/"%>'></asp:Label>
                              <asp:Label ID="Lblmsgnum" runat="server" Text='<%# Eval("msgnum")%>'></asp:Label>
                              </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                         <asp:TemplateField HeaderText="留言">
                        <ItemTemplate>
                        <img src="../../../icon/go3.gif" border="0" />
                         <asp:LinkButton ID="lbtnMsg" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# AddMsg(Eval("SupMoneyID").ToString(),Eval("SupplyerID").ToString(),Eval("SupplyNo").ToString()) %>'
                        CommandName="Check" Text='留言' >
                         </asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="报价" SortExpression="MaterID">
                        <ItemTemplate>
                            <a href="../chkprice/BP_MaterDetailPrice.aspx?pid=<%#Eval("PublishID") %>&mid=<%#Eval("MaterID") %>&spid=<%#Eval("SupplyerID") %>&SupMoneyID=<%#Eval("SupMoneyID") %>"  rel="gb_pageset[search_sites2]"  >  <img src="../../../icon/go3.gif" border="0" />详细</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="分配">
                        <ItemTemplate>
                        <img src="../../../icon/go3.gif" border="0" />
                         <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# GivMaterNum(Eval("SupMoneyID").ToString(),Eval("PublishID").ToString(),Eval("MaterID").ToString(),LbMaterlNoNum.Text.ToString(),Eval("Wegivenum").ToString(),Eval("SupplyerID").ToString()) %>'
                        CommandName="Check" Text='分配' >
                         </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">供应商</th>
                            <th scope="col">单价</th>
                            <th scope="col">税率</th>
                            <th scope="col">起订量</th>
                            <th scope="col">到样期</th>
                            <th scope="col">分配量</th>
                            <th scope="col">到货时间</th>
                    </tr>
                         <tr  bgcolor="White">
                      <th scope="col"></th>
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
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetChkMaterPiceList" TypeName="ddl_cgnew"  >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFPublishCode" Name="PublishID" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="HFMaterID" Name="MaterID" PropertyName="Value" Type="String" />
            </SelectParameters>
           
        </asp:ObjectDataSource>
    </td>
    </tr>
        <tr>
    <td>
    <table width="100%">

        <tr>
    <td valign="top">
        &nbsp;
    
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

