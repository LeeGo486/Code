<%@ page language="C#" autoeventwireup="true" inherits="b28web_Append_VIP_ShiftChk, App_Web_shiftchk.aspx.ea5f856c" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>会员审批</title>
    <link href="../../Utility/stymain.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
       <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="q_query" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="审批" CssClass="icon icon-tick" Callback="e_sure" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>
        
            
         <table> 
            <tr>
                <td>开始日期：</td>    
                <td> <cc1:DatePicker ID="begdate" runat="server" CssClass="field " Width="90px" /></td>    
                <td>结束日期：</td>    
                <td><cc1:DatePicker ID="enddate" runat="server" CssClass="field " Width="90px" /></td>    
                <td>
                    &nbsp;&nbsp;状态：&nbsp;&nbsp;
                    <label><input type ="radio" name="getchk" value="0" class="field"  checked="checked"/>未审批</label>
                    <label><input type ="radio" name="getchk" value="1" class="field" />已审批</label>
                </td>
            </tr>
        </table>
    <div>
            <input type="hidden" id="shiftid" name="shiftid" class="field" />
       <cc1:GridControl runat="server" ID="GridControl1"  AllowFilter="true"  AjaxParams="$('.field').serializeObject"      
         AjaxSource="GetList"  RowSelectType="Single" OnRowSelected="grdSelected" AjaxComplete="grdComplete"
         AllowPaginate="true" BottomHeight="200" >
          <states>
            <cc1:GridControlRowState name="getchk" value="同意" RowCssClass="gradeU" />
            <cc1:GridControlRowState name="getchk" value="拒绝" RowCssClass="gradeC" />
         </states>
        </cc1:GridControl>

           <cc1:GridControl runat="server" ID="GridControl2"  AllowFilter="false"  AjaxParams="$('.field').serializeObject"   Height="280"    
         AjaxSource="GetSubList"  RowSelectType="Single" AutoLoad="false" >
        </cc1:GridControl>
    </div>
    </form>
</body>
</html>
