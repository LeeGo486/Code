<!--#include file="../f22/inc/function.asp"-->
<!--#include FILE="../f22/extend/upload_inc.asp"-->
<%     
  response.buffer=true     
  formsize=request.totalbytes     
  formdata=request.binaryread(formsize)     
  bncrlf=chrB(13)   &   chrB(10)     
  divider=leftB(formdata,clng(instrb(formdata,bncrlf))-1)     
  datastart=instrb(formdata,bncrlf   &   bncrlf)+4     
  dataend=instrb(datastart+1,formdata,divider)-datastart     
  mydata=midb(formdata,datastart,dataend)     
  

  if formsize<300 then
	response.write "<script>alert('错误:请选择图片!');</script>"
	response.end
  end if
  
  if  formsize>650*1024 then
	response.write "<script>alert('错误:上传的图片大小不能超过500k,图片比例100x135最佳!');location.replace('vip_imgupload.asp');</script>"
	
	response.end
  end if

 
  set   connGraph=server.CreateObject("ADODB.connection")  
  connGraph.ConnectionString= cn  
  connGraph.Open     
 
  set   rec=server.createobject("ADODB.recordset") 
  if Left(session("viptmpid"),3)="tmp" then  
       
    rec.Open   "SELECT   *   FROM   [vip_images]   where   vipid   is   null",connGraph,1,3
	if rec.eof and rec.bof then     
      rec.addnew 
	end if
    rec("vipid")=session("viptmpid")    
    rec("img").appendchunk   mydata     
  else
    rec.Open   "SELECT  userpicture   FROM   [vip_user]   where   vipid='"&session("viptmpid")&"'",connGraph,1,3     
    rec("userpicture").appendchunk   mydata     
  end if 
  rec.update 
  rec.close  
  set   rec=nothing 
  set   connGraph=nothing
    
  %>     
  <script >
  parent.form1.vippic.src="vip_showimg.asp?vipid=<%=session("viptmpid")%>";
//parent.formadd.ImageUrl.value='/upload/<%=ufp%>'
 location.replace('vip_imgupload.asp')
</script>