<%@ page language="C#" autoeventwireup="true" inherits="OA_manager_mgmenuupic, App_Web_mgmenuupic.aspx.3665c05a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>上传图片</title>
    <LINK href="../css/project.css" type="text/css" rel="stylesheet">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <base target="_self"/>
		<script language="JavaScript">
var parent_window = parent.dialogArguments;
   function add_all()
{

 var obj = document.getElementById("File1").value;
 if(obj!="")
 {
                         parent_window.document.all.menuimg.value=obj.substring((obj.lastIndexOf("\\") +1), obj.lastIndexOf(".")+4);
                         var inputObjects = parent_window.document.getElementsByTagName("input");
                             var arrayValues = new Array;
                            
                                for(var i = 0;i < inputObjects.length;i ++)
                                {
                                                if("chk" == inputObjects[i].name && false != inputObjects[i].checked)
                                                {
                                                        
                                                    // parent_window.document.getElementById("img"+inputObjects[i].id).src=obj;
                                                     
                                                    // document.all.menuimg.value= obj.src
                                                      if(inputObjects[i].className==0)
                                                           {
                                                             document.all.menuItem1.value+=inputObjects[i].id+","
                                                           }
                                                           else
                                                           {
                                                               if(inputObjects[i].className==1)
                                                               {
                                                                document.all.menuItem2.value+=inputObjects[i].id+","
                                                               }
                                                           }
                                                    
                                                           
                                                }
                                }
                                if(document.all.menuItem1.value!="" || document.all.menuItem2.value!="")
                               {
                                 //document.getElementById("menuItem")
                              }
      }
 }
</script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <fieldset> <LEGEND style="WIDTH: 35px; HEIGHT: 15px" align="left">从电脑中上传图标</LEGEND><p id="iUpload">
     </p>
    <p>
        <input id="File1" type="file" style="width: 300px"  runat="server" name="File" />
 
        
        <asp:Button ID="Btnup" runat="server" Text="上传" OnClick="Btnup_Click" OnClientClick="add_all()"  Width="81px" />&nbsp;
        <asp:CheckBox ID="ChkBoxUp" runat="server" Text="上传并替换图标" /></p></fieldset>
    </div>
        <input id="menuItem1" runat="server" name="menuItem1" type="hidden" /><input id="menuItem2"
            runat="server" name="menuItem2" type="hidden" />
        <asp:Label ID="LblMenuName" runat="server"></asp:Label>
    </form>
</body>
</html>
