<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_filelistmgr, App_Web_filelistmgr.aspx.9ee944ed" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>文档管理列表</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <link href="../inquire/scripts/project.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function lookfile(fileid){
       var m=showModalDialog("filedetail.aspx?fileid="+fileid,"lookfile","scroll:no;status:no;help:no;resizable:no;center:yes;dialogWidth:700px;dialogHeight:330px;");
    }
    </script>
</head>
<body>

    <form id="form2" runat="server" >
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="5">
        <tr>
            <td style="text-align: center; ">
                 <table border="0" cellpadding="0" cellspacing="5">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkcd" runat="server" Text="创建日期：" /></td>
                        <td>
                            <igsch:WebDateChooser
                    ID="WebDateChooser1" runat="server" Value="" Width="80px">
                    <CalendarLayout CellPadding="0" NextMonthImageUrl="ig_tab_scrollXP3.gif" PrevMonthImageUrl="ig_tab_scrollXP2.gif"
                        ShowFooter="False" ShowMonthDropDown="False" ShowYearDropDown="False" ChangeMonthToDateClicked="True">
                        <CalendarStyle BackColor="White" BorderColor="LightSlateGray" BorderStyle="Solid"
                            Font-Bold="False" Font-Italic="False" Font-Names="Tahoma,Verdana" Font-Overline="False"
                            Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" Width="180px">
                        </CalendarStyle>
                        <DayHeaderStyle BackColor="SteelBlue" Font-Bold="False" ForeColor="White">
                            <BorderDetails ColorBottom="172, 168, 153" StyleBottom="Solid" WidthBottom="1px" />
                        </DayHeaderStyle>
                        <OtherMonthDayStyle ForeColor="#ACA899" />
                        <SelectedDayStyle BackColor="Gold" ForeColor="Black" />
                        <TitleStyle BackColor="PowderBlue" Font-Bold="True" Font-Size="12px" />
                        <TodayDayStyle BackColor="#FBE694" />
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser2" runat="server" Value="" Width="80px">
                    <CalendarLayout CellPadding="0" NextMonthImageUrl="ig_tab_scrollXP3.gif" PrevMonthImageUrl="ig_tab_scrollXP2.gif"
                        ShowFooter="False" ShowMonthDropDown="False" ShowYearDropDown="False">
                        <CalendarStyle BackColor="White" BorderColor="LightSlateGray" BorderStyle="Solid"
                            Font-Bold="False" Font-Italic="False" Font-Names="Tahoma,Verdana" Font-Overline="False"
                            Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" Width="180px">
                        </CalendarStyle>
                        <DayHeaderStyle BackColor="SteelBlue" Font-Bold="False" ForeColor="White">
                            <BorderDetails ColorBottom="172, 168, 153" StyleBottom="Solid" WidthBottom="1px" />
                        </DayHeaderStyle>
                        <OtherMonthDayStyle ForeColor="#ACA899" />
                        <SelectedDayStyle BackColor="Gold" ForeColor="Black" />
                        <TitleStyle BackColor="PowderBlue" Font-Bold="True" Font-Size="12px" />
                        <TodayDayStyle BackColor="#FBE694" />
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chksd" runat="server" Text="审核日期：" /></td>
                        <td>
                            <igsch:WebDateChooser
                    ID="WebDateChooser3" runat="server" Value="" Width="80px">
                    <CalendarLayout CellPadding="0" NextMonthImageUrl="ig_tab_scrollXP3.gif" PrevMonthImageUrl="ig_tab_scrollXP2.gif"
                        ShowFooter="False" ShowMonthDropDown="False" ShowYearDropDown="False" ChangeMonthToDateClicked="True">
                        <CalendarStyle BackColor="White" BorderColor="LightSlateGray" BorderStyle="Solid"
                            Font-Bold="False" Font-Italic="False" Font-Names="Tahoma,Verdana" Font-Overline="False"
                            Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" Width="180px">
                        </CalendarStyle>
                        <DayHeaderStyle BackColor="SteelBlue" Font-Bold="False" ForeColor="White">
                            <BorderDetails ColorBottom="172, 168, 153" StyleBottom="Solid" WidthBottom="1px" />
                        </DayHeaderStyle>
                        <OtherMonthDayStyle ForeColor="#ACA899" />
                        <SelectedDayStyle BackColor="Gold" ForeColor="Black" />
                        <TitleStyle BackColor="PowderBlue" Font-Bold="True" Font-Size="12px" />
                        <TodayDayStyle BackColor="#FBE694" />
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser4" runat="server" Value="" Width="80px">
                    <CalendarLayout CellPadding="0" NextMonthImageUrl="ig_tab_scrollXP3.gif" PrevMonthImageUrl="ig_tab_scrollXP2.gif"
                        ShowFooter="False" ShowMonthDropDown="False" ShowYearDropDown="False">
                        <CalendarStyle BackColor="White" BorderColor="LightSlateGray" BorderStyle="Solid"
                            Font-Bold="False" Font-Italic="False" Font-Names="Tahoma,Verdana" Font-Overline="False"
                            Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" Width="180px">
                        </CalendarStyle>
                        <DayHeaderStyle BackColor="SteelBlue" Font-Bold="False" ForeColor="White">
                            <BorderDetails ColorBottom="172, 168, 153" StyleBottom="Solid" WidthBottom="1px" />
                        </DayHeaderStyle>
                        <OtherMonthDayStyle ForeColor="#ACA899" />
                        <SelectedDayStyle BackColor="Gold" ForeColor="Black" />
                        <TitleStyle BackColor="PowderBlue" Font-Bold="True" Font-Size="12px" />
                        <TodayDayStyle BackColor="#FBE694" />
                    </CalendarLayout>
                </igsch:WebDateChooser>
                        </td>
                    </tr>
                </table>

                <table border="0" cellpadding="0" cellspacing="5">
                    <tr>

                        <td><asp:TextBox ID="TextBox1" runat="server" Width="100px"></asp:TextBox></td>
                        <td>
                <asp:DropDownList ID="filetype" runat="server">
                </asp:DropDownList>
                        </td>
                        <td>
                <asp:DropDownList ID="chktype" runat="server">
                    <asp:ListItem Value="-1"> -- 状态 --</asp:ListItem> <asp:ListItem Value="0">未审核</asp:ListItem>
                    <asp:ListItem Value="1">审核通过</asp:ListItem>
                </asp:DropDownList>
                            <asp:DropDownList ID="Softbyfield" runat="server">
                                <asp:ListItem Value="fileid">按ID排序</asp:ListItem>
                                <asp:ListItem Value="tname">按类型排序</asp:ListItem>
                                <asp:ListItem Value="fname">按名称排序</asp:ListItem>
                                <asp:ListItem Value="crname">按创建人排序</asp:ListItem>
                                <asp:ListItem Value="crdate">按创建日期排序</asp:ListItem>
                                <asp:ListItem Value="surename">按审核人排序</asp:ListItem>
                                <asp:ListItem Value="suredate">按审核日期排序</asp:ListItem>
                                <asp:ListItem Value="filestate">按状态排序</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CheckBox ID="todesc" runat="server" Text="降序" Checked="true" />
                        </td>
                        <td><asp:Button ID="Button2" runat="server" CssClass="btn" Text="查　询" OnClick="Button2_Click"
                         OnClientClick="document.getElementById('HiddenField1').value=1" /></td>
                    </tr>
                    </table>

            </td>
        </tr>
        </table>
<div style="text-align:center;"><asp:Label ID="Label2" runat="server" Width="100%" ForeColor="Red"></asp:Label></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="5">

  <tr>
    <td>
      <asp:DataList ID="DataList1" runat="server" Width="98%" CellPadding="4" ForeColor="#333333" HorizontalAlign="Center"
       CssClass="datalist"  OnItemDataBound="DataList1_ItemDataBound">
       <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
<%--头模板--%>
        <HeaderTemplate>
        <div style="width:6%;">
            <span style="color:White;">ID</span>
        </div>
        <div style="width:8%;">
            <span style="color:White;">文档类型</span>
        </div>
        <div style="width:20%;">
            <span style="color:White;">文档名称</span>
        </div>
        <div style="width:8%;">
            <span style="color:White;">店铺编号</span>
        </div>
        <div style="width:8%;">
            <span style="color:White;">店铺名称</span>
        </div>
        <div style="width:8%;">
            <span style="color:White;">创建人</span>
        </div>
        <div style="width:10%;">
            <span style="color:White;">创建日期</span>
        </div>
        <div style="width:8%;">
           <span style="color:White;">审核人</span>
        </div>
        <div style="width:10%;">
            <span style="color:White;">审核日期</span>
        </div>
        <div style="width:8%;">
            <span style="color:White;">状态 </span>
        </div>
        <div style="width:6%;">
        <b>操作</b>
        </div>
        </HeaderTemplate>
        
<%--项模板--%>
        <ItemTemplate>
        <div style="width:6%;">
        <%#Eval("fileid") %>　
        </div>
        <div style="width:8%;">
        <%# Eval("tname") %>
        </div>
        <div style="width:20%;text-align:left;">
        <a href="../file/openfile.aspx?url=<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.fileurl")) %>" target"_blank"><%# Eval("fname") %></a>
        </div>
        <div style="width:8%;">
        <%# Eval("depotid") %>
        </div>
        <div style="width:8%;">
        <%# Eval("d_name")%>
        </div>
        <div style="width:8%;">
        <%# Eval("crname")%>
        </div>
        <div style="width:10%;">
        <%# Eval("crdate") %>
        </div>
        <div style="width:8%;">
        <%# Eval("surename") %>
        </div>
        <div style="width:10%;">
        <%# Eval("suredate") %>
        </div>
        <div style="width:8%;">
        <%# getState(Int16.Parse(Eval("filestate").ToString()))%>
        </div>
        <div style="width:6%;">
        <a href="javascript:;" onclick='javascript:lookfile("<%#Eval("fileid") %>")'>查看</a>
             <%--<asp:LinkButton ID="config1" runat="server" CommandName="edit" ToolTip="审核后不允许编辑" Enabled='<%# s2b(Int16.Parse(Eval("filestate").ToString()),0)%>'>编辑</asp:LinkButton>
             <asp:LinkButton ID="config2" runat="server" CommandName="delete" OnClientClick="return confirm('是否删除该文档?')">删除</asp:LinkButton>--%>
        </div>
        <%# setRemark(Eval("crrmk").ToString()) %>
        </ItemTemplate>
        
<%--编辑状态--%>
        <%--<EditItemTemplate>
        <div style="width:6%;">
        <%#Eval("fileid") %>　
        </div>
        <div style="width:8%;">
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
            <asp:HiddenField ID="typeid" runat="server" Value='<%# Eval("typeid") %>' />
        </div>
        <div style="width:32%;text-align:left;">
            <asp:TextBox ID="TextBox2" runat="server" MaxLength="100"  Width="98%" Text='<%# Eval("fname") %>'></asp:TextBox>
        </div>
            
        <div style="width:8%;">
        <%# Eval("crname") %>
        </div>
        <div style="width:10%;">
        <%# Eval("crdate") %>
        </div>
        <div style="width:8%;">
        <%# Eval("surename") %>
        </div>
        <div style="width:10%;">
            <%# Eval("suredate") %>
        </div>
        <div style="width:8%;">
            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# s2b(Int16.Parse(Eval("filestate").ToString()),1)%>' Enabled='<%# s2b(Int16.Parse(Eval("filestate").ToString()),0)%>' Text="审核" />
        </div>
        <div style="width:10%;">
             <asp:LinkButton ID="config3" runat="server" CommandName="update">更新</asp:LinkButton>
             <asp:LinkButton ID="config4" runat="server" CommandName="cancel">取消</asp:LinkButton>
        </div>
        <span style="padding-left:14%;color:#bbb;display:block;width:100%;"><b>备注：</b><asp:TextBox
            ID="crrmk" runat="server" MaxLength="255" Text='<%# Eval("crrmk") %>' Width="60%" ></asp:TextBox></span>
        </EditItemTemplate>--%>
        <FooterTemplate>
        
        </FooterTemplate>
           <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
           <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
           <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
           <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DataList>
        </td>
  </tr>
      <tr>
    <td style="height:20px;">
        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton4" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton5" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton6" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton7" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton8" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton9" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton10" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton11" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton12" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton13" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton14" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton15" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton16" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton17" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton18" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton19" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton20" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton21" runat="server" OnClick="PageNum_Click"></asp:LinkButton>
            <asp:HiddenField ID="HiddenField1" runat="server" Value="1" />
        </asp:Panel>
        </td>
  </tr></table>

</div>
    </form>
</body>
</html>