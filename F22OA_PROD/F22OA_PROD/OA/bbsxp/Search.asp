<!-- #include file="Setup.asp" --><%
HtmlTop


ForumID=RequestInt("ForumID")
DateComparer=RequestInt("DateComparer")

if Request("menu")="Result" then
	Keywords=HTMLEncode(Request("Keywords"))

	SortBy=HTMLEncode(Request("SortBy"))
	Item=HTMLEncode(Request("Item"))

	if Keywords="" then error("您没有输入任何查询条件！")
	if Request("VerifyCode")<>Session("VerifyCode") or Session("VerifyCode")="" then error("验证码错误！")

	SQLSearch="IsApproved=1 and IsDel=0 and "&Item&" like '%"&Keywords&"%' "
		
	
	if DateComparer > 0 then SQLSearch=SQLSearch&" and DateDiff("&SqlChar&"d"&SqlChar&",PostTime,"&SqlNowString&") < "&DateComparer&" "

	if ForumID > 0 then SQLSearch=SQLSearch&" and ForumID="&ForumID&" "


	sql="Select * from [BBSXP_Threads] where "&SQLSearch&" order by ThreadID "&SortBy&""
	Rs.Open sql,Conn,1
		count=Execute("Select count(ThreadID) from [BBSXP_Threads] where "&SQLSearch&"")(0)    '数据总条数
		if Count=0 then error("对不起，没有找到您要查询的内容")
		PageSetup=SiteConfig("ThreadsPerPage") '设定每页的显示数量
		Rs.Pagesize=PageSetup
		TotalPage=Rs.Pagecount  '总页数
		PageCount = RequestInt("PageIndex")
		if PageCount <1 then PageCount = 1
		if PageCount > TotalPage then PageCount = TotalPage
		if TotalPage>0 then Rs.absolutePage=PageCount '跳转到指定页数
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 搜索结果</div>

<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<tr>
		<td width="100%" align="right">共找到了 <b><font color="FF0000"><%=Count%></font></b> 篇相关帖子</td>
	</tr>
</table>



<table cellspacing="1" cellpadding="5" width="100%" id="CommonListArea">
	<tr id="CommonListTitle">
		<td colspan="5">主题</td>
	</tr>
	<tr id="CommonListHeader" align="center">
		<td>标题</td>
		<td>作者</td>
		<td>回复</td>
		<td>查看</td>
		<td>最后更新</td>
	</tr>
<%
i=0
Do While Not RS.EOF and i<pagesetup
i=i+1
ShowThread()
Rs.MoveNext
loop
Rs.Close
%>
</table>


<table cellspacing=0 cellpadding=0 border=0 width=100%>
	<tr>
		<td width="100%"><%ShowPage()%></td>
	</tr>
</table>

<%
	HtmlBottom
end if
%>
<div id="CommonBreadCrumbArea"><%ClubTree%> → 搜索帖子</div>
<table cellspacing=1 cellpadding=5 width=100% id=CommonListArea>
	<form method="POST" action="Search.asp?menu=Result" name="form">
		<tr id=CommonListTitle>
			<td colspan="2">搜索选项</td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">关键词：</td>
			<td><input size="40" name="Keywords" onkeyup="ValidateTextboxAdd(this, 'btnadd')" onpropertychange="ValidateTextboxAdd(this, 'btnadd')"></td>
		</tr>
		<tr id=CommonListCell>
			<td width="40%" align="right">搜索内容：</td>
			<td> 
			<input type="radio" name="Item" value="Topic" id="Topic" checked><label for="Topic">主题</label> 
			<input type="radio" name="Item" value="Tags" id="Tags"><label for="Tags">标签</label> 
			<input type="radio" name="Item" value="Category" id="Category"><label for="Category">类别</label> 
			<input type="radio" name="Item" value="PostAuthor" id="PostAuthor"><label for="PostAuthor">作者</label> 
			<input type="radio" name="Item" value="LastName" id="LastName"><label for="LastName">最后更新的用户</label> 
		</tr>
		<tr id=CommonListCell>
			<td align="right">日期范围：</td>
			<td>
			<select size="1" name="DateComparer">
				<option value="1" >昨天以来</option>
				<option value="2" >2 天以来</option>
				<option value="7" >1 周以来</option>
				<option value="10" >10 天以来</option>
				<option value="14" >2 周以来</option>
				<option value="30" >1 个月以来</option>
				<option value="45" >45 天以来</option>
				<option value="60" >2 个月以来</option>
				<option value="75" >75 天以来</option>
				<option value="100" >100 天以来</option>
				<option value="365" selected="selected">1 年以来</option>
				<option value="-1">任何时间</option>
				</select>
</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">排序方式：</td>
			<td>
				<select  name="SortBy">
					<option value="">从旧到新</option>
					<option value="Desc" selected="">从新到旧</option>
				</select>
			</td>
		</tr>
		<tr id=CommonListCell>
			<td align="right">搜索论坛：</td>
			<td>
				<select name="ForumID">
				<option value="0">全部论坛</option>
				<%=GroupList(ForumID)%>
				</select>
			</td>
		</tr>
		
	<tr id=CommonListCell>
		<td align="right">验证码：</td>
		<td><input type="text" name="VerifyCode" MaxLength="4" size="10" onblur="CheckVerifyCode(this.value)" onKeyUp="if (this.value.length == 4)CheckVerifyCode(this.value)"> <img src="VerifyCode.asp" title="验证码,看不清楚?请点击刷新验证码" style="cursor:pointer" onclick="this.src='VerifyCode.asp?'+Math.random()"> <span id="CheckVerifyCode" style="color:red"></span></td>
	</tr>
		<tr id=CommonListCell>
			<td colspan="2" align="center"><input type="submit" value="开始搜索" id="btnadd" disabled></td>
		</tr>
	</form>
</table>
<%
HtmlBottom
%>