<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentStudy.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentStudy" %>

<form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo1" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="studyID" />
<div class="pageContent">
                <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                    <div class="unit">
                            <label>
                                缴纳形式：</label>
                                <input type="text" class="required textInput" value="<%=model.MP_Mode %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_Mode" />
                        </div>
                        <div class="unit">
                            <label>
                                基数上限：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_MAXBase %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_MAXBase" />
                        </div>
                        <div class="unit">
                            <label>
                                基数下限：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_MINBase %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_MINBase" />
                        </div>
                        <div class="unit">
                            <label>
                                公司承担比例：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_CompanyRatio %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_CompanyRatio" />     
                        </div>
                        <div class="unit">
                            <label>
                                个人承担比例：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_PersonalRatio %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_PersonalRatio" />   
                        </div>
                        <div class="unit">
                            <label>
                                公积金基数调整时间：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_MPFAdjustDate %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_MPFAdjustDate" />
                        </div>
                        <div class="unit">
                            <label>
                                公积金增减时间：</label>
                            <input type="text" class="required textInput" value="<%=model.MP_MPFAMDate %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_MPFAMDate" />      
                        </div>
                        <div class="unit">
                            <label>
                                公积金贷款政策：</label>
                             <input type="text" class="required textInput" value="<%=model.MP_MPFLocalPolicy %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="MP_MPFLocalPolicy" />
                        </div>
                        
                </div>
                <div class="formBar" <%=per.PM_Level >= 1 ? "":"style='display:none'" %>>
                        <ul>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button type="submit">
                                            保存</button></div>
                                </div>
                            </li>
                        </ul>
                    </div>
</div>
</form>