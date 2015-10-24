<!-- #include file="conn.asp" -->
<%
SiteSettings=Execute("[BBSXP_SiteSettings]")

'=========================================================
' 调用代码
'<script type="text/javascript" src="http://www.***.com/New.asp?TopicCount=10&TitleLen=15&Showtime=1&icon=◎"></script>
'---------------------------------------------------------
'调用的参数及说明：
' ForumID:    指定论坛的ID（若不指定，调用整个论坛）
' TopicCount: 显示多少条主题（最高100条）
' TimeLimit:  显示多长时间内的帖子（单位：天）
' Sort:       排序方式 ThreadID[新帖] 、TotalViews[人气帖] 、TotalReplies[热门帖] 、IsGood[精华帖]
' icon:       标题前的符号（如："◎"）
' TitleLen:   显示标题的长度
' Showtime:   是否显示发表时间 1=是 0=否
'=========================================================
ForumID=RequestInt("ForumID")
TopicCount=RequestInt("TopicCount")
TitleLen=RequestInt("TitleLen")
TimeLimit=RequestInt("TimeLimit")
icon=HTMLEncode(Request("icon"))
Sort=HTMLEncode(Request("Sort"))

if Sort = empty then
	SqlSort="ThreadID"
else
	SqlSort=Sort
end if

if TitleLen=0 then
	SqlTitleLen=100
else
	SqlTitleLen=TitleLen
end if


if TopicCount=0 then
	SqlTopicCount=10
elseif TopicCount>100 then
	SqlTopicCount=100
else
	SqlTopicCount=TopicCount
end if



if ForumID > 0 then SqlForumID=" and ForumID="&ForumID&""
if TimeLimit > 0 then SqlTimeLimit=" and DateDiff("&SqlChar&"d"&SqlChar&",PostTime,"&SqlNowString&") < "&TimeLimit&""


	sql="Select top "&SqlTopicCount&" * from [BBSXP_Threads] where IsDel=0 and IsApproved=1 "&SqlForumID&" "&SqlTimeLimit&" order by "&SqlSort&" desc"
	Set Rs=Execute(sql)
	list="<table width='100%'>"
	do while Not Rs.Eof

	Topic=ReplaceText(Rs("Topic"),"<[^>]*>","")
	if Request("Showtime")=1 then Showtime=" ["&Rs("PostTime")&"]"
	
	list=list&"<tr height='22px' style='background:#fff' ><td><img src='icon/arrow.GIF' /><a href='../bbsxp/ShowPost.asp?ThreadID="&Rs("ThreadID")&"' target='_self'> "&Left(Topic,SqlTitleLen)&"</a>"&Showtime&"</td><tr>"

	Rs.MoveNext
	Loop
	Rs.close
	list=list&"</table>"
%>
document.write("<%=list%>")