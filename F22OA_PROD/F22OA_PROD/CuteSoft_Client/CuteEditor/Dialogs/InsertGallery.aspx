<%@ Register TagPrefix="CC1" TagName="ThumbList" Src="ThumbList.ascx" %>
<%@ Register TagPrefix="CE" Assembly="CuteEditor" Namespace="CuteEditor" %>
<%@ Page Language="C#" Inherits="CuteEditor.Dialogs.InsertGalleryFrame" %>
<script runat="server">
override protected void OnInit(EventArgs args)
{
	if(Context.Request.QueryString["IsFrame"]==null)
	{
		string FrameSrc="InsertGallery.Aspx?IsFrame=1&"+Request.ServerVariables["QUERY_STRING"];
		CuteEditor.CEU.WriteDialogOuterFrame(Context,"[[ImageGalleryByBrowsing]]",FrameSrc);
		Context.Response.End();
	}
	base.OnInit(args);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>		
	    <title></title>
		<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.1)" />
		<meta http-equiv="Page-Exit" content="blendTrans(Duration=0.1)" />
		<link href="Load.ashx?type=style&file=dialog.css" type="text/css" rel="stylesheet" />
		<!--[if IE]>
			<link href="Load.ashx?type=style&file=IE.css" type="text/css" rel="stylesheet" />
		<![endif]-->
		<script type="text/javascript" src="Load.ashx?type=dialogscript&file=DialogHead.js"></script>
		<script type="text/javascript">
		
						
			var OxO98e7=["lightyellow","0px","-3px","all","getElementById","\x3Cdiv id=\x22tooltipdiv\x22 style=\x22visibility:hidden;background-color:","\x22 \x3E\x3C/div\x3E","left","offsetLeft","offsetTop","offsetParent","top","style","type","visibility","click","mouseover","compatMode","BackCompat","documentElement","body","rightedge","opera","clientWidth","scrollLeft","innerWidth","pageXOffset","offsetWidth","contentmeasure","x","clientHeight","scrollTop","innerHeight","pageYOffset","offsetHeight","y","event","cancelBubble","stopPropagation","tooltipdiv","innerHTML","visible","hidden","px","bottomedge","undefined","hidetip()"];var tipbgcolor=OxO98e7[0x0];var disappeardelay=0xfa;var vertical_offset=OxO98e7[0x1];var horizontal_offset=OxO98e7[0x2];var ie4=document[OxO98e7[0x3]];var ns6=document[OxO98e7[0x4]]&&!document[OxO98e7[0x3]];if(ie4||ns6){ document.write(OxO98e7[0x5]+tipbgcolor+OxO98e7[0x6]) ;} ; function getposOffset(Oxab,Oxac){var Oxad=(Oxac==OxO98e7[0x7])?Oxab[OxO98e7[0x8]]:Oxab[OxO98e7[0x9]];var Oxae=Oxab[OxO98e7[0xa]];while(Oxae!=null){ Oxad=(Oxac==OxO98e7[0x7])?Oxad+Oxae[OxO98e7[0x8]]:Oxad+Oxae[OxO98e7[0x9]] ; Oxae=Oxae[OxO98e7[0xa]] ;} ;return Oxad;}  ; function showhide(obj,Oxb0,Oxb1,Oxb2){if(ie4||ns6){ dropmenuobj[OxO98e7[0xc]][OxO98e7[0x7]]=dropmenuobj[OxO98e7[0xc]][OxO98e7[0xb]]=-0x1f4 ;} ;if(Oxb0[OxO98e7[0xd]]==OxO98e7[0xf]&&obj[OxO98e7[0xe]]==Oxb2||Oxb0[OxO98e7[0xd]]==OxO98e7[0x10]){ obj[OxO98e7[0xe]]=Oxb1 ;} else {if(Oxb0[OxO98e7[0xd]]==OxO98e7[0xf]){ obj[OxO98e7[0xe]]=Oxb2 ;} ;} ;}  ; function iecompattest(){return (document[OxO98e7[0x11]]&&document[OxO98e7[0x11]]!=OxO98e7[0x12])?document[OxO98e7[0x13]]:document[OxO98e7[0x14]];}  ; function clearbrowseredge(obj,Oxb5){var Oxb6=(Oxb5==OxO98e7[0x15])?parseInt(horizontal_offset)*-0x1:parseInt(vertical_offset)*-0x1;if(Oxb5==OxO98e7[0x15]){var Oxb7=ie4&&!window[OxO98e7[0x16]]?iecompattest()[OxO98e7[0x18]]+iecompattest()[OxO98e7[0x17]]-0xf:window[OxO98e7[0x1a]]+window[OxO98e7[0x19]]-0xf; dropmenuobj[OxO98e7[0x1c]]=dropmenuobj[OxO98e7[0x1b]] ;if(Oxb7-dropmenuobj[OxO98e7[0x1d]]<dropmenuobj[OxO98e7[0x1c]]){ Oxb6=dropmenuobj[OxO98e7[0x1c]]-obj[OxO98e7[0x1b]] ;} ;} else {var Oxb7=ie4&&!window[OxO98e7[0x16]]?iecompattest()[OxO98e7[0x1f]]+iecompattest()[OxO98e7[0x1e]]-0xf:window[OxO98e7[0x21]]+window[OxO98e7[0x20]]-0x12; dropmenuobj[OxO98e7[0x1c]]=dropmenuobj[OxO98e7[0x22]] ;if(Oxb7-dropmenuobj[OxO98e7[0x23]]<dropmenuobj[OxO98e7[0x1c]]){ Oxb6=dropmenuobj[OxO98e7[0x1c]]+obj[OxO98e7[0x22]] ;} ;} ;return Oxb6;}  ; function showTooltip(Oxb9,obj,Oxb0){if(window[OxO98e7[0x24]]){ event[OxO98e7[0x25]]=true ;} else {if(Oxb0[OxO98e7[0x26]]){ Oxb0.stopPropagation() ;} ;} ; clearhidetip() ; dropmenuobj=document[OxO98e7[0x4]]?document.getElementById(OxO98e7[0x27]):tooltipdiv ; dropmenuobj[OxO98e7[0x28]]=Oxb9 ;if(ie4||ns6){ showhide(dropmenuobj.style,Oxb0,OxO98e7[0x29],OxO98e7[0x2a]) ; dropmenuobj[OxO98e7[0x1d]]=getposOffset(obj,OxO98e7[0x7]) ; dropmenuobj[OxO98e7[0x23]]=getposOffset(obj,OxO98e7[0xb]) ; dropmenuobj[OxO98e7[0xc]][OxO98e7[0x7]]=dropmenuobj[OxO98e7[0x1d]]-clearbrowseredge(obj,OxO98e7[0x15])+OxO98e7[0x2b] ; dropmenuobj[OxO98e7[0xc]][OxO98e7[0xb]]=dropmenuobj[OxO98e7[0x23]]-clearbrowseredge(obj,OxO98e7[0x2c])+obj[OxO98e7[0x22]]+OxO98e7[0x2b] ;} ;}  ; function hidetip(Oxb0){if( typeof dropmenuobj!=OxO98e7[0x2d]){if(ie4||ns6){ dropmenuobj[OxO98e7[0xc]][OxO98e7[0xe]]=OxO98e7[0x2a] ;} ;} ;}  ; function delayhidetip(){if(ie4||ns6){ delayhide=setTimeout(OxO98e7[0x2e],disappeardelay) ;} ;}  ; function clearhidetip(){if( typeof delayhide!=OxO98e7[0x2d]){ clearTimeout(delayhide) ;} ;}  ;
		</script>
		<style type="text/css">
			INPUT {border:black 1px solid; FONT-SIZE: 8pt; VERTICAL-ALIGN: middle; CURSOR: pointer; FONT-FAMILY: MS Sans Serif; margin-bottom:2px; }
			A:link { COLOR: #000099 }
			A:visited { COLOR: #000099 }
			A:active { COLOR: #000099 }
			A:hover { COLOR: darkred }
			#tooltipdiv{
			position:absolute;
			padding: 2px;
			border:1px solid black;
			font:menu;
			z-index:100;
			}
		</style>
	</head>
	<body style="overflow:auto">
		<form runat="server" enctype="multipart/form-data" id="Form1">
			<input type="hidden" runat="server" enableviewstate="false" id="hiddenAlert" name="hiddenAlert" />
			<fieldset>
				<legend>
					[[ImageGalleryByBrowsing]]
				</legend>
				<div>
					<asp:Table runat="server" Width="100%" id="FoldersAndFiles">
						<asp:TableRow>
							<asp:TableCell Width="20" HorizontalAlign="right">
								<asp:Image runat="server" ImageUrl="../Load.ashx?type=image&file=openfolder.gif" id="Image1"></asp:Image>
							</asp:TableCell>
							<asp:TableCell HorizontalAlign="left" ColumnSpan="2">
								<asp:Label runat="server" id="FolderDescription"></asp:Label>
							</asp:TableCell>
						</asp:TableRow>
					</asp:Table>
				</div>
				<table width="100%" cellspacing="2" cellpadding="0" border="0" align="center">
					<tr>
						<td class="normal" style="padding-left:3px">
							[[Size]]:
							<asp:DropDownList id="cbThumbSize" runat="server" AutoPostBack="True"></asp:DropDownList>
							[[Columns]]:
							<asp:DropDownList id="cbColumns" runat="server" AutoPostBack="True"></asp:DropDownList>
							[[Rows]]:
							<asp:DropDownList id="cbRows" runat="server" AutoPostBack="True"></asp:DropDownList>
							[[Type]]:
							<asp:DropDownList id="cbTypes" runat="server" AutoPostBack="True"></asp:DropDownList>
							<asp:DropDownList id="cbSorts" Runat="server" AutoPostBack="True"></asp:DropDownList>
						
						</td>
					</tr>
					<tr>
						<td class="normal" style="padding-left:3px">
							<CE:UploadSingleFile id="myuploadFile" runat="server"></CE:UploadSingleFile>
						</td>
					</tr>
					<tr>
						<td>
							<CC1:ThumbList id="ThumbList1" runat="server"></CC1:ThumbList>
						</td>
					</tr>
				</table>
			</fieldset>
			<p style="text-align:center">
				<input type="button" value="[[Cancel]]" onclick="cancel();" />
			</p>
		</form>
	</body>
	<script type="text/javascript" src="Load.ashx?type=dialogscript&file=DialogFoot.js"></script>
	<script type="text/javascript" src="Load.ashx?type=dialogscript&file=Dialog_InsertGallery.js"></script>
</html>
