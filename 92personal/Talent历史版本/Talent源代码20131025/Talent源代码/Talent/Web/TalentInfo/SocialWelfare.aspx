<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SocialWelfare.aspx.cs" Inherits="Talent.Web.TalentInfo.SocialWelfare" %>

 <form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo3" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="Div1" />
                    
        <div class="pageContent">
                    <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                         
                        <div class="unit">
                            <label>
                                特殊福利政策：</label>
                            <%=selectstr3 %>
                           
                        </div>
                        <div class="unit">
                            <label>
                                </label>  
                            <%=selectstr4 %>
                        </div>

                        <%--<div class="unit">
                            <label>
                                特殊福利政策二：</label>
                              
                            <%=selectstr3 %>
                        </div>
                        <div class="unit">
                            <label>
                                </label>
                            <%=selectstr4 %>
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


