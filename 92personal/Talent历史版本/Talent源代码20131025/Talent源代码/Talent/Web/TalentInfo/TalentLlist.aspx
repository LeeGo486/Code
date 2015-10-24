<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentLlist.aspx.cs" Inherits="Talent.Web.TalentInfo.TalentLlist" %>

<form id="pagerForm" method="post" action="TalentInfo/TalentLlist.aspx">
<input type="hidden" name="pageNum" value="1" />
<input type="hidden" name="numPerPage" value="20" />
<input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
</form>


 <form method="post" action="ajaxWebServices.ashx" enctype="multipart/form-data" class="pageForm required-validate"
                    onsubmit="return iframeCallback(this,TalentInfo.TalentCallBack)">
                    <input type="hidden" name="webmethod" value="updateTalentInfo" />
                    <input type="hidden" name="CB_No" value='<%=Request["CB_No"] %>' />
                    <input type="hidden" name="rel" value="listID" />
                    


<div class="pageContent" style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
    <div class="panelBar" <%=per.PM_Level >= 1 ? "":"style='display:none'" %>>
        <ul class="searchContent">
			<%--<li>
				<label>区域名称：</label>
                <input type="text" name="SP_Area" size=25   class="medium"  />
            </li>--%>
			<%--<li>
                <label>公司所在地：</label>
                <input  type="text" name="CB_Position" value="<%=queryModel.CB_Position %>"  size=25 class="medium" />
            </li>
            <li>
                <label>姓名：</label>
                <input  type="text" name="TI_Name"  value="<%=queryModel.TI_Name %>"  size=25 class="medium"  />
            </li>--%>
            <%--<input type="hidden" name="TI_TalentClass"  value="<%=queryModel.TI_TalentClass %>" />
            <input type="hidden" name="TI_Sex"  value="<%=queryModel.TI_Sex %>" />
            <input type="hidden" name="TI_Src"  value="<%=queryModel.TI_Src %>" />
            <input type="hidden" name="TI_Audition"  value="<%=queryModel.TI_Audition %>" />
            <input type="hidden" name="TI_AuditionResult"  value="<%=queryModel.TI_AuditionResult %>" />
            <input type="hidden" name="TI_FollowUpPeople"  value="<%=queryModel.TI_FollowUpPeople %>" />
            <input type="hidden" name="TI_RecommendPost"  value="<%=queryModel.TI_RecommendPost %>" />--%>
        </ul>
        <ul class="toolBar">

            <%--<li><a href="TalentBasic.aspx" name="basicID"  rel="TalentCx"><span>新增</span></a></li>
            --%> 
            <li><a class="add" href="javascript:void(0);" onclick="TalentInfo.AddRow(this);return false;">
            <%--<li><a  class="add" href="javascript:void(0);"  onclick="map.openNavTab(this);return false ;">--%>
                <span>添加</span></a></li>
            <li><a class="delete" href="javascript:void(0);" name="TalentDel" data='{sid_talent}'>
                <span>删除</span></a></li>
            <li class="line">line</li>
            <li><a class="icon" href="javascript:void(0);" name="TalentSubmit" onclick='$(this).parents(".pageForm:first").submit();'>
                <span>保存</span></a></li>
            <li class="line">line</li>
            <%--<li><a class="icon" onclick="$(this).attr('href','report.ashx?mode=3&queryStr='+encodeURI($(this).attr('data')));"
                target="_blank" data="<%=queryStr %>"><span>导出</span></a></li>--%>
        </ul>
    </div>
    <table class="table" width="1800px" <%=per.PM_Level >= 1 ? " layoutH='103'":" layoutH='77'" %>
        rel="jbsxBox">
        <thead>
            <tr>
                <th width="60">
                    序号
                </th>
                <th width="60">
                    区域
                </th>
                <th width="80">
                    社保缴纳形式
                </th>
                <th width="80">
                    平均基数
                </th>
                <th width="80">
                    社保基数上限
                </th>
                <th width="80">
                    社保基数下限
                </th>
                <th width="80">
                    养老公司承担比例
                </th>
                <th width="80">
                    养老个人承担比例
                </th>
                <th width="80">
                    失业公司承担比例
                </th>
                <th width="80">
                    失业个人承担比例
                </th>
                <th width="80">
                    生育公司承担比例
                </th>
                <th width="80">
                    工伤公司承担比例
                </th>
                <th width="80">
                    医疗公司承担比例
                </th>
                <th width="80">
                    医疗个人承担比例
                </th>
                <th width="80">
                    大病互助公司承担比例
                </th>
                <th width="80">
                    大病互助个人承担比例
                </th>
                <th width="80">
                    社保基数调整时间
                </th>
                <th width="80">
                    医保基数调整时间
                </th>
                <th width="80">
                    社保增减社保时间
                </th>
                <th width="80">
                    缴纳社保所需资料
                </th>
                <th width="80">
                    社保当地政策
                </th>
                <th width="80">
                    业务办理
                </th>
                <th width="80">
                    备注
                </th>
            </tr>
        </thead>
        <tbody name="TalentsList">
            <%=talentsper %>
        </tbody>
    </table>
    <div class="panelBar">
        <div class="pages">
            <span>每页显示20条，共<%=total %>条</span>
        </div>
        <div class="pagination" rel="listID" totalcount="<%=total %>" numperpage="20" pagenumshown="5"
            currentpage="<%=index %>">
        </div>
    </div>
</div>
</form>
