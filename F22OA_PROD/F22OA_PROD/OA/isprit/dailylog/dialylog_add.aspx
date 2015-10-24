<%@ page language="C#" autoeventwireup="true" inherits="isprit_dailylog_dialylog_add, App_Web_dialylog_add.aspx.d55211a1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
        <title>日志新增</title>
    		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
			<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body>
    <form id="form1" runat="server">
   
     <div><table><tr><td><h3>
        <strong>日志记录</strong>
            </h3></td><td>   <igsch:WebDateChooser ID="dtc" runat="server">
                </igsch:WebDateChooser></td><td>日志类型</td><td style="width: 3px">
                    <asp:RadioButtonList ID="rbl" runat="server" BorderColor="White" ForeColor="MenuText"
                        RepeatDirection="Horizontal" Width="168px">
                        <asp:ListItem Selected="True" Value="1">工作日志</asp:ListItem>
                        <asp:ListItem Value="2">个人日志</asp:ListItem>
                    </asp:RadioButtonList></td></tr></table>    
            
       
    <div>
        <ighedit:webhtmleditor id="WHTML" runat="server" height="293px" width="680px" BackgroundImageName="" FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>" FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7" FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset=" SpecialCharacterList="&#937;,&#931;,&#916;,&#934;,&#915;,&#936;,&#928;,&#920;,&#926;,&#923;,&#958;,&#956;,&#951;,&#966;,&#969;,&#949;,&#952;,&#948;,&#950;,&#968;,&#946;,&#960;,&#963;,&szlig;,&thorn;,&THORN;,&#402,&#1046;,&#1064;,&#1070;,&#1071;,&#1078;,&#1092;,&#1096;,&#1102;,&#1103;,&#12362;,&#12354;,&#32117;,&AElig;,&Aring;,&Ccedil;,&ETH;,&Ntilde;,&Ouml;,&aelig;,&aring;,&atilde;,&ccedil;,&eth;,&euml;,&ntilde;,&cent;,&pound;,&curren;,&yen;,&#8470;,&#153;,&copy;,&reg;,&#151;,@,&#149;,&iexcl;,&#14;,&#8592;,&#8593;,&#8594;,&#8595;,&#8596;,&#8597;,&#8598;,&#8599;,&#8600;,&#8601;,&#18;,&brvbar;,&sect;,&uml;,&ordf;,&not;,&macr;,&para;,&deg;,&plusmn;,&laquo;,&raquo;,&middot;,&cedil;,&ordm;,&sup1;,&sup2;,&sup3;,&frac14;,&frac12;,&frac34;,&iquest;,&times;,&divide;">
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
        Font-Strikeout="False" Font-Underline="False" Key="s" RaisePostback="True" Type="Save" />
    <ighedit:ToolbarUploadButton runat="server" Font-Bold="False" Font-Italic="False"
        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Type="Open">
        <Upload Filter="*.jpg,*.jpeg,*.gif,*.html" Font-Bold="False" Font-Italic="False"
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
            <ProgressBar Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <DownlevelTextArea Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <TextWindow Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <DownlevelLabel Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <TabStrip Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
</ighedit:webhtmleditor>
        <br />
    
										<asp:Button ID="btsend1" Runat="server" Text="添加|编辑(A)" accessKey="a" OnClick="btsend1_Click" CssClass="btr"></asp:Button>
								
    </div>
    </div>
    </form>
</body>
</html>
