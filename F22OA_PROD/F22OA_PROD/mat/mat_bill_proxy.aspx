<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_proxy, App_Web_mat_bill_proxy.aspx.e229d74d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>店铺报修单</title>
   <link  href="../css/project.css" type="text/css"  rel="stylesheet">
 <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
	<script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>
    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script> 
</head>
<body> 
<form id="form1" runat="server" >
<uc1:uc_pagehead id="Uc_pagehead1" runat="server" /> 
 <asp:ScriptManager ID="ScriptManager1" runat="server">
      </asp:ScriptManager>
<div  class="BContent" >
<table width="100%" > 
 <colgroup>
<col width="100px"/>  <col width="100px" align="left"/> <col width="10px"/><col width="100px" align="left"/><col width="50px"/><col width="260px" align="left"/><col width="50px"/><col width="100px" align="left"/><col style="width:1%;"/>
 </colgroup>  
<tr>
<td>创建时间：</td>
<td><igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"  value="" > </igsch:webdatechooser></td>
<td>到</td>
<td><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" ></igsch:webdatechooser> </td>
<td>种类：</td> 
<td nowrap>
 <asp:UpdatePanel ID="UpdatePanel2" runat="server">
      <ContentTemplate>
   <asp:DropDownList ID="drpType" runat="server" Width="100"  AutoPostBack="true"
         onselectedindexchanged="drpType_SelectedIndexChanged"> </asp:DropDownList>
         &nbsp;&nbsp;&nbsp;&nbsp;品类：
         <asp:DropDownList ID="drpchild" runat="server" Width="100" ><asp:ListItem Value="-1" Text="全部"></asp:ListItem> </asp:DropDownList>
        </ContentTemplate>
        </asp:UpdatePanel>
   </td> 
    <td>状态：</td>
 <td><asp:DropDownList ID="drpState" runat="server"> <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem> 
 <asp:ListItem Text="未上报" Value="0" ></asp:ListItem> <asp:ListItem Text="已上报" Value="1"></asp:ListItem> 
 <asp:ListItem Text="已跟进" Value="2" ></asp:ListItem> <asp:ListItem Text="已退回" Value="3" ></asp:ListItem> 
 <asp:ListItem Text="超期" Value="4" ></asp:ListItem> <asp:ListItem Text="完成" Value="5" ></asp:ListItem> 
 <asp:ListItem Text="费用审核" Value="6" ></asp:ListItem> 
 </asp:DropDownList></td>
 <td></td>
 </tr> 
<tr> 
    <td colspan="9">
    <a id="abtnAdd" runat="server" style="width:100px" href="mat_bill_proxyAdd.aspx"  rel="gb_page_center[500,350]">  <input type="button" id="Button1" runat="server" value="添加" class="btn" />  </a>
      <asp:Button ID="btnchkSure" Width="100px" runat="server" CssClass="btn" Text="上报" OnClick="btnchkSure_Click" />
      <asp:Button ID="btnDel" Width="100px" runat="server" CssClass="btn" Text="删除" OnClick="btnDel_Click" />
        <asp:Button ID="btnDelSure" runat="server" Text="删除上报单据"  CssClass="btn" 
            onclick="btnDelSure_Click"/>
    <a id="aBtnEnd" runat="server" style="width:100px" href="mat_bill_posEnd.aspx"  rel="gb_page_center[330,300]">  
    <input type="button" id="BtnEnd"  runat="server" value="代确认完成" class="btn"  />   </a>   
 
    <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click" />
     &nbsp;筛选条件：&nbsp;&nbsp;
              <asp:DropDownList ID="drps" runat="server"> 
              <asp:ListItem Text="无" Value="-1" Selected="True"></asp:ListItem> 
              <asp:ListItem Text="按店编号" Value="0"></asp:ListItem> 
             <asp:ListItem Text="按店名称" Value="1" ></asp:ListItem>
              <asp:ListItem Text="地区编号" Value="2" ></asp:ListItem> 
              <asp:ListItem Text="大区名称" Value="3" ></asp:ListItem> 
             </asp:DropDownList>
             &nbsp;<input id="txtCondition" runat="server"  />
    </td>
</tr>
<tr>
  <td  colspan="9"> 
     
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
      <input type="hidden" id="txtSort" value="asc" runat="server" />
       <input type="hidden" id="txtSortExpression" value="" runat="server" />
      <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="billid"
          AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
          ForeColor="#333333" GridLines="None" Width="100%" PageSize="15" 
          onpageindexchanged="gv_PageIndexChanged" onrowcommand="gv_RowCommand" 
                        onrowcreated="gv_RowCreated" onrowdeleted="gv_RowDeleted"  onsorting="gv_Sorting"
          onrowdeleting="gv_RowDeleting" onpageindexchanging="gv_PageIndexChanging" 
               onrowdatabound="gv_RowDataBound">
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <Columns >           
             <asp:TemplateField HeaderText="选择" >
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                </HeaderTemplate>
                <ItemTemplate><asp:CheckBox runat="server"   ID="ckbDel" Width="2%" OnCheckedChanged="chk_OnCheckedChanged" AutoPostBack="true"  ToolTip='<%# Eval("billid") %>'  /> </ItemTemplate>
             </asp:TemplateField> 
              <asp:TemplateField HeaderText="图片">
              <ItemTemplate>
               <a href='<%# "imgs/"+Eval("img").ToString() %>'  rel="gb_imageset[site]" target="_blank"><img src='<%# "imgst/"+Eval("img").ToString() %>' style="width:30px;height:20px; border:none;" /></a>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="billid" HeaderText="编号"  />  
              <asp:TemplateField HeaderText="店铺">
              <ItemTemplate>
                  <a style="text-decoration:underline" href='mat_bill_proxyUpd.aspx?id=<%# Eval("billid") %>&chk_sure=<%# Eval("chk_sure") %>'  rel="gb_pageset[seach]"><%# Eval("d_name")%></a>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="typeparentName" HeaderText="种类"  /> 
              <asp:BoundField DataField="typename" HeaderText="品类"  /> 
              <asp:TemplateField  HeaderText="内容" HeaderStyle-Width="60" >
               <ItemTemplate>
               <%# Eval("content").ToString().Length > 10 ? "<marquee  width='60' scrolldelay='300'>" + Eval("content") + "</marquee>" : Eval("content")%>
                </ItemTemplate>
              </asp:TemplateField>  
              <asp:BoundField HeaderText="状态" DataField="state" ItemStyle-Font-Bold="true" />  
              <asp:BoundField DataField="chk_date" HeaderText="报修时间" SortExpression="chk_date" DataFormatString="{0:d}" />   
              <asp:BoundField DataField="fb_date" HeaderText="反馈时间" SortExpression="fb_date" DataFormatString="{0:d}"  /> 
              <asp:TemplateField HeaderText="施工单位"><ItemTemplate>
               <a style="text-decoration:underline" href='mat_org_bw.aspx?id=<%# Eval("orgid")%>'  rel="gb_page_center[500,300]"><%# Eval("name")%></a>
              </ItemTemplate></asp:TemplateField>       
              <asp:BoundField DataField="schemaendDate" HeaderText="计划完成时间" SortExpression="schemaendDate" DataFormatString="{0:d}" HtmlEncode="False" />
              <asp:BoundField DataField="endDate" HeaderText="完工时间" SortExpression="endDate" DataFormatString="{0:d}" HtmlEncode="False" />
           <asp:TemplateField>
            <ItemTemplate>                
            <asp:ImageButton id="btnDel" runat="server" ImageUrl="../icon/delete.gif" CommandName="delete" OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" />
            </ItemTemplate>
            </asp:TemplateField>  
             <asp:TemplateField HeaderText="更改计划" Visible="false">
              <ItemTemplate>  <asp:TextBox   ID="txtschema" runat="server" Text='<%# Eval("ischangeschema").ToString() %>'></asp:TextBox> </ItemTemplate>
              </asp:TemplateField>
          </Columns>
          <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
         <PagerSettings Mode="NumericFirstLast"  FirstPageText="首页" LastPageText="最后" Position="bottom" PageButtonCount="4" />   
           <EmptyDataTemplate>
          <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
	    <tr class="header" >
		<th scope="col"><a href="#">编号</a></th>
		<th scope="col"><a href="#" >店铺</a></th>
		<th scope="col"><a href="#" >品类</a></th>	
		<th scope="col"><a href="#" >内容</a></th>	
		<th scope="col"><a href="#" >状态</a></th>
		<th scope="col"><a href="#" >报修时间</a></th>
		<th scope="col"><a href="#" >反馈时间</a></th>			
    	<th scope="col"><a href="#" >施工单位</a></th>			
		<th scope="col"><a href="#" >计划完成时间</a></th>			
		<th scope="col"><a href="#" >完工时间</a></th>
	  </tr>
      </table>
          </EmptyDataTemplate>
          <EditRowStyle BackColor="#2461BF" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <PagerStyle CssClass="header"  HorizontalAlign="Left" />
          <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
          <AlternatingRowStyle BackColor="White" />
      </asp:GridView>
       </ContentTemplate>
       <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSearch" />
<asp:AsyncPostBackTrigger ControlID="btnchkSure"></asp:AsyncPostBackTrigger>
<asp:AsyncPostBackTrigger ControlID="btnDel"></asp:AsyncPostBackTrigger>
<asp:AsyncPostBackTrigger ControlID="btnchkSure"></asp:AsyncPostBackTrigger>
<asp:AsyncPostBackTrigger ControlID="btnDel"></asp:AsyncPostBackTrigger>
<asp:AsyncPostBackTrigger ControlID="btnchkSure"></asp:AsyncPostBackTrigger>
<asp:AsyncPostBackTrigger ControlID="btnDel"></asp:AsyncPostBackTrigger>
          </Triggers>
       <Triggers><asp:AsyncPostBackTrigger ControlID="btnchkSure" /></Triggers>
       <Triggers><asp:AsyncPostBackTrigger ControlID="btnDel" /></Triggers>
      </asp:UpdatePanel>   
  </td>
</tr>
</table>
     
    </div>
    </form>
</body>
</html>