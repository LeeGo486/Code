<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Sign_BP_SignChkDetail, App_Web_bp_signchkdetail.aspx.9fbedc62" %>
<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>新增采购发布</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/select.js"></script>
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
     <script type="text/javascript">
        var GB_ROOT_DIR = "../../../greybox/";
    </script>

    <script type="text/javascript" src="../../../greybox/AJS.js"></script>
    <script type="text/javascript" src="../../../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../../../greybox/gb_scripts.js"></script>
   <link href="../../../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
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


</script>
       <script language="javascript" type="text/javascript">
        function addFile()
    {
       
    	var str = '<INPUT type="file" size="50" runat="server"  class="tbinput" style="width: 450px" NAME="File">'
    	document.getElementById('MyFile').insertAdjacentHTML("beforeEnd",str)
    	
    }
            function GoUrlShowAddTrack(pid) 
        { 
        		var id=	window.document.getElementById("TxtSignCode").value;
		        if (id=="" || id==undefined)
		        {
		            window.alert("请先保存主单数据!");
		        }
		        else
		        {
                    // var url="BP_SignUserShow.aspx?pid="+window.document.getElementById("TxtSignCode").value;
                     var url="BP_SignUserShow.aspx?pid="+pid;
	                 var result=LoadWindow(url,860,653);
	             }
        }
            function GoUrlShowAddModel() 
        { 
        		var id=	window.document.getElementById("TxtSignCode").value;
		        if (id=="" || id==undefined)
		        {
		            window.alert("请先保存主单数据!");
		        }
		        else
		        {
                     var url="BP_SignFileModelShow.aspx?pid="+window.document.getElementById("TxtSignCode").value;
	                 var result=LoadWindow(url,860,653);
	             }
        }
        function GoUrlShowAddMater() 
        { 
        		var id=	window.document.getElementById("TxtSignCode").value;
		        if (id=="" || id==undefined)
		        {
		            window.alert("请先保存主单数据!");
		        }
		        else
		        {
//		             var url="/buyproduct/manager/publish/BP_PublishAddMater.aspx?pid="+window.document.getElementById("TxtSignCode").value;
//	                 var result=showaspx(url,860,653);
                     var url="BP_SignAddMater.aspx?pid="+window.document.getElementById("TxtSignCode").value;
	                 var result=LoadWindow(url,860,653);
	             }
        }
            function GoUrlShowEditMater(msid) 
        { 
        			var id=	window.document.getElementById("TxtSignCode").value;
//		        if (id=="" || id==undefined)
//		        {
//		            window.alert("请先保存主单数据!");
//		        }
//		        else
//		        {
//		             var url="/buyproduct/manager/publish/BP_PublishEditMater.aspx?MaterSubid="+msid;
//	                 var result=showaspx(url,860,653);
                     var url="BP_SignEditMater.aspx?MaterSubid="+msid;
	                 var result=LoadWindow(url,860,653);
//	            }
	        
       }
        function GoUrlShowADDSuper() 
        { 
          
        			var id=	window.document.getElementById("TxtSignCode").value;
		        if (id=="" || id==undefined)
		        {
		            window.alert("请先保存主单数据!");
		        }
		        else
		        {
		             var url="BP_SignAddSuper.aspx?pid="+id;
	                  LoadWindow(url,860,653);
	            }
	        
       }
         function GoUrlShowAddMaterL18() 
        { 
        			var id=	window.document.getElementById("TxtSignCode").value;
		        if (id=="" || id==undefined)
		        {
		            window.alert("请先保存主单数据!");
		        }
		        else
		        {

                    var url="BP_PublishMaterModle.aspx?pid="+window.document.getElementById("TxtSignCode").value;
	                 var result=LoadWindow(url,860,653);
	         }

        }
        function gop() 
        { 
        	     var id=window.document.getElementById("TxtSignCode").value;
		        //var aa=window.parent.location.href="BP_SignPrint.aspx?hid="+id;   
		         window.open("BP_SignPrint.aspx?hid="+id);
                  //window.location.href="BP_SignPrint.aspx?hid="id; 
                  //window.target = "_blank";
                  return false;   
	        
        }
         function post() 
        { 
        	     window.document.getElementById("HFState").value=1;
		        
	        
        }
    </script>
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能： 新增合同&nbsp;&nbsp;&nbsp;
					
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
        &nbsp;

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="返回待审列表" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='BP_SignWillChk.aspx'; return false;"   />
      <asp:Button ID="BtnChk" Width="100px" runat="server" Text="审 核" CssClass="btn" OnClick="btnChk_Click"  />
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="btnSave_Click"  OnClientClick="post()" />
       <asp:Button ID="BtnPrint" Width="100px" runat="server" Text="打印预览" CssClass="btn" OnClientClick="gop()"   />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    <div  class="BContent" style="height:100%">
     <!----contant------------------>
        <asp:HiddenField ID="HFSupplyerID" runat="server" />
        <asp:HiddenField ID="HFState" runat="server" />
            <!----contant------------------>
    <table width="100%">
    <tr>
    <td>
    <!--pi wen-->
     <table width="100%" class="tbBlock" >
        <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="100" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          <tr>
    <td>
        审核:</td>
          <td colspan="4">
              <asp:CheckBox ID="CheckBoxPass" runat="server" Text="审核通过" /></td>
    </tr>          
    <tr>
    <td>
        审核人:</td>
     <td>
         <asp:TextBox ID="TxtChkUser" runat="server" Width="200px" CssClass="tbox" MaxLength="50" Enabled="false"></asp:TextBox></td>
     <td>
    </td>
     <td>
         审核时间:</td>
     <td>
          <igsch:WebDateChooser ID="WebDateChooserChkDate" runat="server" Value="" Width="200px" Enabled="false">
            </igsch:WebDateChooser></td>
    </tr>
    
      <tr>
    <td>
        批文:</td>
          <td colspan="4">
              <asp:TextBox ID="TxtChkCommet" runat="server" Width="95%" CssClass="tbox" MaxLength="100"></asp:TextBox></td>
    </tr>
    </table>
    <!--pi wen end-->
    </td>
    </tr>
    <tr>
    <td>
    <!--old bill-->
    <table width="100%">
       <tr>
            <td align="center" style="height: 14px"><span style="font-size:14px">合同单</span>
        </td>
    </tr>
    <tr>
    <td>
    <hr />
    </td>
    </tr>
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
        <table    class="tbBlock"  >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="50" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
          
          <tr>
             <tr>
        <td style="height: 28px" >
            供应商名称:</td>
              <td align="left" style="height: 28px" >
                  <asp:TextBox ID="TxtCompName" runat="server" MaxLength="100" Width="200px" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator
                      ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtCompName"
                      ErrorMessage="*"></asp:RequiredFieldValidator></td>
            <td style="height: 28px">
            </td>
             <td style="height: 28px">    合同编号:</td>
             <td style="height: 28px">
            <asp:TextBox ID="TxtSignCode" runat="server" CssClass="tbox" MaxLength="50" Width="200"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtSignCode"
                     ErrorMessage="*"></asp:RequiredFieldValidator></td>
             
        </tr>  
                     <tr>
        <td style="height: 28px" >
            供应商编号:</td>
              <td align="left" style="height: 28px" >
            <asp:TextBox ID="TxtSupplyNo" runat="server" MaxLength="50" Width="200" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="TxtSupplyNo"></asp:RequiredFieldValidator></td>
            <td style="height: 28px">
            </td>
             <td style="height: 28px">    流程编号:</td>
             <td style="height: 28px"> 
                 <asp:TextBox ID="TxtSignUCode" runat="server" CssClass="tbox" MaxLength="50" Width="200"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtSignUCode"
                     ErrorMessage="*"></asp:RequiredFieldValidator></td>
             
        </tr>         
       <tr>
        <td >
            付 款方 式:</td>
              <td align="left" > 
                  <asp:TextBox ID="TxtPayment" runat="server" CssClass="tbox" MaxLength="50" Width="200"></asp:TextBox></td>
            <td>
            </td>
             <td>    签定日期:</td>
             <td> 
             <igsch:WebDateChooser ID="WebDateChooserSignDate" runat="server" Value="" Width="200">
            </igsch:WebDateChooser>
             </td>
             
        </tr>      
           <tr>
        <td style="height: 16px" >
            税 票种 类:</td>
        <td style="height: 16px" >
            <asp:TextBox ID="TxtChequeType" runat="server" CssClass="tbox" MaxLength="50" Width="200"></asp:TextBox></td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            制单时间:</td>
      
          <td style="height: 16px" >
              <igsch:WebDateChooser ID="WebDateChooserCrdate" runat="server" Value="" Width="200" Enabled="False">
            </igsch:WebDateChooser>
              </td>
        </tr>
        
                  <tr>
        <td style="height: 16px" >
            制&nbsp; 单&nbsp; 人:</td>
        <td style="height: 16px" >
            <asp:TextBox ID="TxtCrUser" runat="server" CssClass="tbox" MaxLength="50" Width="200" Enabled="False"></asp:TextBox></td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            合同模板:</td>
      
          <td style="height: 16px" >
              <asp:Button ID="BtnChoiceShop" runat="server" CssClass="NormalBtn" OnClientClick="GoUrlShowAddModel()"
                  Text="选择合同模板" Width="200px" /></td>
        </tr>
    
                  <tr>
        <td style="height: 16px" >
            选 &nbsp;&nbsp; 择:</td>
        <td style="height: 16px" ><asp:Button ID="BtnChoiceTrack" runat="server" CssClass="NormalBtn" OnClientClick="GoUrlShowADDSuper()"
                  Text="选择供应商" Width="200px" /></td>
     <td style="height: 16px" >
        
        </td>
        <td style="height: 16px">
            物料添加:</td>
      
          <td style="height: 16px" ><asp:Button ID="BtnAddMater" runat="server" CssClass="NormalBtn" OnClientClick="GoUrlShowAddMater()"
                  Text="物料添加" Width="200px" /></td>
        </tr>
           <tr>
        <td style="height: 16px" >
            备 &nbsp;&nbsp; &nbsp; 注:</td>
               <td colspan="4" style="height: 16px">
            <asp:TextBox ID="TxtCommet" runat="server" CssClass="tbox" Height="40px" MaxLength="50"
                TextMode="MultiLine" Width="90%"></asp:TextBox></td>
        </tr>
           <tr>
        <td >
            <input accesskey="z"  onclick="addFile()"  type="button" class="NormalBtn"
                value="增加附件" /></td>
        <td valign="top" colspan="4" >
                <P id="MyFile">
                            <input id="File1" runat="server" class="tbox" name="File" style="width: 450px" onchange="document.all.ctl00_ContentPlaceHolder1_ImageShopPic.ImageUrl=this.value;if(document.all.ctl00_ContentPlaceHolder1_ImageShopPic.height>document.all.ctl00_ContentPlaceHolder1_ImageShopPic.width){document.all.ctl00_ContentPlaceHolder1_ImageShopPic.height=150;}else{document.all.ctl00_ContentPlaceHolder1_ImageShopPic.width=150;}"
                                type="file" />&nbsp;</P>
               </td>
        </tr>
        <tr>
        <td style="height: 14px"></td>
        <td valign="top" colspan="4" style="height: 14px">
                              
        </td>
        </tr>
         
        </table>
    </td>
    </tr>
    <tr>
    <td>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SignFileID"  CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        
            <Columns>
               
                 <asp:TemplateField HeaderText="文件名称" SortExpression="Signfilename">
                    <ItemTemplate>
                   <a href="../../../<%# Eval("fileUrl")%>" target="_blank"><img src="../../../icon/go3.gif" border="0" /><%# Eval("Signfilename")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="crdate" DataFormatString="{0:d}" HeaderText="上传日期" HtmlEncode="False"
                    SortExpression="crdate" />
                 <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                    <asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader"   />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="CG_DelSignFile"
            SelectMethod="CG_SignFile" TypeName="ddl_cgnew" >
            <DeleteParameters>
                <asp:Parameter Name="SignFileID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TxtSignCode" Name="SignCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </td>
    </tr>
    <tr>
    <td><a href="#" title="查看合同上部内容"  onClick='showDiv2(1)' id="ShowDivLink"><img src="../../../icon/go3.gif" border="0" />查看合同上部内容</a>
    </td>
    </tr>
    <tr>
    <td valign="top" align="left">
    <div id="input2_1" style="display:none;">
    <table width="100%">
    <tr>
    <td>
     <!--the wriehead-->
        <ighedit:WebHtmlEditor ID="whtmlHeader" runat="server"  Width="100%" BackgroundImageName="" 
    FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>" FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7" FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset=" SpecialCharacterList="&#937;,&#931;,&#916;,&#934;,&#915;,&#936;,&#928;,&#920;,&#926;,&#923;,&#958;,&#956;,&#951;,&#966;,&#969;,&#949;,&#952;,&#948;,&#950;,&#968;,&#946;,&#960;,&#963;,&szlig;,&thorn;,&THORN;,&#402,&#1046;,&#1064;,&#1070;,&#1071;,&#1078;,&#1092;,&#1096;,&#1102;,&#1103;,&#12362;,&#12354;,&#32117;,&AElig;,&Aring;,&Ccedil;,&ETH;,&Ntilde;,&Ouml;,&aelig;,&aring;,&atilde;,&ccedil;,&eth;,&euml;,&ntilde;,&cent;,&pound;,&curren;,&yen;,&#8470;,&#153;,&copy;,&reg;,&#151;,@,&#149;,&iexcl;,&#14;,&#8592;,&#8593;,&#8594;,&#8595;,&#8596;,&#8597;,&#8598;,&#8599;,&#8600;,&#8601;,&#18;,&brvbar;,&sect;,&uml;,&ordf;,&not;,&macr;,&para;,&deg;,&plusmn;,&laquo;,&raquo;,&middot;,&cedil;,&ordm;,&sup1;,&sup2;,&sup3;,&frac14;,&frac12;,&frac34;,&iquest;,&times;,&divide;" 
    Height="130px" 
    UploadedFilesDirectory="../uploadFiles/images/" ImageDirectory="~/ig_common/Images/HtmlEditor/">
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
    </table>
   </div>
    </td>
    </tr>
 
   <tr>
    <td>
    <table width="100%">
    <tr>
    <td >
        </td>
    </tr>
  
     <tr>
   
    <td >
    
            <asp:GridView ID="GridViewMater" runat="server" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupmaterID"  CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" OnRowDataBound="GridViewMater_RowDataBound">
            <FooterStyle   BackColor="#EFF3FB" HorizontalAlign="Center"  />
            <Columns>
                   
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="False" />
                    <asp:BoundField DataField="MaterID" HeaderText="物料编号" SortExpression="MaterID" />
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="Maternum" HeaderText="数量" SortExpression="Maternum" />
                    <asp:BoundField DataField="Unit" HeaderText="单位" SortExpression="Unit" />
                    <asp:BoundField DataField="MaterPirce" HeaderText="单价" SortExpression="MaterPirce" />
                    <asp:BoundField DataField="MaterTax" HeaderText="税率" SortExpression="MaterTax" />
                    <asp:BoundField DataField="PriceSum" HeaderText="总金额" SortExpression="PriceSum" />
                 <asp:BoundField DataField="MaterCommet" HeaderText="备注" SortExpression="MaterCommet" />
                    <asp:TemplateField HeaderText="编辑">
                        <ItemTemplate>
                        <img src="../../../icon/go3.gif" border="0" />
                        <asp:LinkButton ID="lbtnCheck" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# Eidtstring(Eval("SupmaterID").ToString()) %>'
                        CommandName="Check" Text='编辑' >
                         </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="TrackUserID" HeaderText="跟进人" SortExpression="TrackUserID"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" FooterStyle-CssClass="hidden"  />
                    <asp:TemplateField HeaderText="跟进人">
                        <ItemTemplate>
                       
                          <img src="../../../icon/go3.gif" border="0" onclick="<%# EidtSupter(Eval("SupmaterID").ToString()) %>" /> 
                          <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# EidtSupter(Eval("SupmaterID").ToString()) %>'
                        CommandName="Check" Text='<%# Eval("TrackUserID") %>' >
                         </asp:LinkButton>
                           
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                    <asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../../../icon/delete.gif" CommandName="delete"  OnClientClick="return confirm('确认要删除此数据吗？')"  CausesValidation="False" ></asp:ImageButton>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                   
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                         <th scope="col">物料编号</th>
                            <th scope="col">物料名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">采购数量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货时间</th>
                            <th scope="col">供应商</th>
                    </tr>
                     <tr  bgcolor="White">
                      <th scope="col"></th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader"   />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="CG_DelSignMater" 
         SelectMethod="CG_GetSignMaterBySignID" TypeName="ddl_cgnew" >
            <DeleteParameters>
                <asp:Parameter Name="SupmaterID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TxtSignCode" Name="SignCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </td>
    </tr>
    </table>
    </td>
    </tr>
   <tr>
    <td><a href="#" title="查看合同底部内容"  onClick='showDiv2(2)' id="A1"><img src="../../../icon/go3.gif" border="0" />查看合同底部内容</a></td>
    </tr>
    <tr>
    <td valign="top" align="left">
        <div id="input2_2" style="display:none;">
    <table width="100%">
    <tr>
    <td>
     <!--the wriehead-->
        <ighedit:WebHtmlEditor ID="whtmlFoot" runat="server"  Width="100%" BackgroundImageName="" 
    FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>" FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7" FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset=" SpecialCharacterList="&#937;,&#931;,&#916;,&#934;,&#915;,&#936;,&#928;,&#920;,&#926;,&#923;,&#958;,&#956;,&#951;,&#966;,&#969;,&#949;,&#952;,&#948;,&#950;,&#968;,&#946;,&#960;,&#963;,&szlig;,&thorn;,&THORN;,&#402,&#1046;,&#1064;,&#1070;,&#1071;,&#1078;,&#1092;,&#1096;,&#1102;,&#1103;,&#12362;,&#12354;,&#32117;,&AElig;,&Aring;,&Ccedil;,&ETH;,&Ntilde;,&Ouml;,&aelig;,&aring;,&atilde;,&ccedil;,&eth;,&euml;,&ntilde;,&cent;,&pound;,&curren;,&yen;,&#8470;,&#153;,&copy;,&reg;,&#151;,@,&#149;,&iexcl;,&#14;,&#8592;,&#8593;,&#8594;,&#8595;,&#8596;,&#8597;,&#8598;,&#8599;,&#8600;,&#8601;,&#18;,&brvbar;,&sect;,&uml;,&ordf;,&not;,&macr;,&para;,&deg;,&plusmn;,&laquo;,&raquo;,&middot;,&cedil;,&ordm;,&sup1;,&sup2;,&sup3;,&frac14;,&frac12;,&frac34;,&iquest;,&times;,&divide;" 
    Height="130px" 
    UploadedFilesDirectory="../uploadFiles/images/" ImageDirectory="~/ig_common/Images/HtmlEditor/">
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
    </table>
   </div>
    </td>
    </tr>
    </table>
      <!--old bill end-->
    </td>
    </tr>
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>