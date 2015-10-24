<%function HTMLEncode(fString)
	fString=Trim(fString)
	fString=replace(fString,"<script","&lt;script")
	fString=replace(fString,"script>","script&gt;")
	fString=replace(fString,"<iFrame","&lt;iFrame")
	fString=replace(fString,"iFrame>","iFrame&gt;")
	fString=Replace(fString,CHR(9),"&#9;")
	fString=Replace(fString,CHR(39),"&#39;")	'¡°'¡±
	HTMLEncode=fString
end function

Function RequestInt(fString)

	RequestInt=Request(fString)

	if IsNumeric(RequestInt) then
		RequestInt=int(RequestInt)
	else
		RequestInt=0
	end if

End Function

formid=RequestInt("formid")
select case formid
case 20671
	response.Redirect("2067_movenotice_seach.asp")
case 20701
    response.Redirect("2070_movenotice_seach.asp") 	
case else
   session("formid")=formid
   response.Redirect("search_frame.asp?action=search&seachid="&request.QueryString("a"))	
end select
%>
