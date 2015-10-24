<!-- #include file="setup.asp" -->
<%
if ReturnUrl="" then ReturnUrl=""&SiteConfig("SiteUrl")&"/Default.asp"

select case Request("menu")

	case "Themes"
		if SiteConfig("AllowUserToSelectTheme")=0 then error("系统已禁止用户选择个性风格。")
		Style=HTMLEncode(Request("Style"))
		
	If IsObjInstalled("Scripting.FileSystemObject") Then
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		if not fso.folderexists(Server.MapPath("Themes/"&Style&"")) then Alert("Themes/"&Style&" 目录不存在！")
		Set fso = nothing
	end if
		
		ResponseCookies "Themes",Style,"9999"

	case "Invisible"
		ResponseCookies "Invisible","1","9999"

	case "Online"
		ResponseCookies "Invisible","0","9999"


end select

	response.redirect ReturnUrl

%>