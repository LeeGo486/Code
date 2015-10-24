<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_upd, App_Web_mat_bill_upd.aspx.e229d74d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" 
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>店铺报修单--修改</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<script language="javascript" src="../js/project.js" type="text/javascript"></script>
	<style type="text/css">
	 .ltd{ background:#D9E5F4; text-align:center; }
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
	</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
        <script language="javascript" type="text/javascript">
		        function ftab(id0,id1){ document.getElementById(id0).className='sec1'; document.getElementById(id1).className='sec2';
		        }
        </script>
	<script type="text/javascript" language="javascript">
   function selectMD(){
     var m=window.showModalDialog('mat_org_dlg.aspx',"弹出d窗口","height:500px;width:800px;toolbar:no;menubar:no;location:no;resizable:no;status:no;scroll:no;help:no;");
	     if (m!=null&&typeof(m)!='undefined'&&m!="all"){	         
		     document.getElementById('hidOrg').value=m.split('|')[1];
             document.getElementById('txtOrg').value=m;
             return true;
	    }
	    else
	    return false;
  }
 </script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
  <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <table  width="750">
    <tr>   
        <td align="right">  
          <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="txtContent" ErrorMessage="请填写报修内容"></asp:RequiredFieldValidator>&nbsp;
          <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />     
        </td>
    </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>  
    <table id="secTable"  width="100%" align="center" cellpadding="0"  cellspacing="0">
     <tr align="center" height="20">
     <td class="sec2" id="tab0" width="15%">
     <asp:LinkButton ID="btnStep1" runat="server" Text="报修资料"   OnClick="btnStep1_OnClick" CausesValidation="false"></asp:LinkButton>
     </td>
      <td class="sec1" id="tab1" width="15%">
      <asp:LinkButton ID="btnStep2" runat="server" Text="其      它"  OnClick="btnStep2_OnClick" CausesValidation="false" ></asp:LinkButton>
     </td>
     <td width="79%"></td>
     </tr> 
     </table>
     <table  width="100%" align="center" cellpadding="0"  cellspacing="0" >  
     <tr><td>
         <table width="100%" align="center" cellpadding="0"  cellspacing="0">
           <tr><td class="ltd" colspan="6" style="height:5px;"></td></tr> 
           <tr><td>  
           <asp:MultiView ID="Mv" ActiveViewIndex="1" runat="server"  >
            <asp:View ID="v1" runat="server"> 
                <table width="100%" >
                 <colgroup>
                    <col  width="60" />
                    <col  align="left"  width="120" />
                    <col  width="60" />
                    <col  align="left"  width="120" />  
                    <col  width="60" />
                    <col  align="left"  width="120" />  
                </colgroup>
                <tr><td class="ltd" >编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号: </td>
                <td> <input id="txtbillid" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>  </td>
                
                
                <td class="ltd">大&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区:</td>
                <td><input id="txtshutname" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">联 系 人:</td>
                <td><input id="txtr_name" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                </tr>
                <tr>
                <td class="ltd" >店铺名称:</td>
                <td><input id="txtDepotid" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                 <td class="ltd"> 报修日期:</td>
                <td><input id="txtchk_date" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">报 修 人:</td>
                <td><input id="txtchk_name" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                </tr> 
                <tr>
                <td class="ltd" > 种&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类:</td>
                <td> <asp:DropDownList ID="drpType" runat="server" Width="99%"  Enabled="false"> </asp:DropDownList>  </td>
                 <td class="ltd"> 品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类:</td>
                <td><asp:DropDownList ID="drpchild" runat="server" Width="99%" Enabled="false"> </asp:DropDownList></td>
                <td class="ltd">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话:</td>
                <td><input id="txtTel" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                </tr>   
                <tr>
                <td class="ltd" > 状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</td>
                <td><asp:DropDownList ID="drpState" runat="server" Width="99%" Enabled="false"> 
                     <asp:ListItem Text="未上报" Value="0" ></asp:ListItem> <asp:ListItem Text="已上报" Value="1"></asp:ListItem> 
                     <asp:ListItem Text="已跟进" Value="2" ></asp:ListItem> <asp:ListItem Text="已退回" Value="3" ></asp:ListItem> 
                     <asp:ListItem Text="超期" Value="4" ></asp:ListItem> <asp:ListItem Text="完成" Value="5" ></asp:ListItem> 
                 </asp:DropDownList></td>
                 <td class="ltd"> 创 建 人:</td>
                <td><input id="txtcrname" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">创建时间:</td>
                <td><input id="txtcrdate" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/> </td>
               </tr>         
               <tr>
                <td class="ltd">报修内容:</td>
                <td colspan="3"" ><textarea id="txtContent" runat="server" class="tbox" style="width:98%; height:50px; margin:0px;" readonly="readonly"></textarea> </td>
                <td class="ltd" rowspan="3">图&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;片:</td>
                <td align="center" valign="middle"  rowspan="3"><a id="aimgbill" href="" runat="server" target="_blank"><img id="imgbill" runat="server" src=""  style="border:none;" /></a></td>
                </tr>  
               <tr>
                <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
                <td colspan="3"><textarea id="txtComment" runat="server" class="tbox" style="width:98%; height:50px;" readonly="readonly"></textarea></td>      
               </tr> 
                <tr><td class="ltd" colspan="6" style="height:5px;"></td></tr> 
              </table>
          </asp:View>
            <asp:View ID="v2" runat="server">          
             <table width="100%" >
              <colgroup>
                    <col  width="60" />
                    <col  align="left"  width="120" />
                    <col  width="60" />
                    <col  align="left"  width="120" />  
                    <col  width="60" />
                    <col  align="left"  width="120" />  
                </colgroup>
                <tr>
                <td class="ltd">回复时间:</td>
                <td><input id="txtfb_date" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>     </td>
                <td class="ltd">回 复 人:</td>
                <td><input id="txtfb_name" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">核实情况:</td>
                <td><input id="txtfb_comment" runat="server" class="tbox" style="width:99%;"/>         </td>
                </tr>         
                <tr>
                <td class="ltd">处理方案:</td>
                <td><input id="txtfb_content" runat="server" class="tbox" style="width:99%;"  />         </td>
                <td class="ltd">计划完成时间:</td>
                <td><input id="txtschemaenddate" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">已更改计划:</td>
                <td><input id="txtischangeschema" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                </tr>   
               <tr>
                <td class="ltd">施工单位:</td>
                <td>
                   <input id="txtOrg" runat="server" class="tbox" style="width:50%;" readonly="readonly"/> 
                   <asp:Button  id="btnOrg" Text="选择"  OnClientClick="javascript:selectMD();"  runat="server" />
                   <input type="hidden" runat="server" id="hidOrg" />
                </td>
                 <td class="ltd">结束时间:</td>
                <td><input id="txtend_crdate" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">完工时间:</td>
                <td><input id="txtenddate" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                </tr> 
               <tr>
                <td class="ltd">实际完成天数:</td>
                <td><input id="txtendday" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                  <td class="ltd">满 意 度:</td>
                <td><input id="txtopinion" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
                <td class="ltd">更改计划原因:</td>
                <td><input id="txtchangecause" runat="server" class="tbox" style="width:99%;"  readonly="readonly"/>         </td>
               </tr> 
               <tr>
                <td class="ltd"> 质&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保:</td>
                <td><asp:DropDownList ID="drpisquality" runat="server" Width="99%" ><asp:ListItem Text="否" Value="0" ></asp:ListItem><asp:ListItem Text="是" Value="1" Selected=True></asp:ListItem> </asp:DropDownList>  </td>
                <td class="ltd"></td><td class="ltd"></td><td class="ltd"></td><td></td>
               </tr> 
 
                <tr><td class="ltd" colspan="6" ><br /></td></tr> 
                 <tr><td colspan="6">
                  <asp:GridView ID="gv" runat="server" DataKeyNames="billid" AutoGenerateColumns="False" CellPadding="3"  CssClass="tbGrid"
                   CellSpacing="1"   ForeColor="#333333" GridLines="None" Width="100%"  >
                      <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                      <Columns>  
                          <asp:BoundField DataField="billid" HeaderText="编号" />
					        <asp:BoundField DataField="schemaenddate" HeaderText="历史计划完成时间" DataFormatString="{0:d}" ReadOnly="true" />
					        <asp:TemplateField HeaderText="计划完成更改原因" ControlStyle-Width="100">
					        <ItemTemplate>
                            <%# Eval("changecause").ToString().Length > 20 ? "<marquee  width='100' scrolldelay='300'>" + Eval("changecause") + "</marquee>" : Eval("changecause")%>
                            </ItemTemplate>
					        </asp:TemplateField>		
                     
                      </Columns>
                      <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                       <EmptyDataTemplate>
                      <table cellspacing="0" cellpadding="4" border="0" id="ctl00_ctplhder_GridMonth" style="color:#333333;width:100%;border-collapse:collapse;">
			        <tr class="header">
			        <td><a href="#" >编号</a></td>
			        <td><a href="#">历史计划完成时间</a></td>
			        <td><a href="#" >计划完成更改原因</a></td>
			        </tr>
	              </table>
                      </EmptyDataTemplate>
                      <EditRowStyle BackColor="#2461BF" />
                      <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                      <PagerStyle CssClass="header"  HorizontalAlign="Left" />
                      <HeaderStyle CssClass="dgHeader"    HorizontalAlign="Center" />
                      <AlternatingRowStyle BackColor="White" />
                  </asp:GridView>
                 </td></tr>          
                </table>
              </asp:View>
            </asp:MultiView>
            </td></tr> 
          </table>  
        </td>
    </tr>
      
    </table> 
  </ContentTemplate>
  <Triggers><asp:PostBackTrigger ControlID="BtnSave" /></Triggers> 
    </asp:UpdatePanel>
</form>
</body>
</html>

