<!-- #include file="conn.asp" -->
<%
SiteSettings=Execute("[BBSXP_SiteSettings]")

'=========================================================
' ���ô���
'<script type="text/javascript" src="http://www.***.com/New.asp?TopicCount=10&TitleLen=15&Showtime=1&icon=��"></script>
'---------------------------------------------------------
'���õĲ�����˵����
' ForumID:    ָ����̳��ID������ָ��������������̳��
' TopicCount: ��ʾ���������⣨���100����
' TimeLimit:  ��ʾ�೤ʱ���ڵ����ӣ���λ���죩
' Sort:       ����ʽ ThreadID[����] ��TotalViews[������] ��TotalReplies[������] ��IsGood[������]
' icon:       ����ǰ�ķ��ţ��磺"��"��
' TitleLen:   ��ʾ����ĳ���
' Showtime:   �Ƿ���ʾ����ʱ�� 1=�� 0=��
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