<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentClassCx.aspx.cs" Inherits="Talent.Web.TalentClass.TalentClassCx" %>


<form id="pagerForm" method="post" action="TalentClass/TalentClassCx.aspx">
<input type="hidden" name="pageNum" value="1" />
<input type="hidden" name="numPerPage" value="20" />

</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" rel="pagerForm" action="TalentClass/TalentClassCx.aspx" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>人才类别：</label>
                <input   type="text" name="TC_Class" value='<%=Request["TC_Class"] %>' size=25 class="medium"  />
            </li>
        </ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >查询</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">
    <div class="panelBar" <%=per.PM_Level >= 1 ? "":"style='display:none'" %>>
		<ul class="toolBar"  >
			<li><a class="add" href="TalentClass/EditTalentClass.aspx?webmethod=addTalentClass" target="dialog" rel="addTalent" ><span>新增</span></a></li>
            <li><a class="edit" href="TalentClass/EditTalentClass.aspx?webmethod=updateTalentClass&TC_No={sid_class}"  target="dialog" rel="TDTASB" ><span>编辑</span></a></li>
            <li><a title="确实要删除这些记录吗?" target="selectedTodo" rel="ids" posttype="string" href="ajaxWebServices.ashx?webmethod=delTalentClass" class="delete"><span>删除</span></a></li>
            <li class="line" >line</li>     
            <li><a  class="icon" onclick="$(this).attr('href','report.ashx?mode=1&queryStr='+encodeURI($(this).attr('data')));"  target="_blank" data="<%=queryStr %>" ><span>导出</span></a></li>
           <!-- <li><a  href="" src="javascript:void(0)" onclick="return false" target="_blank"  name="" ><span>导出</span></a></li> -->
        </ul>
	</div>

    <table class="table" width="100%"   <%=per.PM_Level >= 1 ? "layouth='138'":"layouth='111'" %> >
        <thead>
            <tr>
                <th width="30">
                    <input type="checkbox" group="ids" class="checkboxCtrl">
                </th>
                <th width="50">
                        序号
                </th>
                <th width="100">
                    人才类别
                </th> 
                <th width="50">
                    颜色
                </th>
            </tr>
        </thead>
        <tbody runat="server" id="TalentClassList">
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

