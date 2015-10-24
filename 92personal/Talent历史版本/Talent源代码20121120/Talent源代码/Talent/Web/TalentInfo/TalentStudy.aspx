﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentStudy.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentStudy" %>

<form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="studyID" />
<div class="pageContent">
                <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                    <div class="unit">
                            <label>
                                创始人介绍：</label>
                            <textarea name="CB_Founder" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %>  cols="100"><%=model.CB_Founder%></textarea>
                        </div>
                        <div class="unit">
                            <label>
                                企业或品牌优势：</label>
                            <textarea name="CB_Advantage" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> cols="100"><%=model.CB_Advantage%></textarea>
                        </div>
                        <div class="divider">
                        </div>
                        <div class="unit">
                            <label>
                                企业组织架构:(含单个部门的架构,如设计\研发技术\销售\人资等)：</label>
                            <textarea name="CB_OrgStructure" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> rows="10" cols="100"><%=model.CB_OrgStructure%></textarea>
                        </div>
                        <div class="unit">
                            <label>
                                人力资源政策（包含薪酬、福利、培训、员工关怀等）：</label>
                            <textarea name="CB_HumanSrc" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> rows="10" cols="100"><%=model.CB_HumanSrc%></textarea>
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