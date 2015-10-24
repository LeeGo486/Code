<%@ page language="C#" autoeventwireup="true" inherits="OA_manager_mgmenuimg, App_Web_mgmenuimg.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>菜单图标管理</title>
    <LINK href="../css/project.css" type="text/css" rel="stylesheet">
		<script  language="javascript" src="../js/project.js" type="text/javascript"></script>
		<script id="Infragistics" language="javascript" type="text/javascript">
	
		function getroot() 
{
  
  var path=location.pathname.split("/");

  var root=path[1];
  if (path[0]!="")
  {
     root=path[0];
   }
  if (root!="")
  {
    root="/"+root;
  }
  return root;
}
		
		function openurl()
		{
		LoadWindow('../../manager/mgmenuupic.aspx',605,480,'上传图片');
		var pt
		
		if(getroot().search("/oa")!=-1)
		{
	        pt=  getroot()+"/";
	     }
	     else
	     {
	       pt=  getroot()+"/oa/";
	     }
		var inputObjects = document.getElementsByTagName("input");
             var arrayValues = new Array;
           
                for(var i = 0;i < inputObjects.length;i ++)
                {
                                if("chk" == inputObjects[i].name && false != inputObjects[i].checked)
                                {
                               
                                       if(document.all.menuimg.value!="")
                                    {
                                    document.getElementById("img"+inputObjects[i].id).src=pt+"iconpublic/"+document.all.menuimg.value;
                                          
                                           inputObjects[i].checked=false;
                                           }
                                         
                                }
                }
		}
		
        function mysubmit(obj)
        {
             
	         var inputObjects = document.getElementsByTagName("input");
             var arrayValues = new Array;
            
                for(var i = 0;i < inputObjects.length;i ++)
                {
                                if("chk" == inputObjects[i].name && false != inputObjects[i].checked)
                                {
                                         // debugger;
                                           //arrayValues[arrayValues.length] = inputObjects[i].value;
                                           document.getElementById("img"+inputObjects[i].id).src=obj.src;
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
                                          
                                            document.all.menuimg.value= obj.src
                                           //document.all.menuItem.value=temp
                                           inputObjects[i].checked=false;
                                           //window.alert(obj.src);
                                           //window.alert(document.getElementById(inputObjects[i].id));
                                }
                }

               if(document.all.menuItem1.value!="" || document.all.menuItem2.value!="")
               {
                  var t1=document.all.menuItem1.value;
                  var t2=document.all.menuItem2.value;
                  var img=document.all.menuimg.value;
                 
                var url="mgmenuxml.aspx?t1="+escape(t1)+"&t2="+escape(t2)+"&img="+escape(img);
              return update_srv(url);
              }
             

         }
 
function clears()
{
  var question = confirm("你确认要还原成默认图标吗!");
		             
		              if(question)
		              {
                         var url="mgmenuxmlclear.aspx";
                             update_srv(url);
                           var inputObjects = document.getElementsByTagName("input");
                                 var arrayValues = new Array;
                                 var pt;
                                                             
		                            if(getroot().search("/oa")!=-1)
		                            {
	                                    pt=  getroot()+"/img/";
	                                 }
	                                 else
	                                 {
	                                   pt=  getroot()+"/oa/img/";
	                                 }
                                    for(var i = 0;i < inputObjects.length;i ++)
                                    {
                                                    if("chk" == inputObjects[i].name )
                                                    {
                                                            
                                                              
                                                               if(inputObjects[i].className==0)
                                                               {
                                                                  document.getElementById("img"+inputObjects[i].id).src=pt+"folder.gif";
                                                               }
                                                               else
                                                               {
                                                                   if(inputObjects[i].className==1)
                                                                   {
                                                                    document.getElementById("img"+inputObjects[i].id).src=pt+"page.gif";
                                                                   }
                                                               } 
                                                    }
                                    }
                                    return true;
                  
                  }
                  else
                  {
                  return false;
                  }
}
function save_readyState()
{

   if (request.readyState<4) 
   {
       showmsg("正在处理...");
   }
   else
   if (request.readyState==4) 
   {
      showmsg("操作成功！");
   }
   else
   {
     showmsg("操作失败！");
     alert(request.responseText);
   }
   
}
//提交服务器
function update_srv(url)
{

    if (window.XMLHttpRequest)
    {
        request = new XMLHttpRequest();
    }
    
    else if (window.ActiveXObject)
    {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    if (request)
    {
        if (request.readyState!=0)
        {
          alert("服务器正忙,请稍后提交...");
          return false;
        } 

        showmsg("正在处理...");
        request.onreadystatechange = save_readyState;
        request.open("GET", url,false);
        request.send(null);
        
        var strReturn=request.responseText;
        if (strReturn.substring(0,3)=="upd")
        {
           showmsg("处理成功！.");
          
           return 0;
        }
        else
        {
          showmsg("处理失败！");
          alert(strReturn);
          return 1;
        }          
     }
}
function showmsg(msg)
{
        
    window.document.getElementById("LblMenuName").innerHTML ="<font color='red'>"+msg+"</font>";
         
}        

function GoSelect(obj)

    {
      
        window.document.getElementById("LblMenuName").innerText=obj.innerText;
        window.document.getElementById("HFtid").value=obj.id;
        window.document.getElementById("HFtype").value=obj.className;
        return false;

    }

        </script>
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <input value="" type="hidden" name="menuItem1" ID="menuItem1" runat="server" />
     <input value="" type="hidden" name="menuItem2" ID="menuItem2" runat="server" />
    <input value="" type="hidden" name="menuimg" ID="menuimg" runat="server" />
    <div>
 
    <table width="100%">
    <tr>
    <td width="20%" valign="top">
    <div style="overflow:scroll; height:500px">
    
    
    <asp:TreeView ID="TreeView1" runat="server"  ShowLines="True" ToolTip=""  EnableViewState="false" >
          </asp:TreeView></div></td>
<td width="80%"  valign="top">
<table width="100%">
<tr>
<td>
<table  width="100%">
<tr>
<td align="left"><asp:Label ID="LblMenuName" runat="server" Text="双击下列图标,可更换右侧选取项图标"></asp:Label> <asp:HiddenField runat="server" ID="HFtype" /><asp:HiddenField runat="server" ID="HFtid" /></td>
<td align="right"><input class="btn" onclick="openurl()" type="button"
        value="从本地上传图标" />
    <input class="btn" onclick="return clears()" type="button"
        value="还原成默认图标" />
</td>
</tr>
</table>
<hr />
   </td>
</tr>

<tr>
<td> 
 
            <table width="100%">
            <tr>
            <td>
            <asp:Panel runat="server" ID="p1" ScrollBars="Auto" Height="400" BackColor="#D5E8EB">
            <asp:DataList ID="DLPhotoList" runat="server" RepeatDirection="Horizontal"  RepeatColumns="5" Width="100%" CellPadding="0" ForeColor="#333333">
		<ItemTemplate>
		  <table width="100%" border="0" cellpadding="0" cellspacing="5">
            <tr>
              <td width="20%" style="text-align:center">
			  <div >
			  <table width="100" border="0" cellspacing="0" cellpadding="0" >
			  <tr>
				<td><div >
				  
				  <img id="Img1" src="<%#Eval("imgurl")%>"   ondblclick="mysubmit(this)" runat="server"    style="border:none; width:16px; height:16px"   alt=""/>
				  </div></td>
			  </tr>		 
			</table>
			</div>
              </td>
              </tr>
          </table>
		</ItemTemplate>
	<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
	<SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
	<AlternatingItemStyle BackColor="#FFFFFF" />
	<ItemStyle BackColor="#D5E8EB" />
	<HeaderStyle BackColor="#D5E8EB" Font-Bold="True" ForeColor="White" />
	</asp:DataList>
	</asp:Panel>
            </td>
            </tr>
             <tr>
            <td>

            </td>
            </tr>
            </table>

   </td>
</tr>

<tr>
<td>

</td>
</tr>
</table>
    </td>
    </tr>
    </table>
           
    <table width="100%">
    <tr>
    <td width="20%"></td>
    <td><table>
<tr>
<td>&nbsp;
    </td>
</tr>
</table></td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
