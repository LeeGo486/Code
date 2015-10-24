<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HumanLabor.aspx.cs" Inherits="Talent.Web.TalentInfo.HumanLabor" %>

    <form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo2" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="basicID" />
                    
        <div class="pageContent">
                    <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                        <div class="unit">
                            
                                <label>
                                    人事劳动政策一：</label>
                                <textarea name="PP_PerPolicyOne" class="required" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %>  cols="100"><%=model.PP_PerPolicyOne%></textarea> 
                                
                              
                        </div>
                        <div class="unit" width="80%">
                           
                                <label>
                                    人事劳动政策二：</label>
                                <textarea name="PP_PerPolicyTwo" class="required" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %>  cols="100"><%=model.PP_PerPolicyTwo%></textarea> 
                                 
                        </div>
             
                        <%--<div class="unit">
                            <label>
                                人才类别：</label>
                            <%=selectstr %>
                        </div>
                        <div class="unit">
                            <label>
                                </label>
                            <%=selectstr2 %>
                        </div>--%>
                       
                    </div>
                    <div class="formBar" <%=per.PM_Level >= 1 ? "":" style='display:none' " %> >
                        <ul>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button onclick="$(this).next().get(0).click()">导出</button><a target="_blank" href='report.ashx?mode=21&CB_No=<%=Request["CB_No"] %>'></a></div>
                                </div>
                            </li>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button type="submit">
                                            保存</button></div>
                                </div>
                            </li>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button onclick="TalentInfo.DelTalent('<%=Request["CB_No"] %>')">
                                            删除</button></div>
                                </div>
                            </li>
                        </ul>
                    </div>

                </div>
    </form>

