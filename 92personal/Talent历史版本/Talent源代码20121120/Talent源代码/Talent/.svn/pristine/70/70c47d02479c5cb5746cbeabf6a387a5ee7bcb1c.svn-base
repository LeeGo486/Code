<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentInfo.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentInfo" %>


<div class="pageContent">
    <div class="tabs" currentindex="0" eventtype="click">
        <div class="tabsHeader">
            <div class="tabsHeaderContent">
                <ul>
                    <li><a href="javascript:;"><span>竞品信息描述</span></a></li>
                    <li><a href="javascript:;"><span>竞品信息调研</span></a></li>
                    <li><a href="javascript:;"><span>人才库信息</span></a></li>
                </ul>
            </div>
        </div>
        

        <div class="tabsContent" style=" background-color:White;border-left:0px;border-right:0px;padding:0px">
            <div class="unitBox" id="basicID" >
                <%Server.Execute("TalentBasic.aspx?CB_No=" + Talent.Common.Constants.getReqValue(Request, "CB_No") ); %>
            </div>
            <div class="unitBox"  id="studyID" >
                <%Server.Execute("TalentStudy.aspx?CB_No=" + Talent.Common.Constants.getReqValue(Request, "CB_No") ); %>
            </div>
            <div class="unitBox"  id="listID" >
               <%Server.Execute("TalentLlist.aspx?CB_No=" + Talent.Common.Constants.getReqValue(Request, "CB_No") ); %>
            </div>
        </div>
    </div>
</div>
