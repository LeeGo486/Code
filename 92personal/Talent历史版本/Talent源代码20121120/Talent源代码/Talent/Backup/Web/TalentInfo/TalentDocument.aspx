<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentDocument.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentDocument" %>

<div class="pageContent">
	<form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate" onsubmit="return iframeCallback(this,TalentInfo.RefeshDocument);">
        <input type="hidden" name="webmethod" value='addTalentDocument'>
        <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>'>
        <input type="hidden" name="TI_No" value='<%=Request["TI_No"] %>'>
        <input type="hidden" name="rel" value='ducument_dia'>
        
		<div class="pageFormContent" layoutH="58">
            <div class="unit" <%=Request["status"]=="99" ? "style='display:none'" : "" %> > 
				<label>选择上传文件：</label>
                <input class="required {accept:'doc|docx|xls|xlsx|zip|rar'}" type="file"  name="filename"  />
                <span class="info">doc,docx,xls,xlsx,zip,rar文件</span>
            </div>
            <div class="divider">divider</div>
            <%=filelist %>
		</div>
		<div class="formBar" <%=Request["status"]=="99" ? "style='display:none'" : "" %> >
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
