<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlanTel_upd, App_Web_vip_msgplantel_upd.aspx.e229d74e" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>短信调查发送 修改</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
	<style type="text/css"> .ltd{ background:#D9E5F4;}
	 .sec1 { border-right: gray 1px solid; 
                border-top: #ffffff 1px solid; 
                border-left: #ffffff 1px solid; 
                cursor: hand; color: #D9E5F4; 
                border-bottom: #D9E5F4 1px solid; 
                background-color: #D9E5F4}
    .sec2 {border-right: gray 1px solid; 
        border-top:#ffffff 1px solid; 
        font-weight: bold; 
        border-left: #ffffff 1px solid; 
        cursor: hand; color:#fffff1; 
        background-color: #fffff1
    }
.tabH{  border:solid 1 #ffffff; }
	</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		<script language="javascript" type="text/javascript">
		function ftab(id0,id1){
		 document.getElementById(id0).className='sec1'; document.getElementById(id1).className='sec2';
		}
		
function fScroll(obj, h, s){
    if(obj == undefined){return false;}
    var h = h || 200;
    var s = s || 1.2;
    var obj = typeof(obj)=="string"?document.getElementById(obj):obj;
    var status = obj.getAttribute("status")==null;
    var oh = parseInt(obj.offsetHeight);
    obj.style.height = oh;
    obj.style.display = "block";
    obj.style.overflow = "hidden";
    if(obj.getAttribute("oldHeight") == null){
        obj.setAttribute("oldHeight", oh);
    }else{
        var oldH = Math.ceil(obj.getAttribute("oldHeight"));
    }
    var reSet = function(){
        if(status){
            if(oh < h){
                oh = Math.ceil(h-(h-oh)/s);
                obj.style.height = oh+"px";
            }else{
                obj.setAttribute("status",false);
                window.clearInterval(IntervalId);
            }
        }else{
            obj.style.height = oldH+"px";
            obj.removeAttribute("status");
            window.clearInterval(IntervalId);
        }
    }
    var IntervalId = window.setInterval(reSet,10);
 return status;
}
window.onload= function(){    
    document.getElementById('btnStep1').onclick = function(){
        fScroll('btnStep1');
    }
}
//------
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
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <input type="hidden" id="hidPlanid" runat="server" /> <input type="hidden" id="hidPlanName"  runat="server"/>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                    
    <!--head end-->
    <!--menu----->
   <table  width="98%" >
    <tr>
    <td align="right">
      <asp:UpdatePanel ID="upd2" runat="server" ><ContentTemplate>
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" Enabled="false" Visible="false" CssClass="btn" OnClick="BtnSave_onclick" />      
       </ContentTemplate>
		<Triggers>
		<asp:AsyncPostBackTrigger ControlID="btnSearch" />
		<asp:AsyncPostBackTrigger ControlID="btnTelSelect" /></Triggers>
		</asp:UpdatePanel>   		 
        </td>
        <td style="width:107px;"><input id="btnBack" type="button" class="btn" onclick="javascript:window.history.go(-1);" value="返回" />
          <script language="javascript" type="text/javascript">
		  var vh=window.parent.location.href;
	     if(vh.indexOf('loader_frame')>-1)
	        document.getElementById('btnBack').style.display='none';
	        else
	        document.getElementById('btnBack').style.display='';
		</script> </td>
    </tr>
    </table>
    <!--menu-----> 
   
    <!----contant------------------>
    <div id="tb1" style="height:100px;display:block;overflow:hidden">
    <table width="100%"  >   
    <tr>
    <td align="center">
        <table  width="100%"  >
         <colgroup>
            <col  width="15%" /><col  width="80%" />          
        </colgroup>
        <tr>
        <td class="ltd"> 方案:</td>
        <td align="left" nowrap>
              <input id="txtMsgPlanid" runat="server" class="tbox" style="width:300px"  readonly="readonly" />
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
             <input id="txtTel" runat="server"  value="输入多个号码请用逗号分隔" onfocus="this.value=''"    class="tbox" style="width:300px" ></input>
             <asp:Button ID="btnTel" runat="server"  CssClass="btn" Text="加入" OnClick="btnTel_OnClick" ValidationGroup="add" /> &nbsp;
             <asp:Button ID="btnTelSelect" runat="server" CssClass="btn"  Text="选择"  OnClick="btnTelSelect_OnClick" OnClientClick="javascript:if(fVipTel('vip_SelectDlg.aspx',500,500)){return true;} else{return false;}" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTel" ErrorMessage="*" ValidationGroup="add" ></asp:RequiredFieldValidator>
           </span>
        </td>
        </tr>
         <tr><td class="ltd"></td>  <td>  </td>        
       </tr>
      </table>
     </td>
     </tr>
       
    </table>
    </div>
      <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>  
    <table width="98%"> 
    <tr>
    <td align="center" width="98%"> 
     <table id="secTable"  width="100%" align="center" cellpadding="0"  cellspacing="0" class="tabH">
     <tr align="center" height=20>
     <td class="sec2" id="tab0" width="10%">
    <asp:LinkButton ID="btnStep1" runat="server" Text="添加号码"  ToolTip="请点击使展开添加界面" OnClick="btnStep1_OnClick"></asp:LinkButton>
     </td>
      <td class="sec1" id="tab1" width="10%">
      <asp:LinkButton ID="btnStep2" runat="server" Text="短信信息"  OnClick="btnStep2_OnClick" ></asp:LinkButton>
     </td>
     <td width="79%"></td>
     </tr>
     <tr><td  class="ltd"colspan="3">
            <asp:MultiView ID="Mv" ActiveViewIndex="1" runat="server"  >
            <asp:View ID="v1" runat="server">      
             
                    <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="no"
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
                            
                           <asp:BoundField DataField="no" HeaderText="序号" ReadOnly="true"/>
					        <asp:BoundField DataField="vipid" HeaderText="VIP编号" ReadOnly="true" />
					        <asp:TemplateField HeaderText="手机号码">
					        <ItemTemplate>
                           <span ><%# Eval("tel").ToString().Length > 11 ? Eval("tel").ToString().Substring(0, 11) + "..." : Eval("tel")%> </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtTel1" runat="server" Text='<%# Eval("tel")%>'></asp:TextBox>
                             <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTel1" ValidationExpression="\d{1,11}" ErrorMessage="*" ValidationGroup="upd"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
					        </asp:TemplateField>					
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
			        <th scope="col"><a href="#" >序号</a></th>
			        <th scope="col"><a href="#">VIP编号</a></th>
			        <th scope="col"><a href="#" >手机号码</a></th>
			        <th scope="col"><a href="#" >删除</a></th>	
		          </tr>
	              </table>
                      </EmptyDataTemplate>
                      <EditRowStyle BackColor="#2461BF" />
                      <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                      <PagerStyle CssClass="header"  HorizontalAlign="Left" />
                      <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
                      <AlternatingRowStyle BackColor="White" />
                  </asp:GridView>
            </asp:View>
            <asp:View ID="v2" runat="server">   
               <table width="100%" cellspacing="0">
               <tr><td align="right"> 回执状态:<asp:DropDownList ID="drpRptCode" runat="server">  </asp:DropDownList>
                <asp:Button ID="btnSearch" Width="100px" runat="server" CssClass="btn" Text="查询" OnClick="btnSearch_Click" />
               </td></tr>
               <tr><td></td></tr>
               </table>
          
                 <asp:GridView ID="gv1" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="msgid"
                      AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid" CellSpacing="1" 
                      ForeColor="#333333" GridLines="None" Width="97%" PageSize="10" 
                    onpageindexchanged="gv1_PageIndexChanged" 
                    onpageindexchanging="gv1_PageIndexChanging" 
                    onrowcancelingedit="gv1_RowCancelingEdit" OnRowCommand="gv1_RowCommand" 
                    onrowcreated="gv1_RowCreated" onrowdeleted="gv1_RowDeleted" 
                    onrowdeleting="gv1_RowDeleting" onrowediting="gv1_RowEditing" 
                    onrowupdated="gv1_RowUpdated" onrowupdating="gv1_RowUpdating" onrowdatabound="gv1_RowDataBound" 
                     >
                      <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                      <Columns> 
                           <asp:BoundField DataField="title" HeaderText="方案名称" ReadOnly="true" Visible="false" />
					        <asp:BoundField DataField="msgid" HeaderText="短信编号" ReadOnly="true" />
					        <asp:TemplateField HeaderText="手机号码">
					        <ItemTemplate>
                           <span ><%# Eval("tel").ToString().Length > 11 ? Eval("tel").ToString().Substring(0, 11) + "..." : Eval("tel")%> </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:TextBox ID="txtdesc" runat="server" Text='<%# Eval("tel")%>'></asp:TextBox>
                            </EditItemTemplate>
					        </asp:TemplateField>
					        <asp:BoundField DataField="msgplanid" HeaderText="方案编号" ReadOnly="true" Visible="false" />
					        <asp:BoundField DataField="rptCode" HeaderText="回执状态" ReadOnly="true" />
					        <asp:BoundField DataField="rptDesc" HeaderText="回执描述" ReadOnly="true" />								
					        <asp:BoundField DataField="itemid" HeaderText="回复编号" ReadOnly="true" />							
					        <asp:BoundField DataField="vipid" HeaderText="VIP编号" ReadOnly="true"/>								
					        <asp:BoundField DataField="crdate" HeaderText="创建时间" ReadOnly="true" DataFormatString="{0:d}"/>							
					        <asp:BoundField DataField="crname" HeaderText="创建人" ReadOnly="true"/>  
		               <asp:CommandField HeaderText="修改" CancelText="取消" UpdateText="更新" EditText="编辑" ShowCancelButton="true" ShowEditButton="true" />
                       <asp:TemplateField HeaderText="排除">
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
			        <th scope="col"><a href="#" >短信编号</a></th>
			        <th scope="col"><a href="#">方案编号</a></th>
			        <th scope="col"><a href="#" >方案名称</a></th>
			        <th scope="col"><a href="#" >手机号码</a></th>	
			        <th scope="col"><a href="#" >回执编码</a></th>	
			        <th scope="col"><a href="#" >回执描述</a></th>	
			        <th scope="col"><a href="#" >卡号</a></th>	
			        <th scope="col"><a href="#" >创建人</a></th>	
			        <th scope="col"><a href="#" >创建时间</a></th>			
		          </tr>
	              </table>
                      </EmptyDataTemplate>
                      <EditRowStyle BackColor="#2461BF" />
                      <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                      <PagerStyle CssClass="header"  HorizontalAlign="Left" />
                      <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
                      <AlternatingRowStyle BackColor="White" />
                  </asp:GridView>
                 
            </asp:View>
            </asp:MultiView>
    </td></tr>
    </td>
    </tr>
    </table>
      </ContentTemplate>
          <Triggers >
          <asp:AsyncPostBackTrigger ControlID="BtnSave" />
          <asp:AsyncPostBackTrigger ControlID="btnTel" />
          <asp:AsyncPostBackTrigger ControlID="btnTelSelect" />

          </Triggers>
    </asp:UpdatePanel>    
    
    
   
    <!----contant end------------->
    
    </form>
</body>
</html>
