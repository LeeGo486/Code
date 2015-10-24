<%@ control language="C#" autoeventwireup="true" inherits="inc_pagehead, App_Web_uc_pagehead.ascx.f9bb04d2" %>
     <!--head
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName"><asp:Label ID="LblID" runat="server" Text=""></asp:Label><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3" >
                    <span id="rm_MainPanel_lPageNO"><a href="" runat="server" id="ahelp" style="color:#C60001">帮助</a></span><IMG alt="" id="himg" runat="server" align="absmiddle" src="../icon/help.gif" ></TD>
			</TR>
	</TABLE>

    <script language="javascript">
/*估计是按F1弹出帮助菜单的功能*/
function   KeyDown()
  {   
     var id=window.document.getElementById("Uc_pagehead1_ahelp").href;
      
      if   (window.event.keyCode==112 && (id!="" || id!=undefined))     
             {    
            
               window.location.href=document.all.Uc_pagehead1_ahelp.href;
            }  
}
document.onkeydown =KeyDown;
</SCRIPT>-->
