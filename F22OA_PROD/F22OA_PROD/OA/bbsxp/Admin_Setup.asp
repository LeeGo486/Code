<!-- #include file="Setup.asp" -->
<%
AdminTop
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"
Log("")

select case Request("menu")
	case "Showbanner"
		Showbanner
	case "variable"
		variable
	case "SiteSettingsUp"
		SiteSettingsUp
	case "SiteInfo"
		SiteInfo
	case "UserAgreement"
		UserAgreement
end select

Sub variable
DomainPath=Left(Script_Name,inStrRev(Script_Name,"/"))
if SiteConfig("SiteUrl")="" then
	SiteUrl="http://"&Server_Name&DomainPath
	SiteUrl=left(SiteUrl,len(SiteUrl)-1)
else
	SiteUrl=SiteConfig("SiteUrl")
end if

%>
<script language="JavaScript">
function VerifyInput() {
	if (document.form.SiteName.value == "")
	{
		alert("请输入站点名称");
		return false;
	}
	if (document.form.DefaultSiteStyle.value == "")
	{
		alert("默认风格不能没有设置");
		return false;
	}
}
</SCRIPT>
<script type="text/javascript" src="Utility/selectColor.js"></script>

<form method="POST" action="?menu=SiteInfo" onsubmit="return VerifyInput();" name=form>
<table cellspacing=0 cellpadding=0 width=100%>
  <tr height=22 style="text-align:center">
    <td class=PannelOn id=PannelHeader0 onclick="ShowPannel(0,8)">普通配置</td>
    <td class=PannelOff id=PannelHeader1 onclick="ShowPannel(1,8)">首页显示</td>
    <td class=PannelOff id=PannelHeader6 onclick="ShowPannel(6,8)">用户注册</td>
    <td class=PannelOff id=PannelHeader7 onclick="ShowPannel(7,8)">论坛设置</td>
    <td class=PannelOff id=PannelHeader2 onclick="ShowPannel(2,8)">上传设置</td>
    <td class=PannelOff id=PannelHeader4 onclick="ShowPannel(4,8)">邮件设置</td>
    <td class=PannelOff id=PannelHeader5 onclick="ShowPannel(5,8)">过滤设置</td>
    <td class=PannelOff id=PannelHeader8 onclick="ShowPannel(8,8)">验证码设置</td>
    <td class=PannelOff id=PannelHeader3 onclick="ShowPannel(3,8)">金钱和经验设置</td>
    <td width=50 class="TableRight">　</td>

  </tr>
</table>

<table id="Pannel0" style="display:" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="30%"><a class="helpicon" title='论坛名称，它将在论坛所有页面的浏览器窗口标题中显示。'><img src="images/spacer.gif" border="0"></a><b>论坛名称</b></td>
		<td><input size="30" name="SiteName" value="<%=SiteConfig("SiteName")%>"></td>
	</tr>


	<tr>
		<td width="30%"><a class="helpicon" title='您访问这个论坛的网址。注意: 不要以斜杠 (“/”) 结尾。'><img src="images/spacer.gif" border="0"></a><b>论坛网址</b></td>
		<td><input size="30" name="SiteUrl" value="<%=SiteUrl%>"></td>
	</tr>

	<tr>
		<td><a class="helpicon" title='请输入公司/组织名称'><img src="images/spacer.gif" border="0"></a><b>公司/组织名称</b></td>
		<td><input size="30" name="CompanyName" value="<%=SiteConfig("CompanyName")%>"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='请输入公司/组织网址'><img src="images/spacer.gif" border="0"></a><b>公司/组织网址</b></td>
		<td><input size="30" value="<%=SiteConfig("CompanyURL")%>" name="CompanyURL"></td>
	</tr>
	

	<tr>
		<td><a class="helpicon" title='键入简短的网页说明。如果网站访问者在您的网站或万维网上搜索内容，则会在搜索结果中看到此说明。'><img src="images/spacer.gif" border="0"></a><b>META标签-描述信息</b></td>
		<td><input size="60" name="MetaDescription" value="<%=SiteConfig("MetaDescription")%>" /></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='键入描述网页内容的一个或多个关键字（用一个逗号和一个空格分隔）。一些 Internet 搜索引擎使用这些关键字来确定网页是否满足搜索查询条件。'><img src="images/spacer.gif" border="0"></a><b>META标签-关键字</b></td>
		<td><input size="60" name="MetaKeywords" value="<%=SiteConfig("MetaKeywords")%>" /></td>
	</tr>
	
	
	<tr>
		<td><a class="helpicon" title='默认:20'><img src="images/spacer.gif" border="0"></a><b>统计用户在线时间（分钟）</b></td>
		<td><input size="20" value="<%=SiteConfig("UserOnlineTime")%>" name="UserOnlineTime"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='默认:60'><img src="images/spacer.gif" border="0"></a><b>脚本超时时间（秒）</b></td>
		<td><input size="20" value="<%=SiteConfig("Timeout")%>" name="Timeout"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='指定 Themes/ 目录下的目录名即可 [默认:default]'><img src="images/spacer.gif" border="0"></a><b>默认风格目录</b></td>
		<td><input size="20" value="<%=SiteConfig("DefaultSiteStyle")%>" name="DefaultSiteStyle"></td>
	</tr>

	<tr>
		<td><a class="helpicon" title='默认:BBSXP'><img src="images/spacer.gif" border="0"></a><b>站点缓存名称</b></td>
		<td><input size="20" value="<%=SiteConfig("CacheName")%>" name="CacheName"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='默认:5分钟'><img src="images/spacer.gif" border="0"></a><b>缓存更新间隔（分钟）</b></td>
		<td><input size="20" value="<%=SiteConfig("CacheUpDateInterval")%>" name="CacheUpDateInterval"></td>
	</tr>
	

	<tr>
		<td width="40%"><a class="helpicon" title='Cookie 保存的路径。如果您在同一个域名下运行了多个论坛，便需要将它设置为每个论坛所在的目录名。否则，填写 / 便可以了。'><img src="images/spacer.gif" border="0"></a><b>Cookies 保存路径</b></td>
		<td>
		<select name="CookiePath" size="1">
		<option value="/">/</option>
		<option value="<%=DomainPath%>" <%if SiteConfig("CookiePath")=DomainPath then%>selected<%end if%>><%=DomainPath%></option>
		</select></td>
	</tr>


	<tr>
		<td><a class="helpicon" title='维护期间可设置关闭论坛'><img src="images/spacer.gif" border="0"></a><b>论坛状态</b></td>
		<td><input type="radio" name="SiteDisabled" value=1 <%if SiteConfig("SiteDisabled")=1 then%>checked<%end if%>>关闭 <input type="radio" name="SiteDisabled" value=0 <%if SiteConfig("SiteDisabled")=0 then%>checked<%end if%>>打开</td>
	</tr>
	
	
	<tr>
		<td><a class="helpicon" title='论坛关闭时出现的提示信息'><img src="images/spacer.gif" border="0"></a><b>论坛关闭的原因</b></td>
		<td><input size="50" value="<%=SiteConfig("SiteDisabledReason")%>" name="SiteDisabledReason"></td>
	</tr>



	<tr>
		<td width="30%"><a class="helpicon" title='选择“是”将使论坛加入“no-cache”的 HTTP 头信息，客户端不再保留页面缓存。这可能因页面请求增加而导致服务器负载增加。'><img src="images/spacer.gif" border="0"></a><b>添加“No-cache”HTTP 头信息</b></td>
		<td>
		<input type="radio" name="NoCacheHeaders" value=1 <%if SiteConfig("NoCacheHeaders")=1 then%>checked<%end if%>>是 
		<input type="radio" name="NoCacheHeaders" value=0 <%if SiteConfig("NoCacheHeaders")=0 then%>checked<%end if%>>否 
		</td>
	</tr>	
	
</table>

<table id="Pannel1" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="30%"><a class="helpicon" title='在首页上显示“用户在线信息”部分'><img src="images/spacer.gif" border="0"></a><b>显示在线用户</b></td>
		<td>
		<input type="radio" name="DisplayWhoIsOnline" value=1 <%if SiteConfig("DisplayWhoIsOnline")=1 then%>checked<%end if%>>是 
		<input type="radio" name="DisplayWhoIsOnline" value=0 <%if SiteConfig("DisplayWhoIsOnline")=0 then%>checked<%end if%>>否 
		</td>
	</tr>	
	<tr>
		<td><a class="helpicon" title='在首页上显示“统计信息”部分'><img src="images/spacer.gif" border="0"></a><b>显示统计信息</b></td>
		<td>
		<input type="radio" name="DisplayStatistics" value=1 <%if SiteConfig("DisplayStatistics")=1 then%>checked<%end if%>>是 
		<input type="radio" name="DisplayStatistics" value=0 <%if SiteConfig("DisplayStatistics")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='在首页上显示“今天过生日的用户”部分'><img src="images/spacer.gif" border="0"></a><b>显示今天的生日榜</b></td>
		<td>
		<input type="radio" name="DisplayBirthdays" value=1 <%if SiteConfig("DisplayBirthdays")=1 then%>checked<%end if%>>是 
		<input type="radio" name="DisplayBirthdays" value=0 <%if SiteConfig("DisplayBirthdays")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='在首页上显示“友情链接”部分'><img src="images/spacer.gif" border="0"></a><b>显示友情链接</b></td>
		<td>
		<input type="radio" name="DisplayLink" value=1 <%if SiteConfig("DisplayLink")=1 then%>checked<%end if%>>是 
		<input type="radio" name="DisplayLink" value=0 <%if SiteConfig("DisplayLink")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='在版块列表中显示子版块'><img src="images/spacer.gif" border="0"></a><b>版块列表中显示子版块</b></td>
		<td>
		<input type="radio" name="IsShowSonForum" value=1 <%if SiteConfig("IsShowSonForum")=1 then%>checked<%end if%>>是 
		<input type="radio" name="IsShowSonForum" value=0 <%if SiteConfig("IsShowSonForum")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
</table>

<table id="Pannel2" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>上传组件选择</b></font></td></tr>

	<tr>
		<td width="40%"><a class="helpicon" title='根据 服务支持的组件 选择上传组件'><img src="images/spacer.gif" border="0"></a><b>选择上传组件</b></td>
		<td>
		<select name="UpFileOption" size="1" onchange="IsObjInstalled('IsUpFileInstalled',this.options[this.selectedIndex].value)">
		<option value="">关闭</option>
		<option value="ADODB.Stream" <%if SiteConfig("UpFileOption")="ADODB.Stream" then%>selected<%end if%>>ADODB.Stream</option>
		<option value="SoftArtisans.FileUp" <%if SiteConfig("UpFileOption")="SoftArtisans.FileUp" then%>selected<%end if%>>SoftArtisans.FileUp</option>
		</select> <span id="IsUpFileInstalled"></span></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='默认:10 KB'><img src="images/spacer.gif" border="0"></a><b>允许单个头像文件的大小 (KB)</b></td>
		<td><input size="20" value="<%=SiteConfig("MaxFaceSize")%>" name="MaxFaceSize"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='默认:1024 KB（1M）'><img src="images/spacer.gif" border="0"></a><b>允许单个帖子附件的大小 (KB)</b></td>
		<td><input size="20" value="<%=SiteConfig("MaxFileSize")%>" name="MaxFileSize"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='默认:10240 KB（10M）'><img src="images/spacer.gif" border="0"></a><b>设置用户上传文件夹的最大容量 (KB)</b></td>
		<td><input size="20" value="<%=SiteConfig("MaxPostAttachmentsSize")%>" name="MaxPostAttachmentsSize"></td>
	</tr>
	
	
	<tr>
		<td><a class="helpicon" title='例如：gif|jpg|png|bmp|swf|txt|mid|doc|xls|zip|rar'><img src="images/spacer.gif" border="0"></a><b>允许上传的附件类型（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("UpFileTypes")%>" name="UpFileTypes"></td>
	</tr>	
	
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>水印组件选择</b></font></td></tr>
	<tr>
		<td width="30%"><a class="helpicon" title='水印组件设置：关闭/启用'><img src="images/spacer.gif" border="0"></a><b>水印图片组件</b></td>
		<td>
		<select name="WatermarkOption" size="1" onchange="IsObjInstalled('IsWatermarkInstalled',this.options[this.selectedIndex].value)">
		<option value="">关闭</option>
		<option value="Persits.Jpeg" <%if SiteConfig("WatermarkOption")="Persits.Jpeg" then%>selected<%end if%>>Persits.Jpeg</option>
		</select> <span id="IsWatermarkInstalled"></span>
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='请选择：水印效果（只支持JPEG）'><img src="images/spacer.gif" border="0"></a><b>水印效果</b></td>
		<td><select name="WatermarkType" size="1">
		<option value="0" <%if SiteConfig("WatermarkType")="0" then%>selected<%end if%>>水印文字</option>
		<option value="1" <%if SiteConfig("WatermarkType")="1" then%>selected<%end if%>>水印图片</option>
		</select></td>
	</tr>
	
	
	<tr>
		<td><a class="helpicon" title='水印水平位置'><img src="images/spacer.gif" border="0"></a><b>水印水平位置</b></td>
		<td>
		<input type="radio" name="WatermarkWidthPosition" value="left" <%if SiteConfig("WatermarkWidthPosition")="left" then%>checked<%end if%>>左
		<input type="radio" name="WatermarkWidthPosition" value="center" <%if SiteConfig("WatermarkWidthPosition")="center" then%>checked<%end if%>>中
		<input type="radio" name="WatermarkWidthPosition" value="right" <%if SiteConfig("WatermarkWidthPosition")="right" then%>checked<%end if%>>右
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='水印垂直位置（此项只针对图片）'><img src="images/spacer.gif" border="0"></a><b>水印垂直位置</b></td>
		<td>
		<input type="radio" name="WatermarkHeightPosition" value="top" <%if SiteConfig("WatermarkHeightPosition")="top" then%>checked<%end if%>>上
		<input type="radio" name="WatermarkHeightPosition" value="center" <%if SiteConfig("WatermarkHeightPosition")="center" then%>checked<%end if%>>中
		<input type="radio" name="WatermarkHeightPosition" value="bottom" <%if SiteConfig("WatermarkHeightPosition")="bottom" then%>checked<%end if%>>下
		</td>
	</tr>	
	
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>水印文字</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='该文字将显示于用户上传的图片上'><img src="images/spacer.gif" border="0"></a><b>水印文字</b></td>
		<td><input size="30" value="<%=SiteConfig("WatermarkText")%>" name="WatermarkText"></td>
	</tr>
	

	<tr>
		<td><a class="helpicon" title='用于设置水印文字字体名称'><img src="images/spacer.gif" border="0"></a><b>水印文字字体</b></td>
		<td>
		<SELECT name="WatermarkFontFamily">
		<option value="<%=SiteConfig("WatermarkFontFamily")%>" selected><%=SiteConfig("WatermarkFontFamily")%></option>
		<option value="宋体">宋体</option>
		<option value="黑体">黑体</option>
		<OPTION value="Arial">Arial</OPTION> 
		<OPTION value="Arial Black">Arial Black</OPTION> 
		<OPTION value="Times New Roman" >Times New Roman</OPTION>
		<OPTION value="Garamond">Garamond</OPTION>
		<OPTION value="Lucida Handwriting">Lucida Handwriting</OPTION>
		<OPTION value="Verdana">Verdana</OPTION>
		</SELECT>
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='设置水印文字字体大小'><img src="images/spacer.gif" border="0"></a><b>水印文字大小</b></td>
		<td><input size="2" value="<%=SiteConfig("WatermarkFontSize")%>" name="WatermarkFontSize"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='设置水印文字字体颜色'><img src="images/spacer.gif" border="0"></a><b>水印文字颜色</b></td>
		<td><img title="点击选取颜色!" id="WatermarkFontColor" onClick="OpenColorPicker('WatermarkFontColor', event)" style="CURSOR:pointer;BACKGROUND-COLOR:<%=SiteConfig("WatermarkFontColor")%>" src="images/rect.gif"><input type="hidden" value="<%=SiteConfig("WatermarkFontColor")%>" name="WatermarkFontColor">
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='设置水印字体是否显示粗体'><img src="images/spacer.gif" border="0"></a><b>水印文字是否粗体</b></td>
		<td>
		<input type="radio" name="WatermarkFontIsBold" value=1 <%if SiteConfig("WatermarkFontIsBold")=1 then%>checked<%end if%>>是 
		<input type="radio" name="WatermarkFontIsBold" value=0 <%if SiteConfig("WatermarkFontIsBold")=0 then%>checked<%end if%>>否 
		</td>
	</tr>

	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>水印图片</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='该图片将显示于用户上传的图片上'><img src="images/spacer.gif" border="0"></a><b>水印图片的相对路径</b></td>
		<td><input size="30" value="<%=SiteConfig("WatermarkImage")%>" name="WatermarkImage"></td>
	</tr>	
	
</table>
<table id="Pannel4" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="30%"><a class="helpicon" title='发送邮件组件设置：开启/关闭'><img src="images/spacer.gif" border="0"></a><b>发送邮件组件</b></td>
		<td>
		<select name="SelectMailMode" size="1" onchange="IsObjInstalled('IsMailObjInstalled',this.options[this.selectedIndex].value)">
		<option value="">关闭</option>
		<option value="JMail.Message" <%if SiteConfig("SelectMailMode")="JMail.Message" then%>selected<%end if%>>JMail.Message</option>
		<option value="CDO.Message" <%if SiteConfig("SelectMailMode")="CDO.Message" then%>selected<%end if%>>CDO.Message</option>
		</select> <span id=IsMailObjInstalled></span>
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用来发送电子邮件的地址'><img src="images/spacer.gif" border="0"></a><b>发件人Email地址</b></td>
		<td><input size="30" value="<%=SiteConfig("SmtpServerMail")%>" name="SmtpServerMail"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='如果您启用了 SMTP 发送邮件，请在这里指定 SMTP 服务器。一般情况下在这里输入 IP 地址会比输入主机域名更快。'><img src="images/spacer.gif" border="0"></a><b>SMTP 服务器</b></td>
		<td><input size="30" value="<%=SiteConfig("SmtpServer")%>" name="SmtpServer"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='如果您启用了 SMTP 发送邮件，并且服务器需要认证，请在这里输入用户名。'><img src="images/spacer.gif" border="0"></a><b>SMTP 用户名</b></td>
		<td><input size="30" value="<%=SiteConfig("SmtpServerUserName")%>" name="SmtpServerUserName"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='如果您启用了 SMTP 发送邮件，并且服务器需要认证，请在这里输入密码。'><img src="images/spacer.gif" border="0"></a><b>SMTP 密码</b></td>
		<td><input type=password size="30" value="<%=SiteConfig("SmtpServerPassword")%>" name="SmtpServerPassword"></td>
	</tr>
</table>

<table id="Pannel5" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="40%"><a class="helpicon" title='例如：link|script|object|iframe|form|style|div|caption|!--|meta'><img src="images/spacer.gif" border="0"></a><b>过滤HTML标签（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("BannedHtmlLabel")%>" name="BannedHtmlLabel"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='例如：javascript:|onerror|onload|onmouseover'><img src="images/spacer.gif" border="0"></a><b>过滤HTML标签内的事件（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("BannedHtmlEvent")%>" name="BannedHtmlEvent"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='例如：fuck|shit|你妈'><img src="images/spacer.gif" border="0"></a><b>过滤发表时含有的敏感词（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("BannedText")%>" name="BannedText"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='例如：fuck|shit'><img src="images/spacer.gif" border="0"></a><b>禁止注册的字符（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("BannedRegUserName")%>" name="BannedRegUserName"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='例如：127.0.0.1|192.168.0.1'><img src="images/spacer.gif" border="0"></a><b>禁止IP地址进入论坛（请用“|”分隔）</b></td>
		<td><input size="60" value="<%=SiteConfig("BannedIP")%>" name="BannedIP"></td>
	</tr>
</table>

<table id="Pannel6" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>新注册设置</b></font></td></tr>
	<tr>
		<td width="30%"><a class="helpicon" title='禁止登录时，仅管理员可以登录站点。'><img src="images/spacer.gif" border="0"></a><b>允许登录</b></td>
		<td>
		<input type="radio" name="AllowLogin" value=1 <%if SiteConfig("AllowLogin")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowLogin" value=0 <%if SiteConfig("AllowLogin")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='控制是否允许被禁用帐号的用户登录，他们在试图发帖之前不会注意到自己帐号已被禁用。'><img src="images/spacer.gif" border="0"></a><b>允许被禁用帐号的用户登录</b></td>
		<td>
		<input type="radio" name="EnableBannedUsersToLogin" value=1 <%if SiteConfig("EnableBannedUsersToLogin")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableBannedUsersToLogin" value=0 <%if SiteConfig("EnableBannedUsersToLogin")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='禁止后，新用户将不能注册。'><img src="images/spacer.gif" border="0"></a><b>允许新用户注册</b></td>
		<td>
		<input type="radio" name="AllowNewUserRegistration" value=1 <%if SiteConfig("AllowNewUserRegistration")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowNewUserRegistration" value=0 <%if SiteConfig("AllowNewUserRegistration")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用于控制新注册的用户在 发帖需要审核的版块 中所发的帖子是否需要审核'><img src="images/spacer.gif" border="0"></a><b>新用户信任等级</b></td>
		<td>
		<select name="NewUserModerationLevel">
			<option value="1" <%if SiteConfig("NewUserModerationLevel")=1 then%>selected<%end if%>>信任用户</option>
			<option value="0" <%if SiteConfig("NewUserModerationLevel")=0 then%>selected<%end if%>>非信任用户</option>
		</select> 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用户名的字符数必须大于或者等于该数值'><img src="images/spacer.gif" border="0"></a><b>用户名最小长度</b></td>
		<td><input type="text" name="UserNameMinLength" value="<%=SiteConfig("UserNameMinLength")%>"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用户名的字符数必须小于或者等于该数值'><img src="images/spacer.gif" border="0"></a><b>用户名最大长度</b></td>
		<td><input type="text" name="UserNameMaxLength" value="<%=SiteConfig("UserNameMaxLength")%>"></td>
	</tr>
	
	<tr>
		<td><a class="helpicon" title='控制用户注册后帐号激活的方式。 &quot;自动&quot;表示允许用户创建自己的帐号；&quot;Email&quot;表示新注册用户后，会通过邮件方式将密码发送给新用户；&quot;只有邀请码;表示新注册用户必须拥有已注册用户发送的邀请码才能注册；&quot;管理员审批&quot;表示帐号注册后需要管理员审批。'><img src="images/spacer.gif" border="0"></a><b>帐号激活方式</b></td>
		<td>
		<input type="radio" name="AccountActivation" value="0" <%if SiteConfig("AccountActivation")=0 then%>checked<%end if%>>自动 
		<input type="radio" name="AccountActivation" value="1" <%if SiteConfig("AccountActivation")=1 then%>checked<%end if%>>Email  
		<input type="radio" name="AccountActivation" value="2" <%if SiteConfig("AccountActivation")=2 then%>checked<%end if%>>仅邀请码 
		<input type="radio" name="AccountActivation" value="3" <%if SiteConfig("AccountActivation")=3 then%>checked<%end if%>>管理员审批</td>
	</tr>


	<tr>
		<td><a class="helpicon" title='用户密码的加密算法，可以选择MD5或SHA1'><img src="images/spacer.gif" border="0"></a><b>默认密码加密算法</b></td>
		<td>
		<input type="radio" name="DefaultPasswordFormat" value="MD5" <%if SiteConfig("DefaultPasswordFormat")="MD5" then%>checked<%end if%>>MD5 
		<input type="radio" name="DefaultPasswordFormat" value="SHA1" <%if SiteConfig("DefaultPasswordFormat")="SHA1" then%>checked<%end if%>>SHA1 
</td>
	</tr>


	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>全局用户资料设置</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='允许用户将个性签名显示在用户发的每个帖子末端。'><img src="images/spacer.gif" border="0"></a><b>启用个性签名</b></td>
		<td>
		<input type="radio" name="EnableSignatures" value=1 <%if SiteConfig("EnableSignatures")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableSignatures" value=0 <%if SiteConfig("EnableSignatures")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许个性签名最大字符数'><img src="images/spacer.gif" border="0"></a><b>个性签名最大长度
		（字节）</b></td>
		<td>
		<input type="text" name="SignatureMaxLength" value="<%=SiteConfig("SignatureMaxLength")%>">
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用户设置短信息的最大容量'><img src="images/spacer.gif" border="0"></a><b>用户短信息的最大容量（条）</b></td>
		<td>
		<input type="text" name="MaxPrivateMessageSize" value="<%=SiteConfig("MaxPrivateMessageSize")%>">
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='启用该功能后，如果用户申明自己性别，将显示该信息。'><img src="images/spacer.gif" border="0"></a><b>允许显示用户性别</b></td>
		<td>
		<input type="radio" name="AllowGender" value=1 <%if SiteConfig("AllowGender")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowGender" value=0 <%if SiteConfig("AllowGender")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许用户头像显示在用户发的每个帖子中。'><img src="images/spacer.gif" border="0"></a><b>允许帖子中显示头像</b></td>
		<td>
		<input type="radio" name="AllowAvatars" value=1 <%if SiteConfig("AllowAvatars")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowAvatars" value=0 <%if SiteConfig("AllowAvatars")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许用户将个性签名显示在用户发的每个帖子末端。'><img src="images/spacer.gif" border="0"></a><b>允许帖子中显示个性签名</b></td>
		<td>
		<input type="radio" name="AllowSignatures" value=1 <%if SiteConfig("AllowSignatures")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowSignatures" value=0 <%if SiteConfig("AllowSignatures")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='如果有多套页面主题，是否允许用户自行选择自己喜欢的页面风格？'><img src="images/spacer.gif" border="0"></a><b>允许用户选择页面主题</b></td>
		<td>
		<input type="radio" name="AllowUserToSelectTheme" value=1 <%if SiteConfig("AllowUserToSelectTheme")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowUserToSelectTheme" value=0 <%if SiteConfig("AllowUserToSelectTheme")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='访客在登录前无法浏览用户个人资料'><img src="images/spacer.gif" border="0"></a><b>浏览用户资料需要登录</b></td>
		<td>
		<input type="radio" name="RequireAuthenticationForProfileViewing" value=1 <%if SiteConfig("RequireAuthenticationForProfileViewing")=1 then%>checked<%end if%>>是 
		<input type="radio" name="RequireAuthenticationForProfileViewing" value=0 <%if SiteConfig("RequireAuthenticationForProfileViewing")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>用户列表设置</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='关闭后用户列表链接将从导航菜单中移除。'><img src="images/spacer.gif" border="0"></a><b>显示用户列表</b></td>
		<td>
		<input type="radio" name="PublicMemberList" value=1 <%if SiteConfig("PublicMemberList")=1 then%>checked<%end if%>>是 
		<input type="radio" name="PublicMemberList" value=0 <%if SiteConfig("PublicMemberList")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许用户使用更高级的的用户搜索。'><img src="images/spacer.gif" border="0"></a><b>允许用户使用高级搜索选项</b></td>
		<td>
		<input type="radio" name="MemberListAdvancedSearch" value=1 <%if SiteConfig("MemberListAdvancedSearch")=1 then%>checked<%end if%>>是 
		<input type="radio" name="MemberListAdvancedSearch" value=0 <%if SiteConfig("MemberListAdvancedSearch")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='浏览用户列表时，每页显示的用户数。'><img src="images/spacer.gif" border="0"></a><b>每页显示的用户</b></td>
		<td>
		<input type="text" name="MemberListPageSize" value="<%=SiteConfig("MemberListPageSize")%>"> 
		</td>
	</tr>
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>全局用户头像设置</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='启用后，用户可以选择个性化头像'><img src="images/spacer.gif" border="0"></a><b>启用头像</b></td>
		<td>
		<input type="radio" name="EnableAvatars" value=1 <%if SiteConfig("EnableAvatars")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableAvatars" value=0 <%if SiteConfig("EnableAvatars")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许用户使用外部链接的图片作为头像。'><img src="images/spacer.gif" border="0"></a><b>允许远端头像</b></td>
		<td>
		<input type="radio" name="EnableRemoteAvatars" value=1 <%if SiteConfig("EnableRemoteAvatars")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableRemoteAvatars" value=0 <%if SiteConfig("EnableRemoteAvatars")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='显示用户头像的最大尺寸，超过限制的图片将按比例缩小。'><img src="images/spacer.gif" border="0"></a><b>头像尺寸</b></td>
		<td>
		<input size=3 name="AvatarHeight" value="<%=SiteConfig("AvatarHeight")%>"> X <input size=3 name="AvatarWidth" value="<%=SiteConfig("AvatarWidth")%>">
		</td>
	</tr>


	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>声望设置</b></font></td></tr>


	<tr>
		<td><a class="helpicon" title='新注册的会员的声望。（默认：0）'><img src="images/spacer.gif" border="0"></a><b>默认声望</b></td>
		<td>
		<input type="text" name="ReputationDefault" value="<%=SiteConfig("ReputationDefault")%>"> 
		</td>
	</tr>


	<tr>
		<td><a class="helpicon" title='在用户资料查看页面中显示多少条其他用户的声望评价。（默认：5）'><img src="images/spacer.gif" border="0"></a><b>显示的声望评价数</b></td>
		<td>
		<input type="text" name="ShowUserRates" value="<%=SiteConfig("ShowUserRates")%>"> 
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='用户的发帖量必须达到这一数目，才能对其他用户进行声望评价。（默认：50）'><img src="images/spacer.gif" border="0"></a><b>最少发帖数</b></td>
		<td>
		<input type="text" name="MinReputationPost" value="<%=SiteConfig("MinReputationPost")%>"> 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='用户的声望值必须达到这一数目，才能对其他用户进行声望评价时。（默认：0）'><img src="images/spacer.gif" border="0"></a><b>最小声望值</b></td>
		<td>
		<input type="text" name="MinReputationCount" value="<%=SiteConfig("MinReputationCount")%>"> 
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='一个用户一天最多能对其他多少用户进行声望评价？管理员（超级版主）不受限制。（默认：10）'><img src="images/spacer.gif" border="0"></a><b>每日声望评价次数限制</b></td>
		<td>
		<input type="text" name="MaxReputationPerDay" value="<%=SiteConfig("MaxReputationPerDay")%>"> 
		</td>
	</tr>


	<tr>
		<td><a class="helpicon" title='在某用户再次给他曾经评价过的用户进行声望评价之前，必须对其他多少个用户进行声望评价？管理员（超级版主）不受限制。（默认：20）'><img src="images/spacer.gif" border="0"></a><b>用户声望范围</b></td>
		<td>
		<input type="text" name="ReputationRepeat" value="<%=SiteConfig("ReputationRepeat")%>"> 
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='管理员（超级版主）每次对其他用户进行声望评价时，其他用户得到或者失去的声望值。（默认：10）'><img src="images/spacer.gif" border="0"></a><b>管理员（超级版主）声望力</b></td>
		<td>
		<input type="text" name="AdminReputationPower" value="<%=SiteConfig("AdminReputationPower")%>"> 
		</td>
	</tr>
	
	<tr>
		<td><a class="helpicon" title='如果用户声望值低于这一数目，将自动进入监狱并不能再发表帖子，之前所发的帖子将被屏蔽。（默认：-9）'><img src="images/spacer.gif" border="0"></a><b>进监狱的声望值</b></td>
		<td>
		<input type="text" name="InPrisonReputation" value="<%=SiteConfig("InPrisonReputation")%>"> 
		</td>
	</tr>

	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>头衔设置</b></font></td></tr>

	<tr>
		<td><a class="helpicon" title='启用后，用户可以自定义头衔'><img src="images/spacer.gif" border="0"></a><b>允许用户自定义头衔</b></td>
		<td>
		<input type="radio" name="CustomUserTitle" value=1 <%if SiteConfig("CustomUserTitle")=1 then%>checked<%end if%>>是 
		<input type="radio" name="CustomUserTitle" value=0 <%if SiteConfig("CustomUserTitle")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='允许用户自定义头衔的最大长度。'><img src="images/spacer.gif" border="0"></a><b>用户自定义头衔的最大长度</b></td>
		<td>
		<input type="text" name="UserTitleMaxChars" value="<%=SiteConfig("UserTitleMaxChars")%>"> 
		</td>
	</tr>

	<tr>
		<td><a class="helpicon" title='自定义头衔中要屏蔽的词语'><img src="images/spacer.gif" border="0"></a><b>自定义头衔中要屏蔽的词语</b></td>
		<td>
		<input type="text" name="UserTitleCensorWords" value="<%=SiteConfig("UserTitleCensorWords")%>" size="60"> 
		</td>
	</tr>

</table>
<table id="Pannel7" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">

	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>基本发帖设置</b></font></td></tr>


	<tr>
	  <td width=30%><a class="helpicon" title='将为所有公开论坛生成 RSS 订阅源。'><img src="images/spacer.gif" border="0"></a><b>启用公开论坛的 RSS 订阅源</b></td>
	  <td><input type="radio" name="EnableForumsRSS" value=1 <%if SiteConfig("EnableForumsRSS")=1 then%>checked<%end if%> />是 <input type="radio" name="EnableForumsRSS" value=0 <%if SiteConfig("EnableForumsRSS")=0 then%>checked<%end if%> />否 </td>
	</tr>

	<tr>
	  <td><a class="helpicon" title='控制主题发起者是否可以将所发起的主题状态设置为已解决/未解决'><img src="images/spacer.gif" border="0"></a><b>启用主题状态跟踪</b></td>
	  <td><input type="radio" name="DisplayThreadStatus" value=1 <%if SiteConfig("DisplayThreadStatus")=1 then%>checked<%end if%> />是 <input type="radio" name="DisplayThreadStatus" value=0 <%if SiteConfig("DisplayThreadStatus")=0 then%>checked<%end if%> />否 </td>
	</tr>
	<tr>
	  <td><a class="helpicon" title='控制用户使用标签加到帖子中和使用标签浏览其它的帖子'><img src="images/spacer.gif" border="0"></a><b>允许帖子含有标签</b></td>
	  <td><input type="radio" name="DisplayPostTags" value=1 <%if SiteConfig("DisplayPostTags")=1 then%>checked<%end if%> />是 <input type="radio" name="DisplayPostTags" value=0 <%if SiteConfig("DisplayPostTags")=0 then%>checked<%end if%> />否 </td>
	</tr>
	
	<tr>
		<td><a class="helpicon" title='默认查看帖子的模式'><img src="images/spacer.gif" border="0"></a><b>默认查看帖子的模式</b></td>
		<td>
		<input type="radio" name="ViewMode" value=0 <%if SiteConfig("ViewMode")=0 then%>checked<%end if%>>简洁 
		<input type="radio" name="ViewMode" value=1 <%if SiteConfig("ViewMode")=1 then%>checked<%end if%>>完整 
		</td>
	</tr>
	
	
	<tr>
		<td><a class="helpicon" title='每个RSS订阅源主题数'><img src="images/spacer.gif" border="0"></a><b>默认RSS源主题数</b></td>
		<td><input value="<%=SiteConfig("RSSDefaultThreadsPerFeed")%>" name="RSSDefaultThreadsPerFeed" size="20"></td>
	</tr>
	
	</tr>
	<tr>
		<td><a class="helpicon" title='每个网页上显示的主题数'><img src="images/spacer.gif" border="0"></a><b>主题/页码</b></td>
		<td><input value="<%=SiteConfig("ThreadsPerPage")%>" id="ThreadsPerPage" name="ThreadsPerPage" size="20"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='每个网页上所显示的帖子数'><img src="images/spacer.gif" border="0"></a><b>帖子/页码</b></td>
		<td><input value="<%=SiteConfig("PostsPerPage")%>" name="PostsPerPage" size="20"></td>
	</tr>
	
	<tr>
		<td><a class="helpicon" title='投票选项最少不得低于该数值'><img src="images/spacer.gif" border="0"></a><b>投票选项最少</b></td>
		<td>
		<input size="20" name="MinVoteOptions" value="<%=SiteConfig("MinVoteOptions")%>"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='投票选项最大不得高于该数值'><img src="images/spacer.gif" border="0"></a><b>投票选项最大</b></td>
		<td><input size="20" name="MaxVoteOptions" value="<%=SiteConfig("MaxVoteOptions")%>"></td>


	</tr>
	

		
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>编辑帖子</b></font></td></tr>
	
	<tr>
		<td><a class="helpicon" title='启用后，在消息的底部(位于用户签名前)将会显示出帖子的编辑记录 。'><img src="images/spacer.gif" border="0"></a><b>记录帖子编辑消息</b></td>
		<td>
		<input type="radio" name="DisplayEditNotes" value=1 <%if SiteConfig("DisplayEditNotes")=1 then%>checked<%end if%>>是 
		<input type="radio" name="DisplayEditNotes" value=0 <%if SiteConfig("DisplayEditNotes")=0 then%>checked<%end if%>>否</td>
	</tr>	
	<tr>
		<td><a class="helpicon" title='如启用该功能，在经过指定时间内允许编辑帖子(设置为 0 时无限制)'><img src="images/spacer.gif" border="0"></a><b>发帖后多长时间内能编辑帖子（分钟）</b></td>
		<td><input size="20" value="<%=SiteConfig("PostEditBodyAgeInMinutes")%>" name="PostEditBodyAgeInMinutes"></td>
	</tr>	
	
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>水帖控制</b></font></td></tr>
	<tr>
		<td><a class="helpicon" title='允许同一个用户重复发内容相同的帖子。'><img src="images/spacer.gif" border="0"></a><b>允许重复帖子</b></td>
		<td>
		<input type="radio" name="AllowDuplicatePosts" value=1 <%if SiteConfig("AllowDuplicatePosts")=1 then%>checked<%end if%>>是 
		<input type="radio" name="AllowDuplicatePosts" value=0 <%if SiteConfig("AllowDuplicatePosts")=0 then%>checked<%end if%>>否</td>
	</tr>	
	<tr>
		<td><a class="helpicon" title='两次发帖时间至少间隔'><img src="images/spacer.gif" border="0"></a><b>每次发帖间隔（秒）</b></td>
		<td><input size="20" name="PostInterval" value="<%=SiteConfig("PostInterval")%>"></td>
	</tr>	
	<tr>
		<td><a class="helpicon" title='允许刚注册用户在此时间后能发表帖子'><img src="images/spacer.gif" border="0"></a><b>注册后多长时间才能发表帖子（分钟）</b></td>
		<td><input size="20" value="<%=SiteConfig("RegUserTimePost")%>" name="RegUserTimePost"></td>
	</tr>
	
	<tr><td colspan="2"><font size=4 color="#C0C0C0"><b>热门帖标准</b></font></td></tr>
	
	<tr>
		<td><a class="helpicon" title='一个主题需要多少篇回帖才能变成热门?'><img src="images/spacer.gif" border="0"></a><b>热门帖子的回复数</b></td>
		<td><input size="20" value="<%=SiteConfig("PopularPostThresholdPosts")%>" name="PopularPostThresholdPosts"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='一个主题需要多少次浏览才能变成热门?'><img src="images/spacer.gif" border="0"></a><b>热门帖子的浏览数</b></td>
		<td><input size="20" value="<%=SiteConfig("PopularPostThresholdViews")%>" name="PopularPostThresholdViews"></td>
	</tr>	
	<tr>
		<td><a class="helpicon" title='普通主题成为热门主题必须保持活跃状态的天数'><img src="images/spacer.gif" border="0"></a><b>热帖时限 (天)</b></td>
		<td><input size="20" value="<%=SiteConfig("PopularPostThresholdDays")%>" name="PopularPostThresholdDays"></td>
	</tr>	
</table>

<table id="Pannel8" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="30%"><a class="helpicon" title='在用户注册时启用验证码功能。'><img src="images/spacer.gif" border="0"></a><b>启用注册验证</b></td>
		<td>
		<input type="radio" name="EnableAntiSpamTextGenerateForRegister" value=1 <%if SiteConfig("EnableAntiSpamTextGenerateForRegister")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableAntiSpamTextGenerateForRegister" value=0 <%if SiteConfig("EnableAntiSpamTextGenerateForRegister")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='在用户登录时启用验证码功能。'><img src="images/spacer.gif" border="0"></a><b>启用登录验证</b></td>
		<td>
		<input type="radio" name="EnableAntiSpamTextGenerateForLogin" value=1 <%if SiteConfig("EnableAntiSpamTextGenerateForLogin")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableAntiSpamTextGenerateForLogin" value=0 <%if SiteConfig("EnableAntiSpamTextGenerateForLogin")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
	<tr>
		<td><a class="helpicon" title='在用户发帖时启用验证码功能。'><img src="images/spacer.gif" border="0"></a><b>启用发帖验证</b></td>
		<td>
		<input type="radio" name="EnableAntiSpamTextGenerateForPost" value=1 <%if SiteConfig("EnableAntiSpamTextGenerateForPost")=1 then%>checked<%end if%>>是 
		<input type="radio" name="EnableAntiSpamTextGenerateForPost" value=0 <%if SiteConfig("EnableAntiSpamTextGenerateForPost")=0 then%>checked<%end if%>>否 
		</td>
	</tr>
</table>

<table id="Pannel3" style="display:none" cellspacing=0 cellpadding=0 width=100% class="PannelBody">
	<tr>
		<td width="30%"><a class="helpicon" title='用户每发表一个主题帖所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>发主题帖</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralAddThread")%>" name="IntegralAddThread"></td>
	</tr>
	<tr>
	  <td><a class="helpicon" title='用户每回复一个帖子所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>回帖</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralAddPost")%>" name="IntegralAddPost"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='版主将某帖子加为精华后，帖子的作者所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>加精华</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralAddValuedPost")%>" name="IntegralAddValuedPost"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='版主删除某主题帖后，帖子的作者所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>主题帖被删除</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralDeleteThread")%>" name="IntegralDeleteThread"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='版主删除某回帖后，帖子的作者所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>回帖被删除</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralDeletePost")%>" name="IntegralDeletePost"></td>
	</tr>
	<tr>
		<td><a class="helpicon" title='版主取消某精华后，帖子的作者所得金钱和经验'><img src="images/spacer.gif" border="0"></a><b>精华被取消</b></td>
		<td><input size="20" value="<%=SiteConfig("IntegralDeleteValuedPost")%>" name="IntegralDeleteValuedPost"></td>
	</tr>
</table>
<br />
<table border="0"  width="100%" align="center">
	<tr>
		<td align="right" height="20"><input type="button" onclick="SiteSettingsInit()" value=" 还原默认值 ">　<input type="submit" value=" 保 存 ">　<input type="reset" value=" 重 置 "></td>
	</tr>
</table>
</form>
<script language="JavaScript">
var FormObject = document.form;

function SiteSettingsInit() {

	FormObject.elements["UserOnlineTime"].value = 20;
	FormObject.elements["Timeout"].value = 60;
	FormObject.elements["DefaultSiteStyle"].value = "default";
	FormObject.elements["CacheName"].value = "BBSXP";
	FormObject.elements["CacheUpDateInterval"].value = 5;
	FormObject.elements["SiteDisabled"][1].checked = true;

	FormObject.elements["DisplayWhoIsOnline"][0].checked = true;
	FormObject.elements["DisplayStatistics"][0].checked = true;
	FormObject.elements["DisplayBirthdays"][0].checked = true;
	FormObject.elements["DisplayLink"][0].checked = true;
	FormObject.elements["IsShowSonForum"][0].checked = true;

	FormObject.elements["AllowLogin"][0].checked = true;
	FormObject.elements["EnableBannedUsersToLogin"][1].checked = true;
	FormObject.elements["AllowNewUserRegistration"][0].checked = true;
	FormObject.elements["NewUserModerationLevel"].options[1].selected = true;
	FormObject.elements["UserNameMinLength"].value = 3;
	FormObject.elements["UserNameMaxLength"].value = 15;
	FormObject.elements["AccountActivation"][0].checked = true;
	FormObject.elements["EnableSignatures"][0].checked = true;
	FormObject.elements["SignatureMaxLength"].value = 256;
	FormObject.elements["MaxPrivateMessageSize"].value = 100;
	FormObject.elements["AllowSignatures"][0].checked = true;
	FormObject.elements["AllowGender"][0].checked = true;
	FormObject.elements["AllowAvatars"][0].checked = true;
	FormObject.elements["AllowUserToSelectTheme"][0].checked = true;
	FormObject.elements["RequireAuthenticationForProfileViewing"][1].checked = true;
	FormObject.elements["PublicMemberList"][0].checked = true;
	FormObject.elements["MemberListAdvancedSearch"][0].checked = true;
	FormObject.elements["MemberListPageSize"].value = 20;
	FormObject.elements["EnableAvatars"][0].checked = true;
	FormObject.elements["EnableRemoteAvatars"][0].checked = true;
	FormObject.elements["AvatarHeight"].value = 150;
	FormObject.elements["AvatarWidth"].value = 150;

	FormObject.elements["EnableForumsRSS"][0].checked = true;
	FormObject.elements["DisplayThreadStatus"][0].checked = true;
	FormObject.elements["DisplayPostTags"][0].checked = true;
	FormObject.elements["ViewMode"][1].checked = true;
	FormObject.elements["RSSDefaultThreadsPerFeed"].value = 20;
	FormObject.elements["ThreadsPerPage"].value = 20;
	FormObject.elements["PostsPerPage"].value = 15;
	FormObject.elements["MinVoteOptions"].value = 2;
	FormObject.elements["MaxVoteOptions"].value = 20;
	FormObject.elements["DisplayEditNotes"][0].checked = true;
	FormObject.elements["PostEditBodyAgeInMinutes"].value = 0;
	FormObject.elements["AllowDuplicatePosts"][1].checked = true;
	FormObject.elements["PostInterval"].value = 10;
	FormObject.elements["RegUserTimePost"].value = 0;
	FormObject.elements["PopularPostThresholdPosts"].value = 15;
	FormObject.elements["PopularPostThresholdViews"].value = 200;
	FormObject.elements["PopularPostThresholdDays"].value = 3;

	FormObject.elements["UpFileTypes"].value = "gif|jpg|png|bmp|swf|txt|mid|doc|xls|zip|rar";;
	FormObject.elements["MaxPostAttachmentsSize"].value = 10240;
	FormObject.elements["MaxFileSize"].value = 1024;
	FormObject.elements["MaxFaceSize"].value = 30;
	
	
	FormObject.elements["WatermarkFontSize"].value = 25;
	FormObject.elements["WatermarkFontColor"].value = "#000000";
	document.getElementById("WatermarkFontColor").style.backgroundColor = "#000000";
	FormObject.elements["WatermarkFontIsBold"][0].checked = true;


	FormObject.elements["BannedHtmlLabel"].value = "link|script|object|iframe|form|style|div|caption|!--|meta";
	FormObject.elements["BannedHtmlEvent"].value = "javascript:|onerror|onload|onmouseover";
	FormObject.elements["BannedText"].value = "fuck|shit";
	FormObject.elements["BannedRegUserName"].value = "fuck|shit";

	FormObject.elements["EnableAntiSpamTextGenerateForRegister"][0].checked = true;
	FormObject.elements["EnableAntiSpamTextGenerateForLogin"][1].checked = true;
	FormObject.elements["EnableAntiSpamTextGenerateForPost"][1].checked = true;

	FormObject.elements["IntegralAddThread"].value = "+2";
	FormObject.elements["IntegralAddPost"].value = "+1";
	FormObject.elements["IntegralAddValuedPost"].value = "+3";
	FormObject.elements["IntegralDeleteThread"].value = "-2";
	FormObject.elements["IntegralDeletePost"].value = "-1";
	FormObject.elements["IntegralDeleteValuedPost"].value = "-3";
}

function IsObjInstalled (OjbSpanID,OjbStr) {
	OjbStr == "" ? document.getElementById(OjbSpanID).innerHTML = "" : Ajax_CallBack(false,OjbSpanID,'Loading.asp?menu=IsObjInstalled&Object='+OjbStr);
}
</script>
<%
End Sub

Sub SiteInfo

	If IsObjInstalled("Scripting.FileSystemObject") Then
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		if not fso.folderexists(Server.MapPath("Themes/"&Request("DefaultSiteStyle")&"")) then Alert("默认风格设置错误，Themes/"&Request("DefaultSiteStyle")&" 目录不存在！")
		Set fso = nothing
	end if

	if Request("UpFileOption")<>"" then
		if Not IsObjInstalled(Request("UpFileOption")) then Alert("本服务器不支持 "&Request("UpFileOption")&" 组件！请关闭此功能！")
	end if
	
	if Request("SelectMailMode")<>"" then
		if Not IsObjInstalled(Request("SelectMailMode")) then Alert("本服务器不支持 "&Request("SelectMailMode")&" 组件！请关闭此功能！")
		if Request("SmtpServerMail")="" then Alert("请填写发件人的Email地址！")
	end if
	
	if Request("WatermarkOption")<>"" then
		if Not IsObjInstalled(Request("WatermarkOption")) then Alert("本服务器不支持 "&Request("WatermarkOption")&" 组件！请关闭此功能！")
	end if

	if Request("AccountActivation")="1" and Request("SelectMailMode")="" then Alert("您选择了注册用户密码通过Email发送，但是您没有设定发送邮件组件！")
	
	filtrate=split(Request("BannedIP"),"|")
	for i = 0 to ubound(filtrate)
		if instr("|"&REMOTE_ADDR&"","|"&filtrate(i)&"") > 0 then Alert("请检查您输入的IP地址是否正确")
	next

	
	FielsStr="UserOnlineTime|Timeout|UserNameMinLength|UserNameMaxLength|ThreadsPerPage|PostsPerPage|RSSDefaultThreadsPerFeed|PostInterval|PostEditBodyAgeInMinutes|RegUserTimePost|PopularPostThresholdPosts|PopularPostThresholdViews|MinVoteOptions|MaxVoteOptions|MaxPostAttachmentsSize|MaxFileSize|MaxFaceSize|AvatarHeight|AvatarWidth|SignatureMaxLength|MemberListPageSize|PopularPostThresholdDays"
	FielsStrArray=split(FielsStr,"|")
	for i=0 to ubound(FielsStrArray)
		if IsNumeric(Request.Form(""&FielsStrArray(i)&""))=false then Alert(FielsStrArray(i)&"输入框内的值，必须是数字类型！")
	next
	
	Rs.Open "[BBSXP_SiteSettings]",Conn,1,3
	
	XMLDOM.loadxml("<bbsxp>"&Rs("SiteSettingsXML")&"</bbsxp>")
		SiteSettingsXMLStrings=""
		Set objNodes = XMLDOM.documentElement.ChildNodes
		Set objRoot = XMLDOM.documentElement
		for each ho in Request.Form
			objRoot.SelectSingleNode(ho).text = ""&server.HTMLEncode(Request(""&ho&""))&""
		next
		for each element in objNodes	
			SiteSettingsXMLStrings=SiteSettingsXMLStrings&"<"&element.nodename&">"&element.text&"</"&element.nodename&">"&vbCrlf
		next
	Set XMLDOM=nothing
	Rs("SiteSettingsXML")=SiteSettingsXMLStrings
	Rs.update
	Rs.close
	Response.Write("更新成功")
End Sub

Sub SiteSettingsUp
	Rs.Open "[BBSXP_SiteSettings]",Conn,1,3
		for each ho in Request.Form
			Rs(ho)=Request(ho)
		next
	Rs.update
	Rs.close
	Response.Write("更新成功")
End Sub

Sub Showbanner
%>
<form method="POST" action="?menu=SiteSettingsUp">
	<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
		<tr id=CommonListTitle>
			<td align=center colspan="2"><b>HTML代码设置</b></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center" width="20%">页面顶部信息<br><font color="#FF0000">放于&lt;Body&gt;内</font></td>
			<td><textarea name="GenericHeader" rows="6" style="width:100%"><%=GenericHeader%></textarea></td>
		</tr>
		<tr id=CommonListCell>
			<td align="center" width="20%">Banner (468 x 60)<br><font color="#FF0000">顶部右侧位置</font> </td>
			<td><textarea name="GenericTop" rows="6" style="width:100%"><%=GenericTop%></textarea></td>
		</tr>

		<tr id=CommonListCell>
			<td align="center" width="20%">版权信息<br><font color="#FF0000">放于页末位置</font> </td>
			<td><textarea name="GenericBottom" rows="6" style="width:100%"><%=GenericBottom%></textarea></td>
		</tr>
	</table>
	<input type="submit" value=" 保 存 ">		<input type="reset" value=" 重 置 ">
</form>
<%
End Sub

Sub UserAgreement
%>
<form method="POST" action="?menu=SiteSettingsUp">
<table cellspacing="1" cellpadding="5" width="100%" border="0" id=CommonListArea>
	<tr id=CommonListTitle>
		<td align=center><b>注册用户协议设置</b></td>
	</tr>
	<tr id=CommonListCell>
		<td align=center><textarea name="CreateUserAgreement" rows="18" style="width:100%"><%=CreateUserAgreement%></textarea></td>
	</tr>
</table>
<input type="submit" value=" 保 存 ">		<input type="reset" value=" 重 置 ">
</form>
<%
End Sub

AdminFooter
%>