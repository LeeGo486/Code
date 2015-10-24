<%@ page language="C#" autoeventwireup="true" maintainscrollpositiononpostback="true" inherits="buyproduct_manager_basic_BP_BSNewAdd, App_Web_bp_bsnewadd.aspx.11713791" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购合同模板添加</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">添加供应商公告信息</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="返 回" CssClass="btn"   OnClientClick="window.location.href='BP_BSNewList.aspx'; return false;" TabIndex="4"   />
     <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="btnSave_Click" TabIndex="3" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
        
    <div  class="BContent" style="height:100%">
    <table width="100%">
     <tr>
     <td align="center"> <asp:Label id="LblAlart" runat="server" Text="" ForeColor="Red"></asp:Label></td>
     </tr>
    <tr>
    <td align="left" valign="top">
   
    <!--the title-->
    <table width="100%">
     <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
    
    <tr>
    <td>
        公告标题:</td>
    <td><asp:TextBox ID="TxtTiTle" runat="server" MaxLength="50" Width="400px" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator
                      ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtTiTle"
                      ErrorMessage="*"></asp:RequiredFieldValidator></td>
   
    
    </tr>
    <tr>
    <td>
        发布人:</td>
    <td><asp:TextBox ID="TxtUUser" runat="server" MaxLength="50" Width="400px" CssClass="tbox" TabIndex="1"></asp:TextBox><asp:RequiredFieldValidator
                      ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtUUser"
                      ErrorMessage="*"></asp:RequiredFieldValidator></td>
    </tr>
    
    </table>
        </td>
    </tr>
    <tr>
    <td align="left" valign="top">
      <!--the wriehead-->
        <!--the writer head end--></td>
    </tr>
    <tr>
    <td align="left" valign="top">
        公告内容:</td>
    </tr>
    <tr>
    <td align="left" valign="top">
    <!--the wriehead-->
        <ighedit:WebHtmlEditor ID="whtmlFoot" runat="server"  Width="100%" BackgroundImageName="" 
    FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>" FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7" FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset=" SpecialCharacterList="&#937;,&#931;,&#916;,&#934;,&#915;,&#936;,&#928;,&#920;,&#926;,&#923;,&#958;,&#956;,&#951;,&#966;,&#969;,&#949;,&#952;,&#948;,&#950;,&#968;,&#946;,&#960;,&#963;,&szlig;,&thorn;,&THORN;,&#402,&#1046;,&#1064;,&#1070;,&#1071;,&#1078;,&#1092;,&#1096;,&#1102;,&#1103;,&#12362;,&#12354;,&#32117;,&AElig;,&Aring;,&Ccedil;,&ETH;,&Ntilde;,&Ouml;,&aelig;,&aring;,&atilde;,&ccedil;,&eth;,&euml;,&ntilde;,&cent;,&pound;,&curren;,&yen;,&#8470;,&#153;,&copy;,&reg;,&#151;,@,&#149;,&iexcl;,&#14;,&#8592;,&#8593;,&#8594;,&#8595;,&#8596;,&#8597;,&#8598;,&#8599;,&#8600;,&#8601;,&#18;,&brvbar;,&sect;,&uml;,&ordf;,&not;,&macr;,&para;,&deg;,&plusmn;,&laquo;,&raquo;,&middot;,&cedil;,&ordm;,&sup1;,&sup2;,&sup3;,&frac14;,&frac12;,&frac34;,&iquest;,&times;,&divide;" 
    Height="250px" 
    UploadedFilesDirectory="../uploadFiles/images/" ImageDirectory="~/ig_common/Images/HtmlEditor/" TabIndex="2">
        <Toolbar Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="DoubleSeparator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Bold" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Italic" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Underline" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Strikethrough" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Subscript" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Superscript" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Cut" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Copy" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Paste" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Undo" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Redo" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="JustifyLeft" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="JustifyCenter" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="JustifyRight" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="JustifyFull" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Indent" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Outdent" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="UnorderedList" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="OrderedList" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="InsertRule">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="InsertRule" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="RowSeparator" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="DoubleSeparator" />
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="FontColor">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="FontHighlight">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="SpecialCharacter">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="SpecialCharacterPicker" Type="InternalWindow" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarMenuButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="InsertTable">
                <Menu Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False">
                    <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" InternalDialogType="InsertTable" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnRight" Font-Bold="False"
                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="InsertColumnLeft" Font-Bold="False"
                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowAbove" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="InsertRowBelow" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="DeleteRow" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="DeleteColumn" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseColspan" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseColspan" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="IncreaseRowspan" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="DecreaseRowspan" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" InternalDialogType="CellProperties" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" InternalDialogType="ModifyTable" />
                    </ighedit:HtmlBoxMenuItem>
                </Menu>
            </ighedit:ToolbarMenuButton>
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="ToggleBorders" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="InsertLink" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="RemoveLink" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Save" />
            <ighedit:ToolbarUploadButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="Open">
                <Upload Filter="*.htm,*.html,*.asp,*.aspx" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Height="350px"
                    Mode="File" Width="500px" />
            </ighedit:ToolbarUploadButton>
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Preview" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Separator" />
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="FindReplace">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="FindReplace" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="InsertBookmark">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="InsertBookmark" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarUploadButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="InsertImage">
                <Upload Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" Height="420px" Width="500px" />
            </ighedit:ToolbarUploadButton>
            <ighedit:ToolbarUploadButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="InsertFlash">
                <Upload Filter="*.swf" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Height="440px" Mode="Flash" Width="500px" />
            </ighedit:ToolbarUploadButton>
            <ighedit:ToolbarUploadButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="InsertWindowsMedia">
                <Upload Filter="*.asf,*.wma,*.wmv,*.wm,*.avi,*.mpg,*.mpeg,*.m1v,*.mp2,*.mp3,*.mpa,*.mpe,*.mpv2,*.m3u,*.mid,*.midi,*.rmi,*.aif,*.aifc,*.aiff,*.au,*.snd,*.wav,*.cda,*.ivf"
                    Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" Height="400px" Mode="WindowsMedia" Width="500px" />
            </ighedit:ToolbarUploadButton>
            <ighedit:ToolbarDialogButton runat="server" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="Help">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="Text" />
            </ighedit:ToolbarDialogButton>
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="CleanWord" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="WordCount" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="PasteHtml" />
            <ighedit:ToolbarMenuButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Zoom">
                <Menu Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False">
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom25" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom50" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom75" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom100" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom200" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom300" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom400" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom500" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                    <ighedit:HtmlBoxMenuItem runat="server" Act="Zoom600" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                        <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                            Font-Underline="False" />
                    </ighedit:HtmlBoxMenuItem>
                </Menu>
            </ighedit:ToolbarMenuButton>
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="TogglePositioning" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="BringForward" />
            <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="SendBackward" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="RowSeparator" />
            <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="DoubleSeparator" />
            <ighedit:ToolbarDropDown runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="FontName">
            </ighedit:ToolbarDropDown>
            <ighedit:ToolbarDropDown runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="FontSize">
            </ighedit:ToolbarDropDown>
            <ighedit:ToolbarDropDown runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="FontFormatting">
            </ighedit:ToolbarDropDown>
            <ighedit:ToolbarDropDown runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="FontStyle">
            </ighedit:ToolbarDropDown>
            <ighedit:ToolbarDropDown runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                Font-Strikeout="False" Font-Underline="False" Type="Insert">
                <Items>
                    <ighedit:ToolbarDropDownItem runat="server" Act="Greeting" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                    <ighedit:ToolbarDropDownItem runat="server" Act="Signature" Font-Bold="False" Font-Italic="False"
                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                </Items>
            </ighedit:ToolbarDropDown>
        </Toolbar>
        <RightClickMenu Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
            <ighedit:HtmlBoxMenuItem runat="server" Act="Cut" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="Copy" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="Paste" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="CellProperties" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" InternalDialogType="ModifyTable" />
            </ighedit:HtmlBoxMenuItem>
            <ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage" Font-Bold="False" Font-Italic="False"
                Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" />
            </ighedit:HtmlBoxMenuItem>
        </RightClickMenu>
        <DropDownStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
            Font-Underline="False" />
        <ProgressBar Font-Bold="False" Font-Italic="False" Font-Overline="False"
            Font-Strikeout="False" Font-Underline="False" />
        <DownlevelTextArea Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
            Font-Underline="False" />
        <TextWindow Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
            Font-Underline="False" />
        <DownlevelLabel Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
            Font-Underline="False" />
        <TabStrip Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
            Font-Underline="False" />
    </ighedit:WebHtmlEditor>
    <!--the writer head end-->
    </td>
    </tr>
    <tr>
    <td align="left" valign="top"></td>
    </tr>
    </table>
    <!--the title end-->
    </div>
    </form>
</body>
</html>
