﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentBasic.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentBasic" %>


    <form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="basicID" />
                    
        <div class="pageContent">
                    <div class="pageFormContent TermClass"  <%=per.PM_Level >= 1 ? "layouth='84'":"layouth='48'" %> >
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    公司名称：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_Name %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_Name" />
                            </p>
                            <p>
                                <label>
                                    公司人数：</label>
                                <input type="text" class="required digits textInput" value="<%=model.CB_Num %>" size="25" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_Num" />
                            </p>
                        </div>
                        <div class="unit" width="80%">
                            <p style="width: 550px;">
                                <label>
                                    公司所在地：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_Position %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_Position" />
                            </p>
                            <p>
                                <label>
                                    华之毅品牌：</label>
                                <select name="CB_Province" class="required"  <%=per.PM_Level >= 1 ? "":" style='display:none' " %> >
                                    <option></option>
                                    <%=Talent.Common.Constants.getArr(model.CB_Province) %>
                                </select>

                                <label <%=per.PM_Level >= 1 ? "style='display:none'":""%> > <%=model.CB_Province %></label>
                            </p>
                        </div>
                        <div class="unit" width="80%">
                            <p style="width: 550px;">
                                <label>
                                    公司logo图片：</label>
                                <input type="file" name="CB_Img" <%=per.PM_Level >= 1 ? "":" style='display:none' " %>  />
                                <span class="info" style="float: none; display: inline">
                                    <%=model.CB_Img == null ? "" : "<a href='NewImages/" + model.CB_Img + "'>logo</a>"%></span>
                            </p>
                            <p>
                                <label>
                                    成立时间：</label>
                                <input type="text"  <%=per.PM_Level >= 1 ? "class='date textInput'":"class='textInput' readonly=readonly " %>  value="<%=model.CB_SetUp %>"  yearend="10" size="25"
                                    name="CB_SetUp" />
                                <a class="inputDateButton" href="javascript:;"   <%=per.PM_Level >= 1 ? "":" style='display:none' " %>   >选择</a>
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    上年度销售额：</label>
                                <input type="text" class="required moneyCheck textInput" value="<%=model.CB_Je %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="CB_Je" />
                            </p>
                            <p>
                                <label>
                                    工厂规模：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_Scale %>" size="25" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_Scale" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    品牌名称：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_BrandName %>" size="50" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_BrandName" />
                            </p>
                            <p>
                                <label>
                                    品牌风格：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_BrandStyle %>" size="25" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_BrandStyle" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    品牌价格区间：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_PriceSection %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="CB_PriceSection" />
                            </p>
                            <p>
                                <label>
                                    擅长品类：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_Category %>" size="25" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    name="CB_Category" />
                            </p>
                        </div>
                        <div class="unit">
                            <p style="width: 550px;">
                                <label>
                                    经营方式：</label>
                                <input type="text" class="required textInput" value="<%=model.CB_ModeOperation %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="50" name="CB_ModeOperation" />
                            </p>
                            <p>
                                <label>
                                    店铺数量：</label> 
                                <input type="text" class="required digits textInput" value="<%=model.CB_ShopNum %>" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %> 
                                    size="25" name="CB_ShopNum" />
                            </p>
                        </div>
                        <div class="divider">
                        </div>
                        <div class="unit">
                            <label>
                                竞品信息描述：</label>
                            <textarea name="CB_Des" class="required" rows="10" <%=per.PM_Level >= 1 ? "":"readonly=readonly" %>  cols="100"><%=model.CB_Des%></textarea> 
                        </div>
                        <div class="divider">
                        </div>
                        <div class="unit">
                            <label>
                                人才类别：</label>
                            <%=selectstr %>
                        </div>
                        <div class="unit">
                            <label>
                                </label>
                            <%=selectstr2 %>
                        </div>
                       
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
