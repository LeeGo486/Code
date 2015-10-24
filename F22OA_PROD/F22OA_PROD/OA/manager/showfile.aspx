<%@ page language="C#" autoeventwireup="true" inherits="manager_showfile, App_Web_showfile.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>图片选择、浏览</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
		<base target="_self">
		<SCRIPT language="JavaScript"  type="text/javascript">
		
		function r(){
			window.returnValue =document.all.hdPath.value
			//window.alert(document.all.tb.value)
			//window.close();
		}
	function onSubmit()
    {
        document.Form1.target="_self";
    }
    function c(){
		window.close();
    }
    
    function SelectAll (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
//==============================================================================
 function SelectAll1 (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll1') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
        
		</SCRIPT>
</head>
<body  onunload="r()" topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div> <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <br />
			<table align="center" width="100%">
		
				<tr>
					<td>
						<asp:datagrid id="dg" runat="server" GridLines="None" ToolTip="" CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="ID">
									<ItemTemplate>
										<asp:Label ID="lbid" Runat=server text='<%# DataBinder.Eval(Container, "DataItem.fileid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="上传文件名">
									<ItemTemplate>
									
									
										<a href='../isprit/Module/openfile.aspx?url=../../file/<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.filename")) %>' target=_blank >
											<asp:label ID=lbfile Runat=server text='<%# DataBinder.Eval(Container, "DataItem.filename") %>'>
											</asp:label>
										</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="文件注释">
									<ItemTemplate>
										<asp:Label runat="server" ID="lbpic" text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="tbpic" MaxLength=40 Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' CssClass=textbox runat="server">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" CancelText="取消" EditText="编辑名称"></asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:imagebutton ID="imgDel" Runat="server" CausesValidation="False" ImageUrl="../icon/delete.gif" CommandName="delete"></asp:imagebutton>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
									<HeaderTemplate>
										<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="cb" runat="server" BorderColor="Silver" BorderWidth="0px"></asp:CheckBox>
									</ItemTemplate>
									<FooterTemplate>
										<asp:CheckBox id="chkAll" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</FooterTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></pagerStyle>
						</asp:datagrid></td>
				</tr>
				<tr>
					<td align="left">
							<webdiyer:AspNetpager id="ap" runat="server" ShowInputBox="Always" SubmitButtonText="转到" SubmitButtonStyle="bt"
								SubmitButtonClass="bt" PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
                        
						</td>
				</tr>
				<tr>
				<td align="left"><asp:Button id="btdel" accessKey="d" runat="server" Text="删除选定的行(D)" CssClass="btr" OnClick="btdel_Click"></asp:Button><A  href="javascript:history.go(-1)">返回</A></td>
				</tr>
			</table>
			<BR>
			<input id="hdPath" type="hidden" name="hdPath" runat="server">
    </div>
    </form>
</body>
</html>
