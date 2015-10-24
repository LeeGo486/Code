<%@ control language="C#" autoeventwireup="true" inherits="web_TreeFram, App_Web_web_treefram.ascx.3f410aa0" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>
<div style="float:left; border-right: #ccccff 1px solid; border-top: #ccccff 1px solid; border-left: #ccccff 1px solid; border-bottom: #ccccff 1px solid;">
    &nbsp;&nbsp;<asp:Label ID="lbltreetitle" runat="server" Font-Underline="True" ></asp:Label><ignav:UltraWebTree ID="wtree" runat="server" Height="474px" Width="188px" WebTreeTarget="ClassicTree">
    </ignav:UltraWebTree>
</div>
<div style="float:left;"><iframe id="TreeFrame"  runat="server" frameborder="0" name="treeframe" style="width: 100%; height: 491px">
    </iframe>
</div>
