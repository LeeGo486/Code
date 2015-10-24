<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_filedetail, App_Web_filedetail.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">
    <title>查看与修改文档</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
    <base target="_self" />
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <link href="../inquire/scripts/project.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../inquire/scripts/project.js"></script>
    <script type="text/javascript">
    function getFilename(){
        var fileurl = document.getElementById("fileurl").value;
        var fname = document.getElementById("fname");
        ex1 = fileurl.split("\\");
          if(ex1.length>1){
            fname.value= ex1[(ex1.length-1)];
          }
    }
    function choDepot(url,w,h){
        var m = showModalDialog(url,"d","dialogWidth:"+w+"px;dialogHeight:"+h+"px;center: yes;help:no;resizable:no;status:no");
        //alert(m);
        if(m){
            s = m.split("||")
            document.getElementById("depotid").value=s[0];
            document.getElementById("depotname").innerText=s[1];
        }
        return false;
    }
    </script>
    
    
</head>
<body>
    <form id="form1" runat="server">
<div style="text-align:center;"><asp:Label ID="Label2" runat="server" Width="100%" ForeColor="Red"></asp:Label></div>
   <div id="lrTable">
        <table border="0" cellpadding="3" cellspacing="1" width="90%">
            <tr>
                <td>
                    文档类型：</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="box1">
                    </asp:DropDownList>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="DropDownList1"
                        MaximumValue="9999" MinimumValue="1" Type="Integer">请选择文档类型</asp:RangeValidator>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>
            </tr>
            <tr style="color: #000000">
                <td>
                    店　　铺：</td>
                <td>
                    <asp:TextBox ID="depotid" runat="server" Width="80px" AutoPostBack="True" 
                        ontextchanged="depotid_TextChanged"></asp:TextBox>
                    <asp:Label ID="depotname" runat="server"></asp:Label>
                    <asp:Button ID="chodepot" runat="server" CssClass="btn2" 
                        onclientclick="javascript:return choDepot('depotListbyArea.aspx',200,600);" Text="选店铺..." 
                        UseSubmitBehavior="False" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="depotid"
                        ErrorMessage="RequiredFieldValidator">请选择一个店铺</asp:RequiredFieldValidator>
                    
                </td>
            </tr>
            <tr style="color: #000000">
                <td>
                    文档路径：</td>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink></td>
            </tr>
            <tr style="color: #000000">
                <td>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="修改文档："  /></td>
                <td>
                
                    <asp:FileUpload ID="fileurl" runat="server" CssClass="btn2" Width="350px" />&nbsp;
                        </td>
            </tr>
            <tr>
                <td>
                    文档名称：</td>
                <td>
                    <asp:TextBox ID="fname" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator"
                     ControlToValidate="fname">请输入文档名称</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>
                    备　　注：</td>
                <td>
                    <asp:TextBox ID="crrmk" runat="server" Rows="2" TextMode="MultiLine" Width="350px" MaxLength="255"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <asp:Button ID="Button1" runat="server" CssClass="btn" Text="修　改"
                        Enabled="False" onclick="Button1_Click" />
                    <asp:Button ID="Button2" runat="server" CssClass="btn" Text="审　核" 
                        Enabled="False" onclick="Button2_Click" />
                    <asp:Button ID="Button3" runat="server" CssClass="btn" Text="移　除" 
                        Enabled="False" onclick="Button3_Click" />
                    <asp:Button ID="Button4" runat="server" CssClass="btn" Text="恢　复" 
                        Enabled="False" onclick="Button4_Click" />
                    <asp:Button ID="Button5" runat="server" CssClass="btn" Text="关　闭" OnClientClick="javascript:window.close();" UseSubmitBehavior="False" /></td>
            </tr>
        </table></div>
	<script type="text/javascript">
    jsTable('lrTable','lr','90%','120','center');
  </script>
    </form>
</body>
</html>
