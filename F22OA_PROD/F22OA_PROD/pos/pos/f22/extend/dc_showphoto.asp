<!--#include file="inc/function.asp"-->
<%dim ds,id,action
response.Expires = 0 
response.Buffer = True 
response.Clear 
cn=session("cn")
id=trim(request.QueryString("id"))
action=trim(request.QueryString("action"))
'action="style"
'id="GJ-BC-0101"
'session("cnp")="Driver={SQL Server};Server="&conn_server&";Uid="&conn_name&";Pwd="&conn_pass&";dataBase=f117picture"


	  sql="select st_picture from j_style where styleid='"&id&"'"
	  set ds=server.CreateObject("ADODB.Recordset")
	  ds.open sql,cn
	  if ds.bof or ds.eof then
	 
	    ' filemap=Server.MapPath("img/nophoto.gif")
		' set stream = Server.CreateObject("ADODB.Stream")
		' stream.Type=1
		'  stream.Open
		 '''''
		'Set fso = Server.CreateObject("Scripting.FileSystemObject")
		' if not fso.FileExists(filemap) then
		 'Response.Write("<h1>Error:</h1>" & strFilename & " does not exist<p>")
		' Response.End
		 'end if
		 ' get length of file
		' Set f = fso.GetFile(filemap)
		' intFilelength = f.size
		
		 'stream.LoadFromFile(filemap)
		' if err then
		' Response.Write("<h1>Error: </h1>" & err.Description & "<p>")
		'Response.End
		' end if
		'output the file to the browser
		
		'   response.contenttype="image/*"
       'Response.BinaryWrite stream.Read
		' Response.Flush
		
		
		 ' tidy up
		' stream.Close
		 'Set stream = Nothing

	  else
	   response.contenttype="image/*"
       Response.BinaryWrite ds(0)
	  end if
	  ds.close
	  set ds=nothing
	%>