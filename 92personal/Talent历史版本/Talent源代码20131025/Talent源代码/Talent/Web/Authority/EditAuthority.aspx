<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditAuthority.aspx.cs" Inherits="Talent.Web.Authority.EditAuthority" %>

<div class="pageContent">

	<form method="post" action="ajaxWebServices.ashx" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDone);">
		<input type="hidden" name="webmethod" value='updateQx'>
        <input type="hidden" name="navTabId" value="AuthorityCx">
        
		<div class="pageFormContent" layoutH="58">
            <div class="unit">
				<label>序号：</label>
				<input type="text" class="textInput" readonly="readonly" value='<%=Request["PM_No"] %>'  name="PM_No" />
			</div>
            <div class="unit">
				<label>用户名：</label>
				<input type="text" class="textInput" value='<%=model.PM_Login %>'  name="PM_Login" />
			</div>
            <div class="unit">
				<label>权限：</label>
                <select name="PM_Level"  class="required" >
                    <option value=""></option>
                    <option value="-1" <%=model.PM_Level == -1 ? "selected=selected":""  %> >无权限</option>
                    <option value="0"  <%=model.PM_Level == 0 ? "selected=selected":""  %> >查看权限</option>
                    <%=Request["level"] == "9" ?"<option  value='1' "+ (model.PM_Level == 1 ? "selected=selected":"") +" >管理权限</option>":"" %>
                </select>
			</div>
			<div class="divider"></div>
            <%=checkboxlist%>
		</div>
		
		<div class="formBar">
            <label style="float:left"><input type="checkbox" class="checkboxCtrl" group="PM_Province" />全选</label>
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>

</div>
