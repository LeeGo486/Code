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

    <div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid" >
                                  <div class="panelBar"  <%=per.PM_Level >= 1 ? "":"style='display:none'" %> >
                                        <ul class="toolBar">
                                            <li><a class="add" href="javascript:void(0);" onclick="TalentInfo.AddRow(this);return false;">
                                                <span>添加</span></a></li>
                                            <li><a class="delete" href="javascript:void(0);" name="TalentDel" data='{sid_talent}'>
                                                <span>删除</span></a></li>
                                            <li class="line">line</li>               
                                            <li><a class="icon" href="javascript:void(0);" name="TalentSubmit" onclick='$(this).parents(".pageForm:first").submit();' >
                                                <span>保存</span></a></li>
                                            <li class="line">line</li>
                                            <li ><a class="icon" onclick="$(this).attr('href','report.ashx?mode=3&queryStr='+encodeURI($(this).attr('data')));"  target="_blank" data="<%=queryStr %>"  > <span>导出</span></a></li>
                                        </ul>
                                    </div>
                                    <table class="table" width="3800px"  <%=per.PM_Level >= 1 ? " layoutH='103'":" layoutH='77'" %>   rel="jbsxBox">
                                        <thead>
                                            <tr>
                                                <th width="80">
                                                    序号
                                                </th>
                                                <th width="150">
                                                    其他重要雇主
                                                </th>
                                                <th width="200">
                                                    品牌或企业
                                                </th>
                                                <th width="200">
                                                    行业
                                                </th>
                                                <th width="100">
                                                    人才类别
                                                </th>
                                                <th width="100">
                                                    姓名
                                                </th>
                                                <th width="50">
                                                    性别
                                                </th>
                                                <%=per.PM_Level >= 1 ? "<th width='100'>联系方式</th>" : ""%> 
                                                <th width="100">
                                                    邮箱
                                                </th>
                                                <th width="400">
                                                    推荐理由
                                                </th>
                                                <th width="400">
                                                    工作经历
                                                </th>
                                                <th width="100">
                                                    简历获取渠道
                                                </th>
                                                <th width="100">
                                                    推荐人或公司
                                                </th>
                                                <th width="100">
                                                    推荐岗位
                                                </th>
                                                <th width="100">
                                                    其它可能适合的岗位
                                                </th>
                                                <th width="100">
                                                    面试官
                                                </th>
                                                <th width="100">
                                                    特点
                                                </th>
                                                <th width="100">
                                                    是否面试
                                                </th>
                                                <th width="300">
                                                    面试官反馈
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
                                        <tbody name="TalentsList">
                                            <%=talentsper %>
                                        </tbody>
                                    </table>  
                                <div class="panelBar">
		                            <div class="pages">
			                            <span>每页显示20条，共<%=total %>条</span>
		                            </div>
		
		                            <div class="pagination" rel="listID" totalCount="<%=total %>" numPerPage="20" pageNumShown="5" currentPage="<%=index %>"></div>
	                            </div>
    </div>

</form>