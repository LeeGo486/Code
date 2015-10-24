<%@ page language="C#" autoeventwireup="true" inherits="isprit_mail_mail_write, App_Web_mail_write.aspx.2cabe2e1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>写邮件</title>
    		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<link href="../../css/project.css" type="text/css" rel="stylesheet"/>
    <script defer="defer" type="text/javascript">
    	justNew(location.href,"写邮件");
    </script>
		<script language="JavaScript" type="text/javascript">

function CheckForm(){

   if (document.all.TO_ID.value==""&&(!document.getElementById("cbLinkman").checked))
   { alert("请添加收件人！");
     return (false);
   }
     if (document.all.tbtitle.value=="")
   { alert("请填写邮件标题！");
     document.all.tbtitle.focus();
     return (false);
   }
   return (true);
  }
//清除用户
function clear_user()
{
  document.all.TO_NAME.value="";
  document.all.TO_ID.value="";
}
//清除文件
function clear_file()
{
  document.all.TO_FILE.value="";
  document.all.HFILE.value="";
}

    //调用联系人窗口
    function calluser(){
        var east = parent.Ext.getCmp('east');
		if(east){
			if(east.collapsed){
				east.expand(false);//展开联系人：里面的false是要不要动画效果的意思
			}else{
				east.collapse(false);
			}
		}
    }

function addFile()
{
	var str = '<input type="file" style="width: 468px"  runat="server" name="File" />'
	document.getElementById('iUpload').insertAdjacentHTML("beforeEnd",str)
}

</script>
</head>
<body style="margin:1px;">
    <form id="form1" runat="server">
    <div>
    <TABLE cellSpacing=1 cellPadding=0 width="650px" border=0><TBODY>
   <TR><td style="width: 542px">
   <fieldset><legend>发送邮件</legend>
   邮件标题 <asp:TextBox id="tbtitle" runat="server" Width="331px" CssClass="tb"></asp:TextBox> 
<asp:CheckBox id="cbmsg" runat="server" Checked="True" ForeColor="DodgerBlue" Text="使用短消息提醒对方"></asp:CheckBox>
   <TEXTAREA style="WIDTH: 518px; HEIGHT: 45px; BACKGROUND-COLOR: #eeeeee" id="TO_NAME" class="BigStatic" name="TO_NAME" readOnly  cols=62 runat="server"></TEXTAREA>
   
   </fieldset>
    
    <fieldset> <LEGEND style="WIDTH: 35px; HEIGHT: 15px" align="left">邮件附件</LEGEND><p id="iUpload">
     </p>
    <p><input type="button" value="添加附件.." onclick="addFile();" class="btn" /></p></fieldset>
   </td>
<td align=center style="width: 101px" valign="top">
    <br />
    <br />
    <%--<INPUT type="button" onclick="LoadWindow('../module/selectpeople.aspx',405,480,this.value,true,'50%')" value="添加收信人(A)"
								class="btn"  accessKey="A">--%>
								<INPUT type="button" onclick="calluser()" value="收件人(A)"
								class="btn"  accessKey="A">
   <INPUT id="TO_ID" type=hidden name="TO_ID" runat="server" style="width: 88px" />
    <INPUT  class="btn" title="清空收件人" onclick="clear_user()" type=button value="清 空" name="button" /><FONT face="宋体"><asp:CheckBox 
        ID="cbLinkman" runat="server" Text="所有联系人" />
                        </FONT>
					    </td></TR>
</TBODY></TABLE>
    
    <ighedit:WebHtmlEditor ID="whtml" runat="server"  Width="660px" BackgroundImageName="" FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>" FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7" FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset=" SpecialCharacterList="&#937;,&#931;,&#916;,&#934;,&#915;,&#936;,&#928;,&#920;,&#926;,&#923;,&#958;,&#956;,&#951;,&#966;,&#969;,&#949;,&#952;,&#948;,&#950;,&#968;,&#946;,&#960;,&#963;,&szlig;,&thorn;,&THORN;,&#402,&#1046;,&#1064;,&#1070;,&#1071;,&#1078;,&#1092;,&#1096;,&#1102;,&#1103;,&#12362;,&#12354;,&#32117;,&AElig;,&Aring;,&Ccedil;,&ETH;,&Ntilde;,&Ouml;,&aelig;,&aring;,&atilde;,&ccedil;,&eth;,&euml;,&ntilde;,&cent;,&pound;,&curren;,&yen;,&#8470;,&#153;,&copy;,&reg;,&#151;,@,&#149;,&iexcl;,&#14;,&#8592;,&#8593;,&#8594;,&#8595;,&#8596;,&#8597;,&#8598;,&#8599;,&#8600;,&#8601;,&#18;,&brvbar;,&sect;,&uml;,&ordf;,&not;,&macr;,&para;,&deg;,&plusmn;,&laquo;,&raquo;,&middot;,&cedil;,&ordm;,&sup1;,&sup2;,&sup3;,&frac14;,&frac12;,&frac34;,&iquest;,&times;,&divide;" Height="253px">
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

        &nbsp;<asp:Button ID="btsend" runat="server" Text="发送邮件(S)" Width="140px" OnClick="btsend_Click" />
   
    </div>
    </form>

</body>
</html>
