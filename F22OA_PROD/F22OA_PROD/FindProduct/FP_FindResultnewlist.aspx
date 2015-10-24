<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindResultnewlist, App_Web_fp_findresultnewlist.aspx.a918743" title="Untitled Page" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ OutputCache Duration="3" Location="None" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式调查结果</title>
  <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		       <script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>

    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script>
   <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
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

</script>

</head>
<body> 
    <form id="form1" runat="server">
        <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
         
    <!--head end-->
        <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
      
    <div  class="BContent" >

<table width="100%">
    <tr>
      <td>
      <table width="100%">
        <tr>
           <td align="left" style="height: 25px" colspan="2">
               <asp:Label ID="Label1" runat="server" Text="款式编号:" Width="67px"></asp:Label>
               <asp:TextBox ID="TxtStyleid" runat="server" Width="107px"></asp:TextBox>
               &nbsp; &nbsp;&nbsp; <asp:Label ID="Label2" runat="server" Text="完成率:" Width="47px"></asp:Label>
               <asp:TextBox ID="TxtRateBegin" runat="server" Width="63px"></asp:TextBox> &nbsp; &nbsp;到 &nbsp; &nbsp;
               
               <asp:TextBox
                   ID="TxtRateEnd" runat="server" Width="63px"></asp:TextBox> 
                   <asp:RadioButton ID="RBtnAll" runat="server" Checked="True" Text="全部" GroupName="type" />
                <asp:RadioButton ID="RBtnNoover" runat="server" Text="调查中" GroupName="type" />
               <asp:RadioButton ID="RBtnOver" runat="server" Text="已结束调查" GroupName="type" />
              
               <asp:RadioButton ID="RBtnHaveOver" runat="server" Text="已完成调查" GroupName="type" /></td>
        </tr>
        <tr>
        <td align="right"><asp:RegularExpressionValidator ID="REVvs" runat="server" ErrorMessage="*完成率请输入数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtRateBegin"></asp:RegularExpressionValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*完成率请输入数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtRateEnd"></asp:RegularExpressionValidator>
        </td>
               <td align="right" style="height: 25px">
               <asp:Button ID="BtnSearch" runat="server" Text="查询" Width="100px" OnClick="BtnSearch_Click"  CssClass="btn" />
                  <asp:Button ID="BtnOver" Width="100px" runat="server" Text="结束选项调查" CssClass="btn" OnClick="BttnOver_Click" /> 
                   </td>
        </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td>
          <asp:GridView ID="GridViewStyle" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="WN_styleid"
              AutoGenerateColumns="False" CellPadding="3"   CssClass="tbGrid" CellSpacing="1" 
              ForeColor="#333333" GridLines="None" Width="100%" OnRowDataBound="GridViewStyle_RowDataBound">
              <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <Columns>
                <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" Width="2%" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel" Width="2%" /></ItemTemplate>
                    </asp:TemplateField>
                 
                      <asp:TemplateField HeaderText="款式编号" SortExpression="WN_styleid">
                      <ItemTemplate>
                          <a href='FP_FindResultDetail.aspx?styleid=<%# Eval("havenum")%>&titlecode=<%# Eval("TitleCode") %>&havenum=<%# Eval("nonum")%>&nonum=<%# Eval("WN_styleid")%>' target="_blank"  title='<%# Eval("TitleName") %>'><%# Eval("havenum")%></a>
                      </ItemTemplate>
                  </asp:TemplateField>
                     
                  <asp:BoundField DataField="s_name" HeaderText="款式名称" ReadOnly="True" SortExpression="s_name" />
           
                  <asp:TemplateField HeaderText="参于店铺数"  SortExpression="havenum" HeaderStyle-Width="70px">
                      <ItemTemplate>
                              <a href='FP_Findnochekchshop.aspx?styleid=<%# Eval("havenum")%>&titlecode=<%# Eval("TitleCode") %>&state=1' onclick="return GB_showPage('<%# Eval("havenum")%>调查中已填写调查的店铺', this.href)"　target="_blank"  title='<%# Eval("havenum")%>参于店铺数'><%# Eval("nonum")%> </a>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="未参数" SortExpression="nonum" HeaderStyle-Width="50px">
                      <ItemTemplate>

                              <a href='FP_Findnochekchshop.aspx?styleid=<%# Eval("havenum")%>&titlecode=<%# Eval("TitleCode") %>&state=0' onclick="return GB_showPage('<%# Eval("havenum")%>调查中尚未填写调查的店铺', this.href)" target="_blank"  title='<%# Eval("havenum")%>未参于店铺数'><%# Eval("nonum")%> </a>
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="完成率（%）" SortExpression="rate"  HeaderStyle-Width="50px">
                      <ItemTemplate>
                         <asp:Label ID="LblRate" runat="server" Text='<%# Eval("rate")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                    
                  <asp:TemplateField SortExpression="WN_ovsure" HeaderText="结束" HeaderStyle-Width="40px">
                                    <ItemTemplate>
                                   <asp:CheckBox ID="CheckBoxChkSure" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem,"WN_ovsure").ToString()=="1"?true:false %>' Enabled="false" />                         
                                    </ItemTemplate>
                  </asp:TemplateField>
                 

                 <asp:TemplateField AccessibleHeaderText="结束调查" HeaderText="结束调查" >
                   <ItemTemplate>
                      <asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Eval("havenum")%>' runat="server" Text="结束调查" CausesValidation="false" CommandName='<%# Eval("TitleCode") %>' OnClick="LinkBtnChange_Click" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="分值" SortExpression="score" HeaderStyle-Width="40px">
                      <ItemTemplate>
                         <asp:Label ID="LblSocre" runat="server" Text='<%# Eval("score")%>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                      <asp:TemplateField HeaderText="图表" SortExpression="WN_styleid">
                      <ItemTemplate>
                       <a href="FP_FindResultTitlePic.aspx?styleid=<%# Eval("WN_styleid")%>&titlecode=<%# Eval("TitleCode") %>&stylenum=1&shopnum=1 %>&havenum=<%# Eval("havenum")%>&nonum=<%# Eval("nonum")%>"
                         rel="gb_pageset[search_sites1]" title='<%# Eval("WN_styleid")%>款式图报表'  target="_blank">
                     <img  src="../icon/report.ico"/ width="32" height="32" border="0"></a>
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="款式编号" SortExpression="TitleCode"  >
                      <ItemStyle CssClass="hidden" />
                    <HeaderStyle CssClass="hidden" />
                    <FooterStyle CssClass="hidden" />
                      <ItemTemplate>
                       <asp:Label ID="Lbltitlecode" runat="server" Text='<%# Eval("TitleCode")%>'></asp:Label>
                       
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
              <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
              <EditRowStyle BackColor="#2461BF" />
              <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
              <PagerStyle CssClass="header"  HorizontalAlign="Center" />
              <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
              <AlternatingRowStyle BackColor="White" />
               <EmptyDataTemplate>
              <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
		<tr class="dgHeader" >
			<th scope="col"><a href="#" >款式编号</a></th>
			<th scope="col"><a href="#">款式名称</a></th>
			<th scope="col"><a href="#" >参于店铺数</a></th>
			<th scope="col"><a href="#" >未参与店铺数</a></th>
			<th scope="col"><a href="#" >是否已结束调查</a></th>
			<th scope="col"><a href="#" >结束调查</a></th>
		</tr>
	</table>
              </EmptyDataTemplate>
          </asp:GridView>
       
          <asp:ObjectDataSource ID="ObjectDataSourceStyle" runat="server" SelectMethod="F22_GetNewStyleFind"
              TypeName="ddl_FindProduct">
              <SelectParameters>
                  <asp:Parameter DefaultValue="" Name="WN_styleid" Type="String" />
                  <asp:Parameter DefaultValue="-" Name="type" Type="String" />
                  <asp:Parameter DefaultValue="0" Name="RateBegin" Type="single"/>
                  <asp:Parameter DefaultValue="100" Name="RateEnd" Type="single" />
              </SelectParameters>
          </asp:ObjectDataSource>
  
      </td>
    </tr>
</table>
       
                         
					
				
			


 
    </div>
    </form>
</body>
</html>


