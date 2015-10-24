<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditTalentClass.aspx.cs" Inherits="Talent.Web.TalentClass.EditTalentClass" %>

<div class="pageContent">

	<form method="post" action="ajaxWebServices.ashx" class="pageForm required-validate" onsubmit="return validateCallback(this,dialogAjaxDone);">
		<input type="hidden" name="webmethod" value='<%=Request["webmethod"] %>'>
        <input type="hidden" name="navTabId" value="TalentClassCx">
        
		<div class="pageFormContent" layoutH="58">
            <div class="unit">
				<label>序号：</label>
				<input type="text" class=" textInput" readonly="readonly"  name="WT_No" id="TC_No" runat="server" />
			</div>
            <div class="unit">
				<label>特殊福利政策类别：</label>
				<input type="text" class=" textInput required"  name="WT_WPType" id="TC_Class" runat="server" />
			</div>
			<div class="unit">
				<label>标注颜色：</label>
				<div class="colorPicker_controlset"><input id="TC_Color" type="text" name="WT_Color" value="#ffffff" runat="server" class="required"  /></div>
			</div>
		</div>
		
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>

</div>
