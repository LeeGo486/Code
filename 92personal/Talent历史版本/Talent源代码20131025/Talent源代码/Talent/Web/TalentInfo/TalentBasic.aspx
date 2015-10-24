<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentBasic.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentBasic" %>


    <form id="TEST" method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="basicID" />
                    
        <div class="pageContent">
                    <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    缴纳形式：</label>
                                <%--必填在class后加上 required 即可--%>
                                <input type="text" class=" textInput" value="<%=model.SP_Mode %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="SP_Mode" />
                            </p>     
                        </div>
                        <div class="unit" width="80%">
                            <p style="width: 550px;">
                                <label>
                                    平均基数：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_AVGBase %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="SP_AVGBase" />
                            </p>   
                        </div>
                        <div class="unit" width="80%">
                            <p style="width: 550px;">
                                <label>
                                    社保基数上限：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_MAXBase %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="SP_MAXBase" />
                            </p>
                        </div>
                        <div class="unit" width="80%">
                            <p style="width: 550px;">
                                <label>
                                    社保基数下限：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_MINBase %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="SP_MINBase" />
                            </p>
                        </div>
                        <div class="unit" width="80%"> 
                            <p style="width: 550px;">
                                <label>
                                    养老公司承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_CompanyParRatio %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="SP_CompanyParRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    养老个人承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_PersonalParRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_PersonalParRatio" />
                            </p>      
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    失业公司承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_CompanyWorkRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_CompanyWorkRatio" />
                            </p>    
                        </div>
                       <div class="unit">
                            <label>
                                失业个人承担比例：</label>
                             <input type="text" class="  textInput" value="<%=model.SP_PersonalWorkRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_PersonalWorkRatio" />         
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    生育公司承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_CompanyBirthRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_CompanyBirthRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    工伤公司承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_PersonalInjuryRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_PersonalInjuryRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    医疗公司承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_CompanyMedicalRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_CompanyMedicalRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    医疗个人承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_PersonalMedicalRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_PersonalMedicalRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 750px;">
                                <label>
                                    大病，互助补充医疗单位承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_CompanySimulateRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_CompanySimulateRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 750px;">
                                <label>
                                    大病，互助补充医疗个人承担比例：</label>
                                <input type="text" class="  textInput" value="<%=model.SP_PersonalSimulateRatio %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_PersonalSimulateRatio" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    社保基数调整时间：</label>
                                <input type="text"  <%=per.PM_Level >= 1 ? "class='date textInput'":"class='textInput' readonly=readonly " %>  value="<%=model.SP_SocialDate %>"  yearend="10" size="25"
                                    name="SP_SocialDate" />
                                <a class="inputDateButton" href="javascript:;"   <%=per.PM_Level >= 1 ? "":" style='display:none' " %>   >选择</a>
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    医保基数调整时间：</label>
                                <input type="text"  <%=per.PM_Level >= 1 ? "class='date textInput'":"class='textInput' readonly=readonly " %>  value="<%=model.SP_HealthDate %>"  yearend="10" size="25"
                                    name="SP_HealthDate" />
                                <a class="inputDateButton" href="javascript:;"   <%=per.PM_Level >= 1 ? "":" style='display:none' " %>   >选择</a>
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    社保增减社保时间：</label>
                                <input type="text"  <%=per.PM_Level >= 1 ? "class='date textInput'":"class='textInput' readonly=readonly " %>  value="<%=model.SP_SocialAMDate %>"  yearend="10" size="25"
                                    name="SP_SocialAMDate" />
                                <a class="inputDateButton" href="javascript:;"   <%=per.PM_Level >= 1 ? "":" style='display:none' " %>   >选择</a>
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    缴纳社保所需资料：</label>
                                <input type="text" class=" textInput" value="<%=model.SP_SocialData %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_SocialData" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    社保当地政策：</label>
                                <input type="text" class=" textInput" value="<%=model.SP_SocialLocalPolicy %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_SocialLocalPolicy" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    业务办理：</label>
                                <input type="text" class=" textInput" value="<%=model.SP_BusinessTransact %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="SP_BusinessTransact" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    备注：</label>
                                <textarea name="SP_Remark1" class="" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %>  cols="100"><%=model.SP_Remark1%></textarea> 
                            </p>
                        </div>
                        <div class="divider">
                        </div>

                    </div>
                    <div class="formBar" <%=per.PM_Level >= 1 ? "":" style='display:none' " %> >
                        <ul>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <%--<button onclick="TalentInfo.DelTalent('<%=Request["CB_No"] %>')">--%>
                                            新增区域</button></div>
                                </div>
                            </li>

                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button onclick="$(this).next().get(0).click()">导出</button><a target="_blank" href='report.ashx?mode=21&CB_No=<%=Request["CB_No"] %>'></a></div>
                                </div>
                            </li>
                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button onclick="TalentInfo.SaveTalent()">
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

                            <li>
                                <div class="button">
                                    <div class="buttonContent">
                                        <button onclick="TalentInfo.SearchHistory('<%=Request["CB_No"] %>')">
                                            历史查询</button></div>
                                </div>
                            </li>

                        </ul>
                    </div>

                </div>
    </form>
