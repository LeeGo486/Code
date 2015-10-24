<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentUpkeep.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentUpkeep" %>

<div class="pageContent">
	<form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate" onsubmit="return iframeCallback(this,TalentInfo.RefeshDocument);">
        <input type="hidden" name="webmethod" value='addTalentUpkeep'>
        <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>'>
        <input type="hidden" name="TI_No" value='<%=Request["TI_No"] %>'>
        <input type="hidden" name="rel" value='ducument_dia'>
        
		<div class="pageFormContent" layoutH="58">
            <div class="unit" <%=Request["status"]=="99" ? "style='display:none'" : "" %> > 
				<label>维护日期：</label>
                <input class="required date textInput" type="text"  name="UD_Date"  />
                <a class="inputDateButton" href="javascript:;"  >选择</a>
            </div>
            <div class="unit" <%=Request["status"]=="99" ? "style='display:none'" : "" %> > 
				<label>维护结果：</label>
                <textarea class="required" name="UD_Result" cols="30" rows="3" ></textarea>
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
