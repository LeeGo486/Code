<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlanTel_add, App_Web_vip_msgplantel_add.aspx.e229d74e" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		<script language="javascript" type="text/javascript">
		
		function fMsgPlan(url,w,h){
		  var vreturn= fShowDlg(url,w,h);
		   if( typeof(vreturn)!='undefined'&& typeof(vreturn)!='null'){ 
              var vid=document.getElementById("txtMsgPlanid");
               var vTitle=document.getElementById("lblTitle");
		      vid.innerText=vreturn.split('|')[1];
		      vTitle.innerText=vreturn.split('|')[0];
		      var vid1=document.getElementById("hidPlanid");
		      var vTitle1=document.getElementById("hidPlanName");
		      vid1.value=vreturn.split('|')[0];
		      vTitle1.value=vreturn.split('|')[1];
		   return true;
		   }
		   else return false;
		}
		// VIP及电话
		function fVipTel(url,w,h){
		     var vreturn=fShowDlg(url,w,h);
		     if( typeof(vreturn)!='undefined'&& typeof(vreturn)!='null'&&vreturn=='ok')
    		      return true;
    		 else return false;
		}
		function fShowDlg(url,w,h){ 
		  var vreturn=window.showModalDialog(url,"弹出窗口","height:"+h+"px;width:"+w+"px;toolbar:no;menubar:no;location:no;center:yes;resizable:no;status:no;scroll:no;help:no;");
		  return vreturn;
		}
		</script>
</head>
<body    style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <input type="hidden" id="hidPlanid" runat="server" /> <input type="hidden" id="hidPlanName" runat="server"/>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                    
    <!--head end-->
    <!--menu----->
    
   <table  width="98%"  >
    <tr>
    <td align="right">   
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />      
        </td>
    </tr>
    </table>
    <!--menu-----> 
   
    <!----contant------------------>
    <table width="98%"  >   
    <tr>
    <td align="left">
        <table  width="100%"  >
         <colgroup>
           <col  width="15%" /><col  width="80%" />              
        </colgroup>
        <tr>
        <td class="ltd"> 方案:</td>
        <td align="left" nowrap>
              <input id="txtMsgPlanid" runat="server" class="tbox" style="width:300px"  readonly="readonly" />
             <input id="btnPlan"  type="button" class="btn" value="选择"  onclick="javascript:if(fMsgPlan('vip_msgPlanDlg.aspx',700,500)){return true;} else{return false;}" /> 
             <asp:Label ID="lblTitle" runat="server"></asp:Label>
              &nbsp;
              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtMsgPlanid" ErrorMessage="*"></asp:RequiredFieldValidator>
        </td>
        </tr>
        <tr>
        <td class="ltd">发送时间:</td>
        <td >   
         <div style="white-space:nowrap; width:180px;float:left;">  
         <asp:RadioButton ID="radDate1" runat="server" OnCheckedChanged="rad1_OnServer"  Text="立即发送" Checked="true" CausesValidation="false" AutoPostBack="true" />
        <asp:RadioButton ID="radDate2" runat="server" OnCheckedChanged="rad2_OnServer"  Text="设置时间" CausesValidation="false" AutoPostBack="true" />  
        </div>
          <div style="white-space:nowrap;float:left;">    
           <span id="spanDate" style="white-space:nowrap;" visible="false" runat="server"> 
             <table><tr><td>              
            <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"  value="" width="100"> </igsch:webdatechooser>
            </td><td>
            <select id="drpDay" runat="server">
             <option selected="selected">00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option>
             <option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option>
             <option>12</option><option>13</option><option>14</option><option>15</option><option>16</option><option>17</option>
             <option>18</option><option>19</option><option>20</option><option>21</option><option>22</option><option>23</option>
            </select>
            点
            <select id="drpHour" runat="server">
            <option>00</option><option>10</option><option>20</option><option>30</option><option>40</option><option>50</option>
            </select>
            分
             </td></tr></table>
              </span>
             </div  >
        </td>
        </tr>
        <tr>
         <td class="ltd"> 手机号码:</td>
        <td align="left" style="white-space:nowrap; ">
           <span style="white-space:nowrap; ">
             <input id="txtTel" runat="server" value="输入多个号码请用逗号分隔" onfocus="this.value=''"  class="tbox" style="width:300px" />
             <asp:Button ID="btnTel" runat="server"  CssClass="btn" Text="加入" OnClick="btnTel_OnClick" ValidationGroup="add" /> &nbsp;
             <asp:Button ID="btnTelSelect" runat="server" CssClass="btn"  Text="选择"  OnClick="btnTelSelect_OnClick" OnClientClick="javascript:if(fVipTel('vip_SelectDlg.aspx',500,500)){return true;} else{return false;}" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTel" ErrorMessage="*" ValidationGroup="add" ></asp:RequiredFieldValidator>
           </span>
        </td>
        </tr>
         <tr><td class="ltd">发送号码:</td>       
        <td>           
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>         
           <asp:datagrid id="gv" runat="server" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" Width="100%" AllowCustomPaging="true"  AutoGenerateColumns="False"
							  GridLines="None" ForeColor="#333333" OnItemCommand="gv_ItemCommand" OnItemCreated="gv_ItemCreated" HorizontalAlign="Center">
						<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="gvHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="gvHeader"></FooterStyle>
							<Columns>
							<asp:BoundColumn DataField="no" HeaderText="序号" ReadOnly="true"></asp:BoundColumn>
							<asp:BoundColumn DataField="vipid" HeaderText="VIP卡号" ReadOnly="true"></asp:BoundColumn>								
								<asp:TemplateColumn HeaderText="手机号码">
									<ItemTemplate>
										<asp:label ID="lb" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.tel") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.tel") %>'></asp:textbox>
										<asp:RequiredFieldValidator id="RFVmodelname" runat="server" ControlToValidate="tb" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn UpdateText="更新" HeaderText="修改" CancelText="取消" EditText="修改">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
								</asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
									<asp:ImageButton id="imbdel" runat="server" ImageUrl="../icon/delete.gif" CommandName="DELETE"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#2461BF"></pagerStyle>
                            <EditItemStyle BackColor="#EFF3FB" />
						</asp:datagrid>                      
          </ContentTemplate>
          <Triggers >
          <asp:AsyncPostBackTrigger ControlID="BtnSave" />
          <asp:AsyncPostBackTrigger ControlID="btnTel" />
          <asp:AsyncPostBackTrigger ControlID="btnTelSelect" />
          </Triggers>
          </asp:UpdatePanel>    
        </td>
        
       </tr>
      </table>
     </td>
     </tr>
       
    </table>
    
    <!----contant end------------->
    
    </form>
</body>
</html>
