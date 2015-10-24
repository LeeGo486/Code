<%@ page language="C#" enableviewstate="False" autoeventwireup="true" inherits="FindProduct_FP_FindResultDetail, App_Web_fp_findresultdetail.aspx.a918743" title="Untitled Page" %>
<%@ OutputCache Duration="3" Location="None" VaryByParam="styleid,havenum,nonum" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <script language="javascript" type="text/javascript" src="../js/select.js" ></script>
  <script language="javascript" type="text/javascript" src="../js/check.js" ></script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式资料明细</title>
     <link  href="../css/project.css" type="text/css"  rel="stylesheet">
       <style type="text/css">
  A:link {
	COLOR: #005a5a; TEXT-DECORATION: none
}
  </style>
     	<script language="javascript">
function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDiv2(z){
var z;
var s=document.getElementById("input2_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
function showDiv3(z){
var z;
var s=document.getElementById("input3_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
</script>
</head>
<body>
    <form id="form1" runat="server">
     <!-------title------------------------>
         <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">款式调查明细</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="按主题查询" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='FP_FindResultnewlistByTitle.aspx'; return false;"   />
      <asp:Button ID="BtnGo2" Width="100px" runat="server" Text="按款式查询" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='FP_FindResultnewlist.aspx'; return false;"   />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu-end---->
     <div  class="BContent" style="height:100%" >
<table width="100%">
 <tr>
     <td align="center"> <h2><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></h2></td>
     </tr>
<tr>
<td align="center">
    <asp:HiddenField ID="HFTitleCode" runat="server" /> </td>
</tr>
<tr>
<td style="height:50">
</td>
</tr>
    <tr >
        <td class="ProTitle">&nbsp;</td>
        </tr>
<tr>
<td>
<a href="#" title="查看款式信息"  onClick='showDiv2(1)' id="ShowDivLink">查看款式信息</a>
                     

                    
</td>
</tr>
    
<tr>
<td>
<div id="input2_1" style="display:none;">
<table width="690px" align="center">
<tr>
 <td align="left" width="50%" height="360">
<table >
<tr>
 <td >
  <table   border="0" cellspacing="5" cellpadding="0">
       <tr class="ProTitle">
           <td align="left">  
               <asp:Label ID="Label1" runat="server" Text="款式名称:"></asp:Label>
            </td>
            <td align="left">  
               <asp:Label ID="LblName" runat="server" ></asp:Label>
            </td>
            <td align="left">  
               <asp:Label ID="Label3" runat="server" Text="款式编号:"></asp:Label>
            </td>
            <td align="left">  
               <asp:Label ID="LblID" runat="server" Text=""></asp:Label>
            </td>
           <td align="left" colspan="2" rowspan="6" >
            
           </td>
       </tr>
        <tr class="ProTitle">
            <td align="left">
               <asp:Label ID="Label7" runat="server" Text="款式年份:"></asp:Label></td>
            <td align="left">
               <asp:Label ID="LblNian" runat="server" Text=""></asp:Label></td>
            <td align="left">
               <asp:Label ID="Lbel9" runat="server" Text="款式季节:"></asp:Label></td>
            <td align="left">
               <asp:Label ID="LblJin" runat="server" Text=""></asp:Label></td>
        </tr>
       <tr class="ProTitle">
           <td align="left"> <asp:Label ID="Label11" runat="server" Text="原    料:"></asp:Label></td>
            <td align="left"> <asp:Label ID="LblYanliao" runat="server" Text=""></asp:Label></td>
            <td align="left">  
               <asp:Label ID="Label13" runat="server" Text="款式大类:"></asp:Label></td>
            <td align="left">  &nbsp;<asp:Label ID="LblStyleMax" runat="server" Text=""></asp:Label></td>
       </tr>
       <tr class="ProTitle">
           <td align="left" style="height: 18px">  <asp:Label ID="Label17" runat="server" Text="款式性别:"></asp:Label></td>
            <td align="left" style="height: 18px">  &nbsp;<asp:Label ID="LblSex" runat="server" Text=""></asp:Label></td>
            <td align="left" style="height: 18px">  
               <asp:Label ID="Label15" runat="server" Text="款式小类:"></asp:Label>
            </td>
            <td align="left" style="height: 18px">  
               <asp:Label ID="LblStyleMin" runat="server" Text=""></asp:Label>
            </td>
       </tr>
    <tr class="ProTitle">
           <td align="left" style="height: 18px">  
               <asp:Label ID="Label19" runat="server" Text="零销价格:"></asp:Label>
            </td>
            <td align="left" style="height: 18px">  
               <asp:Label ID="LblPrice" runat="server" Text=""></asp:Label>
            </td>
            <td align="left" style="height: 18px">  
               <asp:Label ID="Lbl21" runat="server" Text="目前库存:"></asp:Label>
            </td>
            <td align="left" style="height: 18px">  
               <asp:Label ID="LblStore" runat="server" Text=""></asp:Label>
            </td>
       </tr>
       <tr class="ProTitle">
            <td align="left">
               <asp:Label ID="Label23" runat="server" Text="计量单位:"></asp:Label></td>
            <td align="left">
               <asp:Label ID="LblDianwei" runat="server" Text=""></asp:Label></td>
            <td align="left">
                <asp:Label ID="Label2" runat="server" Text="最早到货日期:"></asp:Label></td>
            <td align="left">
                <asp:Label ID="LblGetDate" runat="server" Text=""></asp:Label></td>
        </tr>
    </table>
</td>
</tr>
<tr>
<td ><br /></td>
</tr>

<tr>
<td  align="left">
    <br /></td>
</tr>
</table>
 
</td>
  <td width="50%" height="360">
                    <table width="330" border="0" align="center" cellpadding="0" cellspacing="5" style="border:solid 1px #07aba0;">
                    <tr>
                    <td>
                   
                        <a href="#" target="_blank">
                            <asp:Image ID="ImgNew" runat="server" Height="300px" ImageUrl="~/images/nophoto.gif" Width="320px" />
                        </a>
                         </td>
                    </tr>
                    </table>
                </td>
</tr>
</table>
 </div>
</td>
</tr>
<tr>
    <td>
        要求参于调查为人数：<asp:Label ID="LblAll" runat="server" Text=""></asp:Label>,参于人数<asp:Label ID="Lblhave" runat="server" Text=""></asp:Label>,占总参于人数的<asp:Label ID="LblNumRate" runat="server" Text=""></asp:Label>
        (<asp:HyperLink ID="HyperLinkSell" runat="server" Target="_blank" NavigateUrl="FP_FindResultStyleMonth.aspx?styleid=">查看销售情况</asp:HyperLink>)
        <asp:Label ID="LblNo" runat="server" Text=""  CssClass="hidden"></asp:Label></td>
</tr>


<tr><td style="height: 126px">
     <!---contact--->
     <table width="100%">
     <tr>
     <td>

        <table width="100%" border="1" cellpadding="0" cellspacing="0">
             
                     <tr class="header" bgcolor="0" >
                     <td align="center"  >店铺</td>
                      <td align="center"  >回复人</td>
                     <td align="center"  >回复否</td>
                     <td align="center"  >回复日期</td>
                    <td align="center"  >
                    <!-- 调查项目--->
                    <table width="100%">
                    <tr>
                    <td>调查项目</td>
                   </tr>
                    <tr>
                     <td >
                     <hr  style="display:inline;border:solid 1px #1b9bbf;"/>
                     </td>
                     </tr>
                   <tr>
                          <td>
                             <table width="100%">
                            <tr>
                                <%= GetHeader(HFTitleCode.Value.ToString())%>
                            </tr>
                            </table>
                            </td>
                    </tr>
                    </table>
                   
                     <!-- 调查项目--->
                    </td>
                     <td align="center"  >分值</td>
                     <td align="center"  >销售</td>
                     <td align="center"  >
                         图表</td>
                     </tr>
             
        <asp:Repeater ID="RepeaterList" runat="server"   >
                           <ItemTemplate >
                                  <tr bgcolor="#D1DDF1"  >
                    
                     <td align="center"  ><%# Eval("d_name")%></td>
                      <td align="center"  ><%# Eval("cr_name")%></td>
                     <td align="center"  ><a href="#" title="点击查看回复内容"  onClick='showDiv(<%# (Container.ItemIndex+1)%>)' id="ShowDivLink"><%# Eval("IsReply").ToString()=="True"?"是":"否"%></a>
                     <div id="input_<%# (Container.ItemIndex+1)%>" style="display:none;">
                     <%# Eval("ReplyText")%>
                     </div>
                     </td>
                     <td align="center"  ><%# String.Format("{0:d}", Eval("cr_date"))%></td>
                    <td align="center"  >
                    <!-- 调查项目--->
                    <table width="100%">
                    
                   <tr>
                          <td>
                             <table width="100%" >
                            <tr>
                           <%# GetContant(Eval("competecxid").ToString())%>
                            </tr>
                            </table>
                            </td>
                    </tr>
                    </table>
                   
                     <!-- 调查项目--->
                    </td>
                     <td align="center"  ><%# Eval("Score")%></td>
                     <td align="center"  ><%# Eval("SellNum")%></td>
                     <td align="center"  >
                     <a href="FP_FindResultTitlePic.aspx?styleid=<%# Eval("styleid")%>&titlecode=<%=HFTitleCode.Value.ToString()%>&stylenum=1&shopnum=<%= LblAll.Text.ToString()%>&havenum=<%= Lblhave.Text.ToString()%>&nonum=<%= LblNo.Text.ToString()%>" target="_blank">
                     <img  src="../icon/report.ico"/ width="32" height="32" border="0"></a></td>
                     </tr>
                            </ItemTemplate>
        </asp:Repeater>
           
            
    </table>
        
     </td>
     </tr>
     </table>
     <!---contact--->
</td></tr>
 <!---reply--->
        
    <tr>
    <td><asp:Label ID="LblReply" runat="server" Text=""></asp:Label>
    <a href="#" title="显示回复内容"  onClick='showDiv2(2)' id="A1">(显示回复内容)</a>
    <a href="#" title="显示建议内容"  onClick='showDiv3(3)' id="A2">(显示建议内容)</a>
                     
                   
                     </td>
    </tr>
     <tr>
    <td>
    <div id="input2_2" style="display:none;">
        <table>
        <asp:Repeater ID="RepeaterReply" runat="server">
        <ItemTemplate>
         <tr>
        <td><%# (Container.ItemIndex+1)%>.<%# Eval("ReplyText")%>&nbsp;&nbsp;&nbsp;&nbsp;(回复人:<%# Eval("d_name")%>-<%# Eval("cr_name")%>)</td>
        </tr>
        </ItemTemplate>
        </asp:Repeater>
        </table>
    </div>
      <div id="input3_3" style="display:none;">
        <table>
        <asp:Repeater ID="RepeaterSeguest" runat="server">
        <ItemTemplate>
         <tr>
        <td><%# (Container.ItemIndex+1)%>.<%# Eval("AdvanText")%>&nbsp;&nbsp;&nbsp;&nbsp;(建议人:<%# Eval("d_name")%>-<%# Eval("cr_name")%>)</td>
        </tr>
        </ItemTemplate>
        </asp:Repeater>
        </table>
    </div>
    </td>
    </tr>
     <!---reply end--->
<tr>
    <td align="left">
       
    </td>
</tr>
</table>

                            
					
				
			


 
    </div>
    </form>
</body>
</html>



