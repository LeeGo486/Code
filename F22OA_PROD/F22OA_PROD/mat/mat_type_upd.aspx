<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_type_upd, App_Web_mat_type_upd.aspx.e229d74d" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>添加店铺施工单位</title>
      <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
   <table  width="98%">
    <tr>   
        <td align="right">
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTypeName" ErrorMessage="请输入类别名称"></asp:RequiredFieldValidator>
       &nbsp;&nbsp;
       <asp:Button ID="BtnSave"  runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />
        <input id="btnBack" type="button" class="btn" onclick="javascript:window.location.href='mat_type.aspx';" value="返回" />
        <script language="javascript" type="text/javascript">
		    var vh=window.parent.location.href;
	          if(vh.indexOf('loader_frame')>-1)  document.getElementById('btnBack').style.display='none';
	        else  document.getElementById('btnBack').style.display='';
		</script>
        </td>
    </tr>
    </table>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>  
 <table width="98%">
     <colgroup>
        <col  width="60" />
        <col  align="left"  width="100" />   
        <col  width="60" />
        <col  align="left"  width="100" />            
    </colgroup>   
    <tr>
    <td class="ltd" >编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td> <input id="txtTypeid" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    <td class="ltd" > 类别名称:</td>
    <td >
        <input id="txtTypeName" runat="server" class="tbox" style="width:99%;" />  
    </td>
    </tr> 
   <tr>
    <td class="ltd">审 核 人:</td>
    <td> <input id="txtchk_name" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    <td class="ltd"  > 审核时间:</td>
    <td> <input id="txtchk_date" runat="server" class="tbox" readonly="readonly" style="width:99%;" />  </td>
   </tr>      
   <tr>
    <td class="ltd">创 建 人:</td>
    <td> <input id="txtcrname" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    <td class="ltd"  > 创建时间:</td>
    <td> <input id="txtcrdate" runat="server" class="tbox" readonly="readonly" style="width:99%;" />  </td>
   </tr>   
    <tr>
    <td class="ltd">审 核:</td>
    <td> <input id="txtchk_sure" runat="server" class="tbox" readonly="readonly" style="width:99%;" /> </td>
    <td class="ltd"  > </td>
    <td> </td>
   </tr>   
   <tr>
    <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
    <td colspan="3"><textarea id="txtComment" runat="server" class="tbox" style="width:99%; "></textarea></td>      
   </tr> 
   <tr>
   <td colspan="4">
    <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="typeid"
      AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
      ForeColor="#333333" GridLines="None" Width="97%" PageSize="10" 
      OnRowCommand="gv_RowCommand"
    OnPageIndexChanging="gv_PageIndexChanging" 
    OnRowCancelingEdit="gv_RowCancelingEdit" 
    OnRowCreated="gv_RowCreated" OnRowDeleted="gv_RowDeleted" 
    OnRowDeleting="gv_RowDeleting" OnRowEditing="gv_RowEditing" 
    OnRowUpdated="gv_RowUpdated" OnRowUpdating="gv_RowUpdating" 
     >
      <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
      <Columns>                
           <asp:BoundField DataField="typeid" HeaderText="编号" ReadOnly="true"/>
           <asp:TemplateField HeaderText="品类">
	        <ItemTemplate>  <span ><%# Eval("typename").ToString()%></span> </ItemTemplate>
            <EditItemTemplate>
            <asp:TextBox ID="txttypename" runat="server" Text='<%# Eval("typename")%>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rv1" runat="server" ControlToValidate="txttypename" ErrorMessage="*" ValidationGroup="upd"></asp:RequiredFieldValidator>
            </EditItemTemplate>
	        </asp:TemplateField>	
	        <asp:TemplateField HeaderText="备注">
	        <ItemTemplate>  <span ><%# Eval("comment").ToString()%></span> </ItemTemplate>
            <EditItemTemplate>
            <asp:TextBox ID="txtcomment" runat="server" Text='<%# Eval("comment")%>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="rv3" runat="server" ControlToValidate="txtcomment" ErrorMessage="*" ValidationGroup="upd"></asp:RequiredFieldValidator>
            </EditItemTemplate>
	        </asp:TemplateField>	
             <asp:TemplateField HeaderText="审核">
                  <ItemTemplate> <asp:Label  id="lblchk_sure" runat="server" Text=' <%# Eval("chk_sure").ToString() == "1" ? "是" : "否" %> '></asp:label>
                 </ItemTemplate>
              </asp:TemplateField>   	  
            <asp:BoundField DataField="chk_date" HeaderText="审核时间" ReadOnly="true"  DataFormatString="{0:d}" />
	        <asp:BoundField DataField="chk_name" HeaderText="审核人" ReadOnly="true" />
	        <asp:BoundField DataField="crname" HeaderText="创建人" ReadOnly="true" />
	        <asp:BoundField DataField="parentid" HeaderText="种类编号" ReadOnly="true" />
	        <asp:BoundField DataField="parentname" HeaderText="种类名称" ReadOnly="true" />	     
        <asp:CommandField HeaderText="修改" CancelText="取消" UpdateText="更新" EditText="编辑" CausesValidation="true" ValidationGroup="upd" ShowCancelButton="true" ShowEditButton="true" />
       <asp:TemplateField>
        <ItemTemplate>                
        <asp:ImageButton id="btnDel" runat="server" ImageUrl="../icon/delete.gif" CommandName="delete" CausesValidation="False" />
        </ItemTemplate>
        </asp:TemplateField>  
      </Columns>
      <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
     <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
       <EmptyDataTemplate>
      <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
    <tr class="header" >
    <th scope="col"><a href="#" >编号</a></th>
    <th scope="col"><a href="#">品类</a></th>
    <th scope="col"><a href="#" >备注</a></th>	
	<th scope="col"><a href="#" >审核</a></th>	
	<th scope="col"><a href="#" >审核时间</a></th>	
	<th scope="col"><a href="#" >审核人</a></th>	
    <th scope="col"><a href="#" >创建时间</a></th>
    <th scope="col"><a href="#" >创建人</a></th>	
    <th scope="col"><a href="#" >种类编号</a></th>
    <th scope="col"><a href="#" >种类名称</a></th>	
  </tr>
  </table>
      </EmptyDataTemplate>
      <EditRowStyle BackColor="#2461BF" />
      <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
      <PagerStyle CssClass="header"  HorizontalAlign="Left" />
      <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
      <AlternatingRowStyle BackColor="White" />
  </asp:GridView>
   </td>
   </tr>  
  </table>
  </ContentTemplate>
  <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSave" /></Triggers>
    </asp:UpdatePanel>
</form>
</body>
</html>
