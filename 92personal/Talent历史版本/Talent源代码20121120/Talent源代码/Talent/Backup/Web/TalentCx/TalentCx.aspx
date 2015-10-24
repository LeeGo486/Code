<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentCx.aspx.cs" Inherits="Talent.Web.TalentCx.TalentCx" %>

<form id="pagerForm" method="post" action="TalentCx/TalentCx.aspx">
<input type="hidden" name="pageNum" value="1" />
<input type="hidden" name="numPerPage" value="20" />

</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" rel="pagerForm" action="TalentCx/TalentCx.aspx" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>公司名称：</label>
                <input   type="text" name="CB_Name" size=25  value="<%=queryModel.CB_Name %>"  class="medium"  />
            </li>
			<li>
                <label>公司所在地：</label>
                <input  type="text" name="CB_Position" value="<%=queryModel.CB_Position %>"  size=25 class="medium" />
            </li>
            <li>
                <label>姓名：</label>
                <input  type="text" name="TI_Name"  value="<%=queryModel.TI_Name %>"  size=25 class="medium"  />
            </li>
            <input type="hidden" name="TI_TalentClass"  value="<%=queryModel.TI_TalentClass %>" />
            <input type="hidden" name="TI_Sex"  value="<%=queryModel.TI_Sex %>" />
            <input type="hidden" name="TI_Src"  value="<%=queryModel.TI_Src %>" />
            <input type="hidden" name="TI_Audition"  value="<%=queryModel.TI_Audition %>" />
            <input type="hidden" name="TI_AuditionResult"  value="<%=queryModel.TI_AuditionResult %>" />
            <input type="hidden" name="TI_FollowUpPeople"  value="<%=queryModel.TI_FollowUpPeople %>" />
            <input type="hidden" name="TI_RecommendPost"  value="<%=queryModel.TI_RecommendPost %>" />
        </ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
                <li><a class="button" href="TalentCx/TalentCxDialog.aspx" target="dialog"  title="高级检索" height="555" width="370"><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">
    <div class="panelBar" <%=per.PM_Level >= 1 ? "":"style='display:none'" %> >
		<ul class="toolBar">
			<!--<li><a class="add" href="NewsDir/addNew.aspx" target="navTab" rel="addNew" ><span>新增</span></a></li>
            <li><a title="确实要删除这些记录吗?" target="selectedTodo" rel="ids" posttype="string" href="ajaxWebServices.ashx?webmethod=delPersonInnovate" class="delete"><span>删除</span></a></li>
		    <li><a class="edit" href="Person/PersonCreate.aspx?PP_FID={sid_Person}"  target="navTab" rel="TDTASB" ><span>明细</span></a></li> -->
            <li><a  href="" class="icon" onclick="$(this).attr('href','report.ashx?mode=2&queryStr='+encodeURI($(this).attr('data')));"  target="_blank" data="<%=queryStr %>" ><span>导出</span></a></li>
        </ul>
	</div>

    <table class="table" width="2300px"   <%=per.PM_Level >= 1 ? "layouth='138'":"layouth='111'" %> >
        <thead>
            <tr>
                <th width="100">
                        序号
                </th>
                <th width="200">
                    公司名称
                </th> 
                <th width="100">
                    公司所在地
                </th> 
                <th width="100">
                    品牌或企业
                </th> 
                <th width="100">
                    行业
                </th> 
                <th width="100">
                    人才类别
                </th>
                <th width="100">
                    姓名
                </th> 
                <th width="100">
                    性别
                </th>
                <%=per.PM_Level >= 1 ? "<th width='100'>联系方式</th>" : ""%>
                <th width="100">
                    工作经历
                </th> 
                <th width="100">
                    来源
                </th> 
                <th width="100">
                    推荐人
                </th>
                <th width="100">
                    推荐日期
                </th> 
                <th width="100">
                    推荐岗位
                </th>
                <th width="100">
                    特点
                </th>
                <th width="100">
                    是否面试
                </th> 
                <th width="100">
                    面试结果
                </th>
                <th width="100">
                    跟进人
                </th>
                <th width="100">
                    维护信息
                </th>
                <%=per.PM_Level >= 1 ? "<th width='100'>简历下载</th>" : ""%>
            </tr>
        </thead>
        <tbody>
            <%=listStr %>
        </tbody>
    </table>

    <div class="panelBar">
        <div class="pages">
            <span>每页显示20条，共<%=total %>条</span>
        </div>
        <div class="pagination" targettype="navTab" totalcount="<%=total %>" numperpage="20" pagenumshown="10"
            currentpage="<%=index %>">
        </div>
    </div>
</div>


