<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindResultDetailTitle, App_Web_fp_findresultdetailtitle.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>按调查主题查看调查结果</title>
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
</script>
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
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">按调查主题查看调查结果</span>&nbsp;&nbsp;&nbsp;
					
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
    
     <div  class="BContent" style="width:100%">
     <table width="100%">
     <tr>
     <td align="center"> <h2><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></h2></td>
     </tr>
   
     <tr>
     <td align="center">
     </td>
     </tr>
       <tr>
     <td>&nbsp;
         <asp:HiddenField ID="HFTitleCode" runat="server" />
     <asp:Label ID="Lblchkuser" runat="server" CssClass="hidden"></asp:Label>
     </td>
     </tr>
     <tr>
       <td><asp:Label ID="LblSubTitle" runat="server" Text=""></asp:Label></td>
     </tr>
       <tr>
       <td><asp:Label ID="LblIntro" runat="server" Text=""></asp:Label>本次调查由<asp:Label ID="Lblcruser" runat="server" Text=""></asp:Label>发起,于<asp:Label ID="Lblbegintime" runat="server" Text=""></asp:Label>到<asp:Label ID="Lblendtime" runat="server" Text=""></asp:Label>,
       调查款式数量为<a href='FP_FindStyleList.aspx?titlecode=<%= HFTitleCode.Value.ToString() %>' onclick="return GB_showPage('款式列表', this.href)" target="_blank"  title=''><asp:Label ID="Lblstylenum" runat="server" Text=""></asp:Label> </a>,
       要求参于人数<a href='FP_Findnochekchshop.aspx?styleid=-&titlecode=<%= HFTitleCode.Value.ToString() %>&state=0' onclick="return GB_showPage('要求参于调查的店铺', this.href)" target="_blank"  title=''><asp:Label ID="Lblshopnum" runat="server" Text=""></asp:Label> </a>
       人</td>
     </tr>
     <tr>
     <td style="height: 21px" >
     <hr  style="display:inline;border:solid 1px #1b9bbf;"/>
    
     </td>
     </tr>
     <tr>
     <td>
     <!---contact--->
     <asp:Label ID="LblNo" runat="server" Text=""></asp:Label>
     <table width="100%">
     <tr>
     <td>

        <table width="100%" border="1" cellpadding="0" cellspacing="0">
             
                   
             
        <asp:Repeater ID="RepeaterList" runat="server"   OnItemCommand="RepeaterList_ItemCommand" OnItemDataBound="RepeaterList_ItemDataBound"  >
        <HeaderTemplate>
    
          <tr class="header" bgcolor="0" >
                     <td  align="center"  >
                                <asp:LinkButton ID="styleid" Runat="server" text="styleid" CommandName="styleid">款式</asp:LinkButton>
                     </td>
                     <td align="center"  >
                      <asp:LinkButton ID="d_name" Runat="server" text="d_name" CommandName="d_name">店铺</asp:LinkButton>
                     </td>
                      <td align="center"  >
                       <asp:LinkButton ID="cr_name" Runat="server" text="cr_name" CommandName="cr_name">回复人</asp:LinkButton>
                      </td>
                     <td align="center"  >
                      <asp:LinkButton ID="IsReply" Runat="server" text="IsReply" CommandName="IsReply">回复否</asp:LinkButton>
                     </td>
                     <td align="center"  >
                      <asp:LinkButton ID="cr_date" Runat="server" text="cr_date" CommandName="cr_date">回复日期</asp:LinkButton>
                     </td>
                    <td align="center"  >
                    <!-- 调查项目--->
                    <table width="100%">
                    <tr>
                    <td><a href="FP_ModelShowChk.aspx?modelcode=<%= HFTitleCode.Value.ToString()%> " onclick="return GB_showPage('调查题目', this.href)">调查项目</a></td>
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
                     <td align="center"  >
                      <asp:LinkButton ID="havenum" Runat="server" text="havenum" CommandName="havenum">参于数</asp:LinkButton>
                     </td>
                      <td align="center"  >
                       <asp:LinkButton ID="nonum" Runat="server" text="nonum" CommandName="nonum">未参于数</asp:LinkButton>
                      </td>
                     <td align="center"  >
                      <asp:LinkButton ID="Score" Runat="server" text="Score" CommandName="Score">分值</asp:LinkButton>
                     </td>
                     <td align="center"  >
                      <asp:LinkButton ID="SellNum" Runat="server" text="SellNum" CommandName="SellNum">销售</asp:LinkButton>
                     </td>
                     <td align="center"  >
                         图表</td>
                     </tr>
        </HeaderTemplate>
                           <ItemTemplate >
                                  <tr bgcolor="#D1DDF1"  >
                     <td  align="center" ><a href="FP_Styleinfor.aspx?styleid=<%# Eval("styleid")%>" 
                     rel="gb_pageset[search_sites]" title='<%# Eval("styleid")%>款式明细' target="_blank">
                     <%# Eval("styleid")%></a></td>
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
                     <td align="center"  ><%# Eval("havenum")%></td>
                      <td align="center"  ><%# Eval("nonum")%></td>
                     <td align="center"  ><%# Eval("Score")%></td>
                     <td align="center"  ><%# Eval("SellNum")%></td>
                     <td align="center"  >
                     <a href="FP_FindResultTitlePic.aspx?styleid=<%# Eval("styleid")%>&titlecode=<%=HFTitleCode.Value.ToString()%>&stylenum=<%=Lblstylenum.Text.ToString()%>
                     &shopnum=<%=Lblshopnum.Text.ToString()%>&havenum=<%# Eval("havenum")%>&nonum=<%# Eval("nonum")%>"
                      rel="gb_pageset[search_sites1]" title='<%# Eval("styleid")%>款式图报表' target="_blank">
                     <img  src="../icon/report.ico"/ width="32" height="32" border="0"></a></td>
                     </tr>
                            </ItemTemplate>
        </asp:Repeater>
           
            
    </table>
        
     </td>
     </tr>
     </table>
     <!---contact--->
         </td>
     </tr>
     </table>
     
    
    </div>
    </form>
</body>
</html>
