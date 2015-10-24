<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_proxyAdd, App_Web_mat_bill_proxyadd.aspx.e229d74d" %>
    <%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>店铺报修单--添加</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
 <script type="text/javascript" language="javascript">
   function selectMD(){
     var m=window.showModalDialog('mat_dlgDepot.aspx',"弹出d窗口","height:500px;width:800px;toolbar:no;menubar:no;location:no;resizable:no;status:no;scroll:no;help:no;");
	     if (m!=null&&typeof(m)!='undefined'&&m!="all"){	         
		     document.getElementById('hidDepotid').value=m.split('|')[1];
             document.getElementById('txtDepotid').value=m;
             return true;
	    }
	    else
	    return false;
  }
 </script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
  <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />   
   <table  width="98%">
    <tr>   
        <td align="right" >  
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDepotid" ErrorMessage="请选择店铺"></asp:RequiredFieldValidator>&nbsp;
          <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="txtContent" ErrorMessage="请填写报修内容"></asp:RequiredFieldValidator>&nbsp;
          <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />
        </td>
    </tr>
    </table>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table width="98%">
     <colgroup>
        <col  width="60" />
        <col  align="left"  width="190" />
        <col  width="60" />
        <col  align="left"  width="190" />           
           
    </colgroup>
    <tr>
    <td class="ltd">店铺名称:</td>
    <td align="left" colspan="3"><input id="txtDepotid" runat="server" class="tbox" style="width:60%;" readonly="readonly"/> 
           <input type="button"  id="btnDepot" value="选择" class="btn" onclick="javascript:if(selectMD()){ return true;}else{return false;}"  runat="server" onserverclick="btnDepot_Onclick" />
           <input type="hidden" runat="server" id="hidDepotid" />
     </td>
   
    </tr>
    <tr>
    <td class="ltd" > 种&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类:</td>
    <td>
     <asp:DropDownList ID="drpType" runat="server" Width="99%" OnSelectedIndexChanged="drpType_SelectedIndexChanged" AutoPostBack="true"> </asp:DropDownList>
     </td>
     <td class="ltd">品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类: </td>
    <td> <asp:DropDownList ID="drpchild" runat="server" Width="99%"> </asp:DropDownList>
    </td>
    </tr>    
    <tr>
    <td class="ltd" >报修内容:</td>
    <td valign="middle" ><textarea id="txtContent" runat="server" class="tbox" style="width:98%; height:100px; margin:0px;"></textarea>
      </td>
    <td class="ltd" >图片:</td>
    <td align="center" valign="middle"><a id="aimgbill" href="" runat="server" target="_blank"><img id="imgbill" runat="server" src=""  style="border:none;" /></a></td>
    </tr> 
     <tr>
    <td class="ltd" > 联系人:</td>
     <td>
     <input id="txtLinkman" runat="server" class="tbox" style="width:98%;" />
     </td>
     <td class="ltd"> 联系电话:</td>
    <td>
     <input id="txtlinkTel" runat="server" class="tbox" style="width:98%;" />
     </td>
    </tr>     
     <tr>
     <td class="ltd">图片上传:</td>
     <td  colspan="3"><asp:FileUpload ID="flImg" runat="server"   Width="99%"  /></td>
    </tr>                  
   <tr>
    <td class="ltd"> 备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
    <td  colspan="3"><textarea id="txtComment" runat="server" class="tbox" style="width:98%; height:50px;"></textarea></td>      
   </tr>
   <tr><td colspan="4" align="center"><span style="color:Red;">上传图片大小必须小于4M。</span></td></tr>  
  </table>
  </ContentTemplate><Triggers><asp:PostBackTrigger ControlID="BtnSave" /></Triggers> 
    </asp:UpdatePanel>
</form>
</body>
</html>
