<%@ page language="C#" autoeventwireup="true" inherits="mat_mat_bill_fb, App_Web_mat_bill_fb.aspx.e229d74d" %>
  <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
     <link  href="../css/project.css" type="text/css"  rel="stylesheet" />
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center; height:30px; width:100px;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		<script type="text/javascript" language="javascript">
   function selectMD(){
     var m=window.showModalDialog('mat_org_dlg.aspx',"弹出d窗口","height:500px;width:800px;toolbar:no;menubar:no;location:no;resizable:no;status:no;scroll:no;help:no;");
	     if (m!=null&&typeof(m)!='undefined'&&m!="all"){	         
		     document.getElementById('hidOrg').value=m.split('|')[1];
             document.getElementById('txtOrg').value=m;
             return true;
	    }
	    else
	    return false;
  }
  function fchkState_onclick(obj){
  var b=obj.checked; 
   document.getElementById('hidstate').value=obj.checked?1:0;
   document.getElementById('txtfb_content').disabled=b;
   document.getElementById('WebDateChooserDateEnd').disabled=b;
   document.getElementById('drpIsquality').disabled=b;
   document.getElementById('btnOrg').disabled=b;
  }
 </script>
</head>
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <div style="text-align:center;vertical-align:middle;">
     <% if (id.Length > 0)
        { %>
        <input type="hidden" id="hidstate" runat="server" />
       <table  width="98%">
        <tr><td align="right" >
          <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtfb_comment" ErrorMessage="请填写问题核实情况"></asp:RequiredFieldValidator>&nbsp;
         <input id="btnfb" type="submit" value="确 定" class="btn"  runat="server" onserverclick="btnfb_OnClick"/>
        </td></tr>
        </table>      
  
        <table width="98%">
         <tr><td  class="ltd">编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
         <td align="left"><input id="txtbillid" runat="server" class="tbox" style="width:98%;" readonly="readonly"/> </td>
        </tr>
        <tr><td  class="ltd">是 否 退 回：</td><td align="left"><input type="checkbox" id="chkState" runat="server" onclick="fchkState_onclick(this);" />退回</td></tr>
        <tr><td  class="ltd">问题核实情况：</td><td align="left"><textarea id="txtfb_comment" runat="server" class="tbox" style="width:98%; height:50px; margin:0px;"></textarea></td></tr>
        <tr><td  class="ltd">计划完成时间：</td><td align="left"><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server"  value="" > </igsch:webdatechooser></td></tr>
        <tr><td class="ltd"> 质 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保：</td>
         <td align="left"><asp:DropDownList ID="drpIsquality" runat="server" Width="99%"><asp:ListItem Text="否" Value="0" ></asp:ListItem><asp:ListItem Text="是" Value="1" Selected=True></asp:ListItem> </asp:DropDownList>  </td></tr>
        <tr><td  class="ltd">处理具体方案：</td><td align="left"><textarea id="txtfb_content" runat="server" class="tbox" style="width:98%; height:50px; margin:0px;"></textarea></td></tr>
        <tr><td  class="ltd">施工单位：</td><td align="left">
        <input id="txtOrg" runat="server" class="tbox" style="width:60%;" readonly="readonly"/> 
          <input type="button"  id="btnOrg" value="选择" class="btn" onclick="javascript:selectMD();"  />
           <input type="hidden" runat="server" id="hidOrg" />
        </td></tr>
        </table>
      
    <%} else { %>
         <br /><br />
         <div><h4 style="color:Red;">请选择报修单</h4></div>
     <% } %>
    </div>
    </form>
</body>
</html>
