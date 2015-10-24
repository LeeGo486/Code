<%if err.number <>0 then
    response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
end if
on error resume next
ds.close
set ds=nothing
cn.close
set cn=nothing%>