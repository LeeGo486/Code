<%@ page language="C#" autoeventwireup="true" inherits="b28web_Append_VIP_ShiftVipUserEdit, App_Web_shiftvipuseredit.aspx.ea5f856c" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>编辑会员资料转移申请</title>
    <link href="../../Utility/stymain.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        fieldset select
        {
            width:140px;    
        }
        fieldset
        {
            margin:5px 10px;  
            padding:5px;
        }
        
        fieldset h4
        {
            -color:#cfcfcf;    
        } 
    </style>
</head>
<body>
    <form id="form1" runat="server">
      <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnclose" runat="server" Text="关闭" CssClass="icon icon-cross" Callback="function(){close();}" />
                 <cc1:ButtonItem ID="btnedit" runat="server" Text="提交申请" CssClass="icon icon-tick" Callback="e_save" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>

        <fieldset>
            <legend><h4>转出店铺</h4></legend>
            <table>
                <tr>
                    <td>转出店铺：<select id="setdepotid" name="setdepotid" class="field" runat="server"></select></td>
                    <td>客户经理：<select id="set_employeeid" name="set_employeeid" class="field"><option value=""></option></select></td>
                    <td><input type="button" id="btnquery" value=" 查   询 " onclick="q_query()"  /></td>
                </tr>
                <tr>
                    <td>
                        客户姓名：<input type="text"  id="vipname" name="vipname" class="field" />
                    </td>
                    <td>客户手机：<input type="text"  id="vipmobel" name="vipmobel" class="field" /></td>
                    <td style="">客户卡号：<input type="text"  id="vipcardid" name="vipcardid" class="field" /></td>
                </tr>
            </table>
        </fieldset>

         <fieldset>
            <legend><h4>转入店铺</h4></legend>
            转入店铺：<select id="getdepotid" name="getdepotid" class="field" runat="server"></select>&nbsp;
            客户经理：<select id="employeeid" name="employeeid" class="field" runat="server"></select>
            备&emsp;&emsp;注：<input type="text" id="remark" name="remark" class="field" />
        </fieldset>


        <cc1:GridControl runat="server" ID="GridControl1"  AllowFilter="false"  AjaxParams="$('.field').serializeObject"    
         AjaxSource="GetList"  RowSelectType="Single"  
         AllowPaginate="false" >
        </cc1:GridControl>
    </form>
</body>
</html>
